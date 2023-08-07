Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494C7773035
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Aug 2023 22:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjHGURX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Aug 2023 16:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjHGURW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Aug 2023 16:17:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78B010CF;
        Mon,  7 Aug 2023 13:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691439440; x=1722975440;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v77pNGE+feeDfb5yXyNk7i3bSHrdcpf1hNLzQC6GlE8=;
  b=kAzyr1j97/xqh63oW5LgK6T3XRJwWQJZ3BIYbS7CwZjtFdT40v/Pio4P
   bRDL6gt3NfpYTXmBe0PhMh2Ab1Kc5snjdeY7ocPBDHiuUXkcTRqqBA48K
   G/gGrep4KvppfCzTWig6D1X4cTFZCFL7o3itkmw/Zfs2RX14X0pfOXxzN
   8qaMHWXU8jg6ERieqBDR8SGaWUt0Yo3Qt+m6dUkHQnZzyb555/3zRC0ol
   u1JxfRmd6UOHW6oPnbCMTK+/iwsxWdzFAlaNQ0Jz+x+3cBOyf/t+Gee0o
   JoYm9aLRAQ25M4/fnVfPeDNbl5hrjW4F9tBQ3toOR8GxSf0/f9qA8JdmD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="368093406"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="368093406"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 13:17:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="766115780"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="766115780"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Aug 2023 13:17:14 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qT6fB-0004rZ-1L;
        Mon, 07 Aug 2023 20:17:13 +0000
Date:   Tue, 8 Aug 2023 04:17:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 12/13] drivers/acpi/thermal.c:817:22:
 error: redefinition of 'device'
Message-ID: <202308080433.zTgDF79n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   cb7868f075558114df880ebd25d7a0ac7d23f94a
commit: 34af5a3fdf4c63403109630759454e285d26397c [12/13] Merge branch 'acpi-thermal-next' into bleeding-edge
config: i386-randconfig-i011-20230807 (https://download.01.org/0day-ci/archive/20230808/202308080433.zTgDF79n-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230808/202308080433.zTgDF79n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308080433.zTgDF79n-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/thermal.c:817:22: error: redefinition of 'device'
           struct acpi_device *device = data;
                               ^
   drivers/acpi/thermal.c:815:53: note: previous definition is here
   static void acpi_thermal_notify(struct acpi_device *device, u32 event)
                                                       ^
>> drivers/acpi/thermal.c:817:31: error: use of undeclared identifier 'data'
           struct acpi_device *device = data;
                                        ^
>> drivers/acpi/thermal.c:982:8: error: incompatible function pointer types passing 'void (struct acpi_device *, u32)' (aka 'void (struct acpi_device *, unsigned int)') to parameter of type 'acpi_notify_handler' (aka 'void (*)(void *, unsigned int, void *)') [-Wincompatible-function-pointer-types]
                                                    acpi_thermal_notify);
                                                    ^~~~~~~~~~~~~~~~~~~
   include/acpi/acpi_bus.h:520:29: note: passing argument to parameter 'handler' here
                                       acpi_notify_handler handler);
                                                           ^
   drivers/acpi/thermal.c:1007:12: error: incompatible function pointer types passing 'void (struct acpi_device *, u32)' (aka 'void (struct acpi_device *, unsigned int)') to parameter of type 'acpi_notify_handler' (aka 'void (*)(void *, unsigned int, void *)') [-Wincompatible-function-pointer-types]
                                          acpi_thermal_notify);
                                          ^~~~~~~~~~~~~~~~~~~
   include/acpi/acpi_bus.h:523:29: note: passing argument to parameter 'handler' here
                                       acpi_notify_handler handler);
                                                           ^
   drivers/acpi/thermal.c:1026:25: warning: variable 'result' set but not used [-Wunused-but-set-variable]
           int i, j, power_state, result;
                                  ^
   1 warning and 4 errors generated.


vim +/device +817 drivers/acpi/thermal.c

3f655ef8c439e0 Zhang Rui         2008-01-17  809  
3f655ef8c439e0 Zhang Rui         2008-01-17  810  
^1da177e4c3f41 Linus Torvalds    2005-04-16  811  /* --------------------------------------------------------------------------
^1da177e4c3f41 Linus Torvalds    2005-04-16  812                                   Driver Interface
^1da177e4c3f41 Linus Torvalds    2005-04-16  813     -------------------------------------------------------------------------- */
^1da177e4c3f41 Linus Torvalds    2005-04-16  814  
342d550db1bc0b Bjorn Helgaas     2009-04-07  815  static void acpi_thermal_notify(struct acpi_device *device, u32 event)
^1da177e4c3f41 Linus Torvalds    2005-04-16  816  {
9d67b6acf1358b Michal Wilczynski 2023-07-03 @817  	struct acpi_device *device = data;
342d550db1bc0b Bjorn Helgaas     2009-04-07  818  	struct acpi_thermal *tz = acpi_driver_data(device);
^1da177e4c3f41 Linus Torvalds    2005-04-16  819  
^1da177e4c3f41 Linus Torvalds    2005-04-16  820  	if (!tz)
d550d98d331737 Patrick Mochel    2006-06-27  821  		return;
^1da177e4c3f41 Linus Torvalds    2005-04-16  822  
^1da177e4c3f41 Linus Torvalds    2005-04-16  823  	switch (event) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  824  	case ACPI_THERMAL_NOTIFY_TEMPERATURE:
81b704d3e4674e Rafael J. Wysocki 2021-01-14  825  		acpi_queue_thermal_check(tz);
^1da177e4c3f41 Linus Torvalds    2005-04-16  826  		break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  827  	case ACPI_THERMAL_NOTIFY_THRESHOLDS:
^1da177e4c3f41 Linus Torvalds    2005-04-16  828  	case ACPI_THERMAL_NOTIFY_DEVICES:
95d37fab16ec7a Rafael J. Wysocki 2023-08-04  829  		acpi_thermal_trips_update(tz, event);
^1da177e4c3f41 Linus Torvalds    2005-04-16  830  		break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  831  	default:
f86b15a1e65414 Rafael J. Wysocki 2021-02-03  832  		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
f86b15a1e65414 Rafael J. Wysocki 2021-02-03  833  				  event);
^1da177e4c3f41 Linus Torvalds    2005-04-16  834  		break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  835  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  836  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  837  
261cba2deb7d3b Zhang Rui         2012-11-27  838  /*
261cba2deb7d3b Zhang Rui         2012-11-27  839   * On some platforms, the AML code has dependency about
261cba2deb7d3b Zhang Rui         2012-11-27  840   * the evaluating order of _TMP and _CRT/_HOT/_PSV/_ACx.
261cba2deb7d3b Zhang Rui         2012-11-27  841   * 1. On HP Pavilion G4-1016tx, _TMP must be invoked after
261cba2deb7d3b Zhang Rui         2012-11-27  842   *    /_CRT/_HOT/_PSV/_ACx, or else system will be power off.
261cba2deb7d3b Zhang Rui         2012-11-27  843   * 2. On HP Compaq 6715b/6715s, the return value of _PSV is 0
261cba2deb7d3b Zhang Rui         2012-11-27  844   *    if _TMP has never been evaluated.
261cba2deb7d3b Zhang Rui         2012-11-27  845   *
261cba2deb7d3b Zhang Rui         2012-11-27  846   * As this dependency is totally transparent to OS, evaluate
261cba2deb7d3b Zhang Rui         2012-11-27  847   * all of them once, in the order of _CRT/_HOT/_PSV/_ACx,
261cba2deb7d3b Zhang Rui         2012-11-27  848   * _TMP, before they are actually used.
261cba2deb7d3b Zhang Rui         2012-11-27  849   */
261cba2deb7d3b Zhang Rui         2012-11-27  850  static void acpi_thermal_aml_dependency_fix(struct acpi_thermal *tz)
261cba2deb7d3b Zhang Rui         2012-11-27  851  {
261cba2deb7d3b Zhang Rui         2012-11-27  852  	acpi_handle handle = tz->device->handle;
261cba2deb7d3b Zhang Rui         2012-11-27  853  	unsigned long long value;
261cba2deb7d3b Zhang Rui         2012-11-27  854  	int i;
261cba2deb7d3b Zhang Rui         2012-11-27  855  
261cba2deb7d3b Zhang Rui         2012-11-27  856  	acpi_evaluate_integer(handle, "_CRT", NULL, &value);
261cba2deb7d3b Zhang Rui         2012-11-27  857  	acpi_evaluate_integer(handle, "_HOT", NULL, &value);
261cba2deb7d3b Zhang Rui         2012-11-27  858  	acpi_evaluate_integer(handle, "_PSV", NULL, &value);
261cba2deb7d3b Zhang Rui         2012-11-27  859  	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
261cba2deb7d3b Zhang Rui         2012-11-27  860  		char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
261cba2deb7d3b Zhang Rui         2012-11-27  861  		acpi_status status;
261cba2deb7d3b Zhang Rui         2012-11-27  862  
261cba2deb7d3b Zhang Rui         2012-11-27  863  		status = acpi_evaluate_integer(handle, name, NULL, &value);
261cba2deb7d3b Zhang Rui         2012-11-27  864  		if (status == AE_NOT_FOUND)
261cba2deb7d3b Zhang Rui         2012-11-27  865  			break;
261cba2deb7d3b Zhang Rui         2012-11-27  866  	}
261cba2deb7d3b Zhang Rui         2012-11-27  867  	acpi_evaluate_integer(handle, "_TMP", NULL, &value);
261cba2deb7d3b Zhang Rui         2012-11-27  868  }
261cba2deb7d3b Zhang Rui         2012-11-27  869  
4be44fcd3bf648 Len Brown         2005-08-05  870  static int acpi_thermal_get_info(struct acpi_thermal *tz)
^1da177e4c3f41 Linus Torvalds    2005-04-16  871  {
36f554046bd6da Rafael J. Wysocki 2022-10-04  872  	int result;
^1da177e4c3f41 Linus Torvalds    2005-04-16  873  
^1da177e4c3f41 Linus Torvalds    2005-04-16  874  	if (!tz)
d550d98d331737 Patrick Mochel    2006-06-27  875  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  876  
261cba2deb7d3b Zhang Rui         2012-11-27  877  	acpi_thermal_aml_dependency_fix(tz);
261cba2deb7d3b Zhang Rui         2012-11-27  878  
9bcb8118965ab4 Matthew Garrett   2012-02-01  879  	/* Get trip points [_CRT, _PSV, etc.] (required) */
9bcb8118965ab4 Matthew Garrett   2012-02-01  880  	result = acpi_thermal_get_trip_points(tz);
^1da177e4c3f41 Linus Torvalds    2005-04-16  881  	if (result)
d550d98d331737 Patrick Mochel    2006-06-27  882  		return result;
^1da177e4c3f41 Linus Torvalds    2005-04-16  883  
9bcb8118965ab4 Matthew Garrett   2012-02-01  884  	/* Get temperature [_TMP] (required) */
9bcb8118965ab4 Matthew Garrett   2012-02-01  885  	result = acpi_thermal_get_temperature(tz);
^1da177e4c3f41 Linus Torvalds    2005-04-16  886  	if (result)
d550d98d331737 Patrick Mochel    2006-06-27  887  		return result;
^1da177e4c3f41 Linus Torvalds    2005-04-16  888  
^1da177e4c3f41 Linus Torvalds    2005-04-16  889  	/* Set the cooling mode [_SCP] to active cooling (default) */
c31b3a1b004c10 Rafael J. Wysocki 2023-06-04  890  	acpi_execute_simple_method(tz->device->handle, "_SCP",
c31b3a1b004c10 Rafael J. Wysocki 2023-06-04  891  				   ACPI_THERMAL_MODE_ACTIVE);
^1da177e4c3f41 Linus Torvalds    2005-04-16  892  
^1da177e4c3f41 Linus Torvalds    2005-04-16  893  	/* Get default polling frequency [_TZP] (optional) */
^1da177e4c3f41 Linus Torvalds    2005-04-16  894  	if (tzp)
^1da177e4c3f41 Linus Torvalds    2005-04-16  895  		tz->polling_frequency = tzp;
^1da177e4c3f41 Linus Torvalds    2005-04-16  896  	else
^1da177e4c3f41 Linus Torvalds    2005-04-16  897  		acpi_thermal_get_polling_frequency(tz);
^1da177e4c3f41 Linus Torvalds    2005-04-16  898  
d550d98d331737 Patrick Mochel    2006-06-27  899  	return 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  900  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  901  
13614e37e94da4 Jean Delvare      2009-04-06  902  /*
13614e37e94da4 Jean Delvare      2009-04-06  903   * The exact offset between Kelvin and degree Celsius is 273.15. However ACPI
13614e37e94da4 Jean Delvare      2009-04-06  904   * handles temperature values with a single decimal place. As a consequence,
13614e37e94da4 Jean Delvare      2009-04-06  905   * some implementations use an offset of 273.1 and others use an offset of
13614e37e94da4 Jean Delvare      2009-04-06  906   * 273.2. Try to find out which one is being used, to present the most
13614e37e94da4 Jean Delvare      2009-04-06  907   * accurate and visually appealing number.
13614e37e94da4 Jean Delvare      2009-04-06  908   *
13614e37e94da4 Jean Delvare      2009-04-06  909   * The heuristic below should work for all ACPI thermal zones which have a
13614e37e94da4 Jean Delvare      2009-04-06  910   * critical trip point with a value being a multiple of 0.5 degree Celsius.
13614e37e94da4 Jean Delvare      2009-04-06  911   */
13614e37e94da4 Jean Delvare      2009-04-06  912  static void acpi_thermal_guess_offset(struct acpi_thermal *tz)
13614e37e94da4 Jean Delvare      2009-04-06  913  {
7266c88cbaa3de Rafael J. Wysocki 2023-06-04  914  	if (tz->trips.critical.valid &&
13614e37e94da4 Jean Delvare      2009-04-06  915  	    (tz->trips.critical.temperature % 5) == 1)
7f49a5cb94e68a Akinobu Mita      2020-01-30  916  		tz->kelvin_offset = 273100;
13614e37e94da4 Jean Delvare      2009-04-06  917  	else
7f49a5cb94e68a Akinobu Mita      2020-01-30  918  		tz->kelvin_offset = 273200;
13614e37e94da4 Jean Delvare      2009-04-06  919  }
13614e37e94da4 Jean Delvare      2009-04-06  920  
a59ffb2062df3a Aaron Lu          2014-03-04  921  static void acpi_thermal_check_fn(struct work_struct *work)
a59ffb2062df3a Aaron Lu          2014-03-04  922  {
a59ffb2062df3a Aaron Lu          2014-03-04  923  	struct acpi_thermal *tz = container_of(work, struct acpi_thermal,
a59ffb2062df3a Aaron Lu          2014-03-04  924  					       thermal_check_work);
81b704d3e4674e Rafael J. Wysocki 2021-01-14  925  
81b704d3e4674e Rafael J. Wysocki 2021-01-14  926  	/*
81b704d3e4674e Rafael J. Wysocki 2021-01-14  927  	 * In general, it is not sufficient to check the pending bit, because
81b704d3e4674e Rafael J. Wysocki 2021-01-14  928  	 * subsequent instances of this function may be queued after one of them
81b704d3e4674e Rafael J. Wysocki 2021-01-14  929  	 * has started running (e.g. if _TMP sleeps).  Avoid bailing out if just
81b704d3e4674e Rafael J. Wysocki 2021-01-14  930  	 * one of them is running, though, because it may have done the actual
81b704d3e4674e Rafael J. Wysocki 2021-01-14  931  	 * check some time ago, so allow at least one of them to block on the
81b704d3e4674e Rafael J. Wysocki 2021-01-14  932  	 * mutex while another one is running the update.
81b704d3e4674e Rafael J. Wysocki 2021-01-14  933  	 */
81b704d3e4674e Rafael J. Wysocki 2021-01-14  934  	if (!refcount_dec_not_one(&tz->thermal_check_count))
81b704d3e4674e Rafael J. Wysocki 2021-01-14  935  		return;
81b704d3e4674e Rafael J. Wysocki 2021-01-14  936  
81b704d3e4674e Rafael J. Wysocki 2021-01-14  937  	mutex_lock(&tz->thermal_check_lock);
81b704d3e4674e Rafael J. Wysocki 2021-01-14  938  
81b704d3e4674e Rafael J. Wysocki 2021-01-14  939  	thermal_zone_device_update(tz->thermal_zone, THERMAL_EVENT_UNSPECIFIED);
81b704d3e4674e Rafael J. Wysocki 2021-01-14  940  
81b704d3e4674e Rafael J. Wysocki 2021-01-14  941  	refcount_inc(&tz->thermal_check_count);
81b704d3e4674e Rafael J. Wysocki 2021-01-14  942  
81b704d3e4674e Rafael J. Wysocki 2021-01-14  943  	mutex_unlock(&tz->thermal_check_lock);
a59ffb2062df3a Aaron Lu          2014-03-04  944  }
a59ffb2062df3a Aaron Lu          2014-03-04  945  
4be44fcd3bf648 Len Brown         2005-08-05  946  static int acpi_thermal_add(struct acpi_device *device)
^1da177e4c3f41 Linus Torvalds    2005-04-16  947  {
36f554046bd6da Rafael J. Wysocki 2022-10-04  948  	struct acpi_thermal *tz;
36f554046bd6da Rafael J. Wysocki 2022-10-04  949  	int result;
^1da177e4c3f41 Linus Torvalds    2005-04-16  950  
^1da177e4c3f41 Linus Torvalds    2005-04-16  951  	if (!device)
d550d98d331737 Patrick Mochel    2006-06-27  952  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  953  
36bcbec7ce21e2 Burman Yan        2006-12-19  954  	tz = kzalloc(sizeof(struct acpi_thermal), GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds    2005-04-16  955  	if (!tz)
d550d98d331737 Patrick Mochel    2006-06-27  956  		return -ENOMEM;
^1da177e4c3f41 Linus Torvalds    2005-04-16  957  
8348e1b19a06b1 Patrick Mochel    2006-05-19  958  	tz->device = device;
^1da177e4c3f41 Linus Torvalds    2005-04-16  959  	strcpy(tz->name, device->pnp.bus_id);
^1da177e4c3f41 Linus Torvalds    2005-04-16  960  	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
^1da177e4c3f41 Linus Torvalds    2005-04-16  961  	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
db89b4f0dbab83 Pavel Machek      2008-09-22  962  	device->driver_data = tz;
3f655ef8c439e0 Zhang Rui         2008-01-17  963  
^1da177e4c3f41 Linus Torvalds    2005-04-16  964  	result = acpi_thermal_get_info(tz);
^1da177e4c3f41 Linus Torvalds    2005-04-16  965  	if (result)
3f655ef8c439e0 Zhang Rui         2008-01-17  966  		goto free_memory;
3f655ef8c439e0 Zhang Rui         2008-01-17  967  
13614e37e94da4 Jean Delvare      2009-04-06  968  	acpi_thermal_guess_offset(tz);
13614e37e94da4 Jean Delvare      2009-04-06  969  
3f655ef8c439e0 Zhang Rui         2008-01-17  970  	result = acpi_thermal_register_thermal_zone(tz);
3f655ef8c439e0 Zhang Rui         2008-01-17  971  	if (result)
3f655ef8c439e0 Zhang Rui         2008-01-17  972  		goto free_memory;
^1da177e4c3f41 Linus Torvalds    2005-04-16  973  
81b704d3e4674e Rafael J. Wysocki 2021-01-14  974  	refcount_set(&tz->thermal_check_count, 3);
81b704d3e4674e Rafael J. Wysocki 2021-01-14  975  	mutex_init(&tz->thermal_check_lock);
a59ffb2062df3a Aaron Lu          2014-03-04  976  	INIT_WORK(&tz->thermal_check_work, acpi_thermal_check_fn);
a59ffb2062df3a Aaron Lu          2014-03-04  977  
f86b15a1e65414 Rafael J. Wysocki 2021-02-03  978  	pr_info("%s [%s] (%ld C)\n", acpi_device_name(device),
7f49a5cb94e68a Akinobu Mita      2020-01-30  979  		acpi_device_bid(device), deci_kelvin_to_celsius(tz->temperature));
^1da177e4c3f41 Linus Torvalds    2005-04-16  980  
9d67b6acf1358b Michal Wilczynski 2023-07-03  981  	result = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
9d67b6acf1358b Michal Wilczynski 2023-07-03 @982  						 acpi_thermal_notify);
9d67b6acf1358b Michal Wilczynski 2023-07-03  983  	if (result)
9d67b6acf1358b Michal Wilczynski 2023-07-03  984  		goto flush_wq;
9d67b6acf1358b Michal Wilczynski 2023-07-03  985  
9d67b6acf1358b Michal Wilczynski 2023-07-03  986  	return 0;
9d67b6acf1358b Michal Wilczynski 2023-07-03  987  
9d67b6acf1358b Michal Wilczynski 2023-07-03  988  flush_wq:
9d67b6acf1358b Michal Wilczynski 2023-07-03  989  	flush_workqueue(acpi_thermal_pm_queue);
9d67b6acf1358b Michal Wilczynski 2023-07-03  990  	acpi_thermal_unregister_thermal_zone(tz);
3f655ef8c439e0 Zhang Rui         2008-01-17  991  free_memory:
^1da177e4c3f41 Linus Torvalds    2005-04-16  992  	kfree(tz);
9d67b6acf1358b Michal Wilczynski 2023-07-03  993  
d550d98d331737 Patrick Mochel    2006-06-27  994  	return result;
^1da177e4c3f41 Linus Torvalds    2005-04-16  995  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  996  

:::::: The code at line 817 was first introduced by commit
:::::: 9d67b6acf1358b67a6de3302dc9c344a7cab4807 ACPI: thermal: Install Notify() handler directly

:::::: TO: Michal Wilczynski <michal.wilczynski@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
