Return-Path: <linux-acpi+bounces-20437-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD052D3BCC7
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 02:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B606304066B
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 01:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AB21D6194;
	Tue, 20 Jan 2026 01:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VkXHCpZT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9974D1F94A;
	Tue, 20 Jan 2026 01:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768871551; cv=none; b=ismBL6R4sqMLbI/GGqxBf1NGbJs2WjAcNSN9L+OAgcxUNdvW6TXwj4o5UCj6HiBoQYgLxvtpcsJ8tUhbKU7LaEuQ0QcTicRECBiSa6WsmlU3idIM01IMneOiYKa2wA4O0GdrI3c2hamX2vMz1ghOl+wqWynJa6sqkarzMvYtbvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768871551; c=relaxed/simple;
	bh=Zrm7Ak6EH9Packqos10xV6Mit/szD3GdrzOE+k41hXk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HEntiPCn9Vdh74YNPfZouEsOQDVJVc9iVOF9aGvMsmsqXpoRuAb/dwsn4Puk2jPyCxO0Ca20YbEODpHxnwuD4icvZdAsvNitRWDmGngG/kfqMfM4AOi3MdoqlhrBQXwgK7NBhg0Kc1rlOZqGTPM2GxTxXUWyHFVtaz+gPWpOb/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VkXHCpZT; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768871549; x=1800407549;
  h=date:from:to:cc:subject:message-id;
  bh=Zrm7Ak6EH9Packqos10xV6Mit/szD3GdrzOE+k41hXk=;
  b=VkXHCpZTt3RPlCUaLy2NgmoEUUTppOL78HSH4+36MMoxVOID2ZCwAqAI
   Lsp+yMOuNmtVJrElC0RurkiuNiMd3mf3kP2O5ToVNgoleHGqTckd9CDqn
   bD6mb4O0lyPdmEWAXzXUm1rwpp1iBR11X/mCIpOZc11XP2RkjgbLyKzqd
   ztE4MElexs3Oq5cWuWsmS5Mc3sMsizPYul83AHvqsdfjBbf6VY3K/4HUT
   bXHN9SwN76lIAfkGtdtQf0P0DCEXXoSxSZ2aKaVzJYPOtnWPtgMyQOvP8
   GRfp2GzLnbyv7wZ96L4baVKcVRBK6ZewMr49sBx3N3d1w2/nUVApq1A9/
   A==;
X-CSE-ConnectionGUID: 6BuAcmqJQnC2stWIiwmQrQ==
X-CSE-MsgGUID: 4Iw4E/J7QCaGy1lpRAB39A==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="72662950"
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="72662950"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 17:12:29 -0800
X-CSE-ConnectionGUID: TQJ2vOR+TWO07jVTtEEiUQ==
X-CSE-MsgGUID: 29q3GvCHRqufHfGlAoWwSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="205609628"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 19 Jan 2026 17:12:28 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vi0ID-00000000ORX-2bDf;
	Tue, 20 Jan 2026 01:12:25 +0000
Date: Tue, 20 Jan 2026 09:11:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 508205e6d86048658f850a52a11e1cc422271a81
Message-ID: <202601200953.2U4Jngyy-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 508205e6d86048658f850a52a11e1cc422271a81  Merge branch 'pm-runtime-cleanup' into bleeding-edge

elapsed time: 782m

configs tested: 328
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.2.0
arc                   randconfig-001-20260119    gcc-14.3.0
arc                   randconfig-001-20260120    clang-22
arc                   randconfig-002-20260119    gcc-14.3.0
arc                   randconfig-002-20260120    clang-22
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                     am200epdkit_defconfig    clang-18
arm                         bcm2835_defconfig    clang-16
arm                     davinci_all_defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                          exynos_defconfig    clang-18
arm                            hisi_defconfig    clang-22
arm                       multi_v4t_defconfig    clang-22
arm                        mvebu_v7_defconfig    clang-22
arm                          pxa3xx_defconfig    clang-22
arm                   randconfig-001-20260119    gcc-14.3.0
arm                   randconfig-001-20260120    clang-22
arm                   randconfig-002-20260119    gcc-14.3.0
arm                   randconfig-002-20260120    clang-22
arm                   randconfig-003-20260119    gcc-14.3.0
arm                   randconfig-003-20260120    clang-22
arm                   randconfig-004-20260119    gcc-14.3.0
arm                   randconfig-004-20260120    clang-22
arm                         socfpga_defconfig    clang-22
arm                          sp7021_defconfig    clang-16
arm                    vt8500_v6_v7_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260119    clang-19
arm64                 randconfig-001-20260120    gcc-15.2.0
arm64                 randconfig-002-20260119    clang-19
arm64                 randconfig-002-20260120    gcc-15.2.0
arm64                 randconfig-003-20260119    clang-19
arm64                 randconfig-003-20260120    gcc-15.2.0
arm64                 randconfig-004-20260119    clang-19
arm64                 randconfig-004-20260120    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260119    clang-19
csky                  randconfig-001-20260120    gcc-15.2.0
csky                  randconfig-002-20260119    clang-19
csky                  randconfig-002-20260120    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260119    clang-18
hexagon               randconfig-001-20260120    gcc-12.5.0
hexagon               randconfig-002-20260119    clang-18
hexagon               randconfig-002-20260120    gcc-12.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260119    clang-20
i386        buildonly-randconfig-001-20260120    gcc-14
i386        buildonly-randconfig-002-20260119    clang-20
i386        buildonly-randconfig-002-20260120    gcc-14
i386        buildonly-randconfig-003-20260119    clang-20
i386        buildonly-randconfig-003-20260120    gcc-14
i386        buildonly-randconfig-004-20260119    clang-20
i386        buildonly-randconfig-004-20260120    gcc-14
i386        buildonly-randconfig-005-20260119    clang-20
i386        buildonly-randconfig-005-20260120    gcc-14
i386        buildonly-randconfig-006-20260119    clang-20
i386        buildonly-randconfig-006-20260120    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260119    gcc-13
i386                  randconfig-001-20260120    clang-20
i386                  randconfig-002-20260119    gcc-13
i386                  randconfig-002-20260120    clang-20
i386                  randconfig-003-20260119    gcc-13
i386                  randconfig-003-20260120    clang-20
i386                  randconfig-004-20260119    gcc-13
i386                  randconfig-004-20260120    clang-20
i386                  randconfig-005-20260119    gcc-13
i386                  randconfig-005-20260120    clang-20
i386                  randconfig-006-20260119    gcc-13
i386                  randconfig-006-20260120    clang-20
i386                  randconfig-007-20260119    gcc-13
i386                  randconfig-007-20260120    clang-20
i386                  randconfig-011-20260119    gcc-14
i386                  randconfig-011-20260120    clang-20
i386                  randconfig-012-20260119    gcc-14
i386                  randconfig-012-20260120    clang-20
i386                  randconfig-013-20260119    gcc-14
i386                  randconfig-013-20260120    clang-20
i386                  randconfig-014-20260119    gcc-14
i386                  randconfig-014-20260120    clang-20
i386                  randconfig-015-20260119    gcc-14
i386                  randconfig-015-20260120    clang-20
i386                  randconfig-016-20260119    gcc-14
i386                  randconfig-016-20260120    clang-20
i386                  randconfig-017-20260119    gcc-14
i386                  randconfig-017-20260120    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson64_defconfig    clang-16
loongarch             randconfig-001-20260119    clang-18
loongarch             randconfig-001-20260120    gcc-12.5.0
loongarch             randconfig-002-20260119    clang-18
loongarch             randconfig-002-20260120    gcc-12.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         amcore_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                            gpr_defconfig    clang-18
mips                           ip22_defconfig    clang-16
mips                           ip22_defconfig    clang-22
mips                       lemote2f_defconfig    clang-16
mips                      loongson3_defconfig    clang-22
mips                    maltaup_xpa_defconfig    gcc-15.2.0
mips                          rb532_defconfig    clang-22
mips                           xway_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260119    clang-18
nios2                 randconfig-001-20260120    gcc-12.5.0
nios2                 randconfig-002-20260119    clang-18
nios2                 randconfig-002-20260120    gcc-12.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260119    clang-22
parisc                randconfig-001-20260120    gcc-8.5.0
parisc                randconfig-002-20260119    clang-22
parisc                randconfig-002-20260120    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                    amigaone_defconfig    clang-22
powerpc                     asp8347_defconfig    clang-22
powerpc                      bamboo_defconfig    clang-22
powerpc                 canyonlands_defconfig    clang-22
powerpc                   currituck_defconfig    gcc-15.2.0
powerpc                       eiger_defconfig    clang-16
powerpc                    gamecube_defconfig    gcc-15.2.0
powerpc                      katmai_defconfig    clang-18
powerpc                   motionpro_defconfig    clang-22
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc                     mpc83xx_defconfig    clang-22
powerpc                  mpc885_ads_defconfig    clang-22
powerpc               randconfig-001-20260119    clang-22
powerpc               randconfig-001-20260120    gcc-8.5.0
powerpc               randconfig-002-20260119    clang-22
powerpc               randconfig-002-20260120    gcc-8.5.0
powerpc                  storcenter_defconfig    clang-16
powerpc                     tqm5200_defconfig    clang-22
powerpc                     tqm8548_defconfig    clang-22
powerpc                         wii_defconfig    clang-18
powerpc64             randconfig-001-20260119    clang-22
powerpc64             randconfig-001-20260120    gcc-8.5.0
powerpc64             randconfig-002-20260119    clang-22
powerpc64             randconfig-002-20260120    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_virt_defconfig    clang-22
riscv                 randconfig-001-20260119    gcc-15.2.0
riscv                 randconfig-001-20260119    gcc-8.5.0
riscv                 randconfig-001-20260120    gcc-13.4.0
riscv                 randconfig-002-20260119    clang-22
riscv                 randconfig-002-20260119    gcc-15.2.0
riscv                 randconfig-002-20260120    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260119    gcc-15.2.0
s390                  randconfig-001-20260119    gcc-9.5.0
s390                  randconfig-001-20260120    gcc-13.4.0
s390                  randconfig-002-20260119    clang-22
s390                  randconfig-002-20260119    gcc-15.2.0
s390                  randconfig-002-20260120    gcc-13.4.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260119    gcc-15.2.0
sh                    randconfig-001-20260120    gcc-13.4.0
sh                    randconfig-002-20260119    gcc-12.5.0
sh                    randconfig-002-20260119    gcc-15.2.0
sh                    randconfig-002-20260120    gcc-13.4.0
sh                          rsk7201_defconfig    clang-22
sh                           se7722_defconfig    gcc-15.2.0
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260119    gcc-14.3.0
sparc                 randconfig-001-20260120    gcc-8.5.0
sparc                 randconfig-002-20260119    gcc-14.3.0
sparc                 randconfig-002-20260120    gcc-8.5.0
sparc                       sparc32_defconfig    clang-18
sparc64                          alldefconfig    clang-22
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260119    gcc-14.3.0
sparc64               randconfig-001-20260120    gcc-8.5.0
sparc64               randconfig-002-20260119    gcc-14.3.0
sparc64               randconfig-002-20260120    gcc-8.5.0
um                               alldefconfig    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260119    gcc-14.3.0
um                    randconfig-001-20260120    gcc-8.5.0
um                    randconfig-002-20260119    gcc-14.3.0
um                    randconfig-002-20260120    gcc-8.5.0
um                           x86_64_defconfig    clang-18
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260119    gcc-14
x86_64      buildonly-randconfig-001-20260120    gcc-14
x86_64      buildonly-randconfig-002-20260119    gcc-14
x86_64      buildonly-randconfig-002-20260120    gcc-14
x86_64      buildonly-randconfig-003-20260119    gcc-14
x86_64      buildonly-randconfig-003-20260120    gcc-14
x86_64      buildonly-randconfig-004-20260119    gcc-14
x86_64      buildonly-randconfig-004-20260120    gcc-14
x86_64      buildonly-randconfig-005-20260119    gcc-14
x86_64      buildonly-randconfig-005-20260120    gcc-14
x86_64      buildonly-randconfig-006-20260119    gcc-14
x86_64      buildonly-randconfig-006-20260120    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260119    gcc-14
x86_64                randconfig-001-20260120    gcc-14
x86_64                randconfig-002-20260119    gcc-14
x86_64                randconfig-002-20260120    gcc-14
x86_64                randconfig-003-20260119    gcc-14
x86_64                randconfig-003-20260120    gcc-14
x86_64                randconfig-004-20260119    gcc-14
x86_64                randconfig-004-20260120    gcc-14
x86_64                randconfig-005-20260119    gcc-14
x86_64                randconfig-005-20260120    gcc-14
x86_64                randconfig-006-20260119    gcc-14
x86_64                randconfig-006-20260120    gcc-14
x86_64                randconfig-011-20260119    clang-20
x86_64                randconfig-011-20260120    gcc-14
x86_64                randconfig-012-20260119    clang-20
x86_64                randconfig-012-20260120    gcc-14
x86_64                randconfig-013-20260119    clang-20
x86_64                randconfig-013-20260120    gcc-14
x86_64                randconfig-014-20260119    clang-20
x86_64                randconfig-014-20260120    gcc-14
x86_64                randconfig-015-20260119    clang-20
x86_64                randconfig-015-20260120    gcc-14
x86_64                randconfig-016-20260119    clang-20
x86_64                randconfig-016-20260120    gcc-14
x86_64                randconfig-071-20260119    clang-20
x86_64                randconfig-071-20260120    gcc-14
x86_64                randconfig-072-20260119    clang-20
x86_64                randconfig-072-20260120    gcc-14
x86_64                randconfig-073-20260119    clang-20
x86_64                randconfig-073-20260120    gcc-14
x86_64                randconfig-074-20260119    clang-20
x86_64                randconfig-074-20260120    gcc-14
x86_64                randconfig-075-20260119    clang-20
x86_64                randconfig-075-20260120    gcc-14
x86_64                randconfig-076-20260119    clang-20
x86_64                randconfig-076-20260120    gcc-14
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
xtensa                randconfig-001-20260119    gcc-14.3.0
xtensa                randconfig-001-20260120    gcc-8.5.0
xtensa                randconfig-002-20260119    gcc-14.3.0
xtensa                randconfig-002-20260120    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

