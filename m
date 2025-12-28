Return-Path: <linux-acpi+bounces-19870-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65956CE0392
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Dec 2025 01:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DE733013EB8
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Dec 2025 00:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8055B6F06A;
	Sun, 28 Dec 2025 00:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hcQSsJin"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CF32AE8D;
	Sun, 28 Dec 2025 00:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766882250; cv=none; b=MxNs9KCk3awZr+kWlOLTxFhBEYbavVgqT4jbUb1J8gXPyO1AQf0q5Y3ixa0HYoyM6gjvTm2gcLyoGWhd3ao8xPJ4ipCCK6sKVF6of09gZ+QQxlTd4xmozfycU7yoAysrV5SXDCT4JeJ3Bvs6B2rNluZruZw2FHo7PvOzeaI+aCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766882250; c=relaxed/simple;
	bh=dpcUCBTNS2IXrBvrqVpczOVArkWvjWKogC3ApMapwHg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ogf6U6wiMG//BqHXlpWOT8pi/0S77CwChlfFswr1HEkSyPJDT1rw+AEzzNMZRowwcZZgd1DNGPXhHMT5m2dqmvfw3PWpTNtht/xvUiXfzbTp1BYK23PYNxHkBxd6CZUibSbokkn2lvBaKVdOfav7jcSeb6Oq87CZ1LthYWUH5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hcQSsJin; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766882248; x=1798418248;
  h=date:from:to:cc:subject:message-id;
  bh=dpcUCBTNS2IXrBvrqVpczOVArkWvjWKogC3ApMapwHg=;
  b=hcQSsJinPUkSi/Kv/+9qkUZKCSoBccZ3eV8FICUOURmFKm11up0HqoPf
   4lyAtUCfnNxcVRLb0WWS7IPC9HW90hK4/l4S5R0WMVHFmaZdJ8fZ7oPti
   B6JP+16XiO49Iq/vjVRMxcd5iD4i4W5LwkzXTD58fjrVIBGptlrcnU6XM
   fjUapflYGTVmqOIUj/bP08qwPUTXWs+cjBpgzsWZys2B1fSOrCha5owZu
   CQ/lXIo27e02BHj/BWSS5jJiiYbHi+pSnK0jrNF/iToMsxfp5Z4dgOWxY
   rYLm+oL5KKhZGe58yLmrYAtU/p9ADAk6E4XF2aajCBKCrZncMw+d2sL6L
   g==;
X-CSE-ConnectionGUID: vBBFbnJ3RpqAobWapaWcgw==
X-CSE-MsgGUID: g+8ZEGcjTh+diCxoD62BVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11654"; a="68444278"
X-IronPort-AV: E=Sophos;i="6.21,182,1763452800"; 
   d="scan'208";a="68444278"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 16:37:27 -0800
X-CSE-ConnectionGUID: zZgcbZf0SJ6wwpOqEw0NwQ==
X-CSE-MsgGUID: lr+0OaQsQsW619VvI/okAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,182,1763452800"; 
   d="scan'208";a="200261579"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 27 Dec 2025 16:37:26 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vZemh-0000000069R-1Q6q;
	Sun, 28 Dec 2025 00:37:23 +0000
Date: Sun, 28 Dec 2025 08:37:14 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH UNVERIFIED
 WARNING 512f2aac5b1818a03d01a5728942af9281e86af7
Message-ID: <202512280808.FI7IuL5p-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 512f2aac5b1818a03d01a5728942af9281e86af7  Merge branch 'pm-sleep-fixes' into bleeding-edge

Unverified Warning (likely false positive, kindly check if interested):

    drivers/acpi/bus.c:297 acpi_run_osc() warn: sizeof(NUMBER)?
    drivers/acpi/bus.c:335 acpi_osc_handshake() warn: sizeof(NUMBER)?

Warning ids grouped by kconfigs:

recent_errors
|-- i386-randconfig-141-20251227
|   |-- drivers-acpi-bus.c-acpi_osc_handshake()-warn:sizeof(NUMBER)
|   `-- drivers-acpi-bus.c-acpi_run_osc()-warn:sizeof(NUMBER)
`-- x86_64-randconfig-161-20251227
    |-- drivers-acpi-bus.c-acpi_osc_handshake()-warn:sizeof(NUMBER)
    `-- drivers-acpi-bus.c-acpi_run_osc()-warn:sizeof(NUMBER)

elapsed time: 794m

configs tested: 270
configs skipped: 3

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
arc                   randconfig-001-20251227    gcc-11.5.0
arc                   randconfig-001-20251228    gcc-8.5.0
arc                   randconfig-002-20251227    gcc-9.5.0
arc                   randconfig-002-20251228    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                        multi_v5_defconfig    gcc-15.1.0
arm                          pxa168_defconfig    gcc-15.1.0
arm                   randconfig-001-20251227    gcc-8.5.0
arm                   randconfig-001-20251228    gcc-8.5.0
arm                   randconfig-002-20251227    clang-22
arm                   randconfig-002-20251228    gcc-8.5.0
arm                   randconfig-003-20251227    clang-22
arm                   randconfig-003-20251228    gcc-8.5.0
arm                   randconfig-004-20251227    clang-22
arm                   randconfig-004-20251228    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251227    clang-19
arm64                 randconfig-001-20251228    gcc-14.3.0
arm64                 randconfig-002-20251227    gcc-15.1.0
arm64                 randconfig-002-20251228    gcc-14.3.0
arm64                 randconfig-003-20251227    clang-20
arm64                 randconfig-003-20251228    gcc-14.3.0
arm64                 randconfig-004-20251227    gcc-8.5.0
arm64                 randconfig-004-20251228    gcc-14.3.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251227    gcc-15.1.0
csky                  randconfig-001-20251228    gcc-14.3.0
csky                  randconfig-002-20251227    gcc-15.1.0
csky                  randconfig-002-20251228    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251227    clang-22
hexagon               randconfig-002-20251227    clang-17
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251227    clang-20
i386        buildonly-randconfig-002-20251227    clang-20
i386        buildonly-randconfig-003-20251227    clang-20
i386        buildonly-randconfig-004-20251227    clang-20
i386        buildonly-randconfig-005-20251227    clang-20
i386        buildonly-randconfig-006-20251227    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251227    clang-20
i386                  randconfig-002-20251227    clang-20
i386                  randconfig-003-20251227    clang-20
i386                  randconfig-004-20251227    gcc-13
i386                  randconfig-005-20251227    gcc-14
i386                  randconfig-006-20251227    gcc-14
i386                  randconfig-007-20251227    clang-20
i386                  randconfig-011-20251227    gcc-14
i386                  randconfig-011-20251228    clang-20
i386                  randconfig-012-20251227    clang-20
i386                  randconfig-012-20251228    clang-20
i386                  randconfig-013-20251227    gcc-14
i386                  randconfig-013-20251228    clang-20
i386                  randconfig-014-20251227    gcc-14
i386                  randconfig-014-20251228    clang-20
i386                  randconfig-015-20251227    gcc-12
i386                  randconfig-015-20251228    clang-20
i386                  randconfig-016-20251227    clang-20
i386                  randconfig-016-20251228    clang-20
i386                  randconfig-017-20251227    gcc-14
i386                  randconfig-017-20251228    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251227    clang-18
loongarch             randconfig-002-20251227    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5208evb_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                        bcm47xx_defconfig    clang-18
mips                     loongson2k_defconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-11.5.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251227    gcc-11.5.0
nios2                 randconfig-002-20251227    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251227    gcc-8.5.0
parisc                randconfig-001-20251228    clang-22
parisc                randconfig-002-20251227    gcc-8.5.0
parisc                randconfig-002-20251228    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      pcm030_defconfig    gcc-15.1.0
powerpc                      pmac32_defconfig    clang-22
powerpc               randconfig-001-20251227    gcc-8.5.0
powerpc               randconfig-001-20251228    clang-22
powerpc               randconfig-002-20251227    clang-22
powerpc               randconfig-002-20251228    clang-22
powerpc                    socrates_defconfig    gcc-15.1.0
powerpc                     tqm8555_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251227    clang-22
powerpc64             randconfig-001-20251228    clang-22
powerpc64             randconfig-002-20251227    gcc-8.5.0
powerpc64             randconfig-002-20251228    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251228    clang-22
riscv                 randconfig-002-20251228    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251228    clang-22
s390                  randconfig-001-20251228    gcc-15.1.0
s390                  randconfig-002-20251228    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                          kfr2r09_defconfig    gcc-15.1.0
sh                          r7780mp_defconfig    gcc-15.1.0
sh                    randconfig-001-20251228    clang-22
sh                    randconfig-001-20251228    gcc-13.4.0
sh                    randconfig-002-20251228    clang-22
sh                    randconfig-002-20251228    gcc-15.1.0
sh                      rts7751r2d1_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251227    gcc-14.3.0
sparc                 randconfig-001-20251228    clang-22
sparc                 randconfig-002-20251227    gcc-15.1.0
sparc                 randconfig-002-20251228    clang-22
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251227    gcc-8.5.0
sparc64               randconfig-001-20251228    clang-22
sparc64               randconfig-002-20251227    clang-20
sparc64               randconfig-002-20251228    clang-22
um                               alldefconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251227    clang-22
um                    randconfig-001-20251228    clang-22
um                    randconfig-002-20251227    clang-19
um                    randconfig-002-20251228    clang-22
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251227    clang-20
x86_64      buildonly-randconfig-001-20251228    gcc-14
x86_64      buildonly-randconfig-002-20251227    clang-20
x86_64      buildonly-randconfig-002-20251228    gcc-14
x86_64      buildonly-randconfig-003-20251227    gcc-14
x86_64      buildonly-randconfig-003-20251228    gcc-14
x86_64      buildonly-randconfig-004-20251227    clang-20
x86_64      buildonly-randconfig-004-20251228    gcc-14
x86_64      buildonly-randconfig-005-20251227    clang-20
x86_64      buildonly-randconfig-005-20251228    gcc-14
x86_64      buildonly-randconfig-006-20251227    gcc-14
x86_64      buildonly-randconfig-006-20251228    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251227    gcc-14
x86_64                randconfig-001-20251228    gcc-14
x86_64                randconfig-002-20251227    gcc-12
x86_64                randconfig-002-20251228    gcc-14
x86_64                randconfig-003-20251227    gcc-14
x86_64                randconfig-003-20251228    gcc-14
x86_64                randconfig-004-20251227    clang-20
x86_64                randconfig-004-20251228    gcc-14
x86_64                randconfig-005-20251227    gcc-14
x86_64                randconfig-005-20251228    gcc-14
x86_64                randconfig-006-20251227    clang-20
x86_64                randconfig-006-20251228    gcc-14
x86_64                randconfig-011-20251227    gcc-14
x86_64                randconfig-011-20251228    gcc-14
x86_64                randconfig-012-20251227    clang-20
x86_64                randconfig-012-20251228    gcc-14
x86_64                randconfig-013-20251227    clang-20
x86_64                randconfig-013-20251228    gcc-14
x86_64                randconfig-014-20251227    gcc-14
x86_64                randconfig-014-20251228    gcc-14
x86_64                randconfig-015-20251227    gcc-13
x86_64                randconfig-015-20251228    gcc-14
x86_64                randconfig-016-20251227    gcc-14
x86_64                randconfig-016-20251228    gcc-14
x86_64                randconfig-071-20251227    clang-20
x86_64                randconfig-071-20251228    gcc-14
x86_64                randconfig-072-20251227    clang-20
x86_64                randconfig-072-20251228    gcc-14
x86_64                randconfig-073-20251227    clang-20
x86_64                randconfig-073-20251228    gcc-14
x86_64                randconfig-074-20251227    clang-20
x86_64                randconfig-074-20251228    gcc-14
x86_64                randconfig-075-20251227    clang-20
x86_64                randconfig-075-20251228    gcc-14
x86_64                randconfig-076-20251227    clang-20
x86_64                randconfig-076-20251228    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                  audio_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251227    gcc-9.5.0
xtensa                randconfig-001-20251228    clang-22
xtensa                randconfig-002-20251227    gcc-12.5.0
xtensa                randconfig-002-20251228    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

