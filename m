Return-Path: <linux-acpi+bounces-19305-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D03C8D614
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 09:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824B83AEEE3
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 08:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB48331ED83;
	Thu, 27 Nov 2025 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Onn6ddKg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE44F27FD40;
	Thu, 27 Nov 2025 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764232863; cv=none; b=f4aDdROJW27uZE36sqPsQ+yRD40fdT/xyEYXo7CzUq8xOByfWE4Ri0UugvE4IlUM8TUsB5AtfQgxgBUMJarUQGEY4l2vBKuqWbt7eJjQU1AAt2W1/14hR57ubrLKyATgJaif+lsbwb50ZK/NEwPFdEkLyHwj7dd4jXQEkOSLesg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764232863; c=relaxed/simple;
	bh=no70wW7/i7eIpN6AOpshfb0j9DnumnLSUX5yx6QFFyY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HaGf4Ky4ITFUmgSQKwY+/xqai0wARVnRsEG+8Sux98Vcdnexl7YTbCZh2Fi+mx9XnS/1AkXu1FVedA42ULiJ7FV6jPHxIeLCf5+MMoTeCNU0jfy6yf+MyHgz7O03KVVedQ6tBOlRQ6GdIcw4U61ktIfm9Vns7g7SwwARbpKxgrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Onn6ddKg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764232862; x=1795768862;
  h=date:from:to:cc:subject:message-id;
  bh=no70wW7/i7eIpN6AOpshfb0j9DnumnLSUX5yx6QFFyY=;
  b=Onn6ddKgd+yYyuWMWvNb3tvVBz1Qs57bVjv6YIapwJV+CQwMBeveOAk4
   fVFVOY8FzuL3GisoZ4diz806z/XreexgQR3/hrw+X7bYVFJgBaMMOdl6Q
   m3O2xzpiXAVIKVZ2UZjQsuxTZtQZrGT7Hbbnoog6TLhKRVMFZjb12VErS
   SZCYS1OKCfysS8GKtuwIyhZ8HVEUdFIvkL4RelUx2OximtrVWy6XOabbL
   19JMSa4UBeZVImltNQwfWRBaVkGjGn5jdAY4ueO1gPExLbmLeA5LdgLyY
   kkKzxp3K4wuMt0mBXGd0O655lobI7ts02xwgZMzpjvgP0BkWOOLNviG0B
   w==;
X-CSE-ConnectionGUID: rfQ0p7tQTjSFA53UeBRUPA==
X-CSE-MsgGUID: pK6CHMreQ2KvHms7X0cDrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="76905416"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="76905416"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 00:41:01 -0800
X-CSE-ConnectionGUID: WVn0awOvREeMRDIObOgiBA==
X-CSE-MsgGUID: Uwz7ps/sQtiDeZxnrnj1Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="223879832"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 27 Nov 2025 00:40:59 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOXYf-000000003yS-1ZMf;
	Thu, 27 Nov 2025 08:40:57 +0000
Date: Thu, 27 Nov 2025 16:40:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 f06ad625deff6c704a9d9ff8d003a880ec5d380f
Message-ID: <202511271620.b1LNRIpS-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: f06ad625deff6c704a9d9ff8d003a880ec5d380f  Merge branch 'acpi-processor-fixes' into fixes

elapsed time: 2440m

configs tested: 155
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                   randconfig-001-20251126    gcc-13.4.0
arc                   randconfig-001-20251127    clang-22
arc                   randconfig-002-20251126    gcc-11.5.0
arc                   randconfig-002-20251127    clang-22
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                      integrator_defconfig    clang-22
arm                   randconfig-001-20251126    clang-22
arm                   randconfig-001-20251127    clang-22
arm                   randconfig-002-20251126    clang-22
arm                   randconfig-002-20251127    clang-22
arm                   randconfig-003-20251126    clang-19
arm                   randconfig-003-20251127    clang-22
arm                   randconfig-004-20251126    clang-22
arm                   randconfig-004-20251127    clang-22
arm                         s3c6400_defconfig    clang-22
arm64                            allmodconfig    clang-16
arm64                             allnoconfig    gcc-15.1.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon               randconfig-001-20251126    clang-22
hexagon               randconfig-002-20251126    clang-22
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386        buildonly-randconfig-001-20251127    clang-20
i386        buildonly-randconfig-002-20251127    clang-20
i386        buildonly-randconfig-003-20251127    clang-20
i386        buildonly-randconfig-004-20251127    clang-20
i386        buildonly-randconfig-005-20251127    clang-20
i386        buildonly-randconfig-006-20251127    clang-20
i386                  randconfig-011-20251127    clang-20
i386                  randconfig-012-20251127    clang-20
i386                  randconfig-013-20251127    clang-20
i386                  randconfig-014-20251127    clang-20
i386                  randconfig-015-20251127    clang-20
i386                  randconfig-016-20251127    clang-20
i386                  randconfig-017-20251127    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20251126    gcc-15.1.0
loongarch             randconfig-002-20251126    clang-22
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20251126    gcc-11.5.0
nios2                 randconfig-002-20251126    gcc-9.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251126    gcc-8.5.0
parisc                randconfig-001-20251127    gcc-13.4.0
parisc                randconfig-002-20251126    gcc-15.1.0
parisc                randconfig-002-20251127    gcc-13.4.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      bamboo_defconfig    clang-22
powerpc                   bluestone_defconfig    clang-22
powerpc                 linkstation_defconfig    clang-22
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc               randconfig-001-20251126    gcc-10.5.0
powerpc               randconfig-001-20251127    gcc-13.4.0
powerpc               randconfig-002-20251126    gcc-8.5.0
powerpc               randconfig-002-20251127    gcc-13.4.0
powerpc64             randconfig-001-20251126    clang-19
powerpc64             randconfig-001-20251127    gcc-13.4.0
powerpc64             randconfig-002-20251126    clang-22
powerpc64             randconfig-002-20251127    gcc-13.4.0
riscv                            allmodconfig    clang-16
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251126    gcc-10.5.0
riscv                 randconfig-001-20251127    gcc-12.5.0
riscv                 randconfig-002-20251126    clang-22
riscv                 randconfig-002-20251127    gcc-12.5.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251126    gcc-8.5.0
s390                  randconfig-001-20251127    gcc-12.5.0
s390                  randconfig-002-20251126    gcc-8.5.0
s390                  randconfig-002-20251127    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                          kfr2r09_defconfig    clang-22
sh                    randconfig-001-20251126    gcc-14.3.0
sh                    randconfig-001-20251127    gcc-12.5.0
sh                    randconfig-002-20251126    gcc-11.5.0
sh                    randconfig-002-20251127    gcc-12.5.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251126    gcc-8.5.0
sparc                 randconfig-001-20251127    clang-22
sparc                 randconfig-002-20251126    gcc-14.3.0
sparc                 randconfig-002-20251127    clang-22
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251126    gcc-8.5.0
sparc64               randconfig-001-20251127    clang-22
sparc64               randconfig-002-20251126    clang-22
sparc64               randconfig-002-20251127    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251126    clang-19
um                    randconfig-001-20251127    clang-22
um                    randconfig-002-20251126    clang-22
um                    randconfig-002-20251127    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251127    gcc-14
x86_64                randconfig-002-20251127    gcc-14
x86_64                randconfig-003-20251127    gcc-14
x86_64                randconfig-004-20251127    gcc-14
x86_64                randconfig-005-20251127    gcc-14
x86_64                randconfig-006-20251127    gcc-14
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251126    gcc-14.3.0
xtensa                randconfig-001-20251127    clang-22
xtensa                randconfig-002-20251126    gcc-10.5.0
xtensa                randconfig-002-20251127    clang-22
xtensa                    xip_kc705_defconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

