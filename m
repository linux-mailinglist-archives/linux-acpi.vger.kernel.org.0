Return-Path: <linux-acpi+bounces-7542-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586C394F9C0
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 00:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13890281139
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 22:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE80192B8A;
	Mon, 12 Aug 2024 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCUBlF3F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA661953B9;
	Mon, 12 Aug 2024 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502327; cv=none; b=TN59yckulpjamtrX9J9ktDVwPEIkwHp/hpr9df3idinPd+5gV0RbpswjtSF3r/d0FtbKoU4o/xjxduC1pk5k6+HjGQQjhJECZONza4dZgid9oWgCtD0HgpcFy5uoQ8hx2ZlbtPVbUpR/T0HKSZn1Wyu7fIbAmj2olnORM0l4Vic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502327; c=relaxed/simple;
	bh=fs9uWawbxdntjCij/irgiHxw3d98pqFhpJ0sn3rktHs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cjjF2XQ2E0NLg5VNpIiZ9ssDZphz1C6fBvNKzxruF8/n/+gxksSYGUV00xlOftgJSgdZHlpTE8NtTQUrVgltgbPWQiNa4k2iAthvyQHnH0M6KcF5Y0poX3Yb7kGPeniWBb3UDOawmYj8nodQiVz9H1qQ8BbzWlets2ufKzgr0Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCUBlF3F; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723502325; x=1755038325;
  h=date:from:to:cc:subject:message-id;
  bh=fs9uWawbxdntjCij/irgiHxw3d98pqFhpJ0sn3rktHs=;
  b=eCUBlF3Fv1cjGfLevFqYQKMgrIqGXDUluF0rlKBqQYumAMlTQMx4qQkV
   cbC8U08r3osd8y+WPzgXJpv0xqxpohEW8nkCtqIJ2RpVh/5f3jgIpvCxH
   l/flu1UbJ8g8dpngliFYWZcNiQmZxlMT2FWMakk4OiWLhwiOIo7j3Mnjx
   MyK2UNBbl1WCMezo8dfPUS4B1+yjDJD1kK/sgtHDABsod8zIJfnUCJDIt
   a8ibwdPeohH1fwiWym9r+g9NKozgdGXkAMODkQ6s9Xcr6awaA3sOfDCyF
   xGTjTpYcO8/hKUBztZWGxdkP+suzBFWnlM4qPFXqvP7nOaBssTsYqwas4
   A==;
X-CSE-ConnectionGUID: OIzD7uq5RZS8FNd3BDfl1w==
X-CSE-MsgGUID: YAdUlPUnQUKbyNcCsCHyXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="33040534"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="33040534"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 15:38:45 -0700
X-CSE-ConnectionGUID: tHc6yA2ATxyNXfpo9TfrTw==
X-CSE-MsgGUID: 7EAKI2ySToquUqOADwXmmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="59006416"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 12 Aug 2024 15:38:43 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sddgW-000CDz-1l;
	Mon, 12 Aug 2024 22:38:40 +0000
Date: Tue, 13 Aug 2024 06:38:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 808a033fe41be80da178cbe47a1b013eb6d048a6
Message-ID: <202408130625.kHisL31h-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 808a033fe41be80da178cbe47a1b013eb6d048a6  Merge branch 'thermal-core-testing' into bleeding-edge

elapsed time: 733m

configs tested: 161
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240812   gcc-13.2.0
arc                   randconfig-002-20240812   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                        mvebu_v7_defconfig   clang-15
arm                   randconfig-001-20240812   clang-15
arm                   randconfig-002-20240812   clang-20
arm                   randconfig-003-20240812   clang-20
arm                   randconfig-004-20240812   clang-20
arm                           tegra_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240812   gcc-14.1.0
arm64                 randconfig-002-20240812   clang-20
arm64                 randconfig-003-20240812   gcc-14.1.0
arm64                 randconfig-004-20240812   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240812   gcc-14.1.0
csky                  randconfig-002-20240812   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240812   clang-20
hexagon               randconfig-002-20240812   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240812   clang-18
i386         buildonly-randconfig-002-20240812   clang-18
i386         buildonly-randconfig-003-20240812   clang-18
i386         buildonly-randconfig-004-20240812   clang-18
i386         buildonly-randconfig-005-20240812   gcc-12
i386         buildonly-randconfig-006-20240812   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240812   gcc-12
i386                  randconfig-002-20240812   gcc-12
i386                  randconfig-003-20240812   gcc-12
i386                  randconfig-004-20240812   clang-18
i386                  randconfig-005-20240812   clang-18
i386                  randconfig-006-20240812   gcc-12
i386                  randconfig-011-20240812   gcc-12
i386                  randconfig-012-20240812   clang-18
i386                  randconfig-013-20240812   clang-18
i386                  randconfig-014-20240812   clang-18
i386                  randconfig-015-20240812   clang-18
i386                  randconfig-016-20240812   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240812   gcc-14.1.0
loongarch             randconfig-002-20240812   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                       m5208evb_defconfig   gcc-14.1.0
m68k                        mvme16x_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                      loongson3_defconfig   gcc-13.2.0
mips                          rb532_defconfig   clang-20
mips                        vocore2_defconfig   clang-15
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240812   gcc-14.1.0
nios2                 randconfig-002-20240812   gcc-14.1.0
openrisc                         alldefconfig   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240812   gcc-14.1.0
parisc                randconfig-002-20240812   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                 canyonlands_defconfig   clang-20
powerpc                        cell_defconfig   gcc-14.1.0
powerpc                    ge_imp3a_defconfig   gcc-14.1.0
powerpc                        icon_defconfig   gcc-14.1.0
powerpc                  iss476-smp_defconfig   gcc-14.1.0
powerpc                      pasemi_defconfig   clang-20
powerpc                       ppc64_defconfig   clang-20
powerpc               randconfig-001-20240812   gcc-14.1.0
powerpc               randconfig-002-20240812   gcc-14.1.0
powerpc               randconfig-003-20240812   gcc-14.1.0
powerpc                     tqm8560_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240812   clang-20
powerpc64             randconfig-002-20240812   clang-15
powerpc64             randconfig-003-20240812   clang-20
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240812   gcc-14.1.0
riscv                 randconfig-002-20240812   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240812   gcc-14.1.0
s390                  randconfig-002-20240812   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240812   gcc-14.1.0
sh                    randconfig-002-20240812   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240812   gcc-14.1.0
sparc64               randconfig-002-20240812   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240812   clang-20
um                    randconfig-002-20240812   gcc-12
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240812   clang-18
x86_64       buildonly-randconfig-002-20240812   clang-18
x86_64       buildonly-randconfig-003-20240812   gcc-12
x86_64       buildonly-randconfig-004-20240812   clang-18
x86_64       buildonly-randconfig-005-20240812   clang-18
x86_64       buildonly-randconfig-006-20240812   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240812   clang-18
x86_64                randconfig-002-20240812   clang-18
x86_64                randconfig-003-20240812   gcc-12
x86_64                randconfig-004-20240812   gcc-12
x86_64                randconfig-005-20240812   gcc-11
x86_64                randconfig-006-20240812   clang-18
x86_64                randconfig-011-20240812   clang-18
x86_64                randconfig-012-20240812   gcc-12
x86_64                randconfig-013-20240812   clang-18
x86_64                randconfig-014-20240812   clang-18
x86_64                randconfig-015-20240812   gcc-12
x86_64                randconfig-016-20240812   gcc-12
x86_64                randconfig-071-20240812   gcc-12
x86_64                randconfig-072-20240812   gcc-12
x86_64                randconfig-073-20240812   gcc-12
x86_64                randconfig-074-20240812   clang-18
x86_64                randconfig-075-20240812   gcc-12
x86_64                randconfig-076-20240812   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240812   gcc-14.1.0
xtensa                randconfig-002-20240812   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

