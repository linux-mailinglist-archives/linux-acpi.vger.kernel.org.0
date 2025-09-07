Return-Path: <linux-acpi+bounces-16443-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27315B4794D
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Sep 2025 09:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1B41B21053
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Sep 2025 07:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8601E7C27;
	Sun,  7 Sep 2025 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGAgS8Dg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300AA2AE84;
	Sun,  7 Sep 2025 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757228909; cv=none; b=N3MbIqYl/hOqNzn/o5BHd8p1VGVEzzk0Ia0idv8lRegJJHUZmG2ajFA6WqWxOe2Z2zH/e21mho0gWYon4DFOzwSkb5cWdfSpw0BgYWCiyoeZZ4/uuI+UeIa6jYj03QRtDgFDa/8pNTzpy6Ogz6ISf47HBrnuomnS/AlCAh69gnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757228909; c=relaxed/simple;
	bh=BJjF7VDQQPI+Jufb+uiSemKybYIlgQjoRVG/ISASK1I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I5ivQUAydvkr85TcKtPLcjLrx9x1+467zcaVJDpLDj2GBxfxtGQhblBUgCW8BJM3rW7Fe5MNBKd8ZxgH+aVRkkNq9h0yPSBELawr6grtoXi61/wuUe61kFWDx4tqWx1yM30SXIjbN5zxypUM+ZMV7FUIgFLWBejUvSDv8FGaaAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGAgS8Dg; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757228907; x=1788764907;
  h=date:from:to:cc:subject:message-id;
  bh=BJjF7VDQQPI+Jufb+uiSemKybYIlgQjoRVG/ISASK1I=;
  b=YGAgS8Dg+STLctDsjs6qFK0dG6LgkUXzU+lxuckhbw/N5nOLEOQZzQp/
   +LYo7LYzQsY8bqrcBkH9GKVpDfHs9sPY8ihxCGHP7KHHDnO/z1E92dfO+
   qVVLKt1//qnrzXdAZ1R6ct6Cd4YWN/Sg8zAsdEQVoyc+cXK1zvQo/7U7U
   5ipN34dHZx9xezJj3NVZvYtf+AAd4+b4EJHQSn7VwmghZvESVdjxKHZiE
   cWAbWxmRgrdHOYEv75i1hQlB0SedO5GUClLTuJEgzogUJ30EACJGOP5m/
   JyiadR1Rj7cC8ig8DqVZOTyI8Rjb57zjwukDPwwZl+zi0jK1dnbMgnfMD
   Q==;
X-CSE-ConnectionGUID: H2uTn/6+RMCgbOapJMhGHg==
X-CSE-MsgGUID: ybI42J6PSw28QB18BpVTdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="59590398"
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="59590398"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 00:08:27 -0700
X-CSE-ConnectionGUID: cvAWKRu3QB2hkxMvCK6FQQ==
X-CSE-MsgGUID: 5RAO9g5aQSiv3FFiTYe1NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="172433175"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Sep 2025 00:08:25 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uv9Vf-00026F-0R;
	Sun, 07 Sep 2025 07:08:23 +0000
Date: Sun, 07 Sep 2025 15:07:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 db476aeee1c76dfcb4fceceaa301685b30c84849
Message-ID: <202509071533.NVvgm8Og-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: db476aeee1c76dfcb4fceceaa301685b30c84849  Merge branch 'acpi-processor' into bleeding-edge

elapsed time: 2044m

configs tested: 103
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250906    gcc-14.3.0
arc                   randconfig-002-20250906    gcc-10.5.0
arm                               allnoconfig    clang-22
arm                          gemini_defconfig    clang-20
arm                            hisi_defconfig    gcc-15.1.0
arm                   randconfig-001-20250906    clang-22
arm                   randconfig-002-20250906    clang-22
arm                   randconfig-003-20250906    gcc-13.4.0
arm                   randconfig-004-20250906    gcc-10.5.0
arm                           sama5_defconfig    gcc-15.1.0
arm                    vt8500_v6_v7_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250906    gcc-8.5.0
arm64                 randconfig-002-20250906    gcc-12.5.0
arm64                 randconfig-003-20250906    clang-22
arm64                 randconfig-004-20250906    gcc-9.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250906    gcc-15.1.0
csky                  randconfig-002-20250906    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250906    clang-20
hexagon               randconfig-002-20250906    clang-22
i386                             allmodconfig    gcc-13
i386                              allnoconfig    gcc-13
i386                             allyesconfig    gcc-13
i386        buildonly-randconfig-001-20250906    clang-20
i386        buildonly-randconfig-002-20250906    gcc-11
i386        buildonly-randconfig-003-20250906    gcc-13
i386        buildonly-randconfig-004-20250906    gcc-13
i386        buildonly-randconfig-005-20250906    clang-20
i386        buildonly-randconfig-006-20250906    clang-20
i386                                defconfig    clang-20
loongarch                        alldefconfig    clang-20
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250906    clang-22
loongarch             randconfig-002-20250906    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250906    gcc-11.5.0
nios2                 randconfig-002-20250906    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20250906    gcc-11.5.0
parisc                randconfig-002-20250906    gcc-8.5.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                       eiger_defconfig    clang-22
powerpc               randconfig-001-20250906    gcc-14.3.0
powerpc               randconfig-002-20250906    clang-20
powerpc               randconfig-003-20250906    clang-22
powerpc64             randconfig-001-20250906    gcc-13.4.0
powerpc64             randconfig-002-20250906    gcc-10.5.0
powerpc64             randconfig-003-20250906    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250906    gcc-13.4.0
riscv                 randconfig-002-20250906    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250906    gcc-10.5.0
s390                  randconfig-002-20250906    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                            migor_defconfig    gcc-15.1.0
sh                    randconfig-001-20250906    gcc-15.1.0
sh                    randconfig-002-20250906    gcc-12.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250906    gcc-8.5.0
sparc                 randconfig-002-20250906    gcc-13.4.0
sparc64               randconfig-001-20250906    clang-22
sparc64               randconfig-002-20250906    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-13
um                    randconfig-001-20250906    gcc-12
um                    randconfig-002-20250906    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250906    clang-20
x86_64      buildonly-randconfig-002-20250906    gcc-13
x86_64      buildonly-randconfig-003-20250906    gcc-13
x86_64      buildonly-randconfig-004-20250906    clang-20
x86_64      buildonly-randconfig-005-20250906    gcc-13
x86_64      buildonly-randconfig-006-20250906    gcc-13
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250906    gcc-12.5.0
xtensa                randconfig-002-20250906    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

