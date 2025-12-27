Return-Path: <linux-acpi+bounces-19868-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49275CDF3E8
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Dec 2025 05:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B7EB3006638
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Dec 2025 04:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4F820ADD6;
	Sat, 27 Dec 2025 04:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqd0xzyx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F242D1A76DE;
	Sat, 27 Dec 2025 04:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766809360; cv=none; b=c12EKXAIW66T3Zc94kv21mZcpOrocwCnXWXCVX+aEIjOgtMC8aPgPR9X+LYfQATkQV6FQfSAYQyb+0vH7bwkTIJEbnCP/W1WZxNStUNfSiwia2Y7z5+uvSyFqJ9yH+3weL/yZ497O0J8ezqkmGkKvcvA0jKM9QCsObI1dOpVI0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766809360; c=relaxed/simple;
	bh=dp70WJNwdj5yhpJdE+P2vLgMwb8cjrI8A0plzTqlEis=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RQU/OgYZ5CY5I+iwuXeRYIKpK928bCu72oavouZiTXDGlFQN0ydgUuMy8Pf7+9AGPhA0nVPp9BH6Ca7bIT4tFsbs5qsFNiEgcbfACa4dEKnAsvN2iiYqU8MfEMkxw8lJxMmGKueQGOv1b/3is0obbrVtom2KXX/bS4d1Xwfj0hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqd0xzyx; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766809358; x=1798345358;
  h=date:from:to:cc:subject:message-id;
  bh=dp70WJNwdj5yhpJdE+P2vLgMwb8cjrI8A0plzTqlEis=;
  b=dqd0xzyxUKpCZ3bxZ8aNL13IX2BEEBFQ/4qJwqVyTLnxd7cg8x6nLWwV
   gBL8OY2x7tN9Fu/v7gCcU5noukeOqxlcYu+DS2pR0mrXSwFr9CqNrmFTC
   tsOiaDPN2mF8kXOj04ECi22gj5hn2h4ut1PD9e+0ITSOXY/bOt24h9sd8
   b9/3l+1czAzL4c6TI2ThWV6j3UdMa8/Ux7Awg4gMCYRV0Ynj5VfyoYIb6
   uVYatQwNFfMq5db/u+mkxH+MCw9UoLXj/YlBtb7QxQuty/EAX9i8EG4Yo
   EbyOD5WJaS1k8EJhoeW2pr1V2jLBgXvcFaPfFD1jXxOE5qILb41p6sojy
   Q==;
X-CSE-ConnectionGUID: NrTXhDyGTR+ifkA55vX96Q==
X-CSE-MsgGUID: HZvbCmn9TZy1CxxNuEORQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11653"; a="68579759"
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="68579759"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2025 20:22:37 -0800
X-CSE-ConnectionGUID: SE341f3wTO6+K46LswiwHg==
X-CSE-MsgGUID: vxEiNkhsTVyaUGAg03MQ4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="205027623"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 26 Dec 2025 20:22:36 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vZLox-000000005Wz-3rd8;
	Sat, 27 Dec 2025 04:22:29 +0000
Date: Sat, 27 Dec 2025 12:21:29 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 a90d93563047cc5c86142aa0a6bfee7a5a0ec919
Message-ID: <202512271224.DBGh6pB1-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: a90d93563047cc5c86142aa0a6bfee7a5a0ec919  Merge branch 'acpi-queue' into bleeding-edge

elapsed time: 801m

configs tested: 166
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251227    gcc-11.5.0
arc                   randconfig-002-20251227    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                         lpc32xx_defconfig    clang-17
arm                   randconfig-001-20251227    gcc-8.5.0
arm                   randconfig-002-20251227    clang-22
arm                   randconfig-003-20251227    clang-22
arm                   randconfig-004-20251227    clang-22
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251226    clang-20
arm64                 randconfig-002-20251226    clang-22
arm64                 randconfig-003-20251226    gcc-12.5.0
arm64                 randconfig-004-20251226    gcc-13.4.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251226    gcc-15.1.0
csky                  randconfig-002-20251226    gcc-12.5.0
hexagon                          alldefconfig    clang-22
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251226    clang-17
hexagon               randconfig-002-20251226    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251226    gcc-14
i386        buildonly-randconfig-002-20251226    gcc-12
i386        buildonly-randconfig-003-20251226    gcc-14
i386        buildonly-randconfig-004-20251226    gcc-14
i386        buildonly-randconfig-005-20251226    clang-20
i386        buildonly-randconfig-006-20251226    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251226    gcc-14
i386                  randconfig-002-20251226    gcc-14
i386                  randconfig-003-20251226    gcc-14
i386                  randconfig-004-20251226    gcc-14
i386                  randconfig-005-20251226    clang-20
i386                  randconfig-006-20251226    gcc-14
i386                  randconfig-007-20251226    gcc-14
i386                  randconfig-011-20251227    gcc-14
i386                  randconfig-012-20251227    clang-20
i386                  randconfig-013-20251227    gcc-14
i386                  randconfig-014-20251227    gcc-14
i386                  randconfig-015-20251227    gcc-12
i386                  randconfig-016-20251227    clang-20
i386                  randconfig-017-20251227    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251226    gcc-15.1.0
loongarch             randconfig-002-20251226    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251226    gcc-9.5.0
nios2                 randconfig-002-20251226    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251226    gcc-14.3.0
parisc                randconfig-002-20251226    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      pmac32_defconfig    clang-22
powerpc               randconfig-001-20251226    clang-17
powerpc               randconfig-002-20251226    gcc-9.5.0
powerpc                     sequoia_defconfig    clang-17
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20251226    gcc-15.1.0
powerpc64             randconfig-002-20251226    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251226    gcc-15.1.0
riscv                 randconfig-002-20251226    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251226    clang-17
s390                  randconfig-002-20251226    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251226    gcc-9.5.0
sh                    randconfig-002-20251226    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251226    gcc-14.3.0
sparc                 randconfig-002-20251226    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251226    gcc-11.5.0
sparc64               randconfig-002-20251226    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251226    clang-22
um                    randconfig-002-20251226    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251226    gcc-12
x86_64      buildonly-randconfig-002-20251226    clang-20
x86_64      buildonly-randconfig-003-20251226    gcc-12
x86_64      buildonly-randconfig-004-20251226    clang-20
x86_64      buildonly-randconfig-005-20251226    gcc-14
x86_64      buildonly-randconfig-006-20251226    gcc-12
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251227    gcc-14
x86_64                randconfig-002-20251227    gcc-12
x86_64                randconfig-003-20251227    gcc-14
x86_64                randconfig-004-20251227    clang-20
x86_64                randconfig-005-20251227    gcc-14
x86_64                randconfig-006-20251227    clang-20
x86_64                randconfig-011-20251226    clang-20
x86_64                randconfig-012-20251226    gcc-14
x86_64                randconfig-013-20251226    gcc-14
x86_64                randconfig-014-20251226    clang-20
x86_64                randconfig-015-20251226    gcc-14
x86_64                randconfig-016-20251226    gcc-14
x86_64                randconfig-071-20251226    gcc-12
x86_64                randconfig-072-20251226    clang-20
x86_64                randconfig-073-20251226    gcc-14
x86_64                randconfig-074-20251226    gcc-14
x86_64                randconfig-075-20251226    gcc-14
x86_64                randconfig-076-20251226    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                       common_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251226    gcc-8.5.0
xtensa                randconfig-002-20251226    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

