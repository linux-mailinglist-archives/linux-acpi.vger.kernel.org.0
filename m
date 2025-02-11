Return-Path: <linux-acpi+bounces-11012-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AC1A30B9E
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 13:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102463A59F3
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 12:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F17204859;
	Tue, 11 Feb 2025 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rm43OmXT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5D71FECB7;
	Tue, 11 Feb 2025 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739276348; cv=none; b=uWGTUFnQ7JnJgiHCk52HMNqHREBWgo5ZxZJXhLjC/S58ZnzL8o8YzndoV4nq0YWFhcYV4iFIqqc+FaT6TFTYQUvIj4l94K976ORzjtbse4dm2IyOtwLyK9AJPt8M76bjqMqYRYhRpdlPq37naBT87+Rcn4TnmJPw0ZN/GOIxTHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739276348; c=relaxed/simple;
	bh=1i8C269OqO7eaLbZPTYPhQ7p4mKQgeQ/WAhb06fNP/Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sh5AfvTNoaSdJVHyPS0Z6vJaxOSGDMeXlvgyrqXNqo88OPGABYDLl6HZxFKk2+1NhwR7BA4sHEJgG4rpuBgiVNPzSqes7Gb0hI0QEO4hQNcZ5yIuDtPHUagkGKGKiq0pa8VkEF8DkfllNGBo5ToFBkdR4Y5bITBJgOR9ys411vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rm43OmXT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739276347; x=1770812347;
  h=date:from:to:cc:subject:message-id;
  bh=1i8C269OqO7eaLbZPTYPhQ7p4mKQgeQ/WAhb06fNP/Y=;
  b=Rm43OmXTzaAHSLiB/+2uNEK40anWpkKZenfEoP5tCteW7UzY3/eGIBIk
   2smM1utNCc9xUbrVcCNUaqWgH31OcrCHmMGQs48JnTg4bCC8+ksMEjtld
   FSihWF1Sk/aYL6CjBZFSCBePtxSLwc5nSwjZ1wTgzj9AGFEMmwHKorap3
   aGjr3OyKFOrcZpMxUohIur+KBQF724ek4eCDVTtApeBO1W+PXVnpfXuS/
   kbs6+T6oG+fshYegkmEbQCmrq1zwnKHb5q7p8kAkERW9clb5RAqXv4P2b
   +Od0JFqKSzmFNK6W6b5+A1jj5XNW+AJBzi+6FjyK7LEBGlOxW7ye80uA+
   Q==;
X-CSE-ConnectionGUID: wAKSbTVkSR+c/pA9k7cpgQ==
X-CSE-MsgGUID: z5JS9E3nS6eEvoa8EZcS7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="65246229"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="65246229"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 04:19:06 -0800
X-CSE-ConnectionGUID: /LiwICH1QkGQBUPSqZZQpA==
X-CSE-MsgGUID: aihRGlT8ROuLWi8AyFjK8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149674696"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Feb 2025 04:19:04 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thpEE-001493-0O;
	Tue, 11 Feb 2025 12:19:02 +0000
Date: Tue, 11 Feb 2025 20:18:20 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 717d1c526e2424ed8225cf0a74191be06f354b9a
Message-ID: <202502112013.EX81SBHS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 717d1c526e2424ed8225cf0a74191be06f354b9a  Merge branch 'experimental/menu' into bleeding-edge

elapsed time: 1454m

configs tested: 216
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250210    gcc-13.2.0
arc                   randconfig-001-20250211    clang-19
arc                   randconfig-002-20250210    gcc-13.2.0
arc                   randconfig-002-20250211    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         at91_dt_defconfig    clang-21
arm                        multi_v7_defconfig    gcc-14.2.0
arm                   randconfig-001-20250210    clang-16
arm                   randconfig-001-20250211    clang-19
arm                   randconfig-002-20250210    gcc-14.2.0
arm                   randconfig-002-20250211    clang-19
arm                   randconfig-003-20250210    clang-16
arm                   randconfig-003-20250211    clang-19
arm                   randconfig-004-20250210    gcc-14.2.0
arm                   randconfig-004-20250211    clang-19
arm                        vexpress_defconfig    gcc-14.2.0
arm                         vf610m4_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250210    gcc-14.2.0
arm64                 randconfig-001-20250211    clang-19
arm64                 randconfig-002-20250210    clang-21
arm64                 randconfig-002-20250211    clang-19
arm64                 randconfig-003-20250210    clang-21
arm64                 randconfig-003-20250211    clang-19
arm64                 randconfig-004-20250210    gcc-14.2.0
arm64                 randconfig-004-20250211    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250210    gcc-14.2.0
csky                  randconfig-001-20250211    clang-18
csky                  randconfig-002-20250210    gcc-14.2.0
csky                  randconfig-002-20250211    clang-18
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250210    clang-21
hexagon               randconfig-001-20250211    clang-18
hexagon               randconfig-002-20250210    clang-21
hexagon               randconfig-002-20250211    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250210    gcc-12
i386        buildonly-randconfig-001-20250211    gcc-12
i386        buildonly-randconfig-002-20250210    gcc-12
i386        buildonly-randconfig-002-20250211    gcc-12
i386        buildonly-randconfig-003-20250210    clang-19
i386        buildonly-randconfig-003-20250211    gcc-12
i386        buildonly-randconfig-004-20250210    gcc-12
i386        buildonly-randconfig-004-20250211    gcc-12
i386        buildonly-randconfig-005-20250210    gcc-12
i386        buildonly-randconfig-005-20250211    gcc-12
i386        buildonly-randconfig-006-20250210    gcc-12
i386        buildonly-randconfig-006-20250211    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250211    gcc-12
i386                  randconfig-002-20250211    gcc-12
i386                  randconfig-003-20250211    gcc-12
i386                  randconfig-004-20250211    gcc-12
i386                  randconfig-005-20250211    gcc-12
i386                  randconfig-006-20250211    gcc-12
i386                  randconfig-007-20250211    gcc-12
i386                  randconfig-011-20250211    gcc-11
i386                  randconfig-012-20250211    gcc-11
i386                  randconfig-013-20250211    gcc-11
i386                  randconfig-014-20250211    gcc-11
i386                  randconfig-015-20250211    gcc-11
i386                  randconfig-016-20250211    gcc-11
i386                  randconfig-017-20250211    gcc-11
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250210    gcc-14.2.0
loongarch             randconfig-001-20250211    clang-18
loongarch             randconfig-002-20250210    gcc-14.2.0
loongarch             randconfig-002-20250211    clang-18
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          amiga_defconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250210    gcc-14.2.0
nios2                 randconfig-001-20250211    clang-18
nios2                 randconfig-002-20250210    gcc-14.2.0
nios2                 randconfig-002-20250211    clang-18
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250210    gcc-14.2.0
parisc                randconfig-001-20250211    clang-18
parisc                randconfig-002-20250210    gcc-14.2.0
parisc                randconfig-002-20250211    clang-18
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    clang-16
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250210    clang-21
powerpc               randconfig-001-20250211    clang-18
powerpc               randconfig-002-20250210    clang-21
powerpc               randconfig-002-20250211    clang-18
powerpc               randconfig-003-20250210    gcc-14.2.0
powerpc               randconfig-003-20250211    clang-18
powerpc                     tqm8548_defconfig    clang-19
powerpc64             randconfig-001-20250210    gcc-14.2.0
powerpc64             randconfig-001-20250211    clang-18
powerpc64             randconfig-002-20250210    gcc-14.2.0
powerpc64             randconfig-002-20250211    clang-18
powerpc64             randconfig-003-20250210    gcc-14.2.0
powerpc64             randconfig-003-20250211    clang-18
riscv                            alldefconfig    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250210    clang-21
riscv                 randconfig-001-20250211    clang-15
riscv                 randconfig-002-20250210    gcc-14.2.0
riscv                 randconfig-002-20250211    clang-15
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250210    gcc-14.2.0
s390                  randconfig-001-20250211    clang-15
s390                  randconfig-002-20250210    clang-19
s390                  randconfig-002-20250211    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                    randconfig-001-20250210    gcc-14.2.0
sh                    randconfig-001-20250211    clang-15
sh                    randconfig-002-20250210    gcc-14.2.0
sh                    randconfig-002-20250211    clang-15
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250210    gcc-14.2.0
sparc                 randconfig-001-20250211    clang-15
sparc                 randconfig-002-20250210    gcc-14.2.0
sparc                 randconfig-002-20250211    clang-15
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250210    gcc-14.2.0
sparc64               randconfig-001-20250211    clang-15
sparc64               randconfig-002-20250210    gcc-14.2.0
sparc64               randconfig-002-20250211    clang-15
um                               allmodconfig    clang-21
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250210    clang-18
um                    randconfig-001-20250211    clang-15
um                    randconfig-002-20250210    clang-16
um                    randconfig-002-20250211    clang-15
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250210    clang-19
x86_64      buildonly-randconfig-001-20250211    gcc-12
x86_64      buildonly-randconfig-002-20250210    gcc-12
x86_64      buildonly-randconfig-002-20250211    gcc-12
x86_64      buildonly-randconfig-003-20250210    clang-19
x86_64      buildonly-randconfig-003-20250211    gcc-12
x86_64      buildonly-randconfig-004-20250210    clang-19
x86_64      buildonly-randconfig-004-20250211    gcc-12
x86_64      buildonly-randconfig-005-20250210    clang-19
x86_64      buildonly-randconfig-005-20250211    gcc-12
x86_64      buildonly-randconfig-006-20250210    clang-19
x86_64      buildonly-randconfig-006-20250211    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250211    gcc-11
x86_64                randconfig-002-20250211    gcc-11
x86_64                randconfig-003-20250211    gcc-11
x86_64                randconfig-004-20250211    gcc-11
x86_64                randconfig-005-20250211    gcc-11
x86_64                randconfig-006-20250211    gcc-11
x86_64                randconfig-007-20250211    gcc-11
x86_64                randconfig-008-20250211    gcc-11
x86_64                randconfig-071-20250211    clang-19
x86_64                randconfig-072-20250211    clang-19
x86_64                randconfig-073-20250211    clang-19
x86_64                randconfig-074-20250211    clang-19
x86_64                randconfig-075-20250211    clang-19
x86_64                randconfig-076-20250211    clang-19
x86_64                randconfig-077-20250211    clang-19
x86_64                randconfig-078-20250211    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250210    gcc-14.2.0
xtensa                randconfig-001-20250211    clang-15
xtensa                randconfig-002-20250210    gcc-14.2.0
xtensa                randconfig-002-20250211    clang-15
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

