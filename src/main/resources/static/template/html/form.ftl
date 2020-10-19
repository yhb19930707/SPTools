<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head th:replace="common/head :: head(links)"/>
<body>
<div class="ok-body" id="app" v-cloak>
    <template>
        <i-form ref="checkForm" :model="${function}" :rules="ruleValidate" :label-width="100">
            <#list list as entity>
            <#if entity.entityColumnName != "gmtCreate"&&
                 entity.entityColumnName != "gmtModified"&&
                 entity.entityColumnName != "${function}Id">
             <form-item prop="${entity.entityColumnName}" label="${entity.columnComment}：">
                 <i-input maxlength="20" v-model="${function}.${entity.entityColumnName}" placeholder="请输入${entity.columnComment}"></i-input>
             </form-item>
            </#if>
            </#list>
        </i-form>
    </template>
</div>
<div th:replace="common/foot :: foot(script)"></div>
<script th:inline="none">
var vm = new Vue({
    el: '#app',
    data:{
        ${function}:{},
        ruleValidate : {
        <#list list as entity>
            <#if entity.entityColumnName != "gmtCreate"&&
                 entity.entityColumnName != "gmtModified"&&
                 entity.entityColumnName != "${function}Id">
                 ${entity.entityColumnName}: [
                    { required: true, message: '${entity.columnComment}不能为空', trigger: 'blur' }
                 ],
            </#if>
        </#list>
		}
    },
    methods: {
        acceptClick : function(dialog){
          vm.$refs.checkForm.validate(function(valid){
            if (valid) {
                layui.use(["okUtils", "okLayer"], function () {
                     okUtils = layui.okUtils;
                     okLayer = layui.okLayer;
                     okUtils.ajaxCloud({
                        url:"/${prefix}/${function}/save",
                        param : vm.${function},
                        json:true,
                        success : function(result) {
                             okLayer.msg.greenTick(result.msg, function () {
                                  dialog.load();
                             })
                        }
                    });
                });
            }
          });
	    }
    },
    created: function() {

    }
});
</script>
</body>
</html>
