Return-Path: <linux-acpi+bounces-9291-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5E69BC95F
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 10:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834491C22772
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 09:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28351CEAA0;
	Tue,  5 Nov 2024 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMQA/1rj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94431C8773;
	Tue,  5 Nov 2024 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799382; cv=none; b=O7LRcCqDmZy8CP/Rzg838c0kRVy5ZO11rEzdsySzEdhHxdR54pw+0R2XojdaJ8/AbSClcvmPyo0z0Cbyqsgbdm9H04AhoSZL9wSfdbeBp9hqGtplp7igQijGk/1e0+SkhFVYStBvTVkyctZRcr6Wsqo8pvJhC1jS8HVpit+o8gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799382; c=relaxed/simple;
	bh=uiXorxSl6zgzA0n7RYdmcmeVLord7Uf6gn5HWXJvwjM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I7CK8st1UzJB4sv752eikGhmGvZwhU6Cp5zqzSIaAJDbi1rJBBpCalqA50Gg39Y2t+bxPdZn+qBrQ4qQw/z2LZvD5XFw3dURUzzCzroGuGz+UkDk46FZoOq6b4latEez0RxcA8NR95bzXZYnqaY8fAmxJnGhW18VJG0aSr2/OV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMQA/1rj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730799380; x=1762335380;
  h=date:from:to:cc:subject:message-id;
  bh=uiXorxSl6zgzA0n7RYdmcmeVLord7Uf6gn5HWXJvwjM=;
  b=CMQA/1rjh+UGyC3c15+7W3ebmhEKwf6o5Xh3pPfNgBYy+cVkzGH3ga/L
   Vovo4bd+dhZ7hELREsy8ZKRr7Eg3sqIMrodMnJZLP07GZF1OZsNMFqBP7
   Pl3F8NmhKAOGQT7hRk6+PVsWV3sO6YM71ibRAYxCnwYwmz6eFCQ78foyY
   6nBTNrJQXCUK7Ao412HPwzcNlHoBtYAxdS3JYMNlreCa1z1wHK/MlyKUU
   Y6AT1N2hSxATkh9KlzXk+IhbFi7D13r68JnCw1xhJCCNnaihXT9V0lcss
   aFU5ds7rjp3+YDQQJX4PGGEGKKJRAbUeB37XiFjJpePsOgbislHKRGtzt
   Q==;
X-CSE-ConnectionGUID: wk44hpq8SHCUpuVvimfldg==
X-CSE-MsgGUID: pLpD0EUAQSWUAjwGiR2qLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="30757895"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="30757895"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 01:36:20 -0800
X-CSE-ConnectionGUID: /YxS+9u8TXCTOSOiDwi1iQ==
X-CSE-MsgGUID: bRTUp3rIQuO3AmKfKEaxZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="84056052"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 05 Nov 2024 01:36:18 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8Fyy-000lqh-0h;
	Tue, 05 Nov 2024 09:36:16 +0000
Date: Tue, 05 Nov 2024 17:36:08 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 fd3e466911231e23f8e9d49d7e568c032e881ca4
Message-ID: <202411051757.zHYSisju-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: fd3e466911231e23f8e9d49d7e568c032e881ca4  Merge branch 'thermal-fixes' into fixes

elapsed time: 851m

configs tested: 192
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                   randconfig-001-20241105    gcc-14.1.0
arc                   randconfig-002-20241105    gcc-14.1.0
arc                    vdk_hs38_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                       aspeed_g5_defconfig    clang-20
arm                      footbridge_defconfig    gcc-14.1.0
arm                           imxrt_defconfig    clang-20
arm                           imxrt_defconfig    gcc-14.1.0
arm                            mps2_defconfig    clang-20
arm                            qcom_defconfig    gcc-14.1.0
arm                   randconfig-001-20241105    gcc-14.1.0
arm                   randconfig-002-20241105    gcc-14.1.0
arm                   randconfig-003-20241105    gcc-14.1.0
arm                   randconfig-004-20241105    gcc-14.1.0
arm                           sama7_defconfig    clang-20
arm                        shmobile_defconfig    gcc-14.1.0
arm                         wpcm450_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20241105    gcc-14.1.0
arm64                 randconfig-002-20241105    gcc-14.1.0
arm64                 randconfig-003-20241105    gcc-14.1.0
arm64                 randconfig-004-20241105    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20241105    gcc-14.1.0
csky                  randconfig-002-20241105    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241105    gcc-14.1.0
hexagon               randconfig-002-20241105    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241105    clang-19
i386        buildonly-randconfig-002-20241105    clang-19
i386        buildonly-randconfig-003-20241105    clang-19
i386        buildonly-randconfig-004-20241105    clang-19
i386        buildonly-randconfig-005-20241105    clang-19
i386        buildonly-randconfig-006-20241105    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241105    clang-19
i386                  randconfig-002-20241105    clang-19
i386                  randconfig-003-20241105    clang-19
i386                  randconfig-004-20241105    clang-19
i386                  randconfig-005-20241105    clang-19
i386                  randconfig-006-20241105    clang-19
i386                  randconfig-011-20241105    clang-19
i386                  randconfig-012-20241105    clang-19
i386                  randconfig-013-20241105    clang-19
i386                  randconfig-014-20241105    clang-19
i386                  randconfig-015-20241105    clang-19
i386                  randconfig-016-20241105    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20241105    gcc-14.1.0
loongarch             randconfig-002-20241105    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          hp300_defconfig    clang-20
m68k                          multi_defconfig    gcc-14.1.0
m68k                          sun3x_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath79_defconfig    gcc-14.1.0
mips                       bmips_be_defconfig    gcc-14.1.0
mips                  cavium_octeon_defconfig    clang-20
mips                           ip27_defconfig    gcc-14.1.0
mips                           jazz_defconfig    clang-20
mips                     loongson1b_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20241105    gcc-14.1.0
nios2                 randconfig-002-20241105    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241105    gcc-14.1.0
parisc                randconfig-002-20241105    gcc-14.1.0
parisc64                         alldefconfig    clang-20
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     asp8347_defconfig    gcc-14.1.0
powerpc                 canyonlands_defconfig    clang-20
powerpc                        cell_defconfig    clang-20
powerpc                    ge_imp3a_defconfig    gcc-14.1.0
powerpc                     ksi8560_defconfig    clang-20
powerpc                 linkstation_defconfig    gcc-14.1.0
powerpc                      mgcoge_defconfig    gcc-14.1.0
powerpc                 mpc836x_rdk_defconfig    gcc-14.1.0
powerpc                     mpc83xx_defconfig    gcc-14.1.0
powerpc                         ps3_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241105    gcc-14.1.0
powerpc               randconfig-002-20241105    gcc-14.1.0
powerpc               randconfig-003-20241105    gcc-14.1.0
powerpc                  storcenter_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20241105    gcc-14.1.0
powerpc64             randconfig-002-20241105    gcc-14.1.0
powerpc64             randconfig-003-20241105    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241105    gcc-14.1.0
riscv                 randconfig-002-20241105    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241105    gcc-14.1.0
s390                  randconfig-002-20241105    gcc-14.1.0
s390                       zfcpdump_defconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    gcc-14.1.0
sh                          landisk_defconfig    gcc-14.1.0
sh                    randconfig-001-20241105    gcc-14.1.0
sh                    randconfig-002-20241105    gcc-14.1.0
sh                           se7206_defconfig    clang-20
sh                           se7712_defconfig    gcc-14.1.0
sh                           se7722_defconfig    clang-20
sh                           se7722_defconfig    gcc-14.1.0
sh                           se7750_defconfig    gcc-14.1.0
sh                   sh7724_generic_defconfig    clang-20
sh                              ul2_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc32_defconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241105    gcc-14.1.0
sparc64               randconfig-002-20241105    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                             i386_defconfig    gcc-14.1.0
um                    randconfig-001-20241105    gcc-14.1.0
um                    randconfig-002-20241105    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241105    gcc-12
x86_64      buildonly-randconfig-002-20241105    gcc-12
x86_64      buildonly-randconfig-003-20241105    gcc-12
x86_64      buildonly-randconfig-004-20241105    gcc-12
x86_64      buildonly-randconfig-005-20241105    gcc-12
x86_64      buildonly-randconfig-006-20241105    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241105    gcc-12
x86_64                randconfig-002-20241105    gcc-12
x86_64                randconfig-003-20241105    gcc-12
x86_64                randconfig-004-20241105    gcc-12
x86_64                randconfig-005-20241105    gcc-12
x86_64                randconfig-006-20241105    gcc-12
x86_64                randconfig-011-20241105    gcc-12
x86_64                randconfig-012-20241105    gcc-12
x86_64                randconfig-013-20241105    gcc-12
x86_64                randconfig-014-20241105    gcc-12
x86_64                randconfig-015-20241105    gcc-12
x86_64                randconfig-016-20241105    gcc-12
x86_64                randconfig-071-20241105    gcc-12
x86_64                randconfig-072-20241105    gcc-12
x86_64                randconfig-073-20241105    gcc-12
x86_64                randconfig-074-20241105    gcc-12
x86_64                randconfig-075-20241105    gcc-12
x86_64                randconfig-076-20241105    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241105    gcc-14.1.0
xtensa                randconfig-002-20241105    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

