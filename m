Return-Path: <linux-acpi+bounces-18409-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60E3C270D6
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 22:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A951A21C9B
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 21:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAD8303A16;
	Fri, 31 Oct 2025 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n80ZMLrM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53BC2F549D;
	Fri, 31 Oct 2025 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946492; cv=none; b=c/8yMIqx+V8AOO2EhIX9pQwNqkOVP6bK2fIjzaSTr3XeI9TJ9VMqYyXWk+PNzA8uzxpBUZL8F2oEk0vwBtYPgJL3J142Ehk1C2smUmtdHl1UGHMwj/CheYb26U1EIwNsB2yGiuxlvvafDcIQrPhuKNsKDisoM5RYJTjIqRMuH7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946492; c=relaxed/simple;
	bh=1QW2vxfVTetAmuUXzit1UxBTUjgd76CY0n+7kJaDsEA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XpRTKuIq8RMrEKYG0tooccFRqFQZHxUjhukSgQcq5wvOtEaKukH9ygy+BYqmYFID2Ex8Ei9q1icIztYJ/AqxW1vucLo8aUT1eu3Acydn8rcdLDmNs3bdhLroodgZcduD4P6inuRQ9HCMWU7KobmlJvddxwQNtqkqDUDQ6tQMNn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n80ZMLrM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761946491; x=1793482491;
  h=date:from:to:cc:subject:message-id;
  bh=1QW2vxfVTetAmuUXzit1UxBTUjgd76CY0n+7kJaDsEA=;
  b=n80ZMLrME6XgREPdIrbHUiiRL65cxBn4RP6iq7FRCkhQdvH+Vz+eKWs9
   utaI1KVIywIDD9ezzQmyu1g1HiljgYwQfhvPIlGdk0M9BMXrRDb37p00E
   1lsR2y3X2TM0aJasPe8qE/LewXaOKbfDNHHNOf38h2O3m8iISVtoZ9E/i
   iSFfQY9Y5+W1X4CUUpUMyZSY8URpj65a6VGEV/4Sy/VJi/Qch1rB9KlNF
   iVYyQAq+8ILRxB+a1Qe38JiWaM3p0a1pqHKkscc3f30XhWwr7Yzwvw1UO
   WOeBgcSdpQElezW7ar4P97Nk/Vs82KBsjP22V6lb+n13tXCX5HJzV9ORe
   w==;
X-CSE-ConnectionGUID: AkihVdAZTxKPBZKdc4uEAw==
X-CSE-MsgGUID: x/OFA4pcSnKd6QwcVeODqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="64213421"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="64213421"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 14:34:50 -0700
X-CSE-ConnectionGUID: A3QHESK3RPaGXklAy2QgGw==
X-CSE-MsgGUID: kL933jFHReOVCXS1RRYpaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="186276621"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 31 Oct 2025 14:34:48 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEwli-000NfG-24;
	Fri, 31 Oct 2025 21:34:46 +0000
Date: Sat, 01 Nov 2025 05:34:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 8371b2191db948a4c4094acc1b581bc39c018426
Message-ID: <202511010509.DWWY8Y1b-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 8371b2191db948a4c4094acc1b581bc39c018426  Merge branch 'pm-powercap' into bleeding-edge

elapsed time: 1545m

configs tested: 101
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251031    gcc-8.5.0
arc                   randconfig-002-20251031    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251031    gcc-14.3.0
arm                   randconfig-002-20251031    clang-22
arm                   randconfig-003-20251031    gcc-11.5.0
arm                   randconfig-004-20251031    clang-22
arm                         s5pv210_defconfig    gcc-15.1.0
arm                           sunxi_defconfig    gcc-15.1.0
arm                    vt8500_v6_v7_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251031    gcc-8.5.0
arm64                 randconfig-002-20251031    clang-22
arm64                 randconfig-003-20251031    gcc-10.5.0
arm64                 randconfig-004-20251031    gcc-14.3.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251031    gcc-9.5.0
csky                  randconfig-002-20251031    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251031    clang-22
hexagon               randconfig-002-20251031    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251101    clang-20
i386        buildonly-randconfig-002-20251101    gcc-13
i386        buildonly-randconfig-003-20251101    clang-20
i386        buildonly-randconfig-004-20251101    gcc-14
i386        buildonly-randconfig-005-20251101    clang-20
i386        buildonly-randconfig-006-20251101    clang-20
i386                  randconfig-001-20251101    clang-20
i386                  randconfig-002-20251101    gcc-14
i386                  randconfig-003-20251101    gcc-14
i386                  randconfig-004-20251101    clang-20
i386                  randconfig-005-20251101    clang-20
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251031    gcc-15.1.0
loongarch             randconfig-002-20251031    gcc-14.3.0
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20251031    gcc-9.5.0
nios2                 randconfig-002-20251031    gcc-11.5.0
openrisc                         alldefconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                  or1klitex_defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20251031    gcc-14.3.0
parisc                randconfig-002-20251031    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                       ppc64_defconfig    clang-22
powerpc               randconfig-001-20251031    clang-22
powerpc               randconfig-002-20251031    gcc-12.5.0
powerpc64             randconfig-001-20251031    clang-22
powerpc64             randconfig-002-20251031    gcc-10.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251031    gcc-8.5.0
riscv                 randconfig-002-20251031    clang-17
s390                              allnoconfig    clang-22
s390                          debug_defconfig    gcc-15.1.0
s390                  randconfig-001-20251031    clang-16
s390                  randconfig-002-20251031    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251031    gcc-14.3.0
sh                    randconfig-002-20251031    gcc-14.3.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251031    gcc-8.5.0
sparc                 randconfig-002-20251031    gcc-8.5.0
sparc64               randconfig-001-20251031    gcc-8.5.0
sparc64               randconfig-002-20251031    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                    randconfig-001-20251031    gcc-14
um                    randconfig-002-20251031    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251101    clang-20
x86_64      buildonly-randconfig-002-20251101    gcc-14
x86_64      buildonly-randconfig-003-20251101    gcc-13
x86_64      buildonly-randconfig-004-20251101    clang-20
x86_64      buildonly-randconfig-005-20251101    gcc-13
x86_64      buildonly-randconfig-006-20251101    clang-20
x86_64                randconfig-001-20251101    clang-20
x86_64                randconfig-011-20251101    clang-20
x86_64                randconfig-012-20251101    gcc-14
x86_64                randconfig-013-20251101    clang-20
x86_64                randconfig-014-20251101    gcc-14
x86_64                randconfig-015-20251101    clang-20
x86_64                randconfig-016-20251101    gcc-14
x86_64                randconfig-071-20251101    clang-20
x86_64                randconfig-072-20251101    clang-20
x86_64                randconfig-073-20251101    gcc-14
x86_64                randconfig-074-20251101    clang-20
x86_64                randconfig-075-20251101    clang-20
x86_64                randconfig-076-20251101    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251031    gcc-13.4.0
xtensa                randconfig-002-20251031    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

