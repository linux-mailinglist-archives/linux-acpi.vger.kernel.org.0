Return-Path: <linux-acpi+bounces-12612-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D68A77F98
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 17:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234451674E5
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 15:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8493120C482;
	Tue,  1 Apr 2025 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pm5Ny6kd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3BC20B81B;
	Tue,  1 Apr 2025 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743522876; cv=none; b=mrCQcZEB3SOUMtcAjtNsoPcyRMitouNZJIctItV1id0oHHFZbQS7fhB67sqk6FA45DWGoiP3mbVNs2M93ScvMWdVQsC6vWonrhz4HIFz2hKzvc/zbo5k3hd7FfFqvlk/Yo4kDZZ65xaCun5hjjU/rJn8oOg23J//Hlgx+AspAEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743522876; c=relaxed/simple;
	bh=JOWHdatgb3Kw12Rv13dmVlUlEF36EFQzZtP/Bg464Ho=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kTYqCXwVne+BivGK0nS8bouwbmH6/tmOqnzDPJ7VL3Zqmd6+jgiUxdlTT4vBgUQyNMt3SNf5v86eJg+BRiSsR2v0xYFy5JiCalaRlfIWTorAeKLsC4zCtn6jEjARw+tXLanYxj7bz3Y7yJAtmNc1C95Scdydtb/uX+wSU5FB7Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pm5Ny6kd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743522875; x=1775058875;
  h=date:from:to:cc:subject:message-id;
  bh=JOWHdatgb3Kw12Rv13dmVlUlEF36EFQzZtP/Bg464Ho=;
  b=Pm5Ny6kd3krdqxIYmXcerNJ4cJE6pEjP8tfOphu9yFABcoML7eCVv3eu
   fkVsbkZikNn28dYGhhOVCz/+dvaIJjmHa05lOjzzow+S7PuactlfkOBRt
   bsJSMwXD8P5cz19+iLi9+Legt1i3sCenLvg9pHy93p++sOSzbrKIzO7ai
   PTrIMI1bu3rNY27ZzYZFhxFMVshWQOKzxI8uCsMMZPDtYnudijkbxZVvH
   +UKcK/+HoFf5HexSp7uVeCTwHGCyOH3PgbWdEJZZigwowi/Hqh5eDPxPp
   k6Mr9UxPL3a6kj2oQbKBv9sb54YpQin9cU2gsXVM3yPVYZ9/nqEHnYwUI
   A==;
X-CSE-ConnectionGUID: 9nUfnlU7ROuxxPmRC3zSNQ==
X-CSE-MsgGUID: VLibrUORSS+R3cw9CDc9Rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="48646138"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="48646138"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:54:34 -0700
X-CSE-ConnectionGUID: RhlBAMduRv251/ZEpQreog==
X-CSE-MsgGUID: ZOhklllbS/WcDEV9xtWj0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="127245636"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 01 Apr 2025 08:54:32 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tzdwc-0009xu-0p;
	Tue, 01 Apr 2025 15:54:30 +0000
Date: Tue, 01 Apr 2025 23:54:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 de27f67c9d90ad0d41f14330027467b00517bbd7
Message-ID: <202504012357.7K7wwEqi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: de27f67c9d90ad0d41f14330027467b00517bbd7  Merge branch 'pm-sleep-testing' into bleeding-edge

elapsed time: 1453m

configs tested: 127
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250401    gcc-12.4.0
arc                   randconfig-002-20250401    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                          ep93xx_defconfig    clang-21
arm                       imx_v4_v5_defconfig    clang-15
arm                          pxa3xx_defconfig    clang-21
arm                   randconfig-001-20250401    gcc-7.5.0
arm                   randconfig-002-20250401    gcc-8.5.0
arm                   randconfig-003-20250401    clang-18
arm                   randconfig-004-20250401    clang-14
arm                             rpc_defconfig    clang-18
arm                         vf610m4_defconfig    gcc-14.2.0
arm64                            alldefconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-002-20250401    clang-20
arm64                 randconfig-003-20250401    gcc-8.5.0
arm64                 randconfig-004-20250401    gcc-6.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250401    gcc-14.2.0
csky                  randconfig-002-20250401    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250401    clang-21
hexagon               randconfig-002-20250401    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250401    gcc-12
i386        buildonly-randconfig-002-20250401    clang-20
i386        buildonly-randconfig-003-20250401    clang-20
i386        buildonly-randconfig-004-20250401    clang-20
i386        buildonly-randconfig-005-20250401    gcc-12
i386        buildonly-randconfig-006-20250401    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20250401    gcc-14.2.0
loongarch             randconfig-002-20250401    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250401    gcc-8.5.0
nios2                 randconfig-002-20250401    gcc-6.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250401    gcc-11.5.0
parisc                randconfig-002-20250401    gcc-5.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250401    clang-21
powerpc               randconfig-002-20250401    gcc-8.5.0
powerpc               randconfig-003-20250401    clang-20
powerpc                     tqm8541_defconfig    clang-21
powerpc64             randconfig-001-20250401    clang-21
powerpc64             randconfig-002-20250401    clang-17
powerpc64             randconfig-003-20250401    gcc-6.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250401    clang-21
riscv                 randconfig-002-20250401    clang-14
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250401    clang-15
s390                  randconfig-002-20250401    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250401    gcc-12.4.0
sh                    randconfig-002-20250401    gcc-12.4.0
sh                           se7750_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250401    gcc-11.5.0
sparc                 randconfig-002-20250401    gcc-7.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250401    gcc-9.3.0
sparc64               randconfig-002-20250401    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250401    gcc-12
um                    randconfig-002-20250401    gcc-11
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250401    clang-20
x86_64      buildonly-randconfig-002-20250401    gcc-12
x86_64      buildonly-randconfig-003-20250401    clang-20
x86_64      buildonly-randconfig-004-20250401    clang-20
x86_64      buildonly-randconfig-005-20250401    gcc-12
x86_64      buildonly-randconfig-006-20250401    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250401    gcc-9.3.0
xtensa                randconfig-002-20250401    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

