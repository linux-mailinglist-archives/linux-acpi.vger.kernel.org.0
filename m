Return-Path: <linux-acpi+bounces-15840-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32603B2C9EC
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 18:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE0EA019D2
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 16:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55D227B34A;
	Tue, 19 Aug 2025 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqBpsAwg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDAD257821;
	Tue, 19 Aug 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621742; cv=none; b=sAPAM1xrhKOkb/liLpDQcq/jD5CoyaaJU2x5lNEcCS4O0QQUK8JiAzig8N4v0iNWQFO82KA4KP5vYUoCxqUT1fpO1y1JKFhcAj6tVu0jZsYPE0rblb7lZL+V6youHkWhE39wsah2ZOYEKHa6dmmsseFWRYK2BKwwNIjMR5eZ2Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621742; c=relaxed/simple;
	bh=F5dsofOOavRZPRSjUpJQmYbjNq7HP7xst+SCUy+4g00=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DKv1zZMnSNOULMciVl3N3Q7OaLd6x2mSe8t4Ato7FMCUfZCnMSuKr6JxXxUvq2FZWyKDSrh7MO0B7IgU8s3I86HQD7VACPCGBhkiK6tmcpimcm+kg89tPR9Jnp2oWcZlSNRof+vdrO8MpVRgTj9PO9S7D1B3VVyuhulxpKpcdXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqBpsAwg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755621741; x=1787157741;
  h=date:from:to:cc:subject:message-id;
  bh=F5dsofOOavRZPRSjUpJQmYbjNq7HP7xst+SCUy+4g00=;
  b=lqBpsAwgGycvdyAv/yckcJUP63dElFguHTHJ/Fn8mAWmhgD4wEnpt+I3
   XxuL+x9DlqaPvwI/YvWryj1lpLCFvxMN87LihutbopcsBF+gMfaBAybgv
   TCI+IwmxOq6mX8RLE6hMSdd4jLmaDE8Gwe9G79NoQbwx4dKDQbkwhvt01
   UU41C6Njg05xh607dJ6hIr+tfc4IRZITd8p1xFFuQsi+A/kJ58s4jOAFX
   QBBuqaSqAx8xTUEHgEA2NMk5hRI/85jATmku/yhuWwl2UsL/BHR3jCE0G
   ddJMeqtOsybSzyY3u65mWXhn+EEVJHcByxKC/jtcjELJumHo1DfLysW8g
   A==;
X-CSE-ConnectionGUID: r3odsAMWRiaeuKdTplNtJw==
X-CSE-MsgGUID: EGB406QCTK+I585HYQMRGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61683273"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="61683273"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 09:42:20 -0700
X-CSE-ConnectionGUID: BgkOW/5HTaO101uDSH9Ckg==
X-CSE-MsgGUID: VQ6ztoqMSGmo4yvwb//J6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167858359"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 19 Aug 2025 09:42:19 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoPPc-000H8l-2N;
	Tue, 19 Aug 2025 16:42:16 +0000
Date: Wed, 20 Aug 2025 00:41:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 55ce7d7973229a41cadcb4b92aa6e99ffda506cf
Message-ID: <202508200009.KC7KYOde-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 55ce7d7973229a41cadcb4b92aa6e99ffda506cf  Merge branch 'pm-cpuidle' into fixes

elapsed time: 1410m

configs tested: 129
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250819    gcc-14.3.0
arc                   randconfig-002-20250819    gcc-11.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250819    gcc-12.5.0
arm                   randconfig-002-20250819    gcc-10.5.0
arm                   randconfig-003-20250819    gcc-10.5.0
arm                   randconfig-004-20250819    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250819    gcc-14.3.0
arm64                 randconfig-002-20250819    clang-22
arm64                 randconfig-003-20250819    gcc-8.5.0
arm64                 randconfig-004-20250819    clang-16
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250819    gcc-15.1.0
csky                  randconfig-002-20250819    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250819    clang-22
hexagon               randconfig-002-20250819    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250819    gcc-12
i386        buildonly-randconfig-002-20250819    clang-20
i386        buildonly-randconfig-003-20250819    clang-20
i386        buildonly-randconfig-004-20250819    clang-20
i386        buildonly-randconfig-005-20250819    clang-20
i386        buildonly-randconfig-006-20250819    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250819    gcc-15.1.0
loongarch             randconfig-002-20250819    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                           sun3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250819    gcc-8.5.0
nios2                 randconfig-002-20250819    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250819    gcc-10.5.0
parisc                randconfig-002-20250819    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                     akebono_defconfig    clang-22
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc               randconfig-001-20250819    clang-22
powerpc               randconfig-002-20250819    gcc-10.5.0
powerpc               randconfig-003-20250819    clang-22
powerpc                     stx_gp3_defconfig    gcc-15.1.0
powerpc                     tqm8541_defconfig    clang-22
powerpc64             randconfig-001-20250819    clang-22
powerpc64             randconfig-002-20250819    clang-22
powerpc64             randconfig-003-20250819    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250819    clang-22
riscv                 randconfig-002-20250819    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250819    gcc-8.5.0
s390                  randconfig-002-20250819    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250819    gcc-15.1.0
sh                    randconfig-002-20250819    gcc-15.1.0
sh                        sh7785lcr_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250819    gcc-8.5.0
sparc                 randconfig-002-20250819    gcc-11.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250819    clang-22
sparc64               randconfig-002-20250819    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250819    clang-18
um                    randconfig-002-20250819    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250819    clang-20
x86_64      buildonly-randconfig-002-20250819    clang-20
x86_64      buildonly-randconfig-003-20250819    clang-20
x86_64      buildonly-randconfig-004-20250819    clang-20
x86_64      buildonly-randconfig-005-20250819    clang-20
x86_64      buildonly-randconfig-006-20250819    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250819    gcc-8.5.0
xtensa                randconfig-002-20250819    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

