<!-- eslint-disable max-len -->
<template>
  <main class="content container">
    <div class="content__top content__top--catalog">
      <h1 class="content__title">
        Каталог
      </h1>
      <span class="content__info">
        152 товара
      </span>
    </div>

    <div class="content__catalog">

      <ProductFilter
       :price-from.sync="filterPriceFrom"
       :price-to.sync="filterPriceTo"
       :category-id.sync="filterCategoryId"
       :product-color.sync="productColors"
       />

      <section class="catalog">

        <div class="preloader" v-if="productsLoading">Загрузка товаров...<img src="@/assets/Ghost.gif" alt="загрузка"></div>
        <div v-if="productsLoadingFailed">Произошла ошибка при загрузке товаров... <button @click.prevent="loadProducts">Попробовать повторно</button></div>

        <!-- <ProductList :products="products"
        @goToPage="(pageName, pageParams) => $emit('goToPage', pageName, pageParams)" /> -->
         <ProductList :products="products"/>

        <BasePagination v-model="page" :count="countProducts" :per-page="productPerPage"/>

      </section>
    </div>
  </main>
</template>

<script>
import ProductList from '@/components/ProductList.vue';
import BasePagination from '@/components/BasePagination.vue';
import ProductFilter from '@/components/ProductFilter.vue';
import axios from 'axios';
import { API_BASE_URL } from '@/config';

export default {
  components: {
    ProductList,
    BasePagination,
    ProductFilter,
  },
  data() {
    return {
      filterPriceFrom: 0,
      filterPriceTo: 0,
      filterCategoryId: 0,
      page: 1,
      productPerPage: 3,
      productColors: null,
      productsData: null,
      productsLoading: false,
      productsLoadingFailed: false,
    };
  },

  computed: {

    products()/* eslint-disable */{
      return this.productsData
        ? this.productsData.items.map(product =>  {
            return {
              ...product,
              image: product.image.file.url
            }
        })
        : [];
      // const offset = (this.page - 1) * this.productPerPage;
      // return this.filteredProducts.slice(offset, offset + this.productPerPage);
    },
    countProducts() {
      return this.productsData ? this.productsData.pagination.total : 0;
    },
  },
  methods: {
    loadProducts() {
      this.productsLoading = true;
      this.productsLoadingFailed = false;
      clearTimeout(this.loadProductsTimer);
      this.loadProductsTimer = setTimeout(() => {
        axios
          .get(API_BASE_URL + `/api/products`, {
            params: {
              page: this.page,
              limit: this.productPerPage,
              colorId: this.productColors,
              categoryId: this.filterCategoryId,
              minPrice: this.filterPriceFrom,
              maxPrice: this.filterPriceTo,
            }
          })
        .then(response => this.productsData = response.data)
        .catch(() => this.productsLoadingFailed = true)
        .then(() => { this.productsLoading = false });
      }, 2000);
    }
  },
  watch: {
    page() {
      this.loadProducts();
    },
    filterPriceFrom() {
      this.loadProducts();
    },
    filterPriceTo() {
      this.loadProducts();
    },
    filterCategoryId() {
      this.loadProducts();
    },
    productColors() {
      this.loadProducts();
    },
    filterColorId() {
      this.loadProducts();
    },
  },
  created() {
    this.loadProducts();
  },
};
</script>
