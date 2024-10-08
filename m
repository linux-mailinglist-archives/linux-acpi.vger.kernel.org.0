Return-Path: <linux-acpi+bounces-8625-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B7E99575B
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 21:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF7D282418
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 19:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E906212D3C;
	Tue,  8 Oct 2024 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPMgBrzn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EE818C922;
	Tue,  8 Oct 2024 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414189; cv=none; b=MT2C55Qrb+EFYse+8wlRcNbt13lMtC4JxiZ/NDJgbhjC27u9nufpqyIb/+J9Lv8PFtuFtLP+hSbSCwdYfs/AqbojW2q9SLs3cgJA8BN+WthAUZ8+JB7R3z8d6/xo6541R2foSRaRruy3V5zzLCFFAqM9Zs1ahooNeVNGccRG2Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414189; c=relaxed/simple;
	bh=c7DMr8Jr+5PFWNjLqrh02jTwqXIdj+5/PfS0BjabjT0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iEtBT13AaxHmicqeFhyokBsF+QxM0EjE/9umMzAGUsLIRifrXnoMwg+Tn5e9XNzqJs0NAqKb6MXeW5UygC7EoRt0+pZ0NQz5Ua302dIRPDgmh0h9Q4vc9cL0h9QZDF6nit7PnWd8tkOMCQzpXhFxKv9kc5iuJAfqL9UVsOmto/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPMgBrzn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728414187; x=1759950187;
  h=date:from:to:cc:subject:message-id;
  bh=c7DMr8Jr+5PFWNjLqrh02jTwqXIdj+5/PfS0BjabjT0=;
  b=gPMgBrznsfRwELGNZsozZ2I0h8F8Z9VyRhqteTI++9Kx8tBdtp/4Wnyv
   wz9X+sdFya89QjrA/om2pOuUSR4IAdXff/KVv6inDChtmJcm95IdPSdXN
   CGh4xNb1GRXSx3w7v46ooKfWxV9q9uAdjwGNM11cIeHjmdGvxZlujuHGX
   l9O7leITeJS5Baw9gYMXwdKjHvGk1FaEdBau7fFZPvDxbDauXkyKx0aqz
   2VRnsTRyWxnpSzNfd2oEk4zRUYwsvbUdzOJNwtnSDZhmuDiLAawLG5odm
   kxiV3qCXKK4pAKPfVL+skclJtcQpMFu11d5q8ydrKwtPMg5uBIez7XWtP
   A==;
X-CSE-ConnectionGUID: PD9sZqL+QjGzJpER7d7QyA==
X-CSE-MsgGUID: oMHUQ/u3Q2O8zqSF+w9UGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="45115384"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="45115384"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 12:03:07 -0700
X-CSE-ConnectionGUID: BX1lfXjYTjurgBXNmx3iKw==
X-CSE-MsgGUID: YIKpKQeaQ0yQ9/xpV9zUHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="80736448"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Oct 2024 12:03:06 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syFU7-0008Hk-0l;
	Tue, 08 Oct 2024 19:03:03 +0000
Date: Wed, 09 Oct 2024 03:02:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 6dbccbddb67dc1bca1628dd220862d5a71aef6df
Message-ID: <202410090355.fSS5Q5cE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 6dbccbddb67dc1bca1628dd220862d5a71aef6df  Merge branch 'thermal-core-testing' into bleeding-edge

elapsed time: 1397m

configs tested: 232
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241008    gcc-14.1.0
arc                   randconfig-002-20241008    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          gemini_defconfig    gcc-14.1.0
arm                        keystone_defconfig    gcc-14.1.0
arm                          moxart_defconfig    gcc-13.2.0
arm                   randconfig-001-20241008    gcc-14.1.0
arm                   randconfig-002-20241008    gcc-14.1.0
arm                   randconfig-003-20241008    gcc-14.1.0
arm                   randconfig-004-20241008    gcc-14.1.0
arm                        spear3xx_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241008    gcc-14.1.0
arm64                 randconfig-002-20241008    gcc-14.1.0
arm64                 randconfig-003-20241008    gcc-14.1.0
arm64                 randconfig-004-20241008    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241008    gcc-14.1.0
csky                  randconfig-002-20241008    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241008    gcc-14.1.0
hexagon               randconfig-002-20241008    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241008    clang-18
i386        buildonly-randconfig-002-20241008    clang-18
i386        buildonly-randconfig-002-20241008    gcc-12
i386        buildonly-randconfig-003-20241008    clang-18
i386        buildonly-randconfig-003-20241008    gcc-12
i386        buildonly-randconfig-004-20241008    clang-18
i386        buildonly-randconfig-004-20241008    gcc-12
i386        buildonly-randconfig-005-20241008    clang-18
i386        buildonly-randconfig-006-20241008    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241008    clang-18
i386                  randconfig-002-20241008    clang-18
i386                  randconfig-002-20241008    gcc-12
i386                  randconfig-003-20241008    clang-18
i386                  randconfig-003-20241008    gcc-12
i386                  randconfig-004-20241008    clang-18
i386                  randconfig-005-20241008    clang-18
i386                  randconfig-005-20241008    gcc-12
i386                  randconfig-006-20241008    clang-18
i386                  randconfig-006-20241008    gcc-12
i386                  randconfig-011-20241008    clang-18
i386                  randconfig-012-20241008    clang-18
i386                  randconfig-013-20241008    clang-18
i386                  randconfig-013-20241008    gcc-12
i386                  randconfig-014-20241008    clang-18
i386                  randconfig-014-20241008    gcc-12
i386                  randconfig-015-20241008    clang-18
i386                  randconfig-016-20241008    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241008    gcc-14.1.0
loongarch             randconfig-002-20241008    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5208evb_defconfig    gcc-14.1.0
m68k                       m5249evb_defconfig    gcc-14.1.0
m68k                        m5307c3_defconfig    gcc-14.1.0
m68k                           sun3_defconfig    gcc-14.1.0
m68k                          sun3x_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath25_defconfig    gcc-13.2.0
mips                      bmips_stb_defconfig    gcc-13.2.0
mips                          eyeq5_defconfig    gcc-13.2.0
mips                           ip27_defconfig    gcc-13.2.0
mips                           ip30_defconfig    gcc-13.2.0
mips                           ip30_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241008    gcc-14.1.0
nios2                 randconfig-002-20241008    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241008    gcc-14.1.0
parisc                randconfig-002-20241008    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                     akebono_defconfig    gcc-13.2.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                    ge_imp3a_defconfig    gcc-14.1.0
powerpc                 linkstation_defconfig    gcc-13.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-13.2.0
powerpc                 mpc834x_itx_defconfig    gcc-14.1.0
powerpc                 mpc836x_rdk_defconfig    gcc-13.2.0
powerpc                      pmac32_defconfig    gcc-14.1.0
powerpc                      ppc64e_defconfig    gcc-14.1.0
powerpc                     rainier_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241008    gcc-14.1.0
powerpc               randconfig-002-20241008    gcc-14.1.0
powerpc               randconfig-003-20241008    gcc-14.1.0
powerpc                    sam440ep_defconfig    gcc-13.2.0
powerpc64             randconfig-001-20241008    gcc-14.1.0
powerpc64             randconfig-002-20241008    gcc-14.1.0
powerpc64             randconfig-003-20241008    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241008    gcc-14.1.0
riscv                 randconfig-002-20241008    gcc-14.1.0
s390                             alldefconfig    gcc-13.2.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241008    gcc-14.1.0
s390                  randconfig-002-20241008    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                          r7780mp_defconfig    gcc-13.2.0
sh                    randconfig-001-20241008    gcc-14.1.0
sh                    randconfig-002-20241008    gcc-14.1.0
sh                      rts7751r2d1_defconfig    gcc-13.2.0
sh                           se7751_defconfig    gcc-14.1.0
sh                     sh7710voipgw_defconfig    gcc-13.2.0
sh                     sh7710voipgw_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241008    gcc-14.1.0
sparc64               randconfig-002-20241008    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241008    gcc-14.1.0
um                    randconfig-002-20241008    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241008    gcc-12
x86_64      buildonly-randconfig-001-20241009    clang-18
x86_64      buildonly-randconfig-002-20241008    gcc-12
x86_64      buildonly-randconfig-002-20241009    clang-18
x86_64      buildonly-randconfig-003-20241008    gcc-12
x86_64      buildonly-randconfig-003-20241009    clang-18
x86_64      buildonly-randconfig-004-20241008    gcc-12
x86_64      buildonly-randconfig-004-20241009    clang-18
x86_64      buildonly-randconfig-005-20241008    gcc-12
x86_64      buildonly-randconfig-005-20241009    clang-18
x86_64      buildonly-randconfig-006-20241008    gcc-12
x86_64      buildonly-randconfig-006-20241009    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241008    gcc-12
x86_64                randconfig-001-20241009    clang-18
x86_64                randconfig-002-20241008    gcc-12
x86_64                randconfig-002-20241009    clang-18
x86_64                randconfig-003-20241008    gcc-12
x86_64                randconfig-003-20241009    clang-18
x86_64                randconfig-004-20241008    gcc-12
x86_64                randconfig-004-20241009    clang-18
x86_64                randconfig-005-20241008    gcc-12
x86_64                randconfig-005-20241009    clang-18
x86_64                randconfig-006-20241008    gcc-12
x86_64                randconfig-006-20241009    clang-18
x86_64                randconfig-011-20241008    gcc-12
x86_64                randconfig-011-20241009    clang-18
x86_64                randconfig-012-20241008    gcc-12
x86_64                randconfig-012-20241009    clang-18
x86_64                randconfig-013-20241008    gcc-12
x86_64                randconfig-013-20241009    clang-18
x86_64                randconfig-014-20241008    gcc-12
x86_64                randconfig-014-20241009    clang-18
x86_64                randconfig-015-20241008    gcc-12
x86_64                randconfig-015-20241009    clang-18
x86_64                randconfig-016-20241008    gcc-12
x86_64                randconfig-016-20241009    clang-18
x86_64                randconfig-071-20241008    gcc-12
x86_64                randconfig-071-20241009    clang-18
x86_64                randconfig-072-20241008    gcc-12
x86_64                randconfig-072-20241009    clang-18
x86_64                randconfig-073-20241008    gcc-12
x86_64                randconfig-073-20241009    clang-18
x86_64                randconfig-074-20241008    gcc-12
x86_64                randconfig-074-20241009    clang-18
x86_64                randconfig-075-20241008    gcc-12
x86_64                randconfig-075-20241009    clang-18
x86_64                randconfig-076-20241008    gcc-12
x86_64                randconfig-076-20241009    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241008    gcc-14.1.0
xtensa                randconfig-002-20241008    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

