Return-Path: <linux-acpi+bounces-12961-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C366EA8501E
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 01:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1EC177A9E
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 23:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A463213230;
	Thu, 10 Apr 2025 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwjTAC9s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319F5211713;
	Thu, 10 Apr 2025 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744327792; cv=none; b=O4MULvkZBtJ+Q1OSgbvQzSWSBhPqVIcdPnz65asO2tSWjx4kMquEAVjBaqV9WtxxmzCTRVNnuHae/ufFTDmj+lGoPcVmWomMnoCINmEnESCb131Qa7F/Wj1jX4ocVhS4Kk2EnNoaiH19/0PWbiFA6iXn8ddZmmjz+fD73r4AHD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744327792; c=relaxed/simple;
	bh=8jOpSPwprOxkM/J3OPiEEMfzk9Ma6DGiirJIc7Jwjko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBu9OM3ZZhmgoNEP85aH4cREamm1IATsmYPpw44PtHWH9iWiK+VmILLFIvqYF1tvrXYYiYJulu1KJU0MqOs0kEOn+uy3e2vRpjgdiTM2Uxfzt/ZY9XvuJI4xlvnmICUz7ahq75pfsBiCaxuPCGx66GZyUTkSyManZHJAIVOAAB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwjTAC9s; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744327789; x=1775863789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8jOpSPwprOxkM/J3OPiEEMfzk9Ma6DGiirJIc7Jwjko=;
  b=MwjTAC9sYMKnSL0DEaMTEwezMa/j42XoClIxK8QPUPnmaEiA7exDT6mG
   3oWjjYZ8z4kSO0ra52lMUjmYBjN8dlmo+vwsMU1KhcdFTsV63tjCElcey
   f5/Y7sTbRycCnyT6Q+yZeN9Ic6jDoQXSErE8jjyPPQxn575DLi+oro4ji
   aOQoLjqnXDK5MpgqVSowjJL7jsnA7wE5SAuGjvStqzCxaIgpeVT5A/2fr
   a4XW0uk81tRu8+GeH6QYAIr/ZIhwp3cwp8rRYAgc2FwDvXBoQiU0YWZ/S
   nx0MgDrkBmNLlyRMrJ6iT81zP7IHASxOqCr8S5Oo5H/TgXOw/rGOlfRbx
   A==;
X-CSE-ConnectionGUID: XaHqcMXKToCG9XZvewmVow==
X-CSE-MsgGUID: KxQTWAVGS9azDo/6/w1Zaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56514844"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="56514844"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 16:29:48 -0700
X-CSE-ConnectionGUID: SAiMB3F/Q26IBsQ5XFPr9g==
X-CSE-MsgGUID: Lsse+SNpR+WTRSUoqqDiRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="160005628"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Apr 2025 16:29:44 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u31L4-000AdH-0E;
	Thu, 10 Apr 2025 23:29:42 +0000
Date: Fri, 11 Apr 2025 07:29:13 +0800
From: kernel test robot <lkp@intel.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>, chenhuacai@kernel.org,
	kernel@xen0n.name, jiaxun.yang@flygoat.com, rppt@kernel.org,
	akpm@linux-foundation.org, david@redhat.com,
	Jonathan.Cameron@huawei.com, dave.hansen@linux.intel.com,
	dan.j.williams@intel.com, alison.schofield@intel.com
Cc: oe-kbuild-all@lists.linux.dev, chenbaozi@phytium.com.cn,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: Re: [PATCH 1/1] LoongArch: Introduce the numa_memblks conversion
Message-ID: <202504110627.AIvtEzM7-lkp@intel.com>
References: <20250409070250.3225839-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409070250.3225839-1-wangyuquan1236@phytium.com.cn>

Hi Yuquan,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.15-rc1 next-20250410]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuquan-Wang/LoongArch-Introduce-the-numa_memblks-conversion/20250409-150524
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250409070250.3225839-1-wangyuquan1236%40phytium.com.cn
patch subject: [PATCH 1/1] LoongArch: Introduce the numa_memblks conversion
config: loongarch-randconfig-002-20250410 (https://download.01.org/0day-ci/archive/20250411/202504110627.AIvtEzM7-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250411/202504110627.AIvtEzM7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504110627.AIvtEzM7-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> mm/numa_memblks.c:125:5: warning: no previous prototype for '__node_distance' [-Wmissing-prototypes]
     125 | int __node_distance(int from, int to)
         |     ^~~~~~~~~~~~~~~
--
   loongarch64-linux-ld: mm/numa_memblks.o: in function `numa_set_distance':
>> mm/numa_memblks.c:104: multiple definition of `numa_set_distance'; arch/loongarch/kernel/acpi.o:arch/loongarch/kernel/acpi.c:253: first defined here
>> loongarch64-linux-ld: mm/numa_memblks.o:mm/numa_memblks.c:13: multiple definition of `numa_nodes_parsed'; arch/loongarch/kernel/numa.o:arch/loongarch/kernel/numa.c:47: first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

