<!-- eslint-disable max-len -->
<template>
  <li class="catalog__item">
  <!-- <a class="catalog__pic" href="#" @click.prevent="$emit('goToPage', 'product', {id: product.id})"> -->
  <router-link class="catalog__pic" :to="{name: 'product', params: {id: product.id}}">
    <img :src="product.image" :alt="product.title">
  </router-link>

  <h3 class="catalog__title">
    <a href="#">
      {{ product.title }}
    </a>
    </h3>

  <span class="catalog__price">
    {{ product.price | numberFormat }} ₽
  </span>

    <ul class="colors colors--black">
      <li class="colors__item" v-for="colorVal in product.colors" :key="colorVal.id">
        <label class="colors__label" :for="colorVal.id">
        <input id="cold" class="colors__radio sr-only" type="radio" :value="colorVal.code" v-model="color">
        <span class="colors__value" :style="`background-color: ${colorVal.code}`">
        </span>
        </label>
        </li>
    </ul>
  </li>
</template>

<script>
import goToPage from '@/helpers/goToPage';
import numberFormat from '@/helpers/numberFormat';

export default {
  data() {
    return {
      color: this.product.colors[0].code,
    };
  },
  filters: {
    numberFormat,
  },
  methods: {
    goToPage,
  },
  props: ['product'],
};
</script>
