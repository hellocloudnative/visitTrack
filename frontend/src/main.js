"use strict"

import Api from "./utils/api"
import { drawChart } from "./chart"
import { getToday, initDatePicker } from "./datepicker"

Vue.config.delimiters = ['[[', ']]']

new Vue({
  el: '#app',
  data: {
    hosts: [],
    pages: [],
    selectedUrl: "",
    selectedTitle: "",
    selectedHost: "",
    selectedType: "0",
    dates: [],
    counts: []
  },
  ready() {
    initDatePicker();
    drawChart(this.dates, this.counts);
    this.getHosts();
  },
  methods: {
    getHosts() {
      Api.get("/api/hosts", {}, (data) => {
        if (data != null) {
          this.hosts = data.data;
        }
      })
    },

    getPages() {
      console.log(this.selectedHost);
      Api.get("/api/pages", {host: this.selectedHost}, (data) => {
        if (data != null) {
          this.pages = data.data;
        }
      })
    },

    getRecords() {

      Api.get("/api/records", {
        date: $("#date_selected").val(),
        type: this.selectedType,
        url: this.selectedUrl
      }, (data) => {
        this.dates = [];
        this.counts = [];

        data.data.forEach((record)=>{
          this.dates.push(record.Date);
          this.counts.push(record.Count);
        })
        console.log(data);

        $("#detailModal").modal('show');
        drawChart(this.dates, this.counts);
      })
    },

    showDetail(page) {
      $("#date_selected").val(getToday())
      this.selectedUrl = page.Url;
      this.selectedTitle = page.Title;
      this.selectedType = "0";
      this.getRecords();
    },
  }
})
