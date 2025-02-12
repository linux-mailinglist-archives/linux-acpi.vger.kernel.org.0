Return-Path: <linux-acpi+bounces-11084-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B971A32090
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 09:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824DF163191
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 08:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1894204C35;
	Wed, 12 Feb 2025 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LA9P3jvU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81C1E98EC;
	Wed, 12 Feb 2025 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347408; cv=none; b=AAX2In5AEoXwhJglU1927wqciE4B3FM5lygVyX3ocr89PUlRbwDOnKPizT0mz1vGdauNuy9mOgN2/kc3+r+gYXxeX3LTjsB09/b6inZSs6dZ7cq014F3WeQJMmIxajU9FvCcUQ27c5++NVEBT/W1ekkwmuDDz6xKCHrn8aDylHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347408; c=relaxed/simple;
	bh=+cvV45dapivkiAV0ddWbD2YnHoyYc+Kfg/cxdIUY7NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLPhnXSqJeD5WP/NZ5ikw/AYJjDL40aqgdH/6/qtIfV3YjGlyrkxTxD4oBnMhdG0gDyJ8zk1rQN23pLdKsA1tRsGL6WMv9DVVrNXNasF5kgZS99sHLhRLk7MVaFcLC+W4/YIcC9tL6Be4lBWM98JvNcBTm2uP/7sxgbrmmz5OY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LA9P3jvU; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739347407; x=1770883407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+cvV45dapivkiAV0ddWbD2YnHoyYc+Kfg/cxdIUY7NM=;
  b=LA9P3jvU4M778LWMBAgiK4CANetrH0iVVhutG2BDkScWnwm8t8TxffO4
   ct2DoSuW76xtTc1PoGKZc3HOjX7KkugaVC/Ib7gYwNDRErQlN5LYcVHq1
   AIv2cPNY/b5cAVyofgC9BzNGbt60qWMNRH9a0wIIo3ejJzD8I8wGq+u4e
   AaVM4Oj9bp/30PzsbHZZ56jtepjt+Sv2oGUNFbpaOtlzBPno7pD/X7Hqq
   aaFWmZlaq83LAJ59pFrZwN8KQtwLPXOn9lPaBslQrNzQSy149BAUwyynS
   4xRvXuO94pKmQ2s4rNwIbujXpM5P/hLR/5Ny0jqNpOQMvHjbBus4ogjsf
   A==;
X-CSE-ConnectionGUID: mVPvaTwBRii8lnNplmCHjw==
X-CSE-MsgGUID: MMnVE26uTKWb/X6oLa0Hlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="51384817"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="51384817"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 00:03:27 -0800
X-CSE-ConnectionGUID: JANOCzMbRCyoDCzkcpVdNA==
X-CSE-MsgGUID: GG1DiF8HR/K0Cl4csWnfEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117929714"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Feb 2025 00:03:22 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ti7iJ-0015LB-1n;
	Wed, 12 Feb 2025 08:03:19 +0000
Date: Wed, 12 Feb 2025 16:03:02 +0800
From: kernel test robot <lkp@intel.com>
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
	corbet@lwn.net, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-tegra@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, sashal@nvidia.com,
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
	bbasu@nvidia.com, sumitg@nvidia.com
Subject: Re: [Patch 1/5] ACPI: CPPC: add read perf ctrls api and rename few
 existing
Message-ID: <202502121512.r83JqnGm-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-005-20250212 (https://download.01.org/0day-ci/archive/20250212/202502121512.r83JqnGm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502121512.r83JqnGm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502121512.r83JqnGm-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/cpufreq/amd-pstate.c: In function 'shmem_cppc_enable':
>> drivers/cpufreq/amd-pstate.c:395:31: error: implicit declaration of function 'cppc_set_perf'; did you mean 'cppc_set_epp_perf'? [-Werror=implicit-function-declaration]
     395 |                         ret = cppc_set_perf(cpu, &perf_ctrls);
         |                               ^~~~~~~~~~~~~
         |                               cppc_set_epp_perf
   cc1: some warnings being treated as errors


vim +395 drivers/cpufreq/amd-pstate.c

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

