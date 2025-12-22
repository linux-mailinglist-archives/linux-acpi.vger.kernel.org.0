Return-Path: <linux-acpi+bounces-19792-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA78CD774F
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 00:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6319F300A437
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 23:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE498301708;
	Mon, 22 Dec 2025 23:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SssORAXk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D375F2C08C4;
	Mon, 22 Dec 2025 23:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766446473; cv=none; b=G7DCKRBU4GPJcI6twq1iAQCZqm5jNxmhDO3u7yL/wre5IQhmWOmyGvpQFonuuoxb0Sy6TXma6v5i06ZouHAeFped9GdkdSqeLlW/+FO7zu526FJvkKIY7wkJQZIx1YGlXhxq0fr3sGxVf57TPMglXW+cQzJNBg3KQUeJvKsBFik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766446473; c=relaxed/simple;
	bh=rsVXZf5HCfD/6XyIRrhSxqfkKef54C0oJ3OxPaZqzQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjtmtSFkiOMWeafuYCkS9AFw+6x4MguHVLVzSj/sBmh0SPbiaifRu1SWY7ukc9V9JGv2ERKe9X2yN2gm8ha1+dWYvNATnC7b1DgcFoP3xg5gwtAXK3FFZ365evNijk/Eu+c8JXxe6N04wrHOGE/WYORjgcS7PXa1HuQkffSEtVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SssORAXk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766446472; x=1797982472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rsVXZf5HCfD/6XyIRrhSxqfkKef54C0oJ3OxPaZqzQg=;
  b=SssORAXkl80/6wmAK4aaj/6ITkcZ2+R2sUFWN2M+0Gl21+V05r9FxLwa
   N7klAppGLDsByjl49YVnMDq/LaFByoRl8F+0oudsrYlXX5P4dS6n0Ef12
   UwVg9ugjUWmFMMq5yvzGE0cpeiRp0hABt17tzSdKpb5j/vsNsoeZlwDgF
   GKNdlxyRd0kJMh1da20BN3c/IYn6juffTzx3JQL2BijwnwLzFVGMIvMuB
   NBAYPKDCujJxhmV+tWzhrEo+JXnWm6v/8t8x4KLXxy5beuDAC3HeWjbVs
   3q7z5qtQbDlTM1tXO4yJ+LVxhPJ8aYvJF75oRZ0G956x2Tjd0oa2/8+OL
   g==;
X-CSE-ConnectionGUID: A4FfpLexRQaSWGsOQbh/sA==
X-CSE-MsgGUID: agDvVqf6T9Wlq4R7l72ocw==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="68285410"
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="68285410"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 15:34:31 -0800
X-CSE-ConnectionGUID: 87TMfIpKRPaZoBYu7cvMtA==
X-CSE-MsgGUID: wkAk98NKRvq/e5JI8YBASA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="199945400"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by fmviesa008.fm.intel.com with ESMTP; 22 Dec 2025 15:34:28 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXpQ1-000000005f2-19it;
	Mon, 22 Dec 2025 23:34:25 +0000
Date: Tue, 23 Dec 2025 00:34:06 +0100
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
Message-ID: <202512230007.Vs6IvFVD-lkp@intel.com>
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
[also build test ERROR on rafael-pm/bleeding-edge ras/edac-for-next linus/master v6.19-rc2 next-20251219]
[cannot apply to arm64/for-next/core tip/smp/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ruidong-Tian/ACPI-AEST-Parse-the-AEST-table/20251222-175211
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20251222094351.38792-16-tianruidong%40linux.alibaba.com
patch subject: [PATCH v4 14/17] ras: ATL: Unify ATL interface for ARM64 and AMD
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20251223/202512230007.Vs6IvFVD-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251223/202512230007.Vs6IvFVD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512230007.Vs6IvFVD-lkp@intel.com/

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

