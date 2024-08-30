Return-Path: <linux-acpi+bounces-8025-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E61959669E8
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2024 21:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9011F22B0C
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2024 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B041B1BBBCC;
	Fri, 30 Aug 2024 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPP3dL57"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14411B9B5A;
	Fri, 30 Aug 2024 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046536; cv=none; b=Ny/3x9ena9YqX484k4mywfFcJlcdc308yzw+UV7q6Ce+cgmC/5cbiD8RkunG+VF1Y1j1mh0xJQj1aQeHn+scmkfcuEz8hcNEyj9g/woczIFUD8K3RZSiaPQMPzIq7x5wznvpMsDcRq/JU099QLHsnPHtpELNVOpAns5Be837bUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046536; c=relaxed/simple;
	bh=+w56fZU/eoYZPtFEPoXmUXs53h0iyOlCZoPIkGdvgB8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sdfB6efxKhAkhN/rKpwZoAUKI3C6Dfpi8GQ0wW8UH6PrBoSR8bU/z5IZU5eOb9Y83Jw1N2azTx4gCaZZ1K6En0qYA3B5yRTNr0ymjOHLv/wD6tj3ImgUi+KZ5W4EoXXk6P97y540S8K/3LHGlJ2AD56UC+gJHs1lg2geOOL7pMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPP3dL57; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725046535; x=1756582535;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+w56fZU/eoYZPtFEPoXmUXs53h0iyOlCZoPIkGdvgB8=;
  b=FPP3dL57wDXGIALxMkGv985d6747NTJiIcdKjBS1UGZGtUTqv4LiyZB0
   IKn6n1gPwOEDhCdXl64p2zf6Jb8Im9Fk/brWM2PQdnjmxVLa+R7k8Wk/S
   QT62ORcMsw/ZtzkOwIGdN9Q9cJ/0U8te+AxdlFHj04bt34BB8qO6NgscM
   KPfr9eDFZat11n1OwUe5zFZ+fPn3oYH31vhDTypHcHhnDCe6be2jAj9Ue
   L07rh5IXy5tFltQy8Slt1jSXGQPdzH5yMMdknUog94Cvgm07VKDH1ULl2
   KnVqVy+gUGma24+oVWxpURALRYSG3/Om/q7mqBhS2Jjzb/LDMXh09pa4A
   A==;
X-CSE-ConnectionGUID: brFhk2FTTuqxZx9UhvKArw==
X-CSE-MsgGUID: cUevVmNtQu6NNw/N4KSzJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="35109094"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="35109094"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 12:35:34 -0700
X-CSE-ConnectionGUID: PETXZLFISgGbXbcmQPKcDA==
X-CSE-MsgGUID: XedcahG3TE6abaYsBlhxjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="64490190"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 30 Aug 2024 12:35:33 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sk7P8-0001za-2P;
	Fri, 30 Aug 2024 19:35:30 +0000
Date: Sat, 31 Aug 2024 03:34:39 +0800
From: kernel test robot <lkp@intel.com>
To: Len Brown <len.brown@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [acpi:acpi 2/2] drivers/acpi/osl.c:609:14: sparse: sparse: symbol
 'one_ms_timer_hack' was not declared. Should it be static?
Message-ID: <202408310347.Gl65LSbs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git acpi
head:   4b12d579d736e75908699afe6e4950f651c4f5f6
commit: 4b12d579d736e75908699afe6e4950f651c4f5f6 [2/2] acpi_os_sleep debug patch
config: x86_64-randconfig-123-20240830 (https://download.01.org/0day-ci/archive/20240831/202408310347.Gl65LSbs-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408310347.Gl65LSbs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408310347.Gl65LSbs-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/acpi/osl.c:378:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/acpi/osl.c:609:14: sparse: sparse: symbol 'one_ms_timer_hack' was not declared. Should it be static?
   drivers/acpi/osl.c:1666:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *rv @@     got void [noderef] __iomem * @@
   drivers/acpi/osl.c:1666:20: sparse:     expected void *rv
   drivers/acpi/osl.c:1666:20: sparse:     got void [noderef] __iomem *
   drivers/acpi/osl.c:720:1: sparse: sparse: context imbalance in 'acpi_os_read_memory' - wrong count at exit
   drivers/acpi/osl.c:753:1: sparse: sparse: context imbalance in 'acpi_os_write_memory' - wrong count at exit

vim +/one_ms_timer_hack +609 drivers/acpi/osl.c

   603	
   604	/*
   605	 * Running in interpreter thread context, safe to sleep
   606	 */
   607	
   608	#include <linux/moduleparam.h>
 > 609	unsigned int one_ms_timer_hack;
   610	module_param(one_ms_timer_hack, uint, 0644);
   611	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

