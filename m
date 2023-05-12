Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE103700DB8
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 19:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbjELRL5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 13:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjELRL4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 13:11:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89450526F
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 10:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683911514; x=1715447514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xvMiasqrMH8K8WgvBvkOYPOzcAh+VY6MTTrFLmR90rU=;
  b=ibxgAGi15Chw1V1F1suzCpwi7I2IkYWp8bes5MTx+hPrjmPU81j0QEde
   W7RYDtk43fRGCTC17kLYKrS3E3Cv2T52Qax4TcL7f92d3uI7kR8ShjIve
   /UdRkgCGcdMfBKEFzn1hM3+oaacgnlqsjRmjIRrp0czIXXVUAQtjgGB2s
   rSsNRz7GP1TBKSndduB0/pZpZFHIix/1T/O0Ly92XPGtJYyse6ZHX2F0a
   kpE0olbqC2ChRc5O4Rm+jXptoe0/Ur+mT3VuW6w9ciilGSNnXGu7QL3kO
   qXWICKZxQ5rpostE/NRGmSt+KKW1ZxGgYLNc47Fyj/EKQ3CPnIY71bbc7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="335360321"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="335360321"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 10:11:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="769867053"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="769867053"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 12 May 2023 10:11:52 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxWJ5-0004zA-13;
        Fri, 12 May 2023 17:11:51 +0000
Date:   Sat, 13 May 2023 01:11:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        linux-acpi@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: Re: [PATCH v1 07/34] acpi/nfit: Move handler installing logic to
 driver
Message-ID: <202305130006.7vOawF8K-lkp@intel.com>
References: <20230512140222.124868-8-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512140222.124868-8-michal.wilczynski@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on chrome-platform/for-next groeck-staging/hwmon-next linus/master v6.4-rc1 next-20230512]
[cannot apply to jic23-iio/togreg nvdimm/libnvdimm-for-next nvdimm/dax-misc crng-random/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Wilczynski/acpi-Adjust-functions-installing-bus-event-handlers/20230512-220607
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230512140222.124868-8-michal.wilczynski%40intel.com
patch subject: [PATCH v1 07/34] acpi/nfit: Move handler installing logic to driver
config: arm64-randconfig-r032-20230511 (https://download.01.org/0day-ci/archive/20230513/202305130006.7vOawF8K-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b0fb98227c90adf2536c9ad644a74d5e92961111)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/2f0865bfe3ea129ced1df996b1f80fb5d44133e8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Michal-Wilczynski/acpi-Adjust-functions-installing-bus-event-handlers/20230512-220607
        git checkout 2f0865bfe3ea129ced1df996b1f80fb5d44133e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/acpi/nfit/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305130006.7vOawF8K-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/acpi/nfit/core.c:1717:13: warning: no previous prototype for function 'nfit_intel_shutdown_status' [-Wmissing-prototypes]
   __weak void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem)
               ^
   drivers/acpi/nfit/core.c:1717:8: note: declare 'static' if the function is not intended to be used outside of this translation unit
   __weak void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem)
          ^
          static 
>> drivers/acpi/nfit/core.c:3376:43: error: use of undeclared identifier 'device'
           return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_nfit_notify);
                                                    ^
>> drivers/acpi/nfit/core.c:3376:71: error: use of undeclared identifier 'acpi_nfit_notify'
           return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_nfit_notify);
                                                                                ^
   drivers/acpi/nfit/core.c:3381:35: error: use of undeclared identifier 'device'
           acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_nfit_notify);
                                            ^
   drivers/acpi/nfit/core.c:3381:63: error: use of undeclared identifier 'acpi_nfit_notify'
           acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_nfit_notify);
                                                                        ^
>> drivers/acpi/nfit/core.c:3457:15: error: use of undeclared identifier 'adev'
           device_lock(&adev->dev);
                        ^
   drivers/acpi/nfit/core.c:3458:22: error: use of undeclared identifier 'adev'
           __acpi_nfit_notify(&adev->dev, adev->handle, event);
                               ^
   drivers/acpi/nfit/core.c:3458:33: error: use of undeclared identifier 'adev'
           __acpi_nfit_notify(&adev->dev, adev->handle, event);
                                          ^
   drivers/acpi/nfit/core.c:3459:17: error: use of undeclared identifier 'adev'
           device_unlock(&adev->dev);
                          ^
   1 warning and 8 errors generated.


vim +/device +3376 drivers/acpi/nfit/core.c

  3314	
  3315	static int acpi_nfit_add(struct acpi_device *adev)
  3316	{
  3317		struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
  3318		struct acpi_nfit_desc *acpi_desc;
  3319		struct device *dev = &adev->dev;
  3320		struct acpi_table_header *tbl;
  3321		acpi_status status = AE_OK;
  3322		acpi_size sz;
  3323		int rc = 0;
  3324	
  3325		status = acpi_get_table(ACPI_SIG_NFIT, 0, &tbl);
  3326		if (ACPI_FAILURE(status)) {
  3327			/* The NVDIMM root device allows OS to trigger enumeration of
  3328			 * NVDIMMs through NFIT at boot time and re-enumeration at
  3329			 * root level via the _FIT method during runtime.
  3330			 * This is ok to return 0 here, we could have an nvdimm
  3331			 * hotplugged later and evaluate _FIT method which returns
  3332			 * data in the format of a series of NFIT Structures.
  3333			 */
  3334			dev_dbg(dev, "failed to find NFIT at startup\n");
  3335			return 0;
  3336		}
  3337	
  3338		rc = devm_add_action_or_reset(dev, acpi_nfit_put_table, tbl);
  3339		if (rc)
  3340			return rc;
  3341		sz = tbl->length;
  3342	
  3343		acpi_desc = devm_kzalloc(dev, sizeof(*acpi_desc), GFP_KERNEL);
  3344		if (!acpi_desc)
  3345			return -ENOMEM;
  3346		acpi_nfit_desc_init(acpi_desc, &adev->dev);
  3347	
  3348		/* Save the acpi header for exporting the revision via sysfs */
  3349		acpi_desc->acpi_header = *tbl;
  3350	
  3351		/* Evaluate _FIT and override with that if present */
  3352		status = acpi_evaluate_object(adev->handle, "_FIT", NULL, &buf);
  3353		if (ACPI_SUCCESS(status) && buf.length > 0) {
  3354			union acpi_object *obj = buf.pointer;
  3355	
  3356			if (obj->type == ACPI_TYPE_BUFFER)
  3357				rc = acpi_nfit_init(acpi_desc, obj->buffer.pointer,
  3358						obj->buffer.length);
  3359			else
  3360				dev_dbg(dev, "invalid type %d, ignoring _FIT\n",
  3361					(int) obj->type);
  3362			kfree(buf.pointer);
  3363		} else
  3364			/* skip over the lead-in header table */
  3365			rc = acpi_nfit_init(acpi_desc, (void *) tbl
  3366					+ sizeof(struct acpi_table_nfit),
  3367					sz - sizeof(struct acpi_table_nfit));
  3368	
  3369		if (rc)
  3370			return rc;
  3371	
  3372		rc = devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
  3373		if (rc)
  3374			return rc;
  3375	
> 3376		return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_nfit_notify);
  3377	}
  3378	
  3379	static void acpi_nfit_remove(struct acpi_device *adev)
  3380	{
  3381		acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_nfit_notify);
  3382		/* see acpi_nfit_unregister */
  3383	}
  3384	
  3385	static void acpi_nfit_update_notify(struct device *dev, acpi_handle handle)
  3386	{
  3387		struct acpi_nfit_desc *acpi_desc = dev_get_drvdata(dev);
  3388		struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
  3389		union acpi_object *obj;
  3390		acpi_status status;
  3391		int ret;
  3392	
  3393		if (!dev->driver) {
  3394			/* dev->driver may be null if we're being removed */
  3395			dev_dbg(dev, "no driver found for dev\n");
  3396			return;
  3397		}
  3398	
  3399		if (!acpi_desc) {
  3400			acpi_desc = devm_kzalloc(dev, sizeof(*acpi_desc), GFP_KERNEL);
  3401			if (!acpi_desc)
  3402				return;
  3403			acpi_nfit_desc_init(acpi_desc, dev);
  3404		} else {
  3405			/*
  3406			 * Finish previous registration before considering new
  3407			 * regions.
  3408			 */
  3409			flush_workqueue(nfit_wq);
  3410		}
  3411	
  3412		/* Evaluate _FIT */
  3413		status = acpi_evaluate_object(handle, "_FIT", NULL, &buf);
  3414		if (ACPI_FAILURE(status)) {
  3415			dev_err(dev, "failed to evaluate _FIT\n");
  3416			return;
  3417		}
  3418	
  3419		obj = buf.pointer;
  3420		if (obj->type == ACPI_TYPE_BUFFER) {
  3421			ret = acpi_nfit_init(acpi_desc, obj->buffer.pointer,
  3422					obj->buffer.length);
  3423			if (ret)
  3424				dev_err(dev, "failed to merge updated NFIT\n");
  3425		} else
  3426			dev_err(dev, "Invalid _FIT\n");
  3427		kfree(buf.pointer);
  3428	}
  3429	
  3430	static void acpi_nfit_uc_error_notify(struct device *dev, acpi_handle handle)
  3431	{
  3432		struct acpi_nfit_desc *acpi_desc = dev_get_drvdata(dev);
  3433	
  3434		if (acpi_desc->scrub_mode == HW_ERROR_SCRUB_ON)
  3435			acpi_nfit_ars_rescan(acpi_desc, ARS_REQ_LONG);
  3436		else
  3437			acpi_nfit_ars_rescan(acpi_desc, ARS_REQ_SHORT);
  3438	}
  3439	
  3440	void __acpi_nfit_notify(struct device *dev, acpi_handle handle, u32 event)
  3441	{
  3442		dev_dbg(dev, "event: 0x%x\n", event);
  3443	
  3444		switch (event) {
  3445		case NFIT_NOTIFY_UPDATE:
  3446			return acpi_nfit_update_notify(dev, handle);
  3447		case NFIT_NOTIFY_UC_MEMORY_ERROR:
  3448			return acpi_nfit_uc_error_notify(dev, handle);
  3449		default:
  3450			return;
  3451		}
  3452	}
  3453	EXPORT_SYMBOL_GPL(__acpi_nfit_notify);
  3454	
  3455	static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
  3456	{
> 3457		device_lock(&adev->dev);
  3458		__acpi_nfit_notify(&adev->dev, adev->handle, event);
  3459		device_unlock(&adev->dev);
  3460	}
  3461	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
