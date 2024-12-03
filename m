Return-Path: <linux-acpi+bounces-9896-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E60CF9E1681
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 10:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B182838B7
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Dec 2024 09:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246441DE4E0;
	Tue,  3 Dec 2024 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R1HkmmoX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92111DE4DF;
	Tue,  3 Dec 2024 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733216358; cv=none; b=oJOdm0wSMjNpNWcPnx63G/tDIfhouW7FhaLov0GhBqL6MeYF7yGbJH8uyu9rDjM/9S2DijK21e6NXQhnffnULWPLCKb05ifk09IBs+h/8uNfCezjwufwZXQ1E8j+6PiSKoPPABQAliQfx0jLt8wWKsa4uOfk/IjkfqLRom1c5Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733216358; c=relaxed/simple;
	bh=216y/JwJRc9Rw/jR9BtNpHzSocQbW2QJLkmgKgwJNb4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SSouRCW0pFA6gS5KWqCHpZZ+k/7s4GPSh3l4ccDejIqo60lavJ7xyvAESXlnj99lCwgQyJeiMhcpofmD0tkaG9slGao+cADkqzgOmLGjE2tVLXPZz274TgFI4qzynjT9mVCM+9YxuwL1kwU4TuLbytuMH0oyDd/OirsthXTA+34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R1HkmmoX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733216356; x=1764752356;
  h=date:from:to:cc:subject:message-id;
  bh=216y/JwJRc9Rw/jR9BtNpHzSocQbW2QJLkmgKgwJNb4=;
  b=R1HkmmoXedLHFJ+pJYsQsO4lLNJTg1jgeeIdMzsKTZ/OE6uy+xo7o2r5
   L/nKa+E5qHuv9eWYWpS8fMUirsXOHPVM0XyB5l/QuEG7o8OU6ntXHvi74
   HYxMGDOA+9LM/JSiYJHBOcyVCaRK+FOtIk2zPlNGXavaDZ6QqknfEp1v9
   AASgHmHzunW0xbr8clwuc7r2my4Wt04epXiGD++3Ed2unJeUvvt8r0Y3x
   jsZmkvBbOBromgwjh0hjyiloAzkj8hAJya5luaZNeD2JgHgpAmrGiJA1f
   hBExz14sMvRAW1ZY+sOpDLazHC4IufMYfdWxWQRUM+NFZI44C2OYvzzq5
   w==;
X-CSE-ConnectionGUID: sp14uF5WRs+4Tj9F2shMtA==
X-CSE-MsgGUID: bfUHQ6JgTMuEbR3ihMjhuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44801659"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="44801659"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 00:59:15 -0800
X-CSE-ConnectionGUID: N6JPwd0cTqajCkQbNhHkZw==
X-CSE-MsgGUID: F5nj7zhXTgScETOdoSh2XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="130835254"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 03 Dec 2024 00:59:14 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIOkR-0000RF-1F;
	Tue, 03 Dec 2024 08:59:11 +0000
Date: Tue, 03 Dec 2024 16:56:22 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 4d27d1319cc08e4c4ed497c97360eb6e1489eeb1
Message-ID: <202412031612.UVfLbXnt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 4d27d1319cc08e4c4ed497c97360eb6e1489eeb1  Merge branch 'experimental/intel_pstate' into bleeding-edge

elapsed time: 900m

configs tested: 132
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                            hsdk_defconfig    gcc-14.2.0
arc                        nsim_700_defconfig    clang-14
arc                   randconfig-001-20241203    clang-20
arc                   randconfig-001-20241203    gcc-13.2.0
arc                   randconfig-002-20241203    clang-20
arc                   randconfig-002-20241203    gcc-13.2.0
arc                    vdk_hs38_smp_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                         at91_dt_defconfig    gcc-14.2.0
arm                          ep93xx_defconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    clang-14
arm                         mv78xx0_defconfig    gcc-14.2.0
arm                            qcom_defconfig    clang-14
arm                   randconfig-001-20241203    clang-20
arm                   randconfig-002-20241203    clang-20
arm                   randconfig-002-20241203    gcc-14.2.0
arm                   randconfig-003-20241203    clang-20
arm                   randconfig-004-20241203    clang-20
arm                        realview_defconfig    clang-14
arm                           stm32_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241203    clang-20
arm64                 randconfig-001-20241203    gcc-14.2.0
arm64                 randconfig-002-20241203    clang-20
arm64                 randconfig-002-20241203    gcc-14.2.0
arm64                 randconfig-003-20241203    clang-20
arm64                 randconfig-003-20241203    gcc-14.2.0
arm64                 randconfig-004-20241203    clang-20
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
i386        buildonly-randconfig-001-20241203    clang-19
i386        buildonly-randconfig-001-20241203    gcc-12
i386        buildonly-randconfig-002-20241203    clang-19
i386        buildonly-randconfig-002-20241203    gcc-12
i386        buildonly-randconfig-003-20241203    clang-19
i386        buildonly-randconfig-004-20241203    clang-19
i386        buildonly-randconfig-005-20241203    clang-19
i386        buildonly-randconfig-006-20241203    clang-19
i386        buildonly-randconfig-006-20241203    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    clang-14
m68k                        stmark2_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                  cavium_octeon_defconfig    gcc-14.2.0
mips                          eyeq5_defconfig    gcc-14.2.0
mips                           ip28_defconfig    gcc-14.2.0
mips                      maltaaprp_defconfig    clang-14
mips                        qi_lb60_defconfig    gcc-14.2.0
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    clang-14
parisc                generic-64bit_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     asp8347_defconfig    gcc-14.2.0
powerpc                   currituck_defconfig    gcc-14.2.0
powerpc                       eiger_defconfig    gcc-14.2.0
powerpc                        fsp2_defconfig    clang-14
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                   motionpro_defconfig    gcc-14.2.0
powerpc                     mpc5200_defconfig    clang-14
powerpc                     tqm8541_defconfig    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                               j2_defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    gcc-14.2.0
sh                          rsk7203_defconfig    clang-14
sh                           se7705_defconfig    clang-14
sh                           se7724_defconfig    gcc-14.2.0
sh                           se7780_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sh                        sh7785lcr_defconfig    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc64                          alldefconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
x86_64      buildonly-randconfig-001-20241203    gcc-11
x86_64      buildonly-randconfig-002-20241203    gcc-11
x86_64      buildonly-randconfig-003-20241203    gcc-11
x86_64      buildonly-randconfig-004-20241203    gcc-11
x86_64      buildonly-randconfig-005-20241203    gcc-11
x86_64      buildonly-randconfig-006-20241203    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    clang-14
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

