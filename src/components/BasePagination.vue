<!-- eslint-disable max-len -->
<template>
  <ul class="catalog__pagination pagination">
    <li class="pagination__item">
      <a class="pagination__link" href="#"
      aria-label="Предыдущая страница"
      :class="{'pagination__link--disabled': paginate === -1}"
      @click.prevent="previousPage(perPage)">
        <svg width="8" height="14" fill="currentColor">
          <use xlink:href="#icon-arrow-left"></use>
        </svg>
      </a>
    </li>
    <li class="pagination__item" v-for="pageNumber in pages" :key="pageNumber">
      <a href="#" class="pagination__link" :class="{'pagination__link--current': pageNumber === page}" @click.prevent="paginate(pageNumber)">
        {{ pageNumber }}
      </a>
    </li>
    <li class="pagination__item">
      <a class="pagination__link" href="#"
      aria-label="Следующая страница"
      :class="{'pagination__link--disabled': paginate === 1}"
      @click.prevent="nextPage(perPage)">
      <svg width="8" height="14" fill="currentColor">
          <use xlink:href="#icon-arrow-right"></use>
        </svg>
      </a>
    </li>
  </ul>
</template>

<script>
export default {
  model: {
    prop: 'page',
    event: 'paginate',
  },
  props: ['page', 'count', 'perPage'],
  computed: {
    pages() {
      return Math.ceil(this.count / this.perPage);
    },
  },
  methods: {
    paginate(page) {
      if (page >= 1 && page <= this.pages) {
        this.$emit('paginate', page);
      }
    },
    previousPage() {
      this.paginate(this.page - 1);
    },
    nextPage() {
      this.paginate(this.page + 1);
    },
  },
};
</script>
