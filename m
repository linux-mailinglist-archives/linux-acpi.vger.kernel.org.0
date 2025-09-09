Return-Path: <linux-acpi+bounces-16538-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2CDB50076
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 17:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E1E169E64
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 15:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1093034F465;
	Tue,  9 Sep 2025 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mEctLG7D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CDB4A07;
	Tue,  9 Sep 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430018; cv=none; b=iU7onu0KFfAO1OTVqdW/aet0Av4hhRRO4SdXPQ9GBm/IrvikrL/yg7aL8CihKA1eUFRoaAr6mqC2Gl/jupJjw3dpXOd8t/tlTg7LCn0oDQyRLTEJg+k4lbOa6QR2X/FfLeZ7uyRmR15aGbcBpt6q1Bxxl8gV8Z88quvcVwQOMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430018; c=relaxed/simple;
	bh=G0x+V5e2lHqJyNmCDGLDy37bwcMGuxUidlYEXXrz6WI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kcxB9Zxh8ofMUW/JApBzwzzbbmNjOSBQJ+upzyLqNIqQ2VMvzaGTK794k71ScBY9F2UNkbP2v5H05IuWFz7FRjQjt9j2ocbaZ9qo7ru6snOYLiE8j3rpTkASQ/Pt1LvJVradbfAKXnOIuumSnaSTvBtB3k7QNlHzzUYScbOUiNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mEctLG7D; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757430017; x=1788966017;
  h=date:from:to:cc:subject:message-id;
  bh=G0x+V5e2lHqJyNmCDGLDy37bwcMGuxUidlYEXXrz6WI=;
  b=mEctLG7D1x7uqyfUmskRtCSmZg3ZydW0T0xssGEzOLtZIhZUeSx5ezfn
   bN/9OQBWiXIalVbiAlSiVKjM2SzCje5Vrpg4XreomWiiLu7EYPkwjN8yy
   RNeeiV/TwwdnVPzoGFWXGIb5uaf9LXRhrgPsQkc1MwkD3OEsAy0rbnpD0
   gFDMG3AM5WZvrhfPnNm3OxktNoKQoSS6dZGdoDVYjsAJpILb8QjA2gpH1
   BLR/GxVOiyChPIpMqfrRHCz5pDpjqLFzWd5Ocqb4i7gZXjVNMYW55hcaJ
   rPZH7wEg9eL5vmTE33VdrvRVropTFDAUF9G/QnVn7Bz5ymhSF3rBv2ikJ
   A==;
X-CSE-ConnectionGUID: F46jVXaMSQmxvBKOEPa2ng==
X-CSE-MsgGUID: KrHWYd3rSLOUy7WhnSPhug==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="69972268"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="69972268"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 08:00:15 -0700
X-CSE-ConnectionGUID: mYV+F43VTZ2byRVzzjZO0Q==
X-CSE-MsgGUID: lvtg9cNgTBaeLU4n3mPQzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="178316001"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 09 Sep 2025 08:00:13 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvzpK-0004xv-2B;
	Tue, 09 Sep 2025 15:00:10 +0000
Date: Tue, 09 Sep 2025 22:59:22 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 d326fb951ff75aa279a738b69883a2688d4b5edf
Message-ID: <202509092211.Ew0mM3eC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: d326fb951ff75aa279a738b69883a2688d4b5edf  Merge branch 'pm-cpufreq-amd' into fixes

elapsed time: 1392m

configs tested: 243
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
alpha                               defconfig    gcc-14
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250909    clang-16
arc                   randconfig-001-20250909    gcc-8.5.0
arc                   randconfig-002-20250909    clang-16
arc                   randconfig-002-20250909    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                        multi_v7_defconfig    clang-22
arm                             mxs_defconfig    clang-22
arm                       netwinder_defconfig    clang-22
arm                   randconfig-001-20250909    clang-16
arm                   randconfig-001-20250909    clang-18
arm                   randconfig-002-20250909    clang-16
arm                   randconfig-002-20250909    clang-17
arm                   randconfig-003-20250909    clang-16
arm                   randconfig-003-20250909    clang-22
arm                   randconfig-004-20250909    clang-16
arm                   randconfig-004-20250909    clang-19
arm                         s3c6400_defconfig    gcc-14
arm                       versatile_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250909    clang-16
arm64                 randconfig-002-20250909    clang-16
arm64                 randconfig-002-20250909    gcc-11.5.0
arm64                 randconfig-003-20250909    clang-16
arm64                 randconfig-003-20250909    gcc-11.5.0
arm64                 randconfig-004-20250909    clang-16
arm64                 randconfig-004-20250909    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250909    gcc-15.1.0
csky                  randconfig-001-20250909    gcc-8.5.0
csky                  randconfig-002-20250909    gcc-15.1.0
csky                  randconfig-002-20250909    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250909    clang-22
hexagon               randconfig-001-20250909    gcc-8.5.0
hexagon               randconfig-002-20250909    clang-22
hexagon               randconfig-002-20250909    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250909    clang-20
i386        buildonly-randconfig-001-20250909    gcc-13
i386        buildonly-randconfig-001-20250910    clang-20
i386        buildonly-randconfig-002-20250909    clang-20
i386        buildonly-randconfig-002-20250910    clang-20
i386        buildonly-randconfig-003-20250909    clang-20
i386        buildonly-randconfig-003-20250910    clang-20
i386        buildonly-randconfig-004-20250909    clang-20
i386        buildonly-randconfig-004-20250910    clang-20
i386        buildonly-randconfig-005-20250909    clang-20
i386        buildonly-randconfig-005-20250910    clang-20
i386        buildonly-randconfig-006-20250909    clang-20
i386        buildonly-randconfig-006-20250910    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250909    clang-20
i386                  randconfig-002-20250909    clang-20
i386                  randconfig-003-20250909    clang-20
i386                  randconfig-004-20250909    clang-20
i386                  randconfig-005-20250909    clang-20
i386                  randconfig-006-20250909    clang-20
i386                  randconfig-007-20250909    clang-20
i386                  randconfig-011-20250909    gcc-14
i386                  randconfig-012-20250909    gcc-14
i386                  randconfig-013-20250909    gcc-14
i386                  randconfig-014-20250909    gcc-14
i386                  randconfig-015-20250909    gcc-14
i386                  randconfig-016-20250909    gcc-14
i386                  randconfig-017-20250909    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250909    gcc-15.1.0
loongarch             randconfig-001-20250909    gcc-8.5.0
loongarch             randconfig-002-20250909    gcc-15.1.0
loongarch             randconfig-002-20250909    gcc-8.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250909    gcc-11.5.0
nios2                 randconfig-001-20250909    gcc-8.5.0
nios2                 randconfig-002-20250909    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250909    gcc-8.5.0
parisc                randconfig-002-20250909    gcc-12.5.0
parisc                randconfig-002-20250909    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     ep8248e_defconfig    gcc-14
powerpc                  mpc885_ads_defconfig    clang-22
powerpc                      pasemi_defconfig    clang-22
powerpc               randconfig-001-20250909    clang-22
powerpc               randconfig-001-20250909    gcc-8.5.0
powerpc               randconfig-002-20250909    clang-17
powerpc               randconfig-002-20250909    gcc-8.5.0
powerpc               randconfig-003-20250909    gcc-8.5.0
powerpc                     taishan_defconfig    gcc-14
powerpc64             randconfig-001-20250909    clang-20
powerpc64             randconfig-001-20250909    gcc-8.5.0
powerpc64             randconfig-002-20250909    gcc-10.5.0
powerpc64             randconfig-002-20250909    gcc-8.5.0
powerpc64             randconfig-003-20250909    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250909    clang-22
riscv                 randconfig-001-20250909    gcc-15.1.0
riscv                 randconfig-002-20250909    clang-22
riscv                 randconfig-002-20250909    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250909    gcc-11.5.0
s390                  randconfig-001-20250909    gcc-15.1.0
s390                  randconfig-002-20250909    clang-18
s390                  randconfig-002-20250909    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250909    gcc-15.1.0
sh                    randconfig-002-20250909    gcc-15.1.0
sh                    randconfig-002-20250909    gcc-9.5.0
sh                   secureedge5410_defconfig    gcc-14
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250909    gcc-15.1.0
sparc                 randconfig-001-20250909    gcc-8.5.0
sparc                 randconfig-002-20250909    gcc-15.1.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250909    clang-22
sparc64               randconfig-001-20250909    gcc-15.1.0
sparc64               randconfig-002-20250909    gcc-15.1.0
sparc64               randconfig-002-20250909    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250909    gcc-14
um                    randconfig-001-20250909    gcc-15.1.0
um                    randconfig-002-20250909    gcc-14
um                    randconfig-002-20250909    gcc-15.1.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250909    clang-20
x86_64      buildonly-randconfig-001-20250909    gcc-14
x86_64      buildonly-randconfig-002-20250909    clang-20
x86_64      buildonly-randconfig-002-20250909    gcc-14
x86_64      buildonly-randconfig-003-20250909    gcc-14
x86_64      buildonly-randconfig-004-20250909    clang-20
x86_64      buildonly-randconfig-004-20250909    gcc-14
x86_64      buildonly-randconfig-005-20250909    gcc-14
x86_64      buildonly-randconfig-006-20250909    clang-20
x86_64      buildonly-randconfig-006-20250909    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250909    gcc-14
x86_64                randconfig-002-20250909    gcc-14
x86_64                randconfig-003-20250909    gcc-14
x86_64                randconfig-004-20250909    gcc-14
x86_64                randconfig-005-20250909    gcc-14
x86_64                randconfig-006-20250909    gcc-14
x86_64                randconfig-007-20250909    gcc-14
x86_64                randconfig-008-20250909    gcc-14
x86_64                randconfig-071-20250909    gcc-14
x86_64                randconfig-072-20250909    gcc-14
x86_64                randconfig-073-20250909    gcc-14
x86_64                randconfig-074-20250909    gcc-14
x86_64                randconfig-075-20250909    gcc-14
x86_64                randconfig-076-20250909    gcc-14
x86_64                randconfig-077-20250909    gcc-14
x86_64                randconfig-078-20250909    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250909    gcc-15.1.0
xtensa                randconfig-001-20250909    gcc-8.5.0
xtensa                randconfig-002-20250909    gcc-15.1.0
xtensa                    smp_lx200_defconfig    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

