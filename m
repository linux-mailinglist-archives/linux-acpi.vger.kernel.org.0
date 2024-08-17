Return-Path: <linux-acpi+bounces-7637-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C6E955758
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Aug 2024 13:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1C91C20F52
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Aug 2024 11:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE01E14658B;
	Sat, 17 Aug 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="boko1Oi7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B8143C7D;
	Sat, 17 Aug 2024 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723892677; cv=none; b=XJDKOUqKsUnWK/7XQx4M1r2YGnO0o+yi23LLh33a7RcWVCncP9ZucbvrZu11EZjASJ1oWiVuSurVWCmc+2JX6JwBLBtt3QVphsIBo+J7rfc7M6EyA5WxEXqZ4PlUQ/cay6An7t5QXyFGY9T1APAy6Jz16zfUEEYhOgDH8Tsdnyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723892677; c=relaxed/simple;
	bh=D85qIgD8ZsDmnUv1LmUoHqsYUfCiHs/Cz1grAp+KTW8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YOvv0yf68UGzZu2zc5XPMW70ASlVQOxnIhvnPreZhewOyGQxSzQuI8SAqkKWFdAIIOIX6ZUaOaXv44lovvHxWWda8gOl9TA27PIZC2pUhdX29hdEaZZPj6O0QVU+49Sa2CJxHQsqn+nHw17Qz/7J13EVKqauDZnmEh4kZJJGjTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=boko1Oi7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723892676; x=1755428676;
  h=date:from:to:cc:subject:message-id;
  bh=D85qIgD8ZsDmnUv1LmUoHqsYUfCiHs/Cz1grAp+KTW8=;
  b=boko1Oi7uXLx/rryMkWIW4i6ahDJFrZYuWhCJDZUu9Ojkc0Qx+Y9gamJ
   lmz3oePWBr910XG20vOGDHGLKabgx4Q4q4WuVdIt31cqZvc3iOLGMPA97
   fnmzd5GjB79pc72lN4dGsmpy3t0gOHW6gdbdTPL7F5bXM5oPNR6zuNMYe
   pPbAHqhRa8SshuaW7T3BA5GPsYMY/WEZP/aU8HBkLyAiu+EaDWV1NlPoi
   mxYnmbnI1jOO9YpiSMp6D0V/m6oGULztRZsYX1OtzBWenc4hUeHAdycsG
   IfzDDi+QtGhSgLs4MEY4YaBWqx9GH5lyPaWLds4Hk308lKaulRhXLEX4y
   g==;
X-CSE-ConnectionGUID: D6s5/86PR++GkGafLTSKlw==
X-CSE-MsgGUID: xkykpulPTTue14nskmvyAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="21811999"
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="21811999"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 04:04:35 -0700
X-CSE-ConnectionGUID: 6ZxQk4PNQD2xvjgnWnqmjw==
X-CSE-MsgGUID: BEzpQe9nR5uq8W+vqqwuQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="59918487"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 17 Aug 2024 04:04:33 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfHEV-0007NW-1N;
	Sat, 17 Aug 2024 11:04:31 +0000
Date: Sat, 17 Aug 2024 19:04:20 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 413e2254b7a67f21e05791073f95ad41e0a54593
Message-ID: <202408171917.sr18nka7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 413e2254b7a67f21e05791073f95ad41e0a54593  Merge branch 'thermal-core-testing' into bleeding-edge

elapsed time: 1351m

configs tested: 75
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                      axs103_smp_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                              allyesconfig   gcc-14.1.0
arm                        realview_defconfig   clang-20
arm                           sama7_defconfig   clang-20
arm                       spear13xx_defconfig   gcc-14.1.0
arm                           stm32_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
hexagon                          allmodconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240817   gcc-12
i386         buildonly-randconfig-002-20240817   gcc-12
i386         buildonly-randconfig-003-20240817   clang-18
i386         buildonly-randconfig-004-20240817   gcc-12
i386         buildonly-randconfig-005-20240817   clang-18
i386         buildonly-randconfig-006-20240817   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240817   gcc-12
i386                  randconfig-002-20240817   gcc-12
i386                  randconfig-003-20240817   gcc-12
i386                  randconfig-004-20240817   clang-18
i386                  randconfig-005-20240817   gcc-12
i386                  randconfig-006-20240817   clang-18
i386                  randconfig-011-20240817   gcc-12
i386                  randconfig-012-20240817   clang-18
i386                  randconfig-013-20240817   gcc-12
i386                  randconfig-014-20240817   gcc-12
i386                  randconfig-015-20240817   gcc-12
i386                  randconfig-016-20240817   clang-18
loongarch                        allmodconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                generic-32bit_defconfig   gcc-14.1.0
parisc                generic-64bit_defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                        icon_defconfig   gcc-14.1.0
powerpc                 linkstation_defconfig   clang-20
powerpc                 mpc8313_rdb_defconfig   gcc-14.1.0
powerpc                      pcm030_defconfig   clang-20
powerpc                     tqm8540_defconfig   gcc-14.1.0
riscv                            alldefconfig   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                            shmin_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                  nommu_kc705_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

