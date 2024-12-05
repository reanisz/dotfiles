#pragma region includes
#include <atcoder/all>

#include <iostream>

#include <vector>
#include <set>
#include <unordered_set>
#include <map>
#include <unordered_map>
#include <type_traits>
#include <experimental/type_traits>

#include <string>
#include <optional>
#include <bitset>

#include <cmath>
#include <random>
#include <limits>

#ifdef DEBUG
#include <fstream>
#endif

// boost
#include <boost/multiprecision/cpp_int.hpp>

#pragma endregion
#pragma region types
// ====== Types =======
using namespace std;

using uint = unsigned int;
using ll = long long;
using ull = unsigned long long;

const int INF = (1 << 30);
const ll INFLL = (1ll << 62);

constexpr ll expo_10[] = {
    1,
    10,
    100,
    1000,
    10000,
    100000,
    1000000,
    10000000,
    100000000,
    1000000000,
    10000000000,
    100000000000,
    1000000000000,
    10000000000000,
    100000000000000,
    1000000000000000,
    10000000000000000,
    100000000000000000,
    1000000000000000000,
};

using bint = boost::multiprecision::cpp_int;

template<class T>
vector<vector<T>> make_grid(std::size_t w, std::size_t h, T default_value=T{})
{
    return vector<vector<T>>(w, vector<T>(h, default_value));
}
#pragma endregion
#pragma region utils

// ====== utils ======
#define REP(variable, count) for(int variable = 0; variable < count; variable++)
#define REPR(variable, min_value, max_value) for(int variable = min_value; variable < max_value; variable++)

template<class T, class... TArgs>
T& update_max(T& variable, TArgs... values)
{
    variable = std::max<T>(variable, values...);
    return variable;
}
template<class T, class... TArgs>
T& update_min(T& variable, TArgs... values)
{
    variable = std::min<T>(variable, values...);
    return variable;
}
#pragma endregion
#pragma region algorithm
// ====== algorithm ======
// [min, max)中をfuncで二部探索
template<class TKey>
auto binsearch(TKey ok, TKey ng, std::function<bool(TKey)> func)
{
    while(1 < abs(ok - ng))
    {
        auto mid = (ok + ng) / 2;
        if(func(mid))
        {
            ok = mid;
        }
        else
        {
            ng = mid;
        }
    }
    return ok;
}

namespace type_traits {
    template<class T, class TElem>
    using find_func = decltype(std::declval<T>().find(std::declval<TElem>()));

    template<class T, class TElem>
    using has_find = std::experimental::is_detected<find_func, T, TElem>;
}

namespace range 
{
    template<class T>
    void sort(T& vec)
    {
        std::sort(vec.begin(), vec.end());
    }
    template<class T, class TFunc>
    void sort(T& vec, TFunc&& func)
    {
        std::sort(vec.begin(), vec.end(), std::forward<T>(func));
    }

    template<class T>
    void reverse(T& vec)
    {
        std::reverse(vec.begin(), vec.end());
    }

    template<class TVec, class TElem>
    void lower_bound(TVec& vec, const TElem& value)
    {
        return std::lower_bound(vec.begin(), vec.end(), value);
    }
 
    template<class T, class TFunc>
    typename std::vector<T>::iterator lower_bound_if(std::vector<T>& vec, TFunc&& func)
    {
        int size = vec.size();
        auto res = binsearch<int>(size, -1, [&](int idx) -> bool {
            if(idx == size)
                return true;
 
            auto& v = vec[idx];
            return std::forward<TFunc>(func)(v);
        });
 
        return vec.begin() + res;
    }

    template<class T, class TElem>
    bool contains(const T& container, const TElem& elem)
    {
        if constexpr (type_traits::has_find<T, TElem>::value)
        {
            return container.find(elem) != container.end();
        }
        else {
            return std::find(container.begin(), container.end(), elem) != container.end();
        }
    }
}
#pragma endregion
#pragma region io
// ====== I/O =======
template<class T>
class input_vector 
{
public:
    input_vector(std::vector<T>& out, int cnt)
        : _out(out)
        , _cnt(cnt)
    {
    }

    template<class CharT, class Traits>
    basic_istream<CharT, Traits>& read(basic_istream<CharT, Traits>& is) const
    {
        auto size = _out.size();
        size += _cnt;
        _out.reserve(size);
        for(int i=0;i<_cnt;i++)
        {
            T tmp;
            is >> tmp;
            _out.emplace_back(tmp);
        }
        return is;
    }
    
private:
    std::vector<T>& _out;
    int _cnt;
};

template<class CharT, class Traits, class T>
basic_istream<CharT, Traits>& operator>>(basic_istream<CharT, Traits>& is, const input_vector<T>& vec)
{
    return vec.read(is);
}

template<class T>
class output_vector 
{
public:
    output_vector(const std::vector<T>& in, char delimiter = ' ')
        : _in(in)
        , _delimiter(delimiter)
    {
    }

    template<class CharT, class Traits>
    basic_ostream<CharT, Traits>& write(basic_ostream<CharT, Traits>& os) const
    {
        std::size_t i = 0;
        for(auto& v : _in)
        {
            if(i != 0)
                os << _delimiter;
            os << v;
            i++;
        }
        return os;
    }
    
private:
    const std::vector<T>& _in;
    char _delimiter;
};

template<class CharT, class Traits, class T>
basic_ostream<CharT, Traits>& operator<<(basic_ostream<CharT, Traits>& os, const output_vector<T>& vec)
{
    return vec.write(os);
}

template<class T>
class input_grid 
{
public:
    input_grid(std::vector<std::vector<T>>& out, int width, int height, bool swap=false)
        : _out(out)
        , _width(width)
        , _height(height)
        , _swap(swap)
    {
    }

    template<class CharT, class Traits>
    basic_istream<CharT, Traits>& read(basic_istream<CharT, Traits>& is) const
    {
        _out = make_grid<T>(_width, _height);
        if(!_swap)
        {
            for(int x=0;x<_height;x++)
            for(int y=0;y<_width;y++)
            {
                T v;
                cin >> v;
                _out[x][y] = v;
            }
        }else
        {
            for(int y=0;y<_width;y++)
            for(int x=0;x<_height;x++)
            {
                T v;
                cin >> v;
                _out[x][y] = v;
            }
        }
        return is;
    }
    
private:
    std::vector<std::vector<T>>& _out;
    int _width, _height;
    bool _swap;
};

template<class CharT, class Traits, class T>
basic_istream<CharT, Traits>& operator>>(basic_istream<CharT, Traits>& is, const input_grid<T>& grid)
{
    return grid.read(is);
}

template<class T>
class output_grid 
{
public:
    output_grid(const std::vector<std::vector<T>>& in, char delimiter = ' ', bool swap=false)
        : _in(in)
        , _delimiter(delimiter)
        , _swap(swap)
    {
    }

    template<class CharT, class Traits>
    basic_ostream<CharT, Traits>& write(basic_ostream<CharT, Traits>& os) const
    {
        if(!_swap)
        {
            for(auto& row : _in)
            {
                std::size_t i = 0;
                for(auto& v : row)
                {
                    if(i != 0)
                        os << _delimiter;
                    os << v;
                    i++;
                }
                os << endl;
            }
        }
        else
        {
            std::size_t width = 0;
            std::size_t height = _in.size();
            for(auto& row : _in)
            {
                update_max(width, row.size());
            }

            for(std::size_t y=0;y<width;y++)
            {
                std::size_t i = 0;
                for(int x=0;x<height;x++)
                {
                    if(i != 0)
                        os << _delimiter;

                    if(y < _in[x].size())
                    {
                        os << _in[x][y];
                    }
                    i++;
                }
                os << endl;
            }
        }
        return os;
    }
    
private:
    const std::vector<std::vector<T>>& _in;
    char _delimiter;
    bool _swap;
};

template<class CharT, class Traits, class T>
basic_ostream<CharT, Traits>& operator<<(basic_ostream<CharT, Traits>& os, const output_grid<T>& vec)
{
    return vec.write(os);
}

template<class CharT, class Traits, class TFirst, class TSecond>
basic_ostream<CharT, Traits>& operator<<(basic_ostream<CharT, Traits>& os, const std::pair<TFirst, TSecond>& p)
{
    os << "(" << p.first << ", " << p.second << ")";
    return os;
}
#pragma endregion
// ==== DEBUG ====
#pragma region debug
#ifdef DEBUG
  #define FMT_HEADER_ONLY
  #include <fmt/core.h>

  #define TRACE(...) cerr << fmt::format(__VA_ARGS__)

  namespace fmt {
      template<class T, class CharT, class... TArgs>
      struct formatter<std::vector<T, TArgs...>, CharT>
        : formatter<string, CharT>
      {
          template<class FormatContext>
          auto format(const std::vector<T, TArgs...>& t, FormatContext& fc) {
              std::stringstream ss;
              ss << output_vector{t};
              return fmt::formatter<string, CharT>::format(ss.str(), fc);
          }
      };

      template<class T, class CharT>
      struct formatter<output_vector<T>, CharT>
        : formatter<string, CharT>
      {
          template<class FormatContext>
          auto format(const output_vector<T>& t, FormatContext& fc) {
              std::stringstream ss;
              ss << t;
              return fmt::formatter<string, CharT>::format(ss.str(), fc);
          }
      };

      template<class T, class CharT>
      struct formatter<output_grid<T>, CharT>
        : formatter<string, CharT>
      {
          template<class FormatContext>
          auto format(const output_grid<T>& t, FormatContext& fc) {
              std::stringstream ss;
              ss << t;
              return fmt::formatter<string, CharT>::format(ss.str(), fc);
          }
      };
  }
#else
  #define TRACE(...)
#endif
#pragma endregion
#pragma region graph
// ====== graph =======
// namespace graphs
// {
using node_id = int;
using edge_id = int;

#ifdef DEBUG
struct graphviz_element
{
    struct shapes {
        static constexpr const char* box = "box";
        static constexpr const char* polygon = "polygon";
        static constexpr const char* circle = "circle";
        static constexpr const char* triangle = "triangle";
        static constexpr const char* doublecircle = "doublecircle";
    };

    graphviz_element()
    {
    }
    graphviz_element(const std::string& label)
        : _label(label)
    {
    }

    graphviz_element& set_disable()
    {
        _disabled = true;
        return *this;
    }

    bool _disabled = false;

#define DEFINE_MEMBER(name) \
    optional<std::string> _ ## name; \
    graphviz_element& set_ ## name(const std::string& name) \
    { \
        _ ## name = name; \
        return *this; \
    } \

    DEFINE_MEMBER(id)
    DEFINE_MEMBER(label)
    DEFINE_MEMBER(shape)
    DEFINE_MEMBER(fontSize)
    DEFINE_MEMBER(fontColor)
    DEFINE_MEMBER(color)
    DEFINE_MEMBER(fillcolor)
    DEFINE_MEMBER(style)
    DEFINE_MEMBER(dir)

#undef DEFINE_MEMBER
#define GENERATE_MEMBER(name) \
    if(_ ## name) { if(i++) res += ", "; res += fmt::format("{} = \"{}\"", #name, *_ ## name); }

    std::string generate() const {
        int i = 0;
        std::string res = "";
        res += fmt::format("{} ", *_id);
        res += "[";
        GENERATE_MEMBER(label)
        GENERATE_MEMBER(shape)
        GENERATE_MEMBER(fontSize)
        GENERATE_MEMBER(fontColor)
        GENERATE_MEMBER(color)
        GENERATE_MEMBER(fillcolor)
        GENERATE_MEMBER(style)
        GENERATE_MEMBER(dir)
        res += "]";
        return res;
    }
};
#endif

template<bool is_bidirectional = false, class TNodeData = char, class TEdgeData = char>
class adjacency_list_graph
{
public:
    using node_data = TNodeData;
    using edge_data = TEdgeData;

    struct edge
    {
        edge_id _idx;

        node_id _from;
        node_id _to;
        TEdgeData _data;

        edge() {}
        edge(node_id from, node_id to) : _from(from), _to(to) {}
        edge(node_id from, node_id to, TEdgeData data) : _from(from), _to(to), _data(data) {}

        edge reverse() const
        {
            return {_to, _from, _data};
        }
    };

    adjacency_list_graph()
    {
    }

    adjacency_list_graph(node_id size)
    {
        init(size);
    }

    void init(node_id size)
    {
        _size = size;
        _nodes.resize(size);
        _edges.resize(size);

        _edge_size = 0;
    }

    void push_edge(edge e)
    {
        e._idx = _edge_size++;
        _edges[e._from].push_back(e);
        _edge_map.push_back({e._from, _edges[e._from].size() - 1});

        if(is_bidirectional)
        {
            std::swap(e._from, e._to);
            _edges[e._from].push_back(e);
            _edge_map_reversed.push_back({e._from, _edges[e._from].size() - 1});
        }
    }

    void set_node(node_id id, const TNodeData& data)
    {
        _nodes[id] = data;
    }

    TNodeData& get_node(node_id id)
    {
        return _nodes[id];
    }

    vector<edge>& get_edges(node_id id)
    {
        return _edges[id];
    }

    edge& get_edge(edge_id id, bool reverse_edge=false)
    {
        assert(!(!is_bidirectional && reverse_edge));

        auto pos = (!reverse_edge ? _edge_map : _edge_map_reversed)[id];
        return _edges[pos.first][pos.second];
    }

    template<class TFunc>
    void dfs(node_id root, TFunc&& func)
    {
        if constexpr (std::is_invocable_v<TFunc, node_id, node_id, TEdgeData*>) {
            func(root, root, nullptr);
        } else {
            func(root, root);
        }

        std::vector<bool> marked;
        marked.resize(_size);
        marked[root] = true;

        dfs_visit(marked, root, std::forward<TFunc>(func));
    }
private:
    template<class TFunc>
    void dfs_visit(std::vector<bool>& marked, node_id current, TFunc&& func)
    {
        for(auto& edge : _edges[current])
        {
            auto next = edge._to;
            if(!marked[next])
            {
                if constexpr (std::is_invocable_v<TFunc, node_id, node_id, TEdgeData*>) {
                  func(current, next, &edge._data);
                } else {
                  func(current, next);
                }

                marked[next] = true;
                dfs_visit(marked, next, std::forward<TFunc>(func));
            }
        }
    }
public:
    template<class TCost>
    struct dijkstra_result_node
    {
        TCost _cost;
        edge_id _back;

        operator bool() const {
            return _cost != std::numeric_limits<TCost>::max();
        }
    };

    template<class TCost>
    struct dijkstra_result
    {
        std::vector<dijkstra_result_node<TCost>> _nodes;

        void calculate_used_edges()
        {
            _used_edges = set<edge_id>{};
            for(auto& r : _nodes)
            {
                if(r && r._back != -1) {
                    _used_edges->insert(r._back);
                }
            }
        }

        template<class TGraph>
        std::vector<edge_id> get_route_to(TGraph& graph, node_id goal)
        {
            std::vector<edge_id> res;
            node_id next = goal;
            while(true)
            {
                auto edge = _nodes[next]._back;
                if(edge == -1)
                    break;

                res.push_back(edge);
                next = graph.get_edge(edge)._from;
            }

            range::reverse(res);

            return res;
        }

        node_id _root;
        optional<set<edge_id>> _used_edges;
    };

    static constexpr bool has_raw_cost = std::is_arithmetic_v<TEdgeData> && !std::is_same_v<TEdgeData, char>;
    auto dijkstra(node_id root)
    {
        if constexpr (has_raw_cost) {
            return dijkstra(root, TEdgeData{0}, [](const edge& e, TEdgeData prev){ return e._data + prev; });
        }
        else {
            return dijkstra(root, 0, [](const edge& e, TEdgeData prev){ return 1 + prev; });
        }
    }

    template<class TCost, class TFuncCost>
    dijkstra_result<TCost> dijkstra(node_id root, TCost init_cost, TFuncCost&& func_cost)
    {
        const auto inf = std::numeric_limits<TCost>::max();
        auto result = std::vector<dijkstra_result_node<TCost>>(_size, {inf, -1});

        using P = std::pair<TCost, int>;

        std::priority_queue<P, vector<P>, std::greater<P>> que;
        que.push(P{0, root});
        result[0] = {0, -1};

        while(!que.empty())
        {
            auto p = que.top(); que.pop();
            auto v = p.second;

            if(result[v]._cost < p.first) continue;
            auto e_size = _edges[v].size();
            REP(e_id, e_size)
            {
                auto& e = _edges[v][e_id];
                auto next_cost = func_cost(e, result[v]._cost);
                // TRACE("<{}> {} -> {} : {} +{} = {}\n", e._idx, e._from, e._to, result[v]._cost, next_cost - result[v]._cost, next_cost);

                if(result[e._to]._cost > next_cost)
                {
                    result[e._to]._cost = next_cost;
                    result[e._to]._back = e._idx;
                    que.push(P{next_cost, e._to});
                }
            }
        }
        dijkstra_result<TCost> res;
        res._nodes = std::move(result);
        res._root = root;
        return res;
    }

#ifdef DEBUG
public:
    void generate_graphviz(const std::string& graph_title)
    {
        auto func_node = [](node_id n){ return std::to_string(n); };

        std::function<string(const edge&)> func_edge;

        if constexpr (has_raw_cost) {
            func_edge = [](const edge& e){ return std::to_string(e._data); };
        } else {
            func_edge = [](const edge& e){ return ""; };
        }

        generate_graphviz(graph_title, func_node, func_edge);
    }


    template<class TFuncNode, class TFuncEdge>
    void generate_graphviz(const std::string& graph_title, TFuncNode&& func_node, TFuncEdge&& func_edge)
    {
        std::ofstream ofs(graph_title + ".dot");
        auto graph_type = is_bidirectional ? "graph" : "digraph";
        auto arrow = is_bidirectional ? "--" : "->";

        ofs << fmt::format("{} \"{}\" {{", graph_type, graph_title) << endl;
        {
            ofs << "  // nodes" << endl;
            REP(i, _size)
            {
                graphviz_element elem;
                if constexpr(std::is_same_v<graphviz_element, std::invoke_result_t<TFuncNode, node_id>>) 
                {
                    elem = func_node(i);
                }
                else if constexpr(std::is_convertible_v<std::invoke_result_t<TFuncNode, node_id>, std::string>)
                {
                    elem.set_label(func_node(i));
                }
                if(!elem._id)
                    elem.set_id(fmt::format("\"node_{}\"", i));

                if(elem._disabled)
                    continue;

                ofs << elem.generate() << endl;
            }

            std::unordered_set<edge_id> used_edge;

            ofs << "  // edges" << endl;
            REP(i, _size)
            {
                for(auto& e : _edges[i]){
                    if constexpr(is_bidirectional)
                    {
                        if(used_edge.find(e._idx) != used_edge.end())
                        {
                            continue;
                        }
                        used_edge.insert(e._idx);
                    }
                    graphviz_element elem;
                    if constexpr(std::is_same_v<graphviz_element, std::invoke_result_t<TFuncEdge, edge&>>) 
                    {
                        elem = func_edge(e);
                    }
                    else if constexpr(std::is_convertible_v<std::invoke_result_t<TFuncEdge, edge&>, std::string>)
                    {
                        elem.set_label(func_edge(e));
                    }
                    if(!elem._id)
                        elem.set_id(fmt::format("\"node_{}\" {} \"node_{}\"", e._from, arrow, e._to));

                    if(elem._disabled)
                        continue;

                    ofs << elem.generate() << endl;
                }
            }
        }
        ofs << "}" << endl;
    }
#endif

private:
    node_id _size;
    edge_id _edge_size;
    vector<TNodeData> _nodes;
    vector<vector<edge>> _edges;

    vector<std::pair<node_id, int>> _edge_map;
    vector<std::pair<node_id, int>> _edge_map_reversed;
};
#pragma endregion
#pragma region prime
// ====== prime =======
namespace prime
{
    template<class Int = int>
    class PrimeGenerator
    {
    public:
        PrimeGenerator(Int max)
            : _max(max)
        {
            std::vector<bool> buffer(_max, true);
            buffer[0] = false;
            buffer[1] = false;
            auto sqrt_max = std::ceil(std::sqrt(max) + 0.1);
            auto p = 2;
            for(; p < sqrt_max; p++)
            {
                if(!buffer[p])
                    continue;

                _primes.push_back(p);

                for (auto m = p * p; m < max; m += p)
                {
                    buffer[m] = false;
                }
            }
            for(;p < max; p++)
            {
                if(!buffer[p])
                    continue;

                _primes.push_back(p);
            }

            _map.resize(_max, false);
            REP(i, _max)
            {
                if(buffer[i])
                  _map[i] = true;
            }
        }

        bool is_prime(Int value)
        {
            return _map[value];
        }

        int get_count()
        {
            return _primes.size();
        }

        Int get(int nth)
        {
            return _primes[nth];
        }

        // value以上の最小の素数を取得
        Int find_next(Int value)
        {
            return *std::lower_bound(_primes.begin(), _primes.end(), value);
        }

        void dump()
        {
            for(auto& p : _primes)
            {
                cout << p << endl;
            }
        }

    private:
        int _max;
        vector<bool> _map;
        vector<Int> _primes;
    };
}
#pragma endregion
#pragma region accumulate
// ====== accumulate ======
// 1次元累積和
template<class T>
class accumulate_sum
{
public:
    accumulate_sum(const vector<T>& source)
        : _source(source)
    {
    }

    void make_sum()
    {
        _sum.clear();
        auto size = _source.size();
        _sum.resize(size + 1);
        _sum[0] = 0;

        REPR(x, 1, size+1)
        {
            _sum[x] = _sum[x-1] + _source[x-1];
        }
    }

    // x: [x1, x2)
    //   の範囲の累積和をとる
    T calculate(int x1, int x2)
    {
        if(x2 < x1)
            swap(x2, x1);

        return _sum[x2] - _sum[x1];
    }

    const vector<T>& get_internal() const
    {
        return _source;
    }

private:
    const vector<T>& _source;
    vector<T> _sum;
};

// 2次元累積和
template<class T>
class accumulate_sum_grid
{
public:
    accumulate_sum_grid(const vector<vector<T>>& source)
        : _source(source)
    {
        _width = _source.size();
        _height = _source[0].size();

        _sum = make_grid<T>(_width + 1, _height + 1);
    }

    void make_sum()
    {
        REP(x, _width)
            _sum[x][0] = 0;
        REP(y, _height)
            _sum[0][y] = 0;

        REPR(y, 1, _height+1) 
        REPR(x, 1, _width+1)
        {
            _sum[x][y] = _sum[x-1][y] + _sum[x][y-1] - _sum[x-1][y-1] + _source[x-1][y-1];
        }
    }

    // x: [x1, x2)
    // y: [y1, y2)
    //   の範囲の累積和をとる
    T calculate(int x1, int y1, int x2, int y2)
    {
        if(x2 < x1)
            swap(x2, x1);
        if(y2 < y1)
            swap(y2, x1);

        return _sum[x2][y2] - _sum[x1][y2] - _sum[x2][y1] + _sum[x1][y1];
    }

    const vector<vector<T>>& get_internal() const
    {
        return _source;
    }

private:
    const vector<vector<T>>& _source;
    vector<vector<T>> _sum;
    int _width;
    int _height;
};
#pragma endregion

#ifndef LIB_ONLY

bool on_vscode_debug = false;
enum class RunMode{ Solver = 0, SlowSolver = 1, GenerateCase = 2 };
RunMode run_mode = RunMode::Solver;

void init();
void input();
void solve_main();


void solve_slow();
void generate_case();
#ifndef DEBUG
void solve_slow(){}
void generate_case(){}
#endif

// ==================================================================
// ==================================================================

int main(int argc, char** argv)
{
#ifdef DEBUG
    REPR(i, 1, argc)
    {
        auto str = std::string{argv[i]};
        if(str == "--vscode")
        {
            on_vscode_debug = true;
        }
        else if(str == "--slow")
        {
            run_mode = RunMode::SlowSolver;
        }
        else if(str == "--generate")
        {
            run_mode = RunMode::GenerateCase;
        }
    }
#endif

    init();

    if(run_mode != RunMode::GenerateCase)
    {
        input();
    }

    if(run_mode == RunMode::Solver)
    {
        solve_main();
    }
    else if(run_mode == RunMode::SlowSolver)
    {
        solve_slow();
    }

    return 0;
}

// ==================================================================
// ==================================================================

#ifdef DEBUG

void solve_slow()
{
}

void generate_case(ll seed)
{
    std::mt19937 engine(seed);

    auto rand = [&](ll min, ll max) {
        return uniform_int_distribution<ll>(min, max)(engine);
    };
}

#endif

// ==================================================================
// ==================================================================

void init()
{
}

void input()
{
}


void solve_main()
{
}

#endif

