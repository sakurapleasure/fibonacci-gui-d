import std.bigint, std.stdio;

static BigInt fibonacci(int n) {
    if (n == 0) return BigInt(0);
    BigInt a = 0, b = 1, c = 1;
    for (int i = 1; i < n; i++) {
        c = a + b;
        a = b;
        b = c;
    }
    return c;
}

static BigInt[] fibonacciList(int n, int k) {
    if(n > k) return [];
    BigInt[] result;
    for (; n <= k; n++) {
        result ~= fibonacci(n);
    }
    return result;
}