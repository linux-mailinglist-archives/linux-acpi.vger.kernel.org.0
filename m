Return-Path: <linux-acpi+bounces-18883-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F24C5AB84
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 01:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21A12351121
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 00:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467A41E7C18;
	Fri, 14 Nov 2025 00:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W24ae7mn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665221DE4EF;
	Fri, 14 Nov 2025 00:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763079148; cv=none; b=D+DnHH+WIPwFYo9VPjZdeUuANfLz0UqBOP1HksoYucMtrqiPWWk3C7B63IyaGPSRsNxtk3BN9OG46lai+DZpC0AMC0rPrg8ZrtE5TXoh3JTSgnn0NBtdN0JqA9a3Eg/ZJ48Nt/BQzXilkrIonFBrv1ZGQPuayIMKuBsTfTTHau8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763079148; c=relaxed/simple;
	bh=mH2tOhZbM4lgUsFNZf0jqc40dky3O4L6hEQIif2Xi5c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KVUr1U3yVCGRnaDWH9r56lzpvQUDb9RK2T9SZ7WKth9p//Qa7NtyhmG1tRmFUk3iun3SKr4ifA/dUD50GD+NavQ8XvLIsDDBJgtCypN/JsG6cCqrpxtF89WtXe0cdJy2w9+yPqS+t6q+JBB/c/hk58dvI/rbEI2hmKhF0bHwy68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W24ae7mn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763079146; x=1794615146;
  h=date:from:to:cc:subject:message-id;
  bh=mH2tOhZbM4lgUsFNZf0jqc40dky3O4L6hEQIif2Xi5c=;
  b=W24ae7mnE4TlKp0DZZMOKuNkuDRRuUWkiiPujZA/RVLV36++LHl9po2n
   AJ/3ujsbKmn5ft6fPGA6otOCFYOEgcnsEm2YfmpmP30+F/DNm0UIPMRmv
   VyOqmFoDDKlcI25l6tF8Ya6iQK5DokgXpRTQCwTm2zI6wLsyZYN+rZw0H
   fvXWktijj/VdmI2TxX8KdcxTv6+YOxNfEZcEUsP9BGJJiHLwOGk4sg4Oi
   ECXdn+LCV8v/HDrPcm+yYy7Cd6I0+cyN8Ou7hkyFnEYtUp+VhwS+ft8i8
   R6raa43Osmdg8aF6jsih4hoS4c/DkMtdvlPdNhh6wfrcKoQNRgOf1NVKY
   w==;
X-CSE-ConnectionGUID: +xI3kajRR7aTYFJk685RTQ==
X-CSE-MsgGUID: 1JKVwtmwRcGXOTDohNsA0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65211184"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="65211184"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 16:12:25 -0800
X-CSE-ConnectionGUID: YVrZ0buaTZi98aUJ1G0B/A==
X-CSE-MsgGUID: iZHeiLOyTse3sWuVZs3V5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="189642089"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Nov 2025 16:12:24 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJhQL-00060V-2G;
	Fri, 14 Nov 2025 00:12:21 +0000
Date: Fri, 14 Nov 2025 08:12:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 6306e0cca7bfa0d3caac250fbd6f71e2b7853ee3
Message-ID: <202511140859.PYYUszgd-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 6306e0cca7bfa0d3caac250fbd6f71e2b7853ee3  Merge branches 'acpi-tables' and 'acpi-cppc' into fixes

elapsed time: 1827m

configs tested: 100
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251113    gcc-8.5.0
arc                   randconfig-002-20251113    gcc-8.5.0
arc                           tb10x_defconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251113    gcc-10.5.0
arm                   randconfig-002-20251113    clang-22
arm                   randconfig-003-20251113    clang-22
arm                           sunxi_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251113    clang-16
arm64                 randconfig-002-20251113    clang-22
arm64                 randconfig-003-20251113    gcc-8.5.0
arm64                 randconfig-004-20251113    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251113    gcc-9.5.0
csky                  randconfig-002-20251113    gcc-14.3.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251113    clang-22
hexagon               randconfig-002-20251113    clang-22
i386                              allnoconfig    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251114    clang-20
i386                  randconfig-002-20251114    clang-20
i386                  randconfig-003-20251114    clang-20
i386                  randconfig-004-20251114    gcc-14
i386                  randconfig-005-20251114    gcc-14
i386                  randconfig-006-20251114    clang-20
i386                  randconfig-007-20251114    clang-20
i386                  randconfig-011-20251114    gcc-12
i386                  randconfig-012-20251114    gcc-14
i386                  randconfig-013-20251114    gcc-14
i386                  randconfig-014-20251114    clang-20
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251113    gcc-15.1.0
loongarch             randconfig-002-20251113    clang-22
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                            gpr_defconfig    clang-18
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251113    gcc-8.5.0
nios2                 randconfig-002-20251113    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251113    gcc-8.5.0
parisc                randconfig-002-20251113    gcc-14.3.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                       ebony_defconfig    clang-22
powerpc               randconfig-001-20251113    clang-22
powerpc               randconfig-002-20251113    clang-22
powerpc                 xes_mpc85xx_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251113    clang-22
powerpc64             randconfig-002-20251113    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251113    gcc-8.5.0
riscv                 randconfig-002-20251113    gcc-11.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251113    clang-22
s390                  randconfig-002-20251113    clang-17
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                            migor_defconfig    gcc-15.1.0
sh                    randconfig-001-20251113    gcc-15.1.0
sh                    randconfig-002-20251113    gcc-11.5.0
sh                           se7206_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251114    gcc-14.3.0
sparc                 randconfig-002-20251114    gcc-12.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251114    gcc-8.5.0
sparc64               randconfig-002-20251114    gcc-14.3.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251114    gcc-13
um                    randconfig-002-20251114    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251114    clang-20
x86_64      buildonly-randconfig-002-20251114    gcc-14
x86_64      buildonly-randconfig-003-20251114    gcc-14
x86_64      buildonly-randconfig-004-20251114    clang-20
x86_64      buildonly-randconfig-005-20251114    clang-20
x86_64      buildonly-randconfig-006-20251114    gcc-14
x86_64                              defconfig    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251114    gcc-14.3.0
xtensa                randconfig-002-20251114    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

