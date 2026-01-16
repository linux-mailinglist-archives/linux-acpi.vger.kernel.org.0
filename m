Return-Path: <linux-acpi+bounces-20396-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25605D29C8B
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 02:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB18D303C214
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 01:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28748335551;
	Fri, 16 Jan 2026 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O6lPTtyY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B4D30EF7C;
	Fri, 16 Jan 2026 01:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768528538; cv=none; b=DuhqgnZ5oO+RfCqTEUZJKugUlqvi+crxOoop8U5+X57EbKv8F8cxj5u0tNUEZc2WcYRT00liNjZ2ijKy1iYKC2hyVS0fdyY/KOyTV/4haswTKvWX/cbY23OzAEXA1whZC2tg5Qz+NLKo1SLrV1sau+h+7LudeClPdZHZotrlsSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768528538; c=relaxed/simple;
	bh=jYJLmbts15l6IxkppIKSSmoAg25zeFTcy2uoIdpmXZI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cl9QnTBeWJ7t4unNaJyUdff/wGn7vuvBYoKf4m3j/doUU/63agM+z8Q4fJW+mWnPminlTDWP734EegLJ4w0TgCU2XnUoOxWz8wOBV06pA0XHa56iYatsXisaW0ICHIVtLWGEgQG4Mv2dy/FGAzfRYN1EJqYFAtIMEM4eZZ2S3xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O6lPTtyY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768528535; x=1800064535;
  h=date:from:to:cc:subject:message-id;
  bh=jYJLmbts15l6IxkppIKSSmoAg25zeFTcy2uoIdpmXZI=;
  b=O6lPTtyYHWbglB+z6uEOKKeRlYxugunvnWrLwUz9TZe6zrivnNvn2i/y
   tw7NMmsw8FmEXuQf1tObWH/dINobINDTVf6fCRgTbSYpITEqiC97d/cPt
   4syVL1MbTcnYb1WP+cNV60HcLuivDPu1pglbgUsgkYLl9rEjjWGT0OO6b
   XIO1P1ZTFC5rZhyt4k1WO6whesIwNzo9v+td9sDaT6o7sEq9mYr2UQfPH
   ZDQrm1FZa3c1ZO1onKu5rKxncQW8SkfYPHAWr9gl1yYwaP072vqfyOFu8
   1fB8u5rXMrY4WFcR6FmPC0ZYlfWyRKspqKQob5lh5VYf7yJ9ZKLvDjS35
   A==;
X-CSE-ConnectionGUID: NfNgEP6DQ/20lqOeucFNlg==
X-CSE-MsgGUID: +ddDatokRjGU+4v+S6OXZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="80957950"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="80957950"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 17:55:32 -0800
X-CSE-ConnectionGUID: c5Yre5TfT+qeoC3MS7bGLQ==
X-CSE-MsgGUID: 3mBZvA1gTXG90x85KE++Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="205388729"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 15 Jan 2026 17:55:30 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgZ3f-00000000KF0-3xNi;
	Fri, 16 Jan 2026 01:55:27 +0000
Date: Fri, 16 Jan 2026 09:54:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 d22b6c061c9911a8d0f76c6e902c951455c8c4ba
Message-ID: <202601160927.hJlK4cmK-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d22b6c061c9911a8d0f76c6e902c951455c8c4ba  Merge branch 'pm-runtime-cleanup' into bleeding-edge

elapsed time: 732m

configs tested: 212
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                        nsimosci_defconfig    gcc-15.2.0
arc                   randconfig-001-20260116    gcc-8.5.0
arc                   randconfig-002-20260116    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                       aspeed_g5_defconfig    gcc-15.2.0
arm                        clps711x_defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    gcc-15.2.0
arm                       imx_v4_v5_defconfig    clang-22
arm                             mxs_defconfig    gcc-15.2.0
arm                         nhk8815_defconfig    clang-22
arm                   randconfig-001-20260116    gcc-8.5.0
arm                   randconfig-002-20260116    gcc-8.5.0
arm                   randconfig-003-20260116    gcc-8.5.0
arm                   randconfig-004-20260116    gcc-8.5.0
arm                        shmobile_defconfig    gcc-15.2.0
arm                       spear13xx_defconfig    clang-22
arm                    vt8500_v6_v7_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260116    clang-22
arm64                 randconfig-002-20260116    clang-22
arm64                 randconfig-003-20260116    clang-22
arm64                 randconfig-004-20260116    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260116    clang-22
csky                  randconfig-002-20260116    clang-22
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260116    clang-20
hexagon               randconfig-002-20260116    clang-20
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260116    gcc-12
i386        buildonly-randconfig-002-20260116    gcc-12
i386        buildonly-randconfig-003-20260116    gcc-12
i386        buildonly-randconfig-004-20260116    gcc-12
i386        buildonly-randconfig-005-20260116    gcc-12
i386        buildonly-randconfig-006-20260116    gcc-12
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260116    clang-20
i386                  randconfig-002-20260116    clang-20
i386                  randconfig-003-20260116    clang-20
i386                  randconfig-004-20260116    clang-20
i386                  randconfig-005-20260116    clang-20
i386                  randconfig-006-20260116    clang-20
i386                  randconfig-007-20260116    clang-20
i386                  randconfig-011-20260116    clang-20
i386                  randconfig-012-20260116    clang-20
i386                  randconfig-013-20260116    clang-20
i386                  randconfig-014-20260116    clang-20
i386                  randconfig-015-20260116    clang-20
i386                  randconfig-016-20260116    clang-20
i386                  randconfig-017-20260116    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260116    clang-20
loongarch             randconfig-002-20260116    clang-20
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    clang-22
m68k                        mvme147_defconfig    gcc-15.2.0
m68k                        mvme16x_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                      bmips_stb_defconfig    clang-22
mips                  cavium_octeon_defconfig    clang-22
mips                           ci20_defconfig    clang-22
mips                           ip28_defconfig    clang-22
mips                  maltasmvp_eva_defconfig    clang-22
mips                          rm200_defconfig    clang-22
mips                        vocore2_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260116    clang-20
nios2                 randconfig-002-20260116    clang-20
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260116    clang-22
parisc                randconfig-002-20260116    clang-22
parisc64                            defconfig    clang-19
powerpc                    adder875_defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                      cm5200_defconfig    clang-22
powerpc                      cm5200_defconfig    gcc-15.2.0
powerpc                   currituck_defconfig    clang-22
powerpc                       eiger_defconfig    clang-22
powerpc                  iss476-smp_defconfig    gcc-15.2.0
powerpc                      katmai_defconfig    clang-22
powerpc                 mpc837x_rdb_defconfig    clang-22
powerpc                     mpc83xx_defconfig    clang-22
powerpc                  mpc866_ads_defconfig    gcc-15.2.0
powerpc                    mvme5100_defconfig    clang-22
powerpc                      ppc44x_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260116    clang-22
powerpc               randconfig-002-20260116    clang-22
powerpc                    sam440ep_defconfig    clang-22
powerpc                         wii_defconfig    clang-22
powerpc64             randconfig-001-20260116    clang-22
powerpc64             randconfig-002-20260116    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260116    gcc-15.2.0
riscv                 randconfig-002-20260116    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260116    gcc-15.2.0
s390                  randconfig-002-20260116    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                        apsh4ad0a_defconfig    clang-22
sh                                  defconfig    gcc-14
sh                         ecovec24_defconfig    clang-22
sh                 kfr2r09-romimage_defconfig    clang-22
sh                    randconfig-001-20260116    gcc-15.2.0
sh                    randconfig-002-20260116    gcc-15.2.0
sh                          rsk7201_defconfig    gcc-15.2.0
sh                          rsk7269_defconfig    clang-22
sh                          sdk7786_defconfig    clang-22
sh                           se7721_defconfig    gcc-15.2.0
sh                            shmin_defconfig    clang-22
sh                             shx3_defconfig    clang-22
sparc                            alldefconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260116    gcc-10.5.0
sparc                 randconfig-002-20260116    gcc-10.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260116    gcc-10.5.0
sparc64               randconfig-002-20260116    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260116    gcc-10.5.0
um                    randconfig-002-20260116    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260116    gcc-14
x86_64      buildonly-randconfig-002-20260116    gcc-14
x86_64      buildonly-randconfig-003-20260116    gcc-14
x86_64      buildonly-randconfig-004-20260116    gcc-14
x86_64      buildonly-randconfig-005-20260116    gcc-14
x86_64      buildonly-randconfig-006-20260116    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260116    clang-20
x86_64                randconfig-002-20260116    clang-20
x86_64                randconfig-003-20260116    clang-20
x86_64                randconfig-004-20260116    clang-20
x86_64                randconfig-005-20260116    clang-20
x86_64                randconfig-006-20260116    clang-20
x86_64                randconfig-011-20260116    clang-20
x86_64                randconfig-012-20260116    clang-20
x86_64                randconfig-013-20260116    clang-20
x86_64                randconfig-014-20260116    clang-20
x86_64                randconfig-015-20260116    clang-20
x86_64                randconfig-016-20260116    clang-20
x86_64                randconfig-071-20260116    clang-20
x86_64                randconfig-072-20260116    clang-20
x86_64                randconfig-073-20260116    clang-20
x86_64                randconfig-074-20260116    clang-20
x86_64                randconfig-075-20260116    clang-20
x86_64                randconfig-076-20260116    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                           alldefconfig    clang-22
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260116    gcc-10.5.0
xtensa                randconfig-002-20260116    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

