Return-Path: <linux-acpi+bounces-19846-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2D5CDDA01
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 10:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA2923020066
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E50626C3A2;
	Thu, 25 Dec 2025 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/OegG7M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF07919C54E;
	Thu, 25 Dec 2025 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766656489; cv=none; b=NrpOpL9aQRGiB6G9U2OGJo+mMjrAnUgvlP3rmnZYlXVcYjYyUua7cdg2QZSwQoxnJqveQNguYGbk2T09CjJWAWtSGvtd2ZIu2ezxNEYIAvaNRhLNPMvm2CpJMQMfSbOpDOCMg0m+bGMPkZzbVrA/YaxkgoW6iJRc+P7yXFIBFaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766656489; c=relaxed/simple;
	bh=g1z6AkV4utITKL0DzG0l6IfyyZbDqdSGOQTWHHEmxlg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AdRbcR+B0Y73T22wnF9X4D2bOXUMGQY1RyNr2X9go/OMWlEeZ37aQc2apdLFlUdj9QGKAJqTv3rLWWFqLSJ0vMzgZu3aBk7K/5fvT+IEUmstPjZxD8XCGApr+4E3Bi7Z1ajiLKKcrCvhw9I0YMtZfzcCxFEXiT9WmCSez2DcyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/OegG7M; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766656487; x=1798192487;
  h=date:from:to:cc:subject:message-id;
  bh=g1z6AkV4utITKL0DzG0l6IfyyZbDqdSGOQTWHHEmxlg=;
  b=N/OegG7M8lg01vEb3HWQ5DWqSkS7RbCicQIFPH5ILZyw+pl6FkU/aKM2
   ZdC5qAgoy7t8azyzkYiFVsiYc92jjXN3UF69PQ71ru805UxEdWliT3ao2
   Udh3lth1hzLneAEqYxqK/rMLfALeAEQKI9Wiy4jXs3yXjFAspCYimciU0
   7l+ZQKW2cpBwjITRVj4PfjnDiZ7l/sA8GIE1zTR3zkkISQn32MukSEW9C
   vQW2BzDEJRckhMZjn1I4V601M2JXygqDj3MdQgY47qPy3D5ElmbQorzcC
   XlerCD5Jv/YXsTS0xYvthxG9jjmv3W2la4AC1a5eWbZ3RquULCJf8XM4h
   A==;
X-CSE-ConnectionGUID: +uq9knvcT1+NlQAZBGwksA==
X-CSE-MsgGUID: N7QYorEfRA6Ls4roiwHkew==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="72317769"
X-IronPort-AV: E=Sophos;i="6.21,176,1763452800"; 
   d="scan'208";a="72317769"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2025 01:54:46 -0800
X-CSE-ConnectionGUID: 3J9YFNseSA6NUAxcD3sfMQ==
X-CSE-MsgGUID: EXUt1gX7ScepFK2gWdEdvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,176,1763452800"; 
   d="scan'208";a="231253063"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 25 Dec 2025 01:54:45 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYi3K-000000003xn-1duT;
	Thu, 25 Dec 2025 09:54:39 +0000
Date: Thu, 25 Dec 2025 17:53:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 92c49233f514db11ba0abefc7beb5be412ae7e4b
Message-ID: <202512251736.N4KgnVNs-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 92c49233f514db11ba0abefc7beb5be412ae7e4b  Merge branch 'acpi-queue' into bleeding-edge

elapsed time: 1304m

configs tested: 162
configs skipped: 5

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
arc                   randconfig-001-20251225    gcc-11.5.0
arc                   randconfig-002-20251225    gcc-11.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20251225    clang-22
arm                   randconfig-002-20251225    gcc-12.5.0
arm                   randconfig-003-20251225    clang-22
arm                   randconfig-004-20251225    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251225    clang-18
arm64                 randconfig-002-20251225    gcc-12.5.0
arm64                 randconfig-003-20251225    clang-22
arm64                 randconfig-004-20251225    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251225    gcc-15.1.0
csky                  randconfig-002-20251225    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251225    clang-22
hexagon               randconfig-002-20251225    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251225    clang-20
i386        buildonly-randconfig-002-20251225    clang-20
i386        buildonly-randconfig-003-20251225    gcc-14
i386        buildonly-randconfig-004-20251225    clang-20
i386        buildonly-randconfig-005-20251225    clang-20
i386        buildonly-randconfig-006-20251225    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251225    gcc-14
i386                  randconfig-002-20251225    clang-20
i386                  randconfig-003-20251225    clang-20
i386                  randconfig-004-20251225    clang-20
i386                  randconfig-005-20251225    clang-20
i386                  randconfig-006-20251225    clang-20
i386                  randconfig-007-20251225    clang-20
i386                  randconfig-011-20251225    clang-20
i386                  randconfig-012-20251225    gcc-14
i386                  randconfig-013-20251225    gcc-14
i386                  randconfig-014-20251225    clang-20
i386                  randconfig-015-20251225    gcc-14
i386                  randconfig-016-20251225    clang-20
i386                  randconfig-017-20251225    clang-20
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251225    clang-22
loongarch             randconfig-002-20251225    gcc-15.1.0
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
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251225    gcc-9.5.0
nios2                 randconfig-002-20251225    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                  or1klitex_defconfig    gcc-15.1.0
parisc                           alldefconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251225    gcc-12.5.0
parisc                randconfig-002-20251225    gcc-14.3.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                  iss476-smp_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251225    clang-22
powerpc               randconfig-002-20251225    clang-22
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20251225    gcc-8.5.0
powerpc64             randconfig-002-20251225    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251225    clang-22
riscv                 randconfig-002-20251225    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251225    gcc-14.3.0
s390                  randconfig-002-20251225    clang-19
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251225    gcc-15.1.0
sh                    randconfig-002-20251225    gcc-9.5.0
sh                           se7206_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251225    gcc-8.5.0
sparc                 randconfig-002-20251225    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251225    gcc-9.5.0
sparc64               randconfig-002-20251225    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251225    gcc-13
um                    randconfig-002-20251225    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251225    clang-20
x86_64      buildonly-randconfig-002-20251225    clang-20
x86_64      buildonly-randconfig-003-20251225    gcc-14
x86_64      buildonly-randconfig-004-20251225    clang-20
x86_64      buildonly-randconfig-005-20251225    gcc-14
x86_64      buildonly-randconfig-006-20251225    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251225    gcc-12
x86_64                randconfig-002-20251225    clang-20
x86_64                randconfig-003-20251225    gcc-12
x86_64                randconfig-004-20251225    clang-20
x86_64                randconfig-005-20251225    gcc-14
x86_64                randconfig-006-20251225    gcc-14
x86_64                randconfig-011-20251225    gcc-13
x86_64                randconfig-012-20251225    gcc-14
x86_64                randconfig-013-20251225    clang-20
x86_64                randconfig-014-20251225    clang-20
x86_64                randconfig-015-20251225    gcc-14
x86_64                randconfig-016-20251225    clang-20
x86_64                randconfig-071-20251225    clang-20
x86_64                randconfig-072-20251225    clang-20
x86_64                randconfig-073-20251225    gcc-14
x86_64                randconfig-074-20251225    clang-20
x86_64                randconfig-075-20251225    gcc-14
x86_64                randconfig-076-20251225    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251225    gcc-8.5.0
xtensa                randconfig-002-20251225    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

