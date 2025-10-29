Return-Path: <linux-acpi+bounces-18325-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E315C1A29A
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 13:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63153189A137
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 12:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F14733A010;
	Wed, 29 Oct 2025 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5m+IZXK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB4E272816;
	Wed, 29 Oct 2025 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740371; cv=none; b=HfDSAPgm24UIkJX6v3BRifkhr/uvgF9JXB3V3kJP5xfRC2VtUDH/o7Gn+jvW0lMANgH6e1NAItRomgSwA2Tp7EamGHC0taimj43v7Ho0fV8yXlRu5PASsc4A43hCrmpdhK3l+RTI/qrxqSRhNT0GRVCgbsWJaeHZYT2U6lqCggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740371; c=relaxed/simple;
	bh=20JxKDMpCz6SOe1Bp+62xWTJm6sDUhy881hKtyj8pqg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KHIsgLTHmicMnIkDGdIjWX35lQQyJe/Ut0HVANbxO3JyjR5+gYEgps7cDDHwkStjKnpreX4QTZP3B5alZ2kIgUzp8ppr6WqP/9CinlkQ7IZGcNLeJGrktc4g4mHe+71hJXPA4bOL3ZG/SDm+oRWDconFGohZTtKtks89QN1cO3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5m+IZXK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761740370; x=1793276370;
  h=date:from:to:cc:subject:message-id;
  bh=20JxKDMpCz6SOe1Bp+62xWTJm6sDUhy881hKtyj8pqg=;
  b=j5m+IZXKp7ZWQaKM043yDAPl7KvwTKrledhLe4+x8Dr5XIOtlF/V2HNs
   LnxjxyWZq25eTbRYvlc56XeXhal0TfIFymLQn1Va+jrxRbDOSDx5IdcYI
   oATrg1V/qt09RTIjFJGeipOC4me8hjqSEnqmAC09SpYIbbN8PNVTakZsf
   ojYdC8Bk1Fa/aHnrqcM46DhIVkzJtq70ujbzFYDG2LxSrbKnJvccVE7nV
   VUKwyQrjIGAVndr91xGzNwdoF01NoJXN9C02Csq6LYiDkgq3ZPe57rPPH
   7WknHoq9NH8Q6HKBuPAB5b7SSTm278JZP7TYXK1ht+2SeS3wOd4DdX4KC
   w==;
X-CSE-ConnectionGUID: QbMQH+g1SE6OFcBY28HfVw==
X-CSE-MsgGUID: 7PgDB98FS5imv7IF0xFsMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="75307207"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="75307207"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 05:19:29 -0700
X-CSE-ConnectionGUID: p/iko70yQpOJFVN3N586lw==
X-CSE-MsgGUID: q8hG1lXjTg6oEpRcu/ENkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="216509630"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 29 Oct 2025 05:19:27 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vE59A-000Kaf-2q;
	Wed, 29 Oct 2025 12:19:24 +0000
Date: Wed, 29 Oct 2025 20:18:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 d6e9920588cf094d2a89409fc444878781fe4e9c
Message-ID: <202510292020.Dc1Lueh9-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d6e9920588cf094d2a89409fc444878781fe4e9c  Merge branches 'acpi-battery', 'acpi-misc', 'acpi-tad' and 'acpi-fan-next' into linux-next

elapsed time: 1455m

configs tested: 143
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251028    gcc-8.5.0
arc                   randconfig-002-20251028    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                     am200epdkit_defconfig    gcc-15.1.0
arm                        clps711x_defconfig    clang-22
arm                   randconfig-001-20251028    clang-22
arm                   randconfig-002-20251028    clang-22
arm                   randconfig-003-20251028    clang-22
arm                   randconfig-004-20251028    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251028    clang-22
arm64                 randconfig-002-20251028    clang-22
arm64                 randconfig-003-20251028    gcc-11.5.0
arm64                 randconfig-004-20251028    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251028    gcc-15.1.0
csky                  randconfig-002-20251028    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251028    clang-22
hexagon               randconfig-002-20251028    clang-17
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251028    gcc-14
i386        buildonly-randconfig-002-20251028    gcc-14
i386        buildonly-randconfig-003-20251028    gcc-14
i386        buildonly-randconfig-004-20251028    gcc-14
i386        buildonly-randconfig-005-20251028    gcc-14
i386        buildonly-randconfig-006-20251028    gcc-14
i386                  randconfig-001-20251029    gcc-14
i386                  randconfig-002-20251029    gcc-14
i386                  randconfig-003-20251029    clang-20
i386                  randconfig-004-20251029    gcc-14
i386                  randconfig-005-20251029    clang-20
i386                  randconfig-006-20251029    gcc-14
i386                  randconfig-007-20251029    clang-20
i386                  randconfig-011-20251029    gcc-14
i386                  randconfig-012-20251029    clang-20
i386                  randconfig-013-20251029    gcc-14
i386                  randconfig-014-20251029    gcc-14
i386                  randconfig-015-20251029    gcc-14
i386                  randconfig-016-20251029    gcc-14
i386                  randconfig-017-20251029    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251028    gcc-12.5.0
loongarch             randconfig-002-20251028    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                          hp300_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251028    gcc-8.5.0
nios2                 randconfig-002-20251028    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251028    gcc-9.5.0
parisc                randconfig-002-20251028    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      katmai_defconfig    clang-22
powerpc                     mpc83xx_defconfig    clang-22
powerpc               randconfig-001-20251028    gcc-15.1.0
powerpc               randconfig-002-20251028    gcc-11.5.0
powerpc64             randconfig-001-20251028    clang-22
powerpc64             randconfig-002-20251028    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251029    clang-20
riscv                 randconfig-002-20251029    clang-19
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251029    gcc-11.5.0
s390                  randconfig-002-20251029    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          landisk_defconfig    gcc-15.1.0
sh                    randconfig-001-20251029    gcc-11.5.0
sh                    randconfig-002-20251029    gcc-15.1.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251028    gcc-8.5.0
sparc                 randconfig-002-20251028    gcc-12.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251028    clang-22
sparc64               randconfig-002-20251028    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251028    gcc-14
um                    randconfig-002-20251028    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251029    gcc-14
x86_64      buildonly-randconfig-002-20251029    clang-20
x86_64      buildonly-randconfig-003-20251029    clang-20
x86_64      buildonly-randconfig-004-20251029    clang-20
x86_64      buildonly-randconfig-005-20251029    clang-20
x86_64      buildonly-randconfig-006-20251029    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251029    gcc-14
x86_64                randconfig-002-20251029    gcc-14
x86_64                randconfig-003-20251029    clang-20
x86_64                randconfig-004-20251029    gcc-14
x86_64                randconfig-005-20251029    gcc-12
x86_64                randconfig-006-20251029    gcc-14
x86_64                randconfig-011-20251029    clang-20
x86_64                randconfig-012-20251029    clang-20
x86_64                randconfig-013-20251029    gcc-14
x86_64                randconfig-014-20251029    clang-20
x86_64                randconfig-015-20251029    gcc-13
x86_64                randconfig-016-20251029    gcc-13
x86_64                randconfig-071-20251029    clang-20
x86_64                randconfig-072-20251029    clang-20
x86_64                randconfig-073-20251029    gcc-14
x86_64                randconfig-074-20251029    gcc-14
x86_64                randconfig-075-20251029    gcc-14
x86_64                randconfig-076-20251029    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251028    gcc-15.1.0
xtensa                randconfig-002-20251028    gcc-13.4.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

