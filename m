Return-Path: <linux-acpi+bounces-4346-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DFC87C844
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Mar 2024 05:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83CE1F215EC
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Mar 2024 04:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E98ED53F;
	Fri, 15 Mar 2024 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GqtiJSZU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C3D8831;
	Fri, 15 Mar 2024 04:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710477429; cv=none; b=gCCYUsciyytUjErNQ/4PV5tjALkWBZub/IyaeQSu2Rr9hswDpph60fr0+4Lka9zAocOpMsF6OV73Hnz/cpAo7JmuZJqa03Xy2fc/14ih1IEWaedxO4BiT1reeLoxEErKRgS/1V2HLlamoz9riowXPYU5Vbmom4sN1jTZQ8Cs1Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710477429; c=relaxed/simple;
	bh=3aHitELWzV80ymp5VHagQAAEsdm9QsEZ4580EBX7VMQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=u9/G1D52hTeisozmGp6Drbz4ixVzvcU9ljkfbo/wfo2QjwcZzK4fsPLYVY57ttu83YpoOAnRoBINfW+hXWWnk7JpU9JHfYEveCFyQRJzfwqF/SAZwodpz0KFeENM+2mJ1eY8xhy7e5SPYYBRFCAWnhgjezNk/5wpDJPSLSsBzpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GqtiJSZU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710477427; x=1742013427;
  h=date:from:to:cc:subject:message-id;
  bh=3aHitELWzV80ymp5VHagQAAEsdm9QsEZ4580EBX7VMQ=;
  b=GqtiJSZUYqyC6wEo17DjdeEdYQFgN9CMnT/3b0SPCfKEz6U7HY8fbGSt
   CkdnFqYvpHVeROiDM3Z3sWuW82eTlC0qjv/1La98CLvDdNu2szmthb4+h
   MD+2nmjz45I4gWga1KsODLnqnEDbdA405wMSqlAKqyAFxhl3dRPRj9M5N
   zUwqLcx3DsHAJvW9AGOdHAoGt+crzAI4e6TjLqQXaFBLX/2qSW1/+prMy
   AkKUknLuWOs420mIISekyEkMT7m/ZjHCDoy6JggV5BYdMAldsdAXrfmVu
   518il+yUHXr1RU9RQasmrF1PSaLoP0qN2K7T1KcSsS3/OSXMVrsWYotBX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="22854371"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="22854371"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 21:36:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="13154681"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 14 Mar 2024 21:36:56 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkzJN-000E6F-2Z;
	Fri, 15 Mar 2024 04:36:53 +0000
Date: Fri, 15 Mar 2024 12:36:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 2be1965caeef7aed6fb2a9cfa76e83ba0165cde5
Message-ID: <202403151222.uQEU9yrZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 2be1965caeef7aed6fb2a9cfa76e83ba0165cde5  Merge branch 'acpi-docs' into bleeding-edge

elapsed time: 727m

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
arc                   randconfig-001-20240315   gcc  
arc                   randconfig-002-20240315   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                         lpc18xx_defconfig   clang
arm                   randconfig-001-20240315   clang
arm                   randconfig-002-20240315   gcc  
arm                   randconfig-003-20240315   gcc  
arm                   randconfig-004-20240315   gcc  
arm                         socfpga_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240315   gcc  
arm64                 randconfig-002-20240315   gcc  
arm64                 randconfig-003-20240315   gcc  
arm64                 randconfig-004-20240315   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240315   gcc  
csky                  randconfig-002-20240315   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240315   clang
hexagon               randconfig-002-20240315   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240315   clang
i386         buildonly-randconfig-002-20240315   clang
i386         buildonly-randconfig-003-20240315   gcc  
i386         buildonly-randconfig-004-20240315   clang
i386         buildonly-randconfig-005-20240315   gcc  
i386         buildonly-randconfig-006-20240315   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240315   gcc  
i386                  randconfig-002-20240315   clang
i386                  randconfig-003-20240315   clang
i386                  randconfig-004-20240315   clang
i386                  randconfig-005-20240315   gcc  
i386                  randconfig-006-20240315   clang
i386                  randconfig-011-20240315   clang
i386                  randconfig-012-20240315   gcc  
i386                  randconfig-013-20240315   gcc  
i386                  randconfig-014-20240315   clang
i386                  randconfig-015-20240315   gcc  
i386                  randconfig-016-20240315   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240315   gcc  
loongarch             randconfig-002-20240315   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip32_defconfig   clang
mips                      loongson3_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240315   gcc  
nios2                 randconfig-002-20240315   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240315   gcc  
parisc                randconfig-002-20240315   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240315   clang
powerpc               randconfig-002-20240315   gcc  
powerpc               randconfig-003-20240315   clang
powerpc                     stx_gp3_defconfig   clang
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-001-20240315   clang
powerpc64             randconfig-002-20240315   gcc  
powerpc64             randconfig-003-20240315   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240315   clang
riscv                 randconfig-002-20240315   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240315   gcc  
s390                  randconfig-002-20240315   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240315   gcc  
sh                    randconfig-002-20240315   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240315   gcc  
sparc64               randconfig-002-20240315   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240315   gcc  
um                    randconfig-002-20240315   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240315   gcc  
x86_64       buildonly-randconfig-002-20240315   gcc  
x86_64       buildonly-randconfig-003-20240315   gcc  
x86_64       buildonly-randconfig-004-20240315   gcc  
x86_64       buildonly-randconfig-005-20240315   clang
x86_64       buildonly-randconfig-006-20240315   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240315   gcc  
x86_64                randconfig-002-20240315   clang
x86_64                randconfig-003-20240315   gcc  
x86_64                randconfig-004-20240315   clang
x86_64                randconfig-005-20240315   gcc  
x86_64                randconfig-006-20240315   gcc  
x86_64                randconfig-011-20240315   clang
x86_64                randconfig-012-20240315   gcc  
x86_64                randconfig-013-20240315   gcc  
x86_64                randconfig-014-20240315   gcc  
x86_64                randconfig-015-20240315   clang
x86_64                randconfig-016-20240315   clang
x86_64                randconfig-071-20240315   clang
x86_64                randconfig-072-20240315   clang
x86_64                randconfig-073-20240315   gcc  
x86_64                randconfig-074-20240315   gcc  
x86_64                randconfig-075-20240315   clang
x86_64                randconfig-076-20240315   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-002-20240315   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

