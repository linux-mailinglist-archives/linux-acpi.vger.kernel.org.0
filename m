Return-Path: <linux-acpi+bounces-10890-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F354A27125
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2025 13:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50F5165DC5
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2025 12:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B852139B2;
	Tue,  4 Feb 2025 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IteNKGQv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4E42135A4;
	Tue,  4 Feb 2025 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670761; cv=none; b=dUNYWPxoIeq+N0WBsqeZILZe5EbBh+eXoLy99AqZzFyBSGK5cLbIBB+6vfK3UUXIGYq3MNMF0vn6hKqrhYrcZO4BMd/V1GJdOkoDD2xf0k9MfnSQR+PHlD2psDQU8eSHKVkUbAjYXhBea1YPHUWW9OVcFKepcc+jpJgQqWOPMj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670761; c=relaxed/simple;
	bh=+mlDlSFap+IRotptjfd0Ogqpg8+z2hUHB8JoEgIKKes=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VOrxVZEq/p1xJDTizIwL3sp/vxnelaIZHXEEjj0VLUjkHUecBBVsO+iPy6BTojtbaeDAT+lgbpWCpoVfl2RGKz8pkENjXB+VYb4RmGYCxJG5Ap4070yYQ6xjsSlbqi+gdXpAOoZZkda2adBiN2eb6g1bGtZe14FGfO/MMgG11Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IteNKGQv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738670759; x=1770206759;
  h=date:from:to:cc:subject:message-id;
  bh=+mlDlSFap+IRotptjfd0Ogqpg8+z2hUHB8JoEgIKKes=;
  b=IteNKGQvAofqKzXFQH1eXeo5oTScGjFKUOfYKjxv8JXruZqjJ7Ut1H1T
   Pt/DYkqdxgaoZg+trQOCJtKTBmg+JGvPwjuLaV2Q/fr7Uu7n/CbkMDTY/
   9sBI4T/krB//OcWGbhlypOz1y3PcQlHMW8irPowSqobbqNTtJbjoXbVne
   A+ZWKWxz1ZSnojCVs0baHWd8VJpIz3Zce4J3bvM3yHPa994EgYinAo9n2
   a8UKvbF8TS+eo9ytMNJjPeEXDpOrFW9VDKdqyHso99tN6YOB6R4I5yIsM
   kpzF5PvcqkewTWTiK5cNcHzzUyu2prcvRI0DVlVB1qyVZoNkIRbSQWNl6
   Q==;
X-CSE-ConnectionGUID: q+7yKB86S+WFKebHRbeXSQ==
X-CSE-MsgGUID: OF6mEqNRTwWCOsmKkc9bEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="38424853"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="38424853"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 04:05:58 -0800
X-CSE-ConnectionGUID: nFs/650AS0GIkM1AZVyR3w==
X-CSE-MsgGUID: OztBh4lQQTmN4U6eu2oHQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147783249"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 04 Feb 2025 04:05:56 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tfHgg-000sRb-05;
	Tue, 04 Feb 2025 12:05:54 +0000
Date: Tue, 04 Feb 2025 20:05:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 d3b6770a597174f4bcc9d9d8fbdfbccca2180121
Message-ID: <202502042053.Pl7eVSRC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: d3b6770a597174f4bcc9d9d8fbdfbccca2180121  Merge branch 'pm-powercap' into fixes

elapsed time: 1381m

configs tested: 207
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250204    gcc-13.2.0
arc                   randconfig-002-20250204    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    clang-21
arm                       netwinder_defconfig    clang-21
arm                         nhk8815_defconfig    clang-21
arm                   randconfig-001-20250204    clang-21
arm                   randconfig-001-20250204    gcc-13.2.0
arm                   randconfig-002-20250204    clang-17
arm                   randconfig-002-20250204    gcc-13.2.0
arm                   randconfig-003-20250204    clang-19
arm                   randconfig-003-20250204    gcc-13.2.0
arm                   randconfig-004-20250204    clang-21
arm                   randconfig-004-20250204    gcc-13.2.0
arm                         vf610m4_defconfig    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250204    clang-21
arm64                 randconfig-001-20250204    gcc-13.2.0
arm64                 randconfig-002-20250204    clang-21
arm64                 randconfig-002-20250204    gcc-13.2.0
arm64                 randconfig-003-20250204    clang-17
arm64                 randconfig-003-20250204    gcc-13.2.0
arm64                 randconfig-004-20250204    clang-21
arm64                 randconfig-004-20250204    gcc-13.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250204    gcc-14.2.0
csky                  randconfig-002-20250204    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250204    clang-21
hexagon               randconfig-001-20250204    gcc-14.2.0
hexagon               randconfig-002-20250204    clang-21
hexagon               randconfig-002-20250204    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250203    gcc-12
i386        buildonly-randconfig-001-20250204    gcc-12
i386        buildonly-randconfig-002-20250203    gcc-12
i386        buildonly-randconfig-002-20250204    gcc-12
i386        buildonly-randconfig-003-20250203    clang-19
i386        buildonly-randconfig-003-20250204    gcc-12
i386        buildonly-randconfig-004-20250203    gcc-12
i386        buildonly-randconfig-004-20250204    gcc-12
i386        buildonly-randconfig-005-20250203    clang-19
i386        buildonly-randconfig-005-20250204    gcc-12
i386        buildonly-randconfig-006-20250203    gcc-12
i386        buildonly-randconfig-006-20250204    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250204    clang-19
i386                  randconfig-002-20250204    clang-19
i386                  randconfig-003-20250204    clang-19
i386                  randconfig-004-20250204    clang-19
i386                  randconfig-005-20250204    clang-19
i386                  randconfig-006-20250204    clang-19
i386                  randconfig-007-20250204    clang-19
i386                  randconfig-011-20250204    clang-19
i386                  randconfig-012-20250204    clang-19
i386                  randconfig-013-20250204    clang-19
i386                  randconfig-014-20250204    clang-19
i386                  randconfig-015-20250204    clang-19
i386                  randconfig-016-20250204    clang-19
i386                  randconfig-017-20250204    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250204    gcc-14.2.0
loongarch             randconfig-002-20250204    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          multi_defconfig    clang-21
m68k                        mvme16x_defconfig    clang-21
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip32_defconfig    clang-21
mips                        omega2p_defconfig    clang-16
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250204    gcc-14.2.0
nios2                 randconfig-002-20250204    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250204    gcc-14.2.0
parisc                randconfig-002-20250204    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    clang-21
powerpc                     kmeter1_defconfig    clang-21
powerpc               mpc834x_itxgp_defconfig    clang-21
powerpc                 mpc837x_rdb_defconfig    clang-21
powerpc                      pasemi_defconfig    clang-21
powerpc               randconfig-001-20250204    gcc-14.2.0
powerpc               randconfig-002-20250204    gcc-14.2.0
powerpc               randconfig-003-20250204    clang-21
powerpc               randconfig-003-20250204    gcc-14.2.0
powerpc64             randconfig-002-20250204    clang-19
powerpc64             randconfig-002-20250204    gcc-14.2.0
powerpc64             randconfig-003-20250204    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    clang-15
riscv                 randconfig-001-20250204    gcc-14.2.0
riscv                 randconfig-002-20250204    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250204    gcc-14.2.0
s390                  randconfig-002-20250204    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250204    gcc-14.2.0
sh                    randconfig-002-20250204    gcc-14.2.0
sh                           se7750_defconfig    clang-21
sh                        sh7785lcr_defconfig    gcc-14.2.0
sh                          urquell_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250204    gcc-14.2.0
sparc                 randconfig-002-20250204    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250204    gcc-14.2.0
sparc64               randconfig-002-20250204    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                                allnoconfig    clang-21
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250204    clang-21
um                    randconfig-001-20250204    gcc-14.2.0
um                    randconfig-002-20250204    gcc-12
um                    randconfig-002-20250204    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250203    clang-19
x86_64      buildonly-randconfig-001-20250204    clang-19
x86_64      buildonly-randconfig-002-20250203    gcc-12
x86_64      buildonly-randconfig-002-20250204    clang-19
x86_64      buildonly-randconfig-003-20250203    gcc-12
x86_64      buildonly-randconfig-003-20250204    clang-19
x86_64      buildonly-randconfig-004-20250203    clang-19
x86_64      buildonly-randconfig-004-20250204    clang-19
x86_64      buildonly-randconfig-005-20250203    gcc-12
x86_64      buildonly-randconfig-005-20250204    clang-19
x86_64      buildonly-randconfig-006-20250203    gcc-12
x86_64      buildonly-randconfig-006-20250204    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-071-20250204    gcc-12
x86_64                randconfig-072-20250204    gcc-12
x86_64                randconfig-073-20250204    gcc-12
x86_64                randconfig-074-20250204    gcc-12
x86_64                randconfig-075-20250204    gcc-12
x86_64                randconfig-076-20250204    gcc-12
x86_64                randconfig-077-20250204    gcc-12
x86_64                randconfig-078-20250204    gcc-12
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    clang-21
xtensa                randconfig-001-20250204    gcc-14.2.0
xtensa                randconfig-002-20250204    gcc-14.2.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

