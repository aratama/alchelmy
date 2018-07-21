module.exports = {
  mode: "development",
  entry: ["./src/elm-automata.mjs"],
  output: {
    path: `${__dirname}/dist`,
    filename: "elm-automata.js"
  },
  module: {
    rules: [
      {
        test: /\.mjs$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader"
        }
      }
    ]
  }
};
