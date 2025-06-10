Return-Path: <linux-acpi+bounces-14280-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9163BAD4815
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 03:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B31189E8B0
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 01:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECF01494A8;
	Wed, 11 Jun 2025 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHSiy12I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF161448E0;
	Wed, 11 Jun 2025 01:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749606089; cv=none; b=Km43RKXaU20Mfuf2ic3jW050c0DrxHLDXEkPQrB+OXdFQSP8BTPzp4MwOKO9RwXFoEfjVFZsUXYW8M2m9l9yDu+hyX5nTm3FmmBbT0lQ8xmO0pfwBTNZX5Sd5iagdSPxODhCfYtRoI3FwQEvHhtjMrKhHGual/dkZ+PZL2RzUTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749606089; c=relaxed/simple;
	bh=u41mkmUDzxubS0K7NdxLbld4sch3WaFTFIcrjf+nUIQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lzEt+XusTH2kvWCZj0dvgE8rb/FTE/D4BEzvw9BVEH+uMIGQOiPmad8DLJRL6y5f+mTFXQhgR2WfpFpYA+7/7sjUOro/MGmiQoP2fvTEJPtqNggV04nUIj7Ke5th+MvgZUUxJQeS2DWmvo+rbtu0Damc4XO2k+z+P8kHNucCtA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iHSiy12I; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749606089; x=1781142089;
  h=date:from:to:cc:subject:message-id;
  bh=u41mkmUDzxubS0K7NdxLbld4sch3WaFTFIcrjf+nUIQ=;
  b=iHSiy12IUDrfKpJ3iZjT0m89lTgHA63LAByIuXlaQCmkBEYgR+V0EnLl
   lGLQp8mMEov2gzNRFXNx8xF8K9XegFa4jh7btG8oMCI1hSw05Dx6MvXUt
   eL9w59iRoTLdhHoW8lvvLgcY7YylbZSelsTQK9TCmYlUrBPlOWOP3DItl
   dFbmF1QPFXcNC0Qg9Xgv2Zx3Ztl6CAqaO090RwXRyC1OSLngMR1hIxA2J
   Sly7/y2tmXg5juDVQayEqIJlWkekq/BM8ujSG942yvG8Z6/XakSCpJdnr
   BNcpZj4RmEws+UwSECejZkf/LZWxb2it/8R+wKk21LDfqvgus5+kb/WOV
   w==;
X-CSE-ConnectionGUID: PcaXbyBYR7quoaj8oQj60g==
X-CSE-MsgGUID: 8PeZK4Y2QhSe7pwNQVh2ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51613708"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="51613708"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 18:41:28 -0700
X-CSE-ConnectionGUID: okarfdD+TWSimBkQ9bSTbA==
X-CSE-MsgGUID: EqkP/pxDTWKisXYsA7XcNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="184188344"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 10 Jun 2025 18:41:26 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uP5wC-0008kH-1e;
	Tue, 10 Jun 2025 20:51:16 +0000
Date: Wed, 11 Jun 2025 04:51:07 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 1c1f19a32b73c8cff3605411b7f6f4050a044cfc
Message-ID: <202506110457.JYBiteoh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 1c1f19a32b73c8cff3605411b7f6f4050a044cfc  Merge branch 'pm-sleep-testing' into bleeding-edge

elapsed time: 1427m

configs tested: 133
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                            hsdk_defconfig    gcc-15.1.0
arc                   randconfig-001-20250610    gcc-12.4.0
arc                   randconfig-002-20250610    gcc-14.3.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-21
arm                         lpc32xx_defconfig    clang-17
arm                   randconfig-001-20250610    clang-19
arm                   randconfig-002-20250610    gcc-8.5.0
arm                   randconfig-003-20250610    clang-21
arm                   randconfig-004-20250610    clang-16
arm                           sama5_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250610    clang-21
arm64                 randconfig-002-20250610    gcc-11.5.0
arm64                 randconfig-003-20250610    clang-21
arm64                 randconfig-004-20250610    clang-18
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250610    gcc-12.4.0
csky                  randconfig-002-20250610    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250610    clang-21
hexagon               randconfig-002-20250610    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250610    clang-20
i386        buildonly-randconfig-002-20250610    clang-20
i386        buildonly-randconfig-003-20250610    clang-20
i386        buildonly-randconfig-004-20250610    gcc-12
i386        buildonly-randconfig-005-20250610    clang-20
i386        buildonly-randconfig-006-20250610    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                 loongson3_defconfig    gcc-15.1.0
loongarch             randconfig-001-20250610    gcc-15.1.0
loongarch             randconfig-002-20250610    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250610    gcc-8.5.0
nios2                 randconfig-002-20250610    gcc-13.3.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250610    gcc-10.5.0
parisc                randconfig-002-20250610    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc                  mpc866_ads_defconfig    clang-21
powerpc                     ppa8548_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250610    gcc-10.5.0
powerpc               randconfig-002-20250610    gcc-8.5.0
powerpc               randconfig-003-20250610    clang-21
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250610    clang-21
powerpc64             randconfig-002-20250610    clang-21
riscv                            alldefconfig    gcc-15.1.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250610    gcc-14.3.0
riscv                 randconfig-002-20250610    clang-16
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250610    gcc-8.5.0
s390                  randconfig-002-20250610    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250610    gcc-9.3.0
sh                    randconfig-002-20250610    gcc-15.1.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sh                             shx3_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250610    gcc-15.1.0
sparc                 randconfig-002-20250610    gcc-12.4.0
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250610    gcc-8.5.0
sparc64               randconfig-002-20250610    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250610    gcc-11
um                    randconfig-002-20250610    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250610    clang-20
x86_64      buildonly-randconfig-002-20250610    gcc-12
x86_64      buildonly-randconfig-003-20250610    clang-20
x86_64      buildonly-randconfig-004-20250610    clang-20
x86_64      buildonly-randconfig-005-20250610    gcc-12
x86_64      buildonly-randconfig-006-20250610    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                       common_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250610    gcc-11.5.0
xtensa                randconfig-002-20250610    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

