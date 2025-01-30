Return-Path: <linux-acpi+bounces-10860-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B648A22753
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Jan 2025 01:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369D23A565D
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Jan 2025 00:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F198BEC;
	Thu, 30 Jan 2025 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b17FKbka"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4534F28E8;
	Thu, 30 Jan 2025 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738198214; cv=none; b=gwnX9EWfOgSd1Y0YuocMkB/K8gMVWwPgNneSa9nLadxKjQ6SvNYoqF4e7jK/aMes8cmfvxUarMikC0QhhGtYF0yPX7w7RAvAZuhUA8+bIXWwbEuuHIBTuh3GSM9H6UEPr7v22djmtCPs4YND6QMObtCRC6+7CysxB8lTdQdRoTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738198214; c=relaxed/simple;
	bh=75zDwalyUL9Xy2WOefV40/p22DRndy1S2974PSV2H6g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tav9yX1URDfmyQuGyLfmabY2ORkOUQmJJiyJCaMUAj6O4j/Z2NRIBuLCBSvttKDrBRMkNLIJ9VbgukRXb6vp3PK8J24+X1QuKGnAFCId88588uB+uwWTDEsCorx9pdSYr0rwcxA5ACng1E5TAe8mZWfbFsWaMVJgIzq9MiICjHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b17FKbka; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738198212; x=1769734212;
  h=date:from:to:cc:subject:message-id;
  bh=75zDwalyUL9Xy2WOefV40/p22DRndy1S2974PSV2H6g=;
  b=b17FKbkafxPMUZp2dDySlA6vugOLZmSdc/8v4AfsdiOlc/3yxJ4bl+z1
   UnItdhcERsr3t9gdg0xPXSnwECqmSS1mzcqz9Me4oq84N3l54qTotKfmY
   M8I3/bnIHWoy7od9I/9OI0/9x9uqBufRgWxaSCMiXGBWZEDg/z6wNBJ8h
   S0pVuq1w9Uc0uJERxiGjz8E81Od+YhFLaov+bAE4bMbnvXvAQoYNZrH5j
   VELgzb8V4fhQsnIFFwbBtNsWZ96vdz46Kp8PHKvtctSrhzlkZT39iMfX5
   xihTew9wBgT+gSe+KeS/rRwk+kijpHp0gyem3FZKGynxW/eQdA1/rinqM
   Q==;
X-CSE-ConnectionGUID: DtfHKndESmCQJxIukuGGGQ==
X-CSE-MsgGUID: T02UpxgYRH63FWsnxODaWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="64099631"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="64099631"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 16:50:11 -0800
X-CSE-ConnectionGUID: 1OztK+OBR9CYOlfKnnSgFg==
X-CSE-MsgGUID: a2/ambtARVKESwCI1kQ2rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="109780844"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 29 Jan 2025 16:50:10 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tdIky-000jVz-14;
	Thu, 30 Jan 2025 00:50:08 +0000
Date: Thu, 30 Jan 2025 08:49:20 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 6bbc34fd9d99332e5d9f15263034f6f682bf4f61
Message-ID: <202501300814.QDJE2hrX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 6bbc34fd9d99332e5d9f15263034f6f682bf4f61  Merge branch 'experimental/intel_pstate/eas-take1' into bleeding-edge

elapsed time: 783m

configs tested: 124
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-13.2.0
arc                   randconfig-001-20250129    gcc-13.2.0
arc                   randconfig-002-20250129    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                        multi_v7_defconfig    gcc-14.2.0
arm                   randconfig-001-20250129    gcc-14.2.0
arm                   randconfig-002-20250129    clang-20
arm                   randconfig-003-20250129    gcc-14.2.0
arm                   randconfig-004-20250129    gcc-14.2.0
arm                           stm32_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250129    gcc-14.2.0
arm64                 randconfig-002-20250129    gcc-14.2.0
arm64                 randconfig-003-20250129    gcc-14.2.0
arm64                 randconfig-004-20250129    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250129    gcc-14.2.0
csky                  randconfig-002-20250129    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250129    clang-19
hexagon               randconfig-002-20250129    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250129    clang-19
i386        buildonly-randconfig-002-20250129    gcc-12
i386        buildonly-randconfig-003-20250129    clang-19
i386        buildonly-randconfig-004-20250129    clang-19
i386        buildonly-randconfig-005-20250129    clang-19
i386        buildonly-randconfig-006-20250129    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250129    gcc-14.2.0
loongarch             randconfig-002-20250129    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                     loongson1b_defconfig    clang-20
mips                        omega2p_defconfig    clang-16
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250129    gcc-14.2.0
nios2                 randconfig-002-20250129    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250129    gcc-14.2.0
parisc                randconfig-002-20250129    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                 linkstation_defconfig    clang-20
powerpc               randconfig-001-20250129    clang-20
powerpc               randconfig-002-20250129    clang-20
powerpc               randconfig-003-20250129    gcc-14.2.0
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc                         wii_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250129    clang-16
powerpc64             randconfig-002-20250129    clang-18
powerpc64             randconfig-003-20250129    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250129    gcc-14.2.0
riscv                 randconfig-002-20250129    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250129    clang-20
s390                  randconfig-002-20250129    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250129    gcc-14.2.0
sh                    randconfig-002-20250129    gcc-14.2.0
sh                           se7722_defconfig    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250129    gcc-14.2.0
sparc                 randconfig-002-20250129    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250129    gcc-14.2.0
sparc64               randconfig-002-20250129    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250129    gcc-12
um                    randconfig-002-20250129    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250129    clang-19
x86_64      buildonly-randconfig-002-20250129    gcc-12
x86_64      buildonly-randconfig-003-20250129    gcc-12
x86_64      buildonly-randconfig-004-20250129    gcc-12
x86_64      buildonly-randconfig-005-20250129    gcc-12
x86_64      buildonly-randconfig-006-20250129    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250129    gcc-14.2.0
xtensa                randconfig-002-20250129    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

