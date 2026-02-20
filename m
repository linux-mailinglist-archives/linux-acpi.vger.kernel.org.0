Return-Path: <linux-acpi+bounces-21017-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AERJxTQl2mM8wIAu9opvQ
	(envelope-from <linux-acpi+bounces-21017-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 04:08:04 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8E4164580
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 04:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0865A301919C
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 03:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404E3278156;
	Fri, 20 Feb 2026 03:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BP9dPQV7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B7EEEC0;
	Fri, 20 Feb 2026 03:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771556881; cv=none; b=tPUN3PQtXYyJGB9HxN+h7aY1BVl9z4+m39UBjrlML+/uRNfeBqyCGz5d6OyeawHcv/WxYyVLqH9EyCt1LYalVPPF3TUKboCUBiDAzw9mozrGpgNdQLBTuzTutlR7Ajqn3NEdnouvbUXyZL42Waudv+mdGi+HVNU/IGTK4H8u2k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771556881; c=relaxed/simple;
	bh=ouxEWjRTMhcNt7SnzAhjGI3OepmurQ6wScRQrvcuAk8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=d4rLp+SDz8BodPzzIhpqln47/Q+iKNlKIZm2A895tm6wyEHAAoUgNMHgcCv0yjiKqGAllcRzjd8zm1LGbSYmO/3x3foCT04ieumjrkVbqhk15sI5ZKhaX+7scb5rQFXfib06dJv4x/YGMYUXaT9mJOHSGAR9KjXlRmI1ycqeWRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BP9dPQV7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771556880; x=1803092880;
  h=date:from:to:cc:subject:message-id;
  bh=ouxEWjRTMhcNt7SnzAhjGI3OepmurQ6wScRQrvcuAk8=;
  b=BP9dPQV7GggLihDXLUm7xlqCZz2xotZmNRZwIv7tx0uzPiaFx+OZnGxE
   r/FxbrNKfmQCH9ezhZrF79R6OfQOgloyI8GITJmp5AwIwgjla3BRAzShM
   u0roCyf0GOxQqPI85HiLbHACn1etl5Vld+KcwFW7aK6rtlvzXdE9MMmz0
   1fwEaZenmNDiM8CI5o9okUmMt0QqWu0Y715Nn03Go+cWQtIGTmazPcx7V
   x3UZfbkTSyVQ8pCtGfCdV4zBNOUoXKAjkYpX1CcPEzVHn5DaiQce0fs//
   RC0vORjaquvQJfr0tuGtMU0Mgcc5V4Dg1B8RAoKSQ01dYOSlQzbzvspVP
   Q==;
X-CSE-ConnectionGUID: QbimhD0IS3aoN4ZLa6Yq5g==
X-CSE-MsgGUID: EoGn44zsTCGiiV3nlIReYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76491174"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="76491174"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 19:07:59 -0800
X-CSE-ConnectionGUID: CA/5VykVSXSV17b/K/vzVA==
X-CSE-MsgGUID: OqDARE5vT46z7hzFVi7ubQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="213840886"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 19 Feb 2026 19:07:58 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vtGrz-000000013mG-32tk;
	Fri, 20 Feb 2026 03:07:55 +0000
Date: Fri, 20 Feb 2026 11:07:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 1ad4461bd86b79fa43de9034f3d68e174003768e
Message-ID: <202602201104.o9NqDyPq-lkp@intel.com>
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
	TAGGED_FROM(0.00)[bounces-21017-lists,linux-acpi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: DE8E4164580
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 1ad4461bd86b79fa43de9034f3d68e174003768e  Merge branch 'pm-runtime' into bleeding-edge

elapsed time: 762m

configs tested: 189
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                   randconfig-001-20260220    gcc-8.5.0
arc                   randconfig-002-20260220    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                       imx_v6_v7_defconfig    gcc-15.2.0
arm                            mmp2_defconfig    gcc-15.2.0
arm                   randconfig-001-20260220    gcc-8.5.0
arm                   randconfig-002-20260220    gcc-8.5.0
arm                   randconfig-003-20260220    gcc-8.5.0
arm                   randconfig-004-20260220    gcc-8.5.0
arm                        realview_defconfig    gcc-15.2.0
arm                           sama5_defconfig    gcc-15.2.0
arm                    vt8500_v6_v7_defconfig    gcc-15.2.0
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260220    gcc-8.5.0
arm64                 randconfig-002-20260220    gcc-8.5.0
arm64                 randconfig-003-20260220    gcc-8.5.0
arm64                 randconfig-004-20260220    gcc-8.5.0
arm64                           snd_defconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260220    gcc-8.5.0
csky                  randconfig-002-20260220    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    gcc-15.2.0
hexagon               randconfig-001-20260220    clang-23
hexagon               randconfig-002-20260220    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260220    clang-20
i386        buildonly-randconfig-002-20260220    clang-20
i386        buildonly-randconfig-003-20260220    clang-20
i386        buildonly-randconfig-004-20260220    clang-20
i386        buildonly-randconfig-005-20260220    clang-20
i386        buildonly-randconfig-006-20260220    clang-20
i386                  randconfig-001-20260220    clang-20
i386                  randconfig-002-20260220    clang-20
i386                  randconfig-003-20260220    clang-20
i386                  randconfig-004-20260220    clang-20
i386                  randconfig-005-20260220    clang-20
i386                  randconfig-006-20260220    clang-20
i386                  randconfig-007-20260220    clang-20
i386                  randconfig-011-20260220    gcc-14
i386                  randconfig-012-20260220    gcc-14
i386                  randconfig-013-20260220    gcc-14
i386                  randconfig-014-20260220    gcc-14
i386                  randconfig-015-20260220    gcc-14
i386                  randconfig-016-20260220    gcc-14
i386                  randconfig-017-20260220    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson32_defconfig    gcc-15.2.0
loongarch             randconfig-001-20260220    clang-23
loongarch             randconfig-002-20260220    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.2.0
m68k                            q40_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath25_defconfig    gcc-15.2.0
mips                        bcm47xx_defconfig    gcc-15.2.0
mips                         db1xxx_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260220    clang-23
nios2                 randconfig-002-20260220    clang-23
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260220    clang-23
parisc                randconfig-002-20260220    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                    amigaone_defconfig    gcc-15.2.0
powerpc                    ge_imp3a_defconfig    gcc-15.2.0
powerpc                        icon_defconfig    gcc-15.2.0
powerpc                      mgcoge_defconfig    gcc-15.2.0
powerpc                   motionpro_defconfig    gcc-15.2.0
powerpc                    mvme5100_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260220    clang-23
powerpc               randconfig-002-20260220    clang-23
powerpc                    socrates_defconfig    gcc-15.2.0
powerpc                  storcenter_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260220    clang-23
powerpc64             randconfig-002-20260220    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv             nommu_k210_sdcard_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260220    gcc-11.5.0
riscv                 randconfig-002-20260220    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260220    gcc-11.5.0
s390                  randconfig-002-20260220    gcc-11.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                         apsh4a3a_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                          lboxre2_defconfig    gcc-15.2.0
sh                    randconfig-001-20260220    gcc-11.5.0
sh                    randconfig-002-20260220    gcc-11.5.0
sh                           se7780_defconfig    gcc-15.2.0
sh                             shx3_defconfig    gcc-15.2.0
sh                          urquell_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260220    clang-20
sparc                 randconfig-002-20260220    clang-20
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260220    clang-20
sparc64               randconfig-002-20260220    clang-20
um                               alldefconfig    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260220    clang-20
um                    randconfig-002-20260220    clang-20
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260220    clang-20
x86_64      buildonly-randconfig-002-20260220    clang-20
x86_64      buildonly-randconfig-003-20260220    clang-20
x86_64      buildonly-randconfig-004-20260220    clang-20
x86_64      buildonly-randconfig-005-20260220    clang-20
x86_64      buildonly-randconfig-006-20260220    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260220    gcc-14
x86_64                randconfig-002-20260220    gcc-14
x86_64                randconfig-003-20260220    gcc-14
x86_64                randconfig-004-20260220    gcc-14
x86_64                randconfig-005-20260220    gcc-14
x86_64                randconfig-006-20260220    gcc-14
x86_64                randconfig-071-20260220    gcc-14
x86_64                randconfig-072-20260220    gcc-14
x86_64                randconfig-073-20260220    gcc-14
x86_64                randconfig-074-20260220    gcc-14
x86_64                randconfig-075-20260220    gcc-14
x86_64                randconfig-076-20260220    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260220    clang-20
xtensa                randconfig-002-20260220    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

