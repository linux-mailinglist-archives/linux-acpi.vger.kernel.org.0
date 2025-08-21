Return-Path: <linux-acpi+bounces-15887-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B36B2FCB4
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Aug 2025 16:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC151D21963
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Aug 2025 14:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4BA1F03DE;
	Thu, 21 Aug 2025 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBGB76Xu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A722EC549;
	Thu, 21 Aug 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786067; cv=none; b=s56dhngfBB5WaipAaFTNHyCv7YTIuze++I7guKnWtet6BADMzq3cYcfyXeXijGEykep6UPmUfvJ5ZAoFqYDiHTGfUL/qAjfClImMdy1Kw0YoQylOriIbBnDdFg3LNZXooygukZAGFVaqLvlUxwaWC6H7/CTlCXrR2vJW6UGcdBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786067; c=relaxed/simple;
	bh=KXLxfUPwdsrjpEzh7KX7yHIKEbuhbQtE/6YGyUsb5I0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=P2YvqR3GCAWg1LGs5apE2B7Yz/ehSuiykuVK/6t5/HoWgjatoSJxVLsUxgkHxLgQVOh39b7sR89/JVBzq1x+eH+k6+4T662MKPQOxaj6j1Cj55wfnOfR/x6KQ1XSx6exLecA1b+baXHp1v2lm0k52MRLM7qyMFuqF0EfzWdF3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBGB76Xu; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755786066; x=1787322066;
  h=date:from:to:cc:subject:message-id;
  bh=KXLxfUPwdsrjpEzh7KX7yHIKEbuhbQtE/6YGyUsb5I0=;
  b=BBGB76Xuv4+piRKDuYnvjJoPs6W3+wPGe2IYJ5lB2DulU/ELZOeZALqA
   79ZdhurwWuaWG7nsMSzZv8da3aPAG4XpLh67eus5HyDijFmiRFEhRL8yM
   AKpdHeX4IGb1UAnKnmgl9w1YASDkN0NhQ/YHTdDT5ZUu9Ee36orIAakA8
   cGN9pPDZR4oViNkPh9nVhh/fZAVTp6d56jCFb+8pW4FcKUYa9/L5vYF5I
   FdjmHXVOen7cKb0+S2MSengX8g776cCp+VFhq3iAMz7+x9ORGTKz0iH9x
   QDePuF0IGKCCP89Mq03VVOrc3RXllhzw27U7Itwyo/QY/qVGMZbc25HCu
   w==;
X-CSE-ConnectionGUID: MZ2cj/ExRbOYEWowEHKl7g==
X-CSE-MsgGUID: eqjW77y9TPy+zorXC3VzaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69177295"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="69177295"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 07:21:06 -0700
X-CSE-ConnectionGUID: 9PVcUH/TSSivjAFfBv4fnA==
X-CSE-MsgGUID: xpT1QazBRu+b3gay5XT0IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168663686"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 21 Aug 2025 07:21:05 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1up695-000KLp-2g;
	Thu, 21 Aug 2025 14:20:19 +0000
Date: Thu, 21 Aug 2025 22:13:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 f0f47deb2a09709a26ad0e6ab40e9b5cfdcbe679
Message-ID: <202508212221.L2rG09fu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: f0f47deb2a09709a26ad0e6ab40e9b5cfdcbe679  Merge branch 'thermal-intel' into linux-next

elapsed time: 1451m

configs tested: 136
configs skipped: 3

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
arc                   randconfig-001-20250820    gcc-8.5.0
arc                   randconfig-001-20250821    gcc-9.5.0
arc                   randconfig-002-20250820    gcc-11.5.0
arc                   randconfig-002-20250821    gcc-13.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250820    gcc-8.5.0
arm                   randconfig-001-20250821    gcc-13.4.0
arm                   randconfig-002-20250820    gcc-15.1.0
arm                   randconfig-002-20250821    clang-22
arm                   randconfig-003-20250820    gcc-13.4.0
arm                   randconfig-003-20250821    clang-22
arm                   randconfig-004-20250820    clang-22
arm                   randconfig-004-20250821    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250820    gcc-14.3.0
arm64                 randconfig-001-20250821    clang-22
arm64                 randconfig-002-20250820    gcc-14.3.0
arm64                 randconfig-002-20250821    clang-22
arm64                 randconfig-003-20250820    gcc-8.5.0
arm64                 randconfig-003-20250821    gcc-11.5.0
arm64                 randconfig-004-20250820    gcc-14.3.0
arm64                 randconfig-004-20250821    gcc-13.4.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250820    gcc-15.1.0
csky                  randconfig-002-20250820    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250820    clang-22
hexagon               randconfig-002-20250820    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250820    clang-20
i386        buildonly-randconfig-001-20250821    gcc-12
i386        buildonly-randconfig-002-20250820    gcc-12
i386        buildonly-randconfig-002-20250821    gcc-12
i386        buildonly-randconfig-003-20250820    gcc-12
i386        buildonly-randconfig-003-20250821    clang-20
i386        buildonly-randconfig-004-20250820    clang-20
i386        buildonly-randconfig-004-20250821    gcc-12
i386        buildonly-randconfig-005-20250820    gcc-12
i386        buildonly-randconfig-005-20250821    gcc-12
i386        buildonly-randconfig-006-20250820    gcc-11
i386        buildonly-randconfig-006-20250821    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250820    clang-18
loongarch             randconfig-002-20250820    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250820    gcc-11.5.0
nios2                 randconfig-002-20250820    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250820    gcc-8.5.0
parisc                randconfig-002-20250820    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250820    gcc-12.5.0
powerpc               randconfig-002-20250820    gcc-8.5.0
powerpc               randconfig-003-20250820    gcc-13.4.0
powerpc64             randconfig-001-20250820    clang-22
powerpc64             randconfig-002-20250820    clang-22
powerpc64             randconfig-003-20250820    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250820    clang-20
riscv                 randconfig-002-20250820    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250820    clang-18
s390                  randconfig-002-20250820    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250820    gcc-15.1.0
sh                    randconfig-002-20250820    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250820    gcc-8.5.0
sparc                 randconfig-002-20250820    gcc-12.5.0
sparc64               randconfig-001-20250820    clang-22
sparc64               randconfig-002-20250820    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250820    gcc-12
um                    randconfig-002-20250820    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250820    clang-20
x86_64      buildonly-randconfig-001-20250821    clang-20
x86_64      buildonly-randconfig-002-20250820    gcc-11
x86_64      buildonly-randconfig-002-20250821    clang-20
x86_64      buildonly-randconfig-003-20250820    clang-20
x86_64      buildonly-randconfig-003-20250821    clang-20
x86_64      buildonly-randconfig-004-20250820    gcc-12
x86_64      buildonly-randconfig-004-20250821    gcc-12
x86_64      buildonly-randconfig-005-20250820    clang-20
x86_64      buildonly-randconfig-005-20250821    clang-20
x86_64      buildonly-randconfig-006-20250820    gcc-12
x86_64      buildonly-randconfig-006-20250821    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250820    gcc-8.5.0
xtensa                randconfig-002-20250820    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

