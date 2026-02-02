Return-Path: <linux-acpi+bounces-20811-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AUcHMiX7f2n+0wIAu9opvQ
	(envelope-from <linux-acpi+bounces-20811-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Feb 2026 02:17:25 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B106C7BE9
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Feb 2026 02:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E9793003EF4
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Feb 2026 01:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BAD19006B;
	Mon,  2 Feb 2026 01:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I9tCHG2p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD834AEE2;
	Mon,  2 Feb 2026 01:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769995042; cv=none; b=UN2wkufwT2B1cBLILDltMyKBp8MfrgVBm2IjcirhMzighi0KsmxBfnHS0SENXxVJEa+UKUUs8w2iTgVtLgfzjA71+queeCpPaIbaLsjSpuMF0CYHKOQ/2T7e+zbCz1HfKv7H04DHqFPj/WNWM4+8kf66b7Ll7fmr3u6KjAJWL6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769995042; c=relaxed/simple;
	bh=rIsYGe19Z0vKiVU4CAIIRiGqlQzPkJwztsyxgsC+TcM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IQ3UYJP0TYyIlYfMPnS6iu2nXYHqJVmlfAtDFsddk9YxCI+ndKccUTp5s/sFxfiJoNOetwr8GvfvpRrFMlIEShVBobMQChjLmeeF/IIC49naYJrXgxl4/2TXxlwLXoZIbo1HcMnw/oAqQr/Jarqx9OYpYMok2rwumN+3kxhqaog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I9tCHG2p; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769995041; x=1801531041;
  h=date:from:to:cc:subject:message-id;
  bh=rIsYGe19Z0vKiVU4CAIIRiGqlQzPkJwztsyxgsC+TcM=;
  b=I9tCHG2pRRy45zhlwf1wiXBhvPZZRiiE0v2Kheez43jf/pbrK332ptz9
   7cnq6p8AaSKzz5AAHQS0dIabwHVHU6wVwxtpZeMBopljyQNkkwwd1gSf/
   4gogSWz+Vouhctwbqz6PkDPhu2oD8FZWV6s9FiUnTkvo8TIJe7/QBQQp+
   WZh4GcV1A1HVnX2afz+4wxhfawEs3wlCN94FYvSX8YHBWIQ2ZDEqTNoSC
   id53NqzSqvjCwaAFBF8KfeAeFxEQ7X12bdrtdGIGKs1JujA+uasn+ylns
   lcH0MJmFRS81PNj7sBHToEzlNbd1CoNf+8G5VUUwETRIT52lg1cgy8gTC
   w==;
X-CSE-ConnectionGUID: CKHf73DeTMGV9DNQewOUAw==
X-CSE-MsgGUID: woAuVEMCRnWOxN80951p4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="70872238"
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; 
   d="scan'208";a="70872238"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2026 17:17:20 -0800
X-CSE-ConnectionGUID: /Psd/HOHSEGmBxMxQ1FR1Q==
X-CSE-MsgGUID: svfvaxsQR1KYUsrIJhuaMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; 
   d="scan'208";a="240594357"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 01 Feb 2026 17:17:19 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vmiZ3-00000000fA0-06un;
	Mon, 02 Feb 2026 01:17:17 +0000
Date: Mon, 02 Feb 2026 09:16:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 534893ccf20087cf5e31fdaec25247bff6ec82a7
Message-ID: <202602020950.bUR0pyGG-lkp@intel.com>
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
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20811-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
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
X-Rspamd-Queue-Id: 0B106C7BE9
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 534893ccf20087cf5e31fdaec25247bff6ec82a7  Merge branch 'thermal-intel' into bleeding-edge

elapsed time: 724m

configs tested: 267
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260201    gcc-10.5.0
arc                   randconfig-001-20260202    gcc-14.3.0
arc                   randconfig-002-20260201    gcc-10.5.0
arc                   randconfig-002-20260202    gcc-14.3.0
arc                           tb10x_defconfig    clang-22
arc                    vdk_hs38_smp_defconfig    gcc-15.2.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                          collie_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                           h3600_defconfig    gcc-15.2.0
arm                         lpc18xx_defconfig    clang-22
arm                        multi_v7_defconfig    gcc-15.2.0
arm                        mvebu_v7_defconfig    gcc-15.2.0
arm                   randconfig-001-20260201    gcc-10.5.0
arm                   randconfig-001-20260202    gcc-14.3.0
arm                   randconfig-002-20260201    gcc-10.5.0
arm                   randconfig-002-20260202    gcc-14.3.0
arm                   randconfig-003-20260201    gcc-10.5.0
arm                   randconfig-003-20260202    gcc-14.3.0
arm                   randconfig-004-20260201    gcc-10.5.0
arm                   randconfig-004-20260202    gcc-14.3.0
arm                          sp7021_defconfig    gcc-15.2.0
arm                        spear3xx_defconfig    gcc-15.2.0
arm                           spitz_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260202    gcc-9.5.0
arm64                 randconfig-002-20260202    gcc-9.5.0
arm64                 randconfig-003-20260202    gcc-9.5.0
arm64                 randconfig-004-20260202    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260202    gcc-9.5.0
csky                  randconfig-002-20260202    gcc-9.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260201    gcc-15.2.0
hexagon               randconfig-001-20260202    clang-19
hexagon               randconfig-002-20260201    gcc-15.2.0
hexagon               randconfig-002-20260202    clang-19
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260202    gcc-14
i386        buildonly-randconfig-002-20260202    gcc-14
i386        buildonly-randconfig-003-20260202    gcc-14
i386        buildonly-randconfig-004-20260202    gcc-14
i386        buildonly-randconfig-005-20260202    gcc-14
i386        buildonly-randconfig-006-20260202    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260202    gcc-14
i386                  randconfig-002-20260202    gcc-14
i386                  randconfig-003-20260202    gcc-14
i386                  randconfig-004-20260202    gcc-14
i386                  randconfig-005-20260202    gcc-14
i386                  randconfig-006-20260202    gcc-14
i386                  randconfig-007-20260202    gcc-14
i386                  randconfig-011-20260202    clang-20
i386                  randconfig-012-20260202    clang-20
i386                  randconfig-013-20260202    clang-20
i386                  randconfig-014-20260202    clang-20
i386                  randconfig-015-20260202    clang-20
i386                  randconfig-016-20260202    clang-20
i386                  randconfig-017-20260202    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260201    gcc-15.2.0
loongarch             randconfig-001-20260202    clang-19
loongarch             randconfig-002-20260201    gcc-15.2.0
loongarch             randconfig-002-20260202    clang-19
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                        m5272c3_defconfig    gcc-15.2.0
m68k                        m5407c3_defconfig    clang-22
m68k                        stmark2_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        bcm47xx_defconfig    gcc-15.2.0
mips                           ip27_defconfig    gcc-15.2.0
mips                           ip30_defconfig    clang-22
mips                           mtx1_defconfig    gcc-15.2.0
mips                        vocore2_defconfig    clang-22
nios2                         3c120_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260201    gcc-15.2.0
nios2                 randconfig-001-20260202    clang-19
nios2                 randconfig-002-20260201    gcc-15.2.0
nios2                 randconfig-002-20260202    clang-19
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260202    gcc-8.5.0
parisc                randconfig-002-20260202    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      ep88xc_defconfig    clang-22
powerpc                        icon_defconfig    gcc-15.2.0
powerpc                   lite5200b_defconfig    gcc-15.2.0
powerpc                     mpc512x_defconfig    gcc-15.2.0
powerpc                 mpc832x_rdb_defconfig    gcc-15.2.0
powerpc                 mpc836x_rdk_defconfig    gcc-15.2.0
powerpc                     mpc83xx_defconfig    gcc-15.2.0
powerpc                     powernv_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260202    gcc-8.5.0
powerpc               randconfig-002-20260202    gcc-8.5.0
powerpc                    sam440ep_defconfig    gcc-15.2.0
powerpc                     tqm8540_defconfig    gcc-15.2.0
powerpc                     tqm8560_defconfig    clang-22
powerpc64             randconfig-001-20260202    gcc-8.5.0
powerpc64             randconfig-002-20260202    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv             nommu_k210_sdcard_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260201    gcc-13.4.0
riscv                 randconfig-002-20260201    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260201    gcc-13.4.0
s390                  randconfig-002-20260201    gcc-13.4.0
s390                       zfcpdump_defconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                        dreamcast_defconfig    gcc-15.2.0
sh                        edosk7705_defconfig    gcc-15.2.0
sh                     magicpanelr2_defconfig    gcc-15.2.0
sh                            migor_defconfig    gcc-15.2.0
sh                    randconfig-001-20260201    gcc-13.4.0
sh                    randconfig-002-20260201    gcc-13.4.0
sh                           se7206_defconfig    gcc-15.2.0
sh                           se7705_defconfig    gcc-15.2.0
sh                           se7724_defconfig    gcc-15.2.0
sh                             sh03_defconfig    gcc-15.2.0
sh                     sh7710voipgw_defconfig    clang-22
sh                        sh7785lcr_defconfig    gcc-15.2.0
sh                              ul2_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260201    gcc-8.5.0
sparc                 randconfig-001-20260202    gcc-12.5.0
sparc                 randconfig-002-20260201    gcc-8.5.0
sparc                 randconfig-002-20260202    gcc-12.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260201    gcc-8.5.0
sparc64               randconfig-001-20260202    gcc-12.5.0
sparc64               randconfig-002-20260201    gcc-8.5.0
sparc64               randconfig-002-20260202    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260201    gcc-8.5.0
um                    randconfig-001-20260202    gcc-12.5.0
um                    randconfig-002-20260201    gcc-8.5.0
um                    randconfig-002-20260202    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260201    clang-20
x86_64      buildonly-randconfig-001-20260202    gcc-14
x86_64      buildonly-randconfig-002-20260201    clang-20
x86_64      buildonly-randconfig-002-20260202    gcc-14
x86_64      buildonly-randconfig-003-20260201    clang-20
x86_64      buildonly-randconfig-003-20260202    gcc-14
x86_64      buildonly-randconfig-004-20260201    clang-20
x86_64      buildonly-randconfig-004-20260202    gcc-14
x86_64      buildonly-randconfig-005-20260201    clang-20
x86_64      buildonly-randconfig-005-20260202    gcc-14
x86_64      buildonly-randconfig-006-20260201    clang-20
x86_64      buildonly-randconfig-006-20260202    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260202    gcc-14
x86_64                randconfig-002-20260202    gcc-14
x86_64                randconfig-003-20260202    gcc-14
x86_64                randconfig-004-20260202    gcc-14
x86_64                randconfig-005-20260202    gcc-14
x86_64                randconfig-006-20260202    gcc-14
x86_64                randconfig-011-20260202    gcc-14
x86_64                randconfig-012-20260202    gcc-14
x86_64                randconfig-013-20260202    gcc-14
x86_64                randconfig-014-20260202    gcc-14
x86_64                randconfig-015-20260202    gcc-14
x86_64                randconfig-016-20260202    gcc-14
x86_64                randconfig-071-20260201    gcc-14
x86_64                randconfig-071-20260202    clang-20
x86_64                randconfig-072-20260201    gcc-14
x86_64                randconfig-072-20260202    clang-20
x86_64                randconfig-073-20260201    gcc-14
x86_64                randconfig-073-20260202    clang-20
x86_64                randconfig-074-20260201    gcc-14
x86_64                randconfig-074-20260202    clang-20
x86_64                randconfig-075-20260201    gcc-14
x86_64                randconfig-075-20260202    clang-20
x86_64                randconfig-076-20260201    gcc-14
x86_64                randconfig-076-20260202    clang-20
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
xtensa                       common_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260201    gcc-8.5.0
xtensa                randconfig-001-20260202    gcc-12.5.0
xtensa                randconfig-002-20260201    gcc-8.5.0
xtensa                randconfig-002-20260202    gcc-12.5.0
xtensa                    xip_kc705_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

