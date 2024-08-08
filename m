Return-Path: <linux-acpi+bounces-7450-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCE094C775
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 01:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778871F22FE7
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2024 23:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF8B15ECD2;
	Thu,  8 Aug 2024 23:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yauq01mz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E6F2F23
	for <linux-acpi@vger.kernel.org>; Thu,  8 Aug 2024 23:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723161049; cv=none; b=Y7+dUkgav9Xwob/GF8Mfpm1chVLXHmItTPFqPzm7vktdTLQx2iIgQHmVslDbLuqOFSjcc83ROrW7gm5AjHqE/8AU0js/v+TM8vFV/PKIz+91Zn0ZUOGi1nKEwYkdhbe0EzFcTYugMFLgLJ7Dre2qMmRFjBjwAqMVw7WhMLwvltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723161049; c=relaxed/simple;
	bh=msStPv78tQHsgiFR+ibTiL1MtKZ9jSJTczTEuZULeAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mm23eW1o+o/Yse/jqZx199PluVfpwilESM/goElMifzB5i/fYF4GIvQdEJKHU4M1nE8Xeu3Va1B2UIa93mBCBBex6MvaM+O66df7Er7OR4+R4pOLBnCtYeLnuOxwkQwWY4ApkRp8I9QJKIO2/R4uBqol9fJ+9l3vARRpmmrBgnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yauq01mz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723161047; x=1754697047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=msStPv78tQHsgiFR+ibTiL1MtKZ9jSJTczTEuZULeAI=;
  b=Yauq01mz3KMvcE0nkpwBYV3qCgPH6JKs9GYemo9WwZuakbMynhJinvpH
   njedIKoXsncCciOBfiU/DMqiur9jCg0VfZouYk5l71ca2f5TndcxqMyKC
   kfC/K4aVWkMeJltxNztkJb9HHdrGjD5wzI54LCIKQwEjOfxbej/sQg1mh
   xFj9BUGvz5apIYRLr4DV0LppyVJFi7orrZbwhrorpdZUdAoh3xqB0fRa8
   ULVgiGpJ6h38+tV/8LmX/wOwxrEvotbUQo/NxlIlD3HYRKauexnx3FKRs
   eWSfct2rB8wmMwXIvy0q7sFxHuvDKEUDuh6macyrvT+N5GGa/3os6M20G
   A==;
X-CSE-ConnectionGUID: xUMZbY7sRuCrigUmCOoL+Q==
X-CSE-MsgGUID: CUsurqj0Q6+PrQqItPeVuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32711970"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="32711970"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 16:50:20 -0700
X-CSE-ConnectionGUID: VAU9Z6MPSQqj9ETSNKLMjg==
X-CSE-MsgGUID: Ecc3zQWtTPGhvCQPzzVwWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="61778876"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 08 Aug 2024 16:50:14 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scCtX-0006d4-0r;
	Thu, 08 Aug 2024 23:50:11 +0000
Date: Fri, 9 Aug 2024 07:49:39 +0800
From: kernel test robot <lkp@intel.com>
To: Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 3/3] ARM64: ACPI: Move the NUMA code to
 drivers/acpi/arm64/
Message-ID: <202408090735.Oa78ciK8-lkp@intel.com>
References: <20240808131522.1032431-4-guohanjun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808131522.1032431-4-guohanjun@huawei.com>

Hi Hanjun,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v6.11-rc2 next-20240808]
[cannot apply to arm-perf/for-next/perf]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hanjun-Guo/ARM64-ACPI-Remove-the-leftover-acpi_init_cpus/20240808-212154
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20240808131522.1032431-4-guohanjun%40huawei.com
patch subject: [PATCH 3/3] ARM64: ACPI: Move the NUMA code to drivers/acpi/arm64/
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240809/202408090735.Oa78ciK8-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 4527fba9ad6bc682eceda603150bfaec65ec6916)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240809/202408090735.Oa78ciK8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408090735.Oa78ciK8-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/nvme/host/pci.c:7:
>> include/linux/acpi.h:260:19: error: redefinition of 'acpi_numa_get_nid'
     260 | static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
         |                   ^
   arch/riscv/include/asm/acpi.h:68:19: note: previous definition is here
      68 | static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
         |                   ^
   In file included from drivers/nvme/host/pci.c:9:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/riscv/include/asm/cacheflush.h:9:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   drivers/nvme/host/pci.c:2982:41: warning: shift count >= width of type [-Wshift-count-overflow]
    2982 |                 dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
         |                                                       ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   2 warnings and 1 error generated.


vim +/acpi_numa_get_nid +260 include/linux/acpi.h

   254	
   255	#ifdef CONFIG_ARM64
   256	int acpi_numa_get_nid(unsigned int cpu);
   257	void acpi_map_cpus_to_nodes(void);
   258	void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
   259	#else
 > 260	static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
   261	static inline void acpi_map_cpus_to_nodes(void) { }
   262	static inline void
   263	acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
   264	#endif
   265	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

