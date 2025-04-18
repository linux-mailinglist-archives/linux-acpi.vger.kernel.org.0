Return-Path: <linux-acpi+bounces-13115-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04DBA93B41
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Apr 2025 18:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62B1461343
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Apr 2025 16:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55866213E97;
	Fri, 18 Apr 2025 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UBOXX46r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1BE2CCC0;
	Fri, 18 Apr 2025 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994993; cv=none; b=u6+yavhJNiKV0nFo3uK8OLCix7c9dwityi37+57t01X6kSpxgDWgiD0r3d/xWZ7dj850SEcYic0UucFiGKCzfvBp22O41KCKg/FG9sOe3bzEwCNC9ggMtoIYOQa/jfoH6tu/QJ/UBN1CdfYOPkI7wjqOpeyX0k+HD2JauOBzKmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994993; c=relaxed/simple;
	bh=FnN/iTbHvUnR4i7t8MuoF+yhBm71k9OCNEaLyoiHsGc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EZziassExzXom/eX/4SLQcDPIccfL3Fp9ly25PPYZaotmMyO6gIX6E7w7DQoWP6YLkQ7q/F/KwhOW/fqScpnttu7ogHo4BAtD1Dcw+peYJmcdjlWR8BoleqqXspVvwZNsdCOiiw5ulf+XUZFIycx2dJEYafB5vdW5v3TOSDJCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UBOXX46r; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744994992; x=1776530992;
  h=date:from:to:cc:subject:message-id;
  bh=FnN/iTbHvUnR4i7t8MuoF+yhBm71k9OCNEaLyoiHsGc=;
  b=UBOXX46rJ0HXiENRUMC1+fbfdHjv/4F95sWYtyc9Wg76MlbdeAq5ppqv
   NwwRjEWwfRtZ264SsciZQMQIFCF6/jxGDob2exnxvgw4affxT5yPSNzWR
   0sSdq4ls7+jjAoj6COOVomGjvSrIL7Po29Wo9ZVm3bgq3QrNvGHCN7mBr
   RbetogwBKmzfXMmb8BB+amhR1F60At0DKdRpPPXDm7cYEz4AkOAWuy0/I
   t7IUoGLPXzOc393ByXZSVP3PztkjV7LWKGtxfkZb9LLO2o6qNCxXbXWZx
   m7RKpGv0ikHRxhT2MYoAtEjCQ2UX3OsEkybilrszoJXiU2d4TUKul+qOi
   Q==;
X-CSE-ConnectionGUID: D3Vq3qtERYSjw/6TVDD+7g==
X-CSE-MsgGUID: 7xpcXAI7QIGwzPINH2gQXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="50455660"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="50455660"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:49:51 -0700
X-CSE-ConnectionGUID: cNnSyXrkS9GNyTN4vFdtbQ==
X-CSE-MsgGUID: 0hHfpKZyTGSHSsPlD0A7Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="130894861"
Received: from lkp-server01.sh.intel.com (HELO 61e10e65ea0f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 18 Apr 2025 09:49:49 -0700
Received: from kbuild by 61e10e65ea0f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u5ouR-00035B-0I;
	Fri, 18 Apr 2025 16:49:47 +0000
Date: Sat, 19 Apr 2025 00:49:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 2552b687f27ff857ddf0fbb8f44255908e7f85b9
Message-ID: <202504190007.wGInGYng-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 2552b687f27ff857ddf0fbb8f44255908e7f85b9  Merge branch 'pm-sleep-testing' into bleeding-edge

elapsed time: 1454m

configs tested: 88
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250418    gcc-14.2.0
arc                   randconfig-002-20250418    gcc-12.4.0
arm                   randconfig-001-20250418    gcc-8.5.0
arm                   randconfig-002-20250418    gcc-7.5.0
arm                   randconfig-003-20250418    gcc-8.5.0
arm                   randconfig-004-20250418    clang-21
arm64                 randconfig-001-20250418    clang-21
arm64                 randconfig-002-20250418    clang-21
arm64                 randconfig-003-20250418    clang-21
arm64                 randconfig-004-20250418    gcc-6.5.0
csky                  randconfig-001-20250418    gcc-14.2.0
csky                  randconfig-002-20250418    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250418    clang-21
hexagon               randconfig-002-20250418    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250418    clang-20
i386        buildonly-randconfig-002-20250418    gcc-12
i386        buildonly-randconfig-003-20250418    clang-20
i386        buildonly-randconfig-004-20250418    gcc-12
i386        buildonly-randconfig-005-20250418    gcc-11
i386        buildonly-randconfig-006-20250418    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20250418    gcc-14.2.0
loongarch             randconfig-002-20250418    gcc-12.4.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250418    gcc-10.5.0
nios2                 randconfig-002-20250418    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250418    gcc-11.5.0
parisc                randconfig-002-20250418    gcc-13.3.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250418    gcc-8.5.0
powerpc               randconfig-002-20250418    gcc-6.5.0
powerpc               randconfig-003-20250418    clang-21
powerpc64             randconfig-001-20250418    clang-21
powerpc64             randconfig-002-20250418    clang-21
powerpc64             randconfig-003-20250418    clang-17
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250418    clang-21
riscv                 randconfig-002-20250418    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250418    gcc-7.5.0
s390                  randconfig-002-20250418    gcc-6.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250418    gcc-12.4.0
sh                    randconfig-002-20250418    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250418    gcc-10.3.0
sparc                 randconfig-002-20250418    gcc-7.5.0
sparc64               randconfig-001-20250418    gcc-9.3.0
sparc64               randconfig-002-20250418    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250418    clang-21
um                    randconfig-002-20250418    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250418    clang-20
x86_64      buildonly-randconfig-002-20250418    clang-20
x86_64      buildonly-randconfig-003-20250418    clang-20
x86_64      buildonly-randconfig-004-20250418    clang-20
x86_64      buildonly-randconfig-005-20250418    clang-20
x86_64      buildonly-randconfig-006-20250418    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250418    gcc-7.5.0
xtensa                randconfig-002-20250418    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

