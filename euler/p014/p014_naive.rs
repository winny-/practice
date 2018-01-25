fn main() {
    let mut best_n = 0 as u64;
    let mut best_length = 0 as usize;
    for n in 1..1000000 {
        let mut m = n;
        let mut length = 0;
        while m > 1 {
            length += 1;
            m = if m % 2 == 0 { m / 2 } else { 3 * m + 1 };
        }
        length += 1;
        if length > best_length {
            best_n = n;
            best_length = length;
        }
    }
    println!("{}", best_n);
}
