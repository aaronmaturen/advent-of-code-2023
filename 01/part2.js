process.stdin.on("data", function (data) {
  const input = data.toString().trim();

  const digits = {
    one: "1",
    two: "2",
    three: "3",
    four: "4",
    five: "5",
    six: "6",
    seven: "7",
    eight: "8",
    nine: "9",
  };

  const isDigit = (str) => {
    return /^\d$/.test(str);
  };
  4;

  const reverseString = (str) => {
    return str.split("").reverse().join("");
  };

  const findFirst = (str) => {
    // prettier-ignore
    const regex = new RegExp("(one|two|three|four|five|six|seven|eight|nine|\\d)","g");
    const match = str.match(regex);

    if (!match?.[0]) {
      console.log("first", str);
    }

    if (!digits[match[0]]) {
      return match[0];
    }

    return match ? digits[match[0]] : null;
  };

  const findLast = (str) => {
    // prettier-ignore
    const regex = new RegExp("(eno|owt|eerht|ruof|evif|xis|neves|thgie|enin|\\d)","g");
    const match = reverseString(str).match(regex);
    if (!match?.[0]) {
      console.log("last", reverseString(str));
    }
    if (!digits[reverseString(match[0])]) {
      return match[0];
    }
    return match ? digits[reverseString(match[0])] : null;
  };

  const sum = input
    .split("\n")
    .filter(Boolean)
    .map((boop) => `${boop} => ${findFirst(boop)}${findLast(boop)}`)
    .reduce((acc, str) => {
      return acc + parseInt(`${findFirst(str)}${findLast(str)}`);
    }, 0);

  console.log(sum);
});
