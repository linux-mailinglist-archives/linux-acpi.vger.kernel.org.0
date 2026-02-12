Return-Path: <linux-acpi+bounces-20947-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEelBna0jWl96AAAu9opvQ
	(envelope-from <linux-acpi+bounces-20947-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 12:07:34 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6FA12CDB0
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 12:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DBA41300C577
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 11:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FAA3164C2;
	Thu, 12 Feb 2026 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmUH2GIb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16D5EEAB;
	Thu, 12 Feb 2026 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770894449; cv=none; b=CUlNyKKSKa29+UA/7AVOY/1U0OnslQbNayoXdReHrynakooou35MCFnKMnOYi47yJnlY0iCvU2FdpRyXlrFt2bWnBd0OhHvAajl7ZVbWGko4DbwOVbbeI1oP9elw1hdUHAkXjIzW43BBg+teFqf9ZlqZYQOr1ydfmseYXWv7v5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770894449; c=relaxed/simple;
	bh=ow1be9y9MVNOCnQFTPvTSxEiugU7cWyU1T/RRQ3Fmkw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oVMsFdMWdyoucP/6XC6/a2xev9noor0Yyym9LlOL8pCddE9KNkZTzZzC2zTW17uPS1KZ8MuRlUZ1eKgfXnMQrEwBRNyCkcBIp+rgx2IATAQMrAax6JXsZrG3ibZTNWm+UR0G2u3O0NWJUyXH2risrIrpMjmdhpVLPETP0leEeVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JmUH2GIb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770894448; x=1802430448;
  h=date:from:to:cc:subject:message-id;
  bh=ow1be9y9MVNOCnQFTPvTSxEiugU7cWyU1T/RRQ3Fmkw=;
  b=JmUH2GIbG9wOd4udIHD854ZSCzwkSKsY5b2/tIeVNMNO5JTklK+pRqJh
   HFEqhduE8dqEEB7VjsJTrs+yQeegbcVOUYopMps+ZBRiSDf5knDXWHIjb
   inHFoMCJUEce4kmqR7UUhJ9updzG9ENKjP5nhyXcHoYX4WxPGv9kZcaGW
   rqYHbus1Q0Vi5/qTNON6mtKHvFTyUwN7jaaR/u20HsaWLuqMZCENr/JLV
   5vTlIcKoccD+GLs/1aoN4tS6KgMJnwk3R3MNxBrmtTOVwaITmvzsJX0qi
   QA3uRSLTPS/mDxC7olYfswhUdvQ5f6t1pvU6QSVZ8PgcZ9RSD2AiAegc3
   A==;
X-CSE-ConnectionGUID: Mteu1pmEQJuOhWVDf26Tmw==
X-CSE-MsgGUID: IwxxzLc3SkuBJ/TmX0wmHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71967216"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="71967216"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 03:07:28 -0800
X-CSE-ConnectionGUID: naQFYAjcTEOd1bR/QSQX3g==
X-CSE-MsgGUID: aWgmSoxLTfiY8Xc3+puRUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="211838938"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 Feb 2026 03:07:26 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vqUXb-00000000r6V-3VJU;
	Thu, 12 Feb 2026 11:07:23 +0000
Date: Thu, 12 Feb 2026 19:07:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 83acd2aae5963aa8c01cbbac98535b51b7471d38
Message-ID: <202602121906.i1BDmpEE-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20947-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 3B6FA12CDB0
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 83acd2aae5963aa8c01cbbac98535b51b7471d38  Merge branch 'acpi-button' into bleeding-edge

elapsed time: 871m

configs tested: 167
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260212    gcc-9.5.0
arc                   randconfig-002-20260212    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                           omap1_defconfig    gcc-15.2.0
arm                       omap2plus_defconfig    gcc-15.2.0
arm                   randconfig-001-20260212    gcc-8.5.0
arm                   randconfig-002-20260212    gcc-10.5.0
arm                   randconfig-003-20260212    clang-22
arm                   randconfig-004-20260212    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260212    clang-22
arm64                 randconfig-002-20260212    gcc-10.5.0
arm64                 randconfig-003-20260212    clang-22
arm64                 randconfig-004-20260212    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260212    gcc-15.2.0
csky                  randconfig-002-20260212    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260212    clang-22
hexagon               randconfig-002-20260212    clang-18
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260212    gcc-14
i386        buildonly-randconfig-002-20260212    gcc-14
i386        buildonly-randconfig-003-20260212    clang-20
i386        buildonly-randconfig-004-20260212    gcc-13
i386        buildonly-randconfig-005-20260212    gcc-14
i386        buildonly-randconfig-006-20260212    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260212    clang-20
i386                  randconfig-002-20260212    clang-20
i386                  randconfig-003-20260212    clang-20
i386                  randconfig-004-20260212    clang-20
i386                  randconfig-005-20260212    gcc-14
i386                  randconfig-006-20260212    gcc-14
i386                  randconfig-007-20260212    clang-20
i386                  randconfig-011-20260212    gcc-14
i386                  randconfig-012-20260212    gcc-12
i386                  randconfig-013-20260212    clang-20
i386                  randconfig-014-20260212    clang-20
i386                  randconfig-015-20260212    clang-20
i386                  randconfig-016-20260212    gcc-14
i386                  randconfig-017-20260212    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260212    clang-18
loongarch             randconfig-002-20260212    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath79_defconfig    gcc-15.2.0
mips                        omega2p_defconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260212    gcc-11.5.0
nios2                 randconfig-002-20260212    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260212    gcc-8.5.0
parisc                randconfig-002-20260212    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260212    clang-22
powerpc               randconfig-002-20260212    gcc-10.5.0
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20260212    clang-22
powerpc64             randconfig-002-20260212    gcc-11.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260212    gcc-9.5.0
riscv                 randconfig-002-20260212    clang-18
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260212    gcc-15.2.0
s390                  randconfig-002-20260212    clang-22
s390                       zfcpdump_defconfig    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260212    gcc-10.5.0
sh                    randconfig-002-20260212    gcc-12.5.0
sh                          sdk7786_defconfig    gcc-15.2.0
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260212    gcc-13.4.0
sparc                 randconfig-002-20260212    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260212    gcc-14.3.0
sparc64               randconfig-002-20260212    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260212    gcc-14
um                    randconfig-002-20260212    clang-22
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260212    clang-20
x86_64      buildonly-randconfig-002-20260212    clang-20
x86_64      buildonly-randconfig-003-20260212    gcc-14
x86_64      buildonly-randconfig-004-20260212    clang-20
x86_64      buildonly-randconfig-005-20260212    clang-20
x86_64      buildonly-randconfig-006-20260212    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260212    gcc-12
x86_64                randconfig-002-20260212    gcc-14
x86_64                randconfig-003-20260212    gcc-14
x86_64                randconfig-004-20260212    gcc-14
x86_64                randconfig-005-20260212    clang-20
x86_64                randconfig-006-20260212    clang-20
x86_64                randconfig-011-20260212    clang-20
x86_64                randconfig-012-20260212    gcc-14
x86_64                randconfig-013-20260212    clang-20
x86_64                randconfig-014-20260212    gcc-13
x86_64                randconfig-015-20260212    gcc-14
x86_64                randconfig-016-20260212    clang-20
x86_64                randconfig-071-20260212    clang-20
x86_64                randconfig-072-20260212    gcc-14
x86_64                randconfig-073-20260212    gcc-14
x86_64                randconfig-074-20260212    gcc-14
x86_64                randconfig-075-20260212    gcc-14
x86_64                randconfig-076-20260212    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260212    gcc-8.5.0
xtensa                randconfig-002-20260212    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

