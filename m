Return-Path: <linux-acpi+bounces-6920-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBFE932A4D
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2024 17:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9618280FDC
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2024 15:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD4919D88D;
	Tue, 16 Jul 2024 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8PQqKx1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9542198E80;
	Tue, 16 Jul 2024 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143205; cv=none; b=bG/C58+da4BFxcb12rUMLdh/HIsxHWCM2BOhZH3LLYfw2BD1Rt4NAetLSjZe9s49BOYtfH87rf4hWn46wLj8f0B1Sr2klAljSzBu3tyfH8ONgs4W8Rv6gRurC15aan4hG5aB9nBnPa7c05fZHTvfVtqSQ0q14JB7IjTK9dPo42I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143205; c=relaxed/simple;
	bh=WjBM5G+GY8e/kh9YkVNFE9Gx2GSX+r2vEHO6noqqA+w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pO3FLZ3oaeCky+1+TtpTva+h6QIGjZ1wv+vrxiym5XL+ASN5SoWI9kegA+b+3xjgv+/wHgmobUsNs7Ou1NIiKhbfucjX4xg6M5IIIdrcraUgWdmnkoHbubmBK2XyQauYEbtTNPdkipFQBnTyMI0xNpvg1fcJFau4oeXTJniZCd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8PQqKx1; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721143204; x=1752679204;
  h=date:from:to:cc:subject:message-id;
  bh=WjBM5G+GY8e/kh9YkVNFE9Gx2GSX+r2vEHO6noqqA+w=;
  b=V8PQqKx1t79NyUKUTinTxA/AjGp85QzZPpd//C4QKY8+GI4jRXIPzuNT
   liaMrW8uHpFEA8/pxZ1+jWOp7sOYtQdYScx6rj25tQSnEiLb79Cm3IP2R
   IeR4/teje+xqHu1ffC5nDT0i5pg6iyIshtTWYlGELI0CEpQPFiE7y8Oxu
   mH95eYVXIV6X6lOPa5kbvZY9RQ97SoIIhfjFaYycBPvskL748ULUKT8X4
   iZWeDXQClalStItV9TZaDLGRAexspS0/Ji2JGxZJpte93TqwWUZUXBxhy
   peb0EZGCLKWbZqXyA5mIpf6vhK/ri42sWNv2PAdYWpLDLE8P3BeuImm8Z
   Q==;
X-CSE-ConnectionGUID: LMfYt++yRK23/dKI8mDwDw==
X-CSE-MsgGUID: rpa0D0FmQzS93Tkf4MR7HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18785189"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18785189"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 08:20:03 -0700
X-CSE-ConnectionGUID: Ttssp2f4TyeAQOv18cOJ5A==
X-CSE-MsgGUID: FZDlUIHkRi2RKgnv3iB54w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="55200220"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 16 Jul 2024 08:20:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTjyB-000fNT-1r;
	Tue, 16 Jul 2024 15:19:59 +0000
Date: Tue, 16 Jul 2024 23:19:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 218ca41f1f26732bf9b2d041ba0e7e52a1c29ad2
Message-ID: <202407162315.2xwWE5Tl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 218ca41f1f26732bf9b2d041ba0e7e52a1c29ad2  Merge branch 'thermal' into linux-next

elapsed time: 1451m

configs tested: 158
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                        nsim_700_defconfig   gcc-13.2.0
arc                   randconfig-001-20240716   gcc-13.2.0
arc                   randconfig-002-20240716   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-14.1.0
arm                           imxrt_defconfig   clang-19
arm                         nhk8815_defconfig   clang-19
arm                   randconfig-001-20240716   gcc-14.1.0
arm                   randconfig-002-20240716   clang-19
arm                   randconfig-003-20240716   gcc-14.1.0
arm                   randconfig-004-20240716   gcc-14.1.0
arm                        shmobile_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240716   gcc-14.1.0
arm64                 randconfig-002-20240716   clang-19
arm64                 randconfig-003-20240716   gcc-14.1.0
arm64                 randconfig-004-20240716   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240716   gcc-14.1.0
csky                  randconfig-002-20240716   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240716   clang-19
hexagon               randconfig-002-20240716   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240716   clang-18
i386         buildonly-randconfig-002-20240716   clang-18
i386         buildonly-randconfig-003-20240716   clang-18
i386         buildonly-randconfig-004-20240716   clang-18
i386         buildonly-randconfig-005-20240716   clang-18
i386         buildonly-randconfig-006-20240716   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240716   clang-18
i386                  randconfig-002-20240716   clang-18
i386                  randconfig-003-20240716   gcc-9
i386                  randconfig-004-20240716   gcc-7
i386                  randconfig-005-20240716   clang-18
i386                  randconfig-006-20240716   gcc-9
i386                  randconfig-011-20240716   gcc-8
i386                  randconfig-012-20240716   clang-18
i386                  randconfig-013-20240716   gcc-8
i386                  randconfig-014-20240716   clang-18
i386                  randconfig-015-20240716   clang-18
i386                  randconfig-016-20240716   gcc-10
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240716   gcc-14.1.0
loongarch             randconfig-002-20240716   gcc-14.1.0
m68k                             alldefconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                       m5475evb_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                      mmu_defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240716   gcc-14.1.0
nios2                 randconfig-002-20240716   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240716   gcc-14.1.0
parisc                randconfig-002-20240716   gcc-14.1.0
powerpc                    adder875_defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                      arches_defconfig   gcc-14.1.0
powerpc                      pmac32_defconfig   clang-19
powerpc               randconfig-001-20240716   clang-19
powerpc               randconfig-002-20240716   clang-19
powerpc               randconfig-003-20240716   clang-19
powerpc64             randconfig-001-20240716   clang-19
powerpc64             randconfig-002-20240716   clang-19
powerpc64             randconfig-003-20240716   gcc-14.1.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240716   clang-19
riscv                 randconfig-002-20240716   clang-19
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240716   gcc-14.1.0
s390                  randconfig-002-20240716   clang-15
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                        apsh4ad0a_defconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                               j2_defconfig   gcc-14.1.0
sh                    randconfig-001-20240716   gcc-14.1.0
sh                    randconfig-002-20240716   gcc-14.1.0
sh                        sh7757lcr_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240716   gcc-14.1.0
sparc64               randconfig-002-20240716   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240716   gcc-13
um                    randconfig-002-20240716   clang-19
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240716   gcc-13
x86_64       buildonly-randconfig-002-20240716   clang-18
x86_64       buildonly-randconfig-003-20240716   clang-18
x86_64       buildonly-randconfig-004-20240716   clang-18
x86_64       buildonly-randconfig-005-20240716   clang-18
x86_64       buildonly-randconfig-006-20240716   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240716   gcc-13
x86_64                randconfig-002-20240716   gcc-8
x86_64                randconfig-003-20240716   gcc-8
x86_64                randconfig-004-20240716   clang-18
x86_64                randconfig-005-20240716   gcc-12
x86_64                randconfig-006-20240716   clang-18
x86_64                randconfig-011-20240716   clang-18
x86_64                randconfig-012-20240716   gcc-9
x86_64                randconfig-013-20240716   gcc-13
x86_64                randconfig-014-20240716   gcc-13
x86_64                randconfig-015-20240716   gcc-7
x86_64                randconfig-016-20240716   clang-18
x86_64                randconfig-071-20240716   clang-18
x86_64                randconfig-072-20240716   clang-18
x86_64                randconfig-073-20240716   clang-18
x86_64                randconfig-074-20240716   clang-18
x86_64                randconfig-075-20240716   clang-18
x86_64                randconfig-076-20240716   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  audio_kc705_defconfig   gcc-14.1.0
xtensa                randconfig-001-20240716   gcc-14.1.0
xtensa                randconfig-002-20240716   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

