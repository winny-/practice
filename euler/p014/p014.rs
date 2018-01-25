use std::collections::HashMap;

// lol

fn main() {
    let mut table: HashMap<u64, (u64, u64)> = HashMap::new();
    table.insert(1, (0, 1));
    for i in 1..1000000 {
        let mut stack: Vec<u64> = Vec::new();
        stack.push(i);
        //println!("{}", i);
        while !stack.is_empty() {
            let mut v = stack.pop().unwrap();
            match table.get(&v) {
                Some(&(_, steps)) => {
                    for (j, x) in stack.iter().rev().enumerate() {
                        table.insert(*x, (v, j as u64+steps));
                        v = *x;
                    }
                    break;                    
                }
                None => {
                    let next = if v % 2 == 0 { v / 2 } else { 3 * v + 1 };
                    stack.push(v);
                    stack.push(next);
                }
            }
        }
    }

    fn f(acc: (u64, (u64, u64)), v: (&u64, &(u64, u64))) -> (u64, (u64, u64)) {
        let ((_, (_, acc_length)), (v_n, &(v_next, v_length))) = (acc, v);
        if v_length > acc_length {
            (*v_n, (v_next, v_length))
        } else {
            acc
        }        
    }

    let longest = table.iter().fold((0 as u64, (0 as u64, 0 as u64)),f);
    let (n, (_, _)) = longest;
    println!("{}", n);
}
