Return-Path: <linux-acpi+bounces-13071-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948CFA8AF4D
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Apr 2025 06:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B533BFCC2
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Apr 2025 04:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F3022A4E4;
	Wed, 16 Apr 2025 04:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HN9wTUWU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE4622A4E9;
	Wed, 16 Apr 2025 04:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744778658; cv=none; b=X3tybGH+fDvorkjfDglxEU5yuWiDjYNLkeHB46X9xeGlfuZ/I+KLL9rY/ZaLlqjkTctOXiO1lclJmy/11WsVsr1tKnF37ec/aeW2gCyQULFp1RxLO2JcNU3Zmj8OKUcVFDxv94yF0iUZOtfl4AEglq6o+yFaUtC8aBLSFSYzmDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744778658; c=relaxed/simple;
	bh=UvtYsKzxmsrlyk4Ve4cXnLzHORt0pQYPk1Ml4T5SR78=;
	h=Date:From:To:Cc:Subject:Message-ID; b=snXPXRt217GKfjlBoasLN57uATYN8nFN2VKp3PAHFPDcjO96Pl8tYlelho71LgQSj/xDEkaHBXuvM2Zt/IL5ngJ5F4Iwyszu8g3N/4LIbufirDXQh9Byz2hj4Q8E1otujbLgrKRivkmDoek76MsEvQit8X9VUCbpsNnBJ2rCstg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HN9wTUWU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744778656; x=1776314656;
  h=date:from:to:cc:subject:message-id;
  bh=UvtYsKzxmsrlyk4Ve4cXnLzHORt0pQYPk1Ml4T5SR78=;
  b=HN9wTUWUy2Sl3dqi/g0P+qKpIdJ1aYdDZJI67ITpxRnxS7E9z8oKZVZu
   KE71TIAfl7dVPmQNGBC1tSby7Fcbw67AW3i/Lf+GJ+6HOh49Deh31xhtR
   JyHfaTs0oq5bVh1jTl+mTHxyrumrWcWrXwDRskkIJXH6W2lDLmGRMVp3+
   lg+O5R8a8/+00lj/3vw2SFZfLXM0j0lN85stmZydWdDl/ySaj9UPcnnv2
   EJ654NlPDhNoaJXRbHt86LFhPNQ7ydzWiTjJzWxaYIwhCMHh2XH+S0fVT
   LZADCR8+fOhR4yAdyCar5om6eqaae9RzyaD/hOqb3TD1Vd3vtSAmmQfvC
   A==;
X-CSE-ConnectionGUID: AqrT7uExS7eb9SnLwFxscg==
X-CSE-MsgGUID: jQKufkqnQb6WVavE4uidJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="45445483"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="45445483"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 21:44:08 -0700
X-CSE-ConnectionGUID: 0Eio3+/WTbWfkZRDPoBpwg==
X-CSE-MsgGUID: Ll6UtypJQLKm+c3vJCvBzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="134426652"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 Apr 2025 21:44:07 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u4jIC-000Gjy-0s;
	Tue, 15 Apr 2025 16:37:48 +0000
Date: Wed, 16 Apr 2025 00:37:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 df8d205d1ef21ee66376042321fcfc9c27527d11
Message-ID: <202504160053.hSUo5PyO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: df8d205d1ef21ee66376042321fcfc9c27527d11  Merge branch 'pm-cpufreq-fixes' into fixes

elapsed time: 1450m

configs tested: 107
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250415    gcc-14.2.0
arc                   randconfig-002-20250415    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                         bcm2835_defconfig    clang-21
arm                         lpc18xx_defconfig    clang-21
arm                   randconfig-001-20250415    clang-21
arm                   randconfig-002-20250415    clang-21
arm                   randconfig-003-20250415    gcc-10.5.0
arm                   randconfig-004-20250415    gcc-6.5.0
arm64                            allmodconfig    clang-19
arm64                 randconfig-001-20250415    clang-16
arm64                 randconfig-002-20250415    gcc-7.5.0
arm64                 randconfig-003-20250415    gcc-9.5.0
arm64                 randconfig-004-20250415    gcc-9.5.0
csky                  randconfig-001-20250415    gcc-13.3.0
csky                  randconfig-002-20250415    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250415    clang-20
hexagon               randconfig-002-20250415    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250415    clang-20
i386        buildonly-randconfig-002-20250415    clang-20
i386        buildonly-randconfig-003-20250415    clang-20
i386        buildonly-randconfig-004-20250415    clang-20
i386        buildonly-randconfig-005-20250415    gcc-12
i386        buildonly-randconfig-006-20250415    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20250415    gcc-14.2.0
loongarch             randconfig-002-20250415    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250415    gcc-13.3.0
nios2                 randconfig-002-20250415    gcc-7.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250415    gcc-12.4.0
parisc                randconfig-002-20250415    gcc-10.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc                      pasemi_defconfig    clang-21
powerpc               randconfig-001-20250415    gcc-5.5.0
powerpc               randconfig-002-20250415    clang-17
powerpc               randconfig-003-20250415    gcc-7.5.0
powerpc64             randconfig-001-20250415    gcc-7.5.0
powerpc64             randconfig-002-20250415    clang-17
powerpc64             randconfig-003-20250415    gcc-10.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250415    gcc-14.2.0
riscv                 randconfig-002-20250415    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250415    clang-21
s390                  randconfig-002-20250415    gcc-7.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250415    gcc-11.5.0
sh                    randconfig-002-20250415    gcc-9.3.0
sh                           sh2007_defconfig    gcc-14.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sparc                            alldefconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250415    gcc-6.5.0
sparc                 randconfig-002-20250415    gcc-12.4.0
sparc64               randconfig-001-20250415    gcc-14.2.0
sparc64               randconfig-002-20250415    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250415    clang-21
um                    randconfig-002-20250415    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250415    clang-20
x86_64      buildonly-randconfig-002-20250415    gcc-11
x86_64      buildonly-randconfig-003-20250415    gcc-12
x86_64      buildonly-randconfig-004-20250415    clang-20
x86_64      buildonly-randconfig-005-20250415    clang-20
x86_64      buildonly-randconfig-006-20250415    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250415    gcc-6.5.0
xtensa                randconfig-002-20250415    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

