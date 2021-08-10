<template>
  <div class="container-fluid">
    <div class="row justify-content-center mt-5">
      <div class="col-md-8 col-sm-12">
        <h1>{{ msg }}</h1>
        <button @click="loadCPD" type="button">Generate CPD</button>
        <p v-show="status == 'loading'">Generating CPD...</p>
        <p v-show="status == 'error'">Error</p>
        <p v-show="status == 'success'">Success!</p>
        <p><img :src="imageUrl" id="result" class="imageResult" /></p>
      </div>
    </div>
  </div>
</template>

<script>

const spaceman = require('@/assets/spaceman.gif');

export default {
  name: 'HelloWorld',
  props: {
    msg: String,
  },
  data() {
    return {
      imageUrl: spaceman,
      status: 'idle',
      cpdid: null,
    };
  },
  methods: {
    loadCPD() {
      this.status = 'loading';
      fetch('https://cpdbackend-mifk57n6ra-uc.a.run.app/gencpd')
        .then((response) => {
          if (response.ok) {
            return response.json();
          }
          return false;
        })
        .then((data) => {
          this.status = 'success';
          this.cpdid = data.cpdid;
        })
        .catch(() => {
          this.status = 'error';
        });
    },
  },
  mounted() {
    setInterval(() => {
      if (this.cpdid !== null) {
        this.imageUrl = `https://storage.googleapis.com/cpd-images/${this.cpdid}.png`;
      } else {
        this.imageUrl = spaceman;
      }
    }, 500);
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
.imageResult {
  max-width:100%;
  max-height:100%;
}
</style>
