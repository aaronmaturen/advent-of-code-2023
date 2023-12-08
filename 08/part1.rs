use std::io::{self, BufRead};
use std::collections::HashMap;


fn main() {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();
    let mut map: HashMap<String, (String, String)> = HashMap::new();
    let mut location = String::from("AAA");
    let mut instructions = Vec::new();
    let mut iterations = 0;

    if let Some(Ok(first_line)) = lines.next() {
        instructions = first_line.chars().collect();
        println!("{:?}", instructions);
    }

    for line in lines {
      match line {
          Ok(line) => {
              if !line.trim().is_empty() {
                  let parts: Vec<&str> = line.split('=').map(|s| s.trim()).collect();
                  if parts.len() == 2 {
                      let key = parts[0].to_string();
                      let values: Vec<&str> = parts[1][1..parts[1].len()-1].split(',').map(|s| s.trim()).collect();
                      if values.len() == 2 {
                          let value = (values[0].to_string(), values[1].to_string());
                          map.insert(key, value);
                      }
                  }
              }
          },
          Err(error) => println!("Error: {}", error),
      }
  }

  while location != "ZZZ" {
    for instruction in &instructions {
        if let Some(&(ref left, ref right)) = map.get(&location) {
            location = match *instruction {
                'L' => left.clone(),
                'R' => right.clone(),
                _ => panic!("Invalid instruction: {}", instruction),
            };
            iterations += 1;
        } else {
            panic!("Invalid location: {}", location);
        }
    }
  }

println!("Number of iterations: {}", iterations);

  // println!("{:?}", map);
}
