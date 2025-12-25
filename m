Return-Path: <linux-acpi+bounces-19843-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C9CCDD639
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 08:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1775300C165
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 07:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398D72D97BA;
	Thu, 25 Dec 2025 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0stUJ6n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAD62D780A;
	Thu, 25 Dec 2025 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766645994; cv=none; b=cPUq49KurnmMyShvNazv/UfWNHyhxFLcQ6w1WSpoYsiMKEmJBHVjvxNn3sXgu2Sxxw3z82LyXSDBBtnQIopPp0S1GwHO3FlMlVnA8P3K0Ay6PBNQ2XCeasZeqFK5g1s6x19AE5EoHa0Ancsyd8rGIv+OfMQoU3XCKAtEDyrB5is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766645994; c=relaxed/simple;
	bh=+WiEymJv/nr2X5pjWCtt6q+S4mNEdgmhNha83diODgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXdREZGkZeSDWBf8Sv9ohG6TjTOt5Nbg1u3sQ2/BqnE7Xtg1wDIJHb9nyX+KhMG9zXG/Kojm7+II4KA6wKJctNTKY6bxRwxC85FzsZGpWllRbiVQAtw4pu2C2g01M9vH338HPY98yx8z/U8HB/FjZmwNb0qJTx18lheesEBbXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0stUJ6n; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766645993; x=1798181993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+WiEymJv/nr2X5pjWCtt6q+S4mNEdgmhNha83diODgc=;
  b=G0stUJ6nttAUB7l22Wl03ySbSlaIIJVOoEL8KKho3iegOF9Zw4ZrNjDw
   Mh7yxqqFjta7P6d8voSqZaaXC5nZ8njD3AWBDX5pfc3H/xnVG+MaraSxE
   CCuvMcKacb9fJxeoR0ueMXeVcrZJY0BGdZfbwHDxtEPGNRaTktIZMmfD/
   wbVrgzaJRDYDEG5sT5S1ku+iYuw3yvc39aTv8DOku6T6quaO167SbxVKc
   9NsqFt3gnFKFaQEvSRAuzpRiJ5OdsSuulcQOV8SLTceqodRqrvKqGTb1r
   /lhqc73eSi4DPicaBWVguQlWZgMwI5HMs4EazEfQzVi6xFND0Fc95Fz13
   Q==;
X-CSE-ConnectionGUID: zvjfVQwvSKi8Hn5PrW3Cxg==
X-CSE-MsgGUID: AIRdY5bAQfCueRsLc4hD6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="68440322"
X-IronPort-AV: E=Sophos;i="6.21,175,1763452800"; 
   d="scan'208";a="68440322"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2025 22:59:52 -0800
X-CSE-ConnectionGUID: RwRzrLXQR3S4e/QAzpKyJw==
X-CSE-MsgGUID: bgk551fhQNa8HKvE2FagTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,175,1763452800"; 
   d="scan'208";a="231228707"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 24 Dec 2025 22:59:47 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYfK5-000000003qx-1WVx;
	Thu, 25 Dec 2025 06:59:45 +0000
Date: Thu, 25 Dec 2025 14:58:57 +0800
From: kernel test robot <lkp@intel.com>
To: Ruidong Tian <tianruidong@linux.alibaba.com>, catalin.marinas@arm.com,
	will@kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com,
	sudeep.holla@arm.com, xueshuai@linux.alibaba.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	lenb@kernel.org, tony.luck@intel.com, bp@alien8.de,
	yazen.ghannam@amd.com, misono.tomohiro@fujitsu.com
Cc: oe-kbuild-all@lists.linux.dev, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v4 14/17] ras: ATL: Unify ATL interface for ARM64 and AMD
Message-ID: <202512251419.gOeKyBqX-lkp@intel.com>
References: <20251222094351.38792-16-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222094351.38792-16-tianruidong@linux.alibaba.com>

Hi Ruidong,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.19-rc2 next-20251219]
[cannot apply to arm64/for-next/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ruidong-Tian/ACPI-AEST-Parse-the-AEST-table/20251222-215248
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20251222094351.38792-16-tianruidong%40linux.alibaba.com
patch subject: [PATCH v4 14/17] ras: ATL: Unify ATL interface for ARM64 and AMD
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20251225/202512251419.gOeKyBqX-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251225/202512251419.gOeKyBqX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512251419.gOeKyBqX-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/ras/amd/fmpm.c: In function 'save_spa':
>> drivers/ras/amd/fmpm.c:336:15: error: implicit declaration of function 'amd_convert_umc_mca_addr_to_sys_addr'; did you mean 'convert_umc_mca_addr_to_sys_addr'? [-Wimplicit-function-declaration]
     336 |         spa = amd_convert_umc_mca_addr_to_sys_addr(&a_err);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               convert_umc_mca_addr_to_sys_addr
--
   drivers/ras/amd/atl/umc.c: In function '_retire_row_mi300':
>> drivers/ras/amd/atl/umc.c:321:24: error: implicit declaration of function 'amd_convert_umc_mca_addr_to_sys_addr'; did you mean 'convert_umc_mca_addr_to_sys_addr'? [-Wimplicit-function-declaration]
     321 |                 addr = amd_convert_umc_mca_addr_to_sys_addr(a_err);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                        convert_umc_mca_addr_to_sys_addr


vim +336 drivers/ras/amd/fmpm.c

6f15e617cc9932 Yazen Ghannam 2024-02-13  298  
838850c50884cd Yazen Ghannam 2024-03-01  299  static void save_spa(struct fru_rec *rec, unsigned int entry,
838850c50884cd Yazen Ghannam 2024-03-01  300  		     u64 addr, u64 id, unsigned int cpu)
838850c50884cd Yazen Ghannam 2024-03-01  301  {
838850c50884cd Yazen Ghannam 2024-03-01  302  	unsigned int i, fru_idx, spa_entry;
838850c50884cd Yazen Ghannam 2024-03-01  303  	struct atl_err a_err;
838850c50884cd Yazen Ghannam 2024-03-01  304  	unsigned long spa;
838850c50884cd Yazen Ghannam 2024-03-01  305  
838850c50884cd Yazen Ghannam 2024-03-01  306  	if (entry >= max_nr_entries) {
838850c50884cd Yazen Ghannam 2024-03-01  307  		pr_warn_once("FRU descriptor entry %d out-of-bounds (max: %d)\n",
838850c50884cd Yazen Ghannam 2024-03-01  308  			     entry, max_nr_entries);
838850c50884cd Yazen Ghannam 2024-03-01  309  		return;
838850c50884cd Yazen Ghannam 2024-03-01  310  	}
838850c50884cd Yazen Ghannam 2024-03-01  311  
838850c50884cd Yazen Ghannam 2024-03-01  312  	/* spa_nr_entries is always multiple of max_nr_entries */
838850c50884cd Yazen Ghannam 2024-03-01  313  	for (i = 0; i < spa_nr_entries; i += max_nr_entries) {
838850c50884cd Yazen Ghannam 2024-03-01  314  		fru_idx = i / max_nr_entries;
838850c50884cd Yazen Ghannam 2024-03-01  315  		if (fru_records[fru_idx] == rec)
838850c50884cd Yazen Ghannam 2024-03-01  316  			break;
838850c50884cd Yazen Ghannam 2024-03-01  317  	}
838850c50884cd Yazen Ghannam 2024-03-01  318  
838850c50884cd Yazen Ghannam 2024-03-01  319  	if (i >= spa_nr_entries) {
838850c50884cd Yazen Ghannam 2024-03-01  320  		pr_warn_once("FRU record %d not found\n", i);
838850c50884cd Yazen Ghannam 2024-03-01  321  		return;
838850c50884cd Yazen Ghannam 2024-03-01  322  	}
838850c50884cd Yazen Ghannam 2024-03-01  323  
838850c50884cd Yazen Ghannam 2024-03-01  324  	spa_entry = i + entry;
838850c50884cd Yazen Ghannam 2024-03-01  325  	if (spa_entry >= spa_nr_entries) {
838850c50884cd Yazen Ghannam 2024-03-01  326  		pr_warn_once("spa_entries[] index out-of-bounds\n");
838850c50884cd Yazen Ghannam 2024-03-01  327  		return;
838850c50884cd Yazen Ghannam 2024-03-01  328  	}
838850c50884cd Yazen Ghannam 2024-03-01  329  
838850c50884cd Yazen Ghannam 2024-03-01  330  	memset(&a_err, 0, sizeof(struct atl_err));
838850c50884cd Yazen Ghannam 2024-03-01  331  
838850c50884cd Yazen Ghannam 2024-03-01  332  	a_err.addr = addr;
838850c50884cd Yazen Ghannam 2024-03-01  333  	a_err.ipid = id;
838850c50884cd Yazen Ghannam 2024-03-01  334  	a_err.cpu  = cpu;
838850c50884cd Yazen Ghannam 2024-03-01  335  
838850c50884cd Yazen Ghannam 2024-03-01 @336  	spa = amd_convert_umc_mca_addr_to_sys_addr(&a_err);
838850c50884cd Yazen Ghannam 2024-03-01  337  	if (IS_ERR_VALUE(spa)) {
838850c50884cd Yazen Ghannam 2024-03-01  338  		pr_debug("Failed to get system address\n");
838850c50884cd Yazen Ghannam 2024-03-01  339  		return;
838850c50884cd Yazen Ghannam 2024-03-01  340  	}
838850c50884cd Yazen Ghannam 2024-03-01  341  
838850c50884cd Yazen Ghannam 2024-03-01  342  	spa_entries[spa_entry] = spa;
838850c50884cd Yazen Ghannam 2024-03-01  343  	pr_debug("fru_idx: %u, entry: %u, spa_entry: %u, spa: 0x%016llx\n",
838850c50884cd Yazen Ghannam 2024-03-01  344  		 fru_idx, entry, spa_entry, spa_entries[spa_entry]);
838850c50884cd Yazen Ghannam 2024-03-01  345  }
838850c50884cd Yazen Ghannam 2024-03-01  346  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

