Return-Path: <linux-acpi+bounces-8198-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B30970003
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Sep 2024 06:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67B61C22256
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Sep 2024 04:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E7D42AAB;
	Sat,  7 Sep 2024 04:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGI2OXRw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394EC3A1DA;
	Sat,  7 Sep 2024 04:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725684200; cv=none; b=kHixSoN2aqDpNWo0YEQs2X0rke0Exz7ilgFrQ7MRjkd9mr+2vNt2xtbgHDg7tLcISmlpZMssr9uqsaG2EbWPWVb9vq7G8+UC6ro4g4+8dcrWkoZgynqltZEkuBvc1t8c4iYuiQtYxVWju3Acd+vqb8x7nuWmWjlttdgjBWFeV4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725684200; c=relaxed/simple;
	bh=fSEXct1GgQ9TOYumem+6pN9Cr1YQiae/V1ufRG6MUww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+lehL975aK4Qatx/r7pXevuhNwqoZguBP+z5DlSjkUwaKtRrnr8p1fhSvlwFE+3sIsOFZBfC0D7r8q7+DhUz44YRa8/OkWM/bbroj+O5dbi7b4B3ER4ORhmjes4ybvDxB8V0hjhgimdaFF0x8HGVRLO3GVct54ufRhtd6v6VH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGI2OXRw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725684198; x=1757220198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fSEXct1GgQ9TOYumem+6pN9Cr1YQiae/V1ufRG6MUww=;
  b=kGI2OXRwl1XWZTIqjgjRhk+wtqbnMVBWL0biNRoixHKzpQgMT/oV/EYQ
   kDQMXgTWyyUGXuuL1V/N8tKE0W2srMuGFmHYuGW+YZlxRwk4fQeOKNcBt
   bGJv4GYVQBhmclgQH9V4ahTTRkVusVo9OuG0BByT0LxqE3RKcAxvIxPYo
   uSEXP7JMVqM4pNeLiGvhVYidD6Eo+rU1RNaDCYC5FXCugNPu/KQY3yHXX
   AUg1ltZEczXzi3GGyVeHDlHE8tTtkdzcRXvjZtc6GIjiDgjBsRqlW3Q0V
   JLHWZXD/Zezdb9dt+CHxocBeMk1kgsufLhcq5S38Tzrf03U2NaPUs7rGO
   Q==;
X-CSE-ConnectionGUID: CHZobIawTeq0RGidf1cYKQ==
X-CSE-MsgGUID: X8eJbfuHSZyjRxY3+nc1bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="23955069"
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="23955069"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 21:43:17 -0700
X-CSE-ConnectionGUID: YZcGfQ8sTUef9E57zeVnPg==
X-CSE-MsgGUID: TAyDOvwdTrSJnrX/DeGfCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="71106913"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 06 Sep 2024 21:43:14 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smnI0-000C7d-23;
	Sat, 07 Sep 2024 04:43:12 +0000
Date: Sat, 7 Sep 2024 12:42:15 +0800
From: kernel test robot <lkp@intel.com>
To: KobaK <kobak@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	James Morse <james.morse@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V3] acpi/prmt: find block with specific type
Message-ID: <202409071245.bkGWWtfQ-lkp@intel.com>
References: <20240905124950.512973-1-kobak@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905124950.512973-1-kobak@nvidia.com>

Hi KobaK,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.11-rc6 next-20240906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/KobaK/acpi-prmt-find-block-with-specific-type/20240905-205316
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240905124950.512973-1-kobak%40nvidia.com
patch subject: [PATCH V3] acpi/prmt: find block with specific type
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240907/202409071245.bkGWWtfQ-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409071245.bkGWWtfQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409071245.bkGWWtfQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/prmt.c:163:5: warning: format specifies type 'int' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
     162 |                                 "Idx: %d, Parts of handler(GUID: %pUB) are missed, handler_addr %llx, data_addr %llx, param_addr %llx",
         |                                       ~~
         |                                       %llu
     163 |                                 cur_handler, th->handler_addr,
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:518:37: note: expanded from macro 'pr_warn'
     518 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                                    ~~~     ^~~~~~~~~~~
   include/linux/printk.h:465:60: note: expanded from macro 'printk'
     465 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:437:19: note: expanded from macro 'printk_index_wrap'
     437 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
>> drivers/acpi/prmt.c:162:105: warning: more '%' conversions than data arguments [-Wformat-insufficient-args]
     162 |                                 "Idx: %d, Parts of handler(GUID: %pUB) are missed, handler_addr %llx, data_addr %llx, param_addr %llx",
         |                                                                                                                                  ~~~^
   include/linux/printk.h:518:29: note: expanded from macro 'pr_warn'
     518 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                                    ^~~
   include/linux/printk.h:355:21: note: expanded from macro 'pr_fmt'
     355 | #define pr_fmt(fmt) fmt
         |                     ^~~
   include/linux/printk.h:465:53: note: expanded from macro 'printk'
     465 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ^~~
   include/linux/printk.h:437:11: note: expanded from macro 'printk_index_wrap'
     437 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   2 warnings generated.


vim +163 drivers/acpi/prmt.c

    93	
    94	static int __init
    95	acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
    96	{
    97		struct acpi_prmt_module_info *module_info;
    98		struct acpi_prmt_handler_info *handler_info;
    99		struct prm_handler_info *th;
   100		struct prm_module_info *tm;
   101		u64 *mmio_count;
   102		u64 cur_handler = 0;
   103		u32 module_info_size = 0;
   104		u64 mmio_range_size = 0;
   105		void *temp_mmio;
   106	
   107		module_info = (struct acpi_prmt_module_info *) header;
   108		module_info_size = struct_size(tm, handlers, module_info->handler_info_count);
   109		tm = kmalloc(module_info_size, GFP_KERNEL);
   110		if (!tm)
   111			goto parse_prmt_out1;
   112	
   113		guid_copy(&tm->guid, (guid_t *) module_info->module_guid);
   114		tm->major_rev = module_info->major_rev;
   115		tm->minor_rev = module_info->minor_rev;
   116		tm->handler_count = module_info->handler_info_count;
   117		tm->updatable = true;
   118	
   119		if (module_info->mmio_list_pointer) {
   120			/*
   121			 * Each module is associated with a list of addr
   122			 * ranges that it can use during the service
   123			 */
   124			mmio_count = (u64 *) memremap(module_info->mmio_list_pointer, 8, MEMREMAP_WB);
   125			if (!mmio_count)
   126				goto parse_prmt_out2;
   127	
   128			mmio_range_size = struct_size(tm->mmio_info, addr_ranges, *mmio_count);
   129			tm->mmio_info = kmalloc(mmio_range_size, GFP_KERNEL);
   130			if (!tm->mmio_info)
   131				goto parse_prmt_out3;
   132	
   133			temp_mmio = memremap(module_info->mmio_list_pointer, mmio_range_size, MEMREMAP_WB);
   134			if (!temp_mmio)
   135				goto parse_prmt_out4;
   136			memmove(tm->mmio_info, temp_mmio, mmio_range_size);
   137		} else {
   138			tm->mmio_info = kmalloc(sizeof(*tm->mmio_info), GFP_KERNEL);
   139			if (!tm->mmio_info)
   140				goto parse_prmt_out2;
   141	
   142			tm->mmio_info->mmio_count = 0;
   143		}
   144	
   145		INIT_LIST_HEAD(&tm->module_list);
   146		list_add(&tm->module_list, &prm_module_list);
   147	
   148		handler_info = get_first_handler(module_info);
   149		do {
   150			th = &tm->handlers[cur_handler];
   151	
   152			guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
   153			th->handler_addr =
   154				(void *)efi_pa_va_lookup(handler_info->handler_address, EFI_RUNTIME_SERVICES_CODE);
   155			th->static_data_buffer_addr =
   156				efi_pa_va_lookup(handler_info->static_data_buffer_address, EFI_RUNTIME_SERVICES_DATA);
   157			th->acpi_param_buffer_addr =
   158				efi_pa_va_lookup(handler_info->acpi_param_buffer_address, EFI_RUNTIME_SERVICES_DATA);
   159	
   160			if (!th->handler_addr || !th->static_data_buffer_addr || !th->acpi_param_buffer_addr)
   161				pr_warn(
 > 162					"Idx: %d, Parts of handler(GUID: %pUB) are missed, handler_addr %llx, data_addr %llx, param_addr %llx",
 > 163					cur_handler, th->handler_addr,
   164					th->static_data_buffer_addr, th->acpi_param_buffer_addr);
   165		} while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
   166	
   167		return 0;
   168	
   169	parse_prmt_out4:
   170		kfree(tm->mmio_info);
   171	parse_prmt_out3:
   172		memunmap(mmio_count);
   173	parse_prmt_out2:
   174		kfree(tm);
   175	parse_prmt_out1:
   176		return -ENOMEM;
   177	}
   178	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

