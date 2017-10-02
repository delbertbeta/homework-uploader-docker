<template>
  <div id="app">
    <div>
      <label for="name">name</label><input name="name" v-model="addForm.name" />
      <label for="multifile">multifile</label>
      <select name="multifile" v-model="addForm.multifile">
        <option value="0">false</option>
        <option value="1">true</option>
      </select>
      <label for="createFolder">createFolder</label>
      <select name="createFolder" v-model="addForm.createFolder">
        <option value="0">false</option>
        <option value="1">true</option>
      </select>
      <button @click="add">Add</button>
    </div>
    <div>
      <label for="homework">homework</label>
      <select name="homework" v-model="selectedInfo">
        <option v-for="(infoItem, index) in info" :key="index" :value="index">{{ infoItem.name }}</option>
      </select>
      <button @click="toggle">Toggle</button><label for="state">finished:</label><label name="state">{{info[selectedInfo].finished}}</label>
      <div>
        <ul>
          <li v-for="name in uploadedList" :key="name">{{ name }}</li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
import ajax from './ajax';
export default {
  name: 'app',
  data() {
    return {
      addForm: {
        name: '',
        multifile: 0,
        createFolder: 0
      },
      info: [],
      selectedInfo: 0,
    }
  },
  computed: {
    uploadedList: function() {
      if (this.info[this.selectedInfo] === undefined) {
        return [];
      }
      return JSON.parse(this.info[this.selectedInfo].uploaded_list);
    }
  },
  methods: {
    add: function() {
      let data = {
        name: this.addForm.name,
        multifile: this.addForm.multifile === 0 ? false : true,
        createFolder: this.addForm.createFolder === 0 ? false : true,
      }
      ajax.post('/api/add_homework', data, true, function() {
        alert('成功!');
      }, function() {
        alert('失败!');
      }, false);
    },
    toggle: function() {
      ajax.get('/api/toggle_finish_state', 'id=' + this.info[this.selectedInfo].id, false, function() {
        alert('成功!');
      }, function() {
        alert('失败!');
      }, false);
    }
  },
  mounted: function() {
    let that = this;
    ajax.get('/api/get_all_info', null, false, function(data) {
      that.info = JSON.parse(data);
    }, function() {
      alert('失败!');
    }, false)
  }
}
</script>

<style scoped>

</style>
