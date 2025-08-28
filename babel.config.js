module.exports = function (api) {
    api.cache(true);
    return {
      presets: ['babel-preset-expo'],
      plugins: [
        // aliases p/ casar com seu tsconfig (opcional, mas útil)
        ['module-resolver', {
          root: ['./'],
          alias: {
            '@': './src',
            '@components': './src/components',
            '@screens': './src/screens',
            '@theme': './src/theme',
          },
        }],
        // ⚠️ Reanimated 3.x usa este plugin:
        'react-native-reanimated/plugin', // DEIXE POR ÚLTIMO
      ],
    };
  };