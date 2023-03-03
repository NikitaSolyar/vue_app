<!-- eslint-disable max-len -->
<template>
  <transition name="fade">
    <div v-if="show" class="fade__preloader">
      <div class="fade__loading"></div>
      <p>Загрузка страницы...<img src="@/assets/Ghost.gif" alt="загрузка"></p>
    </div>
  </transition>
</template>

<script>
export default {
  data() {
    return {
      show: true,
    };
  },
  mounted() {
    this.showToggle();
  },
  methods: {
    showToggle() {
      setTimeout(() => {
        this.show = false;
      }, 1000);
    },
  },
};
</script>

<style>
.fade-enter-activ, .fade-leave-active {
  transition: opacity 1s ease-in-out
}
</style>
