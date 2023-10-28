Return-Path: <linux-acpi+bounces-1086-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712177DA78C
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Oct 2023 16:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9FC28155B
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Oct 2023 14:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D872015AEF
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Oct 2023 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiPrdjbk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96AC129
	for <linux-acpi@vger.kernel.org>; Sat, 28 Oct 2023 13:43:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9EA93;
	Sat, 28 Oct 2023 06:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698500608; x=1730036608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lgsn/cH6qVOFWUhcF7VtnSy5ywh8V+OwTksqVFwA0F0=;
  b=WiPrdjbksv6Li3CsD9rlnezcj0A9XKcy1mRyOqzhKg+mQzLdZpBUEUo6
   GOI57o02ZFV3zZ1wJhq67UjSHTmstt/a85VPf7SZhl5beOgApuUD0uS9J
   2qQjEUc02t1H5NXozlCu/qgTgh8VqoPrm1SDKgiXQF3M0QPbxMTW4ujBJ
   Dwb1zaEmI27Ja2++2MIH5gRaV7639Fsre3642A17IIkpzcXzDbkOKQKtu
   dI3gbOLgaHgOh4bVFrbVwE9qDEZEmGpBJ++v4BWdH2iOMZcJnAdJ1NR+c
   1KlUbpi2UVJ5Pa1DanyMRPLWLCyIXj7cMyVhxb7Jx59OKXYvAqFSBnAnP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="6530803"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="6530803"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 06:43:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="830274388"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="830274388"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Oct 2023 06:43:23 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qwjaz-000BmT-26;
	Sat, 28 Oct 2023 13:43:21 +0000
Date: Sat, 28 Oct 2023 21:42:57 +0800
From: kernel test robot <lkp@intel.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc: oe-kbuild-all@lists.linux.dev,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 7/7] coresight: debug: Move ACPI support from AMBA driver
 to platform driver
Message-ID: <202310282104.0VVIo070-lkp@intel.com>
References: <20231027072943.3418997-8-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027072943.3418997-8-anshuman.khandual@arm.com>

Hi Anshuman,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/acpi-bus soc/for-next atorgue-stm32/stm32-next linus/master v6.6-rc7 next-20231027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/coresight-replicator-Move-ACPI-support-from-AMBA-driver-to-platform-driver/20231027-153540
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20231027072943.3418997-8-anshuman.khandual%40arm.com
patch subject: [PATCH 7/7] coresight: debug: Move ACPI support from AMBA driver to platform driver
config: arm64-randconfig-003-20231028 (https://download.01.org/0day-ci/archive/20231028/202310282104.0VVIo070-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231028/202310282104.0VVIo070-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310282104.0VVIo070-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/amba/bus.h:15,
                    from drivers/hwtracing/coresight/coresight-cpu-debug.c:7:
   include/linux/module.h:131:49: error: redefinition of '__inittest'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/device/driver.h:262:1: note: in expansion of macro 'module_init'
     262 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/platform_device.h:303:9: note: in expansion of macro 'module_driver'
     303 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/hwtracing/coresight/coresight-cpu-debug.c:784:1: note: in expansion of macro 'module_platform_driver'
     784 | module_platform_driver(debug_platform_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:131:49: note: previous definition of '__inittest' with type 'int (*(void))(void)'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/device/driver.h:262:1: note: in expansion of macro 'module_init'
     262 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/amba/bus.h:186:9: note: in expansion of macro 'module_driver'
     186 |         module_driver(__amba_drv, amba_driver_register, amba_driver_unregister)
         |         ^~~~~~~~~~~~~
   drivers/hwtracing/coresight/coresight-cpu-debug.c:692:1: note: in expansion of macro 'module_amba_driver'
     692 | module_amba_driver(debug_driver);
         | ^~~~~~~~~~~~~~~~~~
   include/linux/module.h:133:13: error: redefinition of 'init_module'
     133 |         int init_module(void) __copy(initfn)                    \
         |             ^~~~~~~~~~~
   include/linux/device/driver.h:262:1: note: in expansion of macro 'module_init'
     262 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/platform_device.h:303:9: note: in expansion of macro 'module_driver'
     303 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/hwtracing/coresight/coresight-cpu-debug.c:784:1: note: in expansion of macro 'module_platform_driver'
     784 | module_platform_driver(debug_platform_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:133:13: note: previous definition of 'init_module' with type 'int(void)'
     133 |         int init_module(void) __copy(initfn)                    \
         |             ^~~~~~~~~~~
   include/linux/device/driver.h:262:1: note: in expansion of macro 'module_init'
     262 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/amba/bus.h:186:9: note: in expansion of macro 'module_driver'
     186 |         module_driver(__amba_drv, amba_driver_register, amba_driver_unregister)
         |         ^~~~~~~~~~~~~
   drivers/hwtracing/coresight/coresight-cpu-debug.c:692:1: note: in expansion of macro 'module_amba_driver'
     692 | module_amba_driver(debug_driver);
         | ^~~~~~~~~~~~~~~~~~
>> include/linux/module.h:139:49: error: redefinition of '__exittest'
     139 |         static inline exitcall_t __maybe_unused __exittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/device/driver.h:267:1: note: in expansion of macro 'module_exit'
     267 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/platform_device.h:303:9: note: in expansion of macro 'module_driver'
     303 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/hwtracing/coresight/coresight-cpu-debug.c:784:1: note: in expansion of macro 'module_platform_driver'
     784 | module_platform_driver(debug_platform_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:139:49: note: previous definition of '__exittest' with type 'void (*(void))(void)'
     139 |         static inline exitcall_t __maybe_unused __exittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/device/driver.h:267:1: note: in expansion of macro 'module_exit'
     267 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/amba/bus.h:186:9: note: in expansion of macro 'module_driver'
     186 |         module_driver(__amba_drv, amba_driver_register, amba_driver_unregister)
         |         ^~~~~~~~~~~~~
   drivers/hwtracing/coresight/coresight-cpu-debug.c:692:1: note: in expansion of macro 'module_amba_driver'
     692 | module_amba_driver(debug_driver);
         | ^~~~~~~~~~~~~~~~~~
>> include/linux/module.h:141:14: error: redefinition of 'cleanup_module'
     141 |         void cleanup_module(void) __copy(exitfn)                \
         |              ^~~~~~~~~~~~~~
   include/linux/device/driver.h:267:1: note: in expansion of macro 'module_exit'
     267 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/platform_device.h:303:9: note: in expansion of macro 'module_driver'
     303 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/hwtracing/coresight/coresight-cpu-debug.c:784:1: note: in expansion of macro 'module_platform_driver'
     784 | module_platform_driver(debug_platform_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:141:14: note: previous definition of 'cleanup_module' with type 'void(void)'
     141 |         void cleanup_module(void) __copy(exitfn)                \
         |              ^~~~~~~~~~~~~~
   include/linux/device/driver.h:267:1: note: in expansion of macro 'module_exit'
     267 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/amba/bus.h:186:9: note: in expansion of macro 'module_driver'
     186 |         module_driver(__amba_drv, amba_driver_register, amba_driver_unregister)
         |         ^~~~~~~~~~~~~
   drivers/hwtracing/coresight/coresight-cpu-debug.c:692:1: note: in expansion of macro 'module_amba_driver'
     692 | module_amba_driver(debug_driver);
         | ^~~~~~~~~~~~~~~~~~


vim +/__exittest +139 include/linux/module.h

0fd972a7d91d6e Paul Gortmaker 2015-05-01  128  
0fd972a7d91d6e Paul Gortmaker 2015-05-01  129  /* Each module must use one module_init(). */
0fd972a7d91d6e Paul Gortmaker 2015-05-01  130  #define module_init(initfn)					\
1f318a8bafcfba Arnd Bergmann  2017-02-01  131  	static inline initcall_t __maybe_unused __inittest(void)		\
0fd972a7d91d6e Paul Gortmaker 2015-05-01  132  	{ return initfn; }					\
cf68fffb66d60d Sami Tolvanen  2021-04-08  133  	int init_module(void) __copy(initfn)			\
cf68fffb66d60d Sami Tolvanen  2021-04-08  134  		__attribute__((alias(#initfn)));		\
92efda8eb15295 Sami Tolvanen  2022-09-08  135  	___ADDRESSABLE(init_module, __initdata);
0fd972a7d91d6e Paul Gortmaker 2015-05-01  136  
0fd972a7d91d6e Paul Gortmaker 2015-05-01  137  /* This is only required if you want to be unloadable. */
0fd972a7d91d6e Paul Gortmaker 2015-05-01  138  #define module_exit(exitfn)					\
1f318a8bafcfba Arnd Bergmann  2017-02-01 @139  	static inline exitcall_t __maybe_unused __exittest(void)		\
0fd972a7d91d6e Paul Gortmaker 2015-05-01  140  	{ return exitfn; }					\
cf68fffb66d60d Sami Tolvanen  2021-04-08 @141  	void cleanup_module(void) __copy(exitfn)		\
cf68fffb66d60d Sami Tolvanen  2021-04-08  142  		__attribute__((alias(#exitfn)));		\
92efda8eb15295 Sami Tolvanen  2022-09-08  143  	___ADDRESSABLE(cleanup_module, __exitdata);
0fd972a7d91d6e Paul Gortmaker 2015-05-01  144  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

