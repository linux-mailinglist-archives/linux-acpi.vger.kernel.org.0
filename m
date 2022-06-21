Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1000A552CB5
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jun 2022 10:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348108AbiFUIU6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Jun 2022 04:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348367AbiFUITN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Jun 2022 04:19:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9223D201A9;
        Tue, 21 Jun 2022 01:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655799552; x=1687335552;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VnOb25EE+Xbwm3fJVJkXzX3ptStChGTjWuHiXzYZZDY=;
  b=VUctaRUxW05Wr3yf71nMshUEFI1tnrCjBzFvbbt/w0TuYf1HNHvdilvY
   sj7UFAK4+hM0NS7taMPGo+iwCE9jDZ3joU8rGF18G2rMD6nbsgAFMQYdV
   fffh0HdKQreTBaZzagicsRnxPZcyXGKI/EhzE4tNICrkwQcHD6+sMzHbU
   4pDa1+OJu74nxt8QNRXr9Zcj6SbsuwB2Rhioy9ausDjPJeUGDD68yMHta
   fGC9sFB3VHVB0tzfbyUZ1NtVbnNLN5TZrY+l6KBzMbR2WA5t72uvCUjNB
   a9T/QPX8CNaMnavgs4P24HM81NzX61F0GGq2oI+m97uIlkC+cAuiAsMjs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="263094907"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="263094907"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 01:19:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="676894865"
Received: from lkp-server01.sh.intel.com (HELO e0735e231192) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jun 2022 01:19:09 -0700
Received: from kbuild by e0735e231192 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3Z6L-00004d-1e;
        Tue, 21 Jun 2022 08:19:09 +0000
Date:   Tue, 21 Jun 2022 16:18:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [rafael-pm:bleeding-edge 20/24] drivers/acpi/scan.c:2449:5: warning:
 no previous prototype for function 'acpi_bus_trim_one'
Message-ID: <202206211629.ncqadywd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   ef9088c776e0c49411bfb413ad43d110a9de1519
commit: e511ff6b4174fa81ca7ee16f8c17f7362c08fadf [20/24] ACPI: scan: Walk ACPI device's children using driver core
config: x86_64-randconfig-a013-20220620 (https://download.01.org/0day-ci/archive/20220621/202206211629.ncqadywd-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=e511ff6b4174fa81ca7ee16f8c17f7362c08fadf
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout e511ff6b4174fa81ca7ee16f8c17f7362c08fadf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/acpi/scan.c:2449:5: warning: no previous prototype for function 'acpi_bus_trim_one' [-Wmissing-prototypes]
   int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
       ^
   drivers/acpi/scan.c:2449:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
   ^
   static 
   1 warning generated.


vim +/acpi_bus_trim_one +2449 drivers/acpi/scan.c

  2448	
> 2449	int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
  2450	{
  2451		struct acpi_scan_handler *handler = adev->handler;
  2452	
  2453		acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
  2454	
  2455		adev->flags.match_driver = false;
  2456		if (handler) {
  2457			if (handler->detach)
  2458				handler->detach(adev);
  2459	
  2460			adev->handler = NULL;
  2461		} else {
  2462			device_release_driver(&adev->dev);
  2463		}
  2464		/*
  2465		 * Most likely, the device is going away, so put it into D3cold before
  2466		 * that.
  2467		 */
  2468		acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
  2469		adev->flags.initialized = false;
  2470		acpi_device_clear_enumerated(adev);
  2471	
  2472		return 0;
  2473	}
  2474	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
