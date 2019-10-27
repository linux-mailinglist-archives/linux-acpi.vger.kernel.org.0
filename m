Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B50ECE6576
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Oct 2019 21:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfJ0U6M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 27 Oct 2019 16:58:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:31908 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbfJ0U6M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 27 Oct 2019 16:58:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2019 13:58:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,237,1569308400"; 
   d="gz'50?scan'50,208,50";a="197923110"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Oct 2019 13:58:07 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iOpby-0002a1-VS; Mon, 28 Oct 2019 04:58:06 +0800
Date:   Mon, 28 Oct 2019 04:57:16 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Erik Schmauss <erik.schmauss@intel.com>
Cc:     kbuild-all@lists.01.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Erik Schmauss <erik.schmauss@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: Re: [PATCH 07/12] ACPICA: Debugger: add command to dump all fields
 of a particular subtype
Message-ID: <201910280412.M9onP4G5%lkp@intel.com>
References: <20191024185556.4606-8-erik.schmauss@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="guaa7rhzg2cz3jss"
Content-Disposition: inline
In-Reply-To: <20191024185556.4606-8-erik.schmauss@intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--guaa7rhzg2cz3jss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Erik,

I love your patch! Perhaps something to improve:

[auto build test WARNING on pm/linux-next]
[also build test WARNING on v5.4-rc5 next-20191025]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Erik-Schmauss/ACPICA-version-20191018/20191028-014314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-randconfig-e001-201943 (attached as .config)
compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/acpi/acpica/dbnames.c: In function 'acpi_db_walk_for_fields':
   drivers/acpi/acpica/dbnames.c:523:2: error: unknown type name 'ACPI_REGION_WALK_INFO'; did you mean 'ACPI_COMMON_FIELD_INFO'?
     ACPI_REGION_WALK_INFO *info = (ACPI_REGION_WALK_INFO *) context;
     ^~~~~~~~~~~~~~~~~~~~~
     ACPI_COMMON_FIELD_INFO
   drivers/acpi/acpica/dbnames.c:523:33: error: 'ACPI_REGION_WALK_INFO' undeclared (first use in this function); did you mean 'ACPI_COMMON_FIELD_INFO'?
     ACPI_REGION_WALK_INFO *info = (ACPI_REGION_WALK_INFO *) context;
                                    ^~~~~~~~~~~~~~~~~~~~~
                                    ACPI_COMMON_FIELD_INFO
   drivers/acpi/acpica/dbnames.c:523:33: note: each undeclared identifier is reported only once for each function it appears in
   drivers/acpi/acpica/dbnames.c:523:56: error: expected expression before ')' token
     ACPI_REGION_WALK_INFO *info = (ACPI_REGION_WALK_INFO *) context;
                                                           ^
   In file included from include/linux/string.h:6:0,
                    from include/acpi/platform/aclinux.h:52,
                    from include/acpi/platform/acenv.h:152,
                    from include/acpi/acpi.h:22,
                    from drivers/acpi/acpica/dbnames.c:8:
   drivers/acpi/acpica/dbnames.c:532:10: error: request for member 'address_space_id' in something not a structure or union
         info->address_space_id) {
             ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> drivers/acpi/acpica/dbnames.c:531:2: note: in expansion of macro 'if'
     if (node->object->field.region_obj->region.space_id !=
     ^~
   drivers/acpi/acpica/dbnames.c:532:10: error: request for member 'address_space_id' in something not a structure or union
         info->address_space_id) {
             ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                ^~~~
>> drivers/acpi/acpica/dbnames.c:531:2: note: in expansion of macro 'if'
     if (node->object->field.region_obj->region.space_id !=
     ^~
   drivers/acpi/acpica/dbnames.c:532:10: error: request for member 'address_space_id' in something not a structure or union
         info->address_space_id) {
             ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
>> drivers/acpi/acpica/dbnames.c:531:2: note: in expansion of macro 'if'
     if (node->object->field.region_obj->region.space_id !=
     ^~
   drivers/acpi/acpica/dbnames.c:536:6: error: request for member 'count' in something not a structure or union
     info->count++;
         ^~
   drivers/acpi/acpica/dbnames.c: In function 'acpi_db_display_fields':
   drivers/acpi/acpica/dbnames.c:721:2: error: unknown type name 'ACPI_REGION_WALK_INFO'; did you mean 'ACPI_COMMON_FIELD_INFO'?
     ACPI_REGION_WALK_INFO info;
     ^~~~~~~~~~~~~~~~~~~~~
     ACPI_COMMON_FIELD_INFO
   drivers/acpi/acpica/dbnames.c:723:6: error: request for member 'count' in something not a structure or union
     info.count = 0;
         ^
   drivers/acpi/acpica/dbnames.c:724:6: error: request for member 'owner_id' in something not a structure or union
     info.owner_id = ACPI_OWNER_ID_MAX;
         ^
   drivers/acpi/acpica/dbnames.c:725:6: error: request for member 'debug_level' in something not a structure or union
     info.debug_level = ACPI_UINT32_MAX;
         ^
   drivers/acpi/acpica/dbnames.c:726:6: error: request for member 'display_type' in something not a structure or union
     info.display_type = ACPI_DISPLAY_SUMMARY | ACPI_DISPLAY_SHORT;
         ^
   drivers/acpi/acpica/dbnames.c:727:6: error: request for member 'address_space_id' in something not a structure or union
     info.address_space_id = address_space_id;
         ^

vim +/if +531 drivers/acpi/acpica/dbnames.c

   505	
   506	/*******************************************************************************
   507	 *
   508	 * FUNCTION:    acpi_db_walk_for_fields
   509	 *
   510	 * PARAMETERS:  Callback from walk_namespace
   511	 *
   512	 * RETURN:      Status
   513	 *
   514	 * DESCRIPTION: Display short info about objects in the namespace
   515	 *
   516	 ******************************************************************************/
   517	
   518	static acpi_status
   519	acpi_db_walk_for_fields(acpi_handle obj_handle,
   520				u32 nesting_level, void *context, void **return_value)
   521	{
   522		union acpi_object *ret_value;
   523		ACPI_REGION_WALK_INFO *info = (ACPI_REGION_WALK_INFO *) context;
   524		struct acpi_buffer buffer;
   525		acpi_status status;
   526		struct acpi_namespace_node *node = acpi_ns_validate_handle(obj_handle);
   527	
   528		if (!node) {
   529			return (AE_OK);
   530		}
 > 531		if (node->object->field.region_obj->region.space_id !=
   532		    info->address_space_id) {
   533			return (AE_OK);
   534		}
   535	
   536		info->count++;
   537	
   538		/* Get and display the full pathname to this object */
   539	
   540		buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
   541		status = acpi_ns_handle_to_pathname(obj_handle, &buffer, TRUE);
   542		if (ACPI_FAILURE(status)) {
   543			acpi_os_printf("Could Not get pathname for object %p\n",
   544				       obj_handle);
   545			return (AE_OK);
   546		}
   547	
   548		acpi_os_printf("%s ", (char *)buffer.pointer);
   549		ACPI_FREE(buffer.pointer);
   550	
   551		buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
   552		acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
   553	
   554		ret_value = (union acpi_object *)buffer.pointer;
   555		switch (ret_value->type) {
   556		case ACPI_TYPE_INTEGER:
   557	
   558			acpi_os_printf("%8.8X%8.8X",
   559				       ACPI_FORMAT_UINT64(ret_value->integer.value));
   560			break;
   561	
   562		case ACPI_TYPE_BUFFER:
   563	
   564			acpi_ut_dump_buffer(ret_value->buffer.pointer,
   565					    ret_value->buffer.length,
   566					    DB_DISPLAY_DATA_ONLY | DB_BYTE_DISPLAY, 0);
   567			break;
   568	
   569		default:
   570	
   571			break;
   572		}
   573	
   574		acpi_os_printf("\n");
   575	
   576		ACPI_FREE(buffer.pointer);
   577		return (AE_OK);
   578	}
   579	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--guaa7rhzg2cz3jss
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICNMBtl0AAy5jb25maWcAlDzbcuO2ku/5CtXkJalTSXwbZXa3/ACCIIWIJDgAKFl+YTke
zRxXfJmV5ZPM3283wAsAgkr21KmJiW40bn1HQ99/9/2CvB1fnu6OD/d3j4/fFl/2z/vD3XH/
afH54XH/P4tULCqhFyzl+mdALh6e3/765eHyw3Lx/uern89+OtxfLdb7w/P+cUFfnj8/fHmD
3g8vz999/x38/3tofPoKhA7/vfhyf//Tr4sf0v3vD3fPi19N7/OrH+1fgEtFlfG8pbTlqs0p
vf7WN8FHu2FScVFd/3p2dXY24BakygfQmUOCkqoteLUeiUDjiqiWqLLNhRZRAK+gD5uAtkRW
bUl2CWubildcc1LwW5Z6iClXJCnYP0Dm8mO7FdKZW9LwItW8ZC270YaKElKPcL2SjKQwvUzA
P60mCjub/c3NeT0uXvfHt6/jLiZSrFnViqpVZe0MDfNpWbVpicxhf0qury8v8JS6ZYiy5jC6
ZkovHl4Xzy9HJNz3XsEkmDTQkeSayYoVcVghKCn643n3LtbcksY9DLMTrSKFdvBXZMP6cfJb
7qzHhSQAuYiDituSxCE3t3M9xBzgCgDDjjmzcjcshJu5nULAGZ6C39xGzsOb65TiVaRLyjLS
FLpdCaUrUrLrdz88vzzvfxz2Wu3UhteO8HUN+F+qC3egWih+05YfG9awyFBUCqXakpVC7lqi
NaErt3ejWMGT6JpJA9omxn94DkTSlcXAGZGi6CUBxGrx+vb767fX4/5plIScVUxyaqSuliJx
xNsFqZXYxiF05XIctqSiJLzy2xQvY0jtijOJU97FiZdES9hEWAbIhBYyjiWZYnJDNMpLKVLm
j5QJSVnaKQle5c7Z1UQqhkjuzruUU5Y0eab8Y9g/f1q8fA42dNS5gq6VaGBM0HWarlLhjGhO
x0VJiSYnwKiQHDXqQDagNqEzawuidEt3tIicnNGZm5ERArChxzas0uokENUlSSlxdVcMrYQD
JelvTRSvFKptapxyz5H64Wl/eI0xpeZ0DcqZAdc5pCrRrm5RCZeicg8MGmsYQ6ScRqTC9uKp
2Z+hj2mNSteK5yvkKLN5Mn70k5k7Ui8ZK2sNA1Qxqe/BG1E0lSZy52kMCzzRjQro1e8frZtf
9N3rH4sjTGdxB1N7Pd4dXxd39/cvb8/Hh+cvwY5Ch5ZQQ8PKwTAy8rphlhEc3ZxEpaglKAPV
Bag6ioT2V2miVWwhio8HCh+Dxu38g9TMqtvmf7BAsxGSNgsV46Jq1wJsHBA+wIUAZnG4SnkY
pk/QhMvp6AxT84cc1M3a/uEooPVwgoJ6O762LkFskwqBlj4DpcszfX1xNnIBr/QazH/GApzz
S88INJXq/CS6AtVnZLTnGnX/7/2nN3A5F5/3d8e3w/7VNHfrikA95bQllW4T1GtAt6lKUre6
SNqsaNTKUVS5FE2t3PWCoaN5zAwaVDvRkUBGuGyjEJqBOiJVuuWp9gym1G6H+ZFqnnoT65pl
OuNhdPAMJPCWyXm6KdtwyiKUgYtDUQlmxGQW6WdsT6SXEijKHY41H6NaA58FrBrIZ3wtK0bX
tQAuQg0H9jSmoizPoN9pxnDJgyWB7U8ZqCMwx9FdlqwgjjFPijXujDFk0nXy8ZuUQM3aM8ed
lWnvxY5nm05dxBHUua8udtQfNKiO32q+PXcV4hRRgx6EgATdBnMyQpakolEPLsBW8IfnGFqH
0BNMnp4vQxxQSZTVxnuBPaEs6FNTVa9hLgXROBlnb+ts/AjVWjBSCTqWg0/peFAqZ7oE3dZO
/AN7zGOze/443w4S2ZJsBaLpeiLWCbam1Gk1iiz8bqvSMQ7A/A7CZA9Gk0TAhcua+HQazW4c
rYKfoACcXauFt3CeV6TIHD41M89Sd0Dj7GQx3lcr0HIuKuEigsZF20jPESXphsMqun0N9WZC
pORR1bNG7F3p7Gzf0noHOrSazUIR1Xzj6SrgpdixuuGINIY6unBjGjAVMM4WqFXg9YGK8URT
sY9R+tCPpWlUo1ghgOHb0FU1jTCzdlOaCMHzpej5mRfhGSvXpWLq/eHzy+Hp7vl+v2D/2T+D
T0HA/lH0KsCxG12I6LBGMccH76zoPxymJ7gp7RjWvfMkBVMOBCyuSYeMcliQeGioiiaJMWYh
EofLoTeclMxZ7315tFdNloHrUBOAD4FXjOhOaVYaE4Q5Jp5xakIwV6xFxguP042CMxZIuRvm
p2l65JsPy/bSyVmYSK5Nd2DlIKLIAmUJ2K59UVo21CjVlFEICh3NJxpdN7o1ql1fv9s/fr68
+AmTdu88hobN6dy5d3eH+3//8teH5S/3Jon3alJ87af9Z/vtpm7WYB5b1dS1l6ICf4yuzYSn
sLJ0vE0zcol+lazA6nEbVl1/OAUnN9fnyzhCzz9/Q8dD88gN0bAibeqmiXqAp6ctVbLrLVeb
pXTaBbQMTyQGr6nvLQx6BCMVVFM3MRgBBwWzlyywuAMGMB1IUVvnwIDOPps5Kaaty2WjIcmc
JVUMHJ8eZDQSkJIYXq8aN1fq4Rk5iaLZ+fCEycrmJsAYKp4U4ZRVo2oGhzADNi632TpStKsG
rHaRTCgYllK9aoIp9TopitaYTI+jZjIw0ozIYkcxhcIcJ6PObSRRgIYCyzTEGV3uVxE8BmRu
3GtGbY7G6Nr68HK/f319OSyO377a8M2LODpCtxAot3POtyrriOZBvZAxohvJrMfrKYG2rE1e
x+E7UaQZV364wDTYfu4H6QMUyVgeBIdHxk0i4rAbDSeH3NB5JrOYoPEw61irWMCHCKQcqUSC
CS5U1pYJnx3g8gKieB73+61LL0oOSg+8bpBM1MBRl2K1A8YGbwT82bzxstWwqWTDpWcs+rZp
sDLOjVUxzwVsXkDfJr/qBlM1wFuF7nyzcbDNKp4D3pQd44eZunCWJ1IcIWofM4+O2NWHZZR6
+f4EQCs6CyvLm8gMyqWxYyMm6AZw3UseP/oRfBoe58weehWHrmcWtv51pv1DvJ3KRom4pJUs
A8eBiSoO3fIKE8x0ZiId+DKdoV2QGbo5A5cgvzk/AW2Lm5nV7CS/md3vDSf0so3fZhjgzN6h
qzzTCxywecXSGdUZrWLEvMLVWLNp00XvXZTifB6G/m0Nmt1mDlRT+poWuNtvoGV9Q1f58ips
FptAR/OKl01plGwG7lyxu166cCPPEGuWSvoZUpN7xGCbFSyeVAGKYOiswnUc6a7ZHJ7nVfYQ
UMDTxtUudz3agQqIDWnkFAAuXqVKBi5xbIimpNH22xURN+6VyapmVlvJoI1BII+Ok9TOzqdu
3FwZt0S1MBFwTBKWA93zOBBM1xTUhwQhYGyACZs5+JcThl1gF2tOJ41cTJvNLWcEHaLjaaNk
Epx2m2bp7m4TITTmrb1o2bCWn6yxvogTiT29PD8cXw5eetyJ8zpL3VRd7DqLIUldnIJTzIHP
UDDGXmyZdIOgmUl6m8ZyQncQMLqxjv+lBchxQq6fHN/hw3pGPUiG2wjeX5it5RQkDdTGTD8r
lr6zxL0sSSXwIgVcydlLFoBdxUxwB1teeTcUm1LVBfgvl3EvowdfxCj2wHM3o4Ruu8gyiAeu
z/66OrP/C+bgr7EmLOQ1WhP0fjVXmtOYZ2ecmgzEBaiBvJGI92+c1Xmw0XP9PTHebjpMxwtk
iKJ35/BSsGHXZ/4+13ruFI1Sh6BPKEzUyKb2w3dEQfZAn6jsZzAi2u6hnOJNLN5ObK+XV4NL
o6XDLviFcQPXEL3Ntne7Maijsxk03D5MaRk9Neou75QgtI1fpOMGgypMffPq9FQQIAfqyWqH
0r30Zhn3PoAlmsTLqTCKEXaM2W/b87MzFxdaLt6fxaXmtr08mwUBnbPoCNcAcesfbljMW6CS
qFWbNm49TL3aKY5qGnhcopyc+2ICITqmh3y2tRuKSXHMNvq7ZyJn00tFRiEFzysY5cIbpMtN
bFLl1XHQMjU5AODQeHwGssKzXVukOp7Z7LXuiTDVk8SOITs5WIFcFJPUR4dj1U2NSl67d2/1
y5/7wwI0/N2X/dP++WhGI7Tmi5evWBXmBcZdWiAWpLjxeRf7eC0k3eCdRRoB0cKLarYfrR1q
jRvOMQnZCdGcMhuSCDhvZ/mTr95YGfZQoBLEuqmD/SpBP+mucAW71G66yLR0WUY7SWNR1TSD
ZjDNWnNXo3jNrX/7YYnXVLY9+45qwcwE7F+m7LixrUAcyTat2DApecrc7I1PidFYGYmLQcJF
J0SDOt9NSCWN1iIWThvoBqYhwO67bRmpXE/A7ghw5BwN449LBlyhVDCp0fcOPZsAzL0bIB84
mczYjeQ5qPEw2exj6xWTJYld9djZNwpCpTZVIPMZL9xbxSE5aOkYMW3qXJI0nOspWC9PwRoo
xxT7jJExExMQL4C2mmWlTp2MnrLfXyWzzOPdjru7AFHISoSwJPcTOB0fpw1qixWR6RbNqaiK
3WyBmeHYmjnS7rd313j+EAiIbk9a62wqZWPAh5l+UQNj8HnGt39nQRoQlF0QQSljp/vamUV2
2P/v2/75/tvi9f7u0cYDo3npBCFqM+K9B8L80+PeqdgFSr5I9C1tLjYQSqXe5YQHLFnVeEbP
BWomonvmIfWJtOhxWlCfdHNjkWEZThRhPB9EjNvRv7VtZn+St9e+YfEDCM5if7z/+Ud351Ga
coFeaZwjDLgs7ecJlJTLeIbAgknlXDxgE47ot1gKfls/sJeVgHZaJRdnsOcfGy7X0VnhDUrS
xOS4u1vBuNfx7ZVX1KAoukUxCSi4c0tSMf3+/dm5e+firgrjzirx5QRv+xP37GeOyB7fw/Pd
4duCPb093vUei++nmfzGSGuC7ysNUFR4uSSsn22GyB4OT3/eHfaL9PDwH+82lqWOOoMPjN/c
OwxZGu0FHprntqcl56n3aSscRlNpmrAmviR0hU5lBeENOvIZeI0JcaOcbNvSLB8IDOfjtve+
aeS0ciHygg1zde8oDECB7nwK2jARYbId1lNxBu0QsLZKVErAn2OS4MTgeAWQNFmGN1gd7dNU
e6x5mps6vX6y5wf7tviB/XXcP78+/P64H8+T463357v7/Y8L9fb168vh6BwtbPYGAuFx8djC
lG+t7JGs+yOOTAcxJGb3S9ZuJalr7zYdobiOQphqfLTKUhT+mJTUqsELL4Pj7osLNWIO/xL4
l6r4vQTih08FRqtY13jJLgWW7XAWUwsYTGtbGr4GT1nzvL9f94aQlF9Y1ojq5f/PcXh7310H
9mKp918Od4vPfe9PRjjd0sEZhB48EWtPEaw3XuEMXsE0+DDErHiSzuvLBfBa/uG4v8do7adP
+68wFFqeMZjqyAlbieDJTt/WlV6YAik4ktiVjJnhQONbSBUdntDVWIc3rL9BYA22PmF+QRXm
jijE5DuFmZ5s5mWJqHVIrxsAn7CEhRCT210z/zHAayoTaGORH0XfO4jJMOeP70w0r9pEbV1N
usZb0xhxDgoCawkiF+6TnbCtc5QiS3XJxNZr4FlT2WoPCMcwBql+Y9RPZxk0r8RsfDBhKK4g
Qg2AaJVRS/C8EU2kSF7BoRpXy74uCHbS1CJAoIppiK7McYqAMm5zCjNA64W0nklzZm7fPtlq
l3a74uCk8cm1KtYQqKFyRpuqP9MjwLu8SLhGs9qGx4jvv0qRds+SwtMB/xwiqyq1pQAdX/n+
jMVT7OPcweGbq9mONm3htqy2bQJLt+WsAazkN8DdI1iZCQZImA/AMoBGVmDv4ZC4d9sSVJ1F
OAfDJczumFpdW/vQ1/JOiETG7wvIZLdpfuptPGFPc5yAunV93p7TpotpsYZ5wmRWKGxReXd9
F+69bbU3NjOwVDQzlSv4OMq+s+lfukVW0SVIu8qdKAbuUQEHGgAntSe9N9rVp3hg8yrDiQfD
vq5edruBrIhoucA4vy3X4Dl2R2k8rImOnL6xCNlWIFu415CehqpMrhu2FIuA8P4ihocwLEkM
M23mLAwQ05Jq5Tmf3ehpfyPBKFbzOal5kTaYw0PTAFYKOS2irAykT/7G5uaVrYXm6QYUT1SL
+r0++Own6l2vAnXh0OyCLV+T0AJrjdCfB987dbAFPqrkeZdxvZwASGBKlleoJvEwHeJ9+DMF
jepcg9HQ/RNEub1xeXEWFHa3pxHtHgMN3SXWM9r3Q04ZlG2bq6AeD6+GQ7+86FP+vg0Y/AYw
ZJ4jMIyDetItcp29K+uqiFtWUbmrh7dOORWbn36/e91/Wvxhi2u/Hl4+P4RZG0Tr9vDUAAat
9976Gve+FPXESEMioGhyfLwolKb0+t2Xf/3Lf4yLL7ItjuszeI3dquji6+Pblwc/8z9i4sM+
w1kFykc0phtx8VK+wvfLoK1qL3nsIKGAWtMfjRa8GYXVuX/jbg9xC3rTmt24GtAUniuslB7r
CDqt4k60419b6IsRWKxAyuI0FcJDHdV1HYAu5d53mbstwu5K0uHl9UwpfI85k3zqwHhoEMCd
HAxrNLfgrCgFtmB8u9Py0tywxAvxK5AzUEq7MhFFTIpAEZQ91tp/HNCrcQ1+wHgfM74BKGYu
BlTlJJTw1b4tvq2BnXCjaVjzOl4R2fSOLLcRXWEeRqeGjHnXOo8itzEEoxH7RwZtwjL8D/pT
3RNgm4z4a3//drzDwBd/sGFhCiyOTmiY8CorNdouJ01QZH7xR4ekqOS1njTDAVI3ssS+6MzF
w/GZCZnZlvunl8O3RTkmUSeh7Ml6gL7QoCRVQ/xAc6gysLDYYxnb2afWmtox289xKUZyNoIN
XQlWGmbqek8ilwzfLOfubWC3Hq5EETwi6O5SzT2qLUS6crcajC4NcwQ9TZ7LgJiN5dqgOBov
oFuSprLV1rSPIFs2KtCXcMJg5exS/4DVuCn2BXQqr6/O/ms5TjPmvEUm7NWVr50xKDi+lSnS
c9rcYnz4CO96hyb3XgQbseZdXf/aN93Wwk2B3SaNo1RvLzNwgRyoKsO96+rDYfW159H2qIZD
ppGzSS/1eQOXU004bapzMChfx8t0bRXzJvD5YetMRR2+PfbMH0RoCTgUq5LImIJDeM6QyUzl
iqmaiSgbBBvfmHgOw7zQjufqvgRZJ7ZsvI+jjeRX++OfL4c/wMmYijxw+Jrp8RDsd5tyko+N
oJYdnw+/QF15OTXThp1iRsP1neFjLEDv2m4y9+UhfoEQ5SJo6q7Yx+IbbDSlSRmJPqE0CKpJ
WqzFp7uAnBVgNqF4suLKjlmjZnA7whlgmi12++IdD69tKrD7tYORLeuxqsLUIsaucgHJ1inS
goBRTz2ydVWH3226otNGU3M1aZVEThbEax5LgltQLrF6qmz82yEkp5uqcs3GgD+lj0SGX3+I
X2vBhplFx18e7MCHBU8jnuG2Y2w09+fSpPE5ZqKZNIzrcaM/BJKVVwOJTeBfzTBAzzFPXqPh
pW4mPmSYnj9AKF6jBaA1Gp98YKKYEPY4tElck9pbmB5+/e7+7feH+3c+9TJ9H7ikwwFtlj4n
b5YdC2NQl82cKiDZ180oaG1K4iX2uOolbPUJ4PymLyNyagYueb2cWUnLC+If9NI7pgA0aUUS
yHBPXoviOsCBlnbpvVjH1ioFX894NXpXswAYHSuXIZrHxX1LjKHMTnTXEl0V1fxZnZBBux6W
L9tia4eZ21uDBFaSemKGP8aFGTq0nr781bruVF22m3YBt8okQkBdl75vABhhpm9oGiTEC00k
T8EjGJAmN0L05bBHIwo+9XF/mPzWmqvVumFgQmF8NsGBv/xfSRtB9tFCN7ETCFOt7dOe/IzK
LKIJhmIj9QiFiG3xABbK+5WJKkNlUhknKzZ+Zn5iZPi1Hb8ZaIKH4DVbBh3lamjCS4z/4+zL
lhzHdQXf5ysy7sONPhHT05Zk2fJEnAdakm1VaktRXrJeFNlV2d0ZJ5eKyuxzuufrByC1cAHl
ivtQiwFwFUgCIAioO/GEwCVKcuxEIhsi+we6ybEAcVJtcnxCrTfYYqcdlcgwb1od5o6PsGr7
CfZKs1pXcC+Jq1pmFmjST7RTiuw7mhD1dkHwPOiQXbbVAUI20yAYIsSc9BYZwNEwXrld7pU6
Rua59J+1F1MvQnN9v/ny9vLr0+vj15uXN4wWowiratGu3zEI7gck1z++Vv/Hw/ffHz9c1bas
QXGd3HksqsNsJ3oiVDrEDS7NjkSJPKUPRJKWZj6CUvSV/AwDRbmTy3y2wXLnZEyCGmXsVJd2
KTIg+uERi/vUH2x+Olnmq4zrQt+uNY55efj48scMI7YYFg80c3Fu0zMsibSoKgQ+HqLizJDA
pgmq/mwzoKjO1pHEca0tYIIkPYm+XJvnnprH9WyP0rh0foOegpTkCELctMx9laDKr7QnpcPr
TDdQi1dtP9bD3G/nZyNPy70eYIoiwjH+WIMoVM1/TodxgqIUQmHVuJespCt3V4WLkRalg7n5
qM6lOFXdFL0KP0ty215df/LYnFsaw341P51NynLqWQ9Jiu85r0wmj9sfZkV5/v5Y46Mx41r7
beOKykdQ27vlLDUcfT/W26Pu3jkrdisGDK7ar+RvEWfEDxUraQ/fZi2aUknLhkkiVxWJFOvD
xOHGBP93wfXjV8fN1Yc4d62ILYkJGBu1xyBQTkSJsStm6pxDzOHcQwRkhiY8C4u+RtbXPamm
GPxJ2CAQ6opwJ7Egecorf8/vI9jWJ37z8f3h9R2dFfFa9uPty9vzzfPbw9ebXx+eH16/oP30
ffQtNZrDO+kKV4azSUlxTGq7rxJlnIAkjcsYopCYe8k0vPch/uIkyMiCjabSSNi5oeVVic2p
V359wTy2a9uRscoEqjrtbPp8O9MCIhuDKbrkYEL0mCwSVhyctfI0MTmrvBv8jsX88YN7CoGP
R56KlDLFTJlClsnKJL3ojPjw7dvz0xex09388fj8TZTt0f93xhQxqbhJumuYsLwsNbVZnh4S
rmnYQkuz6QdtWtJrKl+Cj+8B7tCyhTJpEVg1SxuG0vG+VsOcgIYBIHUbE6yeS23YGClMPKCy
2jQoSHgvyR9oOMqwJKKpe4MTiW3b3OBvQNmWJoOgAHEzp85NiW7Y2WwNZoceFXP1DxB9O6KD
Q+jpGQ7rWfDfqx9jwonZVg5mWxFmHgs+strKMlZY0In0b5IXVgRfIZic6ZXGLH8biJFbaER6
zFZLfQdSsLg63W32YnGtXzVqyAPtQKLR4MBkJOBrTRWuUTStzrwKijf0ZrqaGNyqdLAKiO9B
js1ke5MCOJ/0fZjnSnJnXA2WpySNXx8/foCngbAUJpBu37AtRkvpX532nbhWkc3rvY1X4+ve
II2RXjTWFmGZB3rLfL3r0u2MIX9b23vOtBv0FgE5G/D/mzjOknfXNPQFOiTyTd8AFRkYJ/CE
mJPPBFW7a2KQALXHY86eTf3uo2MeHr78SwvCMlQ7PbJV6zRKqXJo3GqmEvzdJds92mzjklLD
JEV/rSavJ8W1B16iaV4zLjp+YHToKGcJRzx4QW/3wIXFdtUONgnNSaCNULIZa5VLfPjRxXmm
Td0Aw/j4WeywvSBRzsjhIGrb+KtI21UnKHwuJ4sLk8zf6i/bf0VAT4EB0INFC1DaUhsfV40+
RaP8MNd4v2KzfQH8VVaVfn/VY08wC/0uajtzi+tgrlsyBODFAMA2s++ihe/d0ahtExfDPYyT
wDCG6IXrJnVEklBJ9/yc1XQLzm6nTkzR3rr6dMup6NwqxV3sqBUmfBMsAlfN/BPzvEV4pfa2
YVmuilriOw5fYHqDNkK7/YkUaxWK4qTKyPIMMn/3l+4K8+ax9sNXgje0TA/UgUHUxZtBRFBu
L36odj5nNRUIuD5UmgFglVfnmqme7RJgr7wBUR5iEggluF2xwOBZXhgGNhV/qKjJVSlMoVDF
FdU2y2nfaJUM595IeqGiQeefqWAPFOml7Q5Jg72lKtnblZA0uKuSoizVVqIFyKQocG7nKQTT
KWpFmqbIsuGSgnVl3v9HxJPP8LOpb34USvuOUUH2HaGcMllsNo9LY8jyIKSEuz8f/3yEQ/6X
PhuFJiX01F281bL2DOBDS/H9iN3x2GpYHIsWsG6yimpAGN/pIOYDSeO+GxR4vqOjd0/4u5kx
tOmd4RcloNsd1duYDBwyYNN2Z26loi6Gg5/t4v7aGBPuvs8QBPBvah1bomRDSQfj9N+JD0OU
47dbs9vmZByq29SeurvdnQ2MhWe1xRW7ux5jF2C3KUVvww4H8lPVmfN+VeJzR4TdceLswE3S
CPr88P7+9FtvrNJXUqy6zfUAfKyRmbdVAtHGwhDmmGKkELvN0q5ydzaHjNBjQKX0GOviJ8vj
cYBTO+jYFkafezGh/b2tBZf3vVYjWAkppg4EQsE28mOUIkInIpwfCosy16WcZJlsp/jVJrES
riMp8RUXrzA7oCKNwv7F0O/8pLlMjdBumzOiPYUgYa2jaEmpEWrJUU6gSrsUSIVEBtIgxiJ8
CDSxugIh9gRCaqtnylPAuC0RzWkUaZmqT2RP8hzTRjDAXN7S+Cggq6aiLw7EJLWrLCCcsRw1
F7W5HhECorl2FAlYL9A4GKnULesH7txTxbTozlx4rxMAg3O8+pMojYfLmGdEdX1OIqToD08b
YTlGC7n4gu8r7js9GctWPeYwP8mnbHwO2LvL33w8vn8YTwBF87ftPqUjPwtFoKlqkBvLzIo1
1hscrOoNhOqmPyl9RcMSMWwZ6+/hy78eP26ah69Pb+NdleKfwlBiV5Vk+A0LsWCYn+PkuI5t
KkVSaSo+vnNil//jhzevfb+/Pv776csQgkN7WljcZqTP4wofFSjqb32XYqw1ZesBdoi1O2r4
SS7te+D6Dp+175KLvi+MmENCnSH3rFANdbNDmqqNSTFzq0mmWzTYpQltzN+iMxdZBTp56Vtb
S0bpUPFEqD8ZOOn5z8ePt7ePP+yPMxWWMatfFMg2LrTfTavjNU0Zfh/i7MjUW9wJhjOvrXMF
dViS4LK6zcj6oV+8NmZmQLH2ENARsBQi8rGxgg/Omf4cQcGJWZov3qiZtxQ4ThcFZ/vV5eJo
rmhO7tZO8EebIKTWAOdMuBBrNO1t/5GmOFku9lA2iB1slE1N5xMA5G1MubvwtklZISMwKMsZ
72Wao3ZlgjOea+FgBgjqkgoUNUv9faQA9RkOVRCv7y2iTOHAeLdHZdDTTkihgXoiclJhRKCe
Fn1fEE+nNMcYSiKxNJyHjsR3A32M0ZaGTEVdVZLx2EbqJsU4T+KtbykC1+6Trd178VR1eLiP
JCKej8pNSnelZbiebdZ+tjd2v0mYHf50RJ+1D5VnWzm7FqQTb+uBvHbi4rhwI9tbw+Q6oF0C
X6/1e4r1tYfIyARqrIkB0cT4nBL5N6ex48vLH6H653+9PL2+f3x/fO7++Pgvi7BIdYFpROAR
MDMgSgBWK+XDQ0ZaVNOrGcI9msiyGjOv242AKrAFQWAmA8vUn7wg6Ewq3rLOinM6fS4i14tJ
U8XbmRqyLXe7/oxUNTcvraZh1PlM9ehCf/ih2TicC3eWTY0z5DtzZ3+QIuZzsyZI6h8Ydpvk
fKYeySZDmrhrX7H3IrvIPFmLaVtH17sX7Wdfs8jyNMVYaXa3Wa4cZ/K3JRb14Kysj5Ri26P3
dVbp6vdGd6OG370GZdoeNsR3UgTAjHrXEKf1ob+cNCB4H9K29+Z76QGLuzmtaJc73SqyA57I
9llLPqdHbKkKBz0AAx7YwFEeUOAgWlhiZPn48P1m9/T4jGkEX17+fB1ckH6CEv/ohQfVC36H
OdhqvUEAdJlvjaUuwyBAhMNbKBbCjeiqY7y8tYcsYX17NtyejUvdV6I13YPN7qkVBrtzU4ZG
KxI4DnfU435oGqcu1JxhEBanSpntKBVieG+nHKQ9RH9mkGDyOP15/x6T7qS5ag4QiX/HvO+X
Qn2zKFR5xBdcfwSGEpL+hm3Hshyjlk8TJQMwGSp2IuVQKwirJM7Um037V3fKcZllhWbAERgM
lpsawW1lERnzEdRaMtCooCmJuFpQ4QQxf3RJVTAZcWf6lnGWogBlBONV8TCNlIUDMSLyp1nf
zPYkgoO3ZFpORGFYCyFjS5hZb1adnLXC/LpxjGdk6gBs0oxCOQQfr4kNB2Ff3l4/vr89Y1bw
SWuVVoWHr4+YrgaoHhWyd8oJF6cduDxJyzgVoZNI08vVGvVx7lr423MkxUACbIjKkaV364JK
2sUafPL4/vT76xmjluI8CG93roxs8E+ZIxvjY9MTOU5y+vr129vTqzllmKRJxDAkZ0srOFb1
/p+njy9/0J9N58tzb/9r09hZv7s2tbKYNfSFUMPqLNGvZaYYrk9f+g3mpjKjXhxltLBDmtfq
GayBMbPLQQnyD3tdW9S6ND7AugKlJtppp2VlwvLKkQwSxAXR5hhgGqOjJtaAxgC36I+uehLv
zkMw4b8tkIh0kkCNWipvUBimENHT8KZSImykOTUkmg5hPQZAlkGq/qk4W5nDGO2VIlgVuiEM
8Y30WUbxMQHt3uEy2xOkp4aMBCHRqPP3lYD4heEQ1TYElklRXNKImLBEbWOiWUzxemwrQaec
rQr6dMwxs6rwIcjUswU0eS1wkfwtBAkTxtUggz3srOi6PagoVKP4UF9zZ9cXx8oTX4xBK+I1
CjbZGUbZbif20yEkrh6zzV5eYwz+SVKctIzq0pKvlnhWiGDVRR8GSYsUP8pKgxxdgXwTt3qq
j31JWp2LVoktBD/EJ+aDk2P98P3jSUhl3x6+v5uG7BajVa7RsEUGE0T8kCJI0KjdQWS1s8tq
BDDhIuo6QTXsjlYHRQ+P8N+bQj6MFgm/W3yzIuPf3+QPf2vilOhKVXN9HrDNDE1U8NHlPcwg
ljWs+KWpil92zw/vsCn/8fTNtiSLse8yc8Sf0iSNXUsGCWBdyCWldwaqEhdyVW2EfRyQZdWH
idaaQ8wWNst7DJt0ZrRrzECYOwgNsn1aFWmrZ8ZBHK6aLStvQZlNQPv3HFUYZP6VaqhXEQRZ
pM+I2ZfVlVYCR9bPfsiZI0fpgKZu0Efk0v5YmdFdGWvIrheN7HASzdTOCtBbEptX4DhlNvTY
ZrkObVhhACoDwLZcvqMel9wM+8sIeg/fvuHtXA/E8HqS6uELZvky1ogMrDnELjM4G6PC4Qnw
QgCHUA1UgTFZWqQnS1NJ8rT8J4lAvhBs8U+fQlc7ukm0rcjAc8anNER6DScTupwwKjJ9ZosK
cgZnS0Huf9cmW3wR/vj8288oPD6IgBFQ59z1JLZYxGHoWsGg+rJdrsXE0MDduclaEWpaBobQ
ap6oKsdbXrE840PtB7d+6Mg5DCSct35IGX0EMrcYuz5YIPhjwjDLYlu1mG4P7XUihKCOBUGF
91nvPb9/wpY8vf/r5+r15xgn3lLa9fFX8T4gv+T1j6T2vcRI7+IGSBsSnFaIIYH9F5Gfx/wu
A82cmqbSGV+PoPAveJDtcYb/tnqexjFqPgdWCPPEyxWCjhexXkvDzl0/Uq1/auGt7gMkz+6H
//wCksIDKFHPN0h885vcxiY1V9+gRIWgMLPcOswVlLnIHVRJS9YRM9J0NeF5GAYXsmhxyShj
3IjXLb4jeMhyP8h5xdP7F2Lc+BdInmTLwCUV5eA/jTnjt5XIDU5P3IiWAs9cWLa5QonQnhZz
pNttOzC9uknU2cBCYg7yGuq6+W/5rw96d3HzIuNKOnZJWYBay9erMjYz7EpF+Qch9rjN9E8I
gO6ci6Dr/IDBQY19ShBs020fWMlfmDgM/qppVgNinx9Ts7XDPeiwqHVM6pCa+Vo9D0GgP5ZZ
22o+0wDEMLatlvkAgDL8KIm6rbafNECfNkODDZ9ehWmqHPzWngDA7yJR9b9qN2TLTTot7K5E
4NWDuk8CFI22OaMc3c1cmjLlghkhpAdRVsFSkwFFZMr+QlLcYNruLLXi0DSWyziDonT9fXY1
tQ2ReBi9BjoyNSZQ9ElF5c3HqUgp45sGH/cT+yYEJEleNRwjFgT5aeEr5xRLQj+8dEmtJq9R
gPrlhYqQmv9k5DgWxT3yAXmEZdsC06jQNqYDK9uKxrXZrhDHLV1rzDeBz5cLSmRKyziv+BFd
GIDTsliPtn6ouyyn/bxZnfBNtPBZ7og5yHN/s1gEM0ifNsoO36EFojCkMtoNFNuDt15ruZEH
jOjdZkHmairiVRD66t2Kt4p89RSo0Zn6QFrkcT+AWYJDvA4mi/zQuhQnSOusO9GXNC13PNmZ
NtahmlPNSvIgjX09Iof8DVwGHWFN53vhYjg/0hQWUkGZ3SWmY61PqbMTVns+1IPtTHImRcEu
q2gdzpFsgvhCuWuP6MtluSIaBy2oizaHOuXUd+6J0tRbLJaqTcqYianaeLv2FtY66nOb/fXw
fpOhf8ifGMH5/eb9j4fvIAhP0UaeQTC++Qo7y9M3/O+0r7So8Koq6v+gMpvDcZdy3HUyfG8o
0s7XetQCoc4VjjyrI7YrHPvISNBeaIqTtH6fCuKaCJPJPd/AKQmCx/fH54cPGO/EjAYJmg2T
IX+cVBLjbEeAT1WtQ6e+VLWZTNNo5PD2/mFUNyHjh+9fqS446d++jWnC+QeMTg33/VNc8eIf
itI19j2xkuTNzZOyAuIDvS1jqgFggBgzTbk0eyRpWn5xUhzYlpWsYwZ2UOrV01O7aM2mtAoc
PcB7DfHdzOWISMxMoK5KqsDUo92RU2n+8EHZjRdsljc/7Z6+P57hzz+oLW6XNSn6KpKjHZBo
pbwnRzzbjDKx6MTVVvzQ3z44HlbJyOmqLSkzwlv3vpOTr2lVJrR7mJAntK3xTmRFdMephHPI
NNZM3cf3qkQrWS0esuaBFj8DYdrvlmm61OlC12Y+sNirr7qhEzzVX+DFMseoOiETdJC96anW
3wsIx3+RzrgSaT1zPRZ9e6R626oGPiDpTuILNRWHPVh9JpK2ismpf+dRGjFW84LOUd3or4Hl
787zF9pb/gG8II1fPRaDythlYod1fUBXxWbx118/QOJ49Tc0nsGp7O4b1OEvQOxTRGUdIXIa
v1BtSzRtx8DoAf2KU+YQgWJ1GHEGjPBeGg4Y1tz0FGxaunG4iUhPaifJZ/jLiQT5Dq3CTjzI
Ouu1H9I3AUjAii0DVSxxWGqR5FA12eeKfvUi2mDu4cGOBJ+A3kBF3W4ULNPKPoeFU94k8Bhu
I8kTCEdPv/6Jpx+X7gVMyS1F2Ty2Ia1rDA/7tzF0Zed6TogUeVUR4Q2AJ9rszhX8oGjXYbAg
4KcoSleLFYXKYPcQlp9b/tkZt0Gj2izXayqkgUXkds5zlgAN9cdLROvNXPAEOerL5eKaEEB1
+7zastzX92WdpG6td51IcD16w13MIjKsBAb7bNNbTJ89U5wXIBrNhJBQ8S5HQ4pUGHasKTll
oBNi2kserwNqzgwCwxXSQaQYTyf/ox9cTqPuhE+75JGkzcEJtFmQLIO4cgROHShYwuo21V6D
9SBx+bXLyGeYagX7VJeB0tYLPNfD4qFQzmK0pOrPP3megfzteuU+Fm1TPXM2i1Na6e7Vq5Yb
L8WHmgr2WQuIr6K0nAXwM/I8zxGKJkdzs25NgKocd8FltqKWBbTQXfbqdf0A0Z8Nj1DpuxnH
dPdBtoS9kNHIxlEIWUm37LE2d51jOX2XjQjXAZN7jgdP+cW5rw19OzZVQ718VmhkbptKMb9u
l0poCvghzDzoRCQzr2mEiBPZ52bwmqQfY8ICR9KDbXmh5y02GFUxDO6rkj4WsTJqOfF73qZF
b1ZSqV0v0qd5QtdNbTDllbntfT016V/xa8Jfwtn+cBYZQrRbQcTR4qDWwCk7FiRfxoc053oA
jx7UtTQTjmh6Qkc0HUtzQp/ohDpq37KmId+daTQ81npv7lZkxRiGuKTFvPgCC5/RnJe4WFKp
O0ldx+FA0HuZT7XmPv0MlB/LBHe/+frS4pin+pvM1P+BjqafUZq5RrWvKjp2p0Jz0FjyULvc
jNUiR3Z2GOAUqizyw8uVw04+BVYZwGheAS9MOockn+3puDMAd3BtdnEVwfOExiydrdMM/Mlh
kFQmo2DNKSWfDKtEQMHKSmOZIr8sO0ckAMCF7msVwPLzLHp3vtptkK3Jl8oGjZC/Ff/fMvaj
Tyv9q/Yw6UAhnSno+56LvwS6hR4MrFwvg6vnpegKT50i9EB232iHGv72FnuH9Q0E8/JqyyVr
r7cL/4Vh61Ic9x0Wi9PF0SG9wqYqq+vsV17r2SlLMu1Bi8hCnNCSn1Kwus10EfDQuZYV1FVd
2YH7vJBpuc9K46IPpFbgMbLi+xQdu3cZZblSK09LjrndydP2Lq/2egKDu5yBtkJ/+LvcKdFA
nZe07Fzou5mgU0NXjmgeL64oME2i9bZZLZbU5qqWkBqmWirygo3D2oSotqJZs4m81eZaY/AB
mfYJVSxGl3FbgHsqzgo4aF3xYQaiNLWiqA2oKgdNDv5cOSV5Jg3F05qMN/4ioGyYWiltdPBz
4zhdAeVtrh68qI9fpali9Ki+JuryVmyEWvfaAqOvXl3PMOH6sqvr+yJldBho/DopbTKMMUiO
wxxZZscrnbgvq5rfK8bS5Bx3l3xvpKCZoNcl7TY9HFttr5KQK6WUi4826+IaTlRMCsjVF5Gt
ds+glD6pqij86JoDvoF/sUDGwwqEY1CIOGvvHbx9zj7/gCRpPwqb9vckcdytZXXtmhW+7WW1
4eBMQGEwE+0K4PDMQoPFmNY9g89FCySCJmu3jA400FfbYT7YF7OYhAt/vZnKeyqc7Sa91siY
ufKivjQVFIeMZyAYaGkmBcJ4kyxgsK4xDkRGbejAS3psFQFQDB/8DJDpZ54mXdtk+z0+HRII
6S+UZTfw0xmYh+/0GMlJVmJxh0EGK57sMb1NpW9uquMSRevNauuqp40WwaXTOg/ffy2Mp3pN
AI7WEkxUhEwj7sWMiRnMHnoTcQYqOzNgUqfUgQko3kPpyTGvjoLI93vgtM0AuI0jDOlAdlEU
W0ZEXau1DtxllzTRO5LFdQ78psOEI8PlzO714qCfo5lx4XmxOYn5pXX0rtc89BYGIEi9BkII
/DZMGtgd4NYzp2wUxB2dKkX0Gpab5e6oMpPc0dvI3XghdLjxIHYM46AsS2gR1yact6CLXmr9
1GgY8GMWW82Mm7c0d2sV9S5Ue1iofoN/m5MFc37Lo80mLCiTVF0rNzvwo9vyRE/2jMAkRW/Q
VAeaKRIQVtS1FtxfwHCzw72Ibr6SEWbVIhUlVtV1q/eq6vPUaY2JJ5DkJ0KseB/ZkvGQea7e
cfH8oG23iB1fhDoEbUGDkV0dD2kRjUGbxP80py+x06JPzs/vT18fb458O7hYCKrHx6+PX8UD
EsQM8ffY14dvmKHBcjE5a0LDGKfqrMclQarpyqIA5icmRSPSM/7NB5IBbEgbuATG6X4D2I2z
3OqWFhbPWb7yPVoMhmLeghxaXAari3be9yAqTB09bW2ROnqkUA3HyVVCYda8SuUK8GbSNKB7
TFyAL/1Vt3L5e3pH7UKA+m44dvYEteOKYUC73KvSpnAk+KjDZX8jTKObjBch5aapjrw/fRSx
JtumTcsUH/kBol8pjlAj8s0I74NgmeAWhGycLKKmAUWELDpnuyylJ7A45xG9ArRxpknGjDVL
EjbM3HlpMnn+XZld4CnNMgBCw4a8mFQLqS8O4rPn6+Y3CZEFOKkdqHWpStM59/xQeUguf+tf
FWHGGs+9iDQvn/P+0ZZCKq6vXE4Car8+3yfs+n4h5N20dFxCTFHEzpyU6NGxqkPOGfyaz08F
u9ygS97z4/v7zfb728PXXx9evyr+/dL/+RXTAGvHyscb1PzY14AI1aukvzm/Wv04dbqNA7cA
PHD4yXPcJlWcngKYK8HY1PEMDIrxt7olzJESnSfJY/1Xn1ps6k0PMw0UOoG196rIXWNVCMKE
dYBjSNZfRG4J5fD++vSOk//ViC4CPA+yCM0xrLzQp0odB4uFy3JWUu49MUj0at93rDHlo0Gp
yNXYVPhL5CAdo53xJNfc0/jWYYJREh0QrqCTDbq44JU+0ZPd8VPW8mOnJoKTrqPywdsEIqI1
ZTxRHTPhF/r/KSPDX0pACJNQ/OV4nFEglfXVs9dvf3443X1F2DdV/YKfMkTciw7b7fChkwgx
amDQbRND0xpgLqKW3mqPsCWmYKDHX3rMGHThGVfu0ytIjL89GLEt+mLVESTb9ER8EknwqbqX
/TAKpqe5UukJD78XdbJc0bNkgdv0fluxRnMXGWAgqdLCvUJQh6HjA+pEUfQjRJsrRJh1hj63
Jpr2dkuP5g407vBKX5FmfZXG91ZXaJI+tHqziugXKSNlfgv9nSdxGsM0CsG6DmVpJGxjtlp6
9HNylShaelc+mOT7K2MrosCnnRg0muAKDeyN6yC8whxFTO99E0HdeD59Ro40ZXpuHSLxSIMx
/FFWudIccetBfLgqT3YZP3QirtO1GtvqzM6MtolMVMfyKkdVsF3R3iMKEwSwHq984Lbwu7Y6
xgeAXKE858tFcGXVXNqrPUdzVOd4vjYRsdrzHFd+I9GWDFKt7M6KhQx/djVXsmKNoI7ltW4i
HzHbe/IR94jHq0r4t67p4iA7sBoNVPT5aNN1vHAFEpyo43thVZnvWLZLt1V1S8yAOM1vxUND
CpuiE7PhFmljf6ijGG8lzTPHHcPUH8F+GW0Fmsh2VYw6lyMdykR3KsT/ndPD0yZj2mM3CZcJ
0bAvMw0Ay4WbNb3wJEV8z2pKIJdYnD/rakLDOHyFDSIx/ebnA843fPH6kbXZhQwwIrDIw9vC
LlXHnreomXsBnPjlctGi8whwH6jBqG1icZfbuUmHWhYpMA/CFQcySgOXBCI1quaVLCFYLzrs
xozep1SqrHaZDBSqAyvPzHFKKGS3mKz1GlGd7hl3rKueTLIvaD1xVVDWnX70yMc8btJUEe8V
ID6VrzF8vfq4TMWzhK+jpZJqWUeuI/HKwIXbzOH0F/AEXjNJ6Hht4WioxgMlyrF4NEI0QnbF
pXU0MaC7Nlg7puYIklp2ibOGrmJ79EGNDFw9FWifctpQqfBypCphTcdlFHgR3ZJKFC5CV4vx
fRS3xd7zKLcUnbBteW1E4yEIjA2MoKBFfJtwebWxpZtdBgInvyRsswh9Bw43mqaikQdW1PyQ
6fYtlSBNW1qd14j2LGe0DGOT9Qv7yqylF7RpLOhe95YAGrmvqiS7uMZzyJI0paJtqERZngHr
Xuj6+Yrfr1eeo/Fj+dnxldPbdud7vmM3wQPPhalcgxF7Y3eOFgtaV7BpXWeSSgkqjOdFZGQM
jSzmofMLFQX3vKWr37Dz7NBynjkke43WklSoD1ZcVse8a7lzuWZleiHTHGpt3a49xyo6tDHo
UjQOECJMrnMNJW23a8PLggrooBKK/zcYkYZuSPz/nDm60WJwwSAIL3PzIPfz69yStMJB4vox
cwal2HMuNzzr8Xa04llLu2jqLOUF64iy/VmzkLW+OHkoPI/FHuPY8gDtLxaXmf1YUiznkOEc
0rHEe2SX6S8stK8Tk4E8VZKm6NTkedrOlOUpS1yfgmeWSEpRtZ4f+M462mJHBo7ViI7NDuTO
wH1c8Uu0Cp27Q1vzVbhYU3cxKtnntF35voMHPgtfYsdpWuXZtsm60y507F5NdSh68cVRf3bH
Q/3+qNfGM4dHZVNkSzqMyuHh+1cROjr7pbpBI7EWfklLCUhErDIoxM8uixZL3wTC33pgHAmO
28iP15529yYxdYwqP3nlgmiYRDQzGK0YlywS2L8OnKsNcOgOYvYORqwbM3pwvZVQoyFpXCSb
ORpbwp4VqT4fA6QreRhGauUjJqfPqxGfFkdvcUsfxiPRrojM87q/WKNYYYqBQlwnSGP9Hw/f
H76gx4cVvqvVnTlPlBPvscwum6irWz37loxiJMDkcHr1rKxKGQjeEci+rD5X9BuFbs+VV2ji
5mXI9f6iQ7nxRqo85rnprDNN82CmdBHkiQgHc2wrjOdO3XilJxlabiwCkNtC9zruo7R+f3p4
Jnwf5dyIcHmx+u61R0R+aEToGsHQVt3gm7M0GUJHO9bMUMAIQ6eidujvQVkOVKLYDiWi9Yf0
DtM6oGYPURHphTU0pmxEQhz+zyWFbUCWyop0jiS9tGmZpImr1wUrMTOqK1K5Ssp4ncJkn8wM
PSSxCCnvjFWnf8c2jdsfIm34tSlOzrqHrobSN8ex0taPogtdJq/VIIzavKlZZnsExnw3go+W
b68/Iz30V6wAcalthzSS5UGfCDxVUdDgdhfxQ+SZ6lRoICb28QwKPcGiApzh8k+czAApkTzb
ZSe7SgmeqZTHcXmhRLkR760yjhI22eUR7cboORUsrBFjscfDstqmTcIcOZl6qv64/tSy/bVF
0ZM6slv1RNnusrqsLAkDXXFBnpkv23ux1rzTM7QO7TcxBUMOEasfOMRss6npB+M9esdzWB/X
xi2osnKXp5f5/sf4doaVrch5BpJn1RCfxSYaWIsUE4xjx1xWcdv0eeNM9sA8JFpYWDgj0X+u
bJX7kwnWJ7Yb49QeTkMOEfXdiAjqNKwEVSCuiwxtxknueHZ1OIO0WCYOB0jhX0hikjZ3eILW
NYa1oEvxqrwnbXXFGURpxX84jtbB6i8z8R6IDDrkUKvRqfBXVxTMePzcA4d0mkTrMEH7+JDG
t7g2NdEnhj+1KiEhIOPGhtFDbTItvcoAxBsVYfilUeiWWKZq5B0VWx5PVasnZkd06dB4EGc5
wiq4sTGtK3Gz1Vs/wSSgEf+iSbLjKNsg+Fz7S7dhyyR0GGzTPMakYobU54j8C5tSfq/dSw0Q
jK2sxJixRXNFIxS8DyLuEfPY1Uey+xoRJlaROYgsSRSHb/sY+XqwmbgWmQBBrmzSfUZGXUO0
uHOGr6NZKRAh0zfQd1WIBtnI4fADWHxCNTwd+vP54+nb8+NfMC/YcRGEn+o9bOVbqdNB3Xme
lntlofaVDjud1hUJh7/dnenyNl4GCy2G6oCqY7YJl5QBVKf4S3HgGhBZifuv3U2Ych2YpDq9
1Ysiv8R1npBHwOwUqq30+axQ3dE7y/J9tVWTIQ7AOt7pHZVANrpqQXOjoopxRo2IpXV8wwuE
/4GxROfTqcnqMy8MaNejEb9yxEwe8JcZfJGsHVkpejQGHJrDd4VDZBB7pqXMq0juuGSXyMK9
mOosu9DGBrEVC/OWu1PybT0sAXpXERfrGQ/DjXvaAb9yOMH06M2KvvJB9MkRN6/HwX5ubWG4
PdmqtGgrLjKV+97/fv94fLn5FfNo9UlUfnoBZnv+++bx5dfHr/go5pee6mfQVDC7yj/0KmPc
q/UDXa5JTFou3jfox6yBHPUhY99RSHgOYoVzDtS6HC8ikCzd+ws3j6RFeqJMXYizxyb2UZn7
Oys/yWRjRvcry1dM5ciY6XHUVNzF/bmbW0cQDclGRUvGyEGklP2HUyP9C87RV5B7AfWL3GEe
+pdOjp2lD90Pgvr+QB3jSNMydNI6jZpt9fGH3FL7JhQm0zkozdNbma/NmCMjXKfgNukJ1sks
trR4Gv+Fzx1Y7PAF8THePx172Lkha2uoPW7Nbl1jUZk12xVBfyTB8+EKieVCpXTd6m2gqHQx
5pQGyJDPTXuJryAoBczQgGsi36yCGxPGqTBhBpSmPticiod35LZ4OtIsT2UsJXVivSZ2EUmb
+zAjOq5/f64DhzBgL/9L6/+wa1gjOzv3kR6ND9CdeMwTjbosLRwjhaFPAkSqwFsbqGkeCKyA
87PyXh8LbBm+Gt9xggmD4oveweEZrXMEPPYiOLEWDt0eKYTNxok20/JoyBYEoDzb7dBg4Zig
Cz5R04fT718a7PN9eVfU3f6OT0k6cNaH1CA9kxksBX80T3+EYWRWTFEqkiiY89Xm6cq/OGKD
YIXOpc9r0lx/4MpHhR+aliDvsXhm5GSawM9PGNJf3Z+xClQYiKZq3UkVftoLV0qaNR+qttUH
LAbfDFPQ3g6qtVZnjxTXAXQvBpKe98c2f8csoQ8fb99t2betoUdvX/5FpnJu684Lo6gTmibV
pEaAvPZPJRi8XfdYrtchpujhfarWHoFp0Y+1oq0CXKpjNj0qHrsjFNOTVmJN8D+6CQ0hN3yr
S0NXGA/WvnKfN8Ivtb/YEPRFYhMXce0HfKHd0Q04npV7h3lzJLl44YKWSUaSttjNU6Cj/3rl
U55mA0lzG6mOAgO4itO80nMM9Zgtu28bllEWk4EkPqRNc3/K0rNd8RD9zqy1qS6tatQZ62Jl
WZU5u00JXJqwBkS9W7s+OJhOadOqlpuR0dIiKzO6xgyGjQhi3Hl6zvj22FBn8/hFjmWT8dRw
556+RoJnrj0MvlznXmgXEIjAhYhciM3ChVBuwnG/0E7GHiCSeGHy7T7LV+iN6SqrnXHCytyU
sXqUDrVkzZ0e+k4uOdMOImrg95xMEyWQ/Ro2GhUvWBaTsUZmQXt5+PYN1CrxvseSh0W59fJy
GYIK6Z2QApGrF7DCa/UWXph7zCCoApqcWb21asdbRvomWCg8Lf6zID1C1UlQVRsN3eialAAe
8nNi9SMjRQOByu9BwBKM+2IUKrbRiq/pnUZ+wKyawZ4uUUir8AJtx2IyJr7b6WfMzMeW5xsc
Oz/3WPRRMNjBmPq1F0Uznc/aaD0zcIflZEAGHvnAXKDPWYnpQaxPdObeKl4ar8WG43VuaKPp
QUAf//r28PrVXgH960Gb/yXcvAvWScra4PY9iPR5YnOMWJ60ZDcRkGGMpXcMWi711JQ9fBeF
pNOVQLd1FvtR7yakaG/GhMgtY5fYE0VMCXl4SrRIysCsmdwm60Xo08/9eoJNuPaKM2WFljtL
c89bceWmXvrI7cVwopZLt47WxGzJ88bVyCAbGHVJcLgwPnT/fM0arPSDiyin0Qnvqy7zEzha
XcxWELzxfGso7V1xmWlEPoYz2zjnGPzRXmDCGdS5LItos9HSjhGc0tuQs6scNGO3lazQRo53
dfJjgERSzWwx9dz+g9HNMwy05nifOhClksp3uI0hVZPEge/NnQAVBg7LHXfBxEyNOuWVGYQD
21tRL2sGZg28jWeykdx+PBMaB0EUmYxdZ7zijcUkl4Z5SzMJ4nC1bXdbbwgUo6PysP2s9OTs
4TX0ILd4P//nqbeHTSr12BGglQYf8Ti4IuN+jCQJ95eRlvZexXlnyn9kojCfiU0YvqcNekTX
1SHx54d/q05+UKFQ5zvMKlBo8yHhXMuUOoJxWIvQhYiM8aoojAqToO2BHvhE6gWu6lfqN1QQ
qsOtioicPQ08R1WBq/EggGMgdiGdA3fpjCrNOqLONJ3C0d8oFSkZSYy3VndNnQ9GdaQ640Xf
STeeCCCmzCUz2AosP9Z1fm+XknCn0bTGoIdIqJwNvSzNkhh02RZ4XDH6wc4RbfywL6POsTg0
OuSnI+Uy1eOHtqar/ZS3Ekp+FrQuYcxKFDUWK+oyt+9iF6Pb/dTRAYwfS/daUjHkh9YIPLpK
fScZMHm6B1XmRL19GEj4VjHIDKOTwLG6gpWsB8/UtL3zMSrmVJuBMN+9mehDQjs1mnRJ2x2B
TeBDdeWJ2iXHeZGil9UfgHu6q+z4VdFeRG3bQ1FJMH0C+dvkWISCZL47pnm3Z0fVv2CoCJ9D
rQ1hx8BRl3Aaie9d7Ip70QplSfXGox8gyOPAtkFAfYfmErrSccjCYq0tKGYaKCy5bkCgwOuv
bUYzzQtTU4LjZprK22AVenTZi7cM1+uZwtKNtuppV+HK7rEtVuuYTUCWAVlUMyAOKGDepRdS
rKVS+OHaVXgdUGmHFAqQ9omJ58U2WK7tNSDYEr1V/M3So7hh8HifYcKmDRcBMQ1Nu1mGIfVp
xJXlkW9rykN+IDrG3FssfKr8nKZ2ONMpH4X8wrT8HT0IE2S1GTcjTBhEaZFC2yW+WsBVXu12
wD45gzXI/7kwiasd1Q4misDn5xjxuHY8T+9Je58+mP4TBm2tu3NGBmOg6Hcsa6QvOdUJlRKf
rWBIp9jxeo4o0gsCeV7FrK2olTmUut6VHx0c0uElZtffZJIV/eBYroxhYjVxS9KXIvqWpKdd
k97NsRWmyxFhgWc7ZF6dTgKN0PKVBnrMXdVkU7tjiCtMYozuBS/UmxEZgFmMO86NxE4Sx6sY
TlROjXhyoAHSYAkHo92OWhuSUPWMIuZsXWbH0It7rjJ65IpWqIiNZD2DIMja+JBU5A0+xpSo
OM+2av5ZgGo/gPkaNWuZKBVnGJeQLj1gdaD0gR7TmNEldSISp1v8t3HBiLoQbBDJ/saZg3rE
axLLiOBkRhSBn/ps1Dh0GNMexEXpwNrDGQKcTm6fv/35+uXj6e3VGTe+2CVWrmcB46HLSxDR
LG4jOMscETSRgAdrj9ICBqSvyJ91IdhR2CjNjjDW+tF6YXnGqCQitgY6VGhJ8ibUIY/1CB+I
EiF3FmQMUoEeTJuKSoUVSjn3bxumvxARc9j7IaEvgYYYr8+0DkmoO47NREL7jcjPZlzAjcCA
AkYUUL10m4Ca2CE+GGoRATV9I1bVMbAmCdM9VhS44UA9YtxsiOgVpQ6MyMBqyQuN8eEzeKme
6XMtwTOTPVAQ/T5kq6XviZmgvDta9JbjWaypGwiFqiwfZKVaeQDcHVlzOzoZksR5HZs3ZBqO
k7dn08GHHaePRPFx40N7Jt0ILTI8Y4yvLYn0R3E6fLiJJcYu0C7fKyT7xMrPsGlWiStNCNDc
poUxywoyiuoiUt/PTcDQ7JMAr0jFWC5XqXCZq7+/riCgFm8KaLSioJvA3kEAHi0pRbRHgypk
9wbtRBb3C42NUhUnbGQValeBu0xa7nxvWyibZPpZuPbXxn6j24cQ1KTtUSdS9PVh1+khnabf
j1ArfBhWa18GqNhBi9PLxGEbkkEzBPY2WkRG38uwXXnWXPE0njvTeLZcr8yoGQJRhAvPqgyB
1m6gEtzeR8CKvlkXV74G217CxcLwxGZbfExKAys9RbaosS1qRzJCxN7zmFRFEanFU2H2eZ3X
wWZJvzuQ6Gith5LV686Lo9nZmuUFIzXcmq+8RagdCfJ6kA511UfQ0Cd3uE80xyHhjmxhI4Hv
0Zf1A0G0XFNdGQZrXaMqiJDM06y0HOlLTbnhtPu5IWdEQfvErABUj76lYbQ4Jj0GNuRAuXsa
bHk6WwraHsOOiSoe9zeopKiLwenXwUwaTeSuIggdsWjlzFIPfVWC8dJZBYqrYLM7bicT0ZEq
PpRsT3pyCll0vMq3gbaEOiC4fdwKqc+n7ivFnBWhp1uiBqgj/4dEzxwpAmlwHsCWi4UFC7wL
BbOH18OJ0SEmXLhiYg7dWerVyTg1yRozFxh7fI9BG5yxxbYoCXl6RcLdUV2djbg3rAkeVB+g
uZS5oeom3aN9pVLc6keQmU9jQsiMVacqb9leWxsTCb46PsqH0/xYOC6AJnI0PAm7E1nAIgch
ao/bywuJ6mUxohnUQaMVvVQUqiQMNtS5oJCI44yaG1NRVTDDfQfR5JwxVqNypMBQaSwldEIa
cpLyqQ3PGh2jqkQaxvfIORAYj+QcVoZBGIb0LDikkYkg4/kmWDhKA3Llrz3K52cigl15FVyo
rqGwsPZobhY4SmlUSaK176jYPFl1nGPrVojkUTDfPNCs1iu6+9QtjoMsjGh/GY3K5VZtEoWO
ZYi6wGo5PyBBoyeL1pGgllytQGopNCokF6lArQNqJUw3Uo7hqjqXidM1LwMbLeZ5a7Aa6LKL
jl9HdKcBFW3ooca1B5+IxoFaRq9gXflS4fZtqILdHT+bmd4pslMULRzpEAyq6IeoNvNsWp8L
aiyGSqYgesWMQhkXeBPGVqQUXL4PvYXruOolgdkhcKh8sWL0OgFk5C/nDwwQlUNvFZBsMGo1
RNcR5wcrR9elyuJTSq9JtHZW3+tCNM4LyBm1FRITt3TsxYPScr3Lmoqi4aTSQVc/k7RAkZvw
wcIVGqcPp0ayVA1SGgal1OmiuTcqKHfzACmrFvOcqWJhbFgWGnzZqSVxzLOGko0bNGfHVQIS
nmYfxEz1I4qyDDZoORkItKexiFnNF/10ipWiExyjzDjq5Ky8r+ZrxWvYmqy3ANn1dps4qr4U
9XzFWVGVZL1NXBRUpWJWT1lMvgYXqbiEe5iMnzjd7rw8fn16uPny9p3IeCRLxawQFwZ94b91
LCtZXoFyfFIIJjVJkGCIJHTgnmho9U4QNwzdb6/T8aShqPSeAzs5ug0/2gZT2jR2fyccLJO7
I/qsMdKAf8qSVGS2Vr+DBJ6WuQ9tbzF+01xhpJs+r1LWuBCQGJacnM59kkJqYkVWinyB5V6N
oS/qLdLChz+d9jhVYHbnEnhqZA7BF8RdtJwjvMt0Tz/UN77OGVKH2aOJ2Q7Uu5i83hgohkdF
5kSICICOlschjg1rZacZELk1cxan5hfgh+6UHrWvCvUK78W5RGjIb+awrTt/LlfZ49ebooh/
4XjH0AdFUK5URTe2x51v7LETnGAcAYeRVTWnMEkhWTvbk/UVwnVD//wPr1+enp8fvv89Re34
+PMV/v3fMJ7X9zf8z5P/BX59e/rfN799f3v9eHz9+v4Pm19wKTQnEdSGp3kauxcta1sWH8yP
hjuiP/YObS7p65e3r6IrXx+H//WdusH8aG8iLMQfj8/f4B+MJzK+b2Z/fn16U0p9+/725fF9
LPjy9JfB8rIL7UkYBJ3M2iZsvQys1QzgDZy9FjjFXFlhTMJ9i7zgdbDUxcJ+ifAgWFC2iQEd
BsvQrA2heeAzq/H8FPgLlsV+sDVxx4R5wdK3ewACxHpNq6wTQUDn1+o3vNpf86KmfbX7FYmn
9LbddQaZ+ExNwsfPaX83ztjKyBAniE5PXx/f1HLmVrv2VBVKgrdt5G0IoOrlOAJXFvCWL2Q+
AaOPRR6tTuvVitJgx1GsPc/iCwm+2DW2pzr0SElfwYc2W57qNfoHmuCzH6nh1QfoZrMIiLYR
TpsNJgKHkXfgiEvg6yYF5ZvhKn3QFjH51dee45lmvwgufggL09HG4+tszf6VLxVZa04w1JpY
wRIxt4CQIiCvZBX8xuJVdhtFqhdzP/cHHsnEvXJoDy+P3x/6ndMORy3LVCd/ZW9hCA2txYDQ
iKS156Q6rVY2D1ancLUhaNdoT7OhZM/WK2qqsY4lZQEY0BtZmcmNfLUirzH6xdtuCs/ziFXd
blrPo0w5I/608Dyz9wgm6+MN6IuYOXaGV5pP4bL0LKbO4fvanlsD+4SRPzLE7vnh/Q8XI7AE
TUTEksfLrZV7ZtHKKjI2KSvs6QUO3n8/vjy+fozns37i1Al8jsBjdnMSpV+hT2f7L7KBL2/Q
AhzseN1BNoAnwzr0D3zoGCgVN0LA0QWG4un9yyPIQa+PbxgkTxcpzMW1DhbWSixCf72xuHR4
sqG8zf0fCDXj20GjX9oDPbuEFPAQxybpU3lVbmF1Ka09lkL9lHvIn+8fby9P/+/xpj3J+VO9
Ayd6jB1W6yFnVSxISp4IUe0SDUeyyFdn00Jq1+hWA2vPid1E0drZu5SF6xX9iMOmc9y8K3QF
zxZkxh6NqPUXetIKE+swjlpkpLeJTuSvVjMtecH1sWOCW/oyXyG6xP5Cu+LUcKFh/NSxIAL/
wHgvOdQSuu0gKtm6dY45Xi55RD7J0cjYxYc9cY7jPMdod/Fioe/zFpYOjmWROdwK7J6Qjo4K
WbrUEkTpDYG85Pw2RRQ1fAWF54w2fVeObHOd9Xnme+Ga7krWbrzAscgbOMtaGgVfPFh4zY7G
3hVe4sFk6jqORbGFMRqPw4fQwcQ2qO6P7483yWl7sxvU5OF4ad/ent9vPlCa/ffj89u3m9fH
/0zKtLotuyoSNPvvD9/+ePryTgWyYnvqmeZpzzBer6JrSwDyNEYi5f/0VsrJC0h+zlqMZ1RR
anCiPmWGH5gtLOuSbUZBueZPgfCk7tjxMhOTWBCJwDmF0ZCE8jTfichqGu624H1IXRu+25Ko
nTDbjS9NKCSmqpcGE2+xsNF5ym67+nDPjZfcSIHxoDvgqqTbZU1hhgbsZyImQ2wism2VgDcI
2KdFJ54KOAap4UbzSa/f3LxZNhKluIwRDQrhSm9SxgHNvdVSb04Esr3U4ijdRNq5ZaHNZOmK
FOTqm5TwmsKWTsVYK1irTJWoVFK9Jw0DAYx+QoRoViRGIN7huc7NT9J6FL/Vg9XoHxhe8ren
3//8/oCeNep6/bECettldTyljI4CLCZx41G+d4g6ASvoH+oEDGB+hVNx3jsipQl2KljoOGQR
fUzo2ygxbZze/MWq37O9P1NvnDXNkXd3sOoco2ti1mBYzENSWHuHwOWnhLbLIsXdxd3vbRUf
KGlBzJbMlgDsoM9szUoRuU187uTp/dvzw983NagIz5rJYCSd750kkeKxoyOSZJdm9/hob3e/
WC/8ZZL5KxYsEqJvmBKzTW/hn02ghu8jCDKQe72YJCnLKseY54v15nPMKJJPSdblLfSmSBd6
dsmJ5jYr90nGa3zZeZssNutksTTZsp8Cmde+y5PNYunmln5KgW67CMI70l1Cp9svw3VAt4m3
jmUeLZbRIXeEp1GIqxPDWSvbYLPwqCA8E22VZ0V66fI4wf+Wx0tWVtT0VBgmT6Qur1r0VduQ
E13xBP+AhN2CILbuwkDNKjjRwd+MV2UWd6fTxVvsFsGy1GXqibZhvN5ieEIRMXVMlndlDhp2
n2RHWHXFau1trs2YQh0ZO4BNW8W3YiI+HRbhGrq9oRmqqcpt1TVbYLskcIxtYCW+SrxVco2X
Juo0ODBa7CapV8GnxcWMjTNfoJifBIU2YowcP0+z26pbBufTztuTBOJeOr8Dbmk8fll4jjmS
ZHwRrE/r5EwK5QT1Mmi9PF14ZMtZC18nu3S8Xa9/gCTanBx9Q5M/iy/hKmS3jrwyI3Fb400L
6JUtsM81juyJl0EByvr8kAVpvdcs7wq2Oeb3uBWE4Wbdne8ue+l30x//xrGglt82WbJPdelJ
1jlitJMFH+R+/+3hy+PN9vvT199N2UfewsOMsvKyjtQ4IeJsxZDclMR9LLZCrE+YS9rEU6tL
S8vbQBzpmG/wkNWYqiWpL+iQtk+7bRQuTkG3Ozs/AoqAdVsGS4ftQs4FimhdzaOV79rcQQKF
P1mkhW2TiGyz8I1JQKAfGAJre8hKjMIUrwIYqQcnql5TW/FDtmXS935tirsGdm1OUAub6q5e
khaRHs/LVQhfRnfhH2RltOuH5AtY8fVGUcgGov5AcaLNRnqraVuyU3ZyS3hNXO9dAlpx4Yam
d+E7RbvEiOIIPlyiIFwrMsuAQEnEVz00VUSgh9IYUEUGiz64o+6TB5ImrVltBCLqUbABhWQk
PYVgHYQW65+21UUYcZ0zJZNxzosHDcaqFipmd3fMmltj+jByrMwmNOwGu+8PL483v/75228Y
yd5UgkCbjYsk16LVA0y4bt2rIJXXBh1UaKREd6ECTGLUnVJO+ABhk/Bnl+V5k8Y2Iq7qe6ic
WYisYPt0m2d6EQ4KM1kXIsi6EKHWNY0LelU1abYvYftKMkY9GRtarNRI2wBM0h3IRGnSqc9/
cCJYfJvrub4BWsDe2CvYejVtlotuAS/tyS/4x5ACgnCzwXkSKhHJYYCtC1pIwYL3INP5C1LW
AjRrYmOmGGylMEW09ia+Fm+dSDhASDkYUEfkGm2yBECdpHSXGZ0pl+SWh7aavXYVBJCqxrOJ
zoCCX9dL5LtsvZTMteMaT5OdnLhs7VBKAJenEcis9JMNZBMraqHWqNsggd+nvfccj0Ek1oXi
tFyKGHaCVePEZk6+c+UJwnlNK1iKGR17APC39w29YQIuSBw2CWyyqpKqoqU6RLcgAjgH2oI8
lbpZmzV0ZkKxwpyVxqwpYJ91ofcp7AnOucWHtk4G2xbd/tIuXSYYrNwdPEp8HvHOylhTRYoS
d1U4O4VRrX3yJZHgBnFtp+27oIgGi7WxsHixNm8segGEPLnEfrd9+PKv56ff//i4+e8b0JTN
fNnKloh6dJwzzntHV6Kz4w6tEU470IQfIqkTKHwEQIDNJ1ETZnhZQqAwwaV24ak0U0Sbpded
85QO1jBRcgaKF/WMaSLpnzSSDbkjN2s0UbRakENA1JpE2S/oJ5x4WLVgdJcEknYJU4jqKAzp
TUHpAgpIVybHfnCh8IEWK15p/ARTts5rCrdNVp7O+8psNfElLktyEVxh9fEWBgVLWqowbZ+g
9FVkU9Zl0FADr46lFqKclxr7yQwwIApa3uAAVMvBzynOZduk5b6ltiQga9hZ7fPxQAqaWN+0
KKVXw7fHL5g2FwtYvitIz5ZoLJo+kYDFzfFCgLqdkvJEQM2lKYDcIXEJ5BHETypumZiLNL/N
SrM+mfzDWSOoz/CLUhMEtjruWaOPpWAxy/N7HRiLW0oDdl+DXMR1IHyLfSWycqh67gCzpijF
O7KdXgV671aFAft8m96bQ9+nxTZrnJ96p+ekQxhUIoyQzum6vac2fcScWd5WtVkhJl0RplBn
jfv7xoomp6Az9EDXxyrTnGuVfGJbcgdCXHvOygMr9Tpu0xKT3hipeRGTx1Z4XBWbWkswT8vq
REtVAl3tM1wjjgqFuFZUR56aXJajwGAC73dwqhrrDfQkwUBmx4oMY1dVO1ryEhQV+t+nLu4v
jnmbCX4wqy5bOnYP4kA9TWmJDrFwWmC4urxy8mWdtgyTf+iDrDHHd2xNfg8G0cfdYk8ynhBX
KeEjU+qMSgKaob5Q65yVwqYaGwu+bkA7NgbDGd77mDBhczaA+Mgiz0qTtk1ZYYHSHFOWp0b7
UGmdH7k5cU3h/oJ7vIEAjdS1onjBmvZTdW/Wq8Jh13Ktx+xUmb2BnYPTz0kE9gBL1Rhve8D0
znaGQxXu7sMRj8Su5oFe6TnLiqo1VuIlK4tKB31Om6offA8dINYG/vk+gcPPXpwcNqCq6Q7H
raOLLK+5epVOHcVTbmFKXBCpjHuRQU17qdIOCBU4lD9yUO8PcdahBSVPeyvONDzEE0/OEAwr
CNW+PcliSHDMMYmj46RHAvhv6Yo+gHiQ8g7dgfHuECdG644SMkKjmDIkwqEqMs0Ir//4+/3p
C0x0/vA3nSa1rGpR4SVOHYZaxMpcQ64htuxwqszOjl9jph9GIyzZp/SG1t7XKX3qYsGmgg8q
fYlImqIgY6qAONJmesb3AebINyizI/GPpy//IuJWDmWPJcenaCAuHYvx5kUtesC82GQSUbsj
bbYruoKe95Hokzgdyy5wZFsaCZtwQ11/lOlZnBPTcsBfUulV1/oE7cTRTVQlSLYNHk0lyIvd
4YwuWOU+TYaZQAXVmjxRjJXBwg/V62oJro9WJ7ZxsQocNqyJIKReMslB6JFKJKxZLLyl5y0N
uIi0tLC6IMDUbA7Y1dK3a1pt1FcHAioTMpm0PdQIqipQupIpa8ZQZFbHARhafQDtXcR6KApV
IhtxvkcBA3v4AF7RNuMeH4XkBfCAjVb2nMZ5esIUMxntXTNNjEORHwlWZBhQgR5CMLWsPdrc
Lc0yrrJw/Hn+ki+i0CpYn+lLZYEc38c7V0ziRwvfqrSPXsmXtKeDnMo2CDf29yHMNDpBH9XD
VW0bMwyeYNXb5nG48RyJlWTFfXCWGd6ApRP+5Wq5an3VTUPWOYZq1OEZD7xdHnibiz13EmWY
IY0t6Oa3t+83vz4/vf7rJ+8f4qhq9tub3ob2J+YfomSVm58mSe4fxia2RQm3sHpT5BdnHNWB
ALjENScYwMoYOkjn62hrbiYin/S9KvbJrybCDTpWPe5KawLor5eD7QRnpP3+9Pvv9q6NotFe
Myup4G5IvUvhKjgiDlXrwBZt4qjzkIJsvk2Zq+R0s/a3yb09RVxT184aCYtBuM/ae3sF9ATu
ULcq1RCYXzcKiEl9+vbx8Ovz4/vNh5zZiefKx4/fnp4x1/gX4dt58xN+gI+H778/fmjPofWp
bljJM+N2ghy9iMHgmDxQatWUoBquTFstdLRREM13JneN0ynCHypzyeI4xejl6DdIm7Qy+LvM
tqykdKkU9uIOtlSM6svj5qh4BgiUdbnctLGerhwBsAkuV5EX2Rgp/KhhbwB4iNuK31P6NGIB
04KOodfTA4e7g//6/vFl8V96ra4YDIgrT0oOegDcPA0+F8o6REI4KnYy26vevoDXTRWbYxEI
2jVedKo5db37+6iZYfuEDjGQy9h4ZOSYnoJtt+HnlAd6FyUmrT4rrz8n+CVSo5uPcCON9ABP
uLhI+tvuncR0MayPo8OGqpKu6ZR9CsmKDtnWExzuiyhc6fGqehQckKuNK1jVROMKQaZS6GGS
NRQdYnCikBHFrAkcglNZlTY8jIM1LfENNBnPPZ+MH6BT+D7VQo9zRIjriS5A4oho11OIRKaO
G1yNhn7GppEEq8CeIoFZEUwsEFFAfpKl15IZwwYCK1bniLgL/FuqytmITwMNEXSKIhKBpWZ6
x0HX2ejXbwNqVwTelV40sIZJtzWFIIw8apBY1KdeKAwEaQFK45rg41OA7wKtb9Rg3Dbi2/EE
dodovCuqs2u7HX7RzRwDCYKlY4vy7R4IeEjTLwk2FHBi5AjfLJwbD+ldM87OZq07907fYQlf
6MpXXnnzXxl3kCXxTeSGSOzmsKB8z6cXVFyvNy7GEO6OZdLH2R2/KL55/oFzLOGBH8xvdLJj
joiXKgduYq0imdz2+eED9I4Xox9G8bioOMkkPrVtAzzUIioq8JBmnlUUdjtWZHrqR51g5msK
go2j6NqP5jdppFn+AE10rQ/rJSkF+Es1meYIN+PQKvAVyWa8vfXWLZs9S5dRq8XmVOABfT4D
JiTjkw4EvFj5S58qu71bOuJ5DmxXh/GC3EuRH+fW5+j1YTO74ZcxSWdGnOIe/vm+vCtqah/p
M9BYa+Lt9WfUyeZXxBi/yzyCWvjfwiM6YoQTHfeOwY/P/NrliVhzjZ7weOxOb0McfRy4jHoy
O4bB3Uq5MMcUOqgbaNrGBHXYooHA9tnFoFxpudd8dhE2hss+sLJMc65j+9wmCkTPjcfyFkP2
FXyPjdr8k5w7dsmwoGKe2fEcFDE1dZU0ZmUAW2nPtTB7mFHxiPv/nD3LcuNIjr/i2NNMxPQ2
HxJFHeZAkZTEFinSJCWr+sJw2+oqRduW15Z3uubrN5GZpIAk0tWzJ1sA8sF8Akg8buOygHcf
0adiVXCC7ZWCDN+d7A5bp8aZOVuGUY2fTseXCxrVqPmyjbv20JmNFJDZtOUqWeyWN+dX8MdE
9chqlllOPHSbOwnnHzd0TexXSNTgpWy8EPSG+rQnwwftDtp/DvdknUwmM0vc26yAYYizDMzm
uEe+1g02ZoJJ+VANiRbJasIY3kQVUdieGXY0F6n42cUZP1CAq+TWS7dZzeetBZoEovj9gCay
vUJBkMm0jkuLhexOp4zXFklWmm3a8qy6rKDeNZY3RkiMvgwsWeZh83dM/ECExu8J2kW1SLck
PYkG2xIdafQCvNgt06pJsm21Y6M86nYLrjMFTLDyRuiup6UOp/Pwdn4//365WX9/Pb79tL/5
+nF8v3Amn+svVVrv2Z3yo1r6Dq3q9MsCP5Y3bbRSFvn96gXH8cz8bWY7GKBKOyi3cvYrxHj9
p+dMwk/IBLOMKR20bxRxkTXxJ/OtqbKmz9tH7h2NreKcT5aH8B45xTGCkzAQ3ndG4yDAoevx
HQlZiQXjQ6a+wocOmvCoqHIxOFnpOQ4MAdOiIqlizw+Awt70QBj4lqrE2g3ZhxuM5746iWKH
F0AGAsF9F59MkCBwQtmt8RzJwj+o/dN+QwWh47Adb4IJy572BK0XUgkTISzu0piCi5uG8dPx
FgPwjAXjp9geXBS+hx8WNHyZT12P6XYEt0JWul7HiQiIKMvqsnODUcUZLNbMczYxU3scHCDc
MWc30m/2Kg6wm2HfYnLregtmgrYC13aR51re5yjZJw1LisJICU5RbsC/d13J8mgBaQEbnvm7
7uXo04oEQRKxsYiuBHxPBWL36eiC0eCtP1o8zdQL2OqyHx+8oTcdn0sCOF65AOywx5OGb9Rf
eLIYzTs638ZLHs6E8QJsIsKmX2enxZYHV3Bd7lpy49VtrvqCpD2ACGHvS9WKizsuuHhBlKjd
ZJW9iru0YleAoArducc7ouzbIKDZT9RLhpjx98v919PLV9NmKnp4OD4d387Px4uhG4oEw+wG
nsUzX2NNb64+bgutVbX0cv90/irDNJ2+ni73T/DSJ7oybnfG338CIT6cPKglM89k3/sefNYa
7k+P/u300+Pp7aiSO5GeDY21Mx8fZxqgc6WhTinwKIcs7dmP2tXBRV/vHwTZy8PROnBodHAo
UPF7Ngmw9eCPK9Me89Ab8Uehm+8vl2/H95MxR/PQoi+UKD6+l7VmWfX2ePnX+e0POT7f/318
+8dN9vx6fJTdjS0rZTo3E8Lppv5iZXoLXMSWECWPb1+/38glCxsli2lb6Syc8t9lr0C9YR7f
z09gefHDGfQa13MdPGc/KjtYhjI7/Np55VlG77/eQeT+j49XqFK0c7x5fz0eH76R4Jc8hSEL
qChvvXzyfn7oHmhYXOPQeXl8O58eyfg2ayGNMrtexQ+7iuXlVj4wC8l1nUbcIQsUKmRXVGEX
/r5RpIjQnV+UUc1ft73uqrNFLl813bJaReDhjSxrt5noYlNFNblMICFFnG+6Q749wD93v9bI
3AM8LZfUMVr87qJV4XrBZCPYsRFukQSBP5kRoUSjIETAxFlYnLYHChxEAMGnfmKpczrjB0qT
QJwBl31jRAQ+DjdB4FOmVRW6wOrMeSWx+Dz3BJPQZVud4LcFDa/iROz1yQheR2E4m47ATZA4
XjSuHgLnuJ7LfFSzdl3H4vMt8U3ieuGcKyn9RrkXAkIw/iYJ95lOAnzKwMeBGxAmnHNWFJoA
Yj8oZw8DnkPk7PGw7mI3cMc9EGAS/6YHV4kgnzH13ElznLIlEUnvsjyGhFC2HOIljncIv7qY
5ooH0DbFETEBIn0MDViSFTQdJwD59JZaqTK2EeoRcKLUJXcg9hRD8MNnE2M4GvZgu/fMQFFy
RjlXbFmBndm4QelyNQaD3yLTj322qC2WocPXyxg+CUSA5Gqw2qH1BJ8PuvJPHhUyFsgIv4vY
XC1VNvH9/upb3b//cbyg+IpXh1KK6UsfshyeEmA6lzhYRpbmCTRK0sysCzAZh8403YKa8oLb
rMah/Dvs90AtVV0us63F92BTxWbwCyVGNMn2JoZsPMxTMsC7aM9e4aKcegrKVlGTku2pQbI4
P/qaoHAtTv89wejRCClBoeMc5zb+ouEOvyO6BPGzu1tbNMG3+YpzqzyEAcpmM6hw+wmLU8gd
htIsK0hWpzlxOwXwOkFOpFGepVsZcoYWb2CPRpVy49TAJE4WEX78SvNc8IKLrKRhLa9gqJR/
fkE0TcHNs6QY9QCApKM9RPzTxHVWQbLcMTLCSvEBajhw6j6VYWiLjAkE9aLlGCGNQ3Epl7tf
srbZjb6hh7fRIsc3AZgSlF293GQ54s5WlTi4yngj1uQSO1y1sQsZ2+9wyKl1Ja1CUWkBGa8B
AOIhhICMRh+LJhvBqiGS4YC5Mr8QHU6BuS2bCO45SkY1Nrt6KRakr7sz1AaW4RsoAC+rTH3K
X05cTUmEkyvJNcsteXGW3FFPfZj9RVHyL17qoRVI2vVum6T1osy5s/qQRWWR0bGEgTO+pkqj
W+s+AGfHFqKljsbuehjHMhykDG7G9KIPe7ZoR2unR60jHFKphxrdlM3ERcXddfrpeduKg9zr
9tSBRiGl4/k+3bYmYi/2C25H11XxT3EKWxWxPXs7BGWpW87xfwhXOlqfxaEwp4A0WEabto6y
nKxpXdutJTeOjFjQrYodZ7Grqq0xO6idUcAvVkC2EFRrNCzw4Rk7BXqvwF3ri+u6bbEfgi4s
RMUWiqPlmB+GW4PssGt00S75ZFzidZvE4P1Q3dVqHnu0FyvtriAUC3jbZpHhib+L7tLMuu6r
WNlZSPc0TvUMIwHm6dfxG8TnKqsQnypT2yurGCQgrwW7mw6fTp/oJK5sPttzA43YnbZ1ONC0
C9ZB8tqpaxEFGmvzDHxdFQ3PffQUvPzRY3O8BnqgWDktVkgDGFJign8uE0utL6YjwBsFoRGg
XxC1hMbsF+xXS55qyar2+6+S9veGvFV2FquBQly50ba8rnCu5nwjI8CX5WaHLJnW0T6V6pMK
whGS9KqDaqXnwuPz8/P55SZ+Oj/8oSIngTKQcKtXdYw1+Ssg102yYZU4Y3NyipxPQmIIh7DS
3px/LelJmmwK4Rr58oCcWh5CEY07YTsuMBMrBkcpQpg4idOZQ5KbGNg5a7GMiRoQKboY8RIA
bu/ywJk4bH8MMQ1h9jFvRolIFsnMDdl4XIhIJ/vsX8p6PTm/eoaFeCd28jYv4+tyk5TN+ePt
4Ti2gxMNNbU4QEJvip/V8k26b02o/Nnpuq+UizwZKK/d5FpFW03cjQtLvLxMDMGOSz+q9dXP
58sRkjqyJsMpxFgA9xpWomIKq0pfn9+/MkaCcGySRzAAyBOMez+TyMF859ooqXy4fyFSEzCX
g0H0+ePl8e70dkRmhAohPuZvzff3y/H5phQz/+30+nfQdD+cfj89IGd1pbx+fjp/FeDmTE2q
ezUzg1blQHX+aC02xqrobm/n+8eH87OtHItX7ymH6ufl2/H4/nD/dLy5Pb9lt7ZKfkSqfPf+
uzjYKhjhJPL24/5JdM3adxZ/nT3gYvqpO5yeTi9/jioa2Po82x7EsbBj1yRXeHjf+EtTf2Vx
QJBf1ult3zH982Z1FoQvZ9ovjRR80F7HAOxKIZ0UvH8fpq7SGq7HaIuD7xECULk14k7Esv0V
Dd6zTRVZS0dNk+1T8yOYsAzXL1ayAnuepAfgjy03flHWXISijAgkYEi3Wy5x+pUrrIsXHKmM
tFBuIeZETfEbUKYBFQVrx0xgnlRbBKv+XTZsGdqtvtUG5mkg8dABC9aRd0yYRZNCl+XHB3W4
l9P4N/tevNEv9khn3oPmGHTISUpbDdDp9AygetzGwJk3ArBUtL5FEbk4q6X47Xnkd+xOHVMZ
gqFmfQhjvMAn0cgqYMD4fDhwIeIllMFRID7EosSxjj9ydWjWWPVNxbGmiwoSokukD6pfCw7k
tc/w4Pfe46+q20OTcG4Wm0P8y8Z1XOKdWcS+53NfURTRbDIlr3EaZNGs91iyDgAY4JCYAhCS
KJICMJ9OXSNHt4aaAGRqXchEdrR/hzjwpjxb2MSRb8t717Qbwf7zpgyAW0SWPEv/DxOXYX+I
y2BVRKCAbIm1IthwsHlSwdCFJhcEiCVziERxAoZATGbEgGUWOKPfXaa0FhHk58KbkaBHRi9C
GrIY7QgxqSNH0mwWGoYqc9esjPUzBNOgcEaKzj2f/p7M6e85sniMDpXnHAQ4prAwpLBYvhi6
GngVL8D9BYCWs2UOJ9KqMgj6O3K7T/OyAmPuNo2JznudhRMfHcjrwww/h2bbyDsczM7kbexN
ZvwKkDiLq5nEzTk3ayG1usSxFACgsib7TML4MESA8wPeXgxE4oA9e4u48sWsoGYFYEL9pQE0
Z0tvo90sxI6UTQIjBUHlVfwZpFsFI9HYIZmaehgORtTDJo3jGSkTAOF6rs/tLo11wsZ1RrW5
XtgoPzyztsBtAtZ8XOJFXe50VKqZzdksrwoZ+pPJuEgYhPys6XZkkB9LnYXvT41tA6k58ngy
naCFqt2zxVwTShDxfb0xruD9MnAdc1FrRv4w2mP/qVWfTO14k6r0j+j2rFNxGeiotbROVEKL
ea9PQgYYmZyFfhDwfbsWUCW+HZ9lBDjlJEerafNIMI9r/S7CzsuiSAPWfz6Om5CcD9GtvkAR
197MHDbzKjSY1dKKalX56BhuqoaG/Nr/Gs4P7JeOvozjfvoXH7NrDI2VQTbryiGw4nZFU7wp
Z8TTY++MCKZwSoWDZU2eAHe8aIZ2FKepVANN1ZcbKsXcWFOhLwXFksmuDQTr3QIvu3HFBpdH
O8PjCL9l4PTAa5tOtVvExrlXy51nTKZOgMxqxG8/cOhvmsBWQCYedywDYkJYC/Gb3MzT6dyD
uEVNalQIcL7G6dyvaRUO7W3gTWqTMxH3nRtYEiXBXRiwEe2gstBguABi0eIDch6YEtR0Np0a
v0P6OzD4HgHh2b/pmEXyrZbZYcjnIatKCMKP8xQ2kwn1aSoCz2cHRNzfU5fyBtOQXo/ikp7M
WD0wYOaeefuBy0/oQWg5270kKKbTGfctCjnz8TmoYYGLbl91y6iPRnbIn+yGwWD+8eP5+btW
GOGTZITTeWmO//NxfHn4Ppg1/xvCpiVJ83OV573uUOlsV2ApfH85v/2cnN4vb6ffPnTe02EG
5338QaLrtZRTERa+3b8ff8oF2fHxJj+fX2/+Jtr9+83vQ7/eUb/olbYU3KflwRRwJpOp+/Sf
tnjNZPHpSJHz6uv3t/P7w/n1ePM+XKJD10Cz4VBJAkCubxxRCsi7f2n9iOV8iJJD3UxYVmtR
rFyS7kH+NnUUEkYO6eUhajzBU2O6K4yWR3AqWFc738G2/hrAXhWrL3Vp0SNIlF3NINFYy9Cj
25XvOQ63o8bzpW7n4/3T5RtihHro2+Wmvr8cb4rzy+li8kjLdDJheRiFmZDDyHdcknddQTzc
SbY9hMRdVB38eD49ni7f0eK79q7wfD6P8LqlKenXIBSwMcLWbePh4KPqN51FDTMutXW7Y6/d
Jps5OKAO/PbITI2+SZ134mC5QMjH5+P9+8fb8fkoeOEPMUaMR9DEoknR2IDbLRpHmYdFkekt
Y+F/M717OH1WcQiIiLyHTRDITUANagmKVV5hCmOc9U7ImyJIGp4Z/mTo8H6CEeiI/xqGXpXf
KvakzHEyPvLA3ifKsaFU8kvSNeQWjHJxgTvIhS6qkmbu480hIXNyeq3d2dT4TScrLnzPDdlX
5wJiBxm0viUamUAFrPU6IAKs9MP8v85UU5dIS7CqvKgSiztynCVufGCbm9ybOy4n0lISj8R+
kzCX5WJ+aSIh+9M4blUtpHo25m9bT6nXb74XB9Ik5owpxGklDjTj/AII8QDYlpHF9L+sWjHB
pLVK9NVzAMqrNjPX9Vn5UCDw40DTbnzfJUtBbIjdPmvYMWrjxp/geNISMPO4GWrFUE8t6iKJ
Y0P1AmZGKxSgydTnP3TXTN3Q457b9vE2p4OuIFgTt0+LPHBmVC7OA5eVy38V0+B5ehr06UB3
sorecP/15XhRemP2ZtmE8xkrBQCCKIOijTPn1WL6eaSIVlt65A5gy2GIKSjTEa18ksW3KGJ/
6k2cf5p8gyzLsxR9w5+hGY5jsB4t4mmIA8MZCHp1mkjyOT2yLnxDw0kxlmEyiPprow+twU2x
mvyPp8vp9en4JxG8pfphdyBVYEJ9Rz88nV6YdTNcRAxeEvRhjG9+Ah/Bl0ch8rwcaetgO1jX
u6odXjPNWxDsvLjnyqF9vhXCzr+eL+J2PDEPl1MPPysmEGyBPlUJcXNi8TiVOEukPoVjtd1C
JhXXgynAupZzBHC2M0aWcyw2p22VAyPKDpllXNgxE2OKIzTlRTV3HZ4Lp0WUePh2fAfuhD1w
FpUTOAXn+rMoKo++2sJvU8qRsJEqqr+8F1GNLfmrxrhO1hXL5BdV7rroKFa/adMaZjBtAipO
KlYP0UyJo5n6reu8lldQi7+YQPqz0cllpArDUFYqUxij4+2Ul3fWlecEqI5fq0hwXMEIQFvq
gcbZNFoJV47zBbyHx1xn48/96ehSI8R6jZ3/PD2DbAFRJx9P78rVfFShZLFM5ihLwKQ+a9Nu
z6qfFq7BZNZLcHBnA6809RJLh81BtIY13QKN9HD7fOrnzmFYBcM4ffo1/7Fn99zQSoCvtylJ
/TWnb3WmH59fQRlE9/T11MsgN3taF2Vc7lSavh6XH+ZOgFk0BaGj2xaV4/AqE4ni44C24pZg
VY8S4SGPUJDP3XBK4hNwn4S435bPEbYvUjMTUc8C3yFTdPHDjBUOoKgtwBMij5PYtDcFdFxz
l7/CKFNxowDEAFy2nFkzYPOKBljvYWaMsRG69wcgfZdZP0J0RAKwvcsplQBIr6k+qHl9e/Pw
7fTK5Juqb+N1VtEwiN0yY+09ogTiI4oieAJHdSMWoorijTVjlDgMwQWw5NwW1dGy/nLTfPz2
Lu30rl3WweWkm+h3BtgVmWAmE4JexEW3KbcR5FHytINpP1yihI64KQqRqSWYNWfPBiQw+1lx
CItbqJ1WXGQHsdKuHSLI6hB1XrgtunWDU+oSFPSXLB7ok7RIGOWhws1GVbUut2lXJEUQWA4c
OryoAjAyjCPe4aKIF+N5Or5BmF95Uj4rHRuJSte39wkZWhWRJfkW7+JlRJbol/A2qcsMxVnQ
gG6RQSXS98aCw2eFUar35vyv306QveIf3/6l//nfl0f1H0p4MG5xiGFpeeTWgSp6lilC2QD6
7Aj453CwKa3l3c3l7f5BXs/jgIBNyyftUc5D7ZrtEVPloKOuViiSko6bWsFXqgfIcVDVK1Ke
a2xvoNauWNVDGbt3tkka7zl/xoFKWxg0OP7rgBRzOnE0btxAEcXrQ+l93hPluW7HJ0vODW7Z
4O40mcxPBl4w2zJJKUbnRqQOfQjRPzMjTBOzgQQkapEajucCWMZoT0iXMcFBHKRMaAqxnDW2
kGQFf7OazT3O+VFjG3eCmTCA0k8CiI6MyQnFI3vxqujKCvkLNRnWFsKvrg8dQKT9PCt49kGK
xLF2+yOeODvA8AKdSkidYCv45QnC5sijFcctjsVqSru7sk50XhgSejQChlgww0LmrqK6YS2E
AVc2mRjOGN356QGcOpakuh7WLcC1RIwT970Qple6npBIZ2CrDmZUX0w8WmGduBchaFlmsQEX
FHtxJbfctblstmWbLUlY3kSB2DmRGJUcCvchsha53ZUtiVQpARDRA9JWqVkGi0b+Bq0FXpe4
i+qt+HSWTlHYstoobFunxNThdlm03Z7jlhUG6UNkBXGLZjnateWymXTYXF3BCGi5g6TUxEI4
FiCekVaBZ1lvv1LMXx59IXVfYZDCOKvFNumSjEwLRxLld9EX0UvB6JV3nzbVwX15sNS3hWV3
MP2XxnQHsWTkyFjqKVIxsmX1ZcRJxPcP347kXFs2cs/yJlGKWjFB78ePx/PN72Lfj7Y9+E11
dHNK0Mb0ncbIfWFepQiseZEu2bEhByWl4A/I6pHAKlqlkEI6AyNJihJyQJ7U6dYsAeZXkLhV
ZxIcsJu03mJuyRC0hMRIP1kCrocXJzBKikPUtmRBrXcrsW8X7BoVjJD0K07BrRn5E8IftS2u
Z+Qy20d1Pw89UzqeNnSnQYRhOAFV7DGeMf2/yo5sOW4c9yuuPO1WJTO2YzvOVvmBktgtTusy
Jbltv6g6TifpmvgoH7WT/foFSFHiAfbsPqScBiAeIEiCAEjAmgLr+SpGZ6jsx+jhh3nq+OLd
7uXx/Pz084cjS3lEghSUADVaJx8pS6ZD8unjJ7f0GfPpNII5Pz2MYo6jGMcT4eH+tpnntvfR
wxzFqjxzzj8ejjKceSQnez6nzIUeyVm0XZ+jBX/+SIX2uiSnh3s+p03eLtEJfUvFbWQkuxcS
ibZGuSPf83UKOTo+jQ0boI78bqjn8yNlmjqPfCkyCDJrr4X/6I6GAZ/EyosNsMGfuR0z4E9+
pwwizvOpa7Rr0yGh/HwOgTdnV7U4HyQB6/12Yr4HWYP6FqkB8SkH3T51O67hoBX1snbrURhZ
s06nEQ9qS2+kKArSXmRIlowXdqrFCQ660YoqE3a2wrstGdJUvaC0AIcL2Oagn10vVzoziVNo
3y3oUPmsoA/PfSVwIpCagaP+65Di7d3bMxqWg3QZK37j7Ko3qDdd9hwfpUPVw9qPuWwF7DCg
nQIZaKlL68MkKKqTPRBnGjqxYVTbDdyueMhyOCbAeRqVemfvbnnaoy6P2SNaZbrrpEjpY7yh
3Ytc0JupWlXUg0s4GQoWP12ADohngrbuZUrpUKitiFSdGUoYpZwXjX2hk0Rjas/84t3vL192
D7+/vWyf7x+/bj/82P58QtOOEYcxR8HMEmanEW3Li3e/Nveb9z8fN1+fdg/vXzbfttCu3df3
mNLyO8rAOy0Sq+3zw/bnwY/N89etcqwEorFMQf8q+qWooMGyB3WOs+kBAp1q/WD3sMNIpN1/
NmM8qWXdEfhuI9pgq7qimESWH5yzaKrkRnL6XaY99HAQoFNe099cocGv/duW46MomjHz6GoQ
5oqF7pdIJm75xdGhlUdipoLzAIgzLZIzlewrzPIL550WJTRiUROYAxf7WaeRpLge6QKWQYvS
1k4jQ2zQcQGa7hv4q86kIav3xqe3LJ5/Pb0+Htw9Pm8PHp8PtMRbj1nox8lZsWS2Bc0BH4dw
zjISGJImxSoVTc5lHBN+lDNYxClgSCqdxCUTjCScNPOg6dGWsFjrV00TUq9sg5UpIa1LghS2
MLYkyh3h4Qfj1CWpjdyqdLdtQLVcHB2fl30RIKq+oIFh9eoPMeh9l8O24xgkxtfwPXO4i21F
ObmwmrcvP3d3H/7c/jq4U9L6/Xnz9ONXIKSyZUH9WSgnPHVeXhphWU60kacyczM3aKfD2+sP
DLi427xuvx7wB9UqfM7937vXHwfs5eXxbqdQ2eZ1EzQzTctwBBTMrz7NQQlgx4dNXdxEIgGn
ubUUmDYx6FjLL8UVwYKcwRp0ZTicqOsGuOW9hM1N0nCwF0kI60LxSwlh42n4bSHXBPfrBe3m
GtENtCzOkeuuJTgKms5akq+IG+HODbNDUc5Ap+x6aqAwy/dVICb55uVHjKlOIjmzgJUsZPU1
8t+nvNKUJm5o+/Ia1iDTj8fEyCmw9v4QLFfoOHcUGhMS4WIRfn19ndO5zObPu6PDTCyCDi3J
Fd0aCr+qMiPT5BjkaVBDKUDmlUM2ZIossyM3KthCkPHtM/749CyoC8DOm+dmLubsKBR9kSAC
i/FRE9hvFiBO6WQwE/5jWHtJwNBGndTLANEtpZd6w2QpabyatRKxe/rhvoE1d47xcA1gnJqc
AB06+s28CV+JUXaDIqs+EWFNqgUyPQnpNdBvQ1LUa3zBcI8QM3zUTrCAZynDY5u6E0rNLMDu
WcARfUZ8lnH6MT6FXKi/xFernN0yKgbajDsrWthXwtVh3HBCUeQqoiQQRC6b2BtBLsnQtvx4
OD2PJOUyIrpnUnc8ZHm3rlWmUb+5I9yMRgx9qm58mhcEnzBQzrmXN43BonBtzKNs3dYB7NzO
1TvRnVCwPFzXb9suMy2Sm4evj/cH1dv9l+2zuQpINY9VrRjShlJ0M5ksTZpDAkNuOBqjl+NA
GhEHG318lJAiKPIPge/0c4z2aW4CLCquA7OjST2Ebk0U2xoVPEqBrAknyYTGg8lesexYt2cW
YutgUVrUBMNyyuPF2ptSHzuV5aW7aSzZspBNnxQjTdsnI9kcXTETdk1pUxFVXp8efh5SjoYT
kaKfWTuZLfvSKm3P0f15hVgsbKS4tyk+gTC1LRpqpu9n+43Co1aPn1NmGbGs8Il/rj3L6CFW
jdEJX/QsxKtV35Re/XLwDYOEdt8fdIDg3Y/t3Z9w0J3Ff8wKY5m6pOPJDvHtxTvL0zLi+XWH
USQzb6imc/hPxuQNUZtfXlKoh1rbyVBH+w//h57O5r0Kq1a+6cXFdGXsy/Pm+dfB8+Pb6+7B
VjEx8s5hRCJgm8eMbZaYmaA50ACqtLkZFrIuvSOkTVLwKoKteDf0nbB9XAa1EFWGWSuAFdAE
20UnM1sLg46VHI6VZaIzdY5gbYtkRVgwJqETdWnnvTYoD6y8lzBBhwVuzmNoi3APyimcyGCB
ckBHntoFc0wpruQqALV2/eC8ywtqslMeaM0mBMxdiRQGZjlPbsgnYm0CT19RGCbXnsh6FAlp
KgfcmbMpuRpSavkUQYMKzxKplY9Ua/122ySrsrq0+ky0ADZK3J69OHqEZjyE36IeB2usuw8r
aLA7w7Y8l+xArZIt+AnRDrU903CyFNy4CXIFpvpzfYtgm2cagjkkqOVbI1V4ph2/OMIFc12d
I5iRzy3PyC6HKUd8h4msqJP1iE7SP4IWjII9AuceD8tbYU1HC1Hc2hkZHUQdgZ+E013ZWpkT
0AAnmmxo66Iu7efXbSj6QY7O6C+wRhvH2rZOBaxEVxxYJpmlvuCyAsuNHZ2pQRikMjjLEMKd
DJSVqlJnooe1ddnlHk6lg2eN0j1s7UDqTPIDyzI5dMPZibOyZuqRubRgkoM05krnsjbEtai7
InHJ03JK45Ztv23efr7i1YPX3fe3x7eXg3tthd48bzcH+G7DvyztEz5WWZobLtF/CFrBhZ2p
2aBbPHQnNx19kLGprIJ+xQoSkXzqDhEjn4FGrhWgg5TIlHPLyYeIRkSjudploeXMYtylvSsV
tTOL8Pe+la8qxigX07DiFv1eM0DISzR9WFWUjUqFOtcvSuc3/Fhk1khj9LFEk2AnLYHt0/YY
d3NHOVDPrJvpdJW1dTjJlrxD50e9yBgRdo/fDPZ2t6jxuKffmvag53/Zc0uBMFQLmKVjLm0p
V86XNSt8307GGzv3nu7PvLtaLpRARXJdb0adVNCn593D65/66s/99oVwyCn1azUgJxy1V4NT
5t9jmJSdCpYWDKRcFqCEFZOP4VOU4rIXvLs4mQZ/VLmDEk7mVmD2MNOUjBeM9sBmNxUrRUpl
ThpZFmXDdEje/dx+eN3dj2rqiyK90/DnkGmqJnM4CmAYJNinrmXBwragqtG2BYsoWzO5oENd
LKqki/grM5iqKicRtTrxSjlNyh4NOzm3H2lfSAY6K4aI6mT2ls8QSoNtA4P0I2FjEs6bqmCg
ImrVzXYD6HKOF3BancmjoALo6gYkE1dAURWi8o4mukg4xaBGjbFtJevSnGycT6T6ONRVQQbz
Ki40tQqqDStc1LCgD2t0oKKLPW3o57r/Z7GaZgRbChXkKC+tNXIGTi5VPYAXh38dWZF9Fh2c
aASjuKnbj2GOtqlRQzE08MJ1xGfbL2/fvzunUxXOAGdLfH7PzWiqS0G82lWoGE78tl5X3gFb
nbtrgQmeImHJc9GD56F3CGSdMQxQNuulg6yTP0AEqOmgtoqRM6D2jH5373OD2dM+HZfQ46IW
beJVGRZ9VSrHRxiT61NJ2m804ZslHBmWVBen8+JIK2TXqxOoX4hGRJuvX0FXfv7w41wsI7lv
LQ4rJmHc8qKo18RcttHUtpOqbqxYyyqzVc+CrMGqjIujIOZglmavNPgora9UYAVIYupPjDYX
cn4nHws5wNfC3p70dM43D9/tC+11uuqb+XXceUevF10UiRsdvlRc2mQNq+zexWnwnkXPocsT
v2XmVaVe4rfVo4DCHoy5KotQVUWMSZx4bNehPcpY2ZBjdquOtfR0Wl9iCtQ0z2p6N4+NwbzO
YN2w2Ne1nX3MAfss00ilD/YdtNgMGkzKTMuBNZIK6O7+CqYsqo7tTFHqhYFXmd5to7MLa19x
3uhdTpvD0IE9Ce7BP16edg/o1H55f3D/9rr9awv/2b7e/fbbb/90RVAXqdJCBzprI2GGhVdk
1GfYBX8C4LGv7/i17fEap8acQcZdJ2jy9VpjhhZmt4pM82tat7wMPlMN844qCAOVOVxBRkSU
yZjZCzfKgvOGqgg5pszvo+bdegyCmdL1kg++zWvu2747kf/PeJpq9boEa5Ba3b1jg0LOMKXV
AKuGvkLfFgifNloRG5reEKN8gn9jrFrAJUHtrw2Co6W1S78UddFJaMuoV1QK+jPHvG6Fs5dp
91Hak2qJEmlAumeYEThE2uaNpdFj4QNcLQlw/ANvHBDEL9tp5ZjfRHDa7/ccVj6tXMpArTSn
7JFtA5cSVnVR/aEVW2t2lzSRdeNpAWrUvvKsCGPe6eube6kWfaW162ijtN5KIkShNTszweeA
WEQtcE7R8bJukdP5gmAaGlKr9AYzM85WA3STzVMoXCWrutGjam3TSpGZersfu5SsyWkac2Bd
eFJDIIe16HI0erR+PRpdqmucajxl5pHgdSlcCxSlOs0EhaDz8sYDpmNpuugZqStM3fVeWSn8
lDcqy4uidzYY+AOD2aHBDk9gPmusopQwrIHQtjY2kvMSjoNwwCF7FNRnTDl+RSMhYczxxiM6
0lZTVF+dRQygoKAtxo/o06jSC/YQ5GuQ2X0E4/CPQxx5YEB9PrQVa9q8JhdAVUgCewSMh8ql
XXhHbAfHg6hre61VBKyCtYKhK1F/SZpHJ2IQTkMWDk+IGRszjYYb0Uywy5wLoMKEE0PlIFA1
hMZLRkbf914ZZt0eZ6sP30/tC9qeOT+PuBHGkXvkVWp6UQikpmOwjzVBrOpsTChFyIhZONEL
PD6hRg3vPDuHBNbdvGSSXjEc9GxHsghiLQ3noTIPehuz7i0HVV85HZBrvn4gMj7UeSqOPn4+
USZzPNsSNZlIeawA2zdGn0xlFass8iKFCh1QjvPWu+XrkkSxWkjVMRUvZ0QHLZn3MlBB43Qy
wfC4GEsdr5Gv5CqDGLKTLGFmLJegvcRq0Br42QnpOlasyPm1fw3Y45W2jus7LqQIjlRt2jhX
8nUcByC6SEpJRaBDEuL4RHRl5DUZgwdtqaCjbxRF34s92GvlkovjKQOJSyHRd91F73RoLntB
rS5WZGTKbyXMqzIYsqsyZvXT/UVtC++nW5NTcapZ+BCMM8nRcYCpf+0XQDDsAjg7Lxrxxi+E
LOEotKfz+ir5ngGKuxtG2VK3rTD6Jk5U8jKFbZw6jJpC8MApOo8H8N1oYjPrMS9Hq6aZ62jR
BJ0X7Z2wyOOLl545tmWYpzFq71QWwdUyc1x8+Huf9bBPlH0N1yE0yTPbl6dwdmEhMckoTYaP
GxgnJrX5KqLZzfnLFS5V9X3QXBAgfFVItFqd5JZ+rC/7jRSO8la7uKjSZM7joRZ5fX5mrnkp
25id/ZkzWYwhT86eZ8OHLFnSi4tD1bfJcJ2RdwWwBU2HS6h5vChAOJUvxNAsu+DpBf9wSrmf
s7qHRcZcL/K+wCcOip6MOlZCOKkZFhPnqA1oK8ZJ4FtTtE1lHjK9+R9eR9IlWhScCh+e8HrW
e/KgUZH7hqOxRPkp0QbqBoA38cdU9Ifm/OUxrirF/j5r5qgDr+99Mntwj5fxcK+NNqGv1vop
r9Df5V/H007l/wKhOWAQHygCAA==

--guaa7rhzg2cz3jss--
