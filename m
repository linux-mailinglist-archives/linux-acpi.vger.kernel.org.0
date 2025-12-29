Return-Path: <linux-acpi+bounces-19879-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B818CE6780
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Dec 2025 12:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2895530014EE
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Dec 2025 11:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2CA2F999A;
	Mon, 29 Dec 2025 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SO64fB9U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FF72F83B8;
	Mon, 29 Dec 2025 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767006670; cv=none; b=E4LDFM0vAsYRco10BdHN6UCAsm2CRZHEmQvT9VVVs4isw91I5OL1Eu61vtJo/dLqjTAAjbrUa6Kg2VyN3Sxs90rsAVEty37F0Xujyip2ohUKHsvlECRUw984HzvE9w2KvuttJj8/JxIoxvml7lwmlRvfe9bEKbwFNrNbETfHqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767006670; c=relaxed/simple;
	bh=c5u0AJqwycdVZpVANCBFJT+wYGH+NRTivgFVy6yK+5g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gaKTPWUQWdDWdDW9vPpi0b3E9QJb5Jrfl2AW0pZwI6JWZrgjH65msZzSNEOwQEdoRz8NnSvJZK1oGWsQcXFjkeu9j42bILIsFPymkrFXcbY6ds31oHpU5U8mjhCbJNlBChH4V4efG5YO3Exg0kcR04j3q40GKu3XXvaN7xyGgjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SO64fB9U; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767006668; x=1798542668;
  h=date:from:to:cc:subject:message-id;
  bh=c5u0AJqwycdVZpVANCBFJT+wYGH+NRTivgFVy6yK+5g=;
  b=SO64fB9UUq+o2snqs2b4XYcxNUZc3ZqudMwnGs0dWGqQrIrkDtO+DV45
   wsz4nYpCruGBihqRCbgV3Wv9S7FrQHPOorpv8FYOxOd565jNLT3QXTmeG
   FG+d7C4nvlYb3AE22zxLf9HinfZxlaie0t9I78XDWnc8aaWWO/Ay6Cjja
   evUVtnMRqHtjwMtXQ1yYfbF9a3loU3/FBIy5OlGgRzOWkuLumT25pN9r4
   jlfmEatigxHA4Zhmj4mVW0+bvglkcbCZBP68287LzXfsybYvgZN8vN8dP
   coOC7pF+vqzaDofnnvDJPL+16Hp1jg9CwxQgGEWnxVDrg6x3ZqbXdhJMW
   g==;
X-CSE-ConnectionGUID: 8y7zIz/cTLmx8bKfIiC+pw==
X-CSE-MsgGUID: fy5yz/NaSL+2HfK3Mx3zgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11655"; a="68688649"
X-IronPort-AV: E=Sophos;i="6.21,185,1763452800"; 
   d="scan'208";a="68688649"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 03:11:07 -0800
X-CSE-ConnectionGUID: B+0xreLhRlyTRbjswTtyKg==
X-CSE-MsgGUID: Mglh7MWcQyOhQFV4AzNhzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,185,1763452800"; 
   d="scan'208";a="205373385"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 29 Dec 2025 03:11:05 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vaB9M-000000007AT-26zA;
	Mon, 29 Dec 2025 11:10:57 +0000
Date: Mon, 29 Dec 2025 19:09:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 604ad4e7f5b87fcc452f6ee5822c224c2a043cb0
Message-ID: <202512291950.IqHV1eeJ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 604ad4e7f5b87fcc452f6ee5822c224c2a043cb0  Merge branch 'pm-sleep-fixes' into fixes

elapsed time: 1375m

configs tested: 297
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                            hsdk_defconfig    gcc-15.1.0
arc                   randconfig-001-20251228    gcc-10.5.0
arc                   randconfig-001-20251229    gcc-8.5.0
arc                   randconfig-002-20251228    gcc-8.5.0
arc                   randconfig-002-20251229    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.1.0
arm                            dove_defconfig    gcc-15.1.0
arm                   milbeaut_m10v_defconfig    gcc-14
arm                        mvebu_v7_defconfig    gcc-14
arm                   randconfig-001-20251228    gcc-8.5.0
arm                   randconfig-001-20251229    gcc-8.5.0
arm                   randconfig-002-20251228    gcc-15.1.0
arm                   randconfig-002-20251229    gcc-8.5.0
arm                   randconfig-003-20251228    clang-22
arm                   randconfig-003-20251229    gcc-8.5.0
arm                   randconfig-004-20251228    gcc-13.4.0
arm                   randconfig-004-20251229    gcc-8.5.0
arm64                            alldefconfig    gcc-14
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251228    gcc-8.5.0
arm64                 randconfig-002-20251228    clang-22
arm64                 randconfig-003-20251228    clang-22
arm64                 randconfig-004-20251228    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251228    gcc-11.5.0
csky                  randconfig-002-20251228    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251228    clang-22
hexagon               randconfig-001-20251229    clang-18
hexagon               randconfig-002-20251228    clang-22
hexagon               randconfig-002-20251229    clang-18
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251228    gcc-14
i386        buildonly-randconfig-001-20251229    gcc-14
i386        buildonly-randconfig-002-20251228    clang-20
i386        buildonly-randconfig-002-20251229    gcc-14
i386        buildonly-randconfig-003-20251228    gcc-12
i386        buildonly-randconfig-003-20251229    gcc-14
i386        buildonly-randconfig-004-20251228    clang-20
i386        buildonly-randconfig-004-20251229    gcc-14
i386        buildonly-randconfig-005-20251228    clang-20
i386        buildonly-randconfig-005-20251229    gcc-14
i386        buildonly-randconfig-006-20251228    clang-20
i386        buildonly-randconfig-006-20251229    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251228    gcc-12
i386                  randconfig-001-20251229    clang-20
i386                  randconfig-002-20251228    clang-20
i386                  randconfig-002-20251229    clang-20
i386                  randconfig-003-20251228    gcc-14
i386                  randconfig-003-20251229    clang-20
i386                  randconfig-004-20251228    gcc-14
i386                  randconfig-004-20251229    clang-20
i386                  randconfig-005-20251228    gcc-14
i386                  randconfig-005-20251229    clang-20
i386                  randconfig-006-20251228    gcc-14
i386                  randconfig-006-20251229    clang-20
i386                  randconfig-007-20251228    gcc-14
i386                  randconfig-007-20251229    clang-20
i386                  randconfig-011-20251228    clang-20
i386                  randconfig-011-20251229    gcc-14
i386                  randconfig-012-20251228    gcc-14
i386                  randconfig-012-20251229    gcc-14
i386                  randconfig-013-20251228    gcc-13
i386                  randconfig-013-20251229    gcc-14
i386                  randconfig-014-20251228    clang-20
i386                  randconfig-014-20251229    gcc-14
i386                  randconfig-015-20251228    clang-20
i386                  randconfig-015-20251229    gcc-14
i386                  randconfig-016-20251228    gcc-14
i386                  randconfig-016-20251229    gcc-14
i386                  randconfig-017-20251228    gcc-14
i386                  randconfig-017-20251229    gcc-14
loongarch                        alldefconfig    gcc-15.1.0
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251228    clang-22
loongarch             randconfig-001-20251229    clang-18
loongarch             randconfig-002-20251228    gcc-15.1.0
loongarch             randconfig-002-20251229    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.1.0
m68k                            q40_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                          ath25_defconfig    gcc-14
mips                       bmips_be_defconfig    gcc-15.1.0
mips                           jazz_defconfig    gcc-15.1.0
mips                      pic32mzda_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251228    gcc-11.5.0
nios2                 randconfig-001-20251229    clang-18
nios2                 randconfig-002-20251228    gcc-8.5.0
nios2                 randconfig-002-20251229    clang-18
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-64bit_defconfig    gcc-14
parisc                randconfig-001-20251228    gcc-10.5.0
parisc                randconfig-001-20251229    gcc-12.5.0
parisc                randconfig-002-20251228    gcc-8.5.0
parisc                randconfig-002-20251229    gcc-12.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      arches_defconfig    gcc-15.1.0
powerpc                 linkstation_defconfig    clang-20
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251228    clang-22
powerpc               randconfig-001-20251229    gcc-12.5.0
powerpc               randconfig-002-20251228    clang-22
powerpc                     stx_gp3_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251228    gcc-15.1.0
powerpc64             randconfig-001-20251229    gcc-12.5.0
powerpc64             randconfig-002-20251228    gcc-8.5.0
powerpc64             randconfig-002-20251229    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251228    clang-22
riscv                 randconfig-001-20251229    gcc-12.5.0
riscv                 randconfig-002-20251228    clang-22
riscv                 randconfig-002-20251229    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251228    gcc-15.1.0
s390                  randconfig-001-20251229    gcc-12.5.0
s390                  randconfig-002-20251228    clang-22
s390                  randconfig-002-20251229    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251228    gcc-13.4.0
sh                    randconfig-001-20251229    gcc-12.5.0
sh                    randconfig-002-20251228    gcc-15.1.0
sh                    randconfig-002-20251229    gcc-12.5.0
sh                          sdk7780_defconfig    gcc-15.1.0
sh                           se7750_defconfig    gcc-15.1.0
sh                        sh7763rdp_defconfig    gcc-15.1.0
sh                             shx3_defconfig    gcc-14
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251228    gcc-14.3.0
sparc                 randconfig-001-20251229    gcc-14
sparc                 randconfig-002-20251228    gcc-12.5.0
sparc                 randconfig-002-20251229    gcc-14
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251228    clang-22
sparc64               randconfig-001-20251229    gcc-14
sparc64               randconfig-002-20251228    clang-20
sparc64               randconfig-002-20251229    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251228    clang-22
um                    randconfig-001-20251229    gcc-14
um                    randconfig-002-20251228    clang-22
um                    randconfig-002-20251229    gcc-14
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251228    gcc-14
x86_64      buildonly-randconfig-001-20251229    clang-20
x86_64      buildonly-randconfig-001-20251229    gcc-14
x86_64      buildonly-randconfig-002-20251228    gcc-14
x86_64      buildonly-randconfig-002-20251229    clang-20
x86_64      buildonly-randconfig-002-20251229    gcc-14
x86_64      buildonly-randconfig-003-20251229    gcc-14
x86_64      buildonly-randconfig-004-20251228    gcc-14
x86_64      buildonly-randconfig-004-20251229    clang-20
x86_64      buildonly-randconfig-004-20251229    gcc-14
x86_64      buildonly-randconfig-005-20251228    gcc-14
x86_64      buildonly-randconfig-005-20251229    gcc-14
x86_64      buildonly-randconfig-006-20251229    gcc-13
x86_64      buildonly-randconfig-006-20251229    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251228    clang-20
x86_64                randconfig-001-20251229    clang-20
x86_64                randconfig-002-20251228    clang-20
x86_64                randconfig-002-20251229    clang-20
x86_64                randconfig-003-20251228    clang-20
x86_64                randconfig-003-20251229    clang-20
x86_64                randconfig-004-20251228    gcc-14
x86_64                randconfig-004-20251229    clang-20
x86_64                randconfig-005-20251228    clang-20
x86_64                randconfig-005-20251229    clang-20
x86_64                randconfig-006-20251228    gcc-14
x86_64                randconfig-006-20251229    clang-20
x86_64                randconfig-011-20251228    gcc-14
x86_64                randconfig-011-20251229    clang-20
x86_64                randconfig-012-20251228    gcc-14
x86_64                randconfig-012-20251229    clang-20
x86_64                randconfig-013-20251228    clang-20
x86_64                randconfig-013-20251229    clang-20
x86_64                randconfig-014-20251228    clang-20
x86_64                randconfig-014-20251229    clang-20
x86_64                randconfig-015-20251228    clang-20
x86_64                randconfig-015-20251229    clang-20
x86_64                randconfig-016-20251228    gcc-12
x86_64                randconfig-016-20251229    clang-20
x86_64                randconfig-071-20251228    gcc-14
x86_64                randconfig-071-20251229    clang-20
x86_64                randconfig-072-20251228    gcc-14
x86_64                randconfig-072-20251229    clang-20
x86_64                randconfig-073-20251228    gcc-14
x86_64                randconfig-073-20251229    clang-20
x86_64                randconfig-074-20251228    gcc-14
x86_64                randconfig-074-20251229    clang-20
x86_64                randconfig-075-20251228    clang-20
x86_64                randconfig-075-20251229    clang-20
x86_64                randconfig-076-20251228    clang-20
x86_64                randconfig-076-20251229    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                          iss_defconfig    gcc-15.1.0
xtensa                  nommu_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251228    gcc-10.5.0
xtensa                randconfig-001-20251229    gcc-14
xtensa                randconfig-002-20251228    gcc-8.5.0
xtensa                randconfig-002-20251229    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

