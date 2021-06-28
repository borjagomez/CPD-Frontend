<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <button @click="loadCPD" type="button">Generate CPD</button>
    <p v-show="status == 'loading'">Generating CPD...</p>
    <p v-show="status == 'error'">Error</p>
    <p v-show="status == 'success'">Success!</p>
    <p><img :src="imageUrl" id="result"></p>
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
      imageUrl: 'https://cdn.dribbble.com/users/144388/screenshots/1364170/spaceman.gif',
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
          this.imageUrl = `https://storage.googleapis.com/cpd-images/${data.cpdid}.png`;
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
