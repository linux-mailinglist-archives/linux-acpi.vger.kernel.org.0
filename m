Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CFC700CD5
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 18:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjELQU4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 12:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjELQUz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 12:20:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3586519A6
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683908453; x=1715444453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gykt74g5vyyXVSMUUlyWHHHNoxdIWA6eEh4Lq6WpaKg=;
  b=bAPgmyzsiE+GWafZctWoQYG1nquqnAHQZkCwUMoYAUZqKtYV2AZFunlY
   N4rRMCOMTfV1Pm8rVQ75TVE7gOWCjZ/UClRW4DmeTleXymYVM9UspM3pc
   9Yqit6KFjKA0wxXRDaqSxhR0EOpPpEUPv4lm+cIDI2Dkwv7wHhZ7TOaU+
   BvdwKTG23XWUAJ7/nT7lsv8uknOoitp8d2zpzVxFbPGVG5815Kokr6W0Q
   pI43GKF571rXtABOTtJ4HhwMDF3jao6wE7LVlEroXzrEB1fOw2fZ/gnn6
   MSy8ZHyfq3KzVhcqqSpHAhz0sn33/9sjIirN2RobyUYK4TV+TkGxbbOk+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="353077804"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="353077804"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 09:20:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="765219557"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="765219557"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 May 2023 09:20:51 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxVVi-0004xw-1Z;
        Fri, 12 May 2023 16:20:50 +0000
Date:   Sat, 13 May 2023 00:20:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        linux-acpi@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, rafael@kernel.org,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: Re: [PATCH v1 19/34] platform/x86/dell/dell-rbtn: Move handler
 installing logic to driver
Message-ID: <202305130030.NokUGQJH-lkp@intel.com>
References: <20230512140222.124868-20-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512140222.124868-20-michal.wilczynski@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Michal,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on chrome-platform/for-next groeck-staging/hwmon-next linus/master v6.4-rc1 next-20230512]
[cannot apply to jic23-iio/togreg nvdimm/libnvdimm-for-next nvdimm/dax-misc crng-random/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Wilczynski/acpi-Adjust-functions-installing-bus-event-handlers/20230512-220607
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230512140222.124868-20-michal.wilczynski%40intel.com
patch subject: [PATCH v1 19/34] platform/x86/dell/dell-rbtn: Move handler installing logic to driver
config: x86_64-randconfig-a002 (https://download.01.org/0day-ci/archive/20230513/202305130030.NokUGQJH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/fd693de93ac3039fc70c1f75327ed1d54f3a55f7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Michal-Wilczynski/acpi-Adjust-functions-installing-bus-event-handlers/20230512-220607
        git checkout fd693de93ac3039fc70c1f75327ed1d54f3a55f7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/dell/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305130030.NokUGQJH-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/platform/x86/dell/dell-rbtn.c: In function 'rbtn_add':
>> drivers/platform/x86/dell/dell-rbtn.c:427:78: error: passing argument 3 of 'acpi_device_install_event_handler' from incompatible pointer type [-Werror=incompatible-pointer-types]
     427 |         return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, rbtn_notify);
         |                                                                              ^~~~~~~~~~~
         |                                                                              |
         |                                                                              void (*)(struct acpi_device *, u32) {aka void (*)(struct acpi_device *, unsigned int)}
   In file included from include/linux/acpi.h:34,
                    from drivers/platform/x86/dell/dell-rbtn.c:9:
   include/acpi/acpi_bus.h:519:46: note: expected 'void (*)(void *, u32,  void *)' {aka 'void (*)(void *, unsigned int,  void *)'} but argument is of type 'void (*)(struct acpi_device *, u32)' {aka 'void (*)(struct acpi_device *, unsigned int)'}
     519 |                                       void (*notify)(acpi_handle, u32, void*));
         |                                       ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/dell/dell-rbtn.c: In function 'rbtn_remove':
>> drivers/platform/x86/dell/dell-rbtn.c:435:70: error: passing argument 3 of 'acpi_device_remove_event_handler' from incompatible pointer type [-Werror=incompatible-pointer-types]
     435 |         acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, rbtn_notify);
         |                                                                      ^~~~~~~~~~~
         |                                                                      |
         |                                                                      void (*)(struct acpi_device *, u32) {aka void (*)(struct acpi_device *, unsigned int)}
   In file included from include/linux/acpi.h:34,
                    from drivers/platform/x86/dell/dell-rbtn.c:9:
   include/acpi/acpi_bus.h:522:46: note: expected 'void (*)(void *, u32,  void *)' {aka 'void (*)(void *, unsigned int,  void *)'} but argument is of type 'void (*)(struct acpi_device *, u32)' {aka 'void (*)(struct acpi_device *, unsigned int)'}
     522 |                                       void (*notify)(acpi_handle, u32, void*));
         |                                       ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/dell/dell-rbtn.c: At top level:
>> drivers/platform/x86/dell/dell-rbtn.c:452:13: error: conflicting types for 'rbtn_notify'; have 'void(void *, u32,  void *)' {aka 'void(void *, unsigned int,  void *)'}
     452 | static void rbtn_notify(acpi_handle handle, u32 event, void *data)
         |             ^~~~~~~~~~~
   drivers/platform/x86/dell/dell-rbtn.c:210:13: note: previous declaration of 'rbtn_notify' with type 'void(struct acpi_device *, u32)' {aka 'void(struct acpi_device *, unsigned int)'}
     210 | static void rbtn_notify(struct acpi_device *device, u32 event);
         |             ^~~~~~~~~~~
>> drivers/platform/x86/dell/dell-rbtn.c:210:13: warning: 'rbtn_notify' used but never defined
   drivers/platform/x86/dell/dell-rbtn.c:452:13: warning: 'rbtn_notify' defined but not used [-Wunused-function]
     452 | static void rbtn_notify(acpi_handle handle, u32 event, void *data)
         |             ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/acpi_device_install_event_handler +427 drivers/platform/x86/dell/dell-rbtn.c

   379	
   380	
   381	/*
   382	 * acpi driver functions
   383	 */
   384	
   385	static int rbtn_add(struct acpi_device *device)
   386	{
   387		struct rbtn_data *rbtn_data;
   388		enum rbtn_type type;
   389		int ret = 0;
   390	
   391		type = rbtn_check(device);
   392		if (type == RBTN_UNKNOWN) {
   393			dev_info(&device->dev, "Unknown device type\n");
   394			return -EINVAL;
   395		}
   396	
   397		ret = rbtn_acquire(device, true);
   398		if (ret < 0) {
   399			dev_err(&device->dev, "Cannot enable device\n");
   400			return ret;
   401		}
   402	
   403		rbtn_data = devm_kzalloc(&device->dev, sizeof(*rbtn_data), GFP_KERNEL);
   404		if (!rbtn_data)
   405			return -ENOMEM;
   406	
   407		rbtn_data->type = type;
   408		device->driver_data = rbtn_data;
   409	
   410		switch (rbtn_data->type) {
   411		case RBTN_TOGGLE:
   412			ret = rbtn_input_init(rbtn_data);
   413			break;
   414		case RBTN_SLIDER:
   415			if (auto_remove_rfkill && rbtn_chain_head.head)
   416				ret = 0;
   417			else
   418				ret = rbtn_rfkill_init(device);
   419			break;
   420		default:
   421			ret = -EINVAL;
   422		}
   423	
   424		if (ret)
   425			return ret;
   426	
 > 427		return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, rbtn_notify);
   428	
   429	}
   430	
   431	static void rbtn_remove(struct acpi_device *device)
   432	{
   433		struct rbtn_data *rbtn_data = device->driver_data;
   434	
 > 435		acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, rbtn_notify);
   436	
   437		switch (rbtn_data->type) {
   438		case RBTN_TOGGLE:
   439			rbtn_input_exit(rbtn_data);
   440			break;
   441		case RBTN_SLIDER:
   442			rbtn_rfkill_exit(device);
   443			break;
   444		default:
   445			break;
   446		}
   447	
   448		rbtn_acquire(device, false);
   449		device->driver_data = NULL;
   450	}
   451	
 > 452	static void rbtn_notify(acpi_handle handle, u32 event, void *data)
   453	{
   454		struct acpi_device *device = data;
   455		struct rbtn_data *rbtn_data;
   456	
   457		rbtn_data = device->driver_data;
   458	
   459		/*
   460		 * Some BIOSes send a notification at resume.
   461		 * Ignore it to prevent unwanted input events.
   462		 */
   463		if (rbtn_data->suspended) {
   464			dev_dbg(&device->dev, "ACPI notification ignored\n");
   465			return;
   466		}
   467	
   468		if (event != 0x80) {
   469			dev_info(&device->dev, "Received unknown event (0x%x)\n",
   470				 event);
   471			return;
   472		}
   473	
   474		switch (rbtn_data->type) {
   475		case RBTN_TOGGLE:
   476			rbtn_input_event(rbtn_data);
   477			break;
   478		case RBTN_SLIDER:
   479			rbtn_rfkill_event(device);
   480			atomic_notifier_call_chain(&rbtn_chain_head, event, device);
   481			break;
   482		default:
   483			break;
   484		}
   485	}
   486	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
