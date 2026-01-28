Return-Path: <linux-acpi+bounces-20713-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFaaOW4jemmv2wEAu9opvQ
	(envelope-from <linux-acpi+bounces-20713-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 15:55:42 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A01AA3537
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 15:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DC793004231
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 14:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCC32690F9;
	Wed, 28 Jan 2026 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAOOwSTx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7324229B8E1;
	Wed, 28 Jan 2026 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611968; cv=none; b=dOjhlK1LoipwEUzbINxmC9kgXIUGMs3iyWMbOmPFJDEmvbvpLktmwX7NBK8kG1Gv7lDBxAVNH58nqpf84MhiTjPoRtwdA1bmysAuqfCruSWsb0Z+iXzb4i+lpseqngPwjGUBabhWWoqS2B3IfrZ0SKeofOrGYQhaA1exs64NUJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611968; c=relaxed/simple;
	bh=EnPfrQ6TbHo7xBirLrwfR7OFUtYfvLFnfY2hABM7eMU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AwPKW+V3Zsdp0agbBFOtvXHw24TddpjimEYyzP4px5LqMqtyq5GKHaez9UPtaHPBTgpSfIzI1y73RdHDVpod/3nhnXChKtoLIU90j/WQ0Lk4N20Mf28SpB2nYv/hrdjKhucful1wcxKB4YJ5KH8HdfnbmyHneA80lSpv+EkrskU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAOOwSTx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769611967; x=1801147967;
  h=date:from:to:cc:subject:message-id;
  bh=EnPfrQ6TbHo7xBirLrwfR7OFUtYfvLFnfY2hABM7eMU=;
  b=YAOOwSTxg/rPMYRblMmtnSK83NX+tHbj0p2pgB3xMwISh8CIq/YpwZD/
   xmH7wezV87tv1lCyDBEX4pEvm2Nuif+MG4ytYMcjRbpL5j6HWAty+Bzi7
   4l1qC45ZXIrP20gOJ+ZPg5LvmMXXnfK+JXaIJyLRu89R2AYXHjqopYjG+
   nmXjNaCGE5BTc5kUbXcXr9hquzvX9IhioIjUN8Vl73Yql4D2uV0ut8If2
   dJceybonYnSuEVfP7YuWDuT8Tc1AI2VatatEGzZeN8j7tBXEyCK5D0SOh
   9Xp7p7Crvu0FZ553sy8AvAKIbK1I1sDq51Ime1lnOGmHUbcfhaBP0UbTS
   A==;
X-CSE-ConnectionGUID: 7u+r4hYaR5mrxRh9BqZhFQ==
X-CSE-MsgGUID: iW+asA8OQPCUkd9+aQrKDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70881657"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70881657"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 06:52:46 -0800
X-CSE-ConnectionGUID: 9yUgPVR9REqnfYAq2GJuZg==
X-CSE-MsgGUID: zsddxbXKSRuvVSvzcur4Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="245886745"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 28 Jan 2026 06:52:43 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vl6uP-00000000ZmK-2QCR;
	Wed, 28 Jan 2026 14:52:41 +0000
Date: Wed, 28 Jan 2026 22:51:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 4802892d9bdbe890394af0856826bb87b9a6f8c3
Message-ID: <202601282231.oMbmyEmD-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20713-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A01AA3537
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 4802892d9bdbe890394af0856826bb87b9a6f8c3  Merge branch 'acpi-sysfs' into bleeding-edge

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202601240833.jYdOreP4-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202601240853.XfwHlHep-lkp@intel.com

    kernel/time/hrtimer.c:946:41: error: call to undeclared function 'tick_nohz_is_active'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    kernel/time/hrtimer.c:946:48: error: implicit declaration of function 'tick_nohz_is_active'; did you mean 'tick_nohz_init'? [-Werror=implicit-function-declaration]
    kernel/time/hrtimer.c:946:48: error: implicit declaration of function 'tick_nohz_is_active'; did you mean 'tick_nohz_init'? [-Wimplicit-function-declaration]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- arc-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- arm-allnoconfig
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- arm64-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- csky-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- hexagon-allnoconfig
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- i386-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- loongarch-allnoconfig
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- m68k-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- microblaze-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- mips-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- nios2-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- openrisc-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- parisc-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- powerpc-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- riscv-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- s390-allnoconfig
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- sh-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- sparc-allnoconfig
|   `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active
|-- um-allnoconfig
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-allnoconfig
|   `-- kernel-time-hrtimer.c:error:call-to-undeclared-function-tick_nohz_is_active-ISO-C99-and-later-do-not-support-implicit-function-declarations
`-- xtensa-allnoconfig
    `-- kernel-time-hrtimer.c:error:implicit-declaration-of-function-tick_nohz_is_active

elapsed time: 1059m

configs tested: 217
configs skipped: 5

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    clang-22
arc                            hsdk_defconfig    clang-22
arc                   randconfig-001-20260128    gcc-8.5.0
arc                   randconfig-002-20260128    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                       aspeed_g4_defconfig    clang-22
arm                         at91_dt_defconfig    clang-22
arm                         bcm2835_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                        neponset_defconfig    gcc-15.2.0
arm                          pxa3xx_defconfig    gcc-15.2.0
arm                          pxa910_defconfig    gcc-15.2.0
arm                   randconfig-001-20260128    gcc-8.5.0
arm                   randconfig-002-20260128    gcc-8.5.0
arm                   randconfig-003-20260128    gcc-8.5.0
arm                   randconfig-004-20260128    gcc-8.5.0
arm                             rpc_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260128    gcc-14.3.0
arm64                 randconfig-002-20260128    gcc-14.3.0
arm64                 randconfig-003-20260128    gcc-14.3.0
arm64                 randconfig-004-20260128    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260128    gcc-14.3.0
csky                  randconfig-002-20260128    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260128    clang-22
hexagon               randconfig-002-20260128    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260128    clang-20
i386        buildonly-randconfig-002-20260128    clang-20
i386        buildonly-randconfig-003-20260128    clang-20
i386        buildonly-randconfig-004-20260128    clang-20
i386        buildonly-randconfig-005-20260128    clang-20
i386        buildonly-randconfig-006-20260128    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260128    gcc-14
i386                  randconfig-002-20260128    gcc-14
i386                  randconfig-003-20260128    gcc-14
i386                  randconfig-004-20260128    gcc-14
i386                  randconfig-005-20260128    gcc-14
i386                  randconfig-006-20260128    gcc-14
i386                  randconfig-007-20260128    gcc-14
i386                  randconfig-011-20260128    clang-20
i386                  randconfig-012-20260128    clang-20
i386                  randconfig-013-20260128    clang-20
i386                  randconfig-014-20260128    clang-20
i386                  randconfig-015-20260128    clang-20
i386                  randconfig-016-20260128    clang-20
i386                  randconfig-017-20260128    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260128    clang-22
loongarch             randconfig-002-20260128    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5275evb_defconfig    clang-22
m68k                        m5407c3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           ip27_defconfig    gcc-15.2.0
mips                           ip30_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260128    clang-22
nios2                 randconfig-002-20260128    clang-22
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                  or1klitex_defconfig    clang-22
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260128    gcc-11.5.0
parisc                randconfig-002-20260128    gcc-11.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                        fsp2_defconfig    gcc-15.2.0
powerpc                 linkstation_defconfig    clang-22
powerpc                      mgcoge_defconfig    gcc-15.2.0
powerpc                     mpc83xx_defconfig    gcc-15.2.0
powerpc                    mvme5100_defconfig    gcc-15.2.0
powerpc                      pasemi_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260128    gcc-11.5.0
powerpc               randconfig-002-20260128    gcc-11.5.0
powerpc64             randconfig-001-20260128    gcc-11.5.0
powerpc64             randconfig-002-20260128    gcc-11.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260128    gcc-13.4.0
riscv                 randconfig-002-20260128    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                          debug_defconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260128    gcc-13.4.0
s390                  randconfig-002-20260128    gcc-13.4.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260128    gcc-13.4.0
sh                    randconfig-002-20260128    gcc-13.4.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260128    gcc-11.5.0
sparc                 randconfig-002-20260128    gcc-11.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260128    gcc-11.5.0
sparc64               randconfig-002-20260128    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260128    gcc-11.5.0
um                    randconfig-002-20260128    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260128    gcc-14
x86_64      buildonly-randconfig-002-20260128    gcc-14
x86_64      buildonly-randconfig-003-20260128    gcc-14
x86_64      buildonly-randconfig-004-20260128    gcc-14
x86_64      buildonly-randconfig-005-20260128    gcc-14
x86_64      buildonly-randconfig-006-20260128    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260128    gcc-13
x86_64                randconfig-002-20260128    gcc-13
x86_64                randconfig-003-20260128    gcc-13
x86_64                randconfig-004-20260128    gcc-13
x86_64                randconfig-005-20260128    gcc-13
x86_64                randconfig-006-20260128    gcc-13
x86_64                randconfig-011-20260128    clang-20
x86_64                randconfig-012-20260128    clang-20
x86_64                randconfig-013-20260128    clang-20
x86_64                randconfig-014-20260128    clang-20
x86_64                randconfig-015-20260128    clang-20
x86_64                randconfig-016-20260128    clang-20
x86_64                randconfig-071-20260128    clang-20
x86_64                randconfig-072-20260128    clang-20
x86_64                randconfig-073-20260128    clang-20
x86_64                randconfig-074-20260128    clang-20
x86_64                randconfig-075-20260128    clang-20
x86_64                randconfig-076-20260128    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260128    gcc-11.5.0
xtensa                randconfig-002-20260128    gcc-11.5.0
xtensa                    xip_kc705_defconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

