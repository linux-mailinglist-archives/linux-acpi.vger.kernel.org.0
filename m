Return-Path: <linux-acpi+bounces-8070-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AED8967E79
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 06:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382471C21864
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 04:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4516C14B970;
	Mon,  2 Sep 2024 04:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDxMc7pP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FCE7DA79;
	Mon,  2 Sep 2024 04:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725251203; cv=none; b=HPLEXMj5MExtE+5wROhK1gqxFS/bvU5DDRSG9GTcFma38nXHae1KYzsQom5Rsd7FwtYHc8tktq8xJo4f3+JWKS8DksSRhzDseMWqnySPlNGreXTDF5DvX6VtpzgRCEeRdyfVGl+WYEFLZTZ/qJu4gO0/cagaAg8INale+7o9ox0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725251203; c=relaxed/simple;
	bh=S5qhRygrcfXvm7kJzwuP8Cmx/Ac9/Pt/rY0TldkIg7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgPSS+c/TyMqz0Oz4WeKZYty4GFl0PU5/e3wSmMhLR8yatZFnJiR5MFG57dHH/84AABPEUO89IpCjvyDrnnSSCNhxHCJK4foVBnwJmWOMNPc5eHCL8WyGLWug6V4S3L2VrbE/mmB5pbi/upQA4mxVB+YN/2bwkL5kLF4xCeidB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDxMc7pP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725251201; x=1756787201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S5qhRygrcfXvm7kJzwuP8Cmx/Ac9/Pt/rY0TldkIg7A=;
  b=dDxMc7pPokPtoqM0EDs2rOGefn8WSzChu1uYRuyz185oxRpSnmyzs+j8
   KLsh240YPJAWKgiak8ZkiAW7GCjEv4GHlSA2mAPLktTt99ayQ6TVsHtin
   vtvfpNF45mipsGlYIichfKsl15ujWy0yAOhKya1jXZekNpTBMLaQP2ByM
   58c6aQBwODPsVQmBto4ipTSH5QkKFd/+ASw4UgI+AJEG4+GCJ2qSxufDz
   slct6SLD/SuuKtay9BgOrDBfk1GZvqEBGcG0F0RNk9jBC+YG653XGhdMU
   7nYI/U7SvFL87cowm1E+fKqQUdFcRCxQFAXl+qfwJHNJvAQ+mo4x/h8qN
   w==;
X-CSE-ConnectionGUID: xFFftpFwSViGl6+7cIMLCw==
X-CSE-MsgGUID: CnDdGiGzRzCO07hJF54gUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="46327567"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="46327567"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 21:26:41 -0700
X-CSE-ConnectionGUID: tlFPs6IPQlWRA66z8qXHOg==
X-CSE-MsgGUID: E6Dh4lY7SJCe09jHoHjkuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64175427"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 01 Sep 2024 21:26:38 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skyeC-00057C-23;
	Mon, 02 Sep 2024 04:26:36 +0000
Date: Mon, 2 Sep 2024 12:26:17 +0800
From: kernel test robot <lkp@intel.com>
To: KobaK <kobak@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	James Morse <james.morse@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V2] acpi/prmt: find block with specific type
Message-ID: <202409021235.QLbKiKxF-lkp@intel.com>
References: <20240901162255.1302358-1-kobak@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901162255.1302358-1-kobak@nvidia.com>

Hi KobaK,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.11-rc6 next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/KobaK/acpi-prmt-find-block-with-specific-type/20240902-002354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240901162255.1302358-1-kobak%40nvidia.com
patch subject: [PATCH V2] acpi/prmt: find block with specific type
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240902/202409021235.QLbKiKxF-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240902/202409021235.QLbKiKxF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409021235.QLbKiKxF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/prmt.c:88:66: warning: format specifies type 'unsigned long' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
      88 |         pr_warn("PRM: Failed to find a VA block for pa: %lx type %u\n", pa, type);
         |                                                         ~~~             ^~
         |                                                         %llx
   include/linux/printk.h:518:37: note: expanded from macro 'pr_warn'
     518 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                                    ~~~     ^~~~~~~~~~~
   include/linux/printk.h:465:60: note: expanded from macro 'printk'
     465 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:437:19: note: expanded from macro 'printk_index_wrap'
     437 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +88 drivers/acpi/prmt.c

    74	
    75	static u64 efi_pa_va_lookup(u64 pa, u32 type)
    76	{
    77		efi_memory_desc_t *md;
    78		u64 pa_offset = pa & ~PAGE_MASK;
    79		u64 page = pa & PAGE_MASK;
    80	
    81		for_each_efi_memory_desc(md) {
    82			if ((md->type == type) &&
    83				(md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)) {
    84				return pa_offset + md->virt_addr + page - md->phys_addr;
    85			}
    86		}
    87	
  > 88		pr_warn("PRM: Failed to find a VA block for pa: %lx type %u\n", pa, type);
    89	
    90		return 0;
    91	}
    92	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

