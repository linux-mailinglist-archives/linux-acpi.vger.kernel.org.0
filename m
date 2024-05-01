Return-Path: <linux-acpi+bounces-5578-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5248B90F3
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 22:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2501C21598
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 20:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEE0165FAA;
	Wed,  1 May 2024 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPmO3AOd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D08165FA5;
	Wed,  1 May 2024 20:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714597192; cv=none; b=m73Z9OENOtNdvO8q+RDaZPLGONJeep6hOv82w6sxgJZLIAGRLd6/lVOt4MMgQqC/UN+ANg7eFT3lKeWAn4xz0PDURqg/3mb9D3mCAL3q5H6EeqkpRfjZmtiJ4kiKaOi3yjH4TwPkVx8EuT0ITREu05FzQxdXNO/TyhkWgwJlEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714597192; c=relaxed/simple;
	bh=e3Re1S+hcoPfrhP63eDdkBaqUByGdLmYGewWsjUP41A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=C/AHCg+jp1fFwTD+uI9ZXCnYkhUqSoodQpBXdIPiZmu32Xk3HHACuFmnQihoucl6qi9KosEOfawZuobdgzJT/SNTNtf/kPa2WJB55R4LVw1MibKqxudZ/60ufTjZ68E6JswPgPzvnKQN9VEajH2LjqtLYNGmrSafLSdOjKEW9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPmO3AOd; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714597190; x=1746133190;
  h=date:from:to:cc:subject:message-id;
  bh=e3Re1S+hcoPfrhP63eDdkBaqUByGdLmYGewWsjUP41A=;
  b=ZPmO3AOdW1eVkhABmNKfeuvqLRvwXTdqSODk7Nit3ODWZFuwfDCEn1Sp
   dJO3pLC3SbQMOmS7+3rgOPu7z/CY/5BYzIB3mrqD9mHd4nR+to0/Mvxxc
   CwtZgI7z2upTmvSItJaj4X809/0KKi3cgWHmy0dnay3eucG1CAUpEZo+w
   Hm9eUqUbBd2MY6UBN13K1TA2qrUbrFuWN37fBx+Ziv9GHQ7AxzP0lj8MH
   fj1T+1GfZ6Q7fsEsIFfIzRqbmFhkVcD2PYkSIWeUD6qERg4tRjhv0tojc
   lqIZiq4sPuBuPfKVLIxBQqYn+MWIWrA9xlqjJ7+J62NVQfTVDw3wy+DRo
   w==;
X-CSE-ConnectionGUID: 3BA9JbIJQ0KDJEXCisCDzA==
X-CSE-MsgGUID: Vtbt5wnESQSbpEG+XfVDEw==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10219859"
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="10219859"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 13:59:49 -0700
X-CSE-ConnectionGUID: SkPQEHdoTeOjmP99tDo79g==
X-CSE-MsgGUID: O/VO/bC6RQ+uHJwRMQYDPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="31588675"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 01 May 2024 13:59:48 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2H3J-0009yc-0z;
	Wed, 01 May 2024 20:59:45 +0000
Date: Thu, 02 May 2024 04:58:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 8f906dfee894690940afdc9d68c4f580c452f046
Message-ID: <202405020453.6Qp93LI3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 8f906dfee894690940afdc9d68c4f580c452f046  Merge branch 'acpi-scan' into bleeding-edge

elapsed time: 1459m

configs tested: 178
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240501   gcc  
arc                   randconfig-002-20240501   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                   randconfig-001-20240501   gcc  
arm                   randconfig-002-20240501   gcc  
arm                   randconfig-003-20240501   clang
arm                   randconfig-004-20240501   gcc  
arm                             rpc_defconfig   clang
arm                         s3c6400_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240501   gcc  
arm64                 randconfig-002-20240501   gcc  
arm64                 randconfig-003-20240501   clang
arm64                 randconfig-004-20240501   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240501   gcc  
csky                  randconfig-002-20240501   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240501   clang
hexagon               randconfig-002-20240501   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240501   clang
i386         buildonly-randconfig-002-20240501   gcc  
i386         buildonly-randconfig-003-20240501   clang
i386         buildonly-randconfig-004-20240501   gcc  
i386         buildonly-randconfig-005-20240501   gcc  
i386         buildonly-randconfig-006-20240501   clang
i386                                defconfig   clang
i386                  randconfig-001-20240501   gcc  
i386                  randconfig-002-20240501   clang
i386                  randconfig-003-20240501   gcc  
i386                  randconfig-004-20240501   gcc  
i386                  randconfig-005-20240501   clang
i386                  randconfig-006-20240501   clang
i386                  randconfig-011-20240501   gcc  
i386                  randconfig-012-20240501   gcc  
i386                  randconfig-013-20240501   gcc  
i386                  randconfig-014-20240501   gcc  
i386                  randconfig-015-20240501   gcc  
i386                  randconfig-016-20240501   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240501   gcc  
loongarch             randconfig-002-20240501   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
mips                           xway_defconfig   clang
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240501   gcc  
nios2                 randconfig-002-20240501   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240501   gcc  
parisc                randconfig-002-20240501   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   currituck_defconfig   clang
powerpc                      ppc40x_defconfig   clang
powerpc               randconfig-001-20240501   clang
powerpc               randconfig-002-20240501   clang
powerpc               randconfig-003-20240501   clang
powerpc                    socrates_defconfig   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240501   clang
powerpc64             randconfig-002-20240501   clang
powerpc64             randconfig-003-20240501   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240501   clang
riscv                 randconfig-002-20240501   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240501   gcc  
s390                  randconfig-002-20240501   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240501   gcc  
sh                    randconfig-002-20240501   gcc  
sh                           se7343_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240501   gcc  
sparc64               randconfig-002-20240501   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240501   gcc  
um                    randconfig-002-20240501   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240501   gcc  
x86_64       buildonly-randconfig-002-20240501   clang
x86_64       buildonly-randconfig-003-20240501   gcc  
x86_64       buildonly-randconfig-004-20240501   gcc  
x86_64       buildonly-randconfig-005-20240501   clang
x86_64       buildonly-randconfig-006-20240501   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240501   gcc  
x86_64                randconfig-002-20240501   gcc  
x86_64                randconfig-003-20240501   gcc  
x86_64                randconfig-004-20240501   clang
x86_64                randconfig-005-20240501   clang
x86_64                randconfig-006-20240501   gcc  
x86_64                randconfig-011-20240501   gcc  
x86_64                randconfig-012-20240501   clang
x86_64                randconfig-013-20240501   gcc  
x86_64                randconfig-014-20240501   clang
x86_64                randconfig-015-20240501   clang
x86_64                randconfig-016-20240501   clang
x86_64                randconfig-071-20240501   clang
x86_64                randconfig-072-20240501   clang
x86_64                randconfig-073-20240501   clang
x86_64                randconfig-074-20240501   gcc  
x86_64                randconfig-075-20240501   gcc  
x86_64                randconfig-076-20240501   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240501   gcc  
xtensa                randconfig-002-20240501   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

