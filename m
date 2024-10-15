Return-Path: <linux-acpi+bounces-8790-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9659E99E2D4
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2024 11:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F292C2839C5
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2024 09:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579811CACF9;
	Tue, 15 Oct 2024 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GghMNKMH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334BF1BF2B;
	Tue, 15 Oct 2024 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984706; cv=none; b=dJlj/dYGx1Ma1dMdyT2nuuEqyqbCAJVG2SFPxK+agz75yg8yQa5gmmGsuRpi/lgNWqJrOyssXi0BTTiVEd9vprwWQhd+WVUC8IwH++vBM0B7M7HXZeDu+mDv0vBS1tYisahTubV4AxveVAmd7Gyf637gN+IEovBgb/HuJnzyfHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984706; c=relaxed/simple;
	bh=g6Y/1o0tCUkkZi3z/Mrp56Htqz9n61aa020CuwiNFOg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=em0OjXcO8r75TzBsZRg0v8dostJWp5nOptx8rh74A+c50W14UZEqh6s0A2c8nUm2YIHO88Xs4ZK/sfM2O3DNUA0jBu16X1zDpOCDDX9IPVISWBfTnmVNa4h+iUVKvKDcCwvTf5XS8Pq2vQQtcSDFST37dfYbAdt10ImFmtJNr7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GghMNKMH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728984704; x=1760520704;
  h=date:from:to:cc:subject:message-id;
  bh=g6Y/1o0tCUkkZi3z/Mrp56Htqz9n61aa020CuwiNFOg=;
  b=GghMNKMHyaEoePfFzlFAptyCPV/Ly7nQlsqBJiSVb1n5TcQuygsg272Q
   c56FdBfX17vMmgXhikOoIk4ok+5d/JMpVrQLzKiBJ8ftN67misVVVfZQn
   pHxSZ2OfsNiXgXU0fJFNL2Toq1uAc3DoMxMvumjgoGmECJKNQwmgiFQzf
   NLKnx9LKrxtJhuZ2SKo/FqUmjPVZtmu/+IGF4/jKV13vrcG0ZjSP6cmUe
   E1rPbZJpRTT2b/HWRDySL2I7oJbFUyeoRVNTuqp8SmQyhZnB0nhT1geIi
   UQS2X/CeWJJPBbDgZ/WDu2ZVGifEe2hPDGVlbV//lQvcWTdhAClsd0Vx4
   Q==;
X-CSE-ConnectionGUID: EDgNSl6tRNG3UpK5iOSnMA==
X-CSE-MsgGUID: gQw4rNEmQqO0Iz39cuVo2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28557629"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="28557629"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 02:31:43 -0700
X-CSE-ConnectionGUID: +42RpgiQQhm6W/rQx1eOWA==
X-CSE-MsgGUID: n3mDX5YtS3K+SsBv1aIv6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="82611292"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 15 Oct 2024 02:31:41 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0dtz-000Hsb-27;
	Tue, 15 Oct 2024 09:31:39 +0000
Date: Tue, 15 Oct 2024 17:30:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 a218483fe53fd0f2272f0c4c23fc97101ed346b9
Message-ID: <202410151742.kVJc5Hnx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: a218483fe53fd0f2272f0c4c23fc97101ed346b9  Merge branch 'thermal-core-experimental' into bleeding-edge

elapsed time: 1203m

configs tested: 112
configs skipped: 3

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
arc                 nsimosci_hs_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          moxart_defconfig    gcc-14.1.0
arm                        mvebu_v5_defconfig    gcc-14.1.0
arm                           spitz_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386                                defconfig    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath25_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                        fsp2_defconfig    gcc-14.1.0
powerpc                   lite5200b_defconfig    gcc-14.1.0
powerpc                 mpc836x_rdk_defconfig    gcc-14.1.0
powerpc                      ppc64e_defconfig    gcc-14.1.0
powerpc64                        alldefconfig    gcc-14.1.0
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
sh                          sdk7780_defconfig    gcc-14.1.0
sh                             sh03_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
um                           x86_64_defconfig    gcc-14.1.0
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241015    clang-18
x86_64      buildonly-randconfig-002-20241015    clang-18
x86_64      buildonly-randconfig-003-20241015    clang-18
x86_64      buildonly-randconfig-004-20241015    clang-18
x86_64      buildonly-randconfig-005-20241015    clang-18
x86_64      buildonly-randconfig-006-20241015    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241015    clang-18
x86_64                randconfig-002-20241015    clang-18
x86_64                randconfig-003-20241015    clang-18
x86_64                randconfig-004-20241015    clang-18
x86_64                randconfig-005-20241015    clang-18
x86_64                randconfig-006-20241015    clang-18
x86_64                randconfig-011-20241015    clang-18
x86_64                randconfig-012-20241015    clang-18
x86_64                randconfig-013-20241015    clang-18
x86_64                randconfig-014-20241015    clang-18
x86_64                randconfig-015-20241015    clang-18
x86_64                randconfig-016-20241015    clang-18
x86_64                randconfig-071-20241015    clang-18
x86_64                randconfig-072-20241015    clang-18
x86_64                randconfig-073-20241015    clang-18
x86_64                randconfig-074-20241015    clang-18
x86_64                randconfig-075-20241015    clang-18
x86_64                randconfig-076-20241015    clang-18
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

