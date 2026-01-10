import { ref, onMounted, onUnmounted } from 'vue'

export function useScrollHide() {
  const isHidden = ref(false)
  let lastScroll = 0

  const handleScroll = () => {
    const current = window.scrollY
    if (current <= 80) {
      isHidden.value = false
      lastScroll = current
      return
    }
    if (current > lastScroll) {
      isHidden.value = true
    }
    if (current < lastScroll) {
      isHidden.value = false
    }
    lastScroll = current
  }

  onMounted(() => window.addEventListener('scroll', handleScroll))
  onUnmounted(() => window.removeEventListener('scroll', handleScroll))

  return { isHidden }
}