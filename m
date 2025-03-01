Return-Path: <linux-acpi+bounces-11672-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBB0A4AE13
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 23:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E16C3B4F18
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 22:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F241D5CF2;
	Sat,  1 Mar 2025 22:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2N3ESve"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F821C5D6A;
	Sat,  1 Mar 2025 22:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740866598; cv=none; b=K4Ni+a5NG9dziaD4SEPlF3hqlDzbPqte2aPJ8B9XC/osUBgnB0UlDZH5njFeWLwp/srQ2yZ+6Ci4a0Aa31ugpmRX8am5A6qQspL9aKEoqz31Up76H9Bz0z/nOXtS5xm6WYX48sLTkKzx/FBin2N+zNzx/L7z9ghSV9gx8ZVaBCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740866598; c=relaxed/simple;
	bh=+KpugZ8a12h+ql1bayjz/txzPbV8FEx+aGzAdbMpSxc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PpGYcui7lnggNuxfidbnbVBF8zr2vPqaW9RwRgz3AWwC3uZ77ytw3narpN95EqT+Y5uI7cPU1GIpY2GGgabRjW6BoDEjuPo8zitKv74eq7CyCqS3zMRIfzw0l6Nuq7MUHaRexYPWZ2f40QqFUVM4vZMzUv0FVkaRA7Ka+6j5ugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2N3ESve; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740866596; x=1772402596;
  h=date:from:to:cc:subject:message-id;
  bh=+KpugZ8a12h+ql1bayjz/txzPbV8FEx+aGzAdbMpSxc=;
  b=W2N3ESveWIwsJ7+MjL0v9j3BX52pAp63lJeg5dysI1tzdOJs5ElRQKPz
   uL1lzp4Xknp31Q/se9y6jtBYB5LaOkXSJCMcIcgV/S7TYC/HLC1gn+p2V
   17IvwNK5qvlR7sMrD7dqgZNouUTKQfZ0XxUojELj2ZNEpEGqXIgPB7Epa
   5H/Kusl2LS3gyREg9HhqMjhOC7MVTEexwMzcc+583Wx8DCfUw13Y+L/w4
   SYXZ8vjIlfaam6N2nsBaSfNpAAMYoBSisl14N0riQFBuBiUx7cLUZeC2u
   7IGFMhzfP5mfZQr+OLwJfRKLHtXV8TCtI4EXp9ZoN/MtOP+v2yoKnyNsC
   A==;
X-CSE-ConnectionGUID: ZWIPQ67zRAiN7aWMgd2FVg==
X-CSE-MsgGUID: Q3GdM+A5ScaLVBAiZUjmxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="42020514"
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="42020514"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 14:03:16 -0800
X-CSE-ConnectionGUID: /jx0p1AqR7GG6tIbpkAkog==
X-CSE-MsgGUID: /3Ds8APDTPa3koHWUHYbXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122889944"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 01 Mar 2025 14:03:14 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toUvP-000Gkm-1k;
	Sat, 01 Mar 2025 22:03:11 +0000
Date: Sun, 02 Mar 2025 06:03:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 3a011fb737353cad4646f07853e1e2025e34193d
Message-ID: <202503020655.JAm3w63U-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 3a011fb737353cad4646f07853e1e2025e34193d  Merge branch 'pm-cpuidle-fixes' into fixes

elapsed time: 1447m

configs tested: 193
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
arc                               allnoconfig    gcc-14.2.0
arc                   randconfig-001-20250301    gcc-13.2.0
arc                   randconfig-001-20250302    gcc-14.2.0
arc                   randconfig-002-20250301    gcc-13.2.0
arc                   randconfig-002-20250302    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    gcc-14.2.0
arm                         lpc18xx_defconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-15
arm                        mvebu_v7_defconfig    clang-15
arm                            qcom_defconfig    clang-15
arm                   randconfig-001-20250301    gcc-14.2.0
arm                   randconfig-001-20250302    gcc-14.2.0
arm                   randconfig-002-20250301    gcc-14.2.0
arm                   randconfig-002-20250302    gcc-14.2.0
arm                   randconfig-003-20250301    clang-21
arm                   randconfig-003-20250302    gcc-14.2.0
arm                   randconfig-004-20250301    clang-21
arm                   randconfig-004-20250302    gcc-14.2.0
arm                         vf610m4_defconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250301    gcc-14.2.0
arm64                 randconfig-001-20250302    gcc-14.2.0
arm64                 randconfig-002-20250301    clang-21
arm64                 randconfig-002-20250302    gcc-14.2.0
arm64                 randconfig-003-20250301    clang-15
arm64                 randconfig-003-20250302    gcc-14.2.0
arm64                 randconfig-004-20250301    clang-17
arm64                 randconfig-004-20250302    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250301    gcc-14.2.0
csky                  randconfig-001-20250302    gcc-14.2.0
csky                  randconfig-002-20250301    gcc-14.2.0
csky                  randconfig-002-20250302    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250301    clang-21
hexagon               randconfig-001-20250302    gcc-14.2.0
hexagon               randconfig-002-20250301    clang-21
hexagon               randconfig-002-20250302    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20250301    clang-19
i386        buildonly-randconfig-001-20250302    gcc-12
i386        buildonly-randconfig-002-20250301    clang-19
i386        buildonly-randconfig-002-20250302    gcc-12
i386        buildonly-randconfig-003-20250301    clang-19
i386        buildonly-randconfig-003-20250302    gcc-12
i386        buildonly-randconfig-004-20250301    clang-19
i386        buildonly-randconfig-004-20250302    gcc-12
i386        buildonly-randconfig-005-20250301    gcc-12
i386        buildonly-randconfig-005-20250302    gcc-12
i386        buildonly-randconfig-006-20250301    clang-19
i386        buildonly-randconfig-006-20250302    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250302    gcc-12
i386                  randconfig-002-20250302    gcc-12
i386                  randconfig-003-20250302    gcc-12
i386                  randconfig-004-20250302    gcc-12
i386                  randconfig-005-20250302    gcc-12
i386                  randconfig-006-20250302    gcc-12
i386                  randconfig-007-20250302    gcc-12
i386                  randconfig-011-20250302    gcc-11
i386                  randconfig-012-20250302    gcc-11
i386                  randconfig-013-20250302    gcc-11
i386                  randconfig-014-20250302    gcc-11
i386                  randconfig-015-20250302    gcc-11
i386                  randconfig-016-20250302    gcc-11
i386                  randconfig-017-20250302    gcc-11
loongarch                        alldefconfig    clang-15
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250301    gcc-14.2.0
loongarch             randconfig-001-20250302    gcc-14.2.0
loongarch             randconfig-002-20250301    gcc-14.2.0
loongarch             randconfig-002-20250302    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250301    gcc-14.2.0
nios2                 randconfig-001-20250302    gcc-14.2.0
nios2                 randconfig-002-20250301    gcc-14.2.0
nios2                 randconfig-002-20250302    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                            defconfig    gcc-12
openrisc                    or1ksim_defconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    clang-15
parisc                randconfig-001-20250301    gcc-14.2.0
parisc                randconfig-001-20250302    gcc-14.2.0
parisc                randconfig-002-20250301    gcc-14.2.0
parisc                randconfig-002-20250302    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                 mpc832x_rdb_defconfig    clang-15
powerpc               randconfig-001-20250301    clang-17
powerpc               randconfig-001-20250302    gcc-14.2.0
powerpc               randconfig-002-20250301    clang-19
powerpc               randconfig-002-20250302    gcc-14.2.0
powerpc               randconfig-003-20250301    clang-21
powerpc               randconfig-003-20250302    gcc-14.2.0
powerpc64             randconfig-001-20250301    gcc-14.2.0
powerpc64             randconfig-001-20250302    gcc-14.2.0
powerpc64             randconfig-002-20250301    clang-21
powerpc64             randconfig-003-20250301    gcc-14.2.0
powerpc64             randconfig-003-20250302    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250301    gcc-14.2.0
riscv                 randconfig-001-20250302    gcc-14.2.0
riscv                 randconfig-002-20250301    gcc-14.2.0
riscv                 randconfig-002-20250302    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250301    clang-15
s390                  randconfig-001-20250302    gcc-14.2.0
s390                  randconfig-002-20250301    gcc-14.2.0
s390                  randconfig-002-20250302    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250301    gcc-14.2.0
sh                    randconfig-001-20250302    gcc-14.2.0
sh                    randconfig-002-20250301    gcc-14.2.0
sh                    randconfig-002-20250302    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250301    gcc-14.2.0
sparc                 randconfig-001-20250302    gcc-14.2.0
sparc                 randconfig-002-20250301    gcc-14.2.0
sparc                 randconfig-002-20250302    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250301    gcc-14.2.0
sparc64               randconfig-001-20250302    gcc-14.2.0
sparc64               randconfig-002-20250301    gcc-14.2.0
sparc64               randconfig-002-20250302    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                               allyesconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250301    gcc-12
um                    randconfig-001-20250302    gcc-14.2.0
um                    randconfig-002-20250301    gcc-12
um                    randconfig-002-20250302    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250301    clang-19
x86_64      buildonly-randconfig-001-20250302    gcc-12
x86_64      buildonly-randconfig-002-20250301    clang-19
x86_64      buildonly-randconfig-002-20250302    gcc-12
x86_64      buildonly-randconfig-003-20250301    gcc-11
x86_64      buildonly-randconfig-003-20250302    gcc-12
x86_64      buildonly-randconfig-004-20250301    gcc-12
x86_64      buildonly-randconfig-004-20250302    gcc-12
x86_64      buildonly-randconfig-005-20250301    gcc-12
x86_64      buildonly-randconfig-005-20250302    gcc-12
x86_64      buildonly-randconfig-006-20250301    clang-19
x86_64      buildonly-randconfig-006-20250302    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250302    clang-19
x86_64                randconfig-002-20250302    clang-19
x86_64                randconfig-003-20250302    clang-19
x86_64                randconfig-004-20250302    clang-19
x86_64                randconfig-005-20250302    clang-19
x86_64                randconfig-006-20250302    clang-19
x86_64                randconfig-007-20250302    clang-19
x86_64                randconfig-008-20250302    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-18
x86_64                          rhel-9.4-func    clang-19
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250301    gcc-14.2.0
xtensa                randconfig-001-20250302    gcc-14.2.0
xtensa                randconfig-002-20250301    gcc-14.2.0
xtensa                randconfig-002-20250302    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

