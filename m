Return-Path: <linux-acpi+bounces-8501-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A40398AC07
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 20:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FE41F242F1
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 18:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E21198850;
	Mon, 30 Sep 2024 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cOKBEWmg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4976197A7A;
	Mon, 30 Sep 2024 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720616; cv=none; b=iIu50GcOmZ5mCsGNDT0yJ55E8WoBjE7RIWCmWmyUkOzKM5reJzBwQd/16v6wQTkA40bPg1DXUo4Lfxw1fDWiSQ7h1UnyUsJBmN2idYtObrqPfECO5o4fcLHdGZ+GbtzbpolGyu6L1PIkam2RrSi8HYbtU/6W0fRB8CcMf5r4gaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720616; c=relaxed/simple;
	bh=AjfZgRFK+gan3yhclRwu2EpSePfJfBr1TD+A3MeIVKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ET4c/Acils7CQuy3l7c8OEcjRpHV1btR0TNA3hHsfqP0YJOVVv0SaLM+ksG9wlNrVMs/J5fDPhrIZ+KNVPywTZAHa5BHPrUAHPbppSP57phjl/3bb+tqU/BxN51dPqwmDxbiS9TFJ571v5Ep5ofG7nSBuCaTHiuG9GDGUGKX7Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cOKBEWmg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727720614; x=1759256614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AjfZgRFK+gan3yhclRwu2EpSePfJfBr1TD+A3MeIVKA=;
  b=cOKBEWmghxbfI+MwW3du4wkhn0dV/fIoktDTDu6bkjJaFirYMT/G7NuV
   IkdbSgKPXoSO9Cdh0rLso9di/CbMHK+Q7rXMpmo7LsZgk6FvTggEr3fV0
   1yiTLhLwpqcsNAYKdpUxHXkU1K8HjZIcJtOG8G10Hr5gwFAczzjJCYeQf
   i7Qki0sm6jOhECwz5QaAPjfsrUwd7BZh/fiTklORlxZcE6VcJCrUrJGvr
   AZsb9oeZWti8tIyKMUxRWcP1FPECxD7jEtS74F3AWDedSTUucS1rqWHsB
   XPXazbu1P7+q2hMVSiXrfKePQ7MPFoSCFzh9T7np/wK4AEf36jBw2YWre
   A==;
X-CSE-ConnectionGUID: BetwVeqqTtGWv1v/Zgl0Gw==
X-CSE-MsgGUID: 5/YiuCJxS3WPhREbUr2N5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="44350136"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="44350136"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 11:23:33 -0700
X-CSE-ConnectionGUID: m0/ZsrjRRn+FWjhMN0hoKQ==
X-CSE-MsgGUID: MzcCrOFATmSkFoPRsfI2zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73515852"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 30 Sep 2024 11:23:29 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svL3P-000Plb-1b;
	Mon, 30 Sep 2024 18:23:27 +0000
Date: Tue, 1 Oct 2024 02:22:59 +0800
From: kernel test robot <lkp@intel.com>
To: Zheng Zengkai <zhengzengkai@huawei.com>, lpieralisi@kernel.org,
	guohanjun@huawei.com, sudeep.holla@arm.com, mark.rutland@arm.com,
	maz@kernel.org, rafael@kernel.org, lenb@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	daniel.lezcano@linaro.org, tglx@linutronix.de,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, zhengzengkai@huawei.com
Subject: Re: [PATCH] ACPI: GTDT: simplify acpi_gtdt_init() implementation
Message-ID: <202410010101.2oPkEaoP-lkp@intel.com>
References: <20240930030716.179992-1-zhengzengkai@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930030716.179992-1-zhengzengkai@huawei.com>

Hi Zheng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge tip/timers/core linus/master v6.12-rc1 next-20240930]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zheng-Zengkai/ACPI-GTDT-simplify-acpi_gtdt_init-implementation/20240930-105041
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240930030716.179992-1-zhengzengkai%40huawei.com
patch subject: [PATCH] ACPI: GTDT: simplify acpi_gtdt_init() implementation
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20241001/202410010101.2oPkEaoP-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241001/202410010101.2oPkEaoP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410010101.2oPkEaoP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/acpi/arm64/gtdt.c:11:
   In file included from include/linux/acpi.h:39:
   In file included from include/acpi/acpi_io.h:7:
   In file included from arch/arm64/include/asm/acpi.h:14:
   In file included from include/linux/memblock.h:12:
   In file included from include/linux/mm.h:2236:
   include/linux/vmstat.h:503:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     503 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     504 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:510:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     510 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     511 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:523:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     523 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     524 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/acpi/arm64/gtdt.c:383:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     383 |         if (!timer_count)
         |             ^~~~~~~~~~~~
   drivers/acpi/arm64/gtdt.c:400:9: note: uninitialized use occurs here
     400 |         return ret;
         |                ^~~
   drivers/acpi/arm64/gtdt.c:383:2: note: remove the 'if' if its condition is always false
     383 |         if (!timer_count)
         |         ^~~~~~~~~~~~~~~~~
     384 |                 goto out_put_gtdt;
         |                 ~~~~~~~~~~~~~~~~~
   drivers/acpi/arm64/gtdt.c:365:9: note: initialize the variable 'ret' to silence this warning
     365 |         int ret, timer_count = 0, gwdt_count = 0;
         |                ^
         |                 = 0
   5 warnings generated.


vim +383 drivers/acpi/arm64/gtdt.c

   360	
   361	static int __init gtdt_sbsa_gwdt_init(void)
   362	{
   363		void *platform_timer;
   364		struct acpi_table_header *table;
   365		int ret, timer_count = 0, gwdt_count = 0;
   366	
   367		if (acpi_disabled)
   368			return 0;
   369	
   370		if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_GTDT, 0, &table)))
   371			return -EINVAL;
   372	
   373		/*
   374		 * Note: Even though the global variable acpi_gtdt_desc has been
   375		 * initialized by acpi_gtdt_init() while initializing the arch timers,
   376		 * when we call this function to get SBSA watchdogs info from GTDT, the
   377		 * pointers stashed in it are stale (since they are early temporary
   378		 * mappings carried out before acpi_permanent_mmap is set) and we need
   379		 * to re-initialize them with permanent mapped pointer values to let the
   380		 * GTDT parsing possible.
   381		 */
   382		acpi_gtdt_init(table, &timer_count);
 > 383		if (!timer_count)
   384			goto out_put_gtdt;
   385	
   386		for_each_platform_timer(platform_timer) {
   387			if (is_non_secure_watchdog(platform_timer)) {
   388				ret = gtdt_import_sbsa_gwdt(platform_timer, gwdt_count);
   389				if (ret)
   390					break;
   391				gwdt_count++;
   392			}
   393		}
   394	
   395		if (gwdt_count)
   396			pr_info("found %d SBSA generic Watchdog(s).\n", gwdt_count);
   397	
   398	out_put_gtdt:
   399		acpi_put_table(table);
   400		return ret;
   401	}
   402	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

