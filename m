Return-Path: <linux-acpi+bounces-3941-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28617862999
	for <lists+linux-acpi@lfdr.de>; Sun, 25 Feb 2024 08:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9016E1F215CA
	for <lists+linux-acpi@lfdr.de>; Sun, 25 Feb 2024 07:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD125D2E5;
	Sun, 25 Feb 2024 07:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iv2oXJIj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FF17460;
	Sun, 25 Feb 2024 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708845268; cv=none; b=ClILbpOpI/uzVsP+Ip2THUU7zTs5Vd2vxckbOVA867viA9gv6kGJ/vSunn0LxTzMlhEMg6dehHBdMQcBtEEN6T01qlg21l1WgemDeRRWsFr0Ry9VuaX+FdmogL9yeTo9/m4ihuXHGTfRJnRf4RqLGYyyVnrVQBE0cVga99qCC6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708845268; c=relaxed/simple;
	bh=z4OFGREyddGguIyPt5+jgAeUNGiDqPBZjgzPMCBvdlE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=A4Py3Q0yP+RL3l7PgtEdBI6dBLlP3ebLzAJk1OeyFhId9o3ZLMUMQJbPaWsjdoDFGH066Bxxs8iWqRoM+0BbCJFoIlmuH5kk06kpppb1gac0oy5kzGZVeVj+bSw/jrZEA3418Y+weGYAIM0hMNll61/X91fZ3UrDgcinFiZwMeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iv2oXJIj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708845266; x=1740381266;
  h=date:from:to:cc:subject:message-id;
  bh=z4OFGREyddGguIyPt5+jgAeUNGiDqPBZjgzPMCBvdlE=;
  b=Iv2oXJIjodloW4wR0lzzQlzLhnZu4wOnn+msFrUMZyWRKy2bIAhUILWr
   z67X56uzQ7RDK8cOGWLi0TkhaVLQ/fImpbgeuocqwWsoYOGB8NmH8dWfA
   sMORJGiTWZISV0CVklhcKrB48n1ojdgU/rUjeoKUTqvTfDP6xoQCw6eCz
   J3g/oTFebMYvqrOmrLwrJ65jYXEPL2EvTJYP9eJmG8Ylhf2iZH7YsQ3d8
   7IPO2UflcOyq18Pcz2Jl+83tFI1WxDQa4jRoWP8C+KpxmaNm3R3tMrc2Y
   UDd01CWw1s/TYrQDayXok0BFlORkbydFpiJw6nsm9XdDM02wCVzN3MH5M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10994"; a="14273784"
X-IronPort-AV: E=Sophos;i="6.06,183,1705392000"; 
   d="scan'208";a="14273784"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2024 23:14:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,183,1705392000"; 
   d="scan'208";a="6559331"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 24 Feb 2024 23:14:23 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1re8iL-0009O3-0j;
	Sun, 25 Feb 2024 07:14:21 +0000
Date: Sun, 25 Feb 2024 15:14:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 cf6b8fb0504e3066fcd684734eb336343924e37e
Message-ID: <202402251500.OIj8Dz5H-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: cf6b8fb0504e3066fcd684734eb336343924e37e  Merge branch 'acpi-scan' into bleeding-edge

elapsed time: 965m

configs tested: 162
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240225   gcc  
arc                   randconfig-002-20240225   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   clang
arm                         axm55xx_defconfig   clang
arm                                 defconfig   clang
arm                           imxrt_defconfig   clang
arm                        mvebu_v5_defconfig   gcc  
arm                   randconfig-001-20240225   clang
arm                   randconfig-002-20240225   gcc  
arm                   randconfig-003-20240225   clang
arm                   randconfig-004-20240225   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240225   gcc  
arm64                 randconfig-002-20240225   clang
arm64                 randconfig-003-20240225   gcc  
arm64                 randconfig-004-20240225   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240225   gcc  
csky                  randconfig-002-20240225   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240225   clang
hexagon               randconfig-002-20240225   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                                defconfig   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240225   gcc  
loongarch             randconfig-002-20240225   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip22_defconfig   gcc  
mips                     loongson1b_defconfig   clang
mips                      loongson3_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240225   gcc  
nios2                 randconfig-002-20240225   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240225   gcc  
parisc                randconfig-002-20240225   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                  mpc866_ads_defconfig   clang
powerpc                     powernv_defconfig   gcc  
powerpc               randconfig-001-20240225   clang
powerpc               randconfig-002-20240225   clang
powerpc               randconfig-003-20240225   clang
powerpc64             randconfig-001-20240225   gcc  
powerpc64             randconfig-002-20240225   clang
powerpc64             randconfig-003-20240225   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240225   gcc  
riscv                 randconfig-002-20240225   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240225   gcc  
s390                  randconfig-002-20240225   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                    randconfig-001-20240225   gcc  
sh                    randconfig-002-20240225   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240225   gcc  
sparc64               randconfig-002-20240225   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240225   clang
um                    randconfig-002-20240225   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240225   clang
x86_64       buildonly-randconfig-002-20240225   clang
x86_64       buildonly-randconfig-003-20240225   clang
x86_64       buildonly-randconfig-004-20240225   gcc  
x86_64       buildonly-randconfig-005-20240225   clang
x86_64       buildonly-randconfig-006-20240225   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240225   gcc  
x86_64                randconfig-002-20240225   clang
x86_64                randconfig-003-20240225   gcc  
x86_64                randconfig-004-20240225   clang
x86_64                randconfig-005-20240225   clang
x86_64                randconfig-006-20240225   gcc  
x86_64                randconfig-011-20240225   clang
x86_64                randconfig-012-20240225   clang
x86_64                randconfig-013-20240225   gcc  
x86_64                randconfig-014-20240225   gcc  
x86_64                randconfig-015-20240225   clang
x86_64                randconfig-016-20240225   gcc  
x86_64                randconfig-071-20240225   gcc  
x86_64                randconfig-072-20240225   gcc  
x86_64                randconfig-073-20240225   clang
x86_64                randconfig-074-20240225   gcc  
x86_64                randconfig-075-20240225   clang
x86_64                randconfig-076-20240225   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240225   gcc  
xtensa                randconfig-002-20240225   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

