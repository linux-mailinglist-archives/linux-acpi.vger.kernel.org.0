Return-Path: <linux-acpi+bounces-19744-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 997E5CD474A
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 00:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A0CF301A1A6
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Dec 2025 23:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642D430F524;
	Sun, 21 Dec 2025 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cno3pLJj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248EB2BE7AB;
	Sun, 21 Dec 2025 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766360420; cv=none; b=OtX/EC/QDapPsbDEp4OmHsWIqD4A44oVRcleE+8sBECs0FaMDKBMONkHIX9ayNejujl6JmypZo9ofSOqzsM4GO+gEhOU9rZZ5QTmj341ELY80sSYl7xLGvEzoSLY95tC5SAY6yw4IoW3VyU+kQWalJqP8CtK34nr2f7CJAnDxWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766360420; c=relaxed/simple;
	bh=e9eJeejx8g4//rFgeHHEHuKIrp9YsEoXUX37jxFDU1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fea7kaKXTH8AZCIyHbFHb+d9Xx7duwXuZ9gZ+QvabS0tOK5SA5xcZxrlgwFhSAnUmIeEHPGnvKQhcV4pqwsFY6jObDQdpO6XUHtK1rPrqUQkfsKUWKWO43UGhMoMKCozt7KQzpvrzAjdJ+Cp5G8f/xGAPUQA/1QjIwuFF3SL3Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cno3pLJj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766360417; x=1797896417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e9eJeejx8g4//rFgeHHEHuKIrp9YsEoXUX37jxFDU1k=;
  b=cno3pLJjQRQUuWZiDjIqzomHdiGyApocZZF1ySBK4eshAIExXweueDpp
   M3YQofGhamMnJwvAOeylnT/DbcfRohwKygwn1jwrLdm2/vAeAaACExn6r
   RezkCW/+3CKiWRjBY0HdcINC1IHqEFbmWcZcLdsxAYP92glKgf/Z//wpI
   dSkpsp9qOl2vA7Ny3TSnVuUy+csm9g8Jxd9QSjoPG8U4rN7goVCIHgxIh
   FF1SkMsARrRZL7mRbUOg1tNVbWsOCzaFlDsSqhENfIsMNJsPX4l4w9EBC
   X/uAj+84nb8n81F54SKMec3opltn2SHvwQitqG5WLyE1jc1lz0P5ql9fz
   g==;
X-CSE-ConnectionGUID: 80GOKc8hT4CK2yDtGaOH/Q==
X-CSE-MsgGUID: smJ7yMIxSPmX6G9PGspCFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11649"; a="85805556"
X-IronPort-AV: E=Sophos;i="6.21,167,1763452800"; 
   d="scan'208";a="85805556"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 15:40:14 -0800
X-CSE-ConnectionGUID: IAayTUEtQcmpvCzIfBzPsw==
X-CSE-MsgGUID: tZ7Ss/XWR3ibjJDzWPED2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,167,1763452800"; 
   d="scan'208";a="230040405"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by orviesa002.jf.intel.com with ESMTP; 21 Dec 2025 15:40:09 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXT1z-000000005H6-24HZ;
	Sun, 21 Dec 2025 23:40:07 +0000
Date: Mon, 22 Dec 2025 00:39:10 +0100
From: kernel test robot <lkp@intel.com>
To: Ahmed Tiba <ahmed.tiba@arm.com>, linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, tony.luck@intel.com, bp@alien8.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com,
	Michael.Zhao2@arm.com, ahmed.tiba@arm.com
Subject: Re: [PATCH 03/12] ras: add estatus vendor handling and processing
Message-ID: <202512220010.sdcS5LYV-lkp@intel.com>
References: <20251217112845.1814119-4-ahmed.tiba@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217112845.1814119-4-ahmed.tiba@arm.com>

Hi Ahmed,

kernel test robot noticed the following build errors:

[auto build test ERROR on efi/next]
[also build test ERROR on rafael-pm/linux-next rafael-pm/bleeding-edge robh/for-next arm64/for-next/core linus/master v6.19-rc1 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Tiba/ras-add-estatus-core-interfaces/20251217-200718
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/20251217112845.1814119-4-ahmed.tiba%40arm.com
patch subject: [PATCH 03/12] ras: add estatus vendor handling and processing
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20251222/202512220010.sdcS5LYV-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251222/202512220010.sdcS5LYV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512220010.sdcS5LYV-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/firmware/efi/estatus.c: In function 'estatus_source_fixmap':
>> drivers/firmware/efi/estatus.c:126:24: error: 'FIX_HOLE' undeclared (first use in this function)
     126 |                 return FIX_HOLE;
         |                        ^~~~~~~~
   drivers/firmware/efi/estatus.c:126:24: note: each undeclared identifier is reported only once for each function it appears in
   drivers/firmware/efi/estatus.c: In function 'estatus_handle_arm_hw_error':
   drivers/firmware/efi/estatus.c:656:9: error: too few arguments to function 'log_arm_hw_error'
     656 |         log_arm_hw_error(err);
         |         ^~~~~~~~~~~~~~~~
   In file included from drivers/firmware/efi/estatus.c:23:
   include/linux/ras.h:27:6: note: declared here
      27 | void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev);
         |      ^~~~~~~~~~~~~~~~
   In file included from drivers/firmware/efi/estatus.c:30:
   drivers/firmware/efi/estatus.c: In function 'estatus_do_proc':
   include/linux/estatus.h:231:71: warning: passing argument 2 of 'estatus_section_iter_next' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     231 |              ((_section) = estatus_section_iter_next(&__estatus_iter, (_estatus))); \
         |                                                                       ^~~~~~~~~~
   drivers/firmware/efi/estatus.c:817:9: note: in expansion of macro 'estatus_for_each_section'
     817 |         estatus_for_each_section(estatus, gdata) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/estatus.h:208:51: note: expected 'struct acpi_hest_generic_status *' but argument is of type 'const struct acpi_hest_generic_status *'
     208 |                           estatus_generic_status *estatus)
         |                                                   ^
   drivers/firmware/efi/estatus.c: At top level:
   drivers/firmware/efi/estatus.c:947:13: warning: 'estatus_print_queued_estatus' defined but not used [-Wunused-function]
     947 | static void estatus_print_queued_estatus(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/firmware/efi/estatus.c:118:12: warning: 'estatus_panic_timeout' defined but not used [-Wunused-variable]
     118 | static int estatus_panic_timeout __read_mostly = 30;
         |            ^~~~~~~~~~~~~~~~~~~~~


vim +/FIX_HOLE +126 drivers/firmware/efi/estatus.c

   122	
   123	static enum fixed_addresses estatus_source_fixmap(struct estatus_source *source)
   124	{
   125		if (WARN_ON_ONCE(!source->fixmap_idx))
 > 126			return FIX_HOLE;
   127	
   128		return source->fixmap_idx;
   129	}
   130	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

