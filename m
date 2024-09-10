Return-Path: <linux-acpi+bounces-8218-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13571973842
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 15:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371831C250BC
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 13:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD4B191F9F;
	Tue, 10 Sep 2024 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fLxD+SZH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F973191F72;
	Tue, 10 Sep 2024 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973604; cv=none; b=kVOumgkpjGIs0MgagCaaIACVZN1wBOGfUz07nrJ8fI7YC00bRQ9Zz5i5bqNayl0s6Nxvf1uj8Jl12+rZk5ncqcc5cqhWBEl5aiJc6Htb95soIsQfha+KQ5etwXJWso/O1sUAeK3XDhKzii8sQwqencLIyw1PiHfFfDnkvIqWOyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973604; c=relaxed/simple;
	bh=Yz/kpha3wBkhE6LIgb99aDoBkB6GQjW3qis7RjJNGvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQ/aSWmI4kbaIeYin0HAUKu55ahOY/4UOtwMhRrTnp73oLAR0WugACJ2DneH7MDtCAA+7bl4m+rrytd7vW+RpU/qRgwDnvy00XUBnNkG9lWCIBZEA8PEml9QSOhHwpD4J/mLxE4BLQ7aHdqnQIgCvnFlr0il1wuolP+1HfZpYSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fLxD+SZH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725973602; x=1757509602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yz/kpha3wBkhE6LIgb99aDoBkB6GQjW3qis7RjJNGvk=;
  b=fLxD+SZHzqPbeQF3kZNw81lHoWhXOSZbM3j6ctVCGpvKKjUq5+wRmPz8
   w6tqvAQ4bfQXN13rMuKKw7v/N14NHBmclh/RCVi8DF425MAYu8sL2Ciu7
   MjaamJwCNgc6+gYkIBHPjHOXOp6MESPt016nPUce8y1YjzTG/xcBY2zqi
   Rs+1lM4PddZceqA3FYSHhXu/C98ebGv+s9cyhLOF5tPOA1qmPCsMhy2R4
   bCBfqD8vfhTy3W2EMmXMsdpfsJxNNufLOY7uHSVe51vXA0kBniThgs7jq
   YWQRhBL1DMBZydWKTdNIhmJlaKQSK2bf7DHeNb8dlyggRAO5CICGMd4F5
   g==;
X-CSE-ConnectionGUID: xbMurTaZQvG3s7Q5jsTCZQ==
X-CSE-MsgGUID: Fkmxy9tsQ8uaQA/WRs+YKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24822637"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="24822637"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 06:06:41 -0700
X-CSE-ConnectionGUID: UBmpZ3GcT4KjmRobpQCIzw==
X-CSE-MsgGUID: fGF6n0NGR/2IbP3iOG/jOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="66820124"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 Sep 2024 06:06:40 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1so0Zp-00026o-0d;
	Tue, 10 Sep 2024 13:06:37 +0000
Date: Tue, 10 Sep 2024 21:06:25 +0800
From: kernel test robot <lkp@intel.com>
To: Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Len Brown <lenb@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Enable ACPI BGRT handling
Message-ID: <202409102056.DNqh6zzA-lkp@intel.com>
References: <20240909015514.597253-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909015514.597253-1-maobibo@loongson.cn>

Hi Bibo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b31c4492884252a8360f312a0ac2049349ddf603]

url:    https://github.com/intel-lab-lkp/linux/commits/Bibo-Mao/LoongArch-Enable-ACPI-BGRT-handling/20240909-095705
base:   b31c4492884252a8360f312a0ac2049349ddf603
patch link:    https://lore.kernel.org/r/20240909015514.597253-1-maobibo%40loongson.cn
patch subject: [PATCH] LoongArch: Enable ACPI BGRT handling
config: loongarch-randconfig-r133-20240910 (https://download.01.org/0day-ci/archive/20240910/202409102056.DNqh6zzA-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240910/202409102056.DNqh6zzA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409102056.DNqh6zzA-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/efi/efi-bgrt.c:69:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *image @@     got void [noderef] __iomem * @@
   drivers/firmware/efi/efi-bgrt.c:69:15: sparse:     expected void *image
   drivers/firmware/efi/efi-bgrt.c:69:15: sparse:     got void [noderef] __iomem *
>> drivers/firmware/efi/efi-bgrt.c:76:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *image @@
   drivers/firmware/efi/efi-bgrt.c:76:24: sparse:     expected void [noderef] __iomem *addr
   drivers/firmware/efi/efi-bgrt.c:76:24: sparse:     got void *image

vim +69 drivers/firmware/efi/efi-bgrt.c

2223af38903242 arch/x86/platform/efi/efi-bgrt.c Josh Triplett 2012-09-28  26  
7b0a911478c74c arch/x86/platform/efi/efi-bgrt.c Dave Young    2017-01-31  27  void __init efi_bgrt_init(struct acpi_table_header *table)
2223af38903242 arch/x86/platform/efi/efi-bgrt.c Josh Triplett 2012-09-28  28  {
50a0cb565246f2 arch/x86/platform/efi/efi-bgrt.c Sai Praneeth  2015-12-09  29  	void *image;
2223af38903242 arch/x86/platform/efi/efi-bgrt.c Josh Triplett 2012-09-28  30  	struct bmp_header bmp_header;
7b0a911478c74c arch/x86/platform/efi/efi-bgrt.c Dave Young    2017-01-31  31  	struct acpi_table_bgrt *bgrt = &bgrt_tab;
2223af38903242 arch/x86/platform/efi/efi-bgrt.c Josh Triplett 2012-09-28  32  
2223af38903242 arch/x86/platform/efi/efi-bgrt.c Josh Triplett 2012-09-28  33  	if (acpi_disabled)
2223af38903242 arch/x86/platform/efi/efi-bgrt.c Josh Triplett 2012-09-28  34  		return;
2223af38903242 arch/x86/platform/efi/efi-bgrt.c Josh Triplett 2012-09-28  35  
792ef14df5c585 drivers/firmware/efi/efi-bgrt.c  Dave Young    2017-06-09  36  	if (!efi_enabled(EFI_MEMMAP))
7425826f4f7ac6 drivers/firmware/efi/efi-bgrt.c  Dave Young    2017-05-26  37  		return;
7425826f4f7ac6 drivers/firmware/efi/efi-bgrt.c  Dave Young    2017-05-26  38  
7b0a911478c74c arch/x86/platform/efi/efi-bgrt.c Dave Young    2017-01-31  39  	if (table->length < sizeof(bgrt_tab)) {
7f9b474c927130 arch/x86/platform/efi/efi-bgrt.c Josh Boyer    2016-05-03  40  		pr_notice("Ignoring BGRT: invalid length %u (expected %zu)\n",
7b0a911478c74c arch/x86/platform/efi/efi-bgrt.c Dave Young    2017-01-31  41  		       table->length, sizeof(bgrt_tab));
5d6d578c170bb2 arch/x86/platform/efi/efi-bgrt.c Jan Beulich   2012-11-07  42  		return;
1282278ee00b41 arch/x86/platform/efi/efi-bgrt.c Josh Triplett 2014-07-30  43  	}
7b0a911478c74c arch/x86/platform/efi/efi-bgrt.c Dave Young    2017-01-31  44  	*bgrt = *(struct acpi_table_bgrt *)table;
55087c5713dcf1 drivers/firmware/efi/efi-bgrt.c  Hans de Goede 2020-01-31  45  	/*
55087c5713dcf1 drivers/firmware/efi/efi-bgrt.c  Hans de Goede 2020-01-31  46  	 * Only version 1 is defined but some older laptops (seen on Lenovo
55087c5713dcf1 drivers/firmware/efi/efi-bgrt.c  Hans de Goede 2020-01-31  47  	 * Ivy Bridge models) have a correct version 1 BGRT table with the
55087c5713dcf1 drivers/firmware/efi/efi-bgrt.c  Hans de Goede 2020-01-31  48  	 * version set to 0, so we accept version 0 and 1.
55087c5713dcf1 drivers/firmware/efi/efi-bgrt.c  Hans de Goede 2020-01-31  49  	 */
55087c5713dcf1 drivers/firmware/efi/efi-bgrt.c  Hans de Goede 2020-01-31  50  	if (bgrt->version > 1) {
7f9b474c927130 arch/x86/platform/efi/efi-bgrt.c Josh Boyer    2016-05-03  51  		pr_notice("Ignoring BGRT: invalid version %u (expected 1)\n",
7b0a911478c74c arch/x86/platform/efi/efi-bgrt.c Dave Young    2017-01-31  52  		       bgrt->version);
7b0a911478c74c arch/x86/platform/efi/efi-bgrt.c Dave Young    2017-01-31  53  		goto out;
1282278ee00b41 arch/x86/platform/efi/efi-bgrt.c Josh Triplett 2014-07-30  54  	}
7b0a911478c74c arch/x86/platform/efi/efi-bgrt.c Dave Young    2017-01-31  55  	if (bgrt->image_type != 0) {
7f9b474c927130 arch/x86/platform/efi/efi-bgrt.c Josh Boyer    2016-05-03  56  		pr_notice("Ignoring BGRT: invalid image type %u (expected 0)\n",
7b0a911478c74c arch/x86/platform/efi/efi-bgrt.c Dave Young    2017-01-31  57  		       bgrt->image_type);
7b0a911478c74c arch/x86/platform/efi/efi-bgrt.c Dave Young    2017-01-31  58  		goto out;
1282278ee00b41 arch/x86/platform/efi/efi-bgrt.c Josh Triplett 2014-07-30  59  	}
7b0a911478c74c arch/x86/platform/efi/efi-bgrt.c Dave Young    2017-01-31  60  	if (!bgrt->image_address) {
7f9b474c927130 arch/x86/platform/efi/efi-bgrt.c Josh Boyer    2016-05-03  61  		pr_notice("Ignoring BGRT: null image address\n");
7b0a911478c74c arch/x86/platform/efi/efi-bgrt.c Dave Young    2017-01-31  62  		goto out;
1282278ee00b41 arch/x86/platform/efi/efi-bgrt.c Josh Triplett 2014-07-30  63  	}
2223af38903242 arch/x86/platform/efi/efi-bgrt.c Josh Triplett 2012-09-28  64  
6de47a5e371f75 drivers/firmware/efi/efi-bgrt.c  Jan Beulich   2017-08-25  65  	if (efi_mem_type(bgrt->image_address) != EFI_BOOT_SERVICES_DATA) {
792ef14df5c585 drivers/firmware/efi/efi-bgrt.c  Dave Young    2017-06-09  66  		pr_notice("Ignoring BGRT: invalid image address\n");
792ef14df5c585 drivers/firmware/efi/efi-bgrt.c  Dave Young    2017-06-09  67  		goto out;
792ef14df5c585 drivers/firmware/efi/efi-bgrt.c  Dave Young    2017-06-09  68  	}
7b0a911478c74c arch/x86/platform/efi/efi-bgrt.c Dave Young    2017-01-31 @69  	image = early_memremap(bgrt->image_address, sizeof(bmp_header));
1282278ee00b41 arch/x86/platform/efi/efi-bgrt.c Josh Triplett 2014-07-30  70  	if (!image) {
7f9b474c927130 arch/x86/platform/efi/efi-bgrt.c Josh Boyer    2016-05-03  71  		pr_notice("Ignoring BGRT: failed to map image header memory\n");
7b0a911478c74c arch/x86/platform/efi/efi-bgrt.c Dave Young    2017-01-31  72  		goto out;
2223af38903242 arch/x86/platform/efi/efi-bgrt.c Josh Triplett 2012-09-28  73  	}
2223af38903242 arch/x86/platform/efi/efi-bgrt.c Josh Triplett 2012-09-28  74  
50a0cb565246f2 arch/x86/platform/efi/efi-bgrt.c Sai Praneeth  2015-12-09  75  	memcpy(&bmp_header, image, sizeof(bmp_header));
7b0a911478c74c arch/x86/platform/efi/efi-bgrt.c Dave Young    2017-01-31 @76  	early_memunmap(image, sizeof(bmp_header));

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

