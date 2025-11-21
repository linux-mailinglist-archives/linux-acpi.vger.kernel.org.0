Return-Path: <linux-acpi+bounces-19183-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39497C7A8FA
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Nov 2025 16:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2453A52BD
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Nov 2025 15:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3305D350D43;
	Fri, 21 Nov 2025 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKFVo9QZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8527634FF65;
	Fri, 21 Nov 2025 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738580; cv=none; b=pkoODuLT82Ashx11UJhYu7iIXXdryENMLqw41uOpJDO9TyilEBPeENw3Mj6Gea1b2lsJkbMKAFvHuZEqUVkQlQhhF/wFW4Bjo2TAAsd5oIUWOziUvBLrZNsL+Z7+kfqhRtl+MvlboslSzdzguZvbe1FLZDAVAuoa+ZMTYZZjVzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738580; c=relaxed/simple;
	bh=X521DMu7j0wgQL6zt7wAE6sXMxswbs0wS8s+aI/rl0g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gxmhDzM/DZJCMjkUM/5sHjTpuoRwbpwpywBFiFCXldZ3ysz/KXHVhVTy1qcO5aKE+c5IX15tmw9XpnspUoL0KxPG5CSV07Nc53VymeqFSrfq43OhvnYjaskSaXuSkkpv10BWnRl1RnqO59PdwjuXeMTclqz67DbomUWFNWR6ZNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKFVo9QZ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763738578; x=1795274578;
  h=date:from:to:cc:subject:message-id;
  bh=X521DMu7j0wgQL6zt7wAE6sXMxswbs0wS8s+aI/rl0g=;
  b=FKFVo9QZNW3zyUteH/X8OvkWNsM1OT/XceOYNN+W3AXv7h5LKM/uI9dj
   qB/0fsAEDgENXkLXtJmOdhXAVivYsqF/nHmieRCG1/htTy7zV+GXX1hPU
   3WoRjlmu+PH5LSznzuOqxFJCBl90K/6rGo+b0prN2+9sRBNnQnBCW8oIT
   1LlhEGWYOSBDexZj9Sfe1SS9eRXbE3P5rOlBRd4kxVSCOktcsFWycE+06
   C+pP0CJKyFHQnHdwkM21XLgIPnTr50eXqTaAHtydBARFPkwmBtJd3uW2D
   0DoZ5TKmg86xZsaiCdHhlAflaxWxkFeHuz/gpGtImlWKtYD0VVkN40wUh
   A==;
X-CSE-ConnectionGUID: Uj1ySBc/SvydvJv6L0OLWQ==
X-CSE-MsgGUID: l3TE6YVuSLmEMJfTwy7uPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="69699387"
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="69699387"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 07:22:58 -0800
X-CSE-ConnectionGUID: rRxC6A2QRrOTU2k0pl9Olw==
X-CSE-MsgGUID: ifQZUgf5QR+OvafmKlJcXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="195884033"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 21 Nov 2025 07:22:57 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMSyM-0006Vn-1a;
	Fri, 21 Nov 2025 15:22:54 +0000
Date: Fri, 21 Nov 2025 23:21:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 a907e1a5a10351d3c5df120fd4e079e36a3b9e55
Message-ID: <202511212353.A6KdUn0G-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: a907e1a5a10351d3c5df120fd4e079e36a3b9e55  Merge branch 'acpi-apei' into fixes

elapsed time: 2985m

configs tested: 77
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc           haps_hs_smp_defconfig    gcc-15.1.0
arc         randconfig-001-20251120    gcc-15.1.0
arm                     allnoconfig    clang-22
arm         randconfig-002-20251120    gcc-14.3.0
arm             spear13xx_defconfig    gcc-15.1.0
arm64                   allnoconfig    gcc-15.1.0
arm64       randconfig-001-20251120    clang-18
arm64       randconfig-002-20251120    clang-16
arm64       randconfig-003-20251120    clang-22
arm64       randconfig-004-20251120    clang-16
csky                    allnoconfig    gcc-15.1.0
csky        randconfig-001-20251120    gcc-15.1.0
csky        randconfig-002-20251120    gcc-9.5.0
hexagon                 allnoconfig    clang-22
i386                    allnoconfig    gcc-14
i386        randconfig-001-20251120    gcc-14
i386        randconfig-002-20251120    gcc-14
i386        randconfig-003-20251120    clang-20
i386        randconfig-004-20251120    clang-20
i386        randconfig-005-20251120    clang-20
i386        randconfig-006-20251120    clang-20
i386        randconfig-007-20251120    gcc-14
i386        randconfig-011-20251120    gcc-14
i386        randconfig-012-20251120    gcc-14
i386        randconfig-013-20251120    clang-20
i386        randconfig-014-20251120    gcc-14
i386        randconfig-015-20251120    gcc-14
i386        randconfig-016-20251120    gcc-14
i386        randconfig-017-20251120    gcc-14
loongarch               allnoconfig    clang-22
m68k                    allnoconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
nios2                   allnoconfig    gcc-11.5.0
openrisc                allnoconfig    gcc-15.1.0
openrisc                  defconfig    gcc-15.1.0
openrisc             virt_defconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc                    defconfig    gcc-15.1.0
parisc      randconfig-001-20251120    gcc-11.5.0
parisc      randconfig-002-20251120    gcc-12.5.0
powerpc                 allnoconfig    gcc-15.1.0
powerpc       mpc8315_rdb_defconfig    clang-22
powerpc     randconfig-001-20251120    clang-22
powerpc     randconfig-002-20251120    clang-22
powerpc64   randconfig-001-20251120    clang-22
powerpc64   randconfig-002-20251120    gcc-13.4.0
riscv                   allnoconfig    gcc-15.1.0
riscv                     defconfig    clang-22
s390                    allnoconfig    clang-22
s390                      defconfig    clang-22
sh                      allnoconfig    gcc-15.1.0
sh                        defconfig    gcc-15.1.0
sh                  shmin_defconfig    gcc-15.1.0
sh                   shx3_defconfig    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
sparc                     defconfig    gcc-15.1.0
sparc       randconfig-002-20251120    gcc-8.5.0
sparc64                alldefconfig    gcc-15.1.0
sparc64                   defconfig    clang-20
sparc64     randconfig-002-20251120    clang-22
um                      allnoconfig    clang-22
um                        defconfig    clang-22
um                   i386_defconfig    gcc-14
um                 x86_64_defconfig    clang-22
x86_64                  allnoconfig    clang-20
x86_64                    defconfig    gcc-14
x86_64                        kexec    clang-20
x86_64                     rhel-9.4    clang-20
x86_64                 rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
xtensa                  allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

