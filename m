Return-Path: <linux-acpi+bounces-16001-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06FCB32ED8
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Aug 2025 11:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4174E7A9934
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Aug 2025 09:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D9D265CB3;
	Sun, 24 Aug 2025 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpBGy8j/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE431243968;
	Sun, 24 Aug 2025 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756028484; cv=none; b=QRz40gMhYpiq5puIYIOmBRFzXDsfhraR0knWj6UFfr/gDJyLRU+qMA2uviXd+bZyIEZfcW0wMbXM7qmOHg9/yMr2T/0ljC01Kbb7EL+6wwj1eDfNynLTFtLr8NOPuELplm7Zr+MAj6F6Zd5vRjN2iLBNCyxf1kyc0Qp883qBLfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756028484; c=relaxed/simple;
	bh=XNxUxbNXFYV9MnHGJJKltYoRT7e8KeOC/h0FveIdxCs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Oe83yLdsPsrtlMtNkLa/yH5d3nXmI9cmW07pL+ll3IjKCeVhCWfTWwJTvT0qTUDuXWFIa9fDtE/zVAEKAFZ42vbZyuFFRQK5e/1kmuZBRzhPFRPbG4DTLI0SiOsH64GLgElz57VPJfBsnuJhPaCyeeC7xGjy2/nBXwL5uNwzufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpBGy8j/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756028482; x=1787564482;
  h=date:from:to:cc:subject:message-id;
  bh=XNxUxbNXFYV9MnHGJJKltYoRT7e8KeOC/h0FveIdxCs=;
  b=FpBGy8j/+CLLLEmYlzglsibLi4Y763KTkQY00veyueiAPRPSlRO0BD4d
   4O/EOTfASQs4gzOD4MmLAUDrpKI3IsJCom6Ij1mQXs0fnBY1SPKoIhkWo
   SR95DdeRP218i9ldgcflxLIaCX7kSJ9ZnWvm4Pee3kSk0yGCbeuMwgKRf
   IruSCcEQIewvdq3oIWAB/CB93oYIjNZpoT4ctcmCQfRXrxZFJpQkIGpka
   Z8PKpmgLXqfyjNT6RxbCSV4f8uxwBRY/VxaBKOtJBYk0SjNCQ5p8M/QVp
   yk6GmAZ9Vm3daHJAalhBmYYWRiC3VRtwMMx6c1OCto969mpEkPuFZX3nQ
   g==;
X-CSE-ConnectionGUID: h7Uw0YBVRJGLym1duJMH6w==
X-CSE-MsgGUID: OLJlopiDTzycD1Ui0x8Mrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58335325"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58335325"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 02:41:20 -0700
X-CSE-ConnectionGUID: edT2Wcv9Qj+Kk9AFzA6kFQ==
X-CSE-MsgGUID: UMJeaxELSqO0peGyu9aK/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169455000"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 24 Aug 2025 02:41:19 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uq7Dw-000Mvb-36;
	Sun, 24 Aug 2025 09:41:17 +0000
Date: Sun, 24 Aug 2025 17:40:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 18fa6888b3a183083bca7561bb00b4bc36cc337a
Message-ID: <202508241734.N4sR2IoK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 18fa6888b3a183083bca7561bb00b4bc36cc337a  Merge branch 'acpi-processor' into bleeding-edge

elapsed time: 1040m

configs tested: 133
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250824    gcc-15.1.0
arc                   randconfig-002-20250824    gcc-10.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                     davinci_all_defconfig    clang-19
arm                                 defconfig    clang-22
arm                        keystone_defconfig    gcc-15.1.0
arm                   randconfig-001-20250824    clang-22
arm                   randconfig-002-20250824    gcc-13.4.0
arm                   randconfig-003-20250824    clang-22
arm                   randconfig-004-20250824    clang-22
arm64                            alldefconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250824    gcc-13.4.0
arm64                 randconfig-002-20250824    gcc-11.5.0
arm64                 randconfig-003-20250824    gcc-10.5.0
arm64                 randconfig-004-20250824    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250824    gcc-10.5.0
csky                  randconfig-002-20250824    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250824    clang-22
hexagon               randconfig-002-20250824    clang-22
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250824    gcc-12
i386        buildonly-randconfig-002-20250824    gcc-12
i386        buildonly-randconfig-003-20250824    gcc-12
i386        buildonly-randconfig-004-20250824    gcc-12
i386        buildonly-randconfig-005-20250824    gcc-12
i386        buildonly-randconfig-006-20250824    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250824    gcc-12.5.0
loongarch             randconfig-002-20250824    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250824    gcc-8.5.0
nios2                 randconfig-002-20250824    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250824    gcc-9.5.0
parisc                randconfig-002-20250824    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                   lite5200b_defconfig    clang-22
powerpc               randconfig-001-20250824    gcc-9.5.0
powerpc               randconfig-002-20250824    clang-22
powerpc               randconfig-003-20250824    gcc-12.5.0
powerpc                     sequoia_defconfig    clang-17
powerpc64             randconfig-001-20250824    gcc-8.5.0
powerpc64             randconfig-002-20250824    gcc-13.4.0
powerpc64             randconfig-003-20250824    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250824    gcc-11.5.0
riscv                 randconfig-002-20250824    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250824    clang-16
s390                  randconfig-002-20250824    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          kfr2r09_defconfig    gcc-15.1.0
sh                          polaris_defconfig    gcc-15.1.0
sh                    randconfig-001-20250824    gcc-15.1.0
sh                    randconfig-002-20250824    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250824    gcc-14.3.0
sparc                 randconfig-002-20250824    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250824    clang-22
sparc64               randconfig-002-20250824    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250824    gcc-12
um                    randconfig-002-20250824    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250824    gcc-12
x86_64      buildonly-randconfig-002-20250824    clang-20
x86_64      buildonly-randconfig-003-20250824    gcc-12
x86_64      buildonly-randconfig-004-20250824    clang-20
x86_64      buildonly-randconfig-005-20250824    gcc-12
x86_64      buildonly-randconfig-006-20250824    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250824    gcc-9.5.0
xtensa                randconfig-002-20250824    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

