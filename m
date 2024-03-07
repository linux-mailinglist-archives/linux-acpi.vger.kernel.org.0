Return-Path: <linux-acpi+bounces-4160-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C7F874BE2
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Mar 2024 11:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B382D1C20D87
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Mar 2024 10:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BFC12B167;
	Thu,  7 Mar 2024 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7/u88ll"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA812B152;
	Thu,  7 Mar 2024 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805838; cv=none; b=I0vR93p7J1okPKy5Uh8zwz1iUU67jtDya5OM2LqyHrlDQX9G0wfT03qMIchbsbjWH1EcgouI4cRpDWPRZx3vYjJg13DX+JoibK+JRNAJB8CUmcJ5KtS0LyVSSbfzCsAiFA4vgrd9dZB2JKj0e2g8hgMtQTVW/wain/0uoU3OJOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805838; c=relaxed/simple;
	bh=iITwFNcyrnEUQtm7TGGHczlszpKnZAJzqzd87ws7Av8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=N/7mSz+5MTUsaBPoSNrkhpdZodZ8m8SS2aP9UfUF7dw46bEtFe3m4ydahuLTzmx6fXnaJw8JFqZAdBW+sFCebbsSNhsu+r6Puo5iILtOw39gPkIPyGkRg6aWxNfrF62ykissyz/Jopz2SMRU3UaYIwnc9bL31oo+mgjTfyXBqu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7/u88ll; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709805836; x=1741341836;
  h=date:from:to:cc:subject:message-id;
  bh=iITwFNcyrnEUQtm7TGGHczlszpKnZAJzqzd87ws7Av8=;
  b=n7/u88lleqAo7rEcvwVIJUZxgzwpdSYLeuf/UYXIJzOf9681C4AMALWC
   PerHtkJcFp3ARmFf/VC6AoEmNxRh7NjnAhyXk9ZqI3V8KLSZJ775+Xd54
   ou6NpkPVYrk3l0iqTfWbnc3H5UYDVXKBHuK7aUM18V+1lNYaRC5lAZmXt
   zYaFR/ogc5pvuEizIqFJj97HFd0dOyO7oA+W3omB1dIECB9Tayh2hCDxY
   LCDwVf08k4c77ynFvVvMRjSndCde2miQsAoyppBxp6zrOhNsG3a7a9G3R
   F/my3otiif8++6xdDG87NrE5LKuJjrI3SsQzBM6IeOP/0Ie3GKuf1ZfPP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15606883"
X-IronPort-AV: E=Sophos;i="6.06,211,1705392000"; 
   d="scan'208";a="15606883"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 02:03:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,211,1705392000"; 
   d="scan'208";a="14559985"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Mar 2024 02:03:53 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1riAbO-000531-2s;
	Thu, 07 Mar 2024 10:03:50 +0000
Date: Thu, 07 Mar 2024 18:03:36 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 b1a0e6540c095265baa040c0378109936f5efd0a
Message-ID: <202403071831.248mJgUg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: b1a0e6540c095265baa040c0378109936f5efd0a  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 1262m

configs tested: 163
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
arc                                 defconfig   gcc  
arc                   randconfig-001-20240307   gcc  
arc                   randconfig-002-20240307   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240307   clang
arm                   randconfig-002-20240307   gcc  
arm                   randconfig-003-20240307   gcc  
arm                   randconfig-004-20240307   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240307   gcc  
arm64                 randconfig-002-20240307   gcc  
arm64                 randconfig-003-20240307   gcc  
arm64                 randconfig-004-20240307   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240307   gcc  
csky                  randconfig-002-20240307   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240307   clang
hexagon               randconfig-002-20240307   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240307   clang
i386         buildonly-randconfig-002-20240307   gcc  
i386         buildonly-randconfig-003-20240307   clang
i386         buildonly-randconfig-004-20240307   gcc  
i386         buildonly-randconfig-005-20240307   gcc  
i386         buildonly-randconfig-006-20240307   clang
i386                                defconfig   clang
i386                  randconfig-001-20240307   gcc  
i386                  randconfig-002-20240307   gcc  
i386                  randconfig-003-20240307   clang
i386                  randconfig-004-20240307   gcc  
i386                  randconfig-005-20240307   gcc  
i386                  randconfig-006-20240307   clang
i386                  randconfig-011-20240307   clang
i386                  randconfig-012-20240307   gcc  
i386                  randconfig-013-20240307   clang
i386                  randconfig-014-20240307   clang
i386                  randconfig-015-20240307   clang
i386                  randconfig-016-20240307   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240307   gcc  
loongarch             randconfig-002-20240307   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240307   gcc  
nios2                 randconfig-002-20240307   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240307   gcc  
parisc                randconfig-002-20240307   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240307   gcc  
powerpc               randconfig-002-20240307   gcc  
powerpc               randconfig-003-20240307   gcc  
powerpc64             randconfig-001-20240307   gcc  
powerpc64             randconfig-002-20240307   gcc  
powerpc64             randconfig-003-20240307   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240307   clang
riscv                 randconfig-002-20240307   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240307   clang
s390                  randconfig-002-20240307   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240307   gcc  
sh                    randconfig-002-20240307   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240307   gcc  
sparc64               randconfig-002-20240307   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240307   gcc  
um                    randconfig-002-20240307   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240307   gcc  
x86_64       buildonly-randconfig-002-20240307   gcc  
x86_64       buildonly-randconfig-003-20240307   gcc  
x86_64       buildonly-randconfig-004-20240307   clang
x86_64       buildonly-randconfig-005-20240307   gcc  
x86_64       buildonly-randconfig-006-20240307   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240307   gcc  
x86_64                randconfig-002-20240307   gcc  
x86_64                randconfig-003-20240307   clang
x86_64                randconfig-004-20240307   gcc  
x86_64                randconfig-005-20240307   gcc  
x86_64                randconfig-006-20240307   clang
x86_64                randconfig-011-20240307   gcc  
x86_64                randconfig-012-20240307   gcc  
x86_64                randconfig-013-20240307   gcc  
x86_64                randconfig-014-20240307   clang
x86_64                randconfig-015-20240307   clang
x86_64                randconfig-016-20240307   clang
x86_64                randconfig-071-20240307   gcc  
x86_64                randconfig-072-20240307   gcc  
x86_64                randconfig-073-20240307   clang
x86_64                randconfig-074-20240307   gcc  
x86_64                randconfig-075-20240307   clang
x86_64                randconfig-076-20240307   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240307   gcc  
xtensa                randconfig-002-20240307   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

