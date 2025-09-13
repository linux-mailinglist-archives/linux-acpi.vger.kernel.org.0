Return-Path: <linux-acpi+bounces-16851-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F41B56077
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 13:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC8587B63E1
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 11:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE06B2EBB81;
	Sat, 13 Sep 2025 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lY4fcl/Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F44BA3D;
	Sat, 13 Sep 2025 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757762250; cv=none; b=A1NHrhYVA1IJze2RTHAbcHpSAo/aF2JdGA7+S+u+AHLv34cBsXC5sLezSvf1uMlB7WxKtB8ASHFBUsdBjzr5m5NKCu0N5HVtPjZokBSiOp6Y8HcxPrYiWjwZtCvK3OM28ndIADOs5LH7AkwU17A6w7xNSAwo3zPHo9ttnea3X6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757762250; c=relaxed/simple;
	bh=XdfudGsJ66XwG0gkyNljGBJm8lx+OQP/EWf0I9/qss8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aqIBFz+2PpYkXwor9QNDg4SvJNUH4cBVagkCC24PLWPMvkE5NNh4ZnjMBnFAoWTq1alUNH4+smojcN5KXyUOQ7FyBx4FLWExthjM3QXrgK8r7SWSYQI8jCykPwb7QEwKHhnFd471oCVhdsZ4S9MO1dl64Ntsf/eHLxMlb7GC4KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lY4fcl/Z; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757762249; x=1789298249;
  h=date:from:to:cc:subject:message-id;
  bh=XdfudGsJ66XwG0gkyNljGBJm8lx+OQP/EWf0I9/qss8=;
  b=lY4fcl/ZHF9WMmginTu46UqwQuJiyLGSExgYINvaZ0QG4L4qrHV4R0vM
   Wg8MdHq/SpielvYATpFJ3b8d/+k8vejsiYs2TOl7I6tTjhGU3paGY+0cC
   VlgF/Hv5QKGzIgRpTDM+Qp11tE1Q2DWe0Tqd2wZ96TlZayWqvKGrCFJHT
   Lv+F++pVhpz+RswZB5Zi/2gz1HNzF1k65sSJdCtf5JlO3Fw9JSMub2so2
   ZIQAO/HULstEOxvULWmvnNoIl1fNm5RRckD6BjmYY5wv9/3ptAg1BAvHq
   Da4kHNoXbe6zbzKABfkhJ6i/BTLjk0J9cHHK2eHi8NOPReoefiUO/QSdi
   A==;
X-CSE-ConnectionGUID: qNYTeYuJT7q6AN3eTfsY4g==
X-CSE-MsgGUID: EKxLL4j0SWK9lGoTFRXDRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60149524"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60149524"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2025 04:17:28 -0700
X-CSE-ConnectionGUID: jFYISAV/RCiSoqlRLbVjZQ==
X-CSE-MsgGUID: 6m7lhzzmSr6vaNnOf/IaIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,261,1751266800"; 
   d="scan'208";a="205185068"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 13 Sep 2025 04:17:26 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uxOFw-0001TE-2D;
	Sat, 13 Sep 2025 11:17:24 +0000
Date: Sat, 13 Sep 2025 19:17:09 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 554127961c3c6e0c7faf03e3434202ac1c6cf311
Message-ID: <202509131958.ck6PK1Ni-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 554127961c3c6e0c7faf03e3434202ac1c6cf311  Merge branch 'pm-cpuidle' into linux-next

elapsed time: 1451m

configs tested: 148
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250912    gcc-10.5.0
arc                   randconfig-001-20250913    gcc-10.5.0
arc                   randconfig-002-20250912    gcc-12.5.0
arc                   randconfig-002-20250913    gcc-11.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250912    clang-22
arm                   randconfig-001-20250913    clang-20
arm                   randconfig-002-20250912    gcc-14.3.0
arm                   randconfig-002-20250913    clang-22
arm                   randconfig-003-20250912    clang-22
arm                   randconfig-003-20250913    clang-22
arm                   randconfig-004-20250912    gcc-10.5.0
arm                   randconfig-004-20250913    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250912    clang-20
arm64                 randconfig-001-20250913    clang-22
arm64                 randconfig-002-20250912    clang-16
arm64                 randconfig-002-20250913    gcc-14.3.0
arm64                 randconfig-003-20250912    clang-22
arm64                 randconfig-003-20250913    clang-22
arm64                 randconfig-004-20250912    clang-19
arm64                 randconfig-004-20250913    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250912    gcc-15.1.0
csky                  randconfig-001-20250913    gcc-11.5.0
csky                  randconfig-002-20250912    gcc-11.5.0
csky                  randconfig-002-20250913    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250912    clang-22
hexagon               randconfig-001-20250913    clang-16
hexagon               randconfig-002-20250912    clang-22
hexagon               randconfig-002-20250913    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20250912    gcc-14
i386        buildonly-randconfig-002-20250912    clang-20
i386        buildonly-randconfig-003-20250912    gcc-13
i386        buildonly-randconfig-004-20250912    clang-20
i386        buildonly-randconfig-005-20250912    gcc-14
i386        buildonly-randconfig-006-20250912    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250912    gcc-15.1.0
loongarch             randconfig-001-20250913    clang-18
loongarch             randconfig-002-20250912    clang-22
loongarch             randconfig-002-20250913    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250912    gcc-11.5.0
nios2                 randconfig-001-20250913    gcc-8.5.0
nios2                 randconfig-002-20250912    gcc-11.5.0
nios2                 randconfig-002-20250913    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250912    gcc-14.3.0
parisc                randconfig-001-20250913    gcc-12.5.0
parisc                randconfig-002-20250912    gcc-8.5.0
parisc                randconfig-002-20250913    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250912    gcc-8.5.0
powerpc               randconfig-001-20250913    gcc-8.5.0
powerpc               randconfig-002-20250912    clang-22
powerpc               randconfig-002-20250913    clang-22
powerpc               randconfig-003-20250912    clang-17
powerpc               randconfig-003-20250913    gcc-10.5.0
powerpc64             randconfig-001-20250912    gcc-12.5.0
powerpc64             randconfig-001-20250913    gcc-10.5.0
powerpc64             randconfig-002-20250912    clang-22
powerpc64             randconfig-002-20250913    clang-22
powerpc64             randconfig-003-20250912    clang-19
powerpc64             randconfig-003-20250913    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250912    clang-16
riscv                 randconfig-001-20250913    gcc-13.4.0
riscv                 randconfig-002-20250912    gcc-9.5.0
riscv                 randconfig-002-20250913    clang-20
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250912    gcc-10.5.0
s390                  randconfig-001-20250913    clang-22
s390                  randconfig-002-20250912    gcc-10.5.0
s390                  randconfig-002-20250913    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250912    gcc-15.1.0
sh                    randconfig-001-20250913    gcc-9.5.0
sh                    randconfig-002-20250912    gcc-15.1.0
sh                    randconfig-002-20250913    gcc-14.3.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250912    gcc-8.5.0
sparc                 randconfig-001-20250913    gcc-15.1.0
sparc                 randconfig-002-20250912    gcc-13.4.0
sparc                 randconfig-002-20250913    gcc-8.5.0
sparc64               randconfig-001-20250912    gcc-8.5.0
sparc64               randconfig-001-20250913    gcc-8.5.0
sparc64               randconfig-002-20250912    clang-20
sparc64               randconfig-002-20250913    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250912    clang-22
um                    randconfig-001-20250913    gcc-14
um                    randconfig-002-20250912    gcc-14
um                    randconfig-002-20250913    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250912    gcc-14
x86_64      buildonly-randconfig-002-20250912    gcc-14
x86_64      buildonly-randconfig-003-20250912    clang-20
x86_64      buildonly-randconfig-004-20250912    clang-20
x86_64      buildonly-randconfig-005-20250912    clang-20
x86_64      buildonly-randconfig-006-20250912    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250912    gcc-9.5.0
xtensa                randconfig-001-20250913    gcc-14.3.0
xtensa                randconfig-002-20250912    gcc-12.5.0
xtensa                randconfig-002-20250913    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

