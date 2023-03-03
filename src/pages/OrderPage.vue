<!-- eslint-disable max-len -->
<template>
    <main class="content container">
    <div class="content__top">
      <ul class="breadcrumbs">
        <li class="breadcrumbs__item">
          <a class="breadcrumbs__link" href="index.html">
            Каталог
          </a>
        </li>
        <li class="breadcrumbs__item">
          <a class="breadcrumbs__link" href="cart.html">
            Корзина
          </a>
        </li>
        <li class="breadcrumbs__item">
          <a class="breadcrumbs__link">
            Оформление заказа
          </a>
        </li>
      </ul>

      <h1 class="content__title">
        Корзина
      </h1>
      <span class="content__info">
        {{ $store.state.cartProducts.length }} товара
      </span>
    </div>

    <section class="cart">
      <form class="cart__form form" action="#" method="POST" @submit.prevent="order">
        <div class="cart__field">
          <div class="cart__data">

            <BaseFormText v-model="formData.name" title="ФИО" :error="formError.name" placeholder="Введите ваше полное имя" />
            <BaseFormText v-model="formData.address" title="Адрес доставки" :error="formError.address" placeholder="Введите ваш адрес" />
            <BaseFormText v-model="formData.phone" title="Телефон" :error="formError.phone" placeholder="Введите ваш телефон" />
            <BaseFormText v-model="formData.email" title="Email" :error="formError.email" placeholder="Введи ваш Email" />
            <BaseFormTextarea v-model="formData.comment" title="Комментарий к заказу" :error="formError.comment" placeholder="Ваши пожелания"/>

          </div>

          <div class="cart__options">
            <h3 class="cart__title">Доставка</h3>
            <ul class="cart__options options">
              <li class="options__item">
                <label class="options__label" for="up1">
                  <input class="options__radio sr-only" type="radio" name="delivery" value="0" checked="" id="up1">
                  <span class="options__value">
                    Самовывоз <b>бесплатно</b>
                  </span>
                </label>
              </li>
              <li class="options__item">
                <label class="options__label" for="up2">
                  <input class="options__radio sr-only" type="radio" name="delivery" value="500" id="up2">
                  <span class="options__value">
                    Курьером <b>500 ₽</b>
                  </span>
                </label>
              </li>
            </ul>

            <h3 class="cart__title">Оплата</h3>
            <ul class="cart__options options">
              <li class="options__item">
                <label class="options__label" for="up3">
                  <input class="options__radio sr-only" type="radio" name="pay" value="card" id="up3">
                  <span class="options__value">
                    Картой при получении
                  </span>
                </label>
              </li>
              <li class="options__item">
                <label class="options__label" for="up4">
                  <input class="options__radio sr-only" type="radio" name="pay" value="cash" id="up4">
                  <span class="options__value">
                    Наличными при получении
                  </span>
                </label>
              </li>
            </ul>
          </div>
        </div>

        <div class="cart__block" v-show="$store.state.cartProductsData.length > 0">
          <div v-if="$store.state.basketLoading">Загрузка товаров...<img src="@/assets/Ghost.gif" alt="загрузка"></div>
          <OrderList :products="this.$store.state.cartProductsData"></OrderList>
          <button class="cart__button button button--primery" type="submit">
            Оформить заказ
          </button>
        </div>

        <div class="cart__error form__error-block" v-if="formErrorMessage">
          <h4>Заявка не отправлена!</h4>
          <p>
            {{ formErrorMessage }}
          </p>
        </div>
      </form>
    </section>
  </main>
</template>

<script>
import BaseFormText from '@/components/BaseFormText.vue';
import BaseFormTextarea from '@/components/BaseFormTextarea.vue';
import OrderList from '@/components/OrderList.vue';
import { API_BASE_URL } from '@/config';
import axios from 'axios';

export default {
  components: { BaseFormText, BaseFormTextarea, OrderList },
  data() {
    return {
      formData: {},
      formError: {},
      formErrorMessage: '',
    };
  },
  methods: {
    order() {
      this.formError = {};
      this.formErrorMessage = '';
      axios /* eslint-disable */
        .post(API_BASE_URL + '/api/orders', {
          ...this.formData,
        }, {
          params: {
            userAccessKey: this.$store.state.userAccessKey,
          },
        })
        .then(response => {
          this.$store.commit('resetCart');
          this.$store.commit('updateOrderInfo', response.data);
          this.$router.push({name: 'orderInfo', params: {id: response.data.id}});
        })
        .catch((error) => {
          this.formError = error.response.data.error.request || {};
          this.formErrorMessage = error.response.data.error.message;
        })
    },
  },
};
</script>
