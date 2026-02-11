Return-Path: <linux-acpi+bounces-20927-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC36Hvo4jGlZjgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20927-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 09:08:26 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4691220EA
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 09:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BAE730067BB
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 08:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333A734F494;
	Wed, 11 Feb 2026 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGInnLZw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A572726F288;
	Wed, 11 Feb 2026 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770797304; cv=none; b=lshJ5FZrSqDkSh3PUAm+vAttHVZbCcQOF3ADcnKfYCrvCCcsx/jNFsaklpPIsioECvUEs/xIBywmGKfteSe8owxKtRFjS+EyIRQr1xe2GJAVzoV1TDJ5CfRE6+VnfD/dGT0nRVKWXU2tIJJd362LxI3KlcRw37ItxSfvwWu8iYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770797304; c=relaxed/simple;
	bh=e3n3/VaMUNKSaCHCl7BoDqU640WJIEmWndO+jawtd9E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=s6TFi+KnkzxJAV9PIR6AQVU3anS96Eg9pL/6OatufTBSEBIpesfWsxNo1xQHxCCjKAyQAl7qYPj9pNwYOFNwTr/ko/8BEXdJR0PRnTOBPRsQoUHvzv5DOmA+ptGEIrKqOO6WlNVBx+OcBvobai0roye5qjppJ6+D2o9U/3u641k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGInnLZw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770797303; x=1802333303;
  h=date:from:to:cc:subject:message-id;
  bh=e3n3/VaMUNKSaCHCl7BoDqU640WJIEmWndO+jawtd9E=;
  b=NGInnLZwbklZwdwOHTMHKehvxzggwwiCoJNSxWpUY2yf2/HiIuJAgPhO
   Lz8LKVg+CkvQyZHUUCL+Ht8Q2M7r258k0okgDmq0SQH4eHzhLs1Npzm2Q
   J/pSyQYSDy9hXj77y3kFAr1zj6F9lg9+McUu36CT55//gG6vUfEt4oB69
   Zf9SGqcWhpvVJcbywkT/TPjKmZGBMGcg3UJ4mndAHoQid2p1aN14+TfpA
   +UQ2Hv5mSjcY+6kPDpmvCQKKYkiMPkC1+AFjxvJychWttXaiAdfNUz3M3
   t3gO8+cW2xiR6xz7lu/0Z5cq9dri6VvJSRvkzgHhvGSZuqWOuW82uZBNe
   g==;
X-CSE-ConnectionGUID: cAc6E+4BSO+AgmbASdcVVQ==
X-CSE-MsgGUID: IgRFbbGTTcGyvEHppAg6DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="59505525"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="59505525"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:08:22 -0800
X-CSE-ConnectionGUID: jHVC4BT9QxqV1CET4Qao5A==
X-CSE-MsgGUID: WK+1er3BR4yxjFOPNF067A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="216699642"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 Feb 2026 00:08:21 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vq5Gk-00000000poV-0UE2;
	Wed, 11 Feb 2026 08:08:18 +0000
Date: Wed, 11 Feb 2026 16:08:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH UNVERIFIED
 WARNING 310ad169e342f46589d39f6c52316445f029621a
Message-ID: <202602111600.g4Sl5zGY-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20927-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 1D4691220EA
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 310ad169e342f46589d39f6c52316445f029621a  Merge branch 'experimental/acpi-driver-conversion' into bleeding-edge

Unverified Warning (likely false positive, kindly check if interested):

    drivers/platform/x86/classmate-laptop.c:1025 cmpc_ipml_probe() warn: 'ipml->rf' is an error pointer or valid
    drivers/platform/x86/toshiba_bluetooth.c:261 toshiba_bt_rfkill_probe() warn: 'bt_dev->rfk' is an error pointer or valid

Warning ids grouped by kconfigs:

recent_errors
`-- i386-randconfig-r071-20260211
    |-- drivers-platform-x86-classmate-laptop.c-cmpc_ipml_probe()-warn:ipml-rf-is-an-error-pointer-or-valid
    `-- drivers-platform-x86-toshiba_bluetooth.c-toshiba_bt_rfkill_probe()-warn:bt_dev-rfk-is-an-error-pointer-or-valid

elapsed time: 1063m

configs tested: 161
configs skipped: 3

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    gcc-15.2.0
arc                   randconfig-001-20260210    gcc-14.3.0
arc                   randconfig-002-20260210    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20260210    clang-19
arm                   randconfig-002-20260210    clang-20
arm                   randconfig-003-20260210    clang-22
arm                   randconfig-004-20260210    clang-22
arm                       spear13xx_defconfig    gcc-15.2.0
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260211    gcc-8.5.0
arm64                 randconfig-002-20260211    gcc-15.2.0
arm64                 randconfig-003-20260211    gcc-15.2.0
arm64                 randconfig-004-20260211    gcc-14.3.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260211    gcc-15.2.0
csky                  randconfig-002-20260211    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260211    clang-22
hexagon               randconfig-002-20260211    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260211    clang-20
i386        buildonly-randconfig-002-20260211    gcc-12
i386        buildonly-randconfig-003-20260211    clang-20
i386        buildonly-randconfig-004-20260211    clang-20
i386        buildonly-randconfig-005-20260211    gcc-14
i386        buildonly-randconfig-006-20260211    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260211    gcc-14
i386                  randconfig-002-20260211    gcc-14
i386                  randconfig-003-20260211    gcc-14
i386                  randconfig-004-20260211    clang-20
i386                  randconfig-005-20260211    gcc-14
i386                  randconfig-006-20260211    clang-20
i386                  randconfig-007-20260211    gcc-14
i386                  randconfig-011-20260211    clang-20
i386                  randconfig-012-20260211    clang-20
i386                  randconfig-013-20260211    clang-20
i386                  randconfig-014-20260211    clang-20
i386                  randconfig-015-20260211    clang-20
i386                  randconfig-016-20260211    clang-20
i386                  randconfig-017-20260211    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260211    clang-22
loongarch             randconfig-002-20260211    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
m68k                        m5407c3_defconfig    gcc-15.2.0
m68k                        stmark2_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260211    gcc-11.5.0
nios2                 randconfig-002-20260211    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260211    gcc-14.3.0
parisc                randconfig-002-20260211    gcc-15.2.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      pmac32_defconfig    clang-22
powerpc                     rainier_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260211    clang-16
powerpc               randconfig-002-20260211    clang-22
powerpc64             randconfig-001-20260211    clang-17
powerpc64             randconfig-002-20260211    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260211    gcc-8.5.0
riscv                 randconfig-002-20260211    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260211    gcc-13.4.0
s390                  randconfig-002-20260211    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260211    gcc-9.5.0
sh                    randconfig-002-20260211    gcc-13.4.0
sh                           se7343_defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260211    gcc-8.5.0
sparc                 randconfig-002-20260211    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260211    gcc-15.2.0
sparc64               randconfig-002-20260211    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260211    clang-17
um                    randconfig-002-20260211    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260211    clang-20
x86_64                randconfig-002-20260211    clang-20
x86_64                randconfig-003-20260211    clang-20
x86_64                randconfig-004-20260211    clang-20
x86_64                randconfig-005-20260211    clang-20
x86_64                randconfig-006-20260211    clang-20
x86_64                randconfig-011-20260211    gcc-14
x86_64                randconfig-012-20260211    gcc-14
x86_64                randconfig-013-20260211    gcc-12
x86_64                randconfig-014-20260211    clang-20
x86_64                randconfig-015-20260211    gcc-14
x86_64                randconfig-016-20260211    gcc-14
x86_64                randconfig-071-20260211    gcc-14
x86_64                randconfig-072-20260211    clang-20
x86_64                randconfig-073-20260211    gcc-14
x86_64                randconfig-074-20260211    clang-20
x86_64                randconfig-075-20260211    gcc-14
x86_64                randconfig-076-20260211    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260211    gcc-8.5.0
xtensa                randconfig-002-20260211    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

