Return-Path: <linux-acpi+bounces-9190-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646FB9B794E
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 12:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959281C22935
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 11:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF03199FD7;
	Thu, 31 Oct 2024 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvTcwFI3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC24199FC2;
	Thu, 31 Oct 2024 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730372775; cv=none; b=V0doI3nEUQ4TU7MXo5m/IEhfHTmmhNA56bFi416BH/LCLrFYSNhJLb+d7drtjJ1bP/pm/Ew8KFFSqYlaVQGAA+tcrlvfVmB8NjOLTE+12NHVM34Wd0rHpNTzoLOiiw5Yd3z2lwnOnll6yWKmSUmjndK4hvPfJkzned5CceApE88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730372775; c=relaxed/simple;
	bh=xxAXBtNnzvPWfaLv9FXxglhIlWGQUeGwE4AbyyfaVZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXj7Wc8SkrSF5Kt8zsaLAOtRNyUELFRIosxsedBYSDsqXN+jhwLKEKV7Py0/CnDupGRwhppsHP3X5Gjxr1y/nDT5YbWMEJq4cUiUPJ79imPrzHfCKI5ME3HrGNoWPd+o5ekUPWimSw5pZld9JQLPEmRrupRUXbTLv7dq2ERjsKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvTcwFI3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730372773; x=1761908773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xxAXBtNnzvPWfaLv9FXxglhIlWGQUeGwE4AbyyfaVZo=;
  b=KvTcwFI3cobqtUmiCmX2EmMyHQ82YFk8tifD0ZrCU6EI39Az2AzkyTzU
   tOwbyGMWbxqB+C0P1xD41/gr1YfZhKoqapkgwInB1ybkeRsB/Oc3xh59v
   7CFc7RlBO5jWbVWEUOxdOlJddqDJdsadTNSJAjjvGsbIvJ0NZxL4tP93G
   LDzuZ+UtUsuf0z51siCl/AcznY2NYuPqqKaPIted4LsU1j+tzJPoP/xU7
   4OogvIW+KQZx/Sd7HH/rjiEhPJ4N5KeBIxiDK++OKODFEOse3uVWPFjEU
   704WY9tjTf+B6zoCeppllXK5Amdd/Pa8sK4p26+qzGVgmwQKAYasRiMy1
   g==;
X-CSE-ConnectionGUID: Qq4zecstQ+61C4dTGoz6XQ==
X-CSE-MsgGUID: CyJvpgygSsKv3UJWjLppWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="30214662"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="30214662"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 04:06:12 -0700
X-CSE-ConnectionGUID: XlORb1l6SPaF8zi7c93N6g==
X-CSE-MsgGUID: m3WkWKG3Q3yadi6hFHXRbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="87198579"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 31 Oct 2024 04:06:10 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6T0C-000g1Y-00;
	Thu, 31 Oct 2024 11:06:08 +0000
Date: Thu, 31 Oct 2024 19:05:25 +0800
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
Message-ID: <202410311801.4Cjd0Myc-lkp@intel.com>
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
config: riscv-randconfig-r071-20241031 (https://download.01.org/0day-ci/archive/20241031/202410311801.4Cjd0Myc-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241031/202410311801.4Cjd0Myc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410311801.4Cjd0Myc-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/acpi/processor_driver.c: In function 'acpi_processor_driver_init':
>> drivers/acpi/processor_driver.c:273:9: error: implicit declaration of function 'arch_init_invariance_cppc' [-Wimplicit-function-declaration]
     273 |         arch_init_invariance_cppc();
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


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

