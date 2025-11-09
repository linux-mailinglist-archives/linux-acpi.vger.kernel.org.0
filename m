Return-Path: <linux-acpi+bounces-18692-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D99C43756
	for <lists+linux-acpi@lfdr.de>; Sun, 09 Nov 2025 03:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F05D3B0AA5
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 02:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C711D416C;
	Sun,  9 Nov 2025 02:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gngKxkgb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD0A134AB;
	Sun,  9 Nov 2025 02:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762655970; cv=none; b=gwh4dUVIaFg8dMwKki28m+Ihq+rwRZvuXwbfFIFrCUUV5PkEdJ0TUij/fTtlUsaVnNFn/iq/KOqiVxLjmhZ+EyfJ8xgmCZeOGA5GmYYmTCEV0ICRpvzV5H1ooRNEwi5GpYH9zdE70VfvrRM1TcteyPYPg8Fc0LegdbRVWP2U5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762655970; c=relaxed/simple;
	bh=xOezjHAfrG6FPu0vI2TkQaXhUlIqnhRYOSpd8sjNurI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FHjIW+RUhU4mBEIghhPIj8hGY9f0OPyYP/roATwrDCsHGOPJ74lFayidxo7YoscCMJMuxNZGpkFRzMbYyn4kOLAEv34AJoUyRocAzo7B+eqHQO7L30zB+pzqBbMMnBZlzPPd9U6l4TqlKiBYN2/FGKkEnfsNUAnzc5ion1ZNh1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gngKxkgb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762655969; x=1794191969;
  h=date:from:to:cc:subject:message-id;
  bh=xOezjHAfrG6FPu0vI2TkQaXhUlIqnhRYOSpd8sjNurI=;
  b=gngKxkgbXBxBpA3m+OKjZLh1liq1Q7osvXDQ8NxFpxr1ctIYVEjRObyT
   JD0j7jFv3FVqbDhGpi/nMreCE/KrRCxTmjAaJav98l9B4BqEJwuotCrdx
   Zwzb3FkUCSkgX6KItjWtCcYC0YUOlwUH30oM1bHV8RDvS1Y7YeEcMHORM
   IbSxWtZbh9LUxpCZ5xL+inquowdjrqUGfEmGoFZV+mNbUA24+e49y4wba
   /Rle92bZ7hrXgMia+7pOfFiXSVlW6p5aW+prqUiI04WNvZnnm16gXKRg7
   vNAzKNgGexEmxXx9N6jasNPcdUc6cbPHkVZin68bRWXLOH6IhJFtz/T+x
   Q==;
X-CSE-ConnectionGUID: 1ZULqS1cQo2Wf/YU8Yj/Lw==
X-CSE-MsgGUID: 28V8WX5eRfmGQnKqvbCmAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="64635656"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="64635656"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 18:39:28 -0800
X-CSE-ConnectionGUID: mfUhvN7+QKK1H0o2wggBwA==
X-CSE-MsgGUID: LB7ln90HSBGZib6t+ym0nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="193394367"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 08 Nov 2025 18:39:27 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHvKv-0001hv-0O;
	Sun, 09 Nov 2025 02:39:25 +0000
Date: Sun, 09 Nov 2025 10:38:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 d1dbf135dcce0eafcc24bddf17c48738846a6eb9
Message-ID: <202511091021.mpleiFl4-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: d1dbf135dcce0eafcc24bddf17c48738846a6eb9  Merge branch 'acpi-tables' into fixes

elapsed time: 1752m

configs tested: 100
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                     nsimosci_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20251108    gcc-12.5.0
arc                   randconfig-002-20251108    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                         nhk8815_defconfig    clang-22
arm                   randconfig-001-20251108    gcc-14.3.0
arm                   randconfig-002-20251108    gcc-15.1.0
arm                   randconfig-003-20251108    clang-22
arm                   randconfig-004-20251108    gcc-10.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251109    gcc-15.1.0
arm64                 randconfig-002-20251109    gcc-12.5.0
arm64                 randconfig-003-20251109    clang-19
arm64                 randconfig-004-20251109    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251109    gcc-14.3.0
csky                  randconfig-002-20251109    gcc-11.5.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251108    clang-22
hexagon               randconfig-002-20251108    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251109    gcc-14
i386        buildonly-randconfig-002-20251109    gcc-13
i386        buildonly-randconfig-003-20251109    clang-20
i386        buildonly-randconfig-004-20251109    clang-20
i386        buildonly-randconfig-005-20251109    clang-20
i386        buildonly-randconfig-006-20251109    clang-20
i386                  randconfig-011-20251109    clang-20
i386                  randconfig-012-20251109    clang-20
i386                  randconfig-013-20251109    gcc-14
i386                  randconfig-014-20251109    gcc-14
i386                  randconfig-015-20251109    gcc-12
i386                  randconfig-016-20251109    gcc-14
i386                  randconfig-017-20251109    gcc-14
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251108    gcc-12.5.0
loongarch             randconfig-002-20251108    gcc-12.5.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251108    gcc-8.5.0
nios2                 randconfig-002-20251108    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20251108    gcc-8.5.0
parisc                randconfig-002-20251108    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                     ksi8560_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251108    gcc-8.5.0
powerpc               randconfig-002-20251108    gcc-9.5.0
powerpc                     redwood_defconfig    clang-22
powerpc                     tqm8541_defconfig    clang-22
powerpc                         wii_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251108    gcc-8.5.0
powerpc64             randconfig-002-20251108    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                  randconfig-001-20251108    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                           se7712_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251109    gcc-8.5.0
sparc                 randconfig-002-20251109    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251109    gcc-8.5.0
sparc64               randconfig-002-20251109    gcc-14.3.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251109    gcc-13
um                    randconfig-002-20251109    clang-17
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251109    clang-20
x86_64      buildonly-randconfig-002-20251109    gcc-14
x86_64      buildonly-randconfig-003-20251109    clang-20
x86_64      buildonly-randconfig-004-20251109    clang-20
x86_64      buildonly-randconfig-005-20251109    clang-20
x86_64      buildonly-randconfig-006-20251109    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251109    gcc-14
x86_64                randconfig-012-20251109    clang-20
x86_64                randconfig-013-20251109    gcc-14
x86_64                randconfig-014-20251109    clang-20
x86_64                randconfig-015-20251109    clang-20
x86_64                randconfig-016-20251109    clang-20
x86_64                randconfig-073-20251109    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251109    gcc-13.4.0
xtensa                randconfig-002-20251109    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

