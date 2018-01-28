use std::vec::Vec;

fn digits(n: u64, base: u8) -> Vec<u8> {
    let mut v = Vec::new();
    let mut m = n;
    while m > 0 {
        v.push((m % base as u64) as u8);
        m = m / (base as u64);
    }
    v
}

fn is_palindrome<T>(v: Vec<T>) -> bool {
    let mut a = v.clone();
    if a.len() <= 1 {
        return true;
    }
    let index = a.len() / 2;
    let b = a.split_off(index);
    return a.iter().eq(b.iter().skip(if v.len() % 2 == 0 { 0 } else {1}).rev());
}

fn p36(n: u64) -> bool {
    return is_palindrome(digits(n, 2)) && is_palindrome(digits(n, 10));
}

fn main() {
    let sum: u64 = (1..1000000 as u64).filter(|n| p36(*n)).sum();
    println!("{}", sum);
}
