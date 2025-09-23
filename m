Return-Path: <linux-acpi+bounces-17224-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9112B9564D
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 12:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7F43B036D
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 10:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C89E2F39DE;
	Tue, 23 Sep 2025 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iK2zGZPh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178E2126C1E;
	Tue, 23 Sep 2025 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622160; cv=none; b=AEQpQYegX7+UhRddGqAKuKTZFX/4qTM3OahBmP5AB4KnRMy2vDFN9zuORBFuqV/sobPa3Xi+NG3JJYzNaedhmd9RzEEOyaQY37RolcjYptChocrCwrUH/PDn+RQLapzhxz6yNCWKg4yNysZ3isn1Nm8LJM+jflEP1bgd0V0d57s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622160; c=relaxed/simple;
	bh=By24cDvoCKBbaeghtkUg6yoVPPfT2pRTl02bn/ctE4U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=c0YPsjHrr00NEFQ8Bh7M85k6tzX7N72Hj16CVo0+8HEImYWZISB5kCd+mwBI4goQK8eLypoDpI3OnZdlle7M/VEjFbwUSNZ8xfXLQXRA6XWOs99YZWuFU4xH5xNKTa8iHlcCMQCxY17Yu13qm1BOCrEAstg1ygxkEnODGgPDqlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iK2zGZPh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758622159; x=1790158159;
  h=date:from:to:cc:subject:message-id;
  bh=By24cDvoCKBbaeghtkUg6yoVPPfT2pRTl02bn/ctE4U=;
  b=iK2zGZPhaFGnlZ0196hEmajmtFu/+MPNwSIPISRR470NWjQ8JZNer4TW
   n33XziAutye9KXQa3NS6Fc2/OnJtoLGC86vDCi0ZseQps2+36lSyQe0+t
   4GGczx0GkR4iT9WI3kBYdNzo81IpmWyRDi0/3Qa+ReY3Xv+WQXIVyT6kg
   F9JTkadda8D2CTkKepvOSw3rXn8SK4TT6P4szPpHLQmbVsbev/Xls+jJS
   e9biA+cikVGntECg6s9VsnhAbcezF7VrfhtfAM3E049ifW/IYMNIscQnM
   vxMd3smo3P60KzwjkuMJwDwHpwpo7jdjoKoVRxEXrIpgks0CLNp2sRKCX
   w==;
X-CSE-ConnectionGUID: kzVN0ytDTZKV2hnep3iNXg==
X-CSE-MsgGUID: 9TsVhPEmQZqi4zLxda3XGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="72322205"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="72322205"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 03:09:18 -0700
X-CSE-ConnectionGUID: 2C5jz7BbRzazfXIZvtzI1w==
X-CSE-MsgGUID: oh8uZemZQPmUZYUFgduHYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="176807779"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 23 Sep 2025 03:09:17 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0zxS-00030D-2e;
	Tue, 23 Sep 2025 10:09:14 +0000
Date: Tue, 23 Sep 2025 18:09:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 f8254bbe1a14f6a603eb88ff81af41a38c363aab
Message-ID: <202509231844.JBb2MP2M-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: f8254bbe1a14f6a603eb88ff81af41a38c363aab  Merge branch 'acpi-x86' into bleeding-edge

elapsed time: 901m

configs tested: 119
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250923    gcc-12.5.0
arc                   randconfig-002-20250923    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250923    gcc-12.5.0
arm                   randconfig-002-20250923    clang-17
arm                   randconfig-003-20250923    gcc-8.5.0
arm                   randconfig-004-20250923    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250923    gcc-8.5.0
arm64                 randconfig-002-20250923    clang-18
arm64                 randconfig-003-20250923    gcc-8.5.0
arm64                 randconfig-004-20250923    gcc-11.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250923    gcc-9.5.0
csky                  randconfig-002-20250923    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250923    clang-22
hexagon               randconfig-002-20250923    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250923    gcc-14
i386        buildonly-randconfig-002-20250923    clang-20
i386        buildonly-randconfig-003-20250923    clang-20
i386        buildonly-randconfig-004-20250923    gcc-14
i386        buildonly-randconfig-005-20250923    clang-20
i386        buildonly-randconfig-006-20250923    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250923    gcc-15.1.0
loongarch             randconfig-002-20250923    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq5_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250923    gcc-11.5.0
nios2                 randconfig-002-20250923    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250923    gcc-15.1.0
parisc                randconfig-002-20250923    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                  iss476-smp_defconfig    gcc-15.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250923    gcc-8.5.0
powerpc               randconfig-002-20250923    clang-16
powerpc               randconfig-003-20250923    gcc-12.5.0
powerpc                        warp_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250923    gcc-10.5.0
powerpc64             randconfig-002-20250923    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250923    gcc-12.5.0
riscv                 randconfig-002-20250923    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250923    gcc-8.5.0
s390                  randconfig-002-20250923    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250923    gcc-15.1.0
sh                    randconfig-002-20250923    gcc-10.5.0
sh                          rsk7201_defconfig    gcc-15.1.0
sh                          sdk7786_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250923    gcc-8.5.0
sparc                 randconfig-002-20250923    gcc-12.5.0
sparc64               randconfig-001-20250923    clang-22
sparc64               randconfig-002-20250923    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250923    clang-22
um                    randconfig-002-20250923    clang-22
x86_64                           alldefconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250923    gcc-14
x86_64      buildonly-randconfig-002-20250923    gcc-14
x86_64      buildonly-randconfig-003-20250923    gcc-14
x86_64      buildonly-randconfig-004-20250923    clang-20
x86_64      buildonly-randconfig-005-20250923    clang-20
x86_64      buildonly-randconfig-006-20250923    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250923    gcc-8.5.0
xtensa                randconfig-002-20250923    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

