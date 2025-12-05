Return-Path: <linux-acpi+bounces-19458-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA6BCA9481
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 21:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18BE5300C346
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 20:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A60D22D9ED;
	Fri,  5 Dec 2025 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HpNZv/NK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0F31E834E;
	Fri,  5 Dec 2025 20:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764967102; cv=none; b=KYbkfjQTfpLRKn5LwRH8VX+1GuTJ6PgJpLlkcLNqU5WAm8PcpITcWVbr6aG9i4svm3vp8QT/gnInFRD0rWI+raX3o/ZSrLL6uhKjuKUOkuW5VfMcGU7m3Jzs78ksILGJT9PZNQVhL+w2zx3DskPbiHbbOl6ZsinbnaTL2f2uZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764967102; c=relaxed/simple;
	bh=+aB5l/9jKFCd6Fbo7HR8goVUIYXzo2J7tji0NoYbHUw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fG71AU7a1v6iTamy9Jnzsbk4yD+JZ91hy1rFQX7qTShvswico16hSelT1+d4z34p1vSEoJgsJQMq0xlaeWL4wD64w8d93rTSycvlFZFU53bxeQu7Q4I9MorT/9nsUbyhGTpkza0lJKnqxj+OoCh+gqxCDV/mEeU6PswkmZYZHh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HpNZv/NK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764967100; x=1796503100;
  h=date:from:to:cc:subject:message-id;
  bh=+aB5l/9jKFCd6Fbo7HR8goVUIYXzo2J7tji0NoYbHUw=;
  b=HpNZv/NKkqT8ZsCKMybnJ2v7GA6WcJKWpA+SwNuym4WyPrqhRnDHDc09
   xl5td2D7rduxmP273934ULX1i+6wc89PpoKnxZN4zyaVxgwku4GzIT0HQ
   S3lwcmVQS2nxRGRx74+7/zricsGOBNr2vV6YOfJNAL2e1Z+XPaNpm6rIy
   R8mR/tEiJAa51MXPOS3h2g9/Yw1tQc4wNebw5TdqGaasw4lIPJcCCgkdy
   VkqroVtZErEVhrJMwAJXnAh2Uk4m2wOe5n9ewEHMJ5R1m9KYyWu5sXqty
   TrbukPU3x8rY7NART6mqn29pahdQ5aDph5suWNIbPNevt2RvI5RtECYYX
   Q==;
X-CSE-ConnectionGUID: zoDpRROcQae9HHrm6wkrPg==
X-CSE-MsgGUID: SfVSROPqRRyZ0QLzIY5n0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="66967248"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="66967248"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 12:38:20 -0800
X-CSE-ConnectionGUID: Uumnvl3LQY6iDsRlDLaoAw==
X-CSE-MsgGUID: qXOWNdnuQqOCveP2jOVRuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="226391172"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 05 Dec 2025 12:38:19 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vRcZF-00000000FWH-0Kq6;
	Fri, 05 Dec 2025 20:38:17 +0000
Date: Sat, 06 Dec 2025 04:37:42 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 d573d1f5141dbfc4ec411bf56d73b57fc57fb9e1
Message-ID: <202512060436.K7CiuNm0-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d573d1f5141dbfc4ec411bf56d73b57fc57fb9e1  Merge branch 'pm-runtime' into linux-next

elapsed time: 1449m

configs tested: 236
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              alldefconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.1.0
arc                        nsim_700_defconfig    clang-17
arc                   randconfig-001-20251205    gcc-13.4.0
arc                   randconfig-001-20251206    clang-16
arc                   randconfig-002-20251205    gcc-13.4.0
arc                   randconfig-002-20251206    clang-16
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                       aspeed_g4_defconfig    clang-20
arm                        clps711x_defconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                          gemini_defconfig    clang-20
arm                       imx_v4_v5_defconfig    clang-20
arm                         lpc32xx_defconfig    clang-17
arm                   randconfig-001-20251205    gcc-13.4.0
arm                   randconfig-001-20251206    clang-16
arm                   randconfig-002-20251205    gcc-13.4.0
arm                   randconfig-002-20251206    clang-16
arm                   randconfig-003-20251205    gcc-13.4.0
arm                   randconfig-003-20251206    clang-16
arm                   randconfig-004-20251205    gcc-13.4.0
arm                   randconfig-004-20251206    clang-16
arm                             rpc_defconfig    gcc-15.1.0
arm                        spear3xx_defconfig    gcc-15.1.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251205    clang-22
arm64                 randconfig-001-20251206    clang-22
arm64                 randconfig-002-20251205    clang-22
arm64                 randconfig-002-20251206    clang-22
arm64                 randconfig-003-20251205    clang-22
arm64                 randconfig-003-20251206    clang-22
arm64                 randconfig-004-20251205    clang-22
arm64                 randconfig-004-20251206    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251205    clang-22
csky                  randconfig-001-20251206    clang-22
csky                  randconfig-002-20251205    clang-22
csky                  randconfig-002-20251206    clang-22
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251205    clang-22
hexagon               randconfig-001-20251206    gcc-15.1.0
hexagon               randconfig-002-20251205    clang-22
hexagon               randconfig-002-20251206    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251205    gcc-14
i386        buildonly-randconfig-002-20251205    gcc-14
i386        buildonly-randconfig-003-20251205    gcc-14
i386        buildonly-randconfig-004-20251205    gcc-14
i386        buildonly-randconfig-005-20251205    gcc-14
i386        buildonly-randconfig-006-20251205    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251205    clang-20
i386                  randconfig-002-20251205    clang-20
i386                  randconfig-003-20251205    clang-20
i386                  randconfig-004-20251205    clang-20
i386                  randconfig-005-20251205    clang-20
i386                  randconfig-006-20251205    clang-20
i386                  randconfig-007-20251205    clang-20
i386                  randconfig-011-20251205    clang-20
i386                  randconfig-012-20251205    clang-20
i386                  randconfig-013-20251205    clang-20
i386                  randconfig-014-20251205    clang-20
i386                  randconfig-015-20251205    clang-20
i386                  randconfig-016-20251205    clang-20
i386                  randconfig-017-20251205    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251205    clang-22
loongarch             randconfig-001-20251206    gcc-15.1.0
loongarch             randconfig-002-20251205    clang-22
loongarch             randconfig-002-20251206    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    clang-17
mips                         bigsur_defconfig    clang-17
mips                           ci20_defconfig    clang-20
mips                         cobalt_defconfig    gcc-15.1.0
mips                         db1xxx_defconfig    clang-17
mips                         db1xxx_defconfig    clang-20
mips                          eyeq6_defconfig    clang-17
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251205    clang-22
nios2                 randconfig-001-20251206    gcc-15.1.0
nios2                 randconfig-002-20251205    clang-22
nios2                 randconfig-002-20251206    gcc-15.1.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251205    clang-22
parisc                randconfig-001-20251206    clang-22
parisc                randconfig-002-20251205    clang-22
parisc                randconfig-002-20251206    clang-22
parisc64                         alldefconfig    gcc-15.1.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                      arches_defconfig    clang-20
powerpc                   currituck_defconfig    gcc-15.1.0
powerpc                        fsp2_defconfig    clang-17
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc                      katmai_defconfig    gcc-15.1.0
powerpc                         ps3_defconfig    gcc-15.1.0
powerpc                     rainier_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251205    clang-22
powerpc               randconfig-001-20251206    clang-22
powerpc               randconfig-002-20251205    clang-22
powerpc               randconfig-002-20251206    clang-22
powerpc64             randconfig-001-20251205    clang-22
powerpc64             randconfig-001-20251206    clang-22
powerpc64             randconfig-002-20251205    clang-22
powerpc64             randconfig-002-20251206    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251205    gcc-13.4.0
riscv                 randconfig-001-20251206    clang-22
riscv                 randconfig-002-20251205    gcc-13.4.0
riscv                 randconfig-002-20251206    clang-22
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251205    gcc-13.4.0
s390                  randconfig-001-20251206    clang-22
s390                  randconfig-002-20251205    gcc-13.4.0
s390                  randconfig-002-20251206    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                        apsh4ad0a_defconfig    clang-17
sh                                  defconfig    gcc-14
sh                        dreamcast_defconfig    clang-20
sh                    randconfig-001-20251205    gcc-13.4.0
sh                    randconfig-001-20251206    clang-22
sh                    randconfig-002-20251205    gcc-13.4.0
sh                    randconfig-002-20251206    clang-22
sh                           se7206_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251205    gcc-14
sparc                 randconfig-001-20251206    gcc-14
sparc                 randconfig-002-20251205    gcc-14
sparc                 randconfig-002-20251206    gcc-14
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251205    gcc-14
sparc64               randconfig-001-20251206    gcc-14
sparc64               randconfig-002-20251205    gcc-14
sparc64               randconfig-002-20251206    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251205    gcc-14
um                    randconfig-001-20251206    gcc-14
um                    randconfig-002-20251205    gcc-14
um                    randconfig-002-20251206    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251205    gcc-14
x86_64      buildonly-randconfig-002-20251205    gcc-14
x86_64      buildonly-randconfig-003-20251205    gcc-14
x86_64      buildonly-randconfig-004-20251205    gcc-14
x86_64      buildonly-randconfig-005-20251205    gcc-14
x86_64      buildonly-randconfig-006-20251205    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251205    clang-20
x86_64                randconfig-002-20251205    clang-20
x86_64                randconfig-003-20251205    clang-20
x86_64                randconfig-004-20251205    clang-20
x86_64                randconfig-005-20251205    clang-20
x86_64                randconfig-006-20251205    clang-20
x86_64                randconfig-011-20251205    clang-20
x86_64                randconfig-012-20251205    clang-20
x86_64                randconfig-013-20251205    clang-20
x86_64                randconfig-014-20251205    clang-20
x86_64                randconfig-015-20251205    clang-20
x86_64                randconfig-016-20251205    clang-20
x86_64                randconfig-071-20251205    gcc-14
x86_64                randconfig-072-20251205    gcc-14
x86_64                randconfig-073-20251205    gcc-14
x86_64                randconfig-074-20251205    gcc-14
x86_64                randconfig-075-20251205    gcc-14
x86_64                randconfig-076-20251205    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                           alldefconfig    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251205    gcc-14
xtensa                randconfig-001-20251206    gcc-14
xtensa                randconfig-002-20251205    gcc-14
xtensa                randconfig-002-20251206    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

