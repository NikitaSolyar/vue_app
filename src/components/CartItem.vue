<!-- eslint-disable max-len -->
<template>
  <li class="cart__item product">
  <div class="product__pic">
    <img :src="item.product.image" width="120" height="120" :alt="item.product.title">
  </div>
  <h3 class="product__title">
    {{ item.product.title }}
  </h3>
  <span class="product__code">
    {{ item.product.id }}
  </span>

  <productAdd :amount.sync="currentAmount" />

  <b class="product__price">
    {{ (item.amount * item.product.price) | numberFormat }} ₽
  </b>

  <button class="product__del button-del" type="button" aria-label="Удалить товар из корзины" @click.prevent="updateDeleteCartProduct(item.productId)">
    <svg width="20" height="20" fill="currentColor">
      <use xlink:href="#icon-close"></use>
    </svg>
  </button>
</li>
</template>

<script>
import numberFormat from '@/helpers/numberFormat';
import { mapActions, mapMutations } from 'vuex';
import ProductAdd from '@/components/ProductAdd.vue';

export default {
  data() {
    return {
      currentAmount: this.item.amount,
    };
  },
  filters: { numberFormat },
  props: ['item'],
  components: { ProductAdd },
  computed: {
    amount: {
      get() {
        return this.item.amount;
      },
      set(value) {
        this.$store.dispatch('updateCartProductAmount', { productId: this.item.productId, amount: value });
      },
    },
  },
  watch: {
    amount(value) {
      this.currentAmount = value;
    },
    currentAmount(val) {
      this.amount = val;
    },
  },
  methods: {
    ...mapMutations({ updateCartProductAmount: 'updateCartProductAmount' }),
    ...mapActions(['updateDeleteCartProduct']),
  },
};
</script>
