struct Fib {
    a: u32,
    b: u32,
}

impl Iterator for Fib {
    type Item = u32;
    fn next(&mut self) -> Option<Self::Item> {
        let c = self.a + self.b;
        self.b = self.a;
        self.a = c;
        return Some(c);
    }
}

fn fib() -> Fib {
    Fib {
        a: 1,
        b: 0
    }
}

fn main() {
/*    let mut a: u32 = 1;
    let mut b: u32 = 0;
    let mut sum: u32 = 0;
    loop {
        let c = a + b;
        if c >= 4000000 {
            break;
        }
        if c % 2 == 0 {
            sum += c;
        }
        b = a;        
        a = c;
}*/

    let sum: u32 = fib().take_while(|x| *x < 4000000).filter(|x| x % 2 == 0).sum();
    println!("{}", sum);
}
