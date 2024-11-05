Return-Path: <linux-acpi+bounces-9293-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB879BCB72
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 12:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198EC281E15
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 11:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD341D3181;
	Tue,  5 Nov 2024 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewkQDjaX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806A216D30B;
	Tue,  5 Nov 2024 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805448; cv=none; b=LnnAXxHOd0mH3gPiOK76TA63hR6APyxuFsRWT326D9YDNGJrkdKkJ0EKZfLAOAYzgZBXNWIWPZB2yurX8PnNtgy1BCX54SCbik0IXySHjEDWDZQHdjX985U2+ficwA2XRsNq9t/MHNOOYoVqCjxGQhrHaB2RByRUZC3WDMCzVf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805448; c=relaxed/simple;
	bh=8w8ENZi65e5Jims1cAXBTRCqVHai8ejEf1Iz+le6GX0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bY3tlgyl9he7BS4jZrDO8SKZO3lw0F+iUWcHLVVNGeFp+Us6QJdH9yw/r4Z1HLN9zu4furPTwt5Uxhc+yVUot28P/kQkCPsQ8FvNWtgutciBDKLngX80HpBJVVcAUvz5uq8zLyLpIyFFCjL3GXAsy61WGr9MU6HRyCKsg/oWoGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewkQDjaX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730805446; x=1762341446;
  h=date:from:to:cc:subject:message-id;
  bh=8w8ENZi65e5Jims1cAXBTRCqVHai8ejEf1Iz+le6GX0=;
  b=ewkQDjaX7TdxNdGBKQ8SCkssC9hhDaCYlIRIhMVCeuMvg6JF0lw7Y50h
   T209GQrOcj+W68l/gTVvg8JGcBGO0sosr0kz1+pokpuHMSkwLhom9Mxqe
   EpUWGG2cqQ2SiCr5VkY06rCCktNyo4h+ResdFVUL1PuWGIaIvursC88Aa
   vEszyM7tywK2ltUIhSl33ev2eLMyjH7z5UT+eUTvixWkdr6YYVeNix5og
   14H7jrUd8Vyb9O92jrOMte4wVgNRwQUFoTF74mWLeVHFfMjh/NHnWE79W
   vK7UngIfAhjy5fMNPbjtIQu3Y6QiiV2wt4cXdy6ubqQ1P2sSQSBZJ8LzU
   w==;
X-CSE-ConnectionGUID: IUe057ofQpCMG+jgyb/9bw==
X-CSE-MsgGUID: v+GE28uqThO13zqDy1P6zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="48053952"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="48053952"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 03:17:26 -0800
X-CSE-ConnectionGUID: h7JFAP+DRqCAFYXE8AP+gw==
X-CSE-MsgGUID: fGqEHdQCQUKbuOTcd58kbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="88779444"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 05 Nov 2024 03:17:25 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8HYn-000lxn-2g;
	Tue, 05 Nov 2024 11:17:21 +0000
Date: Tue, 05 Nov 2024 19:17:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 4fc6cbf1ea427b5d146847e1cc957a16691765db
Message-ID: <202411051901.7Q3sqsKs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 4fc6cbf1ea427b5d146847e1cc957a16691765db  Merge branch 'pm-em' into bleeding-edge

elapsed time: 731m

configs tested: 130
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                       aspeed_g5_defconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                      footbridge_defconfig    gcc-14.1.0
arm                           imxrt_defconfig    clang-20
arm                           imxrt_defconfig    gcc-14.1.0
arm                            mps2_defconfig    clang-20
arm                           sama7_defconfig    clang-20
arm                        shmobile_defconfig    gcc-14.1.0
arm                         wpcm450_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          hp300_defconfig    clang-20
m68k                          sun3x_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath79_defconfig    gcc-14.1.0
mips                  cavium_octeon_defconfig    clang-20
mips                           ip27_defconfig    gcc-14.1.0
mips                           jazz_defconfig    clang-20
mips                     loongson1b_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                         alldefconfig    clang-20
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                 canyonlands_defconfig    clang-20
powerpc                        cell_defconfig    clang-20
powerpc                    ge_imp3a_defconfig    gcc-14.1.0
powerpc                     ksi8560_defconfig    clang-20
powerpc                      mgcoge_defconfig    gcc-14.1.0
powerpc                  storcenter_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    gcc-14.1.0
sh                           se7206_defconfig    clang-20
sh                           se7712_defconfig    gcc-14.1.0
sh                           se7722_defconfig    clang-20
sh                           se7722_defconfig    gcc-14.1.0
sh                   sh7724_generic_defconfig    clang-20
sh                              ul2_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                             i386_defconfig    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241105    gcc-12
x86_64      buildonly-randconfig-002-20241105    gcc-12
x86_64      buildonly-randconfig-003-20241105    gcc-12
x86_64      buildonly-randconfig-004-20241105    gcc-12
x86_64      buildonly-randconfig-005-20241105    gcc-12
x86_64      buildonly-randconfig-006-20241105    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241105    gcc-12
x86_64                randconfig-002-20241105    gcc-12
x86_64                randconfig-003-20241105    gcc-12
x86_64                randconfig-004-20241105    gcc-12
x86_64                randconfig-005-20241105    gcc-12
x86_64                randconfig-006-20241105    gcc-12
x86_64                randconfig-011-20241105    gcc-12
x86_64                randconfig-012-20241105    gcc-12
x86_64                randconfig-013-20241105    gcc-12
x86_64                randconfig-014-20241105    gcc-12
x86_64                randconfig-015-20241105    gcc-12
x86_64                randconfig-016-20241105    gcc-12
x86_64                randconfig-071-20241105    gcc-12
x86_64                randconfig-072-20241105    gcc-12
x86_64                randconfig-073-20241105    gcc-12
x86_64                randconfig-074-20241105    gcc-12
x86_64                randconfig-075-20241105    gcc-12
x86_64                randconfig-076-20241105    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

