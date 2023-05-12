Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8695701170
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 23:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbjELVnC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 17:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbjELVnB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 17:43:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2135B93
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 14:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683927779; x=1715463779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Bl/EjMSSHjz1Wk2AIf5TXrIQmI81mS1RQb/Zga8QtI=;
  b=DHO6y3VuNUUCzNDTwJpBGjk+uHopcn4dMrldlGJVjBdbBglz8Z1s6A2I
   le8Do7t4lIh75vClUev0wbIWljq/TFoD8cXUtYY5X2xNQdquH/2HtXmmo
   +Jcbg4ADcS+psy8ElEEt1sjAgCU9XmNTuo7equfTNTozdR3O2NvBfGyWu
   jLJi/ZyrRhjNC1GUq0M4BZlb0JcDol4gvxPamFnh9WnzEc0sf3+kTLqfL
   2zCQ0uANlkj9qGOBZ/8/l3IzaAG2tx4qHvJKkL2CZn2J6hAx33AYY5q13
   Uwz2nJ3hVJRaLxojlGY9g0wIZ0D7fLjrrWpS4jMqr/vmfANR1qNOyr0fq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="353147652"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="353147652"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 14:42:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="844568072"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="844568072"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 12 May 2023 14:42:57 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxaXQ-00057s-2c;
        Fri, 12 May 2023 21:42:56 +0000
Date:   Sat, 13 May 2023 05:42:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        linux-acpi@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, rafael@kernel.org,
        srinivas.pandruvada@linux.intel.com, hanjun.guo@linaro.org,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: Re: [PATCH v1 2/2] acpi: Move logic responsible for conveying
 processor OSPM capabilities
Message-ID: <202305130519.3kCngRee-lkp@intel.com>
References: <20230512152545.125302-3-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512152545.125302-3-michal.wilczynski@intel.com>
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
[also build test ERROR on linus/master v6.4-rc1 next-20230512]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Wilczynski/acpi-Use-_OSC-method-to-convey-processor-OSPM-capabilites/20230512-232819
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230512152545.125302-3-michal.wilczynski%40intel.com
patch subject: [PATCH v1 2/2] acpi: Move logic responsible for conveying processor OSPM capabilities
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230513/202305130519.3kCngRee-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/46f0576d442f1e76c7bd4edaec78ee2357111aff
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Michal-Wilczynski/acpi-Use-_OSC-method-to-convey-processor-OSPM-capabilites/20230512-232819
        git checkout 46f0576d442f1e76c7bd4edaec78ee2357111aff
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305130519.3kCngRee-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/acpi/acpi_processor.c: In function 'set_no_mwait':
>> drivers/acpi/acpi_processor.c:564:9: error: 'boot_option_idle_override' undeclared (first use in this function)
     564 |         boot_option_idle_override = IDLE_NOMWAIT;
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/acpi_processor.c:564:9: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/acpi/acpi_processor.c:564:37: error: 'IDLE_NOMWAIT' undeclared (first use in this function); did you mean 'FOLL_NOWAIT'?
     564 |         boot_option_idle_override = IDLE_NOMWAIT;
         |                                     ^~~~~~~~~~~~
         |                                     FOLL_NOWAIT
   drivers/acpi/acpi_processor.c: In function 'acpi_processor_osc':
   drivers/acpi/acpi_processor.c:604:9: error: implicit declaration of function 'arch_acpi_set_proc_cap_bits' [-Werror=implicit-function-declaration]
     604 |         arch_acpi_set_proc_cap_bits(&capbuf[OSC_SUPPORT_DWORD]);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/acpi_processor.c:606:13: error: 'boot_option_idle_override' undeclared (first use in this function)
     606 |         if (boot_option_idle_override == IDLE_NOMWAIT)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/acpi_processor.c:606:42: error: 'IDLE_NOMWAIT' undeclared (first use in this function); did you mean 'FOLL_NOWAIT'?
     606 |         if (boot_option_idle_override == IDLE_NOMWAIT)
         |                                          ^~~~~~~~~~~~
         |                                          FOLL_NOWAIT
   drivers/acpi/acpi_processor.c:607:48: error: 'ACPI_PDC_C_C2C3_FFH' undeclared (first use in this function)
     607 |                 capbuf[OSC_SUPPORT_DWORD] &= ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
         |                                                ^~~~~~~~~~~~~~~~~~~
   drivers/acpi/acpi_processor.c:607:70: error: 'ACPI_PDC_C_C1_FFH' undeclared (first use in this function)
     607 |                 capbuf[OSC_SUPPORT_DWORD] &= ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
         |                                                                      ^~~~~~~~~~~~~~~~~
   drivers/acpi/acpi_processor.c: At top level:
   drivers/acpi/acpi_processor.c:627:20: error: redefinition of 'acpi_early_processor_osc'
     627 | acpi_status __init acpi_early_processor_osc(void)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/acpi/acpi_processor.c:27:
   drivers/acpi/internal.h:164:27: note: previous definition of 'acpi_early_processor_osc' with type 'acpi_status(void)' {aka 'unsigned int(void)'}
     164 | static inline acpi_status acpi_early_processor_osc(void) { return AE_ERROR; }
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/boot_option_idle_override +564 drivers/acpi/acpi_processor.c

   559	
   560	static int __init set_no_mwait(const struct dmi_system_id *id)
   561	{
   562		pr_notice("%s detected - disabling mwait for CPU C-states\n",
   563			  id->ident);
 > 564		boot_option_idle_override = IDLE_NOMWAIT;
   565		return 0;
   566	}
   567	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
