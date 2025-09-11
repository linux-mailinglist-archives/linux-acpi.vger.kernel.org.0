Return-Path: <linux-acpi+bounces-16692-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9762B53C4B
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 21:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C6B56882D
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 19:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEA524BBE4;
	Thu, 11 Sep 2025 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c8PzK9ct"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF3B2DC765;
	Thu, 11 Sep 2025 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619068; cv=none; b=Ggc643Zy0I7KnO3DT51B6pJnGUtmqipnP2AOyTKXvK9sMyDVCI77DcqPY4xDHmBR6cX3EKKeLhSp2sKqbQaX6cubbWDfYRmHuzyR3kfTbcl6GaM6iLhRuNp68dYQj1hyL2hVyB6Ypgv+LamC5im337v9+x8vGn5QV/MXP3xvdcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619068; c=relaxed/simple;
	bh=yX5TSOknKtfjZJ2t2ZbP7iUWUUSBQvZMQuGGi2eajPQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ncI6hsz3frbpsNVmbhJ0gpJPcThRIE1LHpNKXg8k+PUqLbmSUGVixgeD2JkESCEqA0sdyzROggNNTUnB0Ynk9CLp1G7VrPyMdo6jmEY1C31E1RuWxaP8LgTq4fE+qzbqN0zbPJ1xQ2/FcQy0AIockqCIoEzJRkxhaDOf4kLYE8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c8PzK9ct; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757619067; x=1789155067;
  h=date:from:to:cc:subject:message-id;
  bh=yX5TSOknKtfjZJ2t2ZbP7iUWUUSBQvZMQuGGi2eajPQ=;
  b=c8PzK9ctOPGdd9AzAs2npa5WbNs7V63KtXi0gMn6vQp6l2QDrEqhErG+
   3Cs5l2cP1kQfbv10Cfm7vXEJkC6Cg62FKgJVjw17foViFccdn8DUP93O/
   qpvR5v0WuNmIf6Thmsw7Hmcf3xF4uKhzKF8yM/h+gT42Z4F6oGjxkWdwB
   MTyZbwA6MTUhjCDBYJJEDsVlI9mGKClPYE0cgtFdQWlbIw5q9DD5WDG9o
   73v4e5zjIyPF0RWqKAQ+BSz3YqELF5Hi11T9gbpCxP7ssBs4keZlp0xKe
   X6K+tZcpr82DtTRwcYnWQ24A7mCQ0CqSuBDeWJK+sxnvrp5gjJqP11g9C
   g==;
X-CSE-ConnectionGUID: y/WfNU6eQ6KaQF4nMIw7Xw==
X-CSE-MsgGUID: I/xebYnMRVinJQNeiUj4FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59907317"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59907317"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 12:31:07 -0700
X-CSE-ConnectionGUID: GwMVY2nLS+atpQ3uI1DzpA==
X-CSE-MsgGUID: COWNDf2oSN6DoQzIEpGQHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="210929702"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 11 Sep 2025 12:31:06 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwn0T-0000ak-1v;
	Thu, 11 Sep 2025 19:30:59 +0000
Date: Fri, 12 Sep 2025 03:29:42 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 a5099d5e8b13e7a790ce2f4228074c76fee98ef6
Message-ID: <202509120332.CiMO6bIf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: a5099d5e8b13e7a790ce2f4228074c76fee98ef6  Merge branch 'pm-sleep-fixes' into fixes

elapsed time: 1459m

configs tested: 118
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250911    gcc-8.5.0
arc                   randconfig-002-20250911    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                           imxrt_defconfig    clang-22
arm                          ixp4xx_defconfig    gcc-15.1.0
arm                   randconfig-001-20250911    clang-22
arm                   randconfig-002-20250911    gcc-14.3.0
arm                   randconfig-003-20250911    clang-22
arm                   randconfig-004-20250911    clang-16
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250911    gcc-13.4.0
arm64                 randconfig-002-20250911    gcc-8.5.0
arm64                 randconfig-003-20250911    gcc-8.5.0
arm64                 randconfig-004-20250911    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250911    gcc-15.1.0
csky                  randconfig-002-20250911    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250911    clang-20
hexagon               randconfig-002-20250911    clang-22
i386                             alldefconfig    gcc-14
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20250911    clang-20
i386        buildonly-randconfig-001-20250912    gcc-13
i386        buildonly-randconfig-002-20250911    clang-20
i386        buildonly-randconfig-002-20250912    gcc-13
i386        buildonly-randconfig-003-20250911    clang-20
i386        buildonly-randconfig-003-20250912    gcc-13
i386        buildonly-randconfig-004-20250911    clang-20
i386        buildonly-randconfig-004-20250912    gcc-13
i386        buildonly-randconfig-005-20250911    clang-20
i386        buildonly-randconfig-005-20250912    gcc-13
i386        buildonly-randconfig-006-20250911    clang-20
i386        buildonly-randconfig-006-20250912    gcc-13
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250911    gcc-15.1.0
loongarch             randconfig-002-20250911    gcc-15.1.0
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
nios2                 randconfig-001-20250911    gcc-11.5.0
nios2                 randconfig-002-20250911    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250911    gcc-8.5.0
parisc                randconfig-002-20250911    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250911    gcc-8.5.0
powerpc               randconfig-002-20250911    gcc-15.1.0
powerpc               randconfig-003-20250911    gcc-8.5.0
powerpc64             randconfig-001-20250911    clang-22
powerpc64             randconfig-002-20250911    gcc-11.5.0
powerpc64             randconfig-003-20250911    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250911    clang-20
riscv                 randconfig-002-20250911    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250911    gcc-11.5.0
s390                  randconfig-002-20250911    clang-16
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250911    gcc-9.5.0
sh                    randconfig-002-20250911    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250911    gcc-15.1.0
sparc                 randconfig-002-20250911    gcc-15.1.0
sparc64               randconfig-001-20250911    gcc-8.5.0
sparc64               randconfig-002-20250911    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250911    clang-22
um                    randconfig-002-20250911    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250911    gcc-14
x86_64      buildonly-randconfig-002-20250911    gcc-14
x86_64      buildonly-randconfig-003-20250911    clang-20
x86_64      buildonly-randconfig-004-20250911    clang-20
x86_64      buildonly-randconfig-005-20250911    clang-20
x86_64      buildonly-randconfig-006-20250911    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250911    gcc-12.5.0
xtensa                randconfig-002-20250911    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

