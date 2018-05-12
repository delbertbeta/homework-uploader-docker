<template>
  <div id="app">
    <el-header>
      <el-menu :default-active="'1'" mode="horizontal">
        <el-menu-item index="1">Homework Uploader Management</el-menu-item>
      </el-menu>
    </el-header>
    <el-main>
      <el-form :inline="true" :model="addForm" >
        <el-form-item label="作业名称">
          <el-input v-model="addForm.name" placeholder="中期检查"></el-input>
        </el-form-item>
        <el-form-item label="是否允许上传多个文件">
          <el-select v-model="addForm.multifile" placeholder="请选择">
            <el-option label="否" value="0"></el-option>
            <el-option label="是" value="1"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="是否建立文件夹">
          <el-select v-model="addForm.createFolder" placeholder="请选择">
            <el-option label="否" value="0"></el-option>
            <el-option label="是" value="1"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="add">添加作业入口</el-button>
        </el-form-item>
      </el-form>
      <el-form :inline="true">
        <el-form-item label="请选中一项作业以管理">
          <el-select v-model="selectedInfo" placeholder="请选择">
            <el-option v-for="(infoItem, index) in info" :key="index" :label="infoItem.name" :value="index"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="toggle">{{finished ? '已完成' : '正在进行中'}}</el-button>
        </el-form-item>
      </el-form>
      <el-table
      :data="uploadedList">
        <el-table-column
          prop="name"
          label="姓名"
          width="180">
        </el-table-column>
      </el-table>
    </el-main>
  </div>
</template>

<script>
import ajax from "./ajax";
export default {
  name: "app",
  data() {
    return {
      addForm: {
        name: "",
        multifile: null,
        createFolder: null
      },
      info: [],
      selectedInfo: null
    };
  },
  computed: {
    uploadedList: function() {
      if (this.info[this.selectedInfo] === undefined) {
        return [];
      }
      return JSON.parse(this.info[this.selectedInfo].uploaded_list).map((v) => {
        return {
          name: v
        }
      });
    },
    finished: function() {
      if (this.info[this.selectedInfo] === undefined) {
        return false;
      }
      return this.info[this.selectedInfo].finished;
    }
  },
  methods: {
    add: function() {
      let data = {
        name: this.addForm.name,
        multifile: this.addForm.multifile === 0 ? false : true,
        createFolder: this.addForm.createFolder === 0 ? false : true
      };
      ajax.post(
        "/api/add_homework",
        data,
        true,
        function() {
          alert("成功!");
        },
        function() {
          alert("失败!");
        },
        false
      );
    },
    toggle: function() {
      ajax.get(
        "/api/toggle_finish_state",
        "id=" + this.info[this.selectedInfo].id,
        false,
        function() {
          alert("成功!");
        },
        function() {
          alert("失败!");
        },
        false
      );
    }
  },
  mounted: function() {
    let that = this;
    ajax.get(
      "/api/get_all_info",
      null,
      false,
      function(data) {
        that.info = JSON.parse(data);
      },
      function() {
        alert("失败!");
      },
      false
    );
  }
};
</script>

<style>

</style>
