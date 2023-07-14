Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8DC754429
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jul 2023 23:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjGNVZu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Jul 2023 17:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGNVZt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Jul 2023 17:25:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFD830C4;
        Fri, 14 Jul 2023 14:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689369947; x=1720905947;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FBim1Jqhx7Bm961IiDiXRuR53DvmgiQ9kaQDTyyInTc=;
  b=U27rYUwmLFxR6B55k39UPrkxS4phT/FXqjALjAa/ut8e3nqReFlikoHx
   dbBarbTUGeSUN6t07GtOOUD03OMezOQ47hBCSMfFTlPOLRv8wXn6dvh/v
   +7yJFZU4lkAAWLMSoKiPRaBndMzAJLXTpD8I7OkvPDPIf9/r+sFmKeLP3
   X7R0dDNonhRM3sIg0yKDox591Cp01r9lOP5/YgvCAvcp89yZRhOhAPF0j
   YstX6Bc1qitsAUoeC3KEewUU0AzanhCkaag6810JyptOkqK+8XZx/alZk
   bnWX5zbPheGrhQIQ9rCsVnHA9IFHtQmLw1umk96JmTSqdyvp6Bzeky1Xi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="431757629"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="431757629"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 14:25:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="722545785"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="722545785"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2023 14:25:44 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qKQIJ-0007i1-1z;
        Fri, 14 Jul 2023 21:25:43 +0000
Date:   Sat, 15 Jul 2023 05:24:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [rafael-pm:bleeding-edge 22/40] drivers/acpi/internal.h:161:6:
 warning: no previous prototype for function
 'acpi_early_processor_control_setup'
Message-ID: <202307150527.HDJ9XJMo-lkp@intel.com>
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
config: arm64-randconfig-r021-20230714 (https://download.01.org/0day-ci/archive/20230715/202307150527.HDJ9XJMo-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230715/202307150527.HDJ9XJMo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307150527.HDJ9XJMo-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/acpi/acpi_processor.c:27:
>> drivers/acpi/internal.h:161:6: warning: no previous prototype for function 'acpi_early_processor_control_setup' [-Wmissing-prototypes]
     161 | void acpi_early_processor_control_setup(void) {}
         |      ^
   drivers/acpi/internal.h:161:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     161 | void acpi_early_processor_control_setup(void) {}
         | ^
         | static 
   1 warning generated.
--
   In file included from drivers/acpi/dptf/int340x_thermal.c:12:
>> drivers/acpi/dptf/../internal.h:161:6: warning: no previous prototype for function 'acpi_early_processor_control_setup' [-Wmissing-prototypes]
     161 | void acpi_early_processor_control_setup(void) {}
         |      ^
   drivers/acpi/dptf/../internal.h:161:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     161 | void acpi_early_processor_control_setup(void) {}
         | ^
         | static 
   1 warning generated.


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
