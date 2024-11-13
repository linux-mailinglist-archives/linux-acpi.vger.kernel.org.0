Return-Path: <linux-acpi+bounces-9570-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5011C9C7E18
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 23:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB853284140
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 22:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E826018BC1D;
	Wed, 13 Nov 2024 22:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PfZVgVA0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE43C18A95E;
	Wed, 13 Nov 2024 22:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731535725; cv=none; b=K1xzCEzwlclqhdz0mSM0Q1r/8PPvrKAwvxVhHYWQJFEpr4JwvN8sVoW2Azb+o9vGXiAUNYc+tgpuIfc+6qs+zwiUTDPf80m8QgcDctn8F8aGk9dAe0sOUkqCjON98nDDpS9VBDnB8iMddUBkB7GWeYfpkrKOjlLxiGZdnmIYIu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731535725; c=relaxed/simple;
	bh=0xMPO3OTNLDOXrC7P1Kv/XQf/SQDmzJZuyHt+T86bsk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oiMo7igIjdH+ngDyP3o0QpbRSU90UPNdsqN51hbOjGlPZUhlzJkexwdgDryXEqSQr4ymPw5YVfuX5lUmazEiFZuD/DQCnllQuMwe2bZImrgXCKBIO4Iee19YWnrse62T5Kx84EfW4/+KdRoPXRWh8t+uEf35N5uDXayJ4iHGo3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PfZVgVA0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731535724; x=1763071724;
  h=date:from:to:cc:subject:message-id;
  bh=0xMPO3OTNLDOXrC7P1Kv/XQf/SQDmzJZuyHt+T86bsk=;
  b=PfZVgVA0OQ5mO18RVto72fKjOt6DI7mkg+PiVBnhp3JLZATej8ZN5Jir
   QhiCw3G9BSELUYVSApSxYBXJZBzJW4rmJxlg7ba6zY8YnENlYBK04BkU6
   m1PFE2ppXOMkgh5gMmsW7TM83sJdi84QbWWo4J+7+Zy1Jhcd6GMovmXw7
   8nv0hEH4xXYuqTF85BGA/VijgYzXxZq9ZpSqTuBlInaQdZ36wUP41juJS
   L84+wW58cuewjvOCrdxhmF0jpJZCJjGKQUGuBWgPgKHjl0ebduUIuLJwx
   EXLu5bT/4GbIRxNrOQXeTK+N6F0p2fswHIUSF97l1jAIDhB0IWyIb4dxb
   w==;
X-CSE-ConnectionGUID: xMw4Dp3eSYa3qy7qA0Ejnw==
X-CSE-MsgGUID: IE12RdRdQLy5zFuIiNYIzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42077983"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="42077983"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 14:08:43 -0800
X-CSE-ConnectionGUID: Y08RwQHaQ6mLx0APu8kpnA==
X-CSE-MsgGUID: q5BwW3BYTNiQxpXWbVPQTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="88397156"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Nov 2024 14:08:42 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBLXT-0000lk-1U;
	Wed, 13 Nov 2024 22:08:39 +0000
Date: Thu, 14 Nov 2024 06:07:54 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 d1bf954af846f66ac2ea07b2457b4a089a009c08
Message-ID: <202411140649.P2ZrnrY8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d1bf954af846f66ac2ea07b2457b4a089a009c08  Merge branch 'thermal-core' into bleeding-edge

elapsed time: 1452m

configs tested: 228
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                          axs103_defconfig    clang-20
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    gcc-14.2.0
arc                        nsimosci_defconfig    gcc-14.2.0
arc                   randconfig-001-20241113    clang-20
arc                   randconfig-002-20241113    clang-20
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                         at91_dt_defconfig    clang-20
arm                         at91_dt_defconfig    gcc-14.2.0
arm                          collie_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          exynos_defconfig    gcc-14.2.0
arm                            mmp2_defconfig    gcc-14.2.0
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                   randconfig-001-20241113    clang-20
arm                   randconfig-002-20241113    clang-20
arm                   randconfig-003-20241113    clang-20
arm                   randconfig-004-20241113    clang-20
arm                         s3c6400_defconfig    gcc-14.2.0
arm                         s5pv210_defconfig    gcc-14.2.0
arm                        shmobile_defconfig    gcc-14.2.0
arm                          sp7021_defconfig    gcc-14.2.0
arm                        spear3xx_defconfig    clang-20
arm                        spear6xx_defconfig    gcc-14.2.0
arm                           stm32_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241113    clang-20
arm64                 randconfig-002-20241113    clang-20
arm64                 randconfig-003-20241113    clang-20
arm64                 randconfig-004-20241113    clang-20
csky                             alldefconfig    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    clang-20
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241113    clang-20
csky                  randconfig-002-20241113    clang-20
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-002-20241113    clang-20
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241113    clang-19
i386        buildonly-randconfig-002-20241113    clang-19
i386        buildonly-randconfig-003-20241113    clang-19
i386        buildonly-randconfig-004-20241113    clang-19
i386        buildonly-randconfig-005-20241113    clang-19
i386        buildonly-randconfig-006-20241113    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241113    clang-19
i386                  randconfig-002-20241113    clang-19
i386                  randconfig-003-20241113    clang-19
i386                  randconfig-004-20241113    clang-19
i386                  randconfig-005-20241113    clang-19
i386                  randconfig-006-20241113    clang-19
i386                  randconfig-011-20241113    clang-19
i386                  randconfig-012-20241113    clang-19
i386                  randconfig-013-20241113    clang-19
i386                  randconfig-014-20241113    clang-19
i386                  randconfig-015-20241113    clang-19
i386                  randconfig-016-20241113    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241113    clang-20
loongarch             randconfig-002-20241113    clang-20
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    clang-20
m68k                                defconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
mips                            gpr_defconfig    gcc-14.2.0
mips                           jazz_defconfig    clang-20
mips                       rbtx49xx_defconfig    gcc-14.2.0
mips                         rt305x_defconfig    clang-20
mips                   sb1250_swarm_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241113    clang-20
nios2                 randconfig-002-20241113    clang-20
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241113    clang-20
parisc                randconfig-002-20241113    clang-20
parisc64                            defconfig    gcc-14.2.0
powerpc                    adder875_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     asp8347_defconfig    clang-20
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                       maple_defconfig    gcc-14.2.0
powerpc                 mpc834x_itx_defconfig    gcc-14.2.0
powerpc                 mpc837x_rdb_defconfig    gcc-14.2.0
powerpc                  mpc885_ads_defconfig    gcc-14.2.0
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc                       ppc64_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241113    clang-20
powerpc               randconfig-002-20241113    clang-20
powerpc               randconfig-003-20241113    clang-20
powerpc                     redwood_defconfig    clang-20
powerpc                     taishan_defconfig    gcc-14.2.0
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241113    clang-20
powerpc64             randconfig-002-20241113    clang-20
powerpc64             randconfig-003-20241113    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    clang-20
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
riscv                    nommu_virt_defconfig    gcc-14.2.0
riscv                 randconfig-001-20241113    clang-20
riscv                 randconfig-002-20241113    clang-20
s390                             alldefconfig    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241113    clang-20
s390                  randconfig-002-20241113    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    clang-20
sh                        dreamcast_defconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                    randconfig-001-20241113    clang-20
sh                    randconfig-002-20241113    clang-20
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sh                           se7705_defconfig    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241113    clang-20
sparc64               randconfig-002-20241113    clang-20
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241113    clang-20
um                    randconfig-002-20241113    clang-20
um                           x86_64_defconfig    clang-20
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241113    clang-19
x86_64      buildonly-randconfig-002-20241113    clang-19
x86_64      buildonly-randconfig-003-20241113    clang-19
x86_64      buildonly-randconfig-004-20241113    clang-19
x86_64      buildonly-randconfig-005-20241113    clang-19
x86_64      buildonly-randconfig-006-20241113    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241113    clang-19
x86_64                randconfig-002-20241113    clang-19
x86_64                randconfig-003-20241113    clang-19
x86_64                randconfig-004-20241113    clang-19
x86_64                randconfig-005-20241113    clang-19
x86_64                randconfig-006-20241113    clang-19
x86_64                randconfig-011-20241113    clang-19
x86_64                randconfig-012-20241113    clang-19
x86_64                randconfig-013-20241113    clang-19
x86_64                randconfig-014-20241113    clang-19
x86_64                randconfig-015-20241113    clang-19
x86_64                randconfig-016-20241113    clang-19
x86_64                randconfig-071-20241113    clang-19
x86_64                randconfig-072-20241113    clang-19
x86_64                randconfig-073-20241113    clang-19
x86_64                randconfig-074-20241113    clang-19
x86_64                randconfig-075-20241113    clang-19
x86_64                randconfig-076-20241113    clang-19
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241113    clang-20
xtensa                randconfig-002-20241113    clang-20
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

