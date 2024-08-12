Return-Path: <linux-acpi+bounces-7524-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB05794E55C
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 05:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31629B22388
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 03:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48B213634F;
	Mon, 12 Aug 2024 03:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HYZjewD2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7740055C29
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 03:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723431797; cv=none; b=eqjf4+LKVaKJ4xACdNsN3WLC8Kln85d/AdbGDTXu+FBL4VwS3JYmuR1Qfqc0qA0ezsn5CP2EvG6u/Lp0CTrs1fLGsRwyFn3QnfNWI+w34lsSb2ootkL0kdfF2J5OUzY/wWF73ZF7eWi6xmv4vKlEekTRwfU+zwR6uktS02o8zdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723431797; c=relaxed/simple;
	bh=i4yPaw+DM1S7Y5y1TYBn/hgITkW+TPEqJBnwJuQUR40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cauz4iXm1ZmWL5qyEIxKCwhrdwcu7thz2LY/wzD1iCROEfWvXJ/sHDyBvRWf9wnc0ISr/h5VRPpp0TQnyzXaJ9SMFIf04ADKDWEH39qFXSRai0UZGIXNhnPJ9Zzb63s+lSjJPaEru+hSmFnJQuucfCqPd/GJtluqzR/55IvFhJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HYZjewD2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723431796; x=1754967796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i4yPaw+DM1S7Y5y1TYBn/hgITkW+TPEqJBnwJuQUR40=;
  b=HYZjewD2gPdGNOUlQSgjPv7Zo01XZejjWuFnscfFuSTpE6MiyL439Ix+
   O20zWXfq/V+KtLP41TzKRjumX/wSKOF9jW8rxq7Gcqd0tfx5awek8dksM
   gX6u6NAFaNxQM6UGaHhsIfv70daro0gUOagrSNW63JYKPkYx7b914gqpQ
   dlYWLdIQKp8jIOdO1nmcZqJHEQdwhYuqTlITf9ZKAZ0E8FYGiAPrQ9m5T
   QrzM6OIvnUPVqO3pdi3BwkIBRYhNwKOFOHFAv2WUpTiTKKE0o9k35CBOq
   hlUEDNgk1ksmuw9hbCPzLHft2hqcnavI4YUqK3BBgWN8ujcr63Ii69DZ1
   A==;
X-CSE-ConnectionGUID: BYXY560pQQeXcVvgMC8AFg==
X-CSE-MsgGUID: 5AyY4c4mRnmFAow0d43q7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21675107"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21675107"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 20:03:15 -0700
X-CSE-ConnectionGUID: mPY9YFuqQcuySKU+lcmd5w==
X-CSE-MsgGUID: mxIAv7KKRAqQi3ixk7Ywtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="88767694"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 11 Aug 2024 20:03:13 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdLKv-000BLe-38;
	Mon, 12 Aug 2024 03:03:09 +0000
Date: Mon, 12 Aug 2024 11:02:25 +0800
From: kernel test robot <lkp@intel.com>
To: Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v2 4/4] ARM64: ACPI: Move the NUMA code to
 drivers/acpi/arm64/
Message-ID: <202408121026.c3mDLUsP-lkp@intel.com>
References: <20240811042303.3498761-5-guohanjun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811042303.3498761-5-guohanjun@huawei.com>

Hi Hanjun,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v6.11-rc3 next-20240809]
[cannot apply to arm-perf/for-next/perf]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hanjun-Guo/ARM64-ACPI-Remove-the-leftover-acpi_init_cpus/20240811-122442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20240811042303.3498761-5-guohanjun%40huawei.com
patch subject: [PATCH v2 4/4] ARM64: ACPI: Move the NUMA code to drivers/acpi/arm64/
config: arm64-randconfig-001-20240812 (https://download.01.org/0day-ci/archive/20240812/202408121026.c3mDLUsP-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240812/202408121026.c3mDLUsP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408121026.c3mDLUsP-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: arch/arm64/kernel/smp.o: in function `smp_init_cpus':
>> arch/arm64/kernel/smp.c:669:(.init.text+0x424): undefined reference to `acpi_map_cpus_to_nodes'


vim +669 arch/arm64/kernel/smp.c

e189624916961c Lorenzo Pieralisi 2018-06-25  650  
e189624916961c Lorenzo Pieralisi 2018-06-25  651  static void __init acpi_parse_and_init_cpus(void)
e189624916961c Lorenzo Pieralisi 2018-06-25  652  {
e189624916961c Lorenzo Pieralisi 2018-06-25  653  	/*
e189624916961c Lorenzo Pieralisi 2018-06-25  654  	 * do a walk of MADT to determine how many CPUs
e189624916961c Lorenzo Pieralisi 2018-06-25  655  	 * we have including disabled CPUs, and get information
e189624916961c Lorenzo Pieralisi 2018-06-25  656  	 * we need for SMP init.
e189624916961c Lorenzo Pieralisi 2018-06-25  657  	 */
e189624916961c Lorenzo Pieralisi 2018-06-25  658  	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
e189624916961c Lorenzo Pieralisi 2018-06-25  659  				      acpi_parse_gic_cpu_interface, 0);
e189624916961c Lorenzo Pieralisi 2018-06-25  660  
e189624916961c Lorenzo Pieralisi 2018-06-25  661  	/*
e189624916961c Lorenzo Pieralisi 2018-06-25  662  	 * In ACPI, SMP and CPU NUMA information is provided in separate
e189624916961c Lorenzo Pieralisi 2018-06-25  663  	 * static tables, namely the MADT and the SRAT.
e189624916961c Lorenzo Pieralisi 2018-06-25  664  	 *
e189624916961c Lorenzo Pieralisi 2018-06-25  665  	 * Thus, it is simpler to first create the cpu logical map through
e189624916961c Lorenzo Pieralisi 2018-06-25  666  	 * an MADT walk and then map the logical cpus to their node ids
e189624916961c Lorenzo Pieralisi 2018-06-25  667  	 * as separate steps.
e189624916961c Lorenzo Pieralisi 2018-06-25  668  	 */
e189624916961c Lorenzo Pieralisi 2018-06-25 @669  	acpi_map_cpus_to_nodes();
e189624916961c Lorenzo Pieralisi 2018-06-25  670  }
0f0783365cbb7e Lorenzo Pieralisi 2015-05-13  671  #else
e189624916961c Lorenzo Pieralisi 2018-06-25  672  #define acpi_parse_and_init_cpus(...)	do { } while (0)
0f0783365cbb7e Lorenzo Pieralisi 2015-05-13  673  #endif
0f0783365cbb7e Lorenzo Pieralisi 2015-05-13  674  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

