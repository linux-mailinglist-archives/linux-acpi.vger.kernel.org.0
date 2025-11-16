Return-Path: <linux-acpi+bounces-18919-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8F4C61071
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Nov 2025 06:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28ED5349894
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Nov 2025 05:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ED2221723;
	Sun, 16 Nov 2025 05:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMTWGyc0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A3B21FF2E;
	Sun, 16 Nov 2025 05:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763270651; cv=none; b=tankdCYe45nPorWmFMcEicjjRLiqpjnf8pTlypRHYpagGM5ku/e2kZwtKRfzW0kdZ/5P1pEDJ14xJrXJyD64g4pbD5nRPVvubSedfN+x2oWtrsIov5xMVd5hSU8NpSm5oD0dzU9ik2/pXolqoFOVaF71BvJTKA2S5Eap+jEu+KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763270651; c=relaxed/simple;
	bh=FIVPV/c9Oy2IP8qQvPsPwf+Bl09ITX+BmQ5xE1dfnNQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=N2euORClxMMrAB9u4vyb7frhhFEgB7jovEn/TIaMdLuY45C30rVB7aVl8Z2pJtlOjNVhzVihyotn1J1/JkQ3y9TSogJoPb9b87bT+xU2FNBI7mYraPgkbR38xsTOyxq4FgkPbAaPnGU89QfEyxRlQ6RY2XQqDrVWvvatD6OmHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMTWGyc0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763270650; x=1794806650;
  h=date:from:to:cc:subject:message-id;
  bh=FIVPV/c9Oy2IP8qQvPsPwf+Bl09ITX+BmQ5xE1dfnNQ=;
  b=NMTWGyc0BoQEAzuAJE7T6STu3Ldeowlw4YeEOwDTZ3D+laXC+pRwjd0w
   ne5bTQBzG+rhT3vTV7XSrfdNd2iPmJ41XCzAjLZ4N6rVlrtMKwfNoXYjb
   OL20mH2hfGp3JMT2ao3RZ3Kuay7T8Jk2idUxSOgNFa0g1WSxjQxbzRd0p
   JxT7BpBOQw0DawiuL6ybDPvH0Wfd09szFhwTncLo6mXRfFa/52EVFjv9o
   OQklZtuoJbRBuee7Tf41GHKo1iycZkb8l49qPLbCUvR2lsEnFjB2R1+Pk
   CjpS4QWmYYa7Vc5zZJpBw5Y1y2sqMtnwA+RRO4HCMX0PLFCuXkGiLg8/r
   Q==;
X-CSE-ConnectionGUID: 9IB/jQxOTJGhCGcalkZkPQ==
X-CSE-MsgGUID: tcP0LMV9Rp66WcHbnNFBUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11614"; a="75909718"
X-IronPort-AV: E=Sophos;i="6.19,308,1754982000"; 
   d="scan'208";a="75909718"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 21:24:09 -0800
X-CSE-ConnectionGUID: L7f7MxgkQnWXTxNOMTc4EA==
X-CSE-MsgGUID: VJdBDcpMRzSPP35YGy25uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,308,1754982000"; 
   d="scan'208";a="190405765"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 15 Nov 2025 21:24:08 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKVF8-0008WR-0Q;
	Sun, 16 Nov 2025 05:24:06 +0000
Date: Sun, 16 Nov 2025 13:23:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 d6723a6d18bcfd5835c6dc634ea75104992c19bc
Message-ID: <202511161321.QMEmZydy-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d6723a6d18bcfd5835c6dc634ea75104992c19bc  Merge branch 'thermal-intel' into bleeding-edge

elapsed time: 2174m

configs tested: 100
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                              alldefconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251115    gcc-13.4.0
arc                   randconfig-002-20251115    gcc-11.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251115    clang-22
arm                   randconfig-002-20251115    gcc-8.5.0
arm                   randconfig-003-20251115    gcc-10.5.0
arm                   randconfig-004-20251115    clang-22
arm                           sunxi_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251115    gcc-8.5.0
arm64                 randconfig-002-20251115    clang-18
arm64                 randconfig-003-20251115    gcc-13.4.0
arm64                 randconfig-004-20251115    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251115    gcc-15.1.0
csky                  randconfig-002-20251115    gcc-9.5.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251116    clang-22
hexagon               randconfig-002-20251116    clang-17
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251116    clang-20
i386        buildonly-randconfig-002-20251116    clang-20
i386        buildonly-randconfig-003-20251116    clang-20
i386        buildonly-randconfig-004-20251116    gcc-14
i386        buildonly-randconfig-005-20251116    clang-20
i386        buildonly-randconfig-006-20251116    clang-20
i386                  randconfig-001-20251116    gcc-14
i386                  randconfig-002-20251116    clang-20
i386                  randconfig-003-20251116    gcc-14
i386                  randconfig-004-20251116    gcc-14
i386                  randconfig-011-20251116    clang-20
i386                  randconfig-012-20251116    gcc-14
i386                  randconfig-013-20251116    gcc-14
i386                  randconfig-014-20251116    clang-20
i386                  randconfig-015-20251116    gcc-12
i386                  randconfig-016-20251116    clang-20
i386                  randconfig-017-20251116    gcc-14
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251116    gcc-15.1.0
loongarch             randconfig-002-20251116    clang-22
m68k                              allnoconfig    gcc-15.1.0
m68k                            mac_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip28_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20251116    gcc-11.5.0
nios2                 randconfig-002-20251116    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251115    gcc-8.5.0
parisc                randconfig-002-20251115    gcc-8.5.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      bamboo_defconfig    clang-22
powerpc               randconfig-001-20251115    clang-19
powerpc               randconfig-002-20251115    gcc-8.5.0
powerpc64             randconfig-001-20251115    gcc-11.5.0
powerpc64             randconfig-002-20251115    gcc-14.3.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                    nommu_k210_defconfig    clang-22
riscv                 randconfig-001-20251115    clang-22
riscv                 randconfig-002-20251115    gcc-8.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251115    clang-17
s390                  randconfig-002-20251115    gcc-8.5.0
sh                                allnoconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251115    gcc-12.5.0
sh                    randconfig-002-20251115    gcc-15.1.0
sh                          rsk7264_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251116    clang-20
x86_64      buildonly-randconfig-002-20251116    clang-20
x86_64      buildonly-randconfig-003-20251116    clang-20
x86_64      buildonly-randconfig-004-20251116    gcc-13
x86_64      buildonly-randconfig-005-20251116    clang-20
x86_64      buildonly-randconfig-006-20251116    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-071-20251116    clang-20
x86_64                randconfig-072-20251116    clang-20
x86_64                randconfig-073-20251116    clang-20
x86_64                randconfig-074-20251116    clang-20
x86_64                randconfig-075-20251116    clang-20
x86_64                randconfig-076-20251116    gcc-14
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

