Return-Path: <linux-acpi+bounces-15843-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D1DB2CA5A
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 19:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F6F3A32BE
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 17:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D3D277008;
	Tue, 19 Aug 2025 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Si5oJqcx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC171E520A;
	Tue, 19 Aug 2025 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623822; cv=none; b=Ecskedxerq4iyb9dN8iS4hifF88Wd+xSDyYyD5Bh3z+sPKgUXkFzF/m4wFbrlsoYd5vOI+u/Lo3c8FwbR8p23vZoItjNJcdLWtr0ooBQ0SCIA54+ZZX4/eJv5FuRCAF8KBrdEk6IqsExH74cODTVy4sEMRdgCr+0kPrTGO1sg/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623822; c=relaxed/simple;
	bh=0fTZgnoe7k8u+uK7++X+I32T+KDitJZaDdTp0OO6UVQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LRD2EyVRAl1tHZ3yabUY28qF/FiKNUIg6kaLItNTAN+vQ7NgoeO2tEhODusBJ16dBcfkUglRKJWubLG6EUzM9Jw6E207Ux5iDQT9/b90qYVgJo67KefJBiUgJWzem+YsjXtGdvAEBmtbiemch9/CMHijoRKw+5oDl8ZBGgCGdJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Si5oJqcx; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755623821; x=1787159821;
  h=date:from:to:cc:subject:message-id;
  bh=0fTZgnoe7k8u+uK7++X+I32T+KDitJZaDdTp0OO6UVQ=;
  b=Si5oJqcxPjNkxmSw8cQJypOu+6JkRQ0RHcUKLWYNDHSwa2vDQRf27h4k
   mFkxgBRH6SDSUgM0mL2s1W29npisax2yZsudltx3iH3jw5aYQDiqZhIqv
   bji0IX+mfcM0zeVPpiw1s99bXnfvUWOWS00npgEZH+mPRzBntH8j87n59
   Ei7B6WIr+f7wegz56apruDMywvaTgxKNnCqL2jkuwvAMx9pH2yY3yFJm3
   phtNmGf2eP315K7NuHHS9g1qRnsknL8lfx0xBzh+ohG9ZnV6BpNjoMiBW
   eF7UZW/te0A3Y9+OQvylq/e8AD+wSed51Ob2Yb09cN7Wdp7CZcntnGC70
   w==;
X-CSE-ConnectionGUID: 61lUEPiETG+r4ZVNpcDtlw==
X-CSE-MsgGUID: KPkLTTJ1TGGOP9K52DHa8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="56905589"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="56905589"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 10:16:32 -0700
X-CSE-ConnectionGUID: iFuclJfIRLKyFqSdNSWyRg==
X-CSE-MsgGUID: 6B7GYotATmCfWmCO4jKTsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="198762598"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 19 Aug 2025 10:16:31 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoPwj-000H9r-0d;
	Tue, 19 Aug 2025 17:16:29 +0000
Date: Wed, 20 Aug 2025 01:15:47 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 b52a57d2305d990e8101f097fcee45216477d2bd
Message-ID: <202508200141.R1S8Xd9u-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: b52a57d2305d990e8101f097fcee45216477d2bd  Merge branch 'fixes' into linux-next

elapsed time: 1444m

configs tested: 126
configs skipped: 3

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
arc                     nsimosci_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250819    gcc-14.3.0
arc                   randconfig-002-20250819    gcc-11.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                         at91_dt_defconfig    clang-22
arm                         bcm2835_defconfig    clang-22
arm                   randconfig-001-20250819    gcc-12.5.0
arm                   randconfig-002-20250819    gcc-10.5.0
arm                   randconfig-003-20250819    gcc-10.5.0
arm                   randconfig-004-20250819    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250819    gcc-14.3.0
arm64                 randconfig-002-20250819    clang-22
arm64                 randconfig-003-20250819    gcc-8.5.0
arm64                 randconfig-004-20250819    clang-16
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250819    gcc-15.1.0
csky                  randconfig-002-20250819    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250819    clang-22
hexagon               randconfig-002-20250819    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250819    gcc-12
i386        buildonly-randconfig-002-20250819    clang-20
i386        buildonly-randconfig-003-20250819    clang-20
i386        buildonly-randconfig-004-20250819    clang-20
i386        buildonly-randconfig-005-20250819    clang-20
i386        buildonly-randconfig-006-20250819    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250819    gcc-15.1.0
loongarch             randconfig-002-20250819    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           xway_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250819    gcc-8.5.0
nios2                 randconfig-002-20250819    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250819    gcc-10.5.0
parisc                randconfig-002-20250819    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          g5_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250819    clang-22
powerpc               randconfig-002-20250819    gcc-10.5.0
powerpc               randconfig-003-20250819    clang-22
powerpc64             randconfig-001-20250819    clang-22
powerpc64             randconfig-002-20250819    clang-22
powerpc64             randconfig-003-20250819    gcc-10.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250819    clang-22
riscv                 randconfig-002-20250819    clang-22
s390                             alldefconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250819    gcc-8.5.0
s390                  randconfig-002-20250819    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          kfr2r09_defconfig    gcc-15.1.0
sh                    randconfig-001-20250819    gcc-15.1.0
sh                    randconfig-002-20250819    gcc-15.1.0
sh                          urquell_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250819    gcc-8.5.0
sparc                 randconfig-002-20250819    gcc-11.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250819    clang-22
sparc64               randconfig-002-20250819    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250819    clang-18
um                    randconfig-002-20250819    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250819    clang-20
x86_64      buildonly-randconfig-002-20250819    clang-20
x86_64      buildonly-randconfig-003-20250819    clang-20
x86_64      buildonly-randconfig-004-20250819    clang-20
x86_64      buildonly-randconfig-005-20250819    clang-20
x86_64      buildonly-randconfig-006-20250819    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250819    gcc-8.5.0
xtensa                randconfig-002-20250819    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

