<!-- eslint-disable max-len -->
<template>
  <div class="product__counter form__counter">
    <button type="button" aria-label="Убрать один товар" @click.prevent="decrement()">
        <svg width="10" height="10" fill="currentColor">
        <use xlink:href="#icon-minus"></use>
        </svg>
    </button>
    <label for="count1">
    <input type="text" v-model.number="currentAmount" name="count" id="count1" @input="$emit('update:amount', $event.target.value)">
    </label>
    <button type="button" aria-label="Добавить один товар" @click.prevent="increment()">
        <svg width="10" height="10" fill="currentColor">
        <use xlink:href="#icon-plus"></use>
        </svg>
    </button>
</div>
</template>
<script>
import { mapActions, mapMutations } from 'vuex';

export default {
  data() {
    return {
      currentAmount: this.amount,
    };
  },
  props: ['amount'],
  watch: {
    amount(value) {
      this.currentAmount = value;
    },
  },
  computed: {

  },
  methods: {
    ...mapMutations({ updateCartProductAmount: 'updateCartProductAmount' }),
    ...mapActions(['updateDeleteCartProduct']),

    increment() {
      this.currentAmount += 1;
      this.$emit('update:amount', this.currentAmount);
    },
    decrement() {
      if (this.amount !== 0) {
        this.currentAmount -= 1;
      }
      this.$emit('update:amount', this.currentAmount);
    },
  },
};
</script>
