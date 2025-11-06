Return-Path: <linux-acpi+bounces-18577-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F338C3A4AA
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 11:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 250B1502228
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 10:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36222C0F67;
	Thu,  6 Nov 2025 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STVLeWeH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8466245C0B;
	Thu,  6 Nov 2025 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762425072; cv=none; b=iTMCrveAFh8hznfDw/IzKOHds4ed1DyjFbqM2ozecrdkq7D0xeGX/01OvcqeYAlj2PlDvkA4Q2cglNPGEl3isHtnUD3hiWrPIMbqSaxlcM8TDhq3k9omqHKQYRX28mkvxh4mLbcBYvdWB3AIV0ctWZZ0yr6a09XhPlc1UM1X4hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762425072; c=relaxed/simple;
	bh=JFOdbYffsARPA55o25J5nmd1eh1TGG+Rp7ggcIJ/X3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2TfHKG+2tG4O+EGr8tgoOBm1nvB7cnG3Gy0t562xy5Lt2YiezRLm2EvgKs0QU2AD8gGPt5k70RlQSYH9wAbud6y9u9LKM8gSFZ+d0x57ItpR1nJX/35pGNSuK/64Q7zSlvCYJ+o4B3qp0gP5tx2bbtEEaGLzGA5igoNQqp7bVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STVLeWeH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762425071; x=1793961071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JFOdbYffsARPA55o25J5nmd1eh1TGG+Rp7ggcIJ/X3I=;
  b=STVLeWeHzv6ILv38R2/zQgW/qNBZtJTXA6cqGDCuVjLEXzLwB5pAmRil
   ROUq5W8wj0jH8XTLBT8lX0G2ogpoodfxBYAPB98DhUuIQVy2TLsbBR0sB
   RV8s0g61kjt1ty9uJNqxfkzOW/zYzz9gaht7e6Tgi65Bei+jwfp/snfgR
   DJSlvPscg5d/uXF9LqXVJTUHjuZC2FS5nTvay3pn1Moq2NzwhQeS+53Y5
   wy5s6+pm+0CbkNgNi8Nr4g7Lof0KKV23eILNq6FyZRAD1GvNk/PMkHHhQ
   1k2Vyt62LD1GtIkEHFxr2IVz0iB39Xox+DId41h7cPZYpOe7Ut+BS4arn
   w==;
X-CSE-ConnectionGUID: COzVy9g0T82U3s7hNBjJgw==
X-CSE-MsgGUID: WYZMXqnhRP2siWooEQS4AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="82187838"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="82187838"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 02:31:10 -0800
X-CSE-ConnectionGUID: dnlOyaMCRDCGbU6AZp/ILA==
X-CSE-MsgGUID: VPaCKE7sRxmOnX0GhoFMRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="186974815"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 06 Nov 2025 02:31:03 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGxGf-000Tlq-05;
	Thu, 06 Nov 2025 10:31:01 +0000
Date: Thu, 6 Nov 2025 18:30:18 +0800
From: kernel test robot <lkp@intel.com>
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
	corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
	rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
	mario.limonciello@amd.com, perry.yuan@amd.com,
	ionela.voinescu@arm.com, zhanjie9@hisilicon.com,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-tegra@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com,
	sanjayc@nvidia.com, nhartman@nvidia.com, bbasu@nvidia.com,
	sumitg@nvidia.com
Subject: Re: [PATCH v4 4/8] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
Message-ID: <202511061802.lIq09jwh-lkp@intel.com>
References: <20251105113844.4086250-5-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105113844.4086250-5-sumitg@nvidia.com>

Hi Sumit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.18-rc4 next-20251106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sumit-Gupta/cpufreq-CPPC-Add-generic-helpers-for-sysfs-show-store/20251105-194715
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20251105113844.4086250-5-sumitg%40nvidia.com
patch subject: [PATCH v4 4/8] ACPI: CPPC: add APIs and sysfs interface for min/max_perf
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20251106/202511061802.lIq09jwh-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d2625a438020ad35330cda29c3def102c1687b1b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251106/202511061802.lIq09jwh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511061802.lIq09jwh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/cpufreq/cppc_cpufreq.c:954 function parameter 'policy' not described in 'show_min_perf'
>> Warning: drivers/cpufreq/cppc_cpufreq.c:954 function parameter 'buf' not described in 'show_min_perf'
>> Warning: drivers/cpufreq/cppc_cpufreq.c:976 function parameter 'policy' not described in 'store_min_perf'
>> Warning: drivers/cpufreq/cppc_cpufreq.c:976 function parameter 'buf' not described in 'store_min_perf'
>> Warning: drivers/cpufreq/cppc_cpufreq.c:976 function parameter 'count' not described in 'store_min_perf'
>> Warning: drivers/cpufreq/cppc_cpufreq.c:1003 function parameter 'policy' not described in 'show_max_perf'
>> Warning: drivers/cpufreq/cppc_cpufreq.c:1003 function parameter 'buf' not described in 'show_max_perf'
>> Warning: drivers/cpufreq/cppc_cpufreq.c:1025 function parameter 'policy' not described in 'store_max_perf'
>> Warning: drivers/cpufreq/cppc_cpufreq.c:1025 function parameter 'buf' not described in 'store_max_perf'
>> Warning: drivers/cpufreq/cppc_cpufreq.c:1025 function parameter 'count' not described in 'store_max_perf'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

