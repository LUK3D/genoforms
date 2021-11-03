import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import Setup from '../views/Setup.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/setup',
    name: 'Setup',
    component: Setup
  },

]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
