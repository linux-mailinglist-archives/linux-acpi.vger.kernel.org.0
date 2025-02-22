Return-Path: <linux-acpi+bounces-11387-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7A5A40ACD
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Feb 2025 18:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A4647A73B8
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Feb 2025 17:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04396200100;
	Sat, 22 Feb 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAlbCH+L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62E127453;
	Sat, 22 Feb 2025 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740247072; cv=none; b=SykaewbXmUQYwi7cI+d7ptOR5AZNOvQGhkYzjKHhRJhpuKaKmyGfkSSe8NuoI6t85RdlNnkQbL+fKbNFMxqokQAHquqLUB1m2CSiUgn/m/OQD+nLX0tDRoqw9gdt3qrrOrUpXOkbl3Y0sr2vXjG+fD6sh7U1ClmzT44LoyxtBTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740247072; c=relaxed/simple;
	bh=jjQakI6WCNEI3/M6OjKvi9M8LBrg5bR6HMVWt965QUQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=urxDED5nEbyJ1hCsbeTKPgum3o9sWkfM7qa1bHBByXi7hts1Ivf+0RI6hRwEnLej12eIag+qNBfu7E0+aI4AoNFM+6jQf3JwupXzK3BGiNeHba6loagOeqsDQe9dh0kwUXpPvxBzEwV8iEgFN4pOvbh8kAHySRwV7gc9FJAKXfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAlbCH+L; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740247072; x=1771783072;
  h=date:from:to:cc:subject:message-id;
  bh=jjQakI6WCNEI3/M6OjKvi9M8LBrg5bR6HMVWt965QUQ=;
  b=lAlbCH+Ldcyjw2ZHr2lYmO913luyR09XdH6InnJDK4j8F1WYWsdLd2um
   UP4Fp0R9yOZoPtHRreAjNyWtRRqG1aK+0RvoMHReI40QSk9INavAgMzvk
   0PKq4Vymu0/6C/vA5zB48XdX4yxVl6iKPeMK8MXfu3tsYl7NXbTLS9zyq
   BYtXnDODmaoYX1o1ZOJeS61NwQGekawaFUtTy6tl2BqJPz5xXKhLIyRPl
   f2W2StR9zlOAxi3zUUeLZxCvdUIlyhm5YPjGTV9Hstn5qTOUgWi/6UPNF
   BMFlm3O3jwyGvIy6xkCgr9qO9zDDx4CnrRkF9wCkjPH+iFYpg9jCCMOTQ
   Q==;
X-CSE-ConnectionGUID: UzQD/3sfTz6FhfPmPHLZAA==
X-CSE-MsgGUID: lw8mLLytTCihTO9po8FjWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="44701588"
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="44701588"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 09:57:51 -0800
X-CSE-ConnectionGUID: yAkvFCzsQoiKyf12jt2odw==
X-CSE-MsgGUID: RdLWSqZDS0yw3iqhLGb0Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="146556447"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 22 Feb 2025 09:57:48 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tltl4-0006n5-1p;
	Sat, 22 Feb 2025 17:57:46 +0000
Date: Sun, 23 Feb 2025 01:57:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 43673f9f2073385ab95f4493a6c90e459e25f86a
Message-ID: <202502230110.5vdoSx0N-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 43673f9f2073385ab95f4493a6c90e459e25f86a  Merge branch 'thermal-core' into fixes

elapsed time: 1443m

configs tested: 62
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250222    gcc-13.2.0
arc                  randconfig-002-20250222    gcc-13.2.0
arm                  randconfig-001-20250222    gcc-14.2.0
arm                  randconfig-002-20250222    gcc-14.2.0
arm                  randconfig-003-20250222    clang-16
arm                  randconfig-004-20250222    gcc-14.2.0
arm64                randconfig-001-20250222    gcc-14.2.0
arm64                randconfig-002-20250222    clang-21
arm64                randconfig-003-20250222    clang-18
arm64                randconfig-004-20250222    clang-21
csky                 randconfig-001-20250222    gcc-14.2.0
csky                 randconfig-002-20250222    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250222    clang-17
hexagon              randconfig-002-20250222    clang-19
i386       buildonly-randconfig-001-20250222    clang-19
i386       buildonly-randconfig-002-20250222    gcc-12
i386       buildonly-randconfig-003-20250222    gcc-12
i386       buildonly-randconfig-004-20250222    clang-19
i386       buildonly-randconfig-005-20250222    gcc-12
i386       buildonly-randconfig-006-20250222    clang-19
loongarch            randconfig-001-20250222    gcc-14.2.0
loongarch            randconfig-002-20250222    gcc-14.2.0
nios2                randconfig-001-20250222    gcc-14.2.0
nios2                randconfig-002-20250222    gcc-14.2.0
parisc               randconfig-001-20250222    gcc-14.2.0
parisc               randconfig-002-20250222    gcc-14.2.0
powerpc              randconfig-001-20250222    gcc-14.2.0
powerpc              randconfig-002-20250222    gcc-14.2.0
powerpc              randconfig-003-20250222    gcc-14.2.0
powerpc64            randconfig-001-20250222    gcc-14.2.0
powerpc64            randconfig-002-20250222    clang-16
powerpc64            randconfig-003-20250222    clang-18
riscv                randconfig-001-20250222    clang-21
riscv                randconfig-002-20250222    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250222    gcc-14.2.0
s390                 randconfig-002-20250222    clang-15
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250222    gcc-14.2.0
sh                   randconfig-002-20250222    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250222    gcc-14.2.0
sparc                randconfig-002-20250222    gcc-14.2.0
sparc64              randconfig-001-20250222    gcc-14.2.0
sparc64              randconfig-002-20250222    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250222    gcc-12
um                   randconfig-002-20250222    gcc-12
x86_64     buildonly-randconfig-001-20250222    clang-19
x86_64     buildonly-randconfig-002-20250222    gcc-12
x86_64     buildonly-randconfig-003-20250222    gcc-12
x86_64     buildonly-randconfig-004-20250222    clang-19
x86_64     buildonly-randconfig-005-20250222    clang-19
x86_64     buildonly-randconfig-006-20250222    gcc-12
xtensa               randconfig-001-20250222    gcc-14.2.0
xtensa               randconfig-002-20250222    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

