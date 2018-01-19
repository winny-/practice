def is_p1(x):
    return x % 3 == 0 or x % 5 == 0

p1 = sum(i for i in range(1000) if is_p1(i))

if __name__ == '__main__':
    print(p1)
