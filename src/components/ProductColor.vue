<!-- eslint-disable max-len -->
<template>
  <ul class="colors">
    <li class="colors__item" :value="color" v-for="color in colors" :key="color.id">
      <label class="colors__label" :for="color.id">
        <input class="colors__radio sr-only" type="radio" name="color" :value="color.id" v-model="currentColor" :id="color.id" @input="onInput">
        <span class="colors__value" :style="`background-color: ${color.code}`">
        </span>
      </label>
    </li>
  </ul>
</template>

<script>

export default {
  props: ['colors'],
  data() {
    return {
      currentColor: null,
    };
  },
  methods: {
    onInput(evt) {
      this.$emit('update:color', evt.target.value);
    },
  },
  computed: {
  },
};
</script>
