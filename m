Return-Path: <linux-acpi+bounces-8250-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F14975A35
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Sep 2024 20:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04AC286D61
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Sep 2024 18:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28941B3F02;
	Wed, 11 Sep 2024 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSTEGfen"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDC31B1509;
	Wed, 11 Sep 2024 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078813; cv=none; b=UVC0XW6l8j+CBZYSVB5164Z41pcRoMuTj5BZkMTAAo3EqXZbAfMMCrUegDzW2r9ZOyNEmETTMtx6plShzgYH+JujMsDjqi6QTArgxSHVGSlNQ54ZaDWuY38Op/pEYGHG5g7TYiKxgti8sdBg60VSnS9XedXsW1rgKzRGct9EOds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078813; c=relaxed/simple;
	bh=xrSOE61qNjyKjaciUb65FfaB3abdMosMwV+7VFFIzjk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eQolCwStuVzJyItHTYjPBxSWo2pXeL+v5DVlEfcAlRasV0MyYiqJ8OIdUwn3JNbGliJb+IqjPrYLztmGcjjyBRVUNlK3DYKEgdAc1NxwF0Pi32hKGp3VpFx/wXSGOBQcdhvE6QPrBn25c+OLvksO/sGx/77g0/olvHgx4B1jq5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSTEGfen; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726078812; x=1757614812;
  h=date:from:to:cc:subject:message-id;
  bh=xrSOE61qNjyKjaciUb65FfaB3abdMosMwV+7VFFIzjk=;
  b=hSTEGfenouxahE1zqnwnDpR5OHmTYVCaRR3Kz+nP4ZGJpjXuFcF0RLBE
   PDMkjtPfkM/682iFnAVyMhx+DkKjSwm0BT+/oiVyfXBIjghLx+OgvKbD5
   0zM6b3j2yerxFsl6a/NvPbME2v+5YIGLnPj2slt4HRlugnbT8OKJLbJAK
   C7csQBM+FNYuxVwHsqgYr2GwWpap/j39X3BQwSggmtXRkaHGltYzfpPHY
   WxeAl/0AUMIos+M81sUp+f5pWiLMsoYAFdYsyo/FT+FEh70Z5CMGYO+rN
   TW647i/5BFCmBj7DRzPWPcuWDLvRzo9IrOdJXX+f2QX8zIlaF8Wtsa1ct
   w==;
X-CSE-ConnectionGUID: laFNU3LoRkaAew8Th3Yagg==
X-CSE-MsgGUID: Z6HgVYIaRoC0RgCLCvwuDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24835065"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="24835065"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 11:20:12 -0700
X-CSE-ConnectionGUID: UIMXhWc5SPuxqJLgkVAQ8A==
X-CSE-MsgGUID: Vd7vqKBxT06U45fvsi4xxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="68228794"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 11 Sep 2024 11:20:09 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soRwl-0003zE-2A;
	Wed, 11 Sep 2024 18:20:07 +0000
Date: Thu, 12 Sep 2024 02:19:23 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 5acb9d24a21720179a051a011fdd0c9f9e6dfb9f
Message-ID: <202409120220.Hs6mgGFZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 5acb9d24a21720179a051a011fdd0c9f9e6dfb9f  Merge branch 'acpi-resource' into bleeding-edge

elapsed time: 1377m

configs tested: 151
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240911   gcc-13.2.0
arc                   randconfig-002-20240911   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                         assabet_defconfig   clang-15
arm                                 defconfig   clang-14
arm                      jornada720_defconfig   clang-20
arm                         lpc18xx_defconfig   clang-20
arm                         mv78xx0_defconfig   clang-20
arm                   randconfig-001-20240911   clang-20
arm                   randconfig-002-20240911   clang-20
arm                   randconfig-003-20240911   clang-20
arm                   randconfig-004-20240911   gcc-14.1.0
arm                             rpc_defconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240911   clang-20
arm64                 randconfig-002-20240911   clang-15
arm64                 randconfig-003-20240911   clang-20
arm64                 randconfig-004-20240911   clang-15
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240911   gcc-14.1.0
csky                  randconfig-002-20240911   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   clang-20
hexagon               randconfig-001-20240911   clang-20
hexagon               randconfig-002-20240911   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240911   clang-18
i386         buildonly-randconfig-002-20240911   gcc-12
i386         buildonly-randconfig-003-20240911   clang-18
i386         buildonly-randconfig-004-20240911   gcc-12
i386         buildonly-randconfig-005-20240911   gcc-12
i386         buildonly-randconfig-006-20240911   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240911   gcc-12
i386                  randconfig-002-20240911   clang-18
i386                  randconfig-003-20240911   clang-18
i386                  randconfig-004-20240911   gcc-12
i386                  randconfig-005-20240911   gcc-12
i386                  randconfig-006-20240911   clang-18
i386                  randconfig-011-20240911   gcc-12
i386                  randconfig-012-20240911   gcc-12
i386                  randconfig-013-20240911   clang-18
i386                  randconfig-014-20240911   clang-18
i386                  randconfig-015-20240911   gcc-12
i386                  randconfig-016-20240911   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240911   gcc-14.1.0
loongarch             randconfig-002-20240911   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240911   gcc-14.1.0
nios2                 randconfig-002-20240911   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240911   gcc-14.1.0
parisc                randconfig-002-20240911   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc               randconfig-003-20240911   gcc-14.1.0
powerpc64             randconfig-001-20240911   clang-17
powerpc64             randconfig-002-20240911   clang-15
powerpc64             randconfig-003-20240911   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240911   gcc-14.1.0
riscv                 randconfig-002-20240911   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240911   gcc-14.1.0
s390                  randconfig-002-20240911   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240911   gcc-14.1.0
sh                    randconfig-002-20240911   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240911   gcc-14.1.0
sparc64               randconfig-002-20240911   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240911   clang-15
um                    randconfig-002-20240911   clang-20
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240911   clang-18
x86_64       buildonly-randconfig-002-20240911   clang-18
x86_64       buildonly-randconfig-003-20240911   gcc-12
x86_64       buildonly-randconfig-004-20240911   gcc-12
x86_64       buildonly-randconfig-005-20240911   gcc-12
x86_64       buildonly-randconfig-006-20240911   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240911   gcc-12
x86_64                randconfig-002-20240911   gcc-12
x86_64                randconfig-003-20240911   clang-18
x86_64                randconfig-004-20240911   clang-18
x86_64                randconfig-005-20240911   clang-18
x86_64                randconfig-006-20240911   gcc-12
x86_64                randconfig-011-20240911   clang-18
x86_64                randconfig-012-20240911   clang-18
x86_64                randconfig-013-20240911   gcc-12
x86_64                randconfig-014-20240911   clang-18
x86_64                randconfig-015-20240911   gcc-12
x86_64                randconfig-016-20240911   clang-18
x86_64                randconfig-071-20240911   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240911   gcc-14.1.0
xtensa                randconfig-002-20240911   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

