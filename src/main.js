import { createApp } from 'vue'
import { createVuetify } from 'vuetify'
import '@mdi/font/css/materialdesignicons.css'
import 'vuetify/styles'
import './style.css'
import App from './App.vue'

const vuetify = createVuetify({
  icons: {
    defaultSet: 'mdi',
  },
  theme: {
    defaultTheme: 'terminal',
    themes: {
      terminal: {
        dark: true,
        colors: {
          background: '#0d1117',
          surface: '#161b22',
          primary: '#00ff41',
          secondary: '#ffb300',
          error: '#ff5555',
          info: '#58a6ff',
          success: '#00ff41',
          warning: '#ffb300',
        },
      },
    },
  },
})

createApp(App).use(vuetify).mount('#app')
