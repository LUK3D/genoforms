<template lang="">
    <div class="w-full h-full flex flex-col overflow-hidden">
        <div class="flex justify-between items-center   w-full h-12 border-b-2 border-black_bg-600">
            <div class="flex items-center h-full">
                <img class="h-3/4 px-2 border-r-2 border-black_bg-600" src="@/assets/logo-min.svg" />
                <div class="btns w-full flex ">
                    <button class="btn btn-sm btn-ghost text-white"> <luk_menu /> </button>
                </div>
            </div>
            <div class="midle flex items-center justify-center normal-case h-full">

                    <button @click="onList = true" :class="`btn btn-sm btn-ghost text-white normal-case font-light  border-0 h-full hover:border-primary-700 hover:border-b-4  ${onList?'border-primary-500 border-b-4 ':''} rounded-none`"> <luk_row_vertical class="mx-1" /> List </button>
                    <button @click="onList = false" :class="`btn btn-sm btn-ghost text-white normal-case font-light border-0 h-full hover:border-primary-700 hover:border-b-4 rounded-none ${!onList?'border-primary-500 border-b-4 ':''}`"> <luk_add_square class="mx-1" /> Add </button>
                    
            </div>
            <div class="flex items-center justify-end">
                <div class="m-6 indicator">
                    <div class="indicator-item badge bg-primary-500 mt-1">+2</div> 
                    <button class="btn btn-sm p-0 btn-ghost text-white normal-case font-light rounded-none"> <luk_notification class="mx-1" /></button>
                </div>
                
                <div class="avatar">
                    <div class=" rounded-full w-10 h-10">
                        <img src="http://daisyui.com/tailwind-css-component-profile-1@94w.png">
                    </div>
                </div> 
            </div>
        </div>
        <div class="body flex h-full w-full bg-gray-100 ">
            <div class="side-menu flex flex-col w-14 h-full bg border-r-2 bg-black_bg-500 border-black_bg-600 ">
                <button class="btn btn-sm btn-ghost text-white normal-case font-light rounded-none border-b border-black_bg-700 py-2 max-h-full h-auto"> <luk_note class="mx-1" /></button>
                <button class="btn btn-sm btn-ghost text-white normal-case font-light rounded-none border-b border-black_bg-700 py-2 max-h-full h-auto"> <luk_document_code class="mx-1" /></button>
            </div>
            <div class="flex flex-col pages-list w-1/6 h-full ">
                <div class="btn-group w-full flex ">
                    <input  type="radio" name="options" id="option1" data-title="Pages" checked class="btn w-3/6 bg-white text-gray-500 font-light normal-case rounded-none border-0 border-b-2 border-opacity-5"> 
                    <input  type="radio" name="options" id="option2" data-title="Components"  class="btn w-3/6 bg-white text-gray-500 font-light normal-case rounded-none border-0 border-b-2 border-opacity-5"> 
                </div>
                <div class="w-full h-full overflow-y-auto pb-16 bg-white  border-r-2 ">
                    <button v-for="(item, index) in 20" :key="index" class="btn w-full border-0 border-b  border-black_bg-100 btn-ghost text-black_bg-500 normal-case font-light rounded-none  text-left flex justify-start"> <luk_document class="mx-1" /> <p>Page Name {{index}}</p></button>
                <div/>
            </div>
           
        </div>
         <div class=" flex justify-center items-center w-full h-full bg-gray-100 dots " >
             <div v-if="onList"  class="shadow-2xl flex flex-col page w-5/6 h-full overflow-y-auto bg-white p-10">
                <h1 class="text-4xl mb-8">Teste de listagem</h1>
                
                <div class="flex flex-col text-left">
                    <div class="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
                        <div class="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
                        <div
                            class="
                            shadow
                            overflow-hidden
                            border-b border-gray-200
                            sm:rounded-lg
                            "
                        >
                            <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                <th
                                    scope="col"
                                    class="
                                    px-6
                                    py-3
                                    text-left text-xs
                                    font-medium
                                    text-gray-500
                                    uppercase
                                    tracking-wider
                                    "
                                >
                                    Name
                                </th>
                                <th
                                    scope="col"
                                    class="
                                    px-6
                                    py-3
                                    text-left text-xs
                                    font-medium
                                    text-gray-500
                                    uppercase
                                    tracking-wider
                                    "
                                >
                                    Title
                                </th>
                                <th
                                    scope="col"
                                    class="
                                    px-6
                                    py-3
                                    text-left text-xs
                                    font-medium
                                    text-gray-500
                                    uppercase
                                    tracking-wider
                                    "
                                >
                                    Status
                                </th>
                                <th
                                    scope="col"
                                    class="
                                    px-6
                                    py-3
                                    text-left text-xs
                                    font-medium
                                    text-gray-500
                                    uppercase
                                    tracking-wider
                                    "
                                >
                                    Role
                                </th>
                                <th scope="col" class="relative px-6 py-3">
                                    <span class="sr-only">Edit</span>
                                </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <tr>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="flex items-center">
                                    <div class="flex-shrink-0 h-10 w-10">
                                        <img
                                        class="h-10 w-10 rounded-full"
                                        src="https://images.unsplash.com/photo-1619914775389-748e5e136c26?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=100&ixid=MnwxfDB8MXxyYW5kb218fHx8fHx8fHwxNjIwMTk4MjAw&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=100"
                                        alt=""
                                        />
                                    </div>
                                    <div class="ml-4">
                                        <div class="text-sm font-medium text-gray-900">
                                        Flora Wu
                                        </div>
                                        <div class="text-sm text-gray-500">
                                        flora.wu@example.com
                                        </div>
                                    </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">Software engineer</div>
                                    <div class="text-sm text-gray-500">IT</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span
                                    class="
                                        px-2
                                        inline-flex
                                        text-xs
                                        leading-5
                                        font-semibold
                                        rounded-full
                                        bg-green-100
                                        text-green-800
                                    "
                                    >
                                    Active
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    Admin
                                </td>
                                <td
                                    class="
                                    px-6
                                    py-4
                                    whitespace-nowrap
                                    text-right text-sm
                                    font-medium
                                    "
                                >
                                    <a href="#" class="text-indigo-600 hover:text-indigo-900"
                                    >Edit</a
                                    >
                                </td>
                                </tr>
                                <tr>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="flex items-center">
                                    <div class="flex-shrink-0 h-10 w-10">
                                        <img
                                        class="h-10 w-10 rounded-full"
                                        src="https://images.unsplash.com/photo-1620037624682-f9c156d0286f?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=100&ixid=MnwxfDB8MXxyYW5kb218fHx8fHx8fHwxNjIwMTk4Mzc2&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=100"
                                        alt=""
                                        />
                                    </div>
                                    <div class="ml-4">
                                        <div class="text-sm font-medium text-gray-900">
                                        Nida Povey
                                        </div>
                                        <div class="text-sm text-gray-500">
                                        nida.povey@example.com
                                        </div>
                                    </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">CMO</div>
                                    <div class="text-sm text-gray-500">Marketing</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span
                                    class="
                                        px-2
                                        inline-flex
                                        text-xs
                                        leading-5
                                        font-semibold
                                        rounded-full
                                        bg-green-100
                                        text-green-800
                                    "
                                    >
                                    Active
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    Member
                                </td>
                                <td
                                    class="
                                    px-6
                                    py-4
                                    whitespace-nowrap
                                    text-right text-sm
                                    font-medium
                                    "
                                >
                                    <a href="#" class="text-indigo-600 hover:text-indigo-900"
                                    >Edit</a
                                    >
                                </td>
                                </tr>
                                <tr>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="flex items-center">
                                    <div class="flex-shrink-0 h-10 w-10">
                                        <img
                                        class="h-10 w-10 rounded-full"
                                        src="https://images.unsplash.com/photo-1619961602105-16fa2a5465c2?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=100&ixid=MnwxfDB8MXxyYW5kb218fHx8fHx8fHwxNjIwMTk4NDAw&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=100"
                                        alt=""
                                        />
                                    </div>
                                    <div class="ml-4">
                                        <div class="text-sm font-medium text-gray-900">
                                        Warren Nixon
                                        </div>
                                        <div class="text-sm text-gray-500">
                                        warren.nixon@example.com
                                        </div>
                                    </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">Designer</div>
                                    <div class="text-sm text-gray-500">UI/UX</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span
                                    class="
                                        px-2
                                        inline-flex
                                        text-xs
                                        leading-5
                                        font-semibold
                                        rounded-full
                                        bg-green-100
                                        text-green-800
                                    "
                                    >
                                    Active
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    Owner
                                </td>
                                <td
                                    class="
                                    px-6
                                    py-4
                                    whitespace-nowrap
                                    text-right text-sm
                                    font-medium
                                    "
                                >
                                    <a href="#" class="text-indigo-600 hover:text-indigo-900"
                                    >Edit</a
                                    >
                                </td>
                                </tr>

                                <!-- More people... -->
                            </tbody>
                            </table>
                        </div>
                        </div>
                    </div>
                    </div>
             </div>
            <div v-else  class="shadow-2xl flex flex-col page w-5/6 h-full overflow-y-auto bg-white p-10">

             <!-- Required form plugin -->
                <link
                href="https://cdn.jsdelivr.net/npm/@tailwindcss/custom-forms@0.2.1/dist/custom-forms.css"
                rel="stylesheet"
                />

                <div class="p-4 shadow-md rounded-md text-left" style="max-width: 400px">
                <label class="block">
                    <span class="text-gray-700">Name</span>
                    <input class="form-input mt-1 block w-full" placeholder="Jane Doe" />
                </label>

                <div class="mt-4">
                    <span class="text-gray-700">Account Type</span>
                    <div class="mt-2">
                    <label class="inline-flex items-center">
                        <input
                        type="radio"
                        class="form-radio"
                        name="accountType"
                        value="personal"
                        />
                        <span class="ml-2">Personal</span>
                    </label>
                    <label class="inline-flex items-center ml-6">
                        <input
                        type="radio"
                        class="form-radio"
                        name="accountType"
                        value="busines"
                        />
                        <span class="ml-2">Business</span>
                    </label>
                    </div>
                </div>

                <label class="block mt-4">
                    <span class="text-gray-700">Requested Limit</span>
                    <select class="form-select mt-1 block w-full">
                    <option>$1,000</option>
                    <option>$5,000</option>
                    <option>$10,000</option>
                    <option>$25,000</option>
                    </select>
                </label>

                <div class="flex mt-6">
                    <label class="flex items-center">
                    <input type="checkbox" class="form-checkbox" />
                    <span class="ml-2"
                        >I agree to the <span class="underline">privacy policy</span></span
                    >
                    </label>
                </div>
                </div>
             </div>
        </div>
    </div>
</div>
</template>
<script lang="ts">
import { Options, Vue } from "vue-class-component";
import {
  luk_menu,
  luk_grid_1,
  luk_row_vertical,
  luk_add_square,
  luk_notification,
  luk_note,
  luk_document,
  luk_document_code,
} from "@/assets/iconsax/index.js"; // @ is an alias to /src

@Options({
  components: {
    luk_menu,
    luk_grid_1,
    luk_row_vertical,
    luk_add_square,
    luk_notification,
    luk_note,
    luk_document,
    luk_document_code,
  },
  data() {
    return {
      onList: true,
    };
  },
})
export default class Editor extends Vue {}
</script>
<style lang="scss">
.dots {
  background-image: url(../assets/dots.svg);
  background-size: 10px;
}
</style>