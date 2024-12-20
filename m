Return-Path: <linux-acpi+bounces-10217-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD47E9F9B1A
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 21:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8CE169CE3
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 20:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B4E221451;
	Fri, 20 Dec 2024 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6TVuuNw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A9021A42D;
	Fri, 20 Dec 2024 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734726136; cv=none; b=oW0kHCvTBOE4epPQBMNm9TOL2e6EHB64ih809YruFSnBti12FYBLmbf7/ZqgSijVEQEOjbiNU89GQXX8IBivCvpkWXUlqA2McDaszNFisddemNLKYQ/clrInTHDw2v8qh2yrJ0V48sMJdj3ORMCE18C3Wa0c3Z4efsMuSLRSQ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734726136; c=relaxed/simple;
	bh=qVwmV6W6mJCHXjYiVxXO94cH5FhJCHktBD7Sj9wo4/Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BByJ4v3bx++Q0719ZJWVy3iM5QBrmMyZ4uoBOTB85rPet5vtfCCA4uFkhbPhPS5nhDiAcTrJx/c5kWc5dYFi5phM444N89vbaPLPWLNOvavKhkOUe4Y4lKU7O9bwSqUCu4Llg9ct0G0UvbULNlt3k7H5VQk+HDQNtrkcfGs0Chc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6TVuuNw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734726135; x=1766262135;
  h=date:from:to:cc:subject:message-id;
  bh=qVwmV6W6mJCHXjYiVxXO94cH5FhJCHktBD7Sj9wo4/Y=;
  b=J6TVuuNw9cEHhBtBV8cAy+vL0NbYTGTSJofMkP44UWNTfo+RnhQIgAoh
   kvL2KTLae/TBVC4Je6XDsQbcktg0NL1o2wyvQ5VFTw3PFd0xqJbko2bkB
   LfFzcnOQvsUmOtQvTksWTIw1tgsOTrcJpcQNyB5YOWj78qRN0B039h7Dl
   oUI0OfmXPgbVDWGJp94HqtpTP05wHtRxNFqktIgbwKTs+AKYehWLDpP4s
   X3zpaO1mBq32LeiCxjpe3u/NDqrfi3cDDSjd7fh3+3O2Q/kpQpUqw89DC
   gc4gcWnE+sN4THxbbh1Q9y7T/pHV+YcEG0/KFgl7cpoNIhjMVmrCbqKMg
   A==;
X-CSE-ConnectionGUID: fpEh+1sTTViOlE+nUApl1A==
X-CSE-MsgGUID: JUgs8X+yTjyNc1uJSa+2tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="34999200"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="34999200"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 12:22:13 -0800
X-CSE-ConnectionGUID: /jguWr7TTim47jtm45jPug==
X-CSE-MsgGUID: ksHKphcTROO35vG71g7XCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="99123566"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 20 Dec 2024 12:22:11 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOjVh-0001eX-19;
	Fri, 20 Dec 2024 20:22:09 +0000
Date: Sat, 21 Dec 2024 04:21:53 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 ea7e5e98b3e491f2bd6204bfb333643cf9429788
Message-ID: <202412210447.jWpHJv4Y-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: ea7e5e98b3e491f2bd6204bfb333643cf9429788  Merge branch 'acpi-property' into bleeding-edge

elapsed time: 1446m

configs tested: 82
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                              allnoconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20241220    gcc-13.2.0
arc                  randconfig-002-20241220    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                  randconfig-001-20241220    clang-19
arm                  randconfig-002-20241220    gcc-14.2.0
arm                  randconfig-003-20241220    gcc-14.2.0
arm                  randconfig-004-20241220    clang-20
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20241220    clang-17
arm64                randconfig-002-20241220    clang-19
arm64                randconfig-003-20241220    clang-20
arm64                randconfig-004-20241220    clang-19
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20241220    gcc-14.2.0
csky                 randconfig-002-20241220    gcc-14.2.0
hexagon                          allnoconfig    clang-20
hexagon              randconfig-001-20241220    clang-20
hexagon              randconfig-002-20241220    clang-20
i386                             allnoconfig    gcc-12
i386       buildonly-randconfig-001-20241220    gcc-12
i386       buildonly-randconfig-002-20241220    gcc-12
i386       buildonly-randconfig-003-20241220    gcc-12
i386       buildonly-randconfig-004-20241220    clang-19
i386       buildonly-randconfig-005-20241220    gcc-12
i386       buildonly-randconfig-006-20241220    gcc-12
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20241220    gcc-14.2.0
loongarch            randconfig-002-20241220    gcc-14.2.0
mips                          jazz_defconfig    clang-20
nios2                randconfig-001-20241220    gcc-14.2.0
nios2                randconfig-002-20241220    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20241220    gcc-14.2.0
parisc               randconfig-002-20241220    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc                     ep88xc_defconfig    gcc-14.2.0
powerpc                    mpc83xx_defconfig    clang-20
powerpc              randconfig-001-20241220    clang-15
powerpc              randconfig-002-20241220    gcc-14.2.0
powerpc              randconfig-003-20241220    gcc-14.2.0
powerpc                    tqm8548_defconfig    clang-19
powerpc64            randconfig-001-20241220    gcc-14.2.0
powerpc64            randconfig-002-20241220    clang-19
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20241220    gcc-14.2.0
riscv                randconfig-002-20241220    clang-19
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-20
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241220    gcc-14.2.0
s390                 randconfig-002-20241220    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                         kfr2r09_defconfig    gcc-14.2.0
sh                   randconfig-001-20241220    gcc-14.2.0
sh                   randconfig-002-20241220    gcc-14.2.0
sh                         rsk7201_defconfig    gcc-14.2.0
sh                            sh03_defconfig    gcc-14.2.0
sh                          sh2007_defconfig    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20241220    gcc-14.2.0
sparc                randconfig-002-20241220    gcc-14.2.0
sparc64              randconfig-001-20241220    gcc-14.2.0
sparc64              randconfig-002-20241220    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20241220    clang-20
um                   randconfig-002-20241220    clang-20
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20241220    gcc-12
x86_64     buildonly-randconfig-002-20241220    clang-19
x86_64     buildonly-randconfig-003-20241220    gcc-12
x86_64     buildonly-randconfig-004-20241220    gcc-12
x86_64     buildonly-randconfig-005-20241220    clang-19
x86_64     buildonly-randconfig-006-20241220    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20241220    gcc-14.2.0
xtensa               randconfig-002-20241220    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

