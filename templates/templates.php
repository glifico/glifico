<?php
echo('<!-- custom templates -->
    <script type="text/ng-template" id="ui-select-single.html">
      <ui-select data-ng-model="model[options.key]" data-required="{{to.required}}" data-disabled="{{to.disabled}}" theme="bootstrap">
        <ui-select-match placeholder="{{to.placeholder}}" data-allow-clear="true">{{$select.selected}}</ui-select-match>
        <ui-select-choices data-repeat="option as option in to.options | filter: $select.search">
          <div ng-bind-html="option | highlight: $select.search"></div>
        </ui-select-choices>
      </ui-select>
    </script>
    <script type="text/ng-template" id="ui-select-multiple.html">
      <ui-select multiple data-ng-model="model[options.key]" data-required="{{to.required}}" data-disabled="{{to.disabled}}" theme="bootstrap">
        <ui-select-match placeholder="{{to.placeholder}}">{{$item}}</ui-select-match>
        <ui-select-choices data-repeat="option as option in to.options | filter: $select.search">
          <div ng-bind-html="option | highlight: $select.search"></div>
        </ui-select-choices>
      </ui-select>
    </script>
	<script type="text/ng-template" id="ui-tagging.html">
		<ui-select multiple tagging="tagTransform" tagging-label="(nuovo)" data-ng-model="model[options.key]" data-required="{{to.required}}" data-disabled="{{to.disabled}}" theme="bootstrap" sortable="true">
		<ui-select-match placeholder="{{to.placeholder}}">{{$item}}</ui-select-match>
		<ui-select-choices data-repeat="option in to.options | filter: $select.search">
          <div ng-bind-html="option | highlight: $select.search"></div>
        </ui-select-choices>
		</ui-select>
	</script>
	<script type="text/ng-template" id="ui-tagging-single.html">
		<ui-select tagging tagging-label="(nuovo)" data-ng-model="model[options.key]" data-required="{{to.required}}" data-disabled="{{to.disabled}}" theme="bootstrap" sortable="true">
		<ui-select-match placeholder="{{to.placeholder}}">{{$item}}</ui-select-match>
		<ui-select-choices data-repeat="option in to.options | filter: $select.search">
		<div ng-bind-html="option | highlight: $select.search"></div>
        </ui-select-choices>
		</ui-select>
	</script>

<!-- end of templates -->');
?>
