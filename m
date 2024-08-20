Return-Path: <linux-acpi+bounces-7737-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56379958EB1
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 21:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2D77B21D21
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 19:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA1815855B;
	Tue, 20 Aug 2024 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCrg++6R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656D814B94B;
	Tue, 20 Aug 2024 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724182798; cv=none; b=Pw97sSr4ujbBpnm1fqUkKHpEwRUQShR6JTCavb4c0HT951gY+aWGkei+6C8TkOU6ie9+vhExoGXOFjZYCyXuethoJI3xbbAnANgAIsPVOJuBafGEmu6xkLlRsL9c9+3kSZVbzO7Lfljnxjd4gIj1EwcaQp8Br9at7pXj5iFYUAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724182798; c=relaxed/simple;
	bh=eet258ZmfZhKKtJwJUN7C598plW54ADv5Xh+PzuuGlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG1o4gYeBReUYtTATCLK9Xcqxd6WPEqUmrVQHRCrNjDiOB/9Nd3sxzi8W68ZoGxq9XTMw+wrX294Fo0nPMti7CGiF/xgxjymsFvEocLDEGiVhqlSe21tfslIvQmQ0LGkAlC36zyvK5fW02ElSDCKsj7YuK7HyueyQCOJ0v66IVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCrg++6R; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724182795; x=1755718795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eet258ZmfZhKKtJwJUN7C598plW54ADv5Xh+PzuuGlY=;
  b=MCrg++6RBR1Pnr3JQzz/CNlb+or+of+6cQiw9tSCMbjbgnNDh3CGak3W
   +s1p6fZFpdo25bbAomE3p9S9OBwV/lZQE361xy1PVoQq5mO82k0fmYaRz
   Bq4+AC/hGZpZkwMPGLNSvkX76SrMdMhQe1+fSXIc2iLU/oH5SDZnWDQlX
   LyLGyqdpPKNoW+Tr6QI9NVKVGsQtYajUPZCxkpVH/cOxtiuoDE5L4X5A6
   v5DTw6mwhK2wg11FdZ0RVi8BjHo+ZlwsEXL1V3HTcMFN6L3fOO5LwgBkc
   QRv99HZ07IwlnGgStK6s8aR+x8po2Za+YVsX9dY/dgSETgzYQclS6Bk1J
   Q==;
X-CSE-ConnectionGUID: TYGdOCngSCKwIupvm8xp1A==
X-CSE-MsgGUID: yIjVp0fHRYOyZ4agwKoCPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22372641"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22372641"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 12:39:55 -0700
X-CSE-ConnectionGUID: E7KFSF83RlWgQgxLEKNz3A==
X-CSE-MsgGUID: 8ngfMDiLTICNrsNrsKuyFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="98315039"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 Aug 2024 12:39:52 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgUhp-000AY8-19;
	Tue, 20 Aug 2024 19:39:49 +0000
Date: Wed, 21 Aug 2024 03:39:26 +0800
From: kernel test robot <lkp@intel.com>
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-acpi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 6/7] xen: allow mapping ACPI data using a different
 physical address
Message-ID: <202408210336.uafTZlvc-lkp@intel.com>
References: <20240820082012.31316-7-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820082012.31316-7-jgross@suse.com>

Hi Juergen,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v6.11-rc4 next-20240820]
[cannot apply to xen-tip/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Juergen-Gross/xen-use-correct-end-address-of-kernel-for-conflict-checking/20240820-162344
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240820082012.31316-7-jgross%40suse.com
patch subject: [PATCH v2 6/7] xen: allow mapping ACPI data using a different physical address
config: x86_64-randconfig-004-20240820 (https://download.01.org/0day-ci/archive/20240821/202408210336.uafTZlvc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240821/202408210336.uafTZlvc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408210336.uafTZlvc-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/smpboot.c:64:
>> arch/x86/include/asm/acpi.h:179:42: error: unknown type name 'acpi_physical_address'
     179 | extern void __iomem * (*acpi_os_ioremap)(acpi_physical_address phys,
         |                                          ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/acpi.h:180:42: error: unknown type name 'acpi_size'
     180 |                                          acpi_size size);
         |                                          ^~~~~~~~~
   arch/x86/include/asm/acpi.h:181:35: error: unknown type name 'acpi_physical_address'
     181 | void __iomem *x86_acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/acpi.h:181:63: error: unknown type name 'acpi_size'
     181 | void __iomem *x86_acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
         |                                                               ^~~~~~~~~


vim +/acpi_physical_address +179 arch/x86/include/asm/acpi.h

   176	
   177	#ifdef CONFIG_XEN_PV_DOM0
   178	/* A Xen PV dom0 needs a special acpi_os_ioremap() handling. */
 > 179	extern void __iomem * (*acpi_os_ioremap)(acpi_physical_address phys,
 > 180						 acpi_size size);
   181	void __iomem *x86_acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
   182	#define acpi_os_ioremap acpi_os_ioremap
   183	#endif
   184	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

