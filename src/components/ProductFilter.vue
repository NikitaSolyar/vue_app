<!-- eslint-disable max-len -->
<template>
  <aside class="filter">
  <h2 class="filter__title">Фильтры</h2>

  <form class="filter__form form" action="#" method="get" @submit.prevent="submit">
    <fieldset class="form__block">
      <legend class="form__legend">Цена</legend>
      <label class="form__label form__label--price" for="min-price">
        <input class="form__input" type="text" name="min-price" v-model.number="currentPriceFrom" id="min-price">
        <span class="form__value">От</span>
      </label>
      <label class="form__label form__label--price" for="max-price">
        <input class="form__input" type="text" name="max-price" v-model.number="currentPriceTo" id="max-price">
        <span class="form__value">До</span>
      </label>
    </fieldset>

    <fieldset class="form__block">
      <legend class="form__legend">Категория</legend>
      <label class="form__label form__label--select" for="categ">
        <select class="form__select" type="text" name="category" id="categ" v-model.number="currentCategoryId">
          <option value="0">Все категории</option>
          <option :value="category.id" v-for="category in categories" :key="category.id">{{ category.title }}</option>
        </select>
      </label>
    </fieldset>

    <fieldset class="form__block">
      <legend class="form__legend">Цвет</legend>

        <ProductColor :colors="colors" @update:color="currentColor = $event" />

    </fieldset>

    <fieldset class="form__block">
      <legend class="form__legend">Объем в ГБ</legend>
      <ul class="check-list">
        <li class="check-list__item">
          <label class="check-list__label" for="volume">
            <input class="check-list__check sr-only" type="checkbox" name="volume" value="8" checked="" id="volume">
            <span class="check-list__desc">
              8
              <span>(313)</span>
            </span>
          </label>
        </li>
        <li class="check-list__item">
          <label class="check-list__label" for="volume1">
            <input class="check-list__check sr-only" type="checkbox" name="volume" value="16" id="volume1">
            <span class="check-list__desc">
              16
              <span>(461)</span>
            </span>
          </label>
        </li>
        <li class="check-list__item">
          <label class="check-list__label" for="volume2">
            <input class="check-list__check sr-only" type="checkbox" name="volume" value="32" id="volume2">
            <span class="check-list__desc">
              32
              <span>(313)</span>
            </span>
          </label>
        </li>
        <li class="check-list__item">
          <label class="check-list__label" for="volume3">
            <input class="check-list__check sr-only" type="checkbox" name="volume" value="64" id="volume3">
            <span class="check-list__desc">
              64
              <span>(313)</span>
            </span>
          </label>
        </li>
        <li class="check-list__item">
          <label class="check-list__label" for="volume4">
            <input class="check-list__check sr-only" type="checkbox" name="volume" value="128" id="volume4">
            <span class="check-list__desc">
              128
              <span>(313)</span>
            </span>
          </label>
        </li>
        <li class="check-list__item">
          <label class="check-list__label" for="volume5">
            <input class="check-list__check sr-only" type="checkbox" name="volume" value="264" id="volume5">
            <span class="check-list__desc">
              264
              <span>(313)</span>
            </span>
          </label>
        </li>
      </ul>
    </fieldset>

    <button class="filter__submit button button--primery" type="submit">
      Применить
    </button>
    <button class="filter__reset button button--second" type="button" @click.prevent="reset">
      Сбросить
    </button>
  </form>
</aside>
</template>

<script>
import axios from 'axios';
import { API_BASE_URL } from '@/config';
import ProductColor from './ProductColor.vue';

export default {
  data() {
    return {
      currentPriceFrom: 0,
      currentPriceTo: 0,
      currentCategoryId: 0,
      currentColor: null,
      categoriesData: null,
      filterColorId: 0,
      colorsData: null,
    };
  },
  props: ['priceFrom', 'priceTo', 'categoryId', 'productColor'],
  components: { ProductColor },
  computed: {
    categories() {
      return this.categoriesData ? this.categoriesData.items : [];
    },
    colors() {
      return this.colorsData ? this.colorsData.items : [];
    },
  },
  watch: {
    priceFrom(value) {
      this.currentPriceFrom = value;
    },
    priceTo(value) {
      this.currentPriceTo = value;
    },
    categoryId(value) {
      this.currentCategoryId = value;
    },
    productColor(value) {
      this.currentColor = value;
    },
    colorsData(value) {
      this.colorsData = value;
    },
  },
  methods: {
    submit() {
      this.$emit('update:priceFrom', this.currentPriceFrom);
      this.$emit('update:priceTo', this.currentPriceTo);
      this.$emit('update:categoryId', this.currentCategoryId);
      this.$emit('update:productColor', this.currentColor);
    },
    reset() {
      this.$emit('update:priceFrom', 0);
      this.$emit('update:priceTo', 0);
      this.$emit('update:categoryId', 0);
      this.$emit('update:productColor', null);
    },
    loadCategories() /* eslint-disable */{
      axios
        .get(API_BASE_URL + '/api/productCategories')
        .then((response) => this.categoriesData = response.data);
    },
    loadColors() /* eslint-disable */{
      return axios
        .get(API_BASE_URL + '/api/colors')
        .then((response) => this.colorsData = response.data);
    },
  },
  created() {
    this.loadCategories();
    this.loadColors();
  },
};
</script>
