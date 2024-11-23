Return-Path: <linux-acpi+bounces-9766-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C6A9D68D2
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Nov 2024 12:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5731613CE
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Nov 2024 11:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E53E18660A;
	Sat, 23 Nov 2024 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MD+y9TU8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5F317C2;
	Sat, 23 Nov 2024 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732360420; cv=none; b=taLOsmJNkudQwFOy83UitGRZnOswOYpRewaJvttrin2AgTuYEz+g1FYJGxHdqOdDjBsPVgekyxceU84s912Yjcmp+qyH/hOATzHt1XfL6QK9xbeNXjGV4sQ8H+pyAfk9qNns7EeTnmLQUMG+ryjQ89c507mN4aldum9Aa6VboaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732360420; c=relaxed/simple;
	bh=BmjlRQD0hrCDkYTu2Q2VI4aLGaXl3t1W3buKWkEnY/c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jZ1nWFvSIFpxdDFt6wVXo0zNBE4kCtEjL2DFn5IElHQoZsh5yyBx+poxbryHCQSTRl5nEACUMgM1wO0scCrLYjtT9R5OlJ8waMLfWaqtpq/LttTYB+etAOV9MgvdD6Hhu9zAzSx3fWFHGUFEpdOGaUaLR7aNSMT2/s5Pk2T4mBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MD+y9TU8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732360419; x=1763896419;
  h=date:from:to:cc:subject:message-id;
  bh=BmjlRQD0hrCDkYTu2Q2VI4aLGaXl3t1W3buKWkEnY/c=;
  b=MD+y9TU89urVuiHx+Eq0l2DbPvWcNofccG5O5lrPMwuGGH8P/FcluWIP
   4vo0imZUIYFBfAoFnjj2XTAU4pcHSaugrIP2l6oS8wdOoQSbQK04Qtn+s
   Ym6e2ekchjnf9v90PQJrlqMsBkTkCYdIdKel5eH2H8W7gqu+nmw4ldj16
   cXl6JCrLLVkSTn3vJ8d3ykmA3es7VtQGPdzfu/bRcJkcG3eAQwqW2sh7a
   UcdV6yxUJ/oMOFFOxY+z1PYEZgY6I/5BmYuIqoPNveuk5hv7MiE7/aYuj
   muWa2673T+iyesEjEkZkLEY7XG2Q2pMoSQ9fATJ2pMUVvC0N5sJlXuDvv
   w==;
X-CSE-ConnectionGUID: AzJhjP89T6WXpxZTDGYdDg==
X-CSE-MsgGUID: hHoQeE9ySIysAB/foMDANg==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="32758813"
X-IronPort-AV: E=Sophos;i="6.12,178,1728975600"; 
   d="scan'208";a="32758813"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2024 03:13:38 -0800
X-CSE-ConnectionGUID: pCv4HtS8SniQYSBiB1fv0g==
X-CSE-MsgGUID: srubRrGYTJquPkeP0KMjNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,178,1728975600"; 
   d="scan'208";a="95743276"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 23 Nov 2024 03:13:36 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEo4z-0004aZ-2y;
	Sat, 23 Nov 2024 11:13:33 +0000
Date: Sat, 23 Nov 2024 19:13:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 db5d4c589ffa266d8897b3b342a4e0bebfb9eaec
Message-ID: <202411231911.mGpkebsM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: db5d4c589ffa266d8897b3b342a4e0bebfb9eaec  Merge branch 'acpi-misc' into bleeding-edge

elapsed time: 810m

configs tested: 201
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241123    gcc-14.2.0
arc                   randconfig-002-20241123    gcc-14.2.0
arc                           tb10x_defconfig    clang-14
arc                        vdk_hs38_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          ep93xx_defconfig    clang-14
arm                       imx_v4_v5_defconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    clang-14
arm                          moxart_defconfig    gcc-14.2.0
arm                   randconfig-001-20241123    gcc-14.2.0
arm                   randconfig-002-20241123    gcc-14.2.0
arm                   randconfig-003-20241123    gcc-14.2.0
arm                   randconfig-004-20241123    gcc-14.2.0
arm                         s5pv210_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241123    gcc-14.2.0
arm64                 randconfig-002-20241123    gcc-14.2.0
arm64                 randconfig-003-20241123    gcc-14.2.0
arm64                 randconfig-004-20241123    gcc-14.2.0
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241123    gcc-14.2.0
csky                  randconfig-002-20241123    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241123    gcc-14.2.0
hexagon               randconfig-002-20241123    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241123    clang-19
i386        buildonly-randconfig-002-20241123    clang-19
i386        buildonly-randconfig-003-20241123    clang-19
i386        buildonly-randconfig-004-20241123    clang-19
i386        buildonly-randconfig-005-20241123    clang-19
i386        buildonly-randconfig-006-20241123    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241123    clang-19
i386                  randconfig-002-20241123    clang-19
i386                  randconfig-003-20241123    clang-19
i386                  randconfig-004-20241123    clang-19
i386                  randconfig-005-20241123    clang-19
i386                  randconfig-006-20241123    clang-19
i386                  randconfig-011-20241123    clang-19
i386                  randconfig-012-20241123    clang-19
i386                  randconfig-013-20241123    clang-19
i386                  randconfig-014-20241123    clang-19
i386                  randconfig-015-20241123    clang-19
i386                  randconfig-016-20241123    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241123    gcc-14.2.0
loongarch             randconfig-002-20241123    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    clang-14
mips                           ip32_defconfig    clang-14
mips                      maltaaprp_defconfig    clang-14
mips                        omega2p_defconfig    gcc-14.2.0
mips                          rb532_defconfig    clang-14
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241123    gcc-14.2.0
nios2                 randconfig-002-20241123    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241123    gcc-14.2.0
parisc                randconfig-002-20241123    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                    adder875_defconfig    clang-14
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    clang-14
powerpc                       maple_defconfig    gcc-14.2.0
powerpc                 mpc834x_itx_defconfig    clang-14
powerpc                 mpc837x_rdb_defconfig    clang-14
powerpc                      ppc64e_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241123    gcc-14.2.0
powerpc               randconfig-002-20241123    gcc-14.2.0
powerpc               randconfig-003-20241123    gcc-14.2.0
powerpc                     taishan_defconfig    clang-14
powerpc64             randconfig-001-20241123    gcc-14.2.0
powerpc64             randconfig-002-20241123    gcc-14.2.0
powerpc64             randconfig-003-20241123    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241123    gcc-14.2.0
riscv                 randconfig-002-20241123    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241123    gcc-14.2.0
s390                  randconfig-002-20241123    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    gcc-14.2.0
sh                    randconfig-001-20241123    gcc-14.2.0
sh                    randconfig-002-20241123    gcc-14.2.0
sh                          rsk7264_defconfig    clang-14
sh                          sdk7786_defconfig    clang-14
sh                           se7705_defconfig    clang-14
sh                           se7721_defconfig    gcc-14.2.0
sh                           se7751_defconfig    gcc-14.2.0
sh                   sh7724_generic_defconfig    gcc-14.2.0
sparc                            alldefconfig    clang-14
sparc                            allmodconfig    gcc-14.2.0
sparc                       sparc32_defconfig    clang-14
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241123    gcc-14.2.0
sparc64               randconfig-002-20241123    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241123    gcc-14.2.0
um                    randconfig-002-20241123    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241123    gcc-12
x86_64      buildonly-randconfig-002-20241123    gcc-12
x86_64      buildonly-randconfig-003-20241123    gcc-12
x86_64      buildonly-randconfig-004-20241123    gcc-12
x86_64      buildonly-randconfig-005-20241123    gcc-12
x86_64      buildonly-randconfig-006-20241123    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241123    gcc-12
x86_64                randconfig-002-20241123    gcc-12
x86_64                randconfig-003-20241123    gcc-12
x86_64                randconfig-004-20241123    gcc-12
x86_64                randconfig-005-20241123    gcc-12
x86_64                randconfig-006-20241123    gcc-12
x86_64                randconfig-011-20241123    gcc-12
x86_64                randconfig-012-20241123    gcc-12
x86_64                randconfig-013-20241123    gcc-12
x86_64                randconfig-014-20241123    gcc-12
x86_64                randconfig-015-20241123    gcc-12
x86_64                randconfig-016-20241123    gcc-12
x86_64                randconfig-071-20241123    gcc-12
x86_64                randconfig-072-20241123    gcc-12
x86_64                randconfig-073-20241123    gcc-12
x86_64                randconfig-074-20241123    gcc-12
x86_64                randconfig-075-20241123    gcc-12
x86_64                randconfig-076-20241123    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                               rhel-9.4    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241123    gcc-14.2.0
xtensa                randconfig-002-20241123    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

