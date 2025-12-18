Return-Path: <linux-acpi+bounces-19676-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B60CCCEBA
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 18:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80CBF300F31C
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 17:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A831DF97C;
	Thu, 18 Dec 2025 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="geE3Vog6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEFF13B284;
	Thu, 18 Dec 2025 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766077700; cv=none; b=MW4DIzA6af/iisK1kvAi8PbuFRaGZqVCGRFbYJZohPtDirTBXJPi5KHcP0+KsITQmuyAN+WD8fQZOGkAJaHmgtHU16kArqYXsLKo+3+Ao/uL/mzTEDS/WQWMYdYCYt8eWwKAW7AZd6nDj/gif3jKDck2mKIqbd6/tT99i7XvKAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766077700; c=relaxed/simple;
	bh=Xw/KK85oH6CkUjUfMU/0ftPtZu/EzySv6Jezu3nJ7R0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jbNrz+5ck4lWu5jOYgIled76ZCPBPaQtFT2PlzVtjxu8AtviFUznlK6+Lz0YcpGkrd5e2vv6VkXtEnrssbu09d1lCp9+vGWVDBMkSBaIu6Oe4g1fuo+KyU1OYJs/NpLfHr7vwP1i3BqwFdI3rsdJL8LEloqWHWX33Owf1rfbgII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=geE3Vog6; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766077700; x=1797613700;
  h=date:from:to:cc:subject:message-id;
  bh=Xw/KK85oH6CkUjUfMU/0ftPtZu/EzySv6Jezu3nJ7R0=;
  b=geE3Vog6OSrc2oProc7pRNNSVSGpi4a3Ykv629oGrs1KmsWzZOR/X5bN
   4hHumu5sdoHRBygpDaBz3SZUpX/bMHqScoFythVe6TTZddgJV64NT2YuY
   7FuYj9QKTPbcmgPnYmDMiUaLpR387bpv7f0AQY1s4x5R87YSs6oSdzLwQ
   MTdJ3Lu6lN3BVAbAR0+oh26HBRYXy8oe2ZbLjPUUwv3oL8vw2qwCqQeA8
   7aHyJqU0XJgjtdyRpUlDNDF8AG3EOdeH9wFt65CqwWNPFCWVlZMqFTadB
   4uVLsXoAWZPOXNS2oX7WNKFsQVFOQscvA5FQuRton7Li/sprRgU/PvMB7
   g==;
X-CSE-ConnectionGUID: gEBtt9giQkuMKB/B8Z+tBw==
X-CSE-MsgGUID: d2zW5TE/RUmmUMsWSdvgVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="67789037"
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="67789037"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 09:08:19 -0800
X-CSE-ConnectionGUID: GjA+2+JvSZy4ruE0Xei+Hg==
X-CSE-MsgGUID: xCHvuUk1Rv2DiWC/3rEqpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="202820194"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 18 Dec 2025 09:08:18 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWHU6-000000002Lj-3FOL;
	Thu, 18 Dec 2025 17:08:14 +0000
Date: Fri, 19 Dec 2025 01:07:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 55ff56d49fa52f3b3d24cbf016b4ba4a95713a55
Message-ID: <202512190101.MD5dMgMk-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 55ff56d49fa52f3b3d24cbf016b4ba4a95713a55  Merge branch 'linux-next' into bleeding-edge

elapsed time: 1463m

configs tested: 177
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251218    clang-22
arc                   randconfig-002-20251218    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.1.0
arm                       imx_v6_v7_defconfig    gcc-15.1.0
arm                   randconfig-001-20251218    clang-22
arm                   randconfig-002-20251218    clang-22
arm                   randconfig-003-20251218    clang-22
arm                   randconfig-004-20251218    clang-22
arm                        spear3xx_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251218    gcc-14.3.0
arm64                 randconfig-002-20251218    gcc-14.3.0
arm64                 randconfig-003-20251218    gcc-14.3.0
arm64                 randconfig-004-20251218    gcc-14.3.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251218    gcc-14.3.0
csky                  randconfig-002-20251218    gcc-14.3.0
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251218    gcc-11.5.0
hexagon               randconfig-002-20251218    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251218    gcc-14
i386        buildonly-randconfig-002-20251218    gcc-14
i386        buildonly-randconfig-003-20251218    gcc-14
i386        buildonly-randconfig-004-20251218    gcc-14
i386        buildonly-randconfig-005-20251218    gcc-14
i386        buildonly-randconfig-006-20251218    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251218    gcc-12
i386                  randconfig-002-20251218    gcc-12
i386                  randconfig-003-20251218    gcc-12
i386                  randconfig-004-20251218    gcc-12
i386                  randconfig-005-20251218    gcc-12
i386                  randconfig-006-20251218    gcc-12
i386                  randconfig-007-20251218    gcc-12
i386                  randconfig-011-20251218    clang-20
i386                  randconfig-012-20251218    clang-20
i386                  randconfig-013-20251218    clang-20
i386                  randconfig-014-20251218    clang-20
i386                  randconfig-015-20251218    clang-20
i386                  randconfig-016-20251218    clang-20
i386                  randconfig-017-20251218    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251218    gcc-11.5.0
loongarch             randconfig-002-20251218    gcc-11.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                          ath25_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251218    gcc-11.5.0
nios2                 randconfig-002-20251218    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
openrisc                  or1klitex_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251218    gcc-8.5.0
parisc                randconfig-002-20251218    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc               randconfig-001-20251218    gcc-8.5.0
powerpc               randconfig-002-20251218    gcc-8.5.0
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251218    gcc-8.5.0
powerpc64             randconfig-002-20251218    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                    nommu_virt_defconfig    gcc-15.1.0
riscv                 randconfig-001-20251218    gcc-8.5.0
riscv                 randconfig-002-20251218    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251218    gcc-8.5.0
s390                  randconfig-002-20251218    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251218    gcc-8.5.0
sh                    randconfig-002-20251218    gcc-8.5.0
sh                          urquell_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251218    gcc-15.1.0
sparc                 randconfig-002-20251218    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251218    gcc-15.1.0
sparc64               randconfig-002-20251218    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251218    gcc-15.1.0
um                    randconfig-002-20251218    gcc-15.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251218    gcc-14
x86_64      buildonly-randconfig-002-20251218    gcc-14
x86_64      buildonly-randconfig-003-20251218    gcc-14
x86_64      buildonly-randconfig-004-20251218    gcc-14
x86_64      buildonly-randconfig-005-20251218    gcc-14
x86_64      buildonly-randconfig-006-20251218    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251218    clang-20
x86_64                randconfig-002-20251218    clang-20
x86_64                randconfig-003-20251218    clang-20
x86_64                randconfig-004-20251218    clang-20
x86_64                randconfig-005-20251218    clang-20
x86_64                randconfig-006-20251218    clang-20
x86_64                randconfig-011-20251218    gcc-14
x86_64                randconfig-012-20251218    gcc-14
x86_64                randconfig-013-20251218    gcc-14
x86_64                randconfig-014-20251218    gcc-14
x86_64                randconfig-015-20251218    gcc-14
x86_64                randconfig-016-20251218    gcc-14
x86_64                randconfig-071-20251218    gcc-12
x86_64                randconfig-072-20251218    gcc-12
x86_64                randconfig-073-20251218    gcc-12
x86_64                randconfig-074-20251218    gcc-12
x86_64                randconfig-075-20251218    gcc-12
x86_64                randconfig-076-20251218    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251218    gcc-15.1.0
xtensa                randconfig-002-20251218    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

