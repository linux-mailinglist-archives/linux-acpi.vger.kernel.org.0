Return-Path: <linux-acpi+bounces-11674-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C49CA4AEC0
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Mar 2025 03:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0679D1893AA4
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Mar 2025 02:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37F3381A3;
	Sun,  2 Mar 2025 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKilS3zZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15A217996
	for <linux-acpi@vger.kernel.org>; Sun,  2 Mar 2025 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740882625; cv=none; b=hbeGsbWQPyM46VO5yQ3suzWMHnYFV65J8yIh4LMto8aTlSm+yCZe5KYhRGKV08MiKQ1tEliTEmH54GKXOmKEAv/wmzxhwsUjTzVCM4O3rXj0V+BrTMVNOGMfaeXMhi7l1PTYKHPZqbGOLAbXpXp4uPWIDmk7Hkhb30vDlGdNSOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740882625; c=relaxed/simple;
	bh=Upvi7tvymOtThpgw3ldPIJo3yPhrccCw8zgMugRRq74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTB1mewcM0+Hs03hEcNYLLv018qrUXkE04npwsCe4AHg0UFjB3PlCZmhPHvPq6CU/7LLPnga+dxbasAA8esaf7R1SlYK/SDjoIo7ubYYC5y/5d4Eaq0HSpLmNnnMPFH1WoTWrcO70mE/TktehKa6WDsa3TPe8tM1gsWazofuOD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKilS3zZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740882624; x=1772418624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Upvi7tvymOtThpgw3ldPIJo3yPhrccCw8zgMugRRq74=;
  b=AKilS3zZFDNOn11iYwzi24ARdtQTfbjRZjdbH0KEAxRO7jfk0A9aSEUv
   71YuO66OBy9fehbfxGEE2b7m/NKrmWvf8a1bXk9HdYDZfHgue2Hfpp/Pa
   uDST2BjsO1R6l0g1AWxzwLsyN2R2nh6DhMiE2RAejE1Kzoa8Psls5l0e4
   vPLclG5vUl6AeYm9Jp8OeoqemcP3irLBgf4HesjyWpHmBpb/shuArujQM
   uQw7PdM/5eWnSvpLu3K+lvg2akO3KD5F29uWnfB3Sy5pfgXW86vcTh/HF
   ata4B3kkEKsImHKKrRPcAIhvbimg/L/VPOsHhs4U9jMGMYievzSd0QHgE
   Q==;
X-CSE-ConnectionGUID: gvL7Es2hTIKM/VAQjN9FHA==
X-CSE-MsgGUID: I5zSG10RRMy2DhU7weGBYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="41806587"
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="41806587"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 18:30:23 -0800
X-CSE-ConnectionGUID: 3EGWKjm7RCut+PtAEbTDrA==
X-CSE-MsgGUID: kZ+DFB4cRxy0N8X66r9xwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="148484747"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 01 Mar 2025 18:30:22 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toZ5v-000Gy2-1m;
	Sun, 02 Mar 2025 02:30:19 +0000
Date: Sun, 2 Mar 2025 10:30:11 +0800
From: kernel test robot <lkp@intel.com>
To: mpagano@gentoo.org, linux-acpi@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	robert.moore@intel.com, rafael.j.wysocki@intel.com,
	Mike Pagano <mpagano@gentoo.org>
Subject: Re: [PATCH] ACPICA: fix build with GCC 15 due to
 -Werror=unterminated-string-initialization
Message-ID: <202503021047.izEzFVqg-lkp@intel.com>
References: <20250228210834.811164-1-mpagano@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228210834.811164-1-mpagano@gentoo.org>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.14-rc4 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/mpagano-gentoo-org/ACPICA-fix-build-with-GCC-15-due-to-Werror-unterminated-string-initialization/20250301-051004
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250228210834.811164-1-mpagano%40gentoo.org
patch subject: [PATCH] ACPICA: fix build with GCC 15 due to -Werror=unterminated-string-initialization
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20250302/202503021047.izEzFVqg-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503021047.izEzFVqg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503021047.izEzFVqg-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/nfit/core.c:3489:2: error: call to '__compiletime_assert_953' declared with 'error' attribute: BUILD_BUG_ON failed: sizeof(struct acpi_table_nfit) != 40
    3489 |         BUILD_BUG_ON(sizeof(struct acpi_table_nfit) != 40);
         |         ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   include/linux/compiler_types.h:542:2: note: expanded from macro 'compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^
   include/linux/compiler_types.h:530:2: note: expanded from macro '_compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:523:4: note: expanded from macro '__compiletime_assert'
     523 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:114:1: note: expanded from here
     114 | __compiletime_assert_953
         | ^
   1 error generated.


vim +3489 drivers/acpi/nfit/core.c

b94d5230d06eb9 drivers/acpi/nfit.c      Dan Williams    2015-05-19  3484  
b94d5230d06eb9 drivers/acpi/nfit.c      Dan Williams    2015-05-19  3485  static __init int nfit_init(void)
b94d5230d06eb9 drivers/acpi/nfit.c      Dan Williams    2015-05-19  3486  {
7e700d2c59e585 drivers/acpi/nfit/core.c Prarit Bhargava 2017-05-31  3487  	int ret;
7e700d2c59e585 drivers/acpi/nfit/core.c Prarit Bhargava 2017-05-31  3488  
b94d5230d06eb9 drivers/acpi/nfit.c      Dan Williams    2015-05-19 @3489  	BUILD_BUG_ON(sizeof(struct acpi_table_nfit) != 40);
cf16b05c607bd7 drivers/acpi/nfit/core.c Bob Moore       2021-04-06  3490  	BUILD_BUG_ON(sizeof(struct acpi_nfit_system_address) != 64);
b94d5230d06eb9 drivers/acpi/nfit.c      Dan Williams    2015-05-19  3491  	BUILD_BUG_ON(sizeof(struct acpi_nfit_memory_map) != 48);
2a5ab99847bd41 drivers/acpi/nfit/core.c Kees Cook       2023-04-05  3492  	BUILD_BUG_ON(sizeof(struct acpi_nfit_interleave) != 16);
74522fea27f8a0 drivers/acpi/nfit/core.c Kees Cook       2023-04-05  3493  	BUILD_BUG_ON(sizeof(struct acpi_nfit_smbios) != 8);
b94d5230d06eb9 drivers/acpi/nfit.c      Dan Williams    2015-05-19  3494  	BUILD_BUG_ON(sizeof(struct acpi_nfit_control_region) != 80);
b94d5230d06eb9 drivers/acpi/nfit.c      Dan Williams    2015-05-19  3495  	BUILD_BUG_ON(sizeof(struct acpi_nfit_data_region) != 40);
06e8ccdab15f46 drivers/acpi/nfit/core.c Dave Jiang      2018-01-31  3496  	BUILD_BUG_ON(sizeof(struct acpi_nfit_capabilities) != 16);
b94d5230d06eb9 drivers/acpi/nfit.c      Dan Williams    2015-05-19  3497  
41c8bdb3ab10c1 drivers/acpi/nfit/core.c Andy Shevchenko 2017-06-05  3498  	guid_parse(UUID_VOLATILE_MEMORY, &nfit_uuid[NFIT_SPA_VOLATILE]);
41c8bdb3ab10c1 drivers/acpi/nfit/core.c Andy Shevchenko 2017-06-05  3499  	guid_parse(UUID_PERSISTENT_MEMORY, &nfit_uuid[NFIT_SPA_PM]);
41c8bdb3ab10c1 drivers/acpi/nfit/core.c Andy Shevchenko 2017-06-05  3500  	guid_parse(UUID_CONTROL_REGION, &nfit_uuid[NFIT_SPA_DCR]);
41c8bdb3ab10c1 drivers/acpi/nfit/core.c Andy Shevchenko 2017-06-05  3501  	guid_parse(UUID_DATA_REGION, &nfit_uuid[NFIT_SPA_BDW]);
41c8bdb3ab10c1 drivers/acpi/nfit/core.c Andy Shevchenko 2017-06-05  3502  	guid_parse(UUID_VOLATILE_VIRTUAL_DISK, &nfit_uuid[NFIT_SPA_VDISK]);
41c8bdb3ab10c1 drivers/acpi/nfit/core.c Andy Shevchenko 2017-06-05  3503  	guid_parse(UUID_VOLATILE_VIRTUAL_CD, &nfit_uuid[NFIT_SPA_VCD]);
41c8bdb3ab10c1 drivers/acpi/nfit/core.c Andy Shevchenko 2017-06-05  3504  	guid_parse(UUID_PERSISTENT_VIRTUAL_DISK, &nfit_uuid[NFIT_SPA_PDISK]);
41c8bdb3ab10c1 drivers/acpi/nfit/core.c Andy Shevchenko 2017-06-05  3505  	guid_parse(UUID_PERSISTENT_VIRTUAL_CD, &nfit_uuid[NFIT_SPA_PCD]);
41c8bdb3ab10c1 drivers/acpi/nfit/core.c Andy Shevchenko 2017-06-05  3506  	guid_parse(UUID_NFIT_BUS, &nfit_uuid[NFIT_DEV_BUS]);
41c8bdb3ab10c1 drivers/acpi/nfit/core.c Andy Shevchenko 2017-06-05  3507  	guid_parse(UUID_NFIT_DIMM, &nfit_uuid[NFIT_DEV_DIMM]);
41c8bdb3ab10c1 drivers/acpi/nfit/core.c Andy Shevchenko 2017-06-05  3508  	guid_parse(UUID_NFIT_DIMM_N_HPE1, &nfit_uuid[NFIT_DEV_DIMM_N_HPE1]);
41c8bdb3ab10c1 drivers/acpi/nfit/core.c Andy Shevchenko 2017-06-05  3509  	guid_parse(UUID_NFIT_DIMM_N_HPE2, &nfit_uuid[NFIT_DEV_DIMM_N_HPE2]);
41c8bdb3ab10c1 drivers/acpi/nfit/core.c Andy Shevchenko 2017-06-05  3510  	guid_parse(UUID_NFIT_DIMM_N_MSFT, &nfit_uuid[NFIT_DEV_DIMM_N_MSFT]);
1194c4133195df drivers/acpi/nfit/core.c Dexuan Cui      2019-01-29  3511  	guid_parse(UUID_NFIT_DIMM_N_HYPERV, &nfit_uuid[NFIT_DEV_DIMM_N_HYPERV]);
6450ddbd5d8e83 drivers/acpi/nfit/core.c Dan Williams    2020-07-20  3512  	guid_parse(UUID_INTEL_BUS, &nfit_uuid[NFIT_BUS_INTEL]);
b94d5230d06eb9 drivers/acpi/nfit.c      Dan Williams    2015-05-19  3513  
7ae0fa439faff0 drivers/acpi/nfit.c      Dan Williams    2016-02-19  3514  	nfit_wq = create_singlethread_workqueue("nfit");
7ae0fa439faff0 drivers/acpi/nfit.c      Dan Williams    2016-02-19  3515  	if (!nfit_wq)
7ae0fa439faff0 drivers/acpi/nfit.c      Dan Williams    2016-02-19  3516  		return -ENOMEM;
7ae0fa439faff0 drivers/acpi/nfit.c      Dan Williams    2016-02-19  3517  
6839a6d96f4ea0 drivers/acpi/nfit/core.c Vishal Verma    2016-07-23  3518  	nfit_mce_register();
7e700d2c59e585 drivers/acpi/nfit/core.c Prarit Bhargava 2017-05-31  3519  	ret = acpi_bus_register_driver(&acpi_nfit_driver);
7e700d2c59e585 drivers/acpi/nfit/core.c Prarit Bhargava 2017-05-31  3520  	if (ret) {
7e700d2c59e585 drivers/acpi/nfit/core.c Prarit Bhargava 2017-05-31  3521  		nfit_mce_unregister();
7e700d2c59e585 drivers/acpi/nfit/core.c Prarit Bhargava 2017-05-31  3522  		destroy_workqueue(nfit_wq);
7e700d2c59e585 drivers/acpi/nfit/core.c Prarit Bhargava 2017-05-31  3523  	}
7e700d2c59e585 drivers/acpi/nfit/core.c Prarit Bhargava 2017-05-31  3524  
7e700d2c59e585 drivers/acpi/nfit/core.c Prarit Bhargava 2017-05-31  3525  	return ret;
6839a6d96f4ea0 drivers/acpi/nfit/core.c Vishal Verma    2016-07-23  3526  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

