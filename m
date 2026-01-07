Return-Path: <linux-acpi+bounces-20037-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB58D00584
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 23:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0052302E04B
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 22:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C668429DB8F;
	Wed,  7 Jan 2026 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PU1ODEz7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B3E2C11FE;
	Wed,  7 Jan 2026 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767825605; cv=none; b=YuYUlFfYfhUQs1vh5vxMjuZGDwyCNpQOhIx5YZEYFMsIYYGVsWucjvFqCJ5AHum/D9viKwo2CQcLA8EOLWX5KTyimubIm1WbcH5OJJfwmZxbUfXv94LajxJblmEB1DIELfBTNPF/WpAAomVodghKUnQvONVuRuGyF3Fnf36mzkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767825605; c=relaxed/simple;
	bh=Dx7BFYgAno1uTd386MrB5lOizKX8IdPSckHlamsZshA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zx1t+a4PjJZ8hF+rmL8/LcdwOqsy1Bk1r/DC2qEMCWg6oQ8Lw3Nj1jrIgg9betSUdEAJkqZILoe6YwvK27no0/Fi5DU8Irkr1FZTC4PV7pGO+iLdyC2A5zCgpcBxxiNI23Wh9OWGpWh9vq84LBzbg0NDsinggG9cS1AxFl93FvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PU1ODEz7; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767825604; x=1799361604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dx7BFYgAno1uTd386MrB5lOizKX8IdPSckHlamsZshA=;
  b=PU1ODEz7NZattQ760eVH25e9bWdjrTRBZgQMAjs2SCy7BkyQMwq0GWud
   qDwXSW2EqP4g5egZjj1EkRI5/HVB6B0ctLoUUE4jTICOlui8nTbSSuBpa
   o+c58dJkzqB+4FvtFk9ivWQ7OVrNZg7EEAzAtQ6fGJjgFPDpLYNW9i2bq
   beMqlmdnZFnv7x7p5K8Qy2V8WqoaNZXxrE8hfW8l66pG8EaAmzd03Yigk
   ZOWIQnV4/iJ8/mNkQQZnW0mK3Ks6JN8Gqhp8S7N6IkiZG3sXSZKoDCHrS
   AhAqbleO0OUOEOensG3F92fXQKtQmsFXmoqaczshsrMyM7wRS4AvALot1
   g==;
X-CSE-ConnectionGUID: z343GTEZSTWukNBPOEWEvA==
X-CSE-MsgGUID: hyycr0+iTDy6cEdS7k6ziQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="94669202"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="94669202"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 14:40:03 -0800
X-CSE-ConnectionGUID: TChAjcvWRgWtvji39qbJMw==
X-CSE-MsgGUID: 0T2nD1EvSymrLqhSK/FxJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="207572747"
Received: from igk-lkp-server01.igk.intel.com (HELO 92b2e8bd97aa) ([10.211.93.152])
  by orviesa004.jf.intel.com with ESMTP; 07 Jan 2026 14:40:02 -0800
Received: from kbuild by 92b2e8bd97aa with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vdcC7-000000001dE-2Zn7;
	Wed, 07 Jan 2026 22:39:59 +0000
Date: Wed, 7 Jan 2026 23:39:16 +0100
From: kernel test robot <lkp@intel.com>
To: Riwen Lu <luriwen@kylinos.cn>, rafael@kernel.org, lenb@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v1] ACPI: PM: Introduce CONFIG_ACPI_S2IDLE for
 platform-independent S2Idle support
Message-ID: <202601072320.hVTvfoUZ-lkp@intel.com>
References: <20260107015907.1421272-1-luriwen@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107015907.1421272-1-luriwen@kylinos.cn>

Hi Riwen,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.19-rc4 next-20260107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Riwen-Lu/ACPI-PM-Introduce-CONFIG_ACPI_S2IDLE-for-platform-independent-S2Idle-support/20260107-101450
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260107015907.1421272-1-luriwen%40kylinos.cn
patch subject: [PATCH v1] ACPI: PM: Introduce CONFIG_ACPI_S2IDLE for platform-independent S2Idle support
config: x86_64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260107/202601072320.hVTvfoUZ-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260107/202601072320.hVTvfoUZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601072320.hVTvfoUZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/s2idle.c:155:20: error: static declaration of 'acpi_s2idle_setup' follows non-static declaration
     155 | static inline void acpi_s2idle_setup(void) {}
         |                    ^~~~~~~~~~~~~~~~~
   In file included from drivers/acpi/s2idle.c:13:
   drivers/acpi/sleep.h:24:13: note: previous declaration of 'acpi_s2idle_setup' with type 'void(void)'
      24 | extern void acpi_s2idle_setup(void);
         |             ^~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ACPI_S2IDLE
   Depends on [n]: ACPI [=y] && SUSPEND [=n]
   Selected by [y]:
   - ACPI_SYSTEM_POWER_STATES_SUPPORT [=y] && ACPI [=y]


vim +/acpi_s2idle_setup +155 drivers/acpi/s2idle.c

   152	
   153	#else /* !CONFIG_SUSPEND */
   154	#define s2idle_wakeup		(false)
 > 155	static inline void acpi_s2idle_setup(void) {}
   156	#endif /* !CONFIG_SUSPEND */
   157	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

