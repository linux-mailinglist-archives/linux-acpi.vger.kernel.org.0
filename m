Return-Path: <linux-acpi+bounces-14890-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DCFAF0573
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 23:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B63D48033E
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 21:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6DD302055;
	Tue,  1 Jul 2025 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/83Ej8x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2591427F166;
	Tue,  1 Jul 2025 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404102; cv=none; b=r0Vot/Tsbt5f243oleFovNmu32fBWaCUyMxbSktZ4TA5jcggWZ+volq/cbXHjVmvsH72k19hel+eGoOzO51QEr9EPK6jmyrzPXKxoMBlcBEl1lrpr8eEbPMi1GBjWEeFuWYxXSYGBclxM5adzOz30EHm5JJzWfh2mpEzrgsahrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404102; c=relaxed/simple;
	bh=7G+jbXgl5YVxWYdBOuIOYBo+nDmZIN7ZkXNpl4Smf14=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OviqsBcBBpkJjDRn3mgDQo4rdINNX1OYg7sFbhgiXwukgcWPZqRfeQ5476zOfjFt7ERlCQK9NtYtLSLpw0g+JZZk037jficRIlSGGkBZnNyPYMdwMbt88IUfiRWjnl/KnZ5qpXUtCBvXQex8t8kjnl2qZ4tbGzPKxF+6i8UWiCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/83Ej8x; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751404102; x=1782940102;
  h=date:from:to:cc:subject:message-id;
  bh=7G+jbXgl5YVxWYdBOuIOYBo+nDmZIN7ZkXNpl4Smf14=;
  b=H/83Ej8xA9kuMGrKiEg9Hk2IMBvDOx+2NxuIs2rfecrYVD6cqUhDN3To
   6FOPl8MydQzXpptdzAO48yFNeuqseHbZycyJsT6a0/ErxSMbQ5G2pTLcu
   SuZ6ViUV7bAgInsVpyjgdzLj5a2vdSk8/9hTmCydB6RX9/gFXdbPJYVQ8
   +b9a1g9djj95nh9wGA8dCbMidclD98Bv/9vHd1aMbKqMeDPsdjIsum2Be
   wEa6Btq/y2znqsHKAqEZHEl4uLhG6ca87lv+c3iKN9BWE85jlN9ZIcX1w
   jwsvKNbktv5XoUeSycAPETOwOfzhhLQCQaLuc7FWObFOmVQoLvjuqw4LG
   A==;
X-CSE-ConnectionGUID: kMKvquFOQ0WSfAoTTj81sQ==
X-CSE-MsgGUID: TrY1XBUBRwGlR1KYyeexCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="65142811"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="65142811"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 14:08:19 -0700
X-CSE-ConnectionGUID: 35o5nLuwRhaMueTjIuSLcw==
X-CSE-MsgGUID: xA4+9conSnqr1TT5Pia5Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="158252699"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 01 Jul 2025 14:08:17 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWiD9-000aem-0o;
	Tue, 01 Jul 2025 21:08:15 +0000
Date: Wed, 02 Jul 2025 05:07:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 3ef1f3359bdbb7d0d8cd8f1c29ce7218570108b7
Message-ID: <202507020504.mlyLlk3V-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3ef1f3359bdbb7d0d8cd8f1c29ce7218570108b7  Merge branch 'acpi-pfrut' into bleeding-edge

elapsed time: 1451m

configs tested: 114
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250701    gcc-13.3.0
arc                   randconfig-002-20250701    gcc-15.1.0
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                        multi_v7_defconfig    gcc-15.1.0
arm                   randconfig-001-20250701    clang-17
arm                   randconfig-002-20250701    gcc-8.5.0
arm                   randconfig-003-20250701    clang-21
arm                   randconfig-004-20250701    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250701    clang-21
arm64                 randconfig-002-20250701    gcc-15.1.0
arm64                 randconfig-003-20250701    clang-18
arm64                 randconfig-004-20250701    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250701    gcc-11.5.0
csky                  randconfig-002-20250701    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250701    clang-21
hexagon               randconfig-002-20250701    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250701    gcc-12
i386        buildonly-randconfig-002-20250701    gcc-12
i386        buildonly-randconfig-003-20250701    gcc-12
i386        buildonly-randconfig-004-20250701    gcc-12
i386        buildonly-randconfig-005-20250701    gcc-12
i386        buildonly-randconfig-006-20250701    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250701    gcc-13.3.0
loongarch             randconfig-002-20250701    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
m68k                           virt_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq6_defconfig    clang-21
mips                         rt305x_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250701    gcc-14.2.0
nios2                 randconfig-002-20250701    gcc-13.3.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20250701    gcc-14.3.0
parisc                randconfig-002-20250701    gcc-10.5.0
parisc64                         alldefconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                       ebony_defconfig    clang-21
powerpc               randconfig-001-20250701    gcc-13.3.0
powerpc               randconfig-002-20250701    clang-21
powerpc               randconfig-003-20250701    clang-21
powerpc64             randconfig-001-20250701    clang-21
powerpc64             randconfig-002-20250701    clang-21
powerpc64             randconfig-003-20250701    gcc-10.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250701    gcc-14.3.0
riscv                 randconfig-002-20250701    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250701    gcc-9.3.0
s390                  randconfig-002-20250701    clang-17
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                         ecovec24_defconfig    gcc-15.1.0
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20250701    gcc-15.1.0
sh                    randconfig-002-20250701    gcc-13.3.0
sh                           se7722_defconfig    gcc-15.1.0
sh                   secureedge5410_defconfig    gcc-15.1.0
sh                        sh7757lcr_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250701    gcc-10.3.0
sparc                 randconfig-002-20250701    gcc-15.1.0
sparc64               randconfig-001-20250701    gcc-8.5.0
sparc64               randconfig-002-20250701    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250701    gcc-12
um                    randconfig-002-20250701    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250701    gcc-12
x86_64      buildonly-randconfig-002-20250701    gcc-12
x86_64      buildonly-randconfig-003-20250701    gcc-12
x86_64      buildonly-randconfig-004-20250701    gcc-12
x86_64      buildonly-randconfig-005-20250701    clang-20
x86_64      buildonly-randconfig-006-20250701    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250701    gcc-15.1.0
xtensa                randconfig-002-20250701    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

