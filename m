Return-Path: <linux-acpi+bounces-10734-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EED01A149F8
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 08:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338CE188B93C
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 07:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046FC1F78EF;
	Fri, 17 Jan 2025 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BwP9QT76"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7E11F76D7;
	Fri, 17 Jan 2025 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737097689; cv=none; b=nYDLlgCxX572FV7093HAWfS25jS4DqMmM3iA9B3RgHhwtB+m6iLmoenlPmTDR6ErOfie83PNTBqdD7noKncKIZrxj3KKmp0/O+dJ9IkznV7leUqpsd9B/QkzKxzGYZcXOaWRwXemi6UAjKUBpJUVtB67oVdq3hQmIc79UQQD1hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737097689; c=relaxed/simple;
	bh=A9YabGAz9F0I03ZVr6BHi8PnA+DJl2DrzQAK/6IyhOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfDvQtZhmwmWmxsU2T2El2H8u62YCegcGixWyKCLzaSPeBP44Ued0GUFuzrqTjFTaIScySvpj97BIUDw5aUZZwGIOBojd9aJICRIJTArnGI/Vjl2E+ZSExRG7XmF7YiqpU9hQBA48wGpeyYiy3p6FFWtaaVRHS9jg/FsWmCpEbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BwP9QT76; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737097688; x=1768633688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A9YabGAz9F0I03ZVr6BHi8PnA+DJl2DrzQAK/6IyhOU=;
  b=BwP9QT76Xs6CRbZVqP0E30b1JkHpI+4Qf7tItzCj/SrNBANnC+n6MkBo
   Q16hB4gIlZK4FADH9xudEuzck3aRN0TfbtLdeFx+h6uo/VBsdaSgRgkd7
   OQC3N+RDO2g/0XlJg0umQALnwSTRTCzn1OZl1feTrToYgDk+7aLOb01NJ
   kbI3ovjCiWwnfFVUicB4wkHyEU/UKXfxlMTqzFyiKxgYPztccw0jqNb3c
   y/vZu8oe6f9sF2eWlEfykUCebIti6E9PtMpAFXlEjeLuGeh5TmMnIE03T
   Q57lWztza/e0BZTpLEWrKHzDusVKAgnOh/CFTAXVr45YihxRScar4tMqb
   g==;
X-CSE-ConnectionGUID: A5ybydPYR32rxy0P6dCJtg==
X-CSE-MsgGUID: mJZs/EaJQTKiwb7WgBFRAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48937464"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48937464"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 23:08:07 -0800
X-CSE-ConnectionGUID: vljCoSYjS7yxeDj8iRCbgg==
X-CSE-MsgGUID: zlF27OjpQf6rVjKY1e3N5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136604791"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 16 Jan 2025 23:08:03 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYgSW-000Stx-0B;
	Fri, 17 Jan 2025 07:08:00 +0000
Date: Fri, 17 Jan 2025 15:07:58 +0800
From: kernel test robot <lkp@intel.com>
To: Ruidong Tian <tianruidong@linux.alibaba.com>, catalin.marinas@arm.com,
	will@kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com,
	sudeep.holla@arm.com, xueshuai@linux.alibaba.com,
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org, lenb@kernel.org, tony.luck@intel.com,
	bp@alien8.de, yazen.ghannam@amd.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	tianruidong@linux.alibaba.com
Subject: Re: [PATCH v3 3/5] RAS/AEST: Introduce AEST inject interface to test
 AEST driver
Message-ID: <202501171406.o7oztilo-lkp@intel.com>
References: <20250115084228.107573-4-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115084228.107573-4-tianruidong@linux.alibaba.com>

Hi Ruidong,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge arm64/for-next/core ras/edac-for-next linus/master tip/smp/core v6.13-rc7 next-20250116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ruidong-Tian/ACPI-RAS-AEST-Initial-AEST-driver/20250115-164601
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250115084228.107573-4-tianruidong%40linux.alibaba.com
patch subject: [PATCH v3 3/5] RAS/AEST: Introduce AEST inject interface to test AEST driver
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20250117/202501171406.o7oztilo-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250117/202501171406.o7oztilo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501171406.o7oztilo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/ras/aest/aest-core.c:280:13: error: static declaration of 'aest_proc_record' follows non-static declaration
     280 | static void aest_proc_record(struct aest_record *record, void *data)
         |             ^
   drivers/ras/aest/aest.h:338:6: note: previous declaration is here
     338 | void aest_proc_record(struct aest_record *record, void *data);
         |      ^
   1 error generated.


vim +/aest_proc_record +280 drivers/ras/aest/aest-core.c

b6c745ae1213b2 Ruidong Tian 2025-01-15  279  
b6c745ae1213b2 Ruidong Tian 2025-01-15 @280  static void aest_proc_record(struct aest_record *record, void *data)
b6c745ae1213b2 Ruidong Tian 2025-01-15  281  {
b6c745ae1213b2 Ruidong Tian 2025-01-15  282  	struct ras_ext_regs regs = {0};
b6c745ae1213b2 Ruidong Tian 2025-01-15  283  	int *count = data;
b6c745ae1213b2 Ruidong Tian 2025-01-15  284  
b6c745ae1213b2 Ruidong Tian 2025-01-15  285  	regs.err_status = record_read(record, ERXSTATUS);
b6c745ae1213b2 Ruidong Tian 2025-01-15  286  	if (!(regs.err_status & ERR_STATUS_V))
b6c745ae1213b2 Ruidong Tian 2025-01-15  287  		return;
b6c745ae1213b2 Ruidong Tian 2025-01-15  288  
b6c745ae1213b2 Ruidong Tian 2025-01-15  289  	(*count)++;
b6c745ae1213b2 Ruidong Tian 2025-01-15  290  
b6c745ae1213b2 Ruidong Tian 2025-01-15  291  	if (regs.err_status & ERR_STATUS_AV)
b6c745ae1213b2 Ruidong Tian 2025-01-15  292  		regs.err_addr = record_read(record, ERXADDR);
b6c745ae1213b2 Ruidong Tian 2025-01-15  293  
b6c745ae1213b2 Ruidong Tian 2025-01-15  294  	regs.err_fr = record->fr;
b6c745ae1213b2 Ruidong Tian 2025-01-15  295  	regs.err_ctlr = record_read(record, ERXCTLR);
b6c745ae1213b2 Ruidong Tian 2025-01-15  296  
b6c745ae1213b2 Ruidong Tian 2025-01-15  297  	if (regs.err_status & ERR_STATUS_MV) {
b6c745ae1213b2 Ruidong Tian 2025-01-15  298  		regs.err_misc[0] = record_read(record, ERXMISC0);
b6c745ae1213b2 Ruidong Tian 2025-01-15  299  		regs.err_misc[1] = record_read(record, ERXMISC1);
b6c745ae1213b2 Ruidong Tian 2025-01-15  300  		if (record->node->version >= ID_AA64PFR0_EL1_RAS_V1P1) {
b6c745ae1213b2 Ruidong Tian 2025-01-15  301  			regs.err_misc[2] = record_read(record, ERXMISC2);
b6c745ae1213b2 Ruidong Tian 2025-01-15  302  			regs.err_misc[3] = record_read(record, ERXMISC3);
b6c745ae1213b2 Ruidong Tian 2025-01-15  303  		}
b6c745ae1213b2 Ruidong Tian 2025-01-15  304  
b6c745ae1213b2 Ruidong Tian 2025-01-15  305  		if (record->node->info->interface_hdr->flags &
b6c745ae1213b2 Ruidong Tian 2025-01-15  306  			AEST_XFACE_FLAG_CLEAR_MISC) {
b6c745ae1213b2 Ruidong Tian 2025-01-15  307  			record_write(record, ERXMISC0, 0);
b6c745ae1213b2 Ruidong Tian 2025-01-15  308  			record_write(record, ERXMISC1, 0);
b6c745ae1213b2 Ruidong Tian 2025-01-15  309  			if (record->node->version >= ID_AA64PFR0_EL1_RAS_V1P1) {
b6c745ae1213b2 Ruidong Tian 2025-01-15  310  				record_write(record, ERXMISC2, 0);
b6c745ae1213b2 Ruidong Tian 2025-01-15  311  				record_write(record, ERXMISC3, 0);
b6c745ae1213b2 Ruidong Tian 2025-01-15  312  			}
b6c745ae1213b2 Ruidong Tian 2025-01-15  313  		/* ce count is 0 if record do not support ce */
b6c745ae1213b2 Ruidong Tian 2025-01-15  314  		} else if (record->ce.count > 0)
b6c745ae1213b2 Ruidong Tian 2025-01-15  315  			record_write(record, ERXMISC0, record->ce.reg_val);
b6c745ae1213b2 Ruidong Tian 2025-01-15  316  	}
b6c745ae1213b2 Ruidong Tian 2025-01-15  317  
b6c745ae1213b2 Ruidong Tian 2025-01-15  318  	/* panic if unrecoverable and uncontainable error encountered */
b6c745ae1213b2 Ruidong Tian 2025-01-15  319  	if ((regs.err_status & ERR_STATUS_UE) &&
b6c745ae1213b2 Ruidong Tian 2025-01-15  320  		(regs.err_status & ERR_STATUS_UET) > ERR_STATUS_UET_UEU)
b6c745ae1213b2 Ruidong Tian 2025-01-15  321  		aest_panic(record, &regs, "AEST: unrecoverable error encountered");
b6c745ae1213b2 Ruidong Tian 2025-01-15  322  
b6c745ae1213b2 Ruidong Tian 2025-01-15  323  	aest_log(record, &regs);
b6c745ae1213b2 Ruidong Tian 2025-01-15  324  
b6c745ae1213b2 Ruidong Tian 2025-01-15  325  	/* Write-one-to-clear the bits we've seen */
b6c745ae1213b2 Ruidong Tian 2025-01-15  326  	regs.err_status &= ERR_STATUS_W1TC;
b6c745ae1213b2 Ruidong Tian 2025-01-15  327  
b6c745ae1213b2 Ruidong Tian 2025-01-15  328  	/* Multi bit filed need to write all-ones to clear. */
b6c745ae1213b2 Ruidong Tian 2025-01-15  329  	if (regs.err_status & ERR_STATUS_CE)
b6c745ae1213b2 Ruidong Tian 2025-01-15  330  		regs.err_status |= ERR_STATUS_CE;
b6c745ae1213b2 Ruidong Tian 2025-01-15  331  
b6c745ae1213b2 Ruidong Tian 2025-01-15  332  	/* Multi bit filed need to write all-ones to clear. */
b6c745ae1213b2 Ruidong Tian 2025-01-15  333  	if (regs.err_status & ERR_STATUS_UET)
b6c745ae1213b2 Ruidong Tian 2025-01-15  334  		regs.err_status |= ERR_STATUS_UET;
b6c745ae1213b2 Ruidong Tian 2025-01-15  335  
b6c745ae1213b2 Ruidong Tian 2025-01-15  336  	record_write(record, ERXSTATUS, regs.err_status);
b6c745ae1213b2 Ruidong Tian 2025-01-15  337  }
b6c745ae1213b2 Ruidong Tian 2025-01-15  338  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

