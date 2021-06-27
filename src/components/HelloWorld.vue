<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <button v-on:click="loadCPD" type="button">Generate CPD</button>
    <p v-show="status == 'loading'">Generating CPD...</p>
    <p v-show="status == 'error'">Error</p>
    <p v-show="status == 'success'">Success!</p>
    <img v-bind:src="image" id="result" v-show="image != null">
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  props: {
    msg: String,
  },
  data() {
    return {
      image: null,
      status: 'idle',
    };
  },
  methods: {
    loadCPD() {
      this.status = 'loading';
      fetch('https://cpdbackend-mifk57n6ra-uc.a.run.app/gencpd')
      // fetch('http://localhost:3000/gencpd')
        .then((response) => {
          if (response.ok) {
            return response.json();
          } return false;
        })
        .then((data) => {
          this.status = 'success';
          setTimeout(() => {
            this.image = `https://storage.cloud.google.com/cpd-images/${data.cpdid}.png`;
          }, 500);
        })
        .catch(() => {
          this.status = 'error';
        });
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
