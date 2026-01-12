Return-Path: <linux-acpi+bounces-20161-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E01C8D10622
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 03:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63225301176B
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 02:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0B51AA1D2;
	Mon, 12 Jan 2026 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMDloc8b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7965477E;
	Mon, 12 Jan 2026 02:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768186189; cv=none; b=oBcRBvuKkNwlDj6lCoXJcWaCLxtKKeJfauy7nfu5fuMIAqJCPJ7uXFD/oQdqIv4K2WekK0GSO/gCnO7GyLra63mWPHzOqnJKvlFNikffk76PINpL/r1A9rSTcpxAYLOR9ejHCGqHWkAuSjP31fIvNvHBEm6fpKuYXA0J3iJCTfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768186189; c=relaxed/simple;
	bh=7l836UcwSPfWIkae0hjuWuUf5euLiTx3Pk/iXDeABh8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=N57lXx8u2ZNp7j3wh9saVGXBQq/cNhnjzqFKil4Mi0KuQetYOvkxuqDSNiYiCJBaLcJs/II3GPYdWdtOz6QS4Zwlg/UDlBLMt4sRkev2A1S+o3jcFQXwoGAJ3uXmzBbgoqobas8IeuYzCA8Bshw7uLqOutMGDD2jjLxkwdhearM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMDloc8b; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768186187; x=1799722187;
  h=date:from:to:cc:subject:message-id;
  bh=7l836UcwSPfWIkae0hjuWuUf5euLiTx3Pk/iXDeABh8=;
  b=YMDloc8bcvmthdZlpdOpsMCct3pTwnFP8DXiBKLupl5/v1mfyqvB3OmZ
   kCiL0qfGuUos0I6h8fEqPmQ2BaxfN79IaS69NFV8XfkncFBCacnQzzA/Z
   DvhkRIYuT2yhnCqYOW5Q0JjdV4079lcfLeey20Xh4fOD8l0d2sEDIRluR
   Jz9ezjNLWm+/5jnABJDKsz8ZFVNiFuU0xqZSbFfzyazSfDytPadHkigFA
   NC4r2haj8GLAMoxaDIrp04GIEHKLmDmqBTu/ItzlzAqZ8GwYXfMcjwZTR
   ZYNpqQI6btIpMenkP8VyOypkeGepAWM2noZD4PMMgKg+yfHKck6NcrwR2
   g==;
X-CSE-ConnectionGUID: CoXJJDAwTFCTn2BJZtdcJQ==
X-CSE-MsgGUID: wVDN3Q7YSju2UEz3SsnRzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69511559"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69511559"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 18:49:47 -0800
X-CSE-ConnectionGUID: 0timBsHmSd26EnVAzIMcEg==
X-CSE-MsgGUID: 57kt2yJ6RyyKMF6xZnkx0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204260539"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 Jan 2026 18:49:45 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vf7zy-00000000Ctk-3QZl;
	Mon, 12 Jan 2026 02:49:42 +0000
Date: Mon, 12 Jan 2026 10:49:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 825b84fb960be3c0b1775e1b4c5e510e74e9a692
Message-ID: <202601121012.CL1Xd7Az-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 825b84fb960be3c0b1775e1b4c5e510e74e9a692  Merge branch 'acpi-driver' into bleeding-edge

elapsed time: 790m

configs tested: 326
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.2.0
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260111    clang-22
arc                   randconfig-001-20260112    gcc-8.5.0
arc                   randconfig-002-20260111    clang-22
arc                   randconfig-002-20260112    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                       aspeed_g4_defconfig    gcc-15.2.0
arm                        clps711x_defconfig    clang-22
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                          exynos_defconfig    gcc-15.2.0
arm                      footbridge_defconfig    clang-22
arm                           h3600_defconfig    gcc-15.2.0
arm                      integrator_defconfig    gcc-15.2.0
arm                         lpc18xx_defconfig    gcc-15.2.0
arm                        multi_v5_defconfig    gcc-15.2.0
arm                       omap2plus_defconfig    gcc-15.2.0
arm                   randconfig-001-20260111    clang-22
arm                   randconfig-001-20260112    gcc-8.5.0
arm                   randconfig-002-20260111    clang-22
arm                   randconfig-002-20260112    gcc-8.5.0
arm                   randconfig-003-20260111    clang-22
arm                   randconfig-003-20260112    gcc-8.5.0
arm                   randconfig-004-20260111    clang-22
arm                   randconfig-004-20260112    gcc-8.5.0
arm                         wpcm450_defconfig    clang-22
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260111    clang-17
arm64                 randconfig-001-20260112    gcc-8.5.0
arm64                 randconfig-002-20260111    gcc-12.5.0
arm64                 randconfig-002-20260112    gcc-8.5.0
arm64                 randconfig-003-20260111    clang-22
arm64                 randconfig-003-20260112    gcc-8.5.0
arm64                 randconfig-004-20260111    gcc-8.5.0
arm64                 randconfig-004-20260112    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260111    gcc-12.5.0
csky                  randconfig-001-20260112    gcc-8.5.0
csky                  randconfig-002-20260111    gcc-11.5.0
csky                  randconfig-002-20260112    gcc-8.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260111    clang-22
hexagon               randconfig-001-20260112    clang-22
hexagon               randconfig-002-20260111    clang-22
hexagon               randconfig-002-20260112    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260111    clang-20
i386        buildonly-randconfig-001-20260112    gcc-14
i386        buildonly-randconfig-002-20260111    clang-20
i386        buildonly-randconfig-002-20260111    gcc-13
i386        buildonly-randconfig-002-20260112    gcc-14
i386        buildonly-randconfig-003-20260111    clang-20
i386        buildonly-randconfig-003-20260112    gcc-14
i386        buildonly-randconfig-004-20260111    clang-20
i386        buildonly-randconfig-004-20260112    gcc-14
i386        buildonly-randconfig-005-20260111    clang-20
i386        buildonly-randconfig-005-20260112    gcc-14
i386        buildonly-randconfig-006-20260111    clang-20
i386        buildonly-randconfig-006-20260111    gcc-14
i386        buildonly-randconfig-006-20260112    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260111    clang-20
i386                  randconfig-001-20260112    clang-20
i386                  randconfig-002-20260111    clang-20
i386                  randconfig-002-20260112    clang-20
i386                  randconfig-003-20260111    clang-20
i386                  randconfig-003-20260112    clang-20
i386                  randconfig-004-20260111    clang-20
i386                  randconfig-004-20260111    gcc-14
i386                  randconfig-004-20260112    clang-20
i386                  randconfig-005-20260111    clang-20
i386                  randconfig-005-20260112    clang-20
i386                  randconfig-006-20260111    clang-20
i386                  randconfig-006-20260112    clang-20
i386                  randconfig-007-20260111    clang-20
i386                  randconfig-007-20260111    gcc-14
i386                  randconfig-007-20260112    clang-20
i386                  randconfig-011-20260111    clang-20
i386                  randconfig-011-20260112    clang-20
i386                  randconfig-012-20260111    clang-20
i386                  randconfig-012-20260112    clang-20
i386                  randconfig-013-20260111    clang-20
i386                  randconfig-013-20260112    clang-20
i386                  randconfig-014-20260111    clang-20
i386                  randconfig-014-20260112    clang-20
i386                  randconfig-015-20260111    clang-20
i386                  randconfig-015-20260112    clang-20
i386                  randconfig-016-20260111    clang-20
i386                  randconfig-016-20260111    gcc-14
i386                  randconfig-016-20260112    clang-20
i386                  randconfig-017-20260111    clang-20
i386                  randconfig-017-20260112    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260111    clang-22
loongarch             randconfig-001-20260112    clang-22
loongarch             randconfig-002-20260111    clang-22
loongarch             randconfig-002-20260112    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                          atari_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                        m5307c3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                      bmips_stb_defconfig    clang-22
mips                      bmips_stb_defconfig    gcc-15.2.0
mips                           ci20_defconfig    clang-22
mips                         cobalt_defconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    clang-22
mips                           ip22_defconfig    gcc-15.2.0
mips                     loongson2k_defconfig    gcc-15.2.0
mips                malta_qemu_32r6_defconfig    gcc-15.2.0
mips                      pic32mzda_defconfig    gcc-15.2.0
mips                       rbtx49xx_defconfig    gcc-15.2.0
mips                   sb1250_swarm_defconfig    gcc-15.2.0
mips                        vocore2_defconfig    clang-22
nios2                         3c120_defconfig    gcc-11.5.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260111    clang-22
nios2                 randconfig-001-20260112    clang-22
nios2                 randconfig-002-20260111    clang-22
nios2                 randconfig-002-20260112    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
parisc                           alldefconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                generic-32bit_defconfig    clang-22
parisc                randconfig-001-20260111    clang-22
parisc                randconfig-001-20260111    gcc-8.5.0
parisc                randconfig-001-20260112    gcc-10.5.0
parisc                randconfig-002-20260111    clang-22
parisc                randconfig-002-20260111    gcc-10.5.0
parisc                randconfig-002-20260112    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                      arches_defconfig    gcc-15.2.0
powerpc                        cell_defconfig    gcc-15.2.0
powerpc                       eiger_defconfig    gcc-15.2.0
powerpc                      ep88xc_defconfig    gcc-15.2.0
powerpc                        fsp2_defconfig    gcc-15.2.0
powerpc                     kmeter1_defconfig    gcc-15.2.0
powerpc                     ksi8560_defconfig    gcc-15.2.0
powerpc                 mpc8315_rdb_defconfig    gcc-15.2.0
powerpc                 mpc834x_itx_defconfig    gcc-15.2.0
powerpc                     mpc83xx_defconfig    gcc-15.2.0
powerpc                    mvme5100_defconfig    gcc-15.2.0
powerpc                      ppc6xx_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260111    clang-22
powerpc               randconfig-001-20260112    gcc-10.5.0
powerpc               randconfig-002-20260111    clang-22
powerpc               randconfig-002-20260112    gcc-10.5.0
powerpc                     tqm8560_defconfig    clang-22
powerpc                     tqm8560_defconfig    gcc-15.2.0
powerpc64                        alldefconfig    gcc-15.2.0
powerpc64             randconfig-001-20260111    clang-22
powerpc64             randconfig-001-20260112    gcc-10.5.0
powerpc64             randconfig-002-20260111    clang-19
powerpc64             randconfig-002-20260111    clang-22
powerpc64             randconfig-002-20260112    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260111    clang-22
riscv                 randconfig-001-20260111    gcc-11.5.0
riscv                 randconfig-001-20260112    gcc-15.2.0
riscv                 randconfig-002-20260111    clang-16
riscv                 randconfig-002-20260111    gcc-11.5.0
riscv                 randconfig-002-20260112    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260111    gcc-11.5.0
s390                  randconfig-001-20260111    gcc-8.5.0
s390                  randconfig-001-20260112    gcc-15.2.0
s390                  randconfig-002-20260111    gcc-11.5.0
s390                  randconfig-002-20260112    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                         ap325rxa_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                        dreamcast_defconfig    gcc-15.2.0
sh                        edosk7705_defconfig    gcc-15.2.0
sh                 kfr2r09-romimage_defconfig    gcc-15.2.0
sh                          lboxre2_defconfig    gcc-15.2.0
sh                    randconfig-001-20260111    gcc-11.5.0
sh                    randconfig-001-20260112    gcc-15.2.0
sh                    randconfig-002-20260111    gcc-11.5.0
sh                    randconfig-002-20260111    gcc-15.2.0
sh                    randconfig-002-20260112    gcc-15.2.0
sh                      rts7751r2d1_defconfig    gcc-15.2.0
sh                          sdk7780_defconfig    gcc-15.2.0
sh                           se7206_defconfig    gcc-15.2.0
sh                             sh03_defconfig    gcc-15.2.0
sh                        sh7757lcr_defconfig    gcc-15.2.0
sh                        sh7785lcr_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260111    gcc-11.5.0
sparc                 randconfig-001-20260112    clang-20
sparc                 randconfig-002-20260111    gcc-12.5.0
sparc                 randconfig-002-20260112    clang-20
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260111    gcc-8.5.0
sparc64               randconfig-001-20260112    clang-20
sparc64               randconfig-002-20260111    gcc-9.5.0
sparc64               randconfig-002-20260112    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260111    clang-22
um                    randconfig-001-20260112    clang-20
um                    randconfig-002-20260111    clang-16
um                    randconfig-002-20260112    clang-20
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260111    clang-20
x86_64      buildonly-randconfig-001-20260112    gcc-14
x86_64      buildonly-randconfig-002-20260111    clang-20
x86_64      buildonly-randconfig-002-20260112    gcc-14
x86_64      buildonly-randconfig-003-20260111    clang-20
x86_64      buildonly-randconfig-003-20260112    gcc-14
x86_64      buildonly-randconfig-004-20260111    clang-20
x86_64      buildonly-randconfig-004-20260112    gcc-14
x86_64      buildonly-randconfig-005-20260111    clang-20
x86_64      buildonly-randconfig-005-20260112    gcc-14
x86_64      buildonly-randconfig-006-20260111    clang-20
x86_64      buildonly-randconfig-006-20260112    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260111    gcc-12
x86_64                randconfig-001-20260112    gcc-13
x86_64                randconfig-002-20260111    gcc-12
x86_64                randconfig-002-20260112    gcc-13
x86_64                randconfig-003-20260111    gcc-12
x86_64                randconfig-003-20260112    gcc-13
x86_64                randconfig-004-20260111    gcc-12
x86_64                randconfig-004-20260112    gcc-13
x86_64                randconfig-005-20260111    gcc-12
x86_64                randconfig-005-20260112    gcc-13
x86_64                randconfig-006-20260111    gcc-12
x86_64                randconfig-006-20260112    gcc-13
x86_64                randconfig-011-20260111    clang-20
x86_64                randconfig-011-20260111    gcc-14
x86_64                randconfig-011-20260112    clang-20
x86_64                randconfig-012-20260111    clang-20
x86_64                randconfig-012-20260111    gcc-14
x86_64                randconfig-012-20260112    clang-20
x86_64                randconfig-013-20260111    clang-20
x86_64                randconfig-013-20260112    clang-20
x86_64                randconfig-014-20260111    clang-20
x86_64                randconfig-014-20260112    clang-20
x86_64                randconfig-015-20260111    clang-20
x86_64                randconfig-015-20260112    clang-20
x86_64                randconfig-016-20260111    clang-20
x86_64                randconfig-016-20260112    clang-20
x86_64                randconfig-071-20260111    clang-20
x86_64                randconfig-071-20260111    gcc-14
x86_64                randconfig-071-20260112    gcc-14
x86_64                randconfig-072-20260111    gcc-14
x86_64                randconfig-072-20260112    gcc-14
x86_64                randconfig-073-20260111    clang-20
x86_64                randconfig-073-20260111    gcc-14
x86_64                randconfig-073-20260112    gcc-14
x86_64                randconfig-074-20260111    gcc-14
x86_64                randconfig-074-20260112    gcc-14
x86_64                randconfig-075-20260111    gcc-14
x86_64                randconfig-075-20260112    gcc-14
x86_64                randconfig-076-20260111    clang-20
x86_64                randconfig-076-20260111    gcc-14
x86_64                randconfig-076-20260112    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                       common_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260111    gcc-9.5.0
xtensa                randconfig-001-20260112    clang-20
xtensa                randconfig-002-20260111    gcc-13.4.0
xtensa                randconfig-002-20260112    clang-20
xtensa                         virt_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

