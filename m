Return-Path: <linux-acpi+bounces-4573-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B99892C22
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Mar 2024 18:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0065E282D84
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Mar 2024 17:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF18E3A8CE;
	Sat, 30 Mar 2024 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KroSnvmy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB242AF13;
	Sat, 30 Mar 2024 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711819899; cv=none; b=P4/7tYSj3FtQxNBKV1LJGQJzRBOxPhw5d3yTp0GjqLWbqB4Dw5fdTXjOQjzXq1D9VHbscStLJsAb0OAvYXNMm7QTJXhiGGCC3A3kn5+X6CvnAFBmbROi8mxwrv4ABSEuNb8tTnwuXXgXRVuFppAg1coBwHpL8lfH9duf/zAFLXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711819899; c=relaxed/simple;
	bh=giVx9/Fipt8Pgmlsg1aHLlHlo1g8adYHBDtICHP+gRc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EAatlvhYIXk6V3nN3CbrJHHUvjTvR4O3h+gpkfqr5ZBUwrHvWjWeLqbwuPCIHFNqszOq7OustOpgVSFfF8N6US+nJsrgDnk390shQeWuPUu/dYtlRou47zNI1mp8ZUrKr1MXLs4A/HnyPUMcuSo4ftLn+xfCVaqL1bP/1vS4mbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KroSnvmy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711819898; x=1743355898;
  h=date:from:to:cc:subject:message-id;
  bh=giVx9/Fipt8Pgmlsg1aHLlHlo1g8adYHBDtICHP+gRc=;
  b=KroSnvmyV2cJxCWGOJTyYO+A84ece9rzKaGPJQz4JKpFXzE93SrmpSd9
   aGjxrjSsQuEu5Ms27EURWQ38MiRobwebkwDqF8ynpQC7ySGFBog3KpDTy
   oVXjkMLH4a58CQhjMsl5hj6TTi8O2+L2veOWKdivtAP9j5YlHeM0WuQNb
   LRPwMmH7OJyAmIx51HU/sTLUpHl1j5UL34ElAPPfhAg9hmsRwmrDsKZez
   4+SeNYumUPShTwdNo+LPzTZTEtHvJOv/giOp6UMyP02XuTOKLjpVIsBYf
   eNIe2TnEvk+k4ZrRWErUHm1graemwjEmOZRf4ec0OnszZBUSjJnhfmpK8
   A==;
X-CSE-ConnectionGUID: nf2XccxLTBqBEHdMkn6Wnw==
X-CSE-MsgGUID: pguGgiFpR42kTlGW0M1iiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11029"; a="7112741"
X-IronPort-AV: E=Sophos;i="6.07,168,1708416000"; 
   d="scan'208";a="7112741"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2024 10:31:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,168,1708416000"; 
   d="scan'208";a="17315341"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 30 Mar 2024 10:31:35 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqcYH-0000Ea-0l;
	Sat, 30 Mar 2024 17:31:33 +0000
Date: Sun, 31 Mar 2024 01:30:53 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 07ab29143acde0dec716a5a94c694b995e19d2a4
Message-ID: <202403310152.q7lte70t-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 07ab29143acde0dec716a5a94c694b995e19d2a4  Merge branches 'thermal-core' and 'thermal-intel' into linux-next

elapsed time: 1381m

configs tested: 177
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
arc                            hsdk_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240330   gcc  
arc                   randconfig-002-20240330   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                        neponset_defconfig   gcc  
arm                   randconfig-001-20240330   clang
arm                   randconfig-002-20240330   clang
arm                   randconfig-003-20240330   gcc  
arm                   randconfig-004-20240330   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240330   clang
arm64                 randconfig-002-20240330   clang
arm64                 randconfig-003-20240330   clang
arm64                 randconfig-004-20240330   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240330   gcc  
csky                  randconfig-002-20240330   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240330   clang
hexagon               randconfig-002-20240330   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240330   clang
i386         buildonly-randconfig-002-20240330   clang
i386         buildonly-randconfig-003-20240330   clang
i386         buildonly-randconfig-004-20240330   clang
i386         buildonly-randconfig-005-20240330   clang
i386         buildonly-randconfig-006-20240330   clang
i386                                defconfig   clang
i386                  randconfig-001-20240330   clang
i386                  randconfig-002-20240330   clang
i386                  randconfig-003-20240330   clang
i386                  randconfig-004-20240330   clang
i386                  randconfig-005-20240330   clang
i386                  randconfig-006-20240330   gcc  
i386                  randconfig-011-20240330   clang
i386                  randconfig-012-20240330   gcc  
i386                  randconfig-013-20240330   gcc  
i386                  randconfig-014-20240330   clang
i386                  randconfig-015-20240330   gcc  
i386                  randconfig-016-20240330   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240330   gcc  
loongarch             randconfig-002-20240330   gcc  
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
mips                          ath25_defconfig   clang
mips                           mtx1_defconfig   clang
mips                           rs90_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240330   gcc  
nios2                 randconfig-002-20240330   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240330   gcc  
parisc                randconfig-002-20240330   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      chrp32_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc               randconfig-001-20240330   gcc  
powerpc               randconfig-002-20240330   clang
powerpc               randconfig-003-20240330   clang
powerpc64             randconfig-001-20240330   gcc  
powerpc64             randconfig-002-20240330   gcc  
powerpc64             randconfig-003-20240330   gcc  
riscv                            alldefconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240330   gcc  
riscv                 randconfig-002-20240330   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240330   clang
s390                  randconfig-002-20240330   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                    randconfig-001-20240330   gcc  
sh                    randconfig-002-20240330   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240330   gcc  
sparc64               randconfig-002-20240330   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240330   clang
um                    randconfig-002-20240330   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240330   gcc  
x86_64       buildonly-randconfig-002-20240330   gcc  
x86_64       buildonly-randconfig-003-20240330   clang
x86_64       buildonly-randconfig-004-20240330   clang
x86_64       buildonly-randconfig-005-20240330   gcc  
x86_64       buildonly-randconfig-006-20240330   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240330   gcc  
x86_64                randconfig-002-20240330   clang
x86_64                randconfig-003-20240330   clang
x86_64                randconfig-004-20240330   gcc  
x86_64                randconfig-005-20240330   gcc  
x86_64                randconfig-006-20240330   gcc  
x86_64                randconfig-011-20240330   clang
x86_64                randconfig-012-20240330   clang
x86_64                randconfig-013-20240330   clang
x86_64                randconfig-014-20240330   gcc  
x86_64                randconfig-015-20240330   gcc  
x86_64                randconfig-016-20240330   gcc  
x86_64                randconfig-071-20240330   clang
x86_64                randconfig-072-20240330   clang
x86_64                randconfig-073-20240330   gcc  
x86_64                randconfig-074-20240330   clang
x86_64                randconfig-075-20240330   clang
x86_64                randconfig-076-20240330   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240330   gcc  
xtensa                randconfig-002-20240330   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

