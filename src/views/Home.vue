<template>
 <div class="main w-full min-h-full  bg-black_bg-500 flex flex-col justify-center items-center">

<img src="@/assets/logo.svg" class="w-2/12 my-8" alt="">
 <div class="w-2/6  bg-black_fg-500 p-10 rounded-lg shadow-2xl text-white text-center flex flex-col">
    
    <p class=" border-b-2 border-dashed border-gray-500 pb-2">Connect to server to get started</p>
    <p class="  mt-5 mb-2">Select your Workspace</p>

    <div class="flex justify-between items-center mb-4">
        <div class="btn-group w-full flex">
          <input type="radio" name="options" id="option1" data-title="MySQL" checked class="btn w-2/6 bg-white text-gray-500 font-light normal-case"> 
          <input type="radio" name="options" id="option2" data-title="MsSQL"  class="btn w-2/6 bg-white text-gray-500 font-light normal-case"> 
          <input type="radio" name="options" id="option3" data-title="MongoDB" class="btn w-2/6 bg-white text-gray-500 font-light normal-case"> 
        </div>
    </div>

    <div class="form-control my-2 w-full">
      <label class="input-group w-full">
        <span class="bg-white "><luk_box_1/></span> 
        <input type="text" placeholder="host" class="input  w-full text-gray-600">
      </label>
    </div> 
    <div class="form-control my-2 w-full">
      <label class="input-group w-full">
        <span class="bg-white "><luk_profile/></span> 
        <input type="text" placeholder="user" class="input  w-full text-gray-600">
      </label>
    </div> 
    <div class="form-control my-2 w-full">
      <label class="input-group w-full">
        <span class="bg-white "><luk_key_square/></span> 
        <input type="password" placeholder="password" class="input  w-full text-gray-600">
      </label>
    </div> 
        <p class="  mt-5 mb-2">By clicking on connect, you agree with our terms of use and privacy politics. </p>
    <router-link to="/setup" class="btn btn-primary font-light text-white"><luk_flash_1 class="mx-1" /> Connect</router-link>
 
 </div>
 

 </div>
</template>

<script lang="ts">
import { Options, Vue } from 'vue-class-component';
import {luk_backward_item,luk_box_1,luk_profile,luk_key_square,luk_flash_1}  from '@/assets/iconsax/index.js'; // @ is an alias to /src

@Options({
  components: {
    luk_backward_item, luk_box_1, luk_profile,luk_key_square,luk_flash_1,
  },
})
export default class Home extends Vue {}
</script>
