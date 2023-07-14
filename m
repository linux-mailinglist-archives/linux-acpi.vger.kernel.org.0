Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D3D75451E
	for <lists+linux-acpi@lfdr.de>; Sat, 15 Jul 2023 00:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjGNWru (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Jul 2023 18:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGNWrt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Jul 2023 18:47:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8C92113;
        Fri, 14 Jul 2023 15:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689374868; x=1720910868;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lJLyV0IIZA10ZKlpLIm2/1mLSE9navxRPFhXVkA4NPk=;
  b=Z6fEMW+nCltFo5RMD5631kPecU7nyi6lJkVbR6Iu7gX88ZKK3HtVFB2F
   i21z5d03AXC6nahWMJx3K40N9JxKfZlmd97XtGHzsxP6BlYD8jNEbpve9
   dTc2PR0CAf+VXhOT3+O/4Xi3xliZspMUIflAIAd+a5l/jouDua+z6u3Wq
   hYvMPpdkqa8J5HJMVI/avdG6smmAwRW4ANN6t9tS14KK4Foitrw9m9jkg
   P3BuXooqT4K4nDnXDbd2HXXx+CoVFzEde6XeIUdVV4aDcbBrq4uMgxNha
   6FFR1g3pJ296+WRbRAfP52qTO+yzr85lY0iol6Ql/Dnw5sE+3aBAIaFsl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="345906958"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="345906958"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 15:47:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="812604605"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="812604605"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2023 15:47:45 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qKRZg-0007k9-1c;
        Fri, 14 Jul 2023 22:47:44 +0000
Date:   Sat, 15 Jul 2023 06:47:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [rafael-pm:bleeding-edge 22/40] drivers/acpi/internal.h:161:
 multiple definition of `acpi_early_processor_control_setup';
 drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
Message-ID: <202307150637.CGq9exEE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   4f9dd7927c1cdbaffb20fcdbcc2bdc6caa0b4736
commit: ca805e0f04a5f9a773875ad6de914e54e41d43c7 [22/40] ACPI: processor: Use _OSC to convey OSPM processor support information
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230715/202307150637.CGq9exEE-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230715/202307150637.CGq9exEE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307150637.CGq9exEE-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: drivers/acpi/osi.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/osl.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/utils.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/nvs.o: in function `acpi_early_processor_control_setup':
   drivers/acpi/nvs.c:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/wakeup.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/device_sysfs.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/device_pm.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/bus.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/glue.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/scan.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/acpi_processor.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/ec.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/pci_root.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/pci_link.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/acpi_lpss.o: in function `acpi_early_processor_control_setup':
   drivers/acpi/acpi_lpss.c:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/acpi_apd.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/acpi_platform.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/acpi_pnp.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/acpi_amba.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/power.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/event.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/sysfs.o: in function `acpi_early_processor_control_setup':
>> drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/property.o: in function `acpi_early_processor_control_setup':
   drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/debugfs.o: in function `acpi_early_processor_control_setup':
   drivers/acpi/debugfs.c:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/processor_driver.o: in function `acpi_early_processor_control_setup':
   drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/container.o: in function `acpi_early_processor_control_setup':
   drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/acpi_memhotplug.o: in function `acpi_early_processor_control_setup':
   drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
   aarch64-linux-ld: drivers/acpi/dptf/int340x_thermal.o: in function `acpi_early_processor_control_setup':
   drivers/acpi/dptf/../internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here


vim +161 drivers/acpi/internal.h

   157	
   158	void acpi_proc_quirk_mwait_check(void);
   159	bool processor_physically_present(acpi_handle handle);
   160	#else
 > 161	void acpi_early_processor_control_setup(void) {}
   162	#endif
   163	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
