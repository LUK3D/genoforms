module.exports = {
  purge: ['./index.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        primary: {
          100: "#d1f0ff",
          200: "#a3e1fe",
          300: "#76d3fe",
          400: "#48c4fd",
          500: "#1ab5fd",
          600: "#1591ca",
          700: "#106d98",
          800: "#0a4865",
          900: "#052433"
          },
          black_bg: {
            100: "#d3d4d6",
            200: "#a7a9ad",
            300: "#7b7e84",
            400: "#4f535b",
            500: "#232832",
            600: "#1c2028",
            700: "#15181e",
            800: "#0e1014",
            900: "#07080a"
          },
          black_fg: {
            100: "#d6d7da",
            200: "#adafb5",
            300: "#84868f",
            400: "#5b5e6a",
            500: "#323645",
            600: "#282b37",
            700: "#1e2029",
            800: "#14161c",
            900: "#0a0b0e"
          },
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [
    require('daisyui'),
  ],
  daisyui: {
    themes: [
      {
        'mytheme': {
          'primary': '#1ab5fd',
          'primary-focus': '#1ab5fd',
          'primary-content': '#ffffff',
          'secondary': '#f000b8',
          'secondary-focus': '#bd0091',
          'secondary-content': '#ffffff',
          'accent': '#37cdbe',
          'accent-focus': '#2aa79b',
          'accent-content': '#ffffff',
          'neutral': '#3d4451',
          'neutral-focus': '#2a2e37',
          'neutral-content': '#ffffff',
          'base-100': '#ffffff',
          'base-200': '#f9fafb',
          'base-300': '#d1d5db',
          'base-content': '#1f2937',
          'info': '#2094f3',
          'success': '#009485',
          'warning': '#ff9900',
          'error': '#ff5724',
        },
      },
    ],
  },
}
