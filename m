Return-Path: <linux-acpi+bounces-15298-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE74B0FE62
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Jul 2025 03:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D1B966F25
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Jul 2025 01:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CBC19343B;
	Thu, 24 Jul 2025 01:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="by27WIHR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C73190664;
	Thu, 24 Jul 2025 01:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753321098; cv=none; b=XqVO2soQcitmmMf0KqmMogy+bPob5qzXxHVc/jwdc/SZuqJ9eCOdrLzMLyCPRdlmriUV1/cYD/mnAI1pgfNaF8wAcnrHpKdqnFzXc5Ucp8GbVOMTqTrSPgjYtzVQYuwUFI5r546z6nWETZ5FFuzVVklG4IVL/u3jYB/78/pLMHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753321098; c=relaxed/simple;
	bh=6b7ZaEfMNucJo8hfYKdLp6+YalgcIzuomcomXgSUQSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RS1T0WC1FqE7Cgt4Uvo/i6WVRxcnOOedGlWBZxaA5BXdWfjLTBUhIwoiVpR+A5/cbCN4vTXzMLyNSB1hKy2Qifmi6hgSXMsYXtNCrXc7D/9/j6ZlS3yTODlPcxnrsrxI+5WC/RAyh2DWeC+rGImJO1aklAa8U/R6/KpDsoMCV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=by27WIHR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753321096; x=1784857096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6b7ZaEfMNucJo8hfYKdLp6+YalgcIzuomcomXgSUQSY=;
  b=by27WIHRFHJx2Xdv+MWuddBCjKdPVqZErogg9+ANK+lABam3i4hmNb14
   l1NJWez8t4gMAiFPM7+WgC5inPJ06gkbhEbrFFr+C1UYKt7P62PZ4Um9x
   qI/NkEj8bk3+UqWwPRMe4f8bMawGPCnF1CShCTse3PLGlownoWUddt2La
   l5RPoGCHrngUHEAH3mS19p592ET2gLP8pyfAE8wewxYPEIMsyA5LCF5g5
   I/d9fPWmQnAArpRUaz51hlWbVMdV2937ToftnqtB0ALc+ieS+bBRZY+I2
   eaY7xJbLyveZOS7+l/Kw8aoxI3xcb7Gs51lm3FD7nHRgBBbSxZ5m68ZyF
   w==;
X-CSE-ConnectionGUID: dEhoQTpQTuaE3dTdpuj8Xg==
X-CSE-MsgGUID: mCnuH/CXQMWim5O/zYPO6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66691889"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="66691889"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 18:38:16 -0700
X-CSE-ConnectionGUID: JO8mWtv0Qz+0oLnRDMGiVA==
X-CSE-MsgGUID: dnv1GQHxQZC82KJiOyHnaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="164125887"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 23 Jul 2025 18:38:13 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uekuR-000JzH-28;
	Thu, 24 Jul 2025 01:38:11 +0000
Date: Thu, 24 Jul 2025 09:38:11 +0800
From: kernel test robot <lkp@intel.com>
To: Huisong Li <lihuisong@huawei.com>, rafael@kernel.org, lenb@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	zhenglifeng1@huawei.com, yubowen8@huawei.com,
	liuyonglong@huawei.com, lihuisong@huawei.com
Subject: Re: [PATCH v2] ACPI: processor: idle: Fix resource leak and
 potential concurrent in acpi_processor_power_init()
Message-ID: <202507240807.1ild86sv-lkp@intel.com>
References: <20250723121034.3685996-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723121034.3685996-1-lihuisong@huawei.com>

Hi Huisong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.16-rc7 next-20250723]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huisong-Li/ACPI-processor-idle-Fix-resource-leak-and-potential-concurrent-in-acpi_processor_power_init/20250723-201246
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250723121034.3685996-1-lihuisong%40huawei.com
patch subject: [PATCH v2] ACPI: processor: idle: Fix resource leak and potential concurrent in acpi_processor_power_init()
config: i386-buildonly-randconfig-001-20250724 (https://download.01.org/0day-ci/archive/20250724/202507240807.1ild86sv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250724/202507240807.1ild86sv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507240807.1ild86sv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/acpi/processor_core.c:15:
>> include/acpi/processor.h:452:13: warning: 'acpi_processor_unregister_idle_driver' defined but not used [-Wunused-function]
     452 | static void acpi_processor_unregister_idle_driver(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/acpi/processor.h:448:12: warning: 'acpi_processor_register_idle_driver' defined but not used [-Wunused-function]
     448 | static int acpi_processor_register_idle_driver(void)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/acpi_processor_unregister_idle_driver +452 include/acpi/processor.h

   443	
   444	static inline int acpi_processor_hotplug(struct acpi_processor *pr)
   445	{
   446		return -ENODEV;
   447	}
 > 448	static int acpi_processor_register_idle_driver(void)
   449	{
   450		return -ENODEV;
   451	}
 > 452	static void acpi_processor_unregister_idle_driver(void)
   453	{
   454	}
   455	#endif /* CONFIG_ACPI_PROCESSOR_IDLE */
   456	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

