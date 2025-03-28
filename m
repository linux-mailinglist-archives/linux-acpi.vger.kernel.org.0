Return-Path: <linux-acpi+bounces-12526-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07700A74A75
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 14:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D41616D227
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 13:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F27670814;
	Fri, 28 Mar 2025 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mqx4g0fi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A8D3C0C;
	Fri, 28 Mar 2025 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743167754; cv=none; b=AjMQq9Kgww1E9uTpkHC9hO10UKuaC3jRjLY8j4K/mDb9lSxzthi12NzyEnHIiBQfz9aS/qewd6ic78B+jTDsqumFjisXzMYrmU1pP2MKxkr52if46VlpQGy3LqWEXRO914rMJ7y8FTIUWEGL5VrJmEkJlBGEmW/yu1OnngYU180=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743167754; c=relaxed/simple;
	bh=QwSIXy+3yg65uEoLr+hIy5mMBOunDFf0avciADMFhc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTsoDupGXUxKiD3wq3ae2KU1y69nkRc+i6z1vJRy5DcTVOQ+ba+ffQ3ayjB/qDrWQWseNoAXCMxv7nZ4vHer+AFC+d1EueTIxYP/94tZfm50zpM9kCX+dN0mBS8HKJZfJ+cjCa21m6EN2ns+6QohA0Tn5UlWOMJl//4ERvkUiqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mqx4g0fi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743167752; x=1774703752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QwSIXy+3yg65uEoLr+hIy5mMBOunDFf0avciADMFhc0=;
  b=Mqx4g0fi35vwEMQtaE6axkv8tCvfKKu1/Oqrsu0sn+5YidOQjGQj7w++
   9k0v2yuQSovZbraT+Bme8ppbkLUvLd6eKeqxosZYmykhPBsuqoX0HQGXj
   3Vnw5QWCEtXOMvFH8cRO/We1Q1b/Y5MUyUnCxu1cuxIHSBFtJAMdN3K7z
   jeMg8cAKDnPLula+0PR9rGyPqolijbrGIJKzjqg2uJ6vN3DQFhtIDewTz
   ayF2rPpHEzzanDbkH+FfqxJth/bH7GlxCBoRT89NzQuhSxnVNfcEiVeEs
   rXzw14fbnsZ3ra05Pg83+yPtnTTbKGJPqZZkLCEQ8toeqUHz6MECGDUvQ
   g==;
X-CSE-ConnectionGUID: JUikcurzREawvopulM08nA==
X-CSE-MsgGUID: hK+RRb10SlanToErZnioTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="44657835"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; 
   d="scan'208";a="44657835"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 06:15:51 -0700
X-CSE-ConnectionGUID: EwJ9838WTrSb5sfy554dUg==
X-CSE-MsgGUID: g0gX6VhxRGS1RHFNcamB7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; 
   d="scan'208";a="129583228"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 28 Mar 2025 06:15:46 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ty9Ym-0007SU-10;
	Fri, 28 Mar 2025 13:15:44 +0000
Date: Fri, 28 Mar 2025 21:15:06 +0800
From: kernel test robot <lkp@intel.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	rppt@kernel.org, rafael@kernel.org, lenb@kernel.org,
	akpm@linux-foundation.org, alison.schofield@intel.com,
	rrichter@amd.com, bfaccini@nvidia.com, haibo1.xu@intel.com,
	david@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	chenbaozi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: Re: [PATCH v2] mm: numa_memblks: introduce numa_add_reserved_memblk
Message-ID: <202503282026.QNaOAK79-lkp@intel.com>
References: <20250328092132.2695299-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328092132.2695299-1-wangyuquan1236@phytium.com.cn>

Hi Yuquan,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuquan-Wang/mm-numa_memblks-introduce-numa_add_reserved_memblk/20250328-172428
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250328092132.2695299-1-wangyuquan1236%40phytium.com.cn
patch subject: [PATCH v2] mm: numa_memblks: introduce numa_add_reserved_memblk
config: loongarch-randconfig-002-20250328 (https://download.01.org/0day-ci/archive/20250328/202503282026.QNaOAK79-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250328/202503282026.QNaOAK79-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503282026.QNaOAK79-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from drivers/acpi/numa/srat.c:10:
   drivers/acpi/numa/srat.c: In function 'acpi_parse_cfmws':
>> drivers/acpi/numa/srat.c:461:13: error: implicit declaration of function 'numa_add_reserved_memblk' [-Wimplicit-function-declaration]
     461 |         if (numa_add_reserved_memblk(node, start, end) < 0) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/acpi/numa/srat.c:461:9: note: in expansion of macro 'if'
     461 |         if (numa_add_reserved_memblk(node, start, end) < 0) {
         |         ^~


vim +/numa_add_reserved_memblk +461 drivers/acpi/numa/srat.c

   431	
   432	static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
   433					   void *arg, const unsigned long table_end)
   434	{
   435		struct acpi_cedt_cfmws *cfmws;
   436		int *fake_pxm = arg;
   437		u64 start, end;
   438		int node;
   439	
   440		cfmws = (struct acpi_cedt_cfmws *)header;
   441		start = cfmws->base_hpa;
   442		end = cfmws->base_hpa + cfmws->window_size;
   443	
   444		/*
   445		 * The SRAT may have already described NUMA details for all,
   446		 * or a portion of, this CFMWS HPA range. Extend the memblks
   447		 * found for any portion of the window to cover the entire
   448		 * window.
   449		 */
   450		if (!numa_fill_memblks(start, end))
   451			return 0;
   452	
   453		/* No SRAT description. Create a new node. */
   454		node = acpi_map_pxm_to_node(*fake_pxm);
   455	
   456		if (node == NUMA_NO_NODE) {
   457			pr_err("ACPI NUMA: Too many proximity domains while processing CFMWS.\n");
   458			return -EINVAL;
   459		}
   460	
 > 461		if (numa_add_reserved_memblk(node, start, end) < 0) {
   462			/* CXL driver must handle the NUMA_NO_NODE case */
   463			pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
   464				node, start, end);
   465		}
   466		node_set(node, numa_nodes_parsed);
   467	
   468		/* Set the next available fake_pxm value */
   469		(*fake_pxm)++;
   470		return 0;
   471	}
   472	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

