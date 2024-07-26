const path = require('path');
const fs = require('fs');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const CssMinimizerPlugin = require('css-minimizer-webpack-plugin');
const BrowserSyncPlugin = require('browser-sync-webpack-plugin');
const webpack = require('webpack');
require('dotenv').config(); // Load environment variables from .env file

module.exports = (env) => {
  const isProduction = env.production === true;
  // const layoutsTemplateFolder = process.env.LAYOUT_TEMPLATES_FOLDER;

  // Function to generate HtmlWebpackPlugin instances for each HTML file in ./src/layout
  const generateHtmlPlugins = (templateDir) => {
    const templateFiles = fs.readdirSync(path.resolve(__dirname, templateDir));
    return templateFiles.filter(item => item.endsWith('.html')).map(item => {
      const name = item.split('.')[0];
      return new HtmlWebpackPlugin({
        template: path.resolve(__dirname, `${templateDir}/${item}`),
        filename: path.resolve(__dirname,  process.env.HTML_WRAPPER_FOLDER + `${item}`)
      });
    });
  };

  const htmlPlugins = generateHtmlPlugins('./src/layout');

  return {
    mode: isProduction ? 'production' : 'development',
    entry: {
      bundle: path.resolve(__dirname, 'src/index.js'),
    },
    output: {
      publicPath: '/',
      path: path.resolve(__dirname, process.env.PUBLIC_FOLDER),
      filename: isProduction ? 'assets/js/[name][contenthash].js' : 'assets/js/[name].js',
      assetModuleFilename: isProduction ? 'assets/[name][contenthash][ext]' : 'assets/[name][ext]',
    },
    devtool: isProduction ? false : 'source-map',
    module: {
      rules: [
        {
          test: /\.scss$/,
          use: [
            MiniCssExtractPlugin.loader,
            "css-loader",
            "postcss-loader",
            "sass-loader",
          ],
        },
        {
          test: /\.js$/,
          exclude: /node_modules/,
          use: {
            loader: 'babel-loader',
            options: {
              presets: ['@babel/preset-env'],
              cacheCompression: false,
              cacheDirectory: true,
              compact: false,
            },
          },
        },
        {
          test: /\.(png|svg|jpg|jpeg|gif)$/i,
          type: 'assets/img',
        },
      ],
    },
    optimization: isProduction ? {
      minimize: true,
      minimizer: [
        new TerserPlugin({
          terserOptions: {
            compress: {
              drop_console: true,
            },
          },
        }),
        new CssMinimizerPlugin(),
      ],
    } : {
      minimize: false,
    },
    plugins: [
      new CleanWebpackPlugin({
        cleanOnceBeforeBuildPatterns: [
          'assets/js/*', 
          'assets/css/*'
        ],
      }),
      new MiniCssExtractPlugin({
        filename: isProduction ? 'assets/css/[name][contenthash].css' : 'assets/css/[name].css',
      }),
      new CopyWebpackPlugin({
        patterns: [
          { from: './src/assets/img', to: './assets/img' }
        ]
      }),
      new BrowserSyncPlugin({
        host: 'localhost',
        https: {
          key: '.devcontainer/server-conf/ssl/' + process.env.DOMAIN + '-key.pem',
          cert: '.devcontainer/server-conf/ssl/' + process.env.DOMAIN + '.pem',
        },
        port: process.env.PORT,
        proxy: 'https://' + process.env.DOMAIN,
        files: [
          process.env.SYSTEM_FOLDER + '/user/templates/**/*',
          'src/**/*',
        ],
        reloadDelay: 0
      }),
      new webpack.DefinePlugin({
        'process.env': JSON.stringify(process.env) // Make environment variables available in your application
      }),
    ].concat(htmlPlugins)
  };
}
