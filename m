Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AFD754435
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jul 2023 23:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjGNVfs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Jul 2023 17:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGNVfr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Jul 2023 17:35:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C813585;
        Fri, 14 Jul 2023 14:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689370546; x=1720906546;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GEvTwBpmmt5pVBjWGnsaUCbUh3I7M6VD7j7FlUZh6mI=;
  b=G3zP7XktMljdwWY9vOFIA61auvErlaWudlTOSgfmmswYkxGZxEoADkCf
   sekq/oprLqlF3n8Y+WHnglMYXPxXUXmKRKJTK8b0NdW+sFO/BQh1/af/L
   V1BuTbG3pvNFfU4iXl8aGhDEq/ovlsAFNdkMjNUiOLQchkpxzz2/HgHh8
   g6l8xt0WYqS7v5bKYNfx3q7rU5rtKQyUmi7EyjlD0O1KhwzFqhWu69hhK
   +9LvMG+c/xqb3o55leT6IuXBO/QGXygf3jxyJ2SwJDBRMIRfAiITDI8A6
   mu0Jzc01907mQLsvTVV/49H8cmgmSoxw9eGa/GsdMxZ9w8/uwmp1gF6B0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="365621617"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="365621617"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 14:35:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="792549559"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="792549559"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2023 14:35:44 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qKQRz-0007iD-2E;
        Fri, 14 Jul 2023 21:35:43 +0000
Date:   Sat, 15 Jul 2023 05:34:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [rafael-pm:bleeding-edge 33/47] drivers/acpi/internal.h:161:6:
 warning: no previous prototype for 'acpi_early_processor_control_setup'
Message-ID: <202307150552.aLyOhzH2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   4f9dd7927c1cdbaffb20fcdbcc2bdc6caa0b4736
commit: ca805e0f04a5f9a773875ad6de914e54e41d43c7 [33/47] ACPI: processor: Use _OSC to convey OSPM processor support information
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230715/202307150552.aLyOhzH2-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230715/202307150552.aLyOhzH2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307150552.aLyOhzH2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/acpi/tables.c:25:
>> drivers/acpi/internal.h:161:6: warning: no previous prototype for 'acpi_early_processor_control_setup' [-Wmissing-prototypes]
     161 | void acpi_early_processor_control_setup(void) {}
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/acpi/osl.c:39:
>> drivers/acpi/internal.h:161:6: warning: no previous prototype for 'acpi_early_processor_control_setup' [-Wmissing-prototypes]
     161 | void acpi_early_processor_control_setup(void) {}
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/osl.c: In function 'acpi_os_vprintf':
   drivers/acpi/osl.c:156:9: warning: function 'acpi_os_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     156 |         vsprintf(buffer, fmt, args);
         |         ^~~~~~~~
--
   In file included from drivers/acpi/dptf/int340x_thermal.c:12:
>> drivers/acpi/dptf/../internal.h:161:6: warning: no previous prototype for 'acpi_early_processor_control_setup' [-Wmissing-prototypes]
     161 | void acpi_early_processor_control_setup(void) {}
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/acpi_early_processor_control_setup +161 drivers/acpi/internal.h

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
