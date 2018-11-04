#!/bin/sh
create_namespace 'master'

alter_namespace 'master', {METHOD=>'set', 'Property1'=>'Value1'}
alter_namespace 'master', {METHOD=>'set', 'Property2'=>'Value2'}

describe_namespace 'master'

alter_namespace 'master', {METHOD=>'unset', NAME=>'Property2'}

describe_namespace 'master'

list_namespace

exit