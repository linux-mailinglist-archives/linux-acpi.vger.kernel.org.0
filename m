Return-Path: <linux-acpi+bounces-10124-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3B99EE6B1
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2024 13:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D452818ED
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2024 12:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585EE2066EE;
	Thu, 12 Dec 2024 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IhoYhCIm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E9C2135A9;
	Thu, 12 Dec 2024 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734006447; cv=none; b=S0tcBUQwHs2rOBrFzfnEq/p8GBPKGk/koodgRoQyBUJZKtQvaFbiR3HpIMmMcUexBfFlJ0Xc0n3Mqt2BxEcCz3pblPhCxbzDPuWV+nFNOXNz9nnbDQadrILzZ4pPWhu4cX65xNGgUvYjyP2akvRtlx7plyp1jc3dAhS90Kt1EP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734006447; c=relaxed/simple;
	bh=tjTVi1Lkd/yduavLI55pAe7unxITEcfJKFMcvf65e6I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jtyepjxvNVVOxw6QLSU9LTJy6zlx5PBihfJ4uK/jw3Uv1ja0TJIM7A4w/iIo0sc5PCY08PIgmSNuOgFcpiw/2MFbBl9wZ8HlY2j311M1ynOq10y1H9XgM6QXmYbft6roOGQYcmgHQLZ3Dxt/5WbvWOiTmLtImo6WR2tvAj5JOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IhoYhCIm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734006445; x=1765542445;
  h=date:from:to:cc:subject:message-id;
  bh=tjTVi1Lkd/yduavLI55pAe7unxITEcfJKFMcvf65e6I=;
  b=IhoYhCImK1/P+ERvq7OQADueEN/Xt8PkVcuG+yWZc7zqVu1OK+diSxzs
   vgRjL3du+gpThztDbQvM7voKUPkn8nMQiHuxXUCWD/sXMHpT9Lds6eEx7
   ALP2JBVQ8CNEa2hJeKAm8UaY0lUzaFWAdHx7SOwTcH91AxDnGO/z9PQE9
   9g1hGazdAjzJtqmP5vgFMdVS3I50Heo2cXSy0b11+CYpJm3N7+nz3/TSy
   9xtuyH0x21Vy2AWJfQjmdYcwux5J6ziUh6asjhWYt/b+FGE5zgsBib681
   K/aeHEygtr3drT2WIgZbMfaImqDn11XhqZ9vDpBX8MIFR0LVjmYudw/n4
   w==;
X-CSE-ConnectionGUID: f9HtzudYTxiBLhE41kHP+A==
X-CSE-MsgGUID: vOSI0wScS8qlUoS4WGHpHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="45028344"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="45028344"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 04:27:25 -0800
X-CSE-ConnectionGUID: ZkQ2TYuuTC6fn35RlbA8rQ==
X-CSE-MsgGUID: NWgVknB3Qye+4JwWhIt4Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="101311707"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 12 Dec 2024 04:27:23 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLiHo-0007pV-23;
	Thu, 12 Dec 2024 12:27:20 +0000
Date: Thu, 12 Dec 2024 20:27:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 bf041214ff9adfbaac0e54cdc99e4af8f91f5c86
Message-ID: <202412122004.19rk3Cvj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: bf041214ff9adfbaac0e54cdc99e4af8f91f5c86  Merge branch 'pm-runtime' into fixes

elapsed time: 1467m

configs tested: 81
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.2.0
arc                   randconfig-001-20241212    gcc-13.2.0
arc                   randconfig-002-20241212    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                   randconfig-001-20241212    gcc-14.2.0
arm                   randconfig-002-20241212    clang-20
arm                   randconfig-003-20241212    clang-19
arm                   randconfig-004-20241212    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241212    clang-20
arm64                 randconfig-002-20241212    clang-15
arm64                 randconfig-003-20241212    clang-20
arm64                 randconfig-004-20241212    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241212    gcc-14.2.0
csky                  randconfig-002-20241212    gcc-14.2.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20241212    clang-14
hexagon               randconfig-002-20241212    clang-16
i386        buildonly-randconfig-001-20241212    clang-19
i386        buildonly-randconfig-002-20241212    clang-19
i386        buildonly-randconfig-003-20241212    clang-19
i386        buildonly-randconfig-004-20241212    clang-19
i386        buildonly-randconfig-005-20241212    clang-19
i386        buildonly-randconfig-006-20241212    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241212    gcc-14.2.0
loongarch             randconfig-002-20241212    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241212    gcc-14.2.0
nios2                 randconfig-002-20241212    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20241212    gcc-14.2.0
parisc                randconfig-002-20241212    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20241212    gcc-14.2.0
powerpc               randconfig-002-20241212    clang-20
powerpc               randconfig-003-20241212    clang-15
powerpc64             randconfig-001-20241212    clang-20
powerpc64             randconfig-002-20241212    gcc-14.2.0
powerpc64             randconfig-003-20241212    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20241212    clang-17
riscv                 randconfig-002-20241212    clang-20
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241212    clang-18
s390                  randconfig-002-20241212    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20241212    gcc-14.2.0
sh                    randconfig-002-20241212    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241212    gcc-14.2.0
sparc                 randconfig-002-20241212    gcc-14.2.0
sparc64               randconfig-001-20241212    gcc-14.2.0
sparc64               randconfig-002-20241212    gcc-14.2.0
um                                allnoconfig    clang-18
um                    randconfig-001-20241212    gcc-12
um                    randconfig-002-20241212    clang-20
x86_64      buildonly-randconfig-001-20241212    clang-19
x86_64      buildonly-randconfig-002-20241212    gcc-12
x86_64      buildonly-randconfig-003-20241212    clang-19
x86_64      buildonly-randconfig-004-20241212    clang-19
x86_64      buildonly-randconfig-005-20241212    gcc-11
x86_64      buildonly-randconfig-006-20241212    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241212    gcc-14.2.0
xtensa                randconfig-002-20241212    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

