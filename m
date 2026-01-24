Return-Path: <linux-acpi+bounces-20600-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBS0JsmPdGmw7AAAu9opvQ
	(envelope-from <linux-acpi+bounces-20600-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 10:24:25 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 059787D159
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 10:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DAE730097FF
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 09:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F16B1E2606;
	Sat, 24 Jan 2026 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBDnGTb7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519341C862F;
	Sat, 24 Jan 2026 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769246649; cv=none; b=r3kleO6ex43o8g32QOipFH7wCe1am1JtTzz5f9SX6l5SBuPKQjtYLjKtroXuB7YLdfULbJmVKAQk43928ULCiMCwgJkuvIV8SH9AzGYKgQv2Yg1+PcM8WCj44eDSntQTAnvJUJC8YCG+exmoVyZl2Dyi9xwoC3ZuNAfMlEWcA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769246649; c=relaxed/simple;
	bh=ASDKnlbk8KScQ5yRP/C+k2grZ3sx3wEelWW7OEWVvx8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=svcIoSjmNpBh2It3MpA7V56iykllRhY4Xup7rWkuBFzoIRUHldaRFcj8x7ZWVTh+k2E1IVGdy+ws2wRLSrTuvYrUW+psvNapbiV0S+tktWR5Z9tJ58H3+ME/sQSgJLLvU5eMO7YIqaVUZ6AnhUZw1ePTGBT3CpX+33g7nu9PFoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBDnGTb7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769246646; x=1800782646;
  h=date:from:to:cc:subject:message-id;
  bh=ASDKnlbk8KScQ5yRP/C+k2grZ3sx3wEelWW7OEWVvx8=;
  b=PBDnGTb7mSrv0UXmXLwUnupCYJ7aNiUQTteZKMMiJsAu04rFOLsK30OY
   CamMb/PJscdqtaZgxPsSBf6/07vcywGl64eDUKnAuW9foLegp9vfPdlLH
   FhwhttkoGmN5xf2KukO1QRJtKyEOyM3r93Yvj0udNTStvLl/KKTo7IH31
   RVTx80k42XZRnE13ZK4/Yu9rdh1TaL981PDCEfGMdQAOP+CXJJfOiI+Co
   wK4GfrDI50v4uJ27QT2ACbPGLj0DZ64/nRBXgy5hrv5SnFV1f3oUPUPFH
   39Hjx8kGOkIjCTJpZZZdAXe2MFWXWYLr5gVk9HjgfP56xV3L8s33a4sC7
   Q==;
X-CSE-ConnectionGUID: lSCOoZS8QJ+Fun2GsJ345w==
X-CSE-MsgGUID: SCnuvUN0TGGsBhhOXw3hGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="74346511"
X-IronPort-AV: E=Sophos;i="6.21,250,1763452800"; 
   d="scan'208";a="74346511"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2026 01:24:06 -0800
X-CSE-ConnectionGUID: ZmQrZOJcSCW9/cZuvFDS7A==
X-CSE-MsgGUID: rFJ6J0AUQH2s4gCxoPMy3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,250,1763452800"; 
   d="scan'208";a="207044794"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 24 Jan 2026 01:24:04 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjZs8-00000000V3O-2Zdw;
	Sat, 24 Jan 2026 09:24:00 +0000
Date: Sat, 24 Jan 2026 17:23:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 7e9b0371ed5b9bf9a80c59487f47fca0ba638f61
Message-ID: <202601241744.a4CSYSUl-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20600-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 059787D159
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 7e9b0371ed5b9bf9a80c59487f47fca0ba638f61  Merge branch 'thermal-intel' into bleeding-edge

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202601240833.jYdOreP4-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202601240853.XfwHlHep-lkp@intel.com

    drivers/cpufreq/cpufreq_ondemand.c:342:13: error: implicit declaration of function 'tick_nohz_is_active' [-Wimplicit-function-declaration]
    drivers/cpufreq/cpufreq_ondemand.c:342:6: error: call to undeclared function 'tick_nohz_is_active'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/cpufreq/cpufreq_ondemand.c:342:6: error: implicit declaration of function 'tick_nohz_is_active' [-Werror=implicit-function-declaration]
    drivers/cpufreq/cpufreq_ondemand.c:342:6: error: implicit declaration of function 'tick_nohz_is_active'; did you mean 'tick_nohz_idle_exit'? [-Werror=implicit-function-declaration]
    kernel/time/hrtimer.c:946:41: error: call to undeclared function 'tick_nohz_is_active'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    kernel/time/hrtimer.c:946:41: error: implicit declaration of function 'tick_nohz_is_active'; did you mean 'tick_nohz_init'? [-Werror=implicit-function-declaration]
    kernel/time/hrtimer.c:946:48: error: implicit declaration of function 'tick_nohz_is_active'; did you mean 'tick_nohz_init'? [-Werror=implicit-function-declaration]
    kernel/time/hrtimer.c:946:48: error: implicit declaration of function 'tick_nohz_is_active'; did you mean 'tick_nohz_init'? [-Wimplicit-function-declaration]
    kernel/time/hrtimer.c:954:41: error: call to undeclared function 'tick_nohz_is_active'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    kernel/time/hrtimer.c:954:41: error: implicit declaration of function 'tick_nohz_is_active'; did you mean 'tick_nohz_init'? [-Werror=implicit-function-declaration]
    kernel/time/hrtimer.c:954:48: error: implicit declaration of function 'tick_nohz_is_active'; did you mean 'tick_nohz_init'? [-Werror=implicit-function-declaration]
    kernel/time/hrtimer.c:954:48: error: implicit declaration of function 'tick_nohz_is_active'; did you mean 'tick_nohz_init'? [-Wimplicit-function-declaration]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- alpha-defconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- alpha-randconfig-r121-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- arc-alldefconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- arc-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- arc-nsim_700_defconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- arc-randconfig-001-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- arc-randconfig-r123-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- arm-allnoconfig
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- arm-s3c6400_defconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- arm-spear3xx_defconfig
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- arm64-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- arm64-randconfig-002-20260124
|   |-- drivers-cpufreq-cpufreq_ondemand.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- arm64-randconfig-003-20260124
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- arm64-randconfig-004-20260124
|   |-- drivers-cpufreq-cpufreq_ondemand.c:error:implicit-declaration-of-function-tick_nohz_is_active
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- csky-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- csky-randconfig-002-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- hexagon-allnoconfig
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- hexagon-defconfig
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- hexagon-randconfig-001-20260124
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- hexagon-randconfig-r064-20260124
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- hexagon-randconfig-r073-20260124
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- hexagon-randconfig-r113-20260124
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- i386-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- i386-buildonly-randconfig-001-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- i386-buildonly-randconfig-003-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- i386-buildonly-randconfig-004-20260124
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- i386-randconfig-001-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- i386-randconfig-003-20260124
|   |-- drivers-cpufreq-cpufreq_ondemand.c:error:implicit-declaration-of-function-tick_nohz_is_active
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- i386-randconfig-005-20260124
|   |-- drivers-cpufreq-cpufreq_ondemand.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- i386-randconfig-006-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- i386-randconfig-012-20260124
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- i386-randconfig-013-20260124
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- i386-randconfig-016-20260124
|   |-- drivers-cpufreq-cpufreq_ondemand.c:error:implicit-declaration-of-function-tick_nohz_is_active
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- i386-randconfig-017-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- i386-randconfig-063-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- i386-randconfig-141-20260124
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- i386-randconfig-r062-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- loongarch-allnoconfig
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- loongarch-randconfig-001-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- loongarch-randconfig-002-20260124
|   |-- drivers-cpufreq-cpufreq_ondemand.c:error:implicit-declaration-of-function-tick_nohz_is_active
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- loongarch-randconfig-r054-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- loongarch-randconfig-r072-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- m68k-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- m68k-defconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- m68k-randconfig-r052-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- microblaze-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- microblaze-defconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- mips-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- mips-randconfig-r053-20260124
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- mips-randconfig-r073-20260124
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- mips-randconfig-r131-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- nios2-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- nios2-randconfig-002-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- openrisc-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- parisc-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- parisc-defconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- parisc-randconfig-002-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- parisc64-defconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- powerpc-akebono_defconfig
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- powerpc-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- powerpc-ppa8548_defconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- powerpc64-randconfig-r133-20260124
|   |-- drivers-cpufreq-cpufreq_ondemand.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- riscv-alldefconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- riscv-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- riscv-nommu_k210_sdcard_defconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- riscv-randconfig-001-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- riscv-randconfig-r064-20260124
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- s390-allnoconfig
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- s390-randconfig-001-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- s390-randconfig-002-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- sh-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- sh-randconfig-001-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- sh-randconfig-002-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- sh-randconfig-r132-20260124
|   |-- drivers-cpufreq-cpufreq_ondemand.c:error:implicit-declaration-of-function-tick_nohz_is_active
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- sparc-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- sparc-defconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- sparc-randconfig-001-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- sparc64-randconfig-002-20260124
|   |-- drivers-cpufreq-cpufreq_ondemand.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- sparc64-randconfig-r061-20260124
|   |-- drivers-cpufreq-cpufreq_ondemand.c:error:implicit-declaration-of-function-tick_nohz_is_active
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- sparc64-randconfig-r134-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- um-allnoconfig
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- um-randconfig-002-20260124
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-allnoconfig
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-buildonly-randconfig-001-20260124
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-buildonly-randconfig-003-20260124
|   |-- drivers-cpufreq-cpufreq_ondemand.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-buildonly-randconfig-005-20260124
|   |-- drivers-cpufreq-cpufreq_ondemand.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-buildonly-randconfig-006-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- x86_64-randconfig-001-20260124
|   |-- drivers-cpufreq-cpufreq_ondemand.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-randconfig-003-20260124
|   |-- drivers-cpufreq-cpufreq_ondemand.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-randconfig-013-20260124
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-randconfig-014-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- x86_64-randconfig-015-20260124
|   |-- drivers-cpufreq-cpufreq_ondemand.c:error:implicit-declaration-of-function-tick_nohz_is_active
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- x86_64-randconfig-072-20260124
|   |-- drivers-cpufreq-cpufreq_ondemand.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-randconfig-075-20260124
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-randconfig-101-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- x86_64-randconfig-121-20260124
|   |-- drivers-cpufreq-cpufreq_ondemand.c:error:implicit-declaration-of-function-tick_nohz_is_active
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- x86_64-randconfig-123-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- x86_64-randconfig-r072-20260124
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- xtensa-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
`-- xtensa-randconfig-001-20260124
    `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active

elapsed time: 737m

configs tested: 195
configs skipped: 3

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    clang-17
arc                   randconfig-001-20260124    clang-18
arc                   randconfig-002-20260124    clang-18
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                       imx_v4_v5_defconfig    gcc-15.2.0
arm                   randconfig-001-20260124    clang-18
arm                   randconfig-002-20260124    clang-18
arm                   randconfig-003-20260124    clang-18
arm                   randconfig-004-20260124    clang-18
arm                        spear3xx_defconfig    clang-17
arm                       versatile_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260124    gcc-15.2.0
arm64                 randconfig-002-20260124    gcc-15.2.0
arm64                 randconfig-003-20260124    gcc-15.2.0
arm64                 randconfig-004-20260124    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260124    gcc-15.2.0
csky                  randconfig-002-20260124    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260124    gcc-15.2.0
hexagon               randconfig-002-20260124    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260124    gcc-14
i386        buildonly-randconfig-002-20260124    gcc-14
i386        buildonly-randconfig-003-20260124    gcc-14
i386        buildonly-randconfig-004-20260124    gcc-14
i386        buildonly-randconfig-005-20260124    gcc-14
i386        buildonly-randconfig-006-20260124    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260124    gcc-14
i386                  randconfig-002-20260124    gcc-14
i386                  randconfig-003-20260124    gcc-14
i386                  randconfig-004-20260124    gcc-14
i386                  randconfig-005-20260124    gcc-14
i386                  randconfig-006-20260124    gcc-14
i386                  randconfig-007-20260124    gcc-14
i386                  randconfig-011-20260124    clang-20
i386                  randconfig-012-20260124    clang-20
i386                  randconfig-013-20260124    clang-20
i386                  randconfig-014-20260124    clang-20
i386                  randconfig-015-20260124    clang-20
i386                  randconfig-016-20260124    clang-20
i386                  randconfig-017-20260124    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260124    gcc-15.2.0
loongarch             randconfig-002-20260124    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  maltasmvp_eva_defconfig    gcc-15.2.0
mips                        maltaup_defconfig    gcc-15.2.0
mips                    maltaup_xpa_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260124    gcc-15.2.0
nios2                 randconfig-002-20260124    gcc-15.2.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260124    gcc-8.5.0
parisc                randconfig-002-20260124    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                     akebono_defconfig    clang-17
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     ppa8548_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260124    gcc-8.5.0
powerpc               randconfig-002-20260124    gcc-8.5.0
powerpc                     redwood_defconfig    clang-17
powerpc64             randconfig-001-20260124    gcc-8.5.0
powerpc64             randconfig-002-20260124    gcc-8.5.0
riscv                            alldefconfig    clang-17
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv             nommu_k210_sdcard_defconfig    clang-17
riscv                 randconfig-001-20260124    gcc-8.5.0
riscv                 randconfig-002-20260124    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260124    gcc-8.5.0
s390                  randconfig-002-20260124    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260124    gcc-8.5.0
sh                    randconfig-002-20260124    gcc-8.5.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260124    gcc-13.4.0
sparc                 randconfig-002-20260124    gcc-13.4.0
sparc                       sparc64_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260124    gcc-13.4.0
sparc64               randconfig-002-20260124    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260124    gcc-13.4.0
um                    randconfig-002-20260124    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260124    clang-20
x86_64      buildonly-randconfig-002-20260124    clang-20
x86_64      buildonly-randconfig-003-20260124    clang-20
x86_64      buildonly-randconfig-004-20260124    clang-20
x86_64      buildonly-randconfig-005-20260124    clang-20
x86_64      buildonly-randconfig-006-20260124    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260124    gcc-13
x86_64                randconfig-002-20260124    gcc-13
x86_64                randconfig-003-20260124    gcc-13
x86_64                randconfig-004-20260124    gcc-13
x86_64                randconfig-005-20260124    gcc-13
x86_64                randconfig-006-20260124    gcc-13
x86_64                randconfig-011-20260124    gcc-12
x86_64                randconfig-012-20260124    gcc-12
x86_64                randconfig-013-20260124    gcc-12
x86_64                randconfig-014-20260124    gcc-12
x86_64                randconfig-015-20260124    gcc-12
x86_64                randconfig-016-20260124    gcc-12
x86_64                randconfig-071-20260124    gcc-14
x86_64                randconfig-072-20260124    gcc-14
x86_64                randconfig-073-20260124    gcc-14
x86_64                randconfig-074-20260124    gcc-14
x86_64                randconfig-075-20260124    gcc-14
x86_64                randconfig-076-20260124    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260124    gcc-13.4.0
xtensa                randconfig-002-20260124    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

