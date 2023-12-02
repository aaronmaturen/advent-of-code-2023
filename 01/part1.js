process.stdin.on("data", function (data) {
  const input = data.toString().trim();
  // console.log(input)

  const sum = input
    .split("\n")
    .filter(Boolean)
    .reduce((acc, str) => {
      const numbers = str.match(/\d/g);
      // console.log(
      //   `[${numbers.join(", ")}] => ${parseInt(
      //     `${numbers.at(0)}${numbers.at(-1)}`
      //   )}`
      // );
      return acc + parseInt(`${numbers.at(0)}${numbers.at(-1)}`);
    }, 0);

  console.log(sum);
});
