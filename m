Return-Path: <linux-acpi+bounces-19742-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC6FCD44D8
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Dec 2025 20:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6118C3007A9D
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Dec 2025 19:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77626315D5E;
	Sun, 21 Dec 2025 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wuzr45lr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48F02F84F;
	Sun, 21 Dec 2025 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766345534; cv=none; b=Y9fUA0G2jnxHqZsaAs8XrQLaige0WeBNPNHdSvUGnFEDZL1zMg8bNj6dFd7BoIUyfAUe5M5Yu/Z5USLZlD03kP9aHY6Rcvo2BWtUL3lTXyDcIISvlcDX4lL8Xvg60RLZVnfU6CgI+TmBbWbcG2m5ESzBeGZjz4HeFEkDtOehORw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766345534; c=relaxed/simple;
	bh=b9Nwd9sXKSYEQNfuaVJPScUfQ1fvQxMuXpR46Wa/4LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kln3TquclvfcJG5xE7ERShkA2U1ANQl/cvf05S1Q6tCLt7XU5J+vJfsG7rFuC5e3rHUuhCoD5w2RErkOR4vPmR6ZFk/qA1Ur3/7Wqv5999vIa5JZg3rVg9lXR+Lpp5n6/3PlzRByfmEuZIhpX/g2I2PKPc4Bd43HU+WDdLFTOMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wuzr45lr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766345532; x=1797881532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b9Nwd9sXKSYEQNfuaVJPScUfQ1fvQxMuXpR46Wa/4LM=;
  b=Wuzr45lrHAYD6ZghjB9sF76SPdFjJEk1aS1QJk9rEt3vv7xN0FLTc1rK
   ctAmkmf/JRePX1wjgtiF8Q5+lmA6b55didaCXalFdykeh0ma+iE4CGwya
   2wpkcCHVMY6+tG+63IsynkMuEQHz0g3IUr5sZwU4c8aZtYqa/sroI7v0Y
   dv3ijORrdRXmy+4O7U92URVfmM3NrY8m0kJPvSSb873Cl+Mj+6byvaaNy
   1rY5hK8MShxaBXchb7+KP32Ig5ATRvxgmKyJVGMDgT2xeHseGNFgd1j/A
   dTTcsNWX4Mr+9vAq8nACg0AaTxjsim9dR2qGG6yiYlRi0TWVT8hvBr5e0
   g==;
X-CSE-ConnectionGUID: DDkiu8YMTlegYJYWJL80tg==
X-CSE-MsgGUID: 4BctYJZ6RnCU9da1pm62UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11649"; a="79582785"
X-IronPort-AV: E=Sophos;i="6.21,166,1763452800"; 
   d="scan'208";a="79582785"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 11:32:11 -0800
X-CSE-ConnectionGUID: ZAYyN8XSTVSW1Pl8TDrcXg==
X-CSE-MsgGUID: k5+MMjNURX+fVBoDoahJDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,166,1763452800"; 
   d="scan'208";a="236766300"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by orviesa001.jf.intel.com with ESMTP; 21 Dec 2025 11:32:07 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXP9w-000000005DA-2giu;
	Sun, 21 Dec 2025 19:32:04 +0000
Date: Sun, 21 Dec 2025 20:31:25 +0100
From: kernel test robot <lkp@intel.com>
To: Ahmed Tiba <ahmed.tiba@arm.com>, linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, tony.luck@intel.com, bp@alien8.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com,
	Michael.Zhao2@arm.com, ahmed.tiba@arm.com
Subject: Re: [PATCH 02/12] ras: add estatus core implementation
Message-ID: <202512212012.arq4zqYv-lkp@intel.com>
References: <20251217112845.1814119-3-ahmed.tiba@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217112845.1814119-3-ahmed.tiba@arm.com>

Hi Ahmed,

kernel test robot noticed the following build warnings:

[auto build test WARNING on efi/next]
[also build test WARNING on rafael-pm/linux-next rafael-pm/bleeding-edge robh/for-next linus/master v6.19-rc1 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Tiba/ras-add-estatus-core-interfaces/20251217-200718
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/20251217112845.1814119-3-ahmed.tiba%40arm.com
patch subject: [PATCH 02/12] ras: add estatus core implementation
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20251221/202512212012.arq4zqYv-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512212012.arq4zqYv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512212012.arq4zqYv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/efi/estatus.c:505:13: warning: 'estatus_cache_add' defined but not used [-Wunused-function]
     505 | static void estatus_cache_add(struct estatus_source *source,
         |             ^~~~~~~~~~~~~~~~~
   drivers/firmware/efi/estatus.c:435:12: warning: 'estatus_cached' defined but not used [-Wunused-function]
     435 | static int estatus_cached(struct acpi_hest_generic_status *estatus)
         |            ^~~~~~~~~~~~~~
   drivers/firmware/efi/estatus.c:411:12: warning: 'estatus_print_estatus' defined but not used [-Wunused-function]
     411 | static int estatus_print_estatus(const char *pfx,
         |            ^~~~~~~~~~~~~~~~~~~~~
   drivers/firmware/efi/estatus.c:340:13: warning: 'estatus_clear_estatus' defined but not used [-Wunused-function]
     340 | static void estatus_clear_estatus(struct estatus_source *source,
         |             ^~~~~~~~~~~~~~~~~~~~~
   drivers/firmware/efi/estatus.c:321:12: warning: 'estatus_read_estatus' defined but not used [-Wunused-function]
     321 | static int estatus_read_estatus(struct estatus_source *source,
         |            ^~~~~~~~~~~~~~~~~~~~
>> drivers/firmware/efi/estatus.c:117:12: warning: 'estatus_panic_timeout' defined but not used [-Wunused-variable]
     117 | static int estatus_panic_timeout __read_mostly = 30;
         |            ^~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/uprobes.h:13,
                    from include/linux/uprobes.h:66,
                    from include/linux/mm_types.h:16,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/xarray.h:16,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs/super_types.h:7,
                    from include/linux/fs/super.h:5,
                    from include/linux/fs.h:5,
                    from include/linux/seq_file.h:11,
                    from include/linux/seq_buf.h:7,
                    from include/linux/trace_seq.h:5,
                    from include/linux/cper.h:13,
                    from drivers/firmware/efi/estatus.c:10:
   drivers/firmware/efi/estatus.c:106:29: warning: 'estatus_report_chain' defined but not used [-Wunused-variable]
     106 | static ATOMIC_NOTIFIER_HEAD(estatus_report_chain);
         |                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/notifier.h:116:37: note: in definition of macro 'ATOMIC_NOTIFIER_HEAD'
     116 |         struct atomic_notifier_head name =                      \
         |                                     ^~~~


vim +/estatus_panic_timeout +117 drivers/firmware/efi/estatus.c

   116	
 > 117	static int estatus_panic_timeout __read_mostly = 30;
   118	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

