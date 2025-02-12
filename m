Return-Path: <linux-acpi+bounces-11089-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A331EA3221F
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 10:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA507A3496
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 09:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3B42046A1;
	Wed, 12 Feb 2025 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IuL9uzUu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6279A205E24;
	Wed, 12 Feb 2025 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352519; cv=none; b=rzEhl388prYzY1vlobBnHF973RnC4P1ICx5/+NgfyS/J3rEGhE1brJRRo+v6Y5ubBUAoNOyqghWrPTmNzjbNykfJRifUcLVHdC8+iTYB6mmbRlkV7v20msAqtSViXnpNEKw0HMO5lHcBTltxDrMQYvHrUTSiDKzlBlABDQ0NdjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352519; c=relaxed/simple;
	bh=gJpIK2N1oWtH5ADm/MDAKA+A5d3VUR0XUHUg0+3+Iq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cm/maOLWhiUrT8Z5G8EESgTAu4bv5fU78zSE95LiURn7AJ2uwnBncBIHoGcXjn1fuujpDDlXREWzR2LDDqgdD3vb7z+AgzmQQPM1sBSF6Qbn5C0q1jiVADBhMm4b6zQFx0vuzKNeZYR1SnYf+ZznYQkMtbQcZ0ZN+qQfd9YfGF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IuL9uzUu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739352517; x=1770888517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gJpIK2N1oWtH5ADm/MDAKA+A5d3VUR0XUHUg0+3+Iq8=;
  b=IuL9uzUuUH+8nCg77Sg+hb4u0zPJq0i75WfPFV7+3vTjA36JBLM6E2r7
   COVfCO8AZAy/nBEW2BdZdQ2cANqf1xd0kyJ4L9SHb3b2fteeTL3z/kBuJ
   ZDXsAo5JB2z9HTcXKedKREAJoqDZRODkxMGi658kJpuwIRZG0ssrzzMSh
   NUFOmx0Zo6UJwm7Cm5ct7QEVauOWDYnlM0Kv4D/CI/gm9zvMo4pIR003L
   zNISUcr3nZ2hFo5I0V4xwsAauVeySgJj8A0uFJkyHU1mCe/beLnxP5S+J
   EJGYHw+uopBnByxvSQdYboJsh6TiN1/8C2vE/9Wo+1olxLO0EqyoqpETB
   A==;
X-CSE-ConnectionGUID: fTfQ6i8fRB+M9w9c4GvkYA==
X-CSE-MsgGUID: 2zc2OsELS7Cz2/nAqIYjJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43925758"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="43925758"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 01:28:36 -0800
X-CSE-ConnectionGUID: uoFlp30lSuaGrdQz3fpcsg==
X-CSE-MsgGUID: XLCudRqwS5uKdTV8jnwDsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="112526808"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 12 Feb 2025 01:28:32 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ti92j-0015R1-2F;
	Wed, 12 Feb 2025 09:28:29 +0000
Date: Wed, 12 Feb 2025 17:27:58 +0800
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
Subject: Re: [Patch 5/5] cpufreq: CPPC: Add cppc_cpufreq_epp instance for
 Autonomous mode
Message-ID: <202502121734.xMnvqs6o-lkp@intel.com>
References: <20250211103737.447704-6-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211103737.447704-6-sumitg@nvidia.com>

Hi Sumit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20250210]
[cannot apply to rafael-pm/linux-next rafael-pm/bleeding-edge v6.14-rc2 v6.14-rc1 v6.13 linus/master v6.14-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sumit-Gupta/ACPI-CPPC-add-read-perf-ctrls-api-and-rename-few-existing/20250211-184154
base:   next-20250210
patch link:    https://lore.kernel.org/r/20250211103737.447704-6-sumitg%40nvidia.com
patch subject: [Patch 5/5] cpufreq: CPPC: Add cppc_cpufreq_epp instance for Autonomous mode
config: riscv-randconfig-001-20250212 (https://download.01.org/0day-ci/archive/20250212/202502121734.xMnvqs6o-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 6807164500e9920638e2ab0cdb4bf8321d24f8eb)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502121734.xMnvqs6o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502121734.xMnvqs6o-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/cppc_cpufreq.c:780:68: warning: more '%' conversions than data arguments [-Wformat-insufficient-args]
     780 |         pr_debug("cpu%d, curr epp:%u, new epp:%u, curr mode:%u, new mode:%u\n",
         |                                                                          ~^
   include/linux/printk.h:631:30: note: expanded from macro 'pr_debug'
     631 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                                     ^~~
   drivers/cpufreq/cppc_cpufreq.c:11:37: note: expanded from macro 'pr_fmt'
      11 | #define pr_fmt(fmt)     "CPPC Cpufreq:" fmt
         |                                         ^~~
   include/linux/printk.h:135:11: note: expanded from macro 'no_printk'
     135 |                 _printk(fmt, ##__VA_ARGS__);            \
         |                         ^~~
>> drivers/cpufreq/cppc_cpufreq.c:799:23: warning: unused variable 'cpu_data' [-Wunused-variable]
     799 |         struct cppc_cpudata *cpu_data = policy->driver_data;
         |                              ^~~~~~~~
   drivers/cpufreq/cppc_cpufreq.c:1018:23: warning: unused variable 'cpu_data' [-Wunused-variable]
    1018 |         struct cppc_cpudata *cpu_data;
         |                              ^~~~~~~~
>> drivers/cpufreq/cppc_cpufreq.c:1019:11: warning: unused variable 'pref' [-Wunused-variable]
    1019 |         int cpu, pref, ret = 0;
         |                  ^~~~
   4 warnings generated.


vim +780 drivers/cpufreq/cppc_cpufreq.c

   773	
   774	static int cppc_cpufreq_epp_update_auto_mode(struct cpufreq_policy *policy, int auto_sel, u32 epp)
   775	{
   776		struct cppc_cpudata *cpu_data = policy->driver_data;
   777		int ret, curr_epp;
   778	
   779		curr_epp = cpu_data->perf_ctrls.energy_perf;
 > 780		pr_debug("cpu%d, curr epp:%u, new epp:%u, curr mode:%u, new mode:%u\n",
   781			 curr_epp, epp, cpu_data->perf_caps.auto_sel, auto_sel);
   782	
   783		/* set Performance preference as default */
   784		cpu_data->perf_ctrls.energy_perf = epp;
   785		ret = cppc_set_epp_perf(policy->cpu, &cpu_data->perf_ctrls, auto_sel);
   786		if (ret < 0) {
   787			pr_err("failed to set energy perf value (%d)\n", ret);
   788			cpu_data->perf_ctrls.energy_perf = curr_epp;
   789			return ret;
   790		}
   791		cpu_data->perf_caps.auto_sel = auto_sel;
   792	
   793		return ret;
   794	}
   795	
   796	static int cppc_cpufreq_epp_update_perf(struct cpufreq_policy *policy, int auto_sel, u32 epp,
   797						u32 highest_perf, u32 lowest_perf)
   798	{
 > 799		struct cppc_cpudata *cpu_data = policy->driver_data;
   800		int ret;
   801	
   802		ret = cppc_cpufreq_epp_update_perf_ctrls(policy, highest_perf, lowest_perf);
   803		if (ret)
   804			return ret;
   805	
   806		ret = cppc_cpufreq_epp_update_auto_mode(policy, auto_sel, epp);
   807		if (ret)
   808			return ret;
   809	
   810		return ret;
   811	}
   812	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

