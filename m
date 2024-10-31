Return-Path: <linux-acpi+bounces-9192-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DC69B79F8
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 12:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0379B1C21290
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 11:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D3619ABC2;
	Thu, 31 Oct 2024 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgvNDMgD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6FB153BC7;
	Thu, 31 Oct 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730375238; cv=none; b=HKeo/Z5ZcV+oPG6vM1gqSUTGlwzn2QbR6hNcbUXxapQ5WNaJ940AYf6lfbvdMS8HP8ze6KIVmHmN6kGf6ErhRiOiHEydJytyKs5w99u8LUmzGidyAvlUtUnoWHOpmkR97yuvosg+hfXHAvkPJW81rMfvd0z7NksXc/S0NZY4c84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730375238; c=relaxed/simple;
	bh=tQAhjuD6XraYLhlQEeJ31UaRObpRRUAvfmmoYCha3gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7Q9U28IWtnp1SHD9N135VV7o2K5TqMqLQdSFwF3R5Ietl9tZmkHMAWzhQb5et82t4xGpW+RJDEGQJtfYXWOLy1AjLx6Xl6RrMSIj6cPWBdFyQHcD2m/e0K78EdKucw2Ypqigxj05emWuiF01rga4GGNlCth++FCpifc0ugaAmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgvNDMgD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730375234; x=1761911234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tQAhjuD6XraYLhlQEeJ31UaRObpRRUAvfmmoYCha3gw=;
  b=CgvNDMgD10aW7V5tILvT4nVGxRUy1Picrnt9SZudAr2+1HtLeksAUc+S
   AKmokhQmkvJj4h5HjN/7RDEUDbZkq+KXYYIiFHEsa3PVBbB74wvaPOMGC
   hbURuM67ChQkftrkz8G5TYvxEKJ4fuox7eJV6zZiJWSijM6lzdLwgfpOE
   A8luKNLZx6MPNVqk2kOYmRAArvaG/raNi+FrBxNHPOw2B8YqgME1HnW5R
   P8wRO2nDpPlMwK6yD3eR5Haa4OuQQ2Mpy3Zy422jr8bDno/vgh8u0peRU
   h1JxKQIVZQ5TvarpM4QamtBe+p2XifzWUhHDznXeSdGykwQQpE3SBh2xy
   g==;
X-CSE-ConnectionGUID: WFJNqt8ETq+DPc3eeUuNVQ==
X-CSE-MsgGUID: Q+YgL11rQeOYTw+UugzM8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40653960"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40653960"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 04:47:14 -0700
X-CSE-ConnectionGUID: Lc9cumRjTDag4RIbvnkHAQ==
X-CSE-MsgGUID: r67rYK7dTI+RlvpphCsdMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="113451514"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 31 Oct 2024 04:47:11 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6Tds-000g32-2f;
	Thu, 31 Oct 2024 11:47:08 +0000
Date: Thu, 31 Oct 2024 19:47:05 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Len Brown <lenb@kernel.org>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ivan Shapovalov <intelfx@intelfx.name>,
	Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH] ACPI: processor: Move arch_init_invariance_cppc() call
 later
Message-ID: <202410311924.XtRR5d9M-lkp@intel.com>
References: <20241029174910.600482-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029174910.600482-1-superm1@kernel.org>

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.12-rc5 next-20241031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/ACPI-processor-Move-arch_init_invariance_cppc-call-later/20241030-015107
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241029174910.600482-1-superm1%40kernel.org
patch subject: [PATCH] ACPI: processor: Move arch_init_invariance_cppc() call later
config: i386-randconfig-141-20241031 (https://download.01.org/0day-ci/archive/20241031/202410311924.XtRR5d9M-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241031/202410311924.XtRR5d9M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410311924.XtRR5d9M-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/processor_driver.c:273:2: error: call to undeclared function 'arch_init_invariance_cppc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     273 |         arch_init_invariance_cppc();
         |         ^
   1 error generated.


vim +/arch_init_invariance_cppc +273 drivers/acpi/processor_driver.c

   239	
   240	/*
   241	 * We keep the driver loaded even when ACPI is not running.
   242	 * This is needed for the powernow-k8 driver, that works even without
   243	 * ACPI, but needs symbols from this driver
   244	 */
   245	static enum cpuhp_state hp_online;
   246	static int __init acpi_processor_driver_init(void)
   247	{
   248		int result = 0;
   249	
   250		if (acpi_disabled)
   251			return 0;
   252	
   253		if (!cpufreq_register_notifier(&acpi_processor_notifier_block,
   254					       CPUFREQ_POLICY_NOTIFIER)) {
   255			acpi_processor_cpufreq_init = true;
   256			acpi_processor_ignore_ppc_init();
   257		}
   258	
   259		result = driver_register(&acpi_processor_driver);
   260		if (result < 0)
   261			return result;
   262	
   263		result = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
   264					   "acpi/cpu-drv:online",
   265					   acpi_soft_cpu_online, NULL);
   266		if (result < 0)
   267			goto err;
   268		hp_online = result;
   269		cpuhp_setup_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD, "acpi/cpu-drv:dead",
   270					  NULL, acpi_soft_cpu_dead);
   271	
   272		acpi_processor_throttling_init();
 > 273		arch_init_invariance_cppc();
   274		return 0;
   275	err:
   276		driver_unregister(&acpi_processor_driver);
   277		return result;
   278	}
   279	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

