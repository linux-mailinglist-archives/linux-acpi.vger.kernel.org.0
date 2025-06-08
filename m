Return-Path: <linux-acpi+bounces-14216-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8154CAD10B8
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 03:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F55C3AD3F0
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 01:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE3833993;
	Sun,  8 Jun 2025 01:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+LwOubK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261942AD11;
	Sun,  8 Jun 2025 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749346741; cv=none; b=gHXSHdXNmhUs6ZAoP0UAbRTxecZHPrVqGsM0L2urVDixqmvDMwPUkZoCJxP2gDYGvM9GHk3bGHJQHzwWbD7KgdAnBLOav5a7nX7gIRrKPgsiIiLWpWfZfMoy1U8tVS9Wwf9Bvh8jFROfJCRWEVburuExer81bnRKsJQ4hWDlpyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749346741; c=relaxed/simple;
	bh=HZFfOau8vVIPLRfak+UeT7qymPdFQ2Uyg7taGLjZCiM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RtGsEY0Yr9306qbKH5X4ydQFrpf3nUu5ZhT8/E2ZKzRkkRw3FPYr+BdwSi+JaJNcDd+2BCkHTDm7xYMegPjdQE8IB1o6XOtjBZYK9vNbojke1/M88NTPBWsAhhB1sfHXuiNWGNjAO9f1bX93CIjkRyRW05ZIyJoAUCYJPa4mXdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+LwOubK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749346739; x=1780882739;
  h=date:from:to:cc:subject:message-id;
  bh=HZFfOau8vVIPLRfak+UeT7qymPdFQ2Uyg7taGLjZCiM=;
  b=k+LwOubKEEbJpcoTWb0/Miedstw2b9MPIyzBpZwqga7BkQRy2KDmtaTR
   xBo7iGo6QxkBJWNiltwp90+Ed8zICecJCzSYtqcGLxxNjK8cCxDP/Ol0h
   Yz/G3o832WauAZroLoH0ABoIv5lTRvq/vSVDvaSawMl+gyC00ja173jdo
   KhquWZmJPkW3zylvHAo6cQn67MlbMKx4olNeDFBl/aFFmBcTf9nyR9XhB
   GmWtnkYvJ8dAWdGcf4ku9OXCbK1tvI7kP7We1jT3tgKY/EkYVNIq52dMa
   j87e7JEUZoL12fdYY6JSvjWV4pdsHJ+qVZrN7LDf4giGG6HL48gRi19QU
   Q==;
X-CSE-ConnectionGUID: govHS8v3SQS9dxuHiERoXg==
X-CSE-MsgGUID: 7w585bZMRjy/FBwTRN1ulQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11457"; a="54090581"
X-IronPort-AV: E=Sophos;i="6.16,219,1744095600"; 
   d="scan'208";a="54090581"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2025 18:38:58 -0700
X-CSE-ConnectionGUID: ugIgPQ4rSp6D7nHBAF7b7Q==
X-CSE-MsgGUID: aPGRgPZ+StyV7Wf8xHZxMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,219,1744095600"; 
   d="scan'208";a="146069705"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 07 Jun 2025 18:38:57 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uO4zu-00067l-1V;
	Sun, 08 Jun 2025 01:38:54 +0000
Date: Sun, 08 Jun 2025 09:38:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 013a27aa0893a6f58cc1edeb46fbfb5380ce2098
Message-ID: <202506080916.m7LuEZF2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 013a27aa0893a6f58cc1edeb46fbfb5380ce2098  Merge branch 'pm-cpuidle' into bleeding-edge

elapsed time: 726m

configs tested: 244
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250607    gcc-15.1.0
arc                   randconfig-002-20250607    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                            dove_defconfig    gcc-15.1.0
arm                       imx_v4_v5_defconfig    clang-21
arm                        keystone_defconfig    gcc-15.1.0
arm                       multi_v4t_defconfig    gcc-15.1.0
arm                   randconfig-001-20250607    clang-21
arm                   randconfig-002-20250607    gcc-13.3.0
arm                   randconfig-003-20250607    gcc-15.1.0
arm                   randconfig-004-20250607    gcc-14.3.0
arm                        realview_defconfig    gcc-15.1.0
arm                       versatile_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250607    clang-21
arm64                 randconfig-002-20250607    clang-21
arm64                 randconfig-003-20250607    clang-21
arm64                 randconfig-004-20250607    clang-21
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250607    gcc-12.4.0
csky                  randconfig-001-20250608    gcc-8.5.0
csky                  randconfig-002-20250607    gcc-9.3.0
csky                  randconfig-002-20250608    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250607    clang-21
hexagon               randconfig-001-20250608    gcc-8.5.0
hexagon               randconfig-002-20250607    clang-21
hexagon               randconfig-002-20250608    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250607    clang-20
i386        buildonly-randconfig-002-20250607    gcc-12
i386        buildonly-randconfig-003-20250607    gcc-12
i386        buildonly-randconfig-004-20250607    gcc-12
i386        buildonly-randconfig-005-20250607    clang-20
i386        buildonly-randconfig-006-20250607    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250608    gcc-12
i386                  randconfig-002-20250608    gcc-12
i386                  randconfig-003-20250608    gcc-12
i386                  randconfig-004-20250608    gcc-12
i386                  randconfig-005-20250608    gcc-12
i386                  randconfig-006-20250608    gcc-12
i386                  randconfig-007-20250608    gcc-12
i386                  randconfig-011-20250608    clang-20
i386                  randconfig-012-20250608    clang-20
i386                  randconfig-013-20250608    clang-20
i386                  randconfig-014-20250608    clang-20
i386                  randconfig-015-20250608    clang-20
i386                  randconfig-016-20250608    clang-20
i386                  randconfig-017-20250608    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250607    gcc-13.3.0
loongarch             randconfig-001-20250608    gcc-8.5.0
loongarch             randconfig-002-20250607    gcc-15.1.0
loongarch             randconfig-002-20250608    gcc-8.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                            mac_defconfig    gcc-15.1.0
m68k                           sun3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                           jazz_defconfig    clang-17
mips                       lemote2f_defconfig    gcc-15.1.0
mips                     loongson1b_defconfig    clang-21
mips                           xway_defconfig    clang-21
nios2                            alldefconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                            allyesconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250607    gcc-10.5.0
nios2                 randconfig-001-20250608    gcc-8.5.0
nios2                 randconfig-002-20250607    gcc-8.5.0
nios2                 randconfig-002-20250608    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-15.1.0
openrisc                  or1klitex_defconfig    gcc-15.1.0
openrisc                       virt_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250607    gcc-12.4.0
parisc                randconfig-001-20250608    gcc-8.5.0
parisc                randconfig-002-20250607    gcc-12.4.0
parisc                randconfig-002-20250608    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                     ksi8560_defconfig    gcc-15.1.0
powerpc                     mpc512x_defconfig    clang-21
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc                  mpc866_ads_defconfig    clang-21
powerpc               randconfig-001-20250607    gcc-10.5.0
powerpc               randconfig-001-20250608    gcc-8.5.0
powerpc               randconfig-002-20250607    clang-21
powerpc               randconfig-002-20250608    gcc-8.5.0
powerpc               randconfig-003-20250607    clang-21
powerpc               randconfig-003-20250608    gcc-8.5.0
powerpc                     skiroot_defconfig    clang-21
powerpc                     tqm8548_defconfig    clang-21
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250607    clang-19
powerpc64             randconfig-001-20250608    gcc-8.5.0
powerpc64             randconfig-002-20250607    clang-21
powerpc64             randconfig-002-20250608    gcc-8.5.0
powerpc64             randconfig-003-20250607    gcc-8.5.0
powerpc64             randconfig-003-20250608    gcc-8.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    gcc-15.1.0
riscv                 randconfig-001-20250607    clang-21
riscv                 randconfig-002-20250607    clang-16
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250607    clang-16
s390                  randconfig-002-20250607    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250607    gcc-14.3.0
sh                    randconfig-002-20250607    gcc-9.3.0
sh                          rsk7203_defconfig    gcc-15.1.0
sh                   sh7724_generic_defconfig    gcc-15.1.0
sparc                            alldefconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    gcc-15.1.0
sparc                 randconfig-001-20250607    gcc-10.3.0
sparc                 randconfig-002-20250607    gcc-12.4.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64                          allmodconfig    gcc-15.1.0
sparc64                          allyesconfig    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250607    gcc-9.3.0
sparc64               randconfig-002-20250607    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250607    clang-21
um                    randconfig-002-20250607    gcc-12
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250607    clang-20
x86_64      buildonly-randconfig-002-20250607    clang-20
x86_64      buildonly-randconfig-003-20250607    clang-20
x86_64      buildonly-randconfig-004-20250607    gcc-12
x86_64      buildonly-randconfig-005-20250607    gcc-12
x86_64      buildonly-randconfig-006-20250607    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250608    clang-20
x86_64                randconfig-002-20250608    clang-20
x86_64                randconfig-003-20250608    clang-20
x86_64                randconfig-004-20250608    clang-20
x86_64                randconfig-005-20250608    clang-20
x86_64                randconfig-006-20250608    clang-20
x86_64                randconfig-007-20250608    clang-20
x86_64                randconfig-008-20250608    clang-20
x86_64                randconfig-071-20250608    gcc-12
x86_64                randconfig-072-20250608    gcc-12
x86_64                randconfig-073-20250608    gcc-12
x86_64                randconfig-074-20250608    gcc-12
x86_64                randconfig-075-20250608    gcc-12
x86_64                randconfig-076-20250608    gcc-12
x86_64                randconfig-077-20250608    gcc-12
x86_64                randconfig-078-20250608    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20250607    gcc-10.5.0
xtensa                randconfig-002-20250607    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

