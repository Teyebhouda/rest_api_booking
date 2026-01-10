const defaultTheme = require('tailwindcss/defaultTheme');
const forms = require('@tailwindcss/forms');

module.exports = {
  content: [
    './vendor/laravel/framework/src/Illuminate/Pagination/resources/views/*.blade.php',
    './storage/framework/views/*.php',
    './resources/views/**/*.blade.php',
    './resources/js/**/*.vue',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Figtree', ...defaultTheme.fontFamily.sans],
        display: ['Poppins', 'Figtree', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        primary: { DEFAULT: '#0D2F4E', light: '#254A6C', dark: '#061B31' },
        secondary: { DEFAULT: '#F5A623', light: '#FFC04D', dark: '#C27800' },
        neutral: { light: '#F9F9F9', gray: '#C4C4C4' },
      },
      borderRadius: { modern: "1rem", xl: "1rem", "2xl": "1.25rem" },
      boxShadow: { soft: "0 8px 30px rgba(0,0,0,0.06)", softLg: "0 12px 50px rgba(0,0,0,0.08)" },
      keyframes: {
        fadeUp: { '0%': { opacity:0, transform:'translateY(20px)' }, '100%': { opacity:1, transform:'translateY(0)' } },
        fadeIn: { '0%': { opacity:0 }, '100%': { opacity:1 } }
      },
      animation: { fadeUp: 'fadeUp 0.8s cubic-bezier(.25,.46,.45,.94) forwards', fadeIn: 'fadeIn 1s ease-out forwards' },
      textShadow: {
        'text': '0 2px 14px rgba(0,0,0,0.35)',
        'glow': '0 0 8px rgba(245,166,35,0.5)',
      },
    }
  },
  plugins: [
    forms,
    function ({ addUtilities }) {
      addUtilities({
        '.text-gradient': {
          background: 'linear-gradient(90deg, #0D2F4E, #F5A623)',
          '-webkit-background-clip': 'text',
          '-webkit-text-fill-color': 'transparent',
        },
        '.text-glow': {
          'text-shadow': '0 0 10px rgba(245,166,35,0.6)',
        },
      })
    }
  ],
};
