Return-Path: <linux-acpi+bounces-19840-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79522CDD014
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Dec 2025 19:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 351D33009F1E
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Dec 2025 18:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5ED2F5474;
	Wed, 24 Dec 2025 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLhNK3j9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B664B86337;
	Wed, 24 Dec 2025 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766601185; cv=none; b=CrnsTiviYqw8zywdeHWe4kY4WTr3RIbe28v61517x1AnD9VmsRe9WB4Pz4kNF8Yg8qFv8rcVUdy2pSPXCvnZFDRwUzgZCIXGVtfWbu9ndLuyDJ5QJM7sZSZ9btg0nL8BLr9oxwDi1FHQd0P8sG26JSIuAUKAF076LnzieISw2qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766601185; c=relaxed/simple;
	bh=RsG87ueyldnZZZk3PsZzqf+vvdsWkt7pyksxnFNVWBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvzmGRkHbFr3+VrtjwFMK42icV6Y61vm00BLYucURO/DzOGmVhz+SfpnJl7znLi1JxOw3K3JTu9nPLe0rCe9z4xGv2ThTSlkQPsuwQGhGdGrJOpJsxmx4b/CKtQ/tBIgpbVy8ynlWShnzdl48wA+6bU6DmXuUZ4UX0jS0Z4QjQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLhNK3j9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766601184; x=1798137184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RsG87ueyldnZZZk3PsZzqf+vvdsWkt7pyksxnFNVWBU=;
  b=lLhNK3j9PL8oSkCwOP6K6ocZt3F/EHta8480nugK2fduJlcSUX2OrqVx
   hus4yqmbCQZi5nAcIgnTQQDiTRzGWXNMqbD0wOrLgtgBIPzrai9d3rWuZ
   bUTepfby9ZjapsZGLPqaZBFLVwcDT60pslyx+aZC7Y2kANxZXXDVnpdHj
   74SImfAi+fym2xlaiE45F5ISQy32JmzGLgoQqqVbOOBK1ON+/cbqH3qnS
   nX45ZgTm+2B643amdt/eAmCgbuhl6El9Xb4P9Ipdi/V204N9B5IJNFGLw
   vw85d+THswzJQZ9vln+/gxD5gR4mFQd78r3aTXMnROnYFNLN410eab5ND
   g==;
X-CSE-ConnectionGUID: WwCPfXMxQwS0Q4MXl3/5CA==
X-CSE-MsgGUID: MiSvo8EXQAe/wGo9KpaBCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="72061774"
X-IronPort-AV: E=Sophos;i="6.21,174,1763452800"; 
   d="scan'208";a="72061774"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2025 10:33:03 -0800
X-CSE-ConnectionGUID: hIIlLaeHRTO+FMsExmvWDw==
X-CSE-MsgGUID: FV+miLuFT0ee+nKrm1TQZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,174,1763452800"; 
   d="scan'208";a="231124025"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by fmviesa001.fm.intel.com with ESMTP; 24 Dec 2025 10:32:57 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYTfL-000000006Ia-0DOx;
	Wed, 24 Dec 2025 18:32:55 +0000
Date: Wed, 24 Dec 2025 19:32:53 +0100
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
Cc: oe-kbuild-all@lists.linux.dev, linux-tegra@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
	ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com,
	bbasu@nvidia.com, sumitg@nvidia.com
Subject: Re: [PATCH v5 07/11] cpufreq: CPPC: Add sysfs for min/max_perf and
 perf_limited
Message-ID: <202512241930.heuhsbt9-lkp@intel.com>
References: <20251223121307.711773-8-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223121307.711773-8-sumitg@nvidia.com>

Hi Sumit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.19-rc2 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sumit-Gupta/cpufreq-CPPC-Add-generic-helpers-for-sysfs-show-store/20251224-001833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20251223121307.711773-8-sumitg%40nvidia.com
patch subject: [PATCH v5 07/11] cpufreq: CPPC: Add sysfs for min/max_perf and perf_limited
reproduce: (https://download.01.org/0day-ci/archive/20251224/202512241930.heuhsbt9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512241930.heuhsbt9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Using alabaster theme
   ERROR: Cannot find file ./include/linux/pci.h
   WARNING: No kernel-doc for file ./include/linux/pci.h
   ERROR: Cannot find file ./include/linux/mod_devicetable.h
   WARNING: No kernel-doc for file ./include/linux/mod_devicetable.h
>> Documentation/ABI/testing/sysfs-devices-system-cpu:356: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
   ERROR: Cannot find file ./include/linux/bootconfig.h
   WARNING: No kernel-doc for file ./include/linux/bootconfig.h
   ERROR: Cannot find file ./include/linux/pstore_zone.h
   ERROR: Cannot find file ./include/linux/pstore_zone.h
   WARNING: No kernel-doc for file ./include/linux/pstore_zone.h


vim +356 Documentation/ABI/testing/sysfs-devices-system-cpu

   347	
   348			Read/write a frequency value in kHz from/to this file. This
   349			file sets the maximum performance level (as frequency) at
   350			which the platform may run. The frequency value is internally
   351			converted to a performance value and must be in the range
   352			[cpuinfo_min_freq, cpuinfo_max_freq], inclusive.
   353	
   354			This file is only present if the cppc-cpufreq driver is in use.
   355	
 > 356	What:		/sys/devices/system/cpu/cpuX/cpufreq/perf_limited
   357	Date:		February 2026
   358	Contact:	linux-pm@vger.kernel.org
   359	Description:	Performance Limited
   360	
   361			Read to check if platform throttling (thermal/power/current
   362			limits) caused delivered performance to fall below the
   363			requested level. A non-zero value indicates throttling occurred.
   364	
   365			Write the bitmask of bits to clear:
   366			  1 = clear bit 0 (desired performance excursion)
   367			  2 = clear bit 1 (minimum performance excursion)
   368			  3 = clear both bits
   369			The platform sets these bits; OSPM can only clear them.
   370	
   371			This file is only present if the cppc-cpufreq driver is in use.
   372	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

