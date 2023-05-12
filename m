Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D25700BB0
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 17:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241900AbjELP3V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 11:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241926AbjELP3D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 11:29:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A237EF5
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 08:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683905332; x=1715441332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4uRCpk5OpKDSPt3U+jwY747ZwoSzT2kAzb5aRw3tcZU=;
  b=MwX2L/QcRXhNJAk+FbnfM/PevhyR6MC5Dg6SNhGfskpPrWIMWuVtEbd/
   1u1t9YRULJ4g7bgF4u42CjAEvMJ7eGdJlgCZRFj7PF7iQqlG233jHBvHL
   qBAHu6zjZVXRQFeua4pWg4yNQHdloLn6TR+6QPrnkXtj9t5TSBHdOqb+E
   ayTeEIVcvJ+DV3jtaoS/9oOk2vPSVk7EnVWY9+DR/tOQfyYRAm25+QDD7
   JnWxLP6HK6PL8LTMlGTqMXYIIjYZVwpwniAEzn7iwpv5jzcmXCxeK3iHR
   hBn6UgX4fdkV6G+IVH/Yo6wbrTK7TFC86yXKVFOTCuI8YqpodHSoLZc0p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="335334625"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="335334625"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 08:28:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="789866910"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="789866910"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 May 2023 08:28:50 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxUhN-0004wu-2X;
        Fri, 12 May 2023 15:28:49 +0000
Date:   Fri, 12 May 2023 23:28:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        linux-acpi@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, rafael@kernel.org,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: Re: [PATCH v1 13/34] platform/wilco_ec: Move handler installing
 logic to driver
Message-ID: <202305122316.bylumx35-lkp@intel.com>
References: <20230512140222.124868-14-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512140222.124868-14-michal.wilczynski@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Michal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on chrome-platform/for-next groeck-staging/hwmon-next linus/master v6.4-rc1 next-20230512]
[cannot apply to jic23-iio/togreg nvdimm/libnvdimm-for-next nvdimm/dax-misc crng-random/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Wilczynski/acpi-Adjust-functions-installing-bus-event-handlers/20230512-220607
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230512140222.124868-14-michal.wilczynski%40intel.com
patch subject: [PATCH v1 13/34] platform/wilco_ec: Move handler installing logic to driver
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230512/202305122316.bylumx35-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/eb24371e3b1a867fba1410400cfc19f6961cff7b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Michal-Wilczynski/acpi-Adjust-functions-installing-bus-event-handlers/20230512-220607
        git checkout eb24371e3b1a867fba1410400cfc19f6961cff7b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/platform/chrome/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305122316.bylumx35-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/platform/chrome/wilco_ec/event.c: In function 'event_device_notify':
   drivers/platform/chrome/wilco_ec/event.c:256:42: error: expected expression before '=' token
     256 |         struct acpi_buffer event_buffer; = { ACPI_ALLOCATE_BUFFER, NULL };
         |                                          ^
>> drivers/platform/chrome/wilco_ec/event.c:257:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     257 |         struct acpi_device *adev = data;
         |         ^~~~~~
   drivers/platform/chrome/wilco_ec/event.c: In function 'event_device_add':
   drivers/platform/chrome/wilco_ec/event.c:487:52: error: 'device' undeclared (first use in this function)
     487 |         error =  acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
         |                                                    ^~~~~~
   drivers/platform/chrome/wilco_ec/event.c:487:52: note: each undeclared identifier is reported only once for each function it appears in
   drivers/platform/chrome/wilco_ec/event.c: In function 'event_device_remove':
   drivers/platform/chrome/wilco_ec/event.c:505:42: error: 'device' undeclared (first use in this function)
     505 |         acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, event_device_notify);
         |                                          ^~~~~~


vim +257 drivers/platform/chrome/wilco_ec/event.c

   253	
   254	static void event_device_notify(acpi_handle handle, u32 value, void *data)
   255	{
   256		struct acpi_buffer event_buffer; = { ACPI_ALLOCATE_BUFFER, NULL };
 > 257		struct acpi_device *adev = data;
   258		union acpi_object *obj;
   259		acpi_status status;
   260	
   261		if (value != EC_ACPI_NOTIFY_EVENT) {
   262			dev_err(&adev->dev, "Invalid event: 0x%08x\n", value);
   263			return;
   264		}
   265	
   266		/* Execute ACPI method to get event data buffer. */
   267		status = acpi_evaluate_object(adev->handle, EC_ACPI_GET_EVENT,
   268					      NULL, &event_buffer);
   269		if (ACPI_FAILURE(status)) {
   270			dev_err(&adev->dev, "Error executing ACPI method %s()\n",
   271				EC_ACPI_GET_EVENT);
   272			return;
   273		}
   274	
   275		obj = (union acpi_object *)event_buffer.pointer;
   276		if (!obj) {
   277			dev_err(&adev->dev, "Nothing returned from %s()\n",
   278				EC_ACPI_GET_EVENT);
   279			return;
   280		}
   281		if (obj->type != ACPI_TYPE_BUFFER) {
   282			dev_err(&adev->dev, "Invalid object returned from %s()\n",
   283				EC_ACPI_GET_EVENT);
   284			kfree(obj);
   285			return;
   286		}
   287		if (obj->buffer.length < sizeof(struct ec_event)) {
   288			dev_err(&adev->dev, "Invalid buffer length %d from %s()\n",
   289				obj->buffer.length, EC_ACPI_GET_EVENT);
   290			kfree(obj);
   291			return;
   292		}
   293	
   294		enqueue_events(adev, obj->buffer.pointer, obj->buffer.length);
   295		kfree(obj);
   296	}
   297	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
