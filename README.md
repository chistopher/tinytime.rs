# It's Rust `time`!

Low overhead implementation of time-related concepts.

## Who is `time` for?

For applications where simplicity and low-overhead are more important than precision, safety, and time zone support.


## License

Licensed under either of

 * Apache License, Version 2.0
   ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
 * MIT license
   ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.

## Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be
dual licensed as above, without any additional terms or conditions.

| left       | operator | right    | result     | note              |
| ---------- | -------- | -------- | ---------- | ----------------- |
| Time       | -        | Time     | Duration   |                   |
| Time       | +=       | Time     | Time       | seems unexpected? |
| Time       | +        | Duration | Time       |                   |
| Time       | +=       | Duration | Time       |                   |
| Time       | -        | Duration | Time       |                   |
| Time       | -=       | Duration | Time       |                   |
| TimeWindow | +        | Duration | TimeWindow |                   |
| TimeWindow | +=       | Duration | TimeWindow |                   |
| TimeWindow | -        | Duration | TimeWindow |                   |
| TimeWindow | -=       | Duration | TimeWindow |                   |
| Duration   | +        | Duration | Duration   |                   |
| Duration   | +=       | Duration | Duration   |                   |
| Duration   | -        | Duration | Duration   |                   |
| Duration   | -=       | Duration | Duration   |                   |
| Duration   | *        | f64      | Duration   |                   |
| Duration   | *=       | f64      | Duration   |                   |
| Duration   | /        | f64      | Duration   |                   |
| Duration   | /=       | f64      | Duration   |                   |
| Duration   | *        | isize    | Duration   |                   |
| Duration   | *=       | isize    | Duration   |                   |
| Duration   | /        | isize    | Duration   |                   |
| Duration   | /=       | isize    | Duration   |                   |
| Duration   | *        | Duration | Duration   |                   |
| Duration   | *=       | Duration | Duration   |                   |
| Duration   | /        | Duration | Duration   |                   |
| Duration   | /=       | Duration | Duration   |                   |

| Duration | Neg, Sum
