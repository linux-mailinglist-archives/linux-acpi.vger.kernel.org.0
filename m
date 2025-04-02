Return-Path: <linux-acpi+bounces-12658-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9CEA794B2
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 19:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972BE189561A
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 17:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741F71A23AF;
	Wed,  2 Apr 2025 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GBIyRXs1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D5E1A2872;
	Wed,  2 Apr 2025 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743616532; cv=none; b=PZtJ6Zp2/sFypCOlC/T86FPux4SIc1Vnp0mGQxAYCq0Tga1yCa/9ObPecjoUbrE0Cok2Jt3ElJT8nnHT1tYNn8Jb7Fv877r3/mLeoUTVi++uQc47WnOTfgonWt11+XZJdj+CM5hkw/HfWBon1387UrmXAiDucWenEJRi42ekyRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743616532; c=relaxed/simple;
	bh=cjtVthk/zS9CxS/AwZacD+x7kSkLJhaQHoKjvYO1HlU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Y5TynogsxVZqgPq1OLKT3h2OdOU5fbnO9TxiAUeDPEfJjBt9VHGj6IX4/306z+W8k/DDlALcGelVINLEMV3t1l5usTRS0eMJbmHn5fsfNWPOY3kuVGiQ0PN8RLlgbwqzPb646ankYY0HkSIcskldpMrAC5cm/JCfaQTmRU5x5qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GBIyRXs1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743616530; x=1775152530;
  h=date:from:to:cc:subject:message-id;
  bh=cjtVthk/zS9CxS/AwZacD+x7kSkLJhaQHoKjvYO1HlU=;
  b=GBIyRXs1I0nKZvYYJx9Z+CMHfk5+4/fpndeNAR5OJ9wAXzxJmeqm0siO
   IynSrT2fruWOI6u4lOrIKKJmbhmQ0nZ2TXPSmTgomkC2Dj3ATwju9/lZ/
   +azB0/eREMquFCoxX48Ey1Ep6cm3eJgQ3fqPn03DFGWrhPHYGNLkR885t
   KUkpWdGjtjuhejaZKCemSUVOZrIwCR4fncPTY1QDZucy8jzDkgwlzNSCy
   +osCESPMiWP9p+b7rOFOqXXk7eiTrRTedSQp6MgnBHiLrqiuwZKNrtd16
   iHqjAdlm8WcnMyU8CKFROs3ximYI7T/jtd7lrxuqUs4S5q05GRWfU1A1M
   A==;
X-CSE-ConnectionGUID: 5nDuC6jsRx6q+UMwO05Nlg==
X-CSE-MsgGUID: gPN3CGLbR4WSwvXKUAmbcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="48664444"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="48664444"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 10:55:30 -0700
X-CSE-ConnectionGUID: Z1M/aSZmRdu6LKCv16hfBA==
X-CSE-MsgGUID: v8ePRMXDTQi9IsORRBNZcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="127034607"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 02 Apr 2025 10:55:27 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u02JB-000AwU-2C;
	Wed, 02 Apr 2025 17:55:25 +0000
Date: Thu, 03 Apr 2025 01:55:14 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 dff8015f508f9dead0122a6861e1cf0ef58fa3af
Message-ID: <202504030103.294FwEci-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: dff8015f508f9dead0122a6861e1cf0ef58fa3af  Merge branch 'pm-sleep-testing' into bleeding-edge

elapsed time: 1450m

configs tested: 128
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    gcc-14.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-14.2.0
arc                   randconfig-001-20250402    gcc-14.2.0
arc                   randconfig-002-20250402    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                       netwinder_defconfig    gcc-14.2.0
arm                   randconfig-001-20250402    clang-20
arm                   randconfig-002-20250402    clang-16
arm                   randconfig-003-20250402    clang-20
arm                   randconfig-004-20250402    clang-16
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250402    gcc-5.5.0
arm64                 randconfig-002-20250402    gcc-7.5.0
arm64                 randconfig-003-20250402    gcc-9.5.0
arm64                 randconfig-004-20250402    clang-17
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250402    gcc-9.3.0
csky                  randconfig-002-20250402    gcc-13.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250402    clang-21
hexagon               randconfig-002-20250402    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250402    gcc-12
i386        buildonly-randconfig-002-20250402    gcc-12
i386        buildonly-randconfig-003-20250402    gcc-12
i386        buildonly-randconfig-004-20250402    gcc-12
i386        buildonly-randconfig-005-20250402    gcc-11
i386        buildonly-randconfig-006-20250402    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20250402    gcc-14.2.0
loongarch             randconfig-002-20250402    gcc-14.2.0
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250402    gcc-7.5.0
nios2                 randconfig-002-20250402    gcc-13.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250402    gcc-14.2.0
parisc                randconfig-002-20250402    gcc-12.4.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                      pasemi_defconfig    clang-21
powerpc               randconfig-001-20250402    clang-21
powerpc               randconfig-002-20250402    gcc-9.3.0
powerpc               randconfig-003-20250402    clang-21
powerpc                     tqm8555_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250402    clang-21
powerpc64             randconfig-002-20250402    clang-21
powerpc64             randconfig-003-20250402    gcc-5.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250402    gcc-9.3.0
riscv                 randconfig-002-20250402    gcc-7.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250402    clang-15
s390                  randconfig-002-20250402    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250402    gcc-7.5.0
sh                    randconfig-002-20250402    gcc-7.5.0
sh                           se7206_defconfig    gcc-14.2.0
sh                           se7343_defconfig    gcc-14.2.0
sh                           se7780_defconfig    gcc-14.2.0
sh                             shx3_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250402    gcc-12.4.0
sparc                 randconfig-002-20250402    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250402    gcc-14.2.0
sparc64               randconfig-002-20250402    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250402    gcc-12
um                    randconfig-002-20250402    clang-21
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250402    clang-20
x86_64      buildonly-randconfig-002-20250402    gcc-12
x86_64      buildonly-randconfig-003-20250402    clang-20
x86_64      buildonly-randconfig-004-20250402    gcc-12
x86_64      buildonly-randconfig-005-20250402    clang-20
x86_64      buildonly-randconfig-006-20250402    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250402    gcc-8.5.0
xtensa                randconfig-002-20250402    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

