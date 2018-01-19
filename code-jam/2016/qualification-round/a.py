import unittest


DIGITS = frozenset(range(10))


def digits(n):
    n = abs(n)
    s = set()
    while n > 0:
        s.add(n % 10)
        n //= 10
    return s

def sleep(n):
    if n == 0:
        return 'INSOMNIA'
    step = 1
    seen = set()
    while True:
        m = n * step
        seen |= digits(m)
        if seen == DIGITS:
            return m
        step += 1


def read_cases(fobj):
    n = int(fobj.readline().strip())
    for _ in range(n):
        yield int(fobj.readline().strip())


def do_case(cur, n):
    return 'Case #{0}: {1}'.format(cur, sleep(n))


def main():
    import sys
    for idx, case in enumerate(read_cases(sys.stdin)):
        print(do_case(idx+1, case))
        sys.stdout.flush()


class TestA(unittest.TestCase):
    cases = [(0, 'INSOMNIA'),
             (1, 10),
             (2, 90),
             (11, 110),
             (1692, 5076)]

    def test_cases(self):
        for case in self.cases:
            self.assertEqual(sleep(case[0]), case[1], 'sleep({0}) -> {1}'.format(*case))

    def test_digit_constant(self):
        self.assertSetEqual(DIGITS, {0, 1, 2, 3, 4, 5, 6, 7, 8, 9})

    def test_digits(self):
        self.assertSetEqual(digits(1234), {1, 2, 3, 4})
        self.assertSetEqual(digits(1234567890), DIGITS)


if __name__ == '__main__':
    main()

