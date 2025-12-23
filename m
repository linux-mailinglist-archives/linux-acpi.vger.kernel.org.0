Return-Path: <linux-acpi+bounces-19793-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BAECD7995
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 01:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A47F130202D4
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 00:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8D41AAE17;
	Tue, 23 Dec 2025 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfsCdlu/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F5A186E58;
	Tue, 23 Dec 2025 00:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766451454; cv=none; b=juOJo2yQ+LxRu3IDndXhtMrhpGJpwV2z7eJscgMv1usHNId3GevQr44L5Kmfq0c4hpq3HnBLEmSxhMwmCv1zlGGcI1z3NmZNOFLE7Vpo+mqFYzbrHQHSJKVt8qbX1ac1p/K7TviJvHOCrRlm4ESd9KCxc1gPtx+OxNoaAO0PCCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766451454; c=relaxed/simple;
	bh=Tzhli8fZhmydE3WtkzmFX0iuaaxe/re1tXi3k0T9e3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeaHSCnwybOVXjkJejnrzTZUCdpSiPFoMrjiTdBEr4P1yTHKGg+a8VzdXWuitj5nD+nbkwRyKupyQT2gvmp6QIwVqiXbEjCj6DriuWa4S16JSAhMyFoG2+b/EVZS/ctzWi05T7IdNVtIGG3tDEjuLQWw0prLKbHkGVjUb9ievyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfsCdlu/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766451453; x=1797987453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tzhli8fZhmydE3WtkzmFX0iuaaxe/re1tXi3k0T9e3o=;
  b=SfsCdlu/ycQIVPofVV9gqBl5VhB6+dGqEVYYrLx44oV4U5KHpGSxsNXS
   27lh9FOgXG7Km6ES14JFUiO8g/hTvAoczsLANpytsGefmqzZo5ye1UOsk
   3rxTJJgEDV6oNfMdgV8IPlzILYCoHiMx4O90y7MSvVww1vvRhZSbr4znc
   /MZSUl7dYR5U93X6k9tsFBdpE7TyWyBGkk6vRR0C++VVM64uXMHYwkdx/
   vH5BXD3pQgDMAF/FKwtCPgBQ/yLf9IFi6d7UFamQxgAYF5PjH2u7pwfbW
   rNKQLHSch8uG2512HcRVYwphMW8r1cJ58Ji4IOu2nvQpuyAt09qaevdNl
   A==;
X-CSE-ConnectionGUID: 8RvRtkKXS/2x+Km+wLutkA==
X-CSE-MsgGUID: QfvgMCAjQbaJjn5PxFMxiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="68350541"
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="68350541"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 16:57:32 -0800
X-CSE-ConnectionGUID: 1obue43dSTyg7GkfEywvfw==
X-CSE-MsgGUID: rJm/Ik0hRb+dawbPI+6Clw==
X-ExtLoop1: 1
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by fmviesa003.fm.intel.com with ESMTP; 22 Dec 2025 16:57:28 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXqiM-000000005gO-0t6c;
	Tue, 23 Dec 2025 00:57:26 +0000
Date: Tue, 23 Dec 2025 01:57:16 +0100
From: kernel test robot <lkp@intel.com>
To: Ruidong Tian <tianruidong@linux.alibaba.com>, catalin.marinas@arm.com,
	will@kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com,
	sudeep.holla@arm.com, xueshuai@linux.alibaba.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	lenb@kernel.org, tony.luck@intel.com, bp@alien8.de,
	yazen.ghannam@amd.com, misono.tomohiro@fujitsu.com
Cc: oe-kbuild-all@lists.linux.dev, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v4 10/17] ras: AEST: Introduce AEST driver sysfs interface
Message-ID: <202512230122.CfXZcF76-lkp@intel.com>
References: <20251222094351.38792-11-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222094351.38792-11-tianruidong@linux.alibaba.com>

Hi Ruidong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge ras/edac-for-next next-20251219]
[cannot apply to arm64/for-next/core linus/master tip/smp/core v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ruidong-Tian/ACPI-AEST-Parse-the-AEST-table/20251222-175211
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20251222094351.38792-11-tianruidong%40linux.alibaba.com
patch subject: [PATCH v4 10/17] ras: AEST: Introduce AEST driver sysfs interface
reproduce: (https://download.01.org/0day-ci/archive/20251223/202512230122.CfXZcF76-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512230122.CfXZcF76-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Using alabaster theme
   ERROR: Cannot find file ./include/linux/pci.h
   WARNING: No kernel-doc for file ./include/linux/pci.h
   ERROR: Cannot find file ./include/linux/mod_devicetable.h
   WARNING: No kernel-doc for file ./include/linux/mod_devicetable.h
>> Documentation/ABI/testing/debugfs-aest:1: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
   ERROR: Cannot find file ./include/linux/bootconfig.h
   WARNING: No kernel-doc for file ./include/linux/bootconfig.h
   ERROR: Cannot find file ./include/linux/pstore_zone.h
   ERROR: Cannot find file ./include/linux/pstore_zone.h
   WARNING: No kernel-doc for file ./include/linux/pstore_zone.h


vim +1 Documentation/ABI/testing/debugfs-aest

   > 1	What:		/sys/kernel/debug/aest/<name>.<id>/
     2	Date:		Dec 2025
     3	KernelVersion	6.19
     4	Contact:	Ruidong Tian <tianruidong@linux.alibaba.com>
     5	Description:
     6			Directory represented a AEST device, <name> means device type,
     7			like:
     8	
     9				processor
    10				memory
    11				smmu
    12				...
    13			<id> is the unique ID for this device.
    14	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

