#define LIB_ONLY
#include "main.cpp"

// ==================================================================
// ==================================================================

void generate(ll seed)
{
    std::mt19937 engine(seed);

    auto rand = [&](ll min, ll max) {
        return uniform_int_distribution<ll>(min, max)(engine);
    };

    auto n = 100;
}

int main(int argc, char** argv)
{
    generate(random_device{}());
}

