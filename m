Return-Path: <linux-acpi+bounces-13963-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E02BAC8976
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 09:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D3D4A6558
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 07:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F09213245;
	Fri, 30 May 2025 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XIuED9oH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56419211460;
	Fri, 30 May 2025 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748591574; cv=none; b=i0KrwDeFQ3DEpBQRwbGdKfIcTgqAjkuqAcPk5iMMq7FyL3sVBSRxTcDFoCuAmoCrD2OqbzQka0lOTxRuhmtAXOKfZbxNB9JQkg9JPPfe/9OxrsJuurKlo4OB8oweozZhfUc/dLrbGUvFiHl4ots/iApG4Pqpj/LFibjJseXAh24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748591574; c=relaxed/simple;
	bh=K5dSVwIVW/FBL+ZH0NxZ2BqtndkMuVUmpC8GJC88b1c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=p+ftJpnaeTp9jaGPGcJ8dFrQFpXlGzhFbIW0pPuditkM+4RXmgHQMMpL0mNiWnb2+grYI6GepG2j0Oz2k8ilPf76jI4jjZF2rra/HtTcKbEYyx+6mw4gvTGLDchVo2ZIYUiH4zhyGfOhVwkKhwEjU4uweipdJkmDL8GHla40L90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XIuED9oH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748591572; x=1780127572;
  h=date:from:to:cc:subject:message-id;
  bh=K5dSVwIVW/FBL+ZH0NxZ2BqtndkMuVUmpC8GJC88b1c=;
  b=XIuED9oHQJ9tocN8B3FZzDrM+YqQuVp4g5lIU/P5Ut47iBxYNXJdlC8o
   MQfU+E9mRJLS1x057Qi/6wgcGpqffvprSsmDQtmV20nrbqtL/uV4YBLA/
   4oYajEb1JVXD4iS/OXeP5fTZ+MA5lJZgpO7/HNNbz85w1Kz0V9GxxD6C3
   PzganjTa5JSJlBfnBETXmABtgyrkHB1dDiCiVPNoosDmXxAlflyt0iZLf
   4aNPoiuG5rvAkLa4diFty7mQqPv6PUdKs461WObihELw4dmTgBAh1Zicu
   IU57GDIixmlYypjW+MKS1/v0nEw3lhKAbz8ckem5cQpi/3vvHQoUYEJ+g
   A==;
X-CSE-ConnectionGUID: 4xBfgVUPQfGWK83ZIzNnnQ==
X-CSE-MsgGUID: wDOzUOiIR8azhodLKD0q+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50373897"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="50373897"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 00:52:51 -0700
X-CSE-ConnectionGUID: ficwK+TLSJ6BriSeWu2HzA==
X-CSE-MsgGUID: +T/Phlu0T2K/qIclkw2cEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="148951324"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 30 May 2025 00:52:50 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKuXo-000XRc-1g;
	Fri, 30 May 2025 07:52:48 +0000
Date: Fri, 30 May 2025 15:51:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 5cce23844086fca1de955e8626d3f55af2c7588a
Message-ID: <202505301545.EKoYjkh8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 5cce23844086fca1de955e8626d3f55af2c7588a  Merge branch 'pm-sleep-testing' into bleeding-edge

elapsed time: 731m

configs tested: 124
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250530    gcc-15.1.0
arc                   randconfig-002-20250530    gcc-10.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                       imx_v6_v7_defconfig    clang-16
arm                         mv78xx0_defconfig    clang-19
arm                   randconfig-001-20250530    gcc-15.1.0
arm                   randconfig-002-20250530    gcc-14.3.0
arm                   randconfig-003-20250530    clang-21
arm                   randconfig-004-20250530    clang-21
arm                           sama5_defconfig    gcc-15.1.0
arm                           sunxi_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250530    gcc-12.3.0
arm64                 randconfig-002-20250530    gcc-5.5.0
arm64                 randconfig-003-20250530    gcc-7.5.0
arm64                 randconfig-004-20250530    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250530    gcc-15.1.0
csky                  randconfig-002-20250530    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250530    clang-21
hexagon               randconfig-002-20250530    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250530    clang-20
i386        buildonly-randconfig-002-20250530    clang-20
i386        buildonly-randconfig-003-20250530    clang-20
i386        buildonly-randconfig-004-20250530    clang-20
i386        buildonly-randconfig-005-20250530    clang-20
i386        buildonly-randconfig-006-20250530    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250530    gcc-15.1.0
loongarch             randconfig-002-20250530    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath79_defconfig    gcc-15.1.0
mips                  cavium_octeon_defconfig    gcc-15.1.0
mips                        qi_lb60_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250530    gcc-5.5.0
nios2                 randconfig-002-20250530    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20250530    gcc-12.4.0
parisc                randconfig-002-20250530    gcc-8.5.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                   bluestone_defconfig    clang-21
powerpc                  iss476-smp_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250530    gcc-14.3.0
powerpc               randconfig-002-20250530    clang-21
powerpc               randconfig-003-20250530    gcc-8.5.0
powerpc                    sam440ep_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250530    gcc-14.3.0
powerpc64             randconfig-002-20250530    clang-21
powerpc64             randconfig-003-20250530    gcc-15.1.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250530    gcc-15.1.0
riscv                 randconfig-002-20250530    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250530    clang-20
s390                  randconfig-002-20250530    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                          polaris_defconfig    gcc-15.1.0
sh                    randconfig-001-20250530    gcc-14.3.0
sh                    randconfig-002-20250530    gcc-15.1.0
sh                           se7206_defconfig    gcc-15.1.0
sh                           se7343_defconfig    gcc-15.1.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250530    gcc-8.5.0
sparc                 randconfig-002-20250530    gcc-10.3.0
sparc64               randconfig-001-20250530    gcc-8.5.0
sparc64               randconfig-002-20250530    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250530    gcc-11
um                    randconfig-002-20250530    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250530    clang-20
x86_64      buildonly-randconfig-002-20250530    clang-20
x86_64      buildonly-randconfig-003-20250530    gcc-12
x86_64      buildonly-randconfig-004-20250530    gcc-11
x86_64      buildonly-randconfig-005-20250530    clang-20
x86_64      buildonly-randconfig-006-20250530    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                           alldefconfig    gcc-15.1.0
xtensa                            allnoconfig    gcc-15.1.0
xtensa                          iss_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250530    gcc-15.1.0
xtensa                randconfig-002-20250530    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

