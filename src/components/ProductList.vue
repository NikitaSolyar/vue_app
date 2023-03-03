<!-- eslint-disable max-len -->
<template>
  <ul class="catalog__list">
    <!-- <ProductListitem v-for="product in products"
    :key="product.id" :product="product"
    @goToPage="(pageName, pageParams) => $emit('goToPage', pageName, pageParams)"/> -->
    <ProductListitem v-for="product in products"
    :key="product.id" :product="product" />
  </ul>
</template>

<script>
import ProductListitem from '@/components/ProductListitem.vue';

export default {
  props: ['products'],
  components: { ProductListitem },
};
</script>
