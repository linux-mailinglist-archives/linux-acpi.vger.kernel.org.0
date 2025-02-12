Return-Path: <linux-acpi+bounces-11086-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F53A3210F
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 09:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76AD0188B0AB
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 08:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA91205503;
	Wed, 12 Feb 2025 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDudayGq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3053E204F73;
	Wed, 12 Feb 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348792; cv=none; b=l8oz9Y/rnL3k2jzAtlHZFi4uC2IT33MqIr8sauomolSCrCSeXMs+NEdB6GG0o0kWkj6jnlbyq8P4QafFT0lgWUZv2iv861Tp14K/2eKnrJR4oTgii+kyVP9A9DEdAnjat3ML4QYe8tJnEQmqpyWSAcR/JZStzDstqwPcVG7ogsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348792; c=relaxed/simple;
	bh=SrzGn1c0JLdZuLtX1GIffHogC91jGV4Iua5E6KKiYOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRCbsT17P3dPeTwWPoLarUUpRMaEgg6nXHuZecR6OCHsZIX5uoLp6iHHnkdlCnxRAQV0QS0nC1z1QV0CA7nNVKAaTD4SxtYP3C/VJrLh2bbC3RMAv/Rnsptv1Ff1uHrU+qzmJtZXsdb1jHCVAUOC8+lPBQj6iBRQU8USSBI8cE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDudayGq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739348790; x=1770884790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SrzGn1c0JLdZuLtX1GIffHogC91jGV4Iua5E6KKiYOU=;
  b=GDudayGq5lwMiJKc8Oy46GYWCsGXv233PwOwk29rzc0PuxbWuLc6GneW
   +iBLYJr50Y0JUpnaOHZ1lRLDw3ZYMZVlMhonc8bwDWGfRDF9LPHRgyeN9
   EY4cQrEWwUqTN8rZfCYZYWfMNHXWezo2m6wvKuW/higaycQwa2G+utxis
   3XVa0ST/7vORZ5rAGm582n0sOqEsb65opOI4wem59UZ+ThwWw6HWKzQmB
   zb8iXEEzS5mnLgjyw3GltgA+3tw1uToV9ZM/ICPzA60JVMy7IM9EpY9pg
   NiURfToYZ019vqAtUW6SywkRBJJh7vaTJ5s+vU5i1HR4jvJrBGJopGJ58
   g==;
X-CSE-ConnectionGUID: JaukPrHOT0uXEHgZgWZQfw==
X-CSE-MsgGUID: uTVWjinOSg2Aw7dx0ZwDLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40114731"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40114731"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 00:26:29 -0800
X-CSE-ConnectionGUID: vvTe5n8/Sg2KTZj+YkbRtg==
X-CSE-MsgGUID: KiP3q/SHSSi1wyxKZEnhVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="112585409"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 12 Feb 2025 00:26:24 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ti84c-0015N9-11;
	Wed, 12 Feb 2025 08:26:22 +0000
Date: Wed, 12 Feb 2025 16:25:30 +0800
From: kernel test robot <lkp@intel.com>
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
	corbet@lwn.net, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-tegra@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, sashal@nvidia.com, vsethi@nvidia.com,
	ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com,
	sumitg@nvidia.com
Subject: Re: [Patch 1/5] ACPI: CPPC: add read perf ctrls api and rename few
 existing
Message-ID: <202502121658.IcwbwB0y-lkp@intel.com>
References: <20250211103737.447704-2-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211103737.447704-2-sumitg@nvidia.com>

Hi Sumit,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250210]
[also build test ERROR on linus/master v6.14-rc2]
[cannot apply to rafael-pm/linux-next rafael-pm/bleeding-edge v6.14-rc2 v6.14-rc1 v6.13]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sumit-Gupta/ACPI-CPPC-add-read-perf-ctrls-api-and-rename-few-existing/20250211-184154
base:   next-20250210
patch link:    https://lore.kernel.org/r/20250211103737.447704-2-sumitg%40nvidia.com
patch subject: [Patch 1/5] ACPI: CPPC: add read perf ctrls api and rename few existing
config: x86_64-buildonly-randconfig-002-20250212 (https://download.01.org/0day-ci/archive/20250212/202502121658.IcwbwB0y-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502121658.IcwbwB0y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502121658.IcwbwB0y-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/cpufreq/amd-pstate.c:395:10: error: call to undeclared function 'cppc_set_perf'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     395 |                         ret = cppc_set_perf(cpu, &perf_ctrls);
         |                               ^
   drivers/cpufreq/amd-pstate.c:395:10: note: did you mean 'cppc_set_epp_perf'?
   include/acpi/cppc_acpi.h:161:12: note: 'cppc_set_epp_perf' declared here
     161 | extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
         |            ^
   drivers/cpufreq/amd-pstate.c:498:9: error: call to undeclared function 'cppc_set_perf'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     498 |         return cppc_set_perf(cpudata->cpu, &perf_ctrls);
         |                ^
   2 errors generated.
--
>> drivers/acpi/cppc_acpi.c:1734:6: warning: variable 'energy_perf' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1734 |         if (CPC_SUPPORTED(energy_perf_reg))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/cppc_acpi.c:129:28: note: expanded from macro 'CPC_SUPPORTED'
     129 | #define CPC_SUPPORTED(cpc) ((cpc)->type == ACPI_TYPE_INTEGER ?          \
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     130 |                                 !!(cpc)->cpc_entry.int_value :          \
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     131 |                                 !IS_NULL_REG(&(cpc)->cpc_entry.reg))
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/cppc_acpi.c:1736:28: note: uninitialized use occurs here
    1736 |         perf_ctrls->energy_perf = energy_perf;
         |                                   ^~~~~~~~~~~
   drivers/acpi/cppc_acpi.c:1734:2: note: remove the 'if' if its condition is always true
    1734 |         if (CPC_SUPPORTED(energy_perf_reg))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1735 |                 cpc_read(cpu, energy_perf_reg, &energy_perf);
   drivers/acpi/cppc_acpi.c:1689:41: note: initialize the variable 'energy_perf' to silence this warning
    1689 |         u64 max, min, desired_perf, energy_perf;
         |                                                ^
         |                                                 = 0
>> drivers/acpi/cppc_acpi.c:1730:6: warning: variable 'desired_perf' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1730 |         if (CPC_SUPPORTED(desired_perf_reg))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/cppc_acpi.c:129:28: note: expanded from macro 'CPC_SUPPORTED'
     129 | #define CPC_SUPPORTED(cpc) ((cpc)->type == ACPI_TYPE_INTEGER ?          \
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     130 |                                 !!(cpc)->cpc_entry.int_value :          \
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     131 |                                 !IS_NULL_REG(&(cpc)->cpc_entry.reg))
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/cppc_acpi.c:1732:29: note: uninitialized use occurs here
    1732 |         perf_ctrls->desired_perf = desired_perf;
         |                                    ^~~~~~~~~~~~
   drivers/acpi/cppc_acpi.c:1730:2: note: remove the 'if' if its condition is always true
    1730 |         if (CPC_SUPPORTED(desired_perf_reg))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1731 |                 cpc_read(cpu, desired_perf_reg, &desired_perf);
   drivers/acpi/cppc_acpi.c:1689:28: note: initialize the variable 'desired_perf' to silence this warning
    1689 |         u64 max, min, desired_perf, energy_perf;
         |                                   ^
         |                                    = 0
>> drivers/acpi/cppc_acpi.c:1726:6: warning: variable 'min' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1726 |         if (CPC_SUPPORTED(min_perf_reg))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/cppc_acpi.c:129:28: note: expanded from macro 'CPC_SUPPORTED'
     129 | #define CPC_SUPPORTED(cpc) ((cpc)->type == ACPI_TYPE_INTEGER ?          \
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     130 |                                 !!(cpc)->cpc_entry.int_value :          \
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     131 |                                 !IS_NULL_REG(&(cpc)->cpc_entry.reg))
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/cppc_acpi.c:1728:25: note: uninitialized use occurs here
    1728 |         perf_ctrls->min_perf = min;
         |                                ^~~
   drivers/acpi/cppc_acpi.c:1726:2: note: remove the 'if' if its condition is always true
    1726 |         if (CPC_SUPPORTED(min_perf_reg))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1727 |                 cpc_read(cpu, min_perf_reg, &min);
   drivers/acpi/cppc_acpi.c:1689:14: note: initialize the variable 'min' to silence this warning
    1689 |         u64 max, min, desired_perf, energy_perf;
         |                     ^
         |                      = 0
>> drivers/acpi/cppc_acpi.c:1722:6: warning: variable 'max' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1722 |         if (CPC_SUPPORTED(max_perf_reg))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/cppc_acpi.c:129:28: note: expanded from macro 'CPC_SUPPORTED'
     129 | #define CPC_SUPPORTED(cpc) ((cpc)->type == ACPI_TYPE_INTEGER ?          \
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     130 |                                 !!(cpc)->cpc_entry.int_value :          \
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     131 |                                 !IS_NULL_REG(&(cpc)->cpc_entry.reg))
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/cppc_acpi.c:1724:25: note: uninitialized use occurs here
    1724 |         perf_ctrls->max_perf = max;
         |                                ^~~
   drivers/acpi/cppc_acpi.c:1722:2: note: remove the 'if' if its condition is always true
    1722 |         if (CPC_SUPPORTED(max_perf_reg))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1723 |                 cpc_read(cpu, max_perf_reg, &max);
   drivers/acpi/cppc_acpi.c:1689:9: note: initialize the variable 'max' to silence this warning
    1689 |         u64 max, min, desired_perf, energy_perf;
         |                ^
         |                 = 0
   4 warnings generated.
--
>> drivers/acpi/cppc_acpi.c:1685: warning: expecting prototype for cppc_get_perf(). Prototype was for cppc_get_perf_ctrls() instead


vim +/cppc_set_perf +395 drivers/cpufreq/amd-pstate.c

ec437d71db77a1 Huang Rui         2021-12-24  377  
7fb463aac84577 Dhananjay Ugwekar 2024-10-23  378  static int shmem_cppc_enable(bool enable)
e059c184da47e9 Huang Rui         2021-12-24  379  {
e059c184da47e9 Huang Rui         2021-12-24  380  	int cpu, ret = 0;
ffa5096a7c3386 Perry Yuan        2023-01-31  381  	struct cppc_perf_ctrls perf_ctrls;
e059c184da47e9 Huang Rui         2021-12-24  382  
217e67784eab30 Wyes Karny        2023-05-30  383  	if (enable == cppc_enabled)
217e67784eab30 Wyes Karny        2023-05-30  384  		return 0;
217e67784eab30 Wyes Karny        2023-05-30  385  
e059c184da47e9 Huang Rui         2021-12-24  386  	for_each_present_cpu(cpu) {
e059c184da47e9 Huang Rui         2021-12-24  387  		ret = cppc_set_enable(cpu, enable);
e059c184da47e9 Huang Rui         2021-12-24  388  		if (ret)
e059c184da47e9 Huang Rui         2021-12-24  389  			return ret;
ffa5096a7c3386 Perry Yuan        2023-01-31  390  
ffa5096a7c3386 Perry Yuan        2023-01-31  391  		/* Enable autonomous mode for EPP */
ffa5096a7c3386 Perry Yuan        2023-01-31  392  		if (cppc_state == AMD_PSTATE_ACTIVE) {
ffa5096a7c3386 Perry Yuan        2023-01-31  393  			/* Set desired perf as zero to allow EPP firmware control */
ffa5096a7c3386 Perry Yuan        2023-01-31  394  			perf_ctrls.desired_perf = 0;
ffa5096a7c3386 Perry Yuan        2023-01-31 @395  			ret = cppc_set_perf(cpu, &perf_ctrls);
ffa5096a7c3386 Perry Yuan        2023-01-31  396  			if (ret)
ffa5096a7c3386 Perry Yuan        2023-01-31  397  				return ret;
ffa5096a7c3386 Perry Yuan        2023-01-31  398  		}
e059c184da47e9 Huang Rui         2021-12-24  399  	}
e059c184da47e9 Huang Rui         2021-12-24  400  
217e67784eab30 Wyes Karny        2023-05-30  401  	cppc_enabled = enable;
e059c184da47e9 Huang Rui         2021-12-24  402  	return ret;
e059c184da47e9 Huang Rui         2021-12-24  403  }
e059c184da47e9 Huang Rui         2021-12-24  404  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

