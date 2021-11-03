<template>
 <div class="main w-full min-h-full  bg-black_bg-500 flex flex-col justify-center items-center">

<img src="@/assets/logo.svg" class="w-2/12 my-8" alt="">
 <div class="w-2/6  bg-black_fg-500 p-10 rounded-lg shadow-2xl text-white text-center flex flex-col">
    
    <p class=" border-b-2 border-dashed border-gray-500 pb-2">Almost there</p>
  
    <div class="form-control my-2 w-full">
      <label class="input-group w-full">
        <span class="bg-white "><luk_layer/></span> 
      <select class="select  w-full max-w-xs text-gray-600 font-light">
        <option disabled="disabled" selected="selected">Choose a Database</option> 
        <option>Test1</option> 
        <option>Test2</option> 
        <option>Test3</option>
      </select>
      </label>
    </div> 
    <p class="text-left text-sm my-2">Select Columns</p>
    <div style="height:40vh;" class=" shadow-inner overflow-y-auto pb-4 mb-2">
      <div class="form-control hover:bg-black_fg-600 rounded-lg" v-for="n in 12" :key="n">
        <label class="cursor-pointer label flex justify-start ">
          <input type="checkbox" checked="checked" class="checkbox checkbox-primary">
          <span class="label-text ml-2 text-gray-200">Users</span> 
        </label>
      </div>
    </div>
    <router-link to="/setup" class="btn btn-primary font-light text-white normal-case"><luk_setting_2 class="mx-2" /> Start Building</router-link>
 
 </div>
 

 </div>
</template>

<script lang="ts">
import { Options, Vue } from 'vue-class-component';
import {luk_layer,luk_flash_1,luk_setting_2}  from '@/assets/iconsax/index.js'; // @ is an alias to /src

@Options({
  components: {
    luk_layer,luk_flash_1,luk_setting_2
  },
})
export default class Home extends Vue {}
</script>
