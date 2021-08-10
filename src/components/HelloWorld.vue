<template>
  <div class="container">
    <div class="row justify-content-center mt-5">
      <div class="col-md-8 col-sm-12 text-start">
        <div class="row">
          <div class="col-md-2">
            <img src="@/assets/yeshiva-logo.png" width="100">
          </div>
          <div class="col-md-10">
            <h1>Real-Time Detection of Crashes in Time Series of Cryptocurrencies</h1>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
            <p> &nbsp; </p>
            <p class="quote">
              Investigators: Borja Gomez (Rever, Inc.), Pablo Roldan (Yeshiva University),
              Qian Zhou (Columbia University), and Han Zhang (Rutgers University)</p>
            <p><strong>Description:</strong></p>
            <p>
              The world’s history of economic crises, including the recent
              COVID-related downturn around March 2020, dramatically illustrates
              the need of efficient methods for real-time financial surveillance
              toward improved active risk management. In this project, we consider
              the problem of real-time detection of structural breaks in live-monitored
              time series of cryptocurrencies.
              <br><br>
              This problem will be approached using statistical time-series analysis.
              In particular, we will discuss Change-Point Detection methods, which
              try to identify times when the probability distribution of a stochastic
              process or time series changes. Our working assumption is that,
              whenever a financial crash happens, the underlying distribution of
              the observable time-series changes drastically. In general, the problem
              concerns both detecting whether a change has occurred (or possibly
              several changes) and identifying the time when they might have occurred.
              Of course, we would like to detect these structural breaks efficiently,
              i.e. as promptly as possible, and without raising many “false alarms”.
              <br><br>
              In the example below, we apply Change-Point Detection to a concrete
              financial time-series, namely the evolution of Bitcoin’s log-returns.
              The button generates a live graph of Bitcoin prices for the year to date,
              and indicates the location of the most recent change points in
              the time series, as determined by our real-time algorithm.
            </p>
            <p> &nbsp; </p>
            <div class="text-center">
              <button @click="loadCPD" type="button" class="btn btn-primary">Generate CPD</button>
              <p v-show="status == 'loading'">Generating CPD...</p>
              <p v-show="status == 'error'">Error</p>
              <p v-show="status == 'success'">Success!</p>
              <p> &nbsp; </p>
              <p class="border"><img :src="imageUrl" id="result" class="imageResult" /></p>
            </div>
            <p> &nbsp; </p>
            <p class="quote">
              Acknowledgements: This project is part of the Research Experience for Undergraduates (REU) event that took place at Yeshiva University during the summer of 2021 (see https://www.yu.edu/REU). P. Roldan and H. Zhang have been partially supported by NSF grant DMS-1814543.
            </p>
          </div>
        </div>
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
.quote {
  font-style: oblique;
}
</style>
