module.exports = {
  root: true,
  parserOptions: {
    ecmaVersion: 2019,
    sourceType: 'module',
    ecmaFeatures: {
      jsx: true
    }
  },
  env: { browser: true, commonjs: true, node: true, es6: true },
  plugins: ['prettier', 'eslint-comments'],
  extends: [
    'eslint:recommended',
    'plugin:eslint-comments/recommended',
    'plugin:prettier/recommended'
  ],
  settings: {},
  rules: {
    'eslint-comments/no-unused-disable': 'error',
    'no-var': 'error',
    'no-else-return': 'error',
    'no-return-await': 'error',
    'no-throw-literal': 'error',
    'no-sparse-arrays': 'error',
    'no-param-reassign': 'error',
    'no-ex-assign': 'error',
    'no-underscore-dangle': 'off',
    'no-useless-constructor': 'error',
    'no-with': 'error',
    'no-plusplus': ['error', { allowForLoopAfterthoughts: true }],
    'no-nested-ternary': 'error',
    'no-shadow': 'warn',
    'no-shadow-restricted-names': 'error',
    'no-this-before-super': 'error',
    'prefer-arrow-callback': 'warn',
    'newline-before-return': 'error',
    'curly': 'error',
    'eqeqeq': 'error',
    'guard-for-in': 'error',
    'default-case': 'error',
    'radix': 'error',
    'dot-notation': 'error',
    'consistent-this': ['error', 'self'],
    'yoda': 'error',
    'new-cap': ['error', { capIsNewExceptions: ['Callsite'] }],
    'spaced-comment': [
      'warn',
      'always',
      {
        markers: ['=', '#region'],
        exceptions: ['#endregion']
      }
    ],
    'camelcase': 'error'
  }
};
