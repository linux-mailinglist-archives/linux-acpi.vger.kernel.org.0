Return-Path: <linux-acpi+bounces-15197-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B89B077A7
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 16:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D832A1C275FE
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 14:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F421821FF41;
	Wed, 16 Jul 2025 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCxBU4on"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011C221D5B8;
	Wed, 16 Jul 2025 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675031; cv=none; b=ZL/KoFtjUY4zZtNrwViuEz4/qsfHaozd/deFjLluVwDvWf3LRcjOxxskSp5w1Wfsqd0eUu39VPkApJNnoBtsmWdsG2SjmZli45+a3eLXlAlbCM2UaFk0JyJVGl1jKvhrW7qzIZmXzyHFG7VO53zKI23MgzWRzP4Aico8DI88ZcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675031; c=relaxed/simple;
	bh=tGpnXrxVE0UUnY88JJMoDphb5L2yKXi5PQiisPbBeu0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DiW+ePoJG1Wu6wwYEvY+tnGlTIgZWIoq8mp/JGbBqvh3YQ8tVm+p+Z6u7cuKQHJYQLLJhvTJOAMmfAu03hl3TPda3J7fPa1CbN8NWBeNiEeTGuEzQHvbFhqxY8kTmbsUUOO9g0JW5C+0qyZVRBEHeUUL11QGbvnhIIft7C9r4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCxBU4on; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752675030; x=1784211030;
  h=date:from:to:cc:subject:message-id;
  bh=tGpnXrxVE0UUnY88JJMoDphb5L2yKXi5PQiisPbBeu0=;
  b=GCxBU4onWknA4PExBAT3kTyX7qQOAJ3Az84t1x862CeRtNsCjNOyFl2B
   sgj8gXZsqx2GKxhqC3QWUC4xl1CO8Pmy6TURCCMIuA4xDrjs80G2C0zFs
   3r6pFuVGfLhRBZ1QsfmJC59GTUx6m0Hgc0vZrtdeRmf5Sc9xc5wui9d8B
   TYfM+1J3zqf0CAZeBAKwfNilCpdTillGiwyeOSFinv/MCHsUt56z1vwp3
   HM5xfafpsup/cVPmGSOtk3jC95CjZE1CWXG0mbG2YFLZ9HqSmcDdNRzwU
   8ob80FRkuG1M3Y/YlPMAA2mFT3AFGZbyWce2UAOAqqSmAQDZv3KvJGDjT
   A==;
X-CSE-ConnectionGUID: lwNaCQcTTY+dxOH6nPW8FA==
X-CSE-MsgGUID: 7Z7GpsfkQwWfIw3GzMbSdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65492529"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="65492529"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 07:10:30 -0700
X-CSE-ConnectionGUID: KKR+B8+BRR6yPoa6AYQGag==
X-CSE-MsgGUID: hje5qfR5SruvgpOvrkv/tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="188519931"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 16 Jul 2025 07:10:28 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uc2q2-000CTl-0d;
	Wed, 16 Jul 2025 14:10:26 +0000
Date: Wed, 16 Jul 2025 22:10:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 e59827643e13ded96e02ae9ce1b97a2f8185edad
Message-ID: <202507162248.FLGxDvEk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: e59827643e13ded96e02ae9ce1b97a2f8185edad  Merge branches 'pm-misc' and 'pm-tools' into linux-next

elapsed time: 1444m

configs tested: 137
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
arc                          axs103_defconfig    gcc-15.1.0
arc                            hsdk_defconfig    gcc-15.1.0
arc                   randconfig-001-20250715    gcc-8.5.0
arc                   randconfig-001-20250716    gcc-13.4.0
arc                   randconfig-002-20250715    gcc-11.5.0
arc                   randconfig-002-20250716    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250715    clang-21
arm                   randconfig-001-20250716    clang-20
arm                   randconfig-002-20250715    gcc-10.5.0
arm                   randconfig-002-20250716    gcc-12.4.0
arm                   randconfig-003-20250715    clang-21
arm                   randconfig-003-20250716    gcc-8.5.0
arm                   randconfig-004-20250715    gcc-12.4.0
arm                   randconfig-004-20250716    gcc-8.5.0
arm                        spear6xx_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250715    clang-16
arm64                 randconfig-001-20250716    gcc-9.5.0
arm64                 randconfig-002-20250715    gcc-12.3.0
arm64                 randconfig-002-20250716    gcc-8.5.0
arm64                 randconfig-003-20250715    gcc-8.5.0
arm64                 randconfig-003-20250716    gcc-8.5.0
arm64                 randconfig-004-20250715    clang-21
arm64                 randconfig-004-20250716    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250715    gcc-9.3.0
csky                  randconfig-002-20250715    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250715    clang-18
hexagon               randconfig-002-20250715    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250715    gcc-12
i386        buildonly-randconfig-001-20250716    gcc-12
i386        buildonly-randconfig-002-20250715    gcc-12
i386        buildonly-randconfig-002-20250716    clang-20
i386        buildonly-randconfig-003-20250715    gcc-12
i386        buildonly-randconfig-003-20250716    gcc-12
i386        buildonly-randconfig-004-20250715    clang-20
i386        buildonly-randconfig-004-20250716    gcc-11
i386        buildonly-randconfig-005-20250715    clang-20
i386        buildonly-randconfig-005-20250716    gcc-12
i386        buildonly-randconfig-006-20250715    clang-20
i386        buildonly-randconfig-006-20250716    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250715    clang-21
loongarch             randconfig-002-20250715    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                           sun3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250715    gcc-11.5.0
nios2                 randconfig-002-20250715    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250715    gcc-10.5.0
parisc                randconfig-002-20250715    gcc-9.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250715    clang-21
powerpc               randconfig-002-20250715    clang-21
powerpc               randconfig-003-20250715    gcc-8.5.0
powerpc64             randconfig-001-20250715    clang-21
powerpc64             randconfig-003-20250715    clang-17
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250716    gcc-8.5.0
riscv                 randconfig-002-20250716    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250716    gcc-11.5.0
s390                  randconfig-002-20250716    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250716    gcc-15.1.0
sh                    randconfig-002-20250716    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250716    gcc-8.5.0
sparc                 randconfig-002-20250716    gcc-14.3.0
sparc64               randconfig-001-20250716    clang-20
sparc64               randconfig-002-20250716    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250716    gcc-11
um                    randconfig-002-20250716    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250715    clang-20
x86_64      buildonly-randconfig-001-20250716    gcc-12
x86_64      buildonly-randconfig-002-20250715    gcc-12
x86_64      buildonly-randconfig-002-20250716    clang-20
x86_64      buildonly-randconfig-003-20250715    gcc-12
x86_64      buildonly-randconfig-003-20250716    clang-20
x86_64      buildonly-randconfig-004-20250715    gcc-11
x86_64      buildonly-randconfig-004-20250716    clang-20
x86_64      buildonly-randconfig-005-20250715    gcc-12
x86_64      buildonly-randconfig-005-20250716    clang-20
x86_64      buildonly-randconfig-006-20250715    gcc-12
x86_64      buildonly-randconfig-006-20250716    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                          iss_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250716    gcc-9.3.0
xtensa                randconfig-002-20250716    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

