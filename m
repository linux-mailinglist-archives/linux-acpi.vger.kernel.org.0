Return-Path: <linux-acpi+bounces-9106-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EB59B59C2
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 03:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8AC284545
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 02:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3670517C224;
	Wed, 30 Oct 2024 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kCq3rXyH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1348D531;
	Wed, 30 Oct 2024 02:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730254185; cv=none; b=gH9tVP6zFsnbt7EDumUpTQuxbwjLaJy0if9gOUawvojSc9b7+QzM1Q5kxbT7Hk0jf0/zDeg9QIsgaKY04R5nHtMq2RZ4sUafbflyHOQKTQwa3xZ1G64mJbC2qcRURpSZuAhSJnBYRiWjmznuM/JRHlrienGKX3w4ka0kJ9+xRGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730254185; c=relaxed/simple;
	bh=tyxsw09VnP158ILhCIrWL66PS9WP3oA2XNlhC/L75e4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I3eJNOB+Q08EYsB1r2z2sDmoXbE3LiRU+VlD3G/U9hXJH6P1M+0i09ug1ojjF+iwN//IVGd9G6d86kNxELyTicCTZUv6eKZ2DxeB6TvBn3eRU28VuB3V6+t+6sQWlH1B/3SMKyxqktvQElB+QBEPypSGWuyLRW9GKcRNiniGJs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kCq3rXyH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730254182; x=1761790182;
  h=date:from:to:cc:subject:message-id;
  bh=tyxsw09VnP158ILhCIrWL66PS9WP3oA2XNlhC/L75e4=;
  b=kCq3rXyHFGs2KjqWPXXTlCWfc+ZuJ0C2MyxZ5SBm+OkVZor3x6ndAu+U
   79g0Fr3i0QmgBoUdDGUjDFAr5Ew7/CJf3EeUkLKajHOF6bXEjqq4mhytW
   WVl9NLypoVe0PiDBb0hLUPlckps7pOZbmbO8echbY/UJl6L4xF2TIUrg0
   I52yGq/TBnC4BRhOwl2K+4eXKa2Fu9sKj9aA+1czhh4rYCgQOJNNAy+HY
   K8JeBnCdUKCUDGOXfPj11pAd0FwNS0t2Nyyvz2Q2UDWIhaHVHNI79NsS4
   meHICdfMfuyb8tiGuZgiY8GezZc8WVCRPEImLis9H5pFYyiYwmqC82iDb
   w==;
X-CSE-ConnectionGUID: 7LfknW1CRFqRzCvW1/WiRA==
X-CSE-MsgGUID: N09wo8UBQVycRzG61wEVow==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="33735792"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="33735792"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 19:09:42 -0700
X-CSE-ConnectionGUID: L7fMuRa/ThC9uuOvnYMgjQ==
X-CSE-MsgGUID: 70hlRWACTju3KuxuoIj1NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="82971052"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 29 Oct 2024 19:09:41 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5y9S-000eOu-0g;
	Wed, 30 Oct 2024 02:09:38 +0000
Date: Wed, 30 Oct 2024 10:09:33 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 c58e12abb31c51ef657e1d048682070212062106
Message-ID: <202410301026.maEai9Cn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: c58e12abb31c51ef657e1d048682070212062106  Merge branch 'acpi-cppc' into fixes

elapsed time: 800m

configs tested: 115
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
arc                     haps_hs_smp_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                        keystone_defconfig    clang-20
arm                        mvebu_v5_defconfig    clang-20
arm                             rpc_defconfig    clang-20
arm                         s5pv210_defconfig    clang-20
arm                           sama7_defconfig    clang-20
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
i386        buildonly-randconfig-001-20241030    gcc-12
i386        buildonly-randconfig-002-20241030    gcc-12
i386        buildonly-randconfig-003-20241030    gcc-12
i386        buildonly-randconfig-004-20241030    gcc-12
i386        buildonly-randconfig-005-20241030    gcc-12
i386        buildonly-randconfig-006-20241030    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241030    gcc-12
i386                  randconfig-002-20241030    gcc-12
i386                  randconfig-003-20241030    gcc-12
i386                  randconfig-004-20241030    gcc-12
i386                  randconfig-005-20241030    gcc-12
i386                  randconfig-006-20241030    gcc-12
i386                  randconfig-011-20241030    gcc-12
i386                  randconfig-012-20241030    gcc-12
i386                  randconfig-013-20241030    gcc-12
i386                  randconfig-014-20241030    gcc-12
i386                  randconfig-015-20241030    gcc-12
i386                  randconfig-016-20241030    gcc-12
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
mips                          ath79_defconfig    clang-20
mips                        maltaup_defconfig    clang-20
mips                          rb532_defconfig    clang-20
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
powerpc                       ppc64_defconfig    clang-20
powerpc                     tqm8541_defconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               alldefconfig    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                          rsk7264_defconfig    clang-20
sh                  sh7785lcr_32bit_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  audio_kc705_defconfig    clang-20
xtensa                  cadence_csp_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

