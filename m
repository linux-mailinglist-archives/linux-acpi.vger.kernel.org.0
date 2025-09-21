Return-Path: <linux-acpi+bounces-17156-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CB4B8DA24
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Sep 2025 13:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7241A3BE9C0
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Sep 2025 11:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB3F269CE6;
	Sun, 21 Sep 2025 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CbiR+LpU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956E925F797;
	Sun, 21 Sep 2025 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758454063; cv=none; b=Y42v7TSclgGkOrr0/oy93gKK4tVTS84NNWtBpPuSqA61yEyVd1uxGi1bMxf7oT7u4CqTPG/J30vPXnmSHokdtVc0FWaVCa3HbKTLJBVJCXI4z4ny1o/stBRhb0ILqu5GTYUdunm9beNSWIT8TbXd3b69V4Rf7E0LfBmTHUsv6JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758454063; c=relaxed/simple;
	bh=iFF4Ys5NzRQQaHMml5utHRzJcMl6tZw8CSQHY8I8h1s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ukqDgwaX9g2CfaC1dla83vbwQYHj1VGVOuYMutAUIzcNvY1fnJuVWJQ3RglfW33tLS1jNARurS9kSYmIMuLmqaGSOpNHT/nHdlYvYzAZlBrisQ0vlQnmZ9Da3NvYc4sssb3X8aZ03ypdSOyKeN/7RnObrZtSa2QbgAle80HjEc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CbiR+LpU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758454060; x=1789990060;
  h=date:from:to:cc:subject:message-id;
  bh=iFF4Ys5NzRQQaHMml5utHRzJcMl6tZw8CSQHY8I8h1s=;
  b=CbiR+LpUU2hmcuH+rgGDFnIbwiRCz0UB1XW4nJDDlcXXGP95L9oCNBNq
   Ikc2g28DhvPRxTuXb8B9OCOtG39v+NBfHE8cd8S7fojeGMfkP2IrOE/PD
   YOQ1amGh0gs5+wF8b4IIsOnXgt9LYfUzwBImIv8p2DnAVeInxSYnUXvty
   YlZqqLxcVyqhtk2u1tIBilx89f0c5ACLCPW9emveA9tGLmfRIC8JubwyN
   fEHSQmjc0OEXU1RqoSmCnDsGsT04VBNA6gX670xM5dwjhrLQXBGmana7k
   ggNYMq90+IJSlS+Q9V8aqqcahIElViGmJvmrGd8s1b9z+jhP/TcolwWde
   Q==;
X-CSE-ConnectionGUID: g84qdTVWTYqt6+Hjy2ow9g==
X-CSE-MsgGUID: p3a8vSoxTsuGpEjlpiQgwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11559"; a="71366004"
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="71366004"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 04:27:40 -0700
X-CSE-ConnectionGUID: W31S58QHQxaTA6jfnre5Ag==
X-CSE-MsgGUID: ZWLovY5iQ1GDLmzHyHAIHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="177050977"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2025 04:27:38 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0IEC-0000gd-2L;
	Sun, 21 Sep 2025 11:27:36 +0000
Date: Sun, 21 Sep 2025 19:27:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 8ffe28b4e8d8b18cb2f2933410322c24f039d5d6
Message-ID: <202509211958.1qlGCp29-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 8ffe28b4e8d8b18cb2f2933410322c24f039d5d6  cpufreq: Initialize cpufreq-based invariance before subsys

elapsed time: 1447m

configs tested: 258
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                     haps_hs_smp_defconfig    clang-22
arc                            hsdk_defconfig    clang-22
arc                   randconfig-001-20250920    gcc-9.5.0
arc                   randconfig-001-20250921    gcc-14.3.0
arc                   randconfig-002-20250920    gcc-9.5.0
arc                   randconfig-002-20250921    gcc-14.3.0
arm                               allnoconfig    clang-22
arm                        clps711x_defconfig    clang-22
arm                                 defconfig    clang-19
arm                          gemini_defconfig    clang-22
arm                      integrator_defconfig    clang-18
arm                        multi_v5_defconfig    clang-18
arm                   randconfig-001-20250920    gcc-12.5.0
arm                   randconfig-001-20250921    gcc-14.3.0
arm                   randconfig-002-20250920    clang-22
arm                   randconfig-002-20250921    gcc-14.3.0
arm                   randconfig-003-20250920    clang-22
arm                   randconfig-003-20250921    gcc-14.3.0
arm                   randconfig-004-20250920    clang-22
arm                   randconfig-004-20250921    gcc-14.3.0
arm                         s3c6400_defconfig    clang-22
arm                          sp7021_defconfig    clang-18
arm                        vexpress_defconfig    clang-18
arm64                            alldefconfig    gcc-15.1.0
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250920    clang-20
arm64                 randconfig-001-20250921    gcc-14.3.0
arm64                 randconfig-002-20250920    clang-22
arm64                 randconfig-002-20250921    gcc-14.3.0
arm64                 randconfig-003-20250920    clang-18
arm64                 randconfig-003-20250921    gcc-14.3.0
arm64                 randconfig-004-20250920    clang-22
arm64                 randconfig-004-20250921    gcc-14.3.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250920    gcc-10.5.0
csky                  randconfig-001-20250921    clang-22
csky                  randconfig-002-20250920    gcc-15.1.0
csky                  randconfig-002-20250921    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250920    clang-22
hexagon               randconfig-001-20250921    clang-22
hexagon               randconfig-002-20250920    clang-22
hexagon               randconfig-002-20250921    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250920    clang-20
i386        buildonly-randconfig-001-20250921    gcc-14
i386        buildonly-randconfig-002-20250920    clang-20
i386        buildonly-randconfig-002-20250921    gcc-14
i386        buildonly-randconfig-003-20250920    clang-20
i386        buildonly-randconfig-003-20250921    gcc-14
i386        buildonly-randconfig-004-20250920    gcc-13
i386        buildonly-randconfig-004-20250921    gcc-14
i386        buildonly-randconfig-005-20250920    clang-20
i386        buildonly-randconfig-005-20250921    gcc-14
i386        buildonly-randconfig-006-20250920    clang-20
i386        buildonly-randconfig-006-20250921    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250921    gcc-14
i386                  randconfig-002-20250921    gcc-14
i386                  randconfig-003-20250921    gcc-14
i386                  randconfig-004-20250921    gcc-14
i386                  randconfig-005-20250921    gcc-14
i386                  randconfig-006-20250921    gcc-14
i386                  randconfig-007-20250921    gcc-14
i386                  randconfig-011-20250921    clang-20
i386                  randconfig-012-20250921    clang-20
i386                  randconfig-013-20250921    clang-20
i386                  randconfig-014-20250921    clang-20
i386                  randconfig-015-20250921    clang-20
i386                  randconfig-016-20250921    clang-20
i386                  randconfig-017-20250921    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250920    clang-22
loongarch             randconfig-001-20250921    clang-22
loongarch             randconfig-002-20250920    gcc-12.5.0
loongarch             randconfig-002-20250921    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                        m5272c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip27_defconfig    gcc-15.1.0
mips                          rb532_defconfig    clang-18
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250920    gcc-9.5.0
nios2                 randconfig-001-20250921    clang-22
nios2                 randconfig-002-20250920    gcc-11.5.0
nios2                 randconfig-002-20250921    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250920    gcc-8.5.0
parisc                randconfig-001-20250921    clang-22
parisc                randconfig-002-20250920    gcc-11.5.0
parisc                randconfig-002-20250921    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      cm5200_defconfig    clang-22
powerpc                    ge_imp3a_defconfig    clang-22
powerpc                 mpc8315_rdb_defconfig    clang-18
powerpc               randconfig-001-20250920    clang-17
powerpc               randconfig-001-20250921    clang-22
powerpc               randconfig-002-20250920    clang-22
powerpc               randconfig-002-20250921    clang-22
powerpc               randconfig-003-20250920    clang-22
powerpc               randconfig-003-20250921    clang-22
powerpc                     tqm8548_defconfig    clang-22
powerpc64             randconfig-001-20250920    clang-16
powerpc64             randconfig-002-20250920    gcc-10.5.0
powerpc64             randconfig-002-20250921    clang-22
powerpc64             randconfig-003-20250920    gcc-10.5.0
powerpc64             randconfig-003-20250921    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250920    clang-22
riscv                 randconfig-001-20250921    gcc-8.5.0
riscv                 randconfig-002-20250920    clang-22
riscv                 randconfig-002-20250921    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250920    clang-20
s390                  randconfig-001-20250921    gcc-8.5.0
s390                  randconfig-002-20250920    gcc-8.5.0
s390                  randconfig-002-20250921    gcc-8.5.0
sh                               alldefconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    clang-18
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250920    gcc-14.3.0
sh                    randconfig-001-20250921    gcc-8.5.0
sh                    randconfig-002-20250920    gcc-12.5.0
sh                    randconfig-002-20250921    gcc-8.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250920    gcc-8.5.0
sparc                 randconfig-001-20250921    gcc-8.5.0
sparc                 randconfig-002-20250920    gcc-14.3.0
sparc                 randconfig-002-20250921    gcc-8.5.0
sparc                       sparc32_defconfig    clang-18
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250920    gcc-8.5.0
sparc64               randconfig-001-20250921    gcc-8.5.0
sparc64               randconfig-002-20250920    gcc-8.5.0
sparc64               randconfig-002-20250921    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250920    clang-22
um                    randconfig-001-20250921    gcc-8.5.0
um                    randconfig-002-20250920    clang-22
um                    randconfig-002-20250921    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250920    clang-20
x86_64      buildonly-randconfig-001-20250921    clang-20
x86_64      buildonly-randconfig-002-20250920    clang-20
x86_64      buildonly-randconfig-002-20250921    clang-20
x86_64      buildonly-randconfig-003-20250920    clang-20
x86_64      buildonly-randconfig-003-20250921    clang-20
x86_64      buildonly-randconfig-004-20250920    clang-20
x86_64      buildonly-randconfig-004-20250921    clang-20
x86_64      buildonly-randconfig-005-20250920    gcc-14
x86_64      buildonly-randconfig-005-20250921    clang-20
x86_64      buildonly-randconfig-006-20250920    gcc-14
x86_64      buildonly-randconfig-006-20250921    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250921    gcc-14
x86_64                randconfig-002-20250921    gcc-14
x86_64                randconfig-003-20250921    gcc-14
x86_64                randconfig-004-20250921    gcc-14
x86_64                randconfig-005-20250921    gcc-14
x86_64                randconfig-006-20250921    gcc-14
x86_64                randconfig-007-20250921    gcc-14
x86_64                randconfig-008-20250921    gcc-14
x86_64                randconfig-071-20250921    gcc-14
x86_64                randconfig-072-20250921    gcc-14
x86_64                randconfig-073-20250921    gcc-14
x86_64                randconfig-074-20250921    gcc-14
x86_64                randconfig-075-20250921    gcc-14
x86_64                randconfig-076-20250921    gcc-14
x86_64                randconfig-077-20250921    gcc-14
x86_64                randconfig-078-20250921    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250920    gcc-8.5.0
xtensa                randconfig-001-20250921    gcc-8.5.0
xtensa                randconfig-002-20250920    gcc-8.5.0
xtensa                randconfig-002-20250921    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

