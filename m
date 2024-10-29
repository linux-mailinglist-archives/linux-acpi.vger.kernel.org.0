Return-Path: <linux-acpi+bounces-9069-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 006229B49BE
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 13:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2456A1C2125F
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 12:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2277C746E;
	Tue, 29 Oct 2024 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XbJH27XU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94C9539A;
	Tue, 29 Oct 2024 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205245; cv=none; b=fDFpE4uspq0O0jWEWJgoJgmCeRDDpmdzDuKRY9ws3SDrEv0vZyetianC/j/A4d009N4naKh5SP4DbNwDZuiRG30s759LyBEos3q63G1PvOpj7NErHqzURh6SFHs+1CVjChyEqou4w7ohkSJGZMgj2XZG2zpfBn9afe1Wc70V3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205245; c=relaxed/simple;
	bh=LzMDlL9U10o7ECbKJh1q3AeQCHYhZjzNpR8YBjdrmE4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ETJkBAwZWfrciKIzQ6llb6Lt6ogK1aoUN0n26MQiuYPZoCNMbcR57JinYo5TIukZnMY5qqUNxqpjJIXf6FRE1kjKJE4lX7IoqFb3ia/u0yZVe3/xRBZpdUDVSHQgNBFHNdSC8d4dr8VGqgI88BT9lRbPl2pc8Ibw61gavlLIk/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XbJH27XU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730205242; x=1761741242;
  h=date:from:to:cc:subject:message-id;
  bh=LzMDlL9U10o7ECbKJh1q3AeQCHYhZjzNpR8YBjdrmE4=;
  b=XbJH27XUhQw5HCp7IWTKYSS8ow7xpFuB2K6Jlvf0jdFZ/9DTTkNzCIr+
   P+//Pd8AxcCEz9EiPtiFMCLBzca7EqfeVjUpMMiLnbpe9yaF434RGI2Ay
   4aH/OqcNFwsqwYSRJzUlZ+TkgRuGAbHljGzRm/02LnRBCLEfad5pkeMMZ
   /IzP8JaH+zWIbzs/0WPFqe7VYYNLGXljp0Iw6ftgRW9hl29xzjZzDXtp8
   MpibUluOWrijcMqgP8GoFjBaC9EbtR/u/ZkDeB9iNQKZPgk4jl3brx/wX
   +4QWFtbkbjHvExd41K6ikv081m5JVsHye3eqzKRICbeQ3Sa/C7brB08kj
   A==;
X-CSE-ConnectionGUID: CLWOUoDiRLmIHYQey22gEQ==
X-CSE-MsgGUID: oGvKTk6MR2auwWQSV473Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52401152"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52401152"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 05:34:01 -0700
X-CSE-ConnectionGUID: W8BxTq+VSZiYoC8/0+5vxg==
X-CSE-MsgGUID: X7vpIw4sSw+BxGurJCMYgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="112759119"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 29 Oct 2024 05:33:59 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5lQ4-000ddy-2E;
	Tue, 29 Oct 2024 12:33:56 +0000
Date: Tue, 29 Oct 2024 20:32:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 60048d341beb5aaeeae5a39fd520bcc6030f80ea
Message-ID: <202410292050.j7DAsXAm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 60048d341beb5aaeeae5a39fd520bcc6030f80ea  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 1445m

configs tested: 255
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                         haps_hs_defconfig    gcc-13.2.0
arc                         haps_hs_defconfig    gcc-14.1.0
arc                   randconfig-001-20241029    gcc-13.2.0
arc                   randconfig-001-20241029    gcc-14.1.0
arc                   randconfig-002-20241029    gcc-13.2.0
arc                   randconfig-002-20241029    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                         assabet_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                          ep93xx_defconfig    clang-20
arm                            hisi_defconfig    gcc-14.1.0
arm                   milbeaut_m10v_defconfig    gcc-13.2.0
arm                        mvebu_v7_defconfig    gcc-13.2.0
arm                       netwinder_defconfig    gcc-14.1.0
arm                   randconfig-001-20241029    gcc-14.1.0
arm                   randconfig-002-20241029    gcc-14.1.0
arm                   randconfig-003-20241029    gcc-14.1.0
arm                   randconfig-004-20241029    clang-16
arm                   randconfig-004-20241029    gcc-14.1.0
arm                         vf610m4_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241029    clang-17
arm64                 randconfig-001-20241029    gcc-14.1.0
arm64                 randconfig-002-20241029    clang-20
arm64                 randconfig-002-20241029    gcc-14.1.0
arm64                 randconfig-003-20241029    gcc-14.1.0
arm64                 randconfig-004-20241029    clang-20
arm64                 randconfig-004-20241029    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241029    gcc-14.1.0
csky                  randconfig-002-20241029    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241029    clang-20
hexagon               randconfig-001-20241029    gcc-14.1.0
hexagon               randconfig-002-20241029    clang-20
hexagon               randconfig-002-20241029    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241029    clang-19
i386        buildonly-randconfig-002-20241029    clang-19
i386        buildonly-randconfig-002-20241029    gcc-12
i386        buildonly-randconfig-003-20241029    clang-19
i386        buildonly-randconfig-004-20241029    clang-19
i386        buildonly-randconfig-004-20241029    gcc-12
i386        buildonly-randconfig-005-20241029    clang-19
i386        buildonly-randconfig-006-20241029    clang-19
i386        buildonly-randconfig-006-20241029    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241029    clang-19
i386                  randconfig-001-20241029    gcc-12
i386                  randconfig-002-20241029    clang-19
i386                  randconfig-002-20241029    gcc-12
i386                  randconfig-003-20241029    clang-19
i386                  randconfig-003-20241029    gcc-12
i386                  randconfig-004-20241029    clang-19
i386                  randconfig-005-20241029    clang-19
i386                  randconfig-006-20241029    clang-19
i386                  randconfig-006-20241029    gcc-12
i386                  randconfig-011-20241029    clang-19
i386                  randconfig-011-20241029    gcc-12
i386                  randconfig-012-20241029    clang-19
i386                  randconfig-013-20241029    clang-19
i386                  randconfig-014-20241029    clang-19
i386                  randconfig-015-20241029    clang-19
i386                  randconfig-016-20241029    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241029    gcc-14.1.0
loongarch             randconfig-002-20241029    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5249evb_defconfig    clang-20
m68k                        mvme147_defconfig    gcc-13.2.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           ip32_defconfig    clang-20
mips                        omega2p_defconfig    gcc-14.1.0
mips                       rbtx49xx_defconfig    gcc-13.2.0
nios2                         10m50_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241029    gcc-14.1.0
nios2                 randconfig-002-20241029    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241029    gcc-14.1.0
parisc                randconfig-002-20241029    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                    adder875_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                 canyonlands_defconfig    clang-20
powerpc                        cell_defconfig    gcc-14.1.0
powerpc                        fsp2_defconfig    gcc-13.2.0
powerpc                       holly_defconfig    clang-20
powerpc                   motionpro_defconfig    clang-20
powerpc                     mpc512x_defconfig    clang-20
powerpc                  mpc866_ads_defconfig    gcc-14.1.0
powerpc                      pcm030_defconfig    gcc-13.2.0
powerpc                      pmac32_defconfig    gcc-13.2.0
powerpc                     ppa8548_defconfig    gcc-13.2.0
powerpc                       ppc64_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241029    gcc-14.1.0
powerpc               randconfig-002-20241029    clang-20
powerpc               randconfig-002-20241029    gcc-14.1.0
powerpc               randconfig-003-20241029    gcc-14.1.0
powerpc                 xes_mpc85xx_defconfig    clang-20
powerpc64             randconfig-001-20241029    gcc-14.1.0
powerpc64             randconfig-002-20241029    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-13.2.0
riscv                 randconfig-001-20241029    clang-20
riscv                 randconfig-001-20241029    gcc-14.1.0
riscv                 randconfig-002-20241029    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                                defconfig    gcc-14.1.0
s390                  randconfig-001-20241029    gcc-14.1.0
s390                  randconfig-002-20241029    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                               j2_defconfig    gcc-13.2.0
sh                    randconfig-001-20241029    gcc-14.1.0
sh                    randconfig-002-20241029    gcc-14.1.0
sh                          rsk7203_defconfig    clang-20
sh                          sdk7780_defconfig    clang-20
sh                          sdk7780_defconfig    gcc-13.2.0
sh                           se7712_defconfig    clang-20
sh                           se7750_defconfig    clang-20
sh                           se7780_defconfig    gcc-13.2.0
sh                           sh2007_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241029    gcc-14.1.0
sparc64               randconfig-002-20241029    gcc-14.1.0
um                               alldefconfig    gcc-13.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241029    gcc-14.1.0
um                    randconfig-002-20241029    gcc-12
um                    randconfig-002-20241029    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241029    clang-19
x86_64      buildonly-randconfig-001-20241029    gcc-12
x86_64      buildonly-randconfig-002-20241029    clang-19
x86_64      buildonly-randconfig-002-20241029    gcc-12
x86_64      buildonly-randconfig-003-20241029    clang-19
x86_64      buildonly-randconfig-003-20241029    gcc-12
x86_64      buildonly-randconfig-004-20241029    clang-19
x86_64      buildonly-randconfig-004-20241029    gcc-12
x86_64      buildonly-randconfig-005-20241029    clang-19
x86_64      buildonly-randconfig-006-20241029    clang-19
x86_64      buildonly-randconfig-006-20241029    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241029    clang-19
x86_64                randconfig-001-20241029    gcc-12
x86_64                randconfig-002-20241029    clang-19
x86_64                randconfig-003-20241029    clang-19
x86_64                randconfig-003-20241029    gcc-12
x86_64                randconfig-004-20241029    clang-19
x86_64                randconfig-005-20241029    clang-19
x86_64                randconfig-005-20241029    gcc-12
x86_64                randconfig-006-20241029    clang-19
x86_64                randconfig-006-20241029    gcc-12
x86_64                randconfig-011-20241029    clang-19
x86_64                randconfig-012-20241029    clang-19
x86_64                randconfig-013-20241029    clang-19
x86_64                randconfig-014-20241029    clang-19
x86_64                randconfig-015-20241029    clang-19
x86_64                randconfig-015-20241029    gcc-12
x86_64                randconfig-016-20241029    clang-19
x86_64                randconfig-016-20241029    gcc-12
x86_64                randconfig-071-20241029    clang-19
x86_64                randconfig-071-20241029    gcc-12
x86_64                randconfig-072-20241029    clang-19
x86_64                randconfig-072-20241029    gcc-12
x86_64                randconfig-073-20241029    clang-19
x86_64                randconfig-073-20241029    gcc-12
x86_64                randconfig-074-20241029    clang-19
x86_64                randconfig-075-20241029    clang-19
x86_64                randconfig-075-20241029    gcc-12
x86_64                randconfig-076-20241029    clang-19
x86_64                randconfig-076-20241029    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  audio_kc705_defconfig    gcc-13.2.0
xtensa                  audio_kc705_defconfig    gcc-14.1.0
xtensa                       common_defconfig    clang-20
xtensa                randconfig-001-20241029    gcc-14.1.0
xtensa                randconfig-002-20241029    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

