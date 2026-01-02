Return-Path: <linux-acpi+bounces-19934-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE9ACEF01A
	for <lists+linux-acpi@lfdr.de>; Fri, 02 Jan 2026 17:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B07F301619C
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jan 2026 16:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8488A2765FF;
	Fri,  2 Jan 2026 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDjQgvpt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7919A149C6F;
	Fri,  2 Jan 2026 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767372734; cv=none; b=MtiYX2YSSvzPhuWyjezZgB3gFJL4vd6/iOZRKFyUsr8Xs/ige8Zn1TKbVJ9ICbhB8PTCzo9sQCv36qzahyUit2wtQa7as8EFWG+T1mnnk2giUq9x6sRE5+o2/thjsZ7lVkEA87op9EN+pb3uKrG2x93K+OGnh8Z7MS9QHDMLFx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767372734; c=relaxed/simple;
	bh=8V8fLvUiGyIBRMLZV4pVuc+83WP4F3JFApJ+XuTFOos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhsX4+bLosNgLfRWU7r1xE7/GfxHj4xbosOcR8apRlmCoEmNqTtUifLwrSxfMd9C5BzRZQR1+LicGFHOKv5o6Kd6J/Ef3ORUQRbWqvTN6nWt4ZZoPHg0xZKMP9mAIonRy8csqjGmElVNUpWPfAoC2P9OVrthh1VZEXC8Xc6Cls8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDjQgvpt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767372732; x=1798908732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8V8fLvUiGyIBRMLZV4pVuc+83WP4F3JFApJ+XuTFOos=;
  b=cDjQgvptmhZhHRGtR8/eFgOohkPmTEpukA7htsEIlFE7EbngigeGVyfT
   dprp7AFyhDjJRYO44ejD8iQ+y1niz8Eyu/PWDUCxHmTtFNiwIrfljPysk
   mQYAK01e4Eb5qgqocWlABUT0B03uk43xiE/xNVK22vlqmY9G+GHa4qsOg
   Ly2Zlm2/hsQMLnRl62Q17MdtLFBWNgQ990f1OG9sf6T6ESdUStp/fOWUF
   mrqZ9QhnBrOTyZEUahroxUv8K6KYJyE1b7elbTwCH1fz1oS3/kdJH0qJ0
   R+uQWI8GWaFTIjzjtdHRUQaqumjJVG8p4ROVPbmKlRSKtlD0MYCXGnIlk
   A==;
X-CSE-ConnectionGUID: p6dqhsBYRf6klFuEW6c4/A==
X-CSE-MsgGUID: +JH5FTkgTb+eTCGViQ999A==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="86447225"
X-IronPort-AV: E=Sophos;i="6.21,197,1763452800"; 
   d="scan'208";a="86447225"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2026 08:52:11 -0800
X-CSE-ConnectionGUID: AtlIZsjJRxaIYByQkePOyA==
X-CSE-MsgGUID: 7oYYZE7eQnyR4Qc6dhv6GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,197,1763452800"; 
   d="scan'208";a="239301491"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 02 Jan 2026 08:52:08 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vbiNh-000000002MP-2IRD;
	Fri, 02 Jan 2026 16:52:05 +0000
Date: Sat, 3 Jan 2026 00:51:35 +0800
From: kernel test robot <lkp@intel.com>
To: Ruidong Tian <tianruidong@linux.alibaba.com>, catalin.marinas@arm.com,
	will@kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com,
	sudeep.holla@arm.com, xueshuai@linux.alibaba.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	lenb@kernel.org, tony.luck@intel.com, bp@alien8.de,
	yazen.ghannam@amd.com, misono.tomohiro@fujitsu.com,
	fengwei_yin@linux.alibaba.com
Cc: oe-kbuild-all@lists.linux.dev, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v5 16/17] ras: AEST: support vendor node CMN700
Message-ID: <202601030052.0TftLGp4-lkp@intel.com>
References: <20251230091342.50404-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230091342.50404-1-tianruidong@linux.alibaba.com>

Hi Ruidong,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge ras/edac-for-next linus/master v6.19-rc3 next-20251219]
[cannot apply to arm64/for-next/core tip/smp/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ruidong-Tian/ACPI-AEST-Parse-the-AEST-table/20251230-172000
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20251230091342.50404-1-tianruidong%40linux.alibaba.com
patch subject: [PATCH v5 16/17] ras: AEST: support vendor node CMN700
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20260103/202601030052.0TftLGp4-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260103/202601030052.0TftLGp4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601030052.0TftLGp4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/perf/arm-cmn.c:5:10: fatal error: asm/arm-cmn.h: No such file or directory
       5 | #include <asm/arm-cmn.h>
         |          ^~~~~~~~~~~~~~~
   compilation terminated.


vim +5 drivers/perf/arm-cmn.c

     4	
   > 5	#include <asm/arm-cmn.h>
     6	#include <linux/acpi.h>
     7	#include <linux/bitfield.h>
     8	#include <linux/bitops.h>
     9	#include <linux/debugfs.h>
    10	#include <linux/interrupt.h>
    11	#include <linux/io.h>
    12	#include <linux/io-64-nonatomic-lo-hi.h>
    13	#include <linux/kernel.h>
    14	#include <linux/list.h>
    15	#include <linux/module.h>
    16	#include <linux/of.h>
    17	#include <linux/perf_event.h>
    18	#include <linux/platform_device.h>
    19	#include <linux/slab.h>
    20	#include <linux/sort.h>
    21	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

