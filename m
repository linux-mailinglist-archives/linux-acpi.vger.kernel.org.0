Return-Path: <linux-acpi+bounces-7584-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C9A952293
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 21:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146B21F215B6
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 19:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4141BD018;
	Wed, 14 Aug 2024 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+80N21N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CE21B9B3B;
	Wed, 14 Aug 2024 19:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723663118; cv=none; b=UCb4Bfj8BMLAf1EeNC2WBuRPwMvexoLfkoWZsohp/QvHN8XXgGqRzzgt+B6bfrlwIILsa6gPqlWQcDrmMrCoR/jf9RuYQjI1yaBerSth1VY/cG6pQiZjJK87rcJPNtlZ2q1kkItMaEsrSFVQBpS4ATsRTtZ/yzFLZktg0uVSktY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723663118; c=relaxed/simple;
	bh=cQa6M2yYnKaPZN5mMN1d7akIILL1+8k8X8jgMt0zx1o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pXJ4BOO4ocijB7ANNloJtZ6Tdy32HZ6mVr+mTQRdmhQUG0C1eAefuShLcq9OdeIOsQzVL1Et1hZGKuvk/6FB/VH6zMFR5IWsGYddGyQd+vzKjnErnnHeUZy4OzUhWtE2XOyh+HVMX1+xvKDwfLNuYjbl10K/Nrj4mGxVk1wEnyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+80N21N; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723663116; x=1755199116;
  h=date:from:to:cc:subject:message-id;
  bh=cQa6M2yYnKaPZN5mMN1d7akIILL1+8k8X8jgMt0zx1o=;
  b=L+80N21N9kh9eHPn23qQ8BO1fPB7oIzENY3dyMH7xxBkgiJmoxZpcMce
   PeVFJnfGKLpHVOz5Cn6kg0dW5/Nb/7758BIgUUjyJFzaBd/FyaSNMptR8
   +FSOzHO+y6avTiTd4MSox2smwRWabxieH9YN21efQBDaLden7il9vE+hl
   tRg1mafS+3gRX0QjmHFHSIjpdtu7obD9EVmswG4P9Ezs7CLtufn55xGvJ
   n/sq55Ll+YTIb5S1kLKg02T6b2zpkEVoPd9xvUBnOGWKdOhA2EK5DKzDT
   93YVc5fhFkR+cVctfOoBZHsLkwKq0cP4vND7uWbk3czPMFfLpHV5Sv3jd
   A==;
X-CSE-ConnectionGUID: 9HF7uh71SfONu+ETNevyjg==
X-CSE-MsgGUID: A5IZUiGCTfqErDjhRdHV8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="22071118"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="22071118"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 12:18:36 -0700
X-CSE-ConnectionGUID: PAfo9a3ER+qy5z40IGWR1w==
X-CSE-MsgGUID: SaMHSnOuSlW36r9VpNRZGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="96618424"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 Aug 2024 12:18:34 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seJVw-0002l8-03;
	Wed, 14 Aug 2024 19:18:32 +0000
Date: Thu, 15 Aug 2024 03:17:45 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 6b6b6fb5ac6f22cb7858ab79e7d93106efaf72a6
Message-ID: <202408150342.gID3e3PA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 6b6b6fb5ac6f22cb7858ab79e7d93106efaf72a6  Merge branch 'thermal-core-testing' into bleeding-edge

elapsed time: 1447m

configs tested: 141
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240814   gcc-13.2.0
arc                   randconfig-002-20240814   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240814   clang-20
arm                   randconfig-002-20240814   clang-20
arm                   randconfig-003-20240814   clang-20
arm                   randconfig-004-20240814   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240814   clang-20
arm64                 randconfig-002-20240814   gcc-14.1.0
arm64                 randconfig-003-20240814   gcc-14.1.0
arm64                 randconfig-004-20240814   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240814   gcc-14.1.0
csky                  randconfig-002-20240814   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240814   clang-16
hexagon               randconfig-002-20240814   clang-14
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240814   clang-18
i386         buildonly-randconfig-002-20240814   clang-18
i386         buildonly-randconfig-003-20240814   clang-18
i386         buildonly-randconfig-004-20240814   clang-18
i386         buildonly-randconfig-005-20240814   gcc-12
i386         buildonly-randconfig-006-20240814   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240814   clang-18
i386                  randconfig-002-20240814   gcc-12
i386                  randconfig-003-20240814   gcc-12
i386                  randconfig-004-20240814   clang-18
i386                  randconfig-005-20240814   clang-18
i386                  randconfig-006-20240814   clang-18
i386                  randconfig-011-20240814   gcc-12
i386                  randconfig-012-20240814   gcc-12
i386                  randconfig-013-20240814   clang-18
i386                  randconfig-014-20240814   gcc-11
i386                  randconfig-015-20240814   gcc-12
i386                  randconfig-016-20240814   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240814   gcc-14.1.0
loongarch             randconfig-002-20240814   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240814   gcc-14.1.0
nios2                 randconfig-002-20240814   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240814   gcc-14.1.0
parisc                randconfig-002-20240814   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc               randconfig-002-20240814   clang-20
powerpc               randconfig-003-20240814   gcc-14.1.0
powerpc64             randconfig-001-20240814   clang-20
powerpc64             randconfig-002-20240814   clang-15
powerpc64             randconfig-003-20240814   clang-20
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240814   gcc-14.1.0
riscv                 randconfig-002-20240814   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240814   gcc-14.1.0
s390                  randconfig-002-20240814   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240814   gcc-14.1.0
sh                    randconfig-002-20240814   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240814   gcc-14.1.0
sparc64               randconfig-002-20240814   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240814   clang-20
um                    randconfig-002-20240814   clang-20
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240814   clang-18
x86_64       buildonly-randconfig-002-20240814   gcc-12
x86_64       buildonly-randconfig-003-20240814   clang-18
x86_64       buildonly-randconfig-004-20240814   clang-18
x86_64       buildonly-randconfig-005-20240814   gcc-12
x86_64       buildonly-randconfig-006-20240814   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240814   clang-18
x86_64                randconfig-002-20240814   gcc-12
x86_64                randconfig-003-20240814   gcc-11
x86_64                randconfig-004-20240814   gcc-12
x86_64                randconfig-005-20240814   gcc-12
x86_64                randconfig-006-20240814   gcc-12
x86_64                randconfig-011-20240814   clang-18
x86_64                randconfig-012-20240814   clang-18
x86_64                randconfig-013-20240814   gcc-11
x86_64                randconfig-014-20240814   clang-18
x86_64                randconfig-015-20240814   gcc-12
x86_64                randconfig-016-20240814   clang-18
x86_64                randconfig-071-20240814   clang-18
x86_64                randconfig-072-20240814   clang-18
x86_64                randconfig-073-20240814   clang-18
x86_64                randconfig-074-20240814   clang-18
x86_64                randconfig-075-20240814   gcc-12
x86_64                randconfig-076-20240814   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240814   gcc-14.1.0
xtensa                randconfig-002-20240814   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

