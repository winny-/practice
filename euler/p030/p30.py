def digits(n):
    while n:
        yield n % 10
        n = n // 10

def p30():
    return sum(x for x in range(2, 1000000)
               if x == sum(pow(y, 5) for y in digits(x)))

if __name__ == '__main__':
    print(p30())
