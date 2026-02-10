Return-Path: <linux-acpi+bounces-20919-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIibCcYSi2nSPQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20919-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 12:13:10 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8FE11A04F
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 12:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 860C43035AB6
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 11:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E81342CBA;
	Tue, 10 Feb 2026 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJ48KsQn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814A33F8CE;
	Tue, 10 Feb 2026 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770721961; cv=none; b=Ou4WDdVkv+30UcOvsVNG8mQNM9TYDu1Y/SwG2K/D0aEx8vskOKlUShTCYtabXo68luEB1u7TfWWyLeeFGQTMOh3y1bhS+NOVYE2v6JvIThrOA6W6j0tLwai6uNDFpFa0591C6l421zLxNp+/tiXLcb5BKnhvAZ84F+xteqZ7D5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770721961; c=relaxed/simple;
	bh=6bM59bC9wmJC1EWUOTfbgC/h/Yw5+ipjSIDIilvzFfA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=P2UJj+Ec+8B/apqcMooXBcA/dkwggk7jBZhD0HbWY+dgen6GYVk0kw7um7WGSRJ0vDVoWNFL7cAYLiDQEn2Ou1QfJPllQLA1BnAAumtPJ7a3t7AyPRUVZVtm83950sQ4VlsM1MlVw9iqSpoy1JRMhZzjKTAB2p7X7hRRRxT3Qxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJ48KsQn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770721959; x=1802257959;
  h=date:from:to:cc:subject:message-id;
  bh=6bM59bC9wmJC1EWUOTfbgC/h/Yw5+ipjSIDIilvzFfA=;
  b=iJ48KsQnH9uRczb5gTt2BBdns6UM0MeryKQ2IGF69VWGhYdy+gV0ZzNT
   thZ5lkrJR3DfvdTEX7uKLNc2JovCpb4DOiAoXYxx2u5ZWLqdNjvLJXjhN
   iaANHuvV5P8oAODnUPsU3IDRtYYqMe/6UTl1s34AIo18q257n9Sh7Ezvx
   S+stk3Qxn7Tvu9taSuzuRN2bHK31AQhrt4pJRFTzNG94UmnRo9f9e/dJD
   C/E+svjMq+vzaG/V3Ji+A+65Gbgl6D6bCfRnyda+ExaY/PEX3plrUPrQh
   IQjnE6gILc3cS2WKg0WxaSEYYjyWtXjFE/8W6zsBCF2Uj7rECDftaUMs3
   A==;
X-CSE-ConnectionGUID: O+0Q1J+kSZKbYIJVGDgFhg==
X-CSE-MsgGUID: +aB1rdwPQVecjqVws0oIYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="89434772"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="89434772"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 03:12:39 -0800
X-CSE-ConnectionGUID: wYoqJ3wgRiiaa9lab4EPpQ==
X-CSE-MsgGUID: oT7H/QJKQBic05ADG9n1vw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 10 Feb 2026 03:12:37 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vplfW-00000000owS-47eM;
	Tue, 10 Feb 2026 11:12:34 +0000
Date: Tue, 10 Feb 2026 19:11:54 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 8711f3ee7e5efcf1b795c80496b0fb68713e153a
Message-ID: <202602101943.srec8iCs-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20919-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 7B8FE11A04F
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 8711f3ee7e5efcf1b795c80496b0fb68713e153a  Merge branch 'experimental/acpi-driver-conversion' into bleeding-edge

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202602100645.LWcwIOMw-lkp@intel.com
    https://lore.kernel.org/oe-kbuild/202602101417.8r6ZtJHr-lkp@intel.com
    https://lore.kernel.org/oe-kbuild/202602101600.KhGfxuWT-lkp@intel.com

    drivers/platform/chrome/wilco_ec/event.c:514:33: error: unknown type name 'platform_device'; did you mean 'to_platform_device'?
    drivers/platform/chrome/wilco_ec/event.c:533:19: error: 'event_device_remove' undeclared here (not in a function); did you mean 'event_device_probe'?

Unverified Error/Warning (likely false positive, kindly check if interested):

    drivers/platform/x86/classmate-laptop.c:1025 cmpc_ipml_probe() warn: 'ipml->rf' is an error pointer or valid
    drivers/platform/x86/toshiba_bluetooth.c:261 toshiba_bt_rfkill_probe() warn: 'bt_dev->rfk' is an error pointer or valid

Error/Warning ids grouped by kconfigs:

recent_errors
|-- i386-randconfig-005-20260210
|   |-- drivers-platform-chrome-wilco_ec-event.c:error:event_device_remove-undeclared-here-(not-in-a-function)
|   `-- drivers-platform-chrome-wilco_ec-event.c:error:unknown-type-name-platform_device
`-- x86_64-randconfig-161-20260210
    |-- drivers-platform-x86-classmate-laptop.c-cmpc_ipml_probe()-warn:ipml-rf-is-an-error-pointer-or-valid
    `-- drivers-platform-x86-toshiba_bluetooth.c-toshiba_bt_rfkill_probe()-warn:bt_dev-rfk-is-an-error-pointer-or-valid

elapsed time: 834m

configs tested: 291
configs skipped: 4

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                          axs101_defconfig    gcc-11.5.0
arc                                 defconfig    gcc-15.2.0
arc                        nsim_700_defconfig    clang-22
arc                        nsimosci_defconfig    gcc-15.2.0
arc                   randconfig-001-20260210    clang-20
arc                   randconfig-002-20260210    clang-20
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         at91_dt_defconfig    clang-22
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                          ep93xx_defconfig    clang-22
arm                         lpc32xx_defconfig    clang-22
arm                            mmp2_defconfig    clang-22
arm                       multi_v4t_defconfig    gcc-11.5.0
arm                             pxa_defconfig    clang-22
arm                   randconfig-001-20260210    clang-20
arm                   randconfig-002-20260210    clang-20
arm                   randconfig-003-20260210    clang-20
arm                   randconfig-004-20260210    clang-20
arm                         s5pv210_defconfig    gcc-11.5.0
arm                        shmobile_defconfig    clang-22
arm                          sp7021_defconfig    clang-22
arm                       versatile_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260210    clang-22
arm64                 randconfig-002-20260210    clang-22
arm64                 randconfig-003-20260210    clang-22
arm64                 randconfig-004-20260210    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    clang-22
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260210    clang-22
csky                  randconfig-001-20260210    gcc-14.3.0
csky                  randconfig-002-20260210    clang-22
csky                  randconfig-002-20260210    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260210    clang-22
hexagon               randconfig-002-20260210    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260210    clang-20
i386        buildonly-randconfig-002-20260210    clang-20
i386        buildonly-randconfig-002-20260210    gcc-14
i386        buildonly-randconfig-003-20260210    clang-20
i386        buildonly-randconfig-003-20260210    gcc-14
i386        buildonly-randconfig-004-20260210    clang-20
i386        buildonly-randconfig-005-20260210    clang-20
i386        buildonly-randconfig-006-20260210    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260210    gcc-14
i386                  randconfig-002-20260210    gcc-14
i386                  randconfig-003-20260210    clang-20
i386                  randconfig-003-20260210    gcc-14
i386                  randconfig-004-20260210    gcc-14
i386                  randconfig-005-20260210    gcc-13
i386                  randconfig-005-20260210    gcc-14
i386                  randconfig-006-20260210    gcc-13
i386                  randconfig-006-20260210    gcc-14
i386                  randconfig-007-20260210    clang-20
i386                  randconfig-007-20260210    gcc-14
i386                  randconfig-011-20260210    gcc-14
i386                  randconfig-012-20260210    gcc-14
i386                  randconfig-013-20260210    gcc-14
i386                  randconfig-014-20260210    gcc-14
i386                  randconfig-015-20260210    gcc-14
i386                  randconfig-016-20260210    gcc-14
i386                  randconfig-017-20260210    gcc-14
loongarch                        alldefconfig    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson32_defconfig    clang-22
loongarch                loongson32_defconfig    gcc-11.5.0
loongarch             randconfig-001-20260210    clang-18
loongarch             randconfig-001-20260210    clang-22
loongarch             randconfig-002-20260210    clang-22
loongarch             randconfig-002-20260210    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                          multi_defconfig    clang-22
m68k                        mvme16x_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath79_defconfig    gcc-15.2.0
mips                         bigsur_defconfig    clang-22
mips                      bmips_stb_defconfig    clang-22
mips                         cobalt_defconfig    clang-22
mips                     cu1000-neo_defconfig    gcc-15.2.0
mips                          eyeq6_defconfig    gcc-15.2.0
mips                           gcw0_defconfig    clang-22
mips                          malta_defconfig    clang-22
mips                        maltaup_defconfig    clang-22
mips                          rm200_defconfig    clang-22
mips                           xway_defconfig    clang-22
nios2                            alldefconfig    gcc-11.5.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260210    clang-22
nios2                 randconfig-001-20260210    gcc-11.5.0
nios2                 randconfig-002-20260210    clang-22
nios2                 randconfig-002-20260210    gcc-11.5.0
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
parisc                randconfig-001-20260210    clang-19
parisc                randconfig-001-20260210    gcc-14.3.0
parisc                randconfig-002-20260210    clang-19
parisc                randconfig-002-20260210    gcc-12.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                     akebono_defconfig    gcc-11.5.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      cm5200_defconfig    clang-22
powerpc                      ep88xc_defconfig    clang-22
powerpc                        icon_defconfig    clang-22
powerpc                     ksi8560_defconfig    gcc-15.2.0
powerpc                 mpc832x_rdb_defconfig    clang-22
powerpc                      pcm030_defconfig    clang-22
powerpc               randconfig-001-20260210    clang-19
powerpc               randconfig-001-20260210    clang-22
powerpc               randconfig-002-20260210    clang-19
powerpc                     taishan_defconfig    clang-22
powerpc                     tqm8555_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260210    clang-19
powerpc64             randconfig-001-20260210    clang-22
powerpc64             randconfig-002-20260210    clang-18
powerpc64             randconfig-002-20260210    clang-19
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv             nommu_k210_sdcard_defconfig    clang-22
riscv                 randconfig-001-20260210    gcc-10.5.0
riscv                 randconfig-001-20260210    gcc-11.5.0
riscv                 randconfig-002-20260210    gcc-11.5.0
riscv                 randconfig-002-20260210    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260210    gcc-11.5.0
s390                  randconfig-002-20260210    clang-22
s390                  randconfig-002-20260210    gcc-11.5.0
sh                               alldefconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                        apsh4ad0a_defconfig    clang-22
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260210    gcc-11.5.0
sh                    randconfig-001-20260210    gcc-14.3.0
sh                    randconfig-002-20260210    gcc-11.5.0
sh                    randconfig-002-20260210    gcc-15.2.0
sh                          rsk7203_defconfig    gcc-15.2.0
sh                           se7724_defconfig    clang-22
sh                           sh2007_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260210    gcc-14.3.0
sparc                 randconfig-001-20260210    gcc-15.2.0
sparc                 randconfig-002-20260210    gcc-14.3.0
sparc                 randconfig-002-20260210    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260210    gcc-11.5.0
sparc64               randconfig-001-20260210    gcc-14.3.0
sparc64               randconfig-002-20260210    clang-22
sparc64               randconfig-002-20260210    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260210    clang-19
um                    randconfig-001-20260210    gcc-14.3.0
um                    randconfig-002-20260210    gcc-14
um                    randconfig-002-20260210    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260210    clang-20
x86_64      buildonly-randconfig-001-20260210    gcc-14
x86_64      buildonly-randconfig-002-20260210    clang-20
x86_64      buildonly-randconfig-002-20260210    gcc-14
x86_64      buildonly-randconfig-003-20260210    clang-20
x86_64      buildonly-randconfig-003-20260210    gcc-14
x86_64      buildonly-randconfig-004-20260210    gcc-14
x86_64      buildonly-randconfig-005-20260210    clang-20
x86_64      buildonly-randconfig-005-20260210    gcc-14
x86_64      buildonly-randconfig-006-20260210    clang-20
x86_64      buildonly-randconfig-006-20260210    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260210    clang-20
x86_64                randconfig-001-20260210    gcc-14
x86_64                randconfig-002-20260210    clang-20
x86_64                randconfig-002-20260210    gcc-14
x86_64                randconfig-003-20260210    clang-20
x86_64                randconfig-003-20260210    gcc-14
x86_64                randconfig-004-20260210    gcc-14
x86_64                randconfig-005-20260210    gcc-14
x86_64                randconfig-006-20260210    gcc-12
x86_64                randconfig-006-20260210    gcc-14
x86_64                randconfig-011-20260210    clang-20
x86_64                randconfig-012-20260210    clang-20
x86_64                randconfig-013-20260210    clang-20
x86_64                randconfig-014-20260210    clang-20
x86_64                randconfig-015-20260210    clang-20
x86_64                randconfig-016-20260210    clang-20
x86_64                randconfig-016-20260210    gcc-13
x86_64                randconfig-071-20260210    clang-20
x86_64                randconfig-071-20260210    gcc-14
x86_64                randconfig-072-20260210    clang-20
x86_64                randconfig-073-20260210    clang-20
x86_64                randconfig-073-20260210    gcc-14
x86_64                randconfig-074-20260210    clang-20
x86_64                randconfig-075-20260210    clang-20
x86_64                randconfig-075-20260210    gcc-14
x86_64                randconfig-076-20260210    clang-20
x86_64                randconfig-076-20260210    gcc-14
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
xtensa                randconfig-001-20260210    gcc-14.3.0
xtensa                randconfig-001-20260210    gcc-8.5.0
xtensa                randconfig-002-20260210    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

