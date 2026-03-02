Return-Path: <linux-acpi+bounces-21294-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KpyIa03pWnt5wUAu9opvQ
	(envelope-from <linux-acpi+bounces-21294-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Mar 2026 08:09:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD781D3ABC
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Mar 2026 08:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1F3B30221C8
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2026 07:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67053313531;
	Mon,  2 Mar 2026 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODvK3mH6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F15824A3;
	Mon,  2 Mar 2026 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435358; cv=none; b=hEATzsi3CKIpbeFBo7jd4BDi+N8qnLOMG4zYCw+6FH/QXaayh+2+wXyi2xrJFrY6d5n/kFMB1HLQRnNQDpt64Ki46D79BSNJS34o9eOA6/ILp0lQRy2oF9B5zu+wMter/p9vbmtITSsU/ZGaBxaCruFatlnJfZ113LD7AOoo5Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435358; c=relaxed/simple;
	bh=fK4KAwfosZCZjpVfG/qGI1Gt1JlTCpU0yXPoutKX+2U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oqqIbfpbkpAFneFm/CJp8tCHxx2SLQw5pJkQY2gLLUWhNSVcYielT5uRQARisXYpY0azl7qCfZtocGI7YXUtzsMp+FlVbV3zK7uSU0F8i9RiuILnMXHXzWwSFD+vxnZx0pCvjvR4OQPUF3Mc30RlN7VY4tn1vak5Bxe0hNBh9jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODvK3mH6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772435357; x=1803971357;
  h=date:from:to:cc:subject:message-id;
  bh=fK4KAwfosZCZjpVfG/qGI1Gt1JlTCpU0yXPoutKX+2U=;
  b=ODvK3mH6NLah4nAYP5pYYWoZe83wSCfqs6r5AdBwQh+fynh/CyCycqBJ
   IBmge6VTzbDqLtYsjfF8Q/WWHBtgg8AjvOB+HIySaAEyaD0juR5ue8FLl
   nbsp6/hmgj8fIW186QCa6rNvW5T9/cA7R692WO3zpk9+cZGdxAE6aB7o6
   Gny8LR2iedaBjc90G36lB1OddsaxsHncyJSs19hgE9NamOl7HX4hMKPN7
   n2C5HZnC658pk4OQr8UTmbEtJCo3VqVz00jFOBGgBNR+qL+kgBsnvFh/M
   n0CJ6NPMfLOYrZ6zsqn6zy8ljbHBWMmtDZabbP4Xy7kXCRhOhtrgqAfK9
   A==;
X-CSE-ConnectionGUID: /o4POHYoRqSDrLRqMqjHFw==
X-CSE-MsgGUID: ZWB2MRllQtidrz13WyB3zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73303707"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="73303707"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 23:09:16 -0800
X-CSE-ConnectionGUID: T35/+KC0Sxi7+EzwVmMdUg==
X-CSE-MsgGUID: yVoz4zFbQP2ZOcVcc+N6ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="220657249"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 01 Mar 2026 23:09:14 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwxOy-000000000Yh-12Nc;
	Mon, 02 Mar 2026 07:09:12 +0000
Date: Mon, 02 Mar 2026 15:08:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 8327acbae0f192cf6c1d72edc5285bd380de9c63
Message-ID: <202603021544.aPDxboHW-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21294-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EDD781D3ABC
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 8327acbae0f192cf6c1d72edc5285bd380de9c63  Merge branch 'experimental/acpi-driver-conversion' into bleeding-edge

elapsed time: 724m

configs tested: 161
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
arc                   randconfig-001-20260302    gcc-14.3.0
arc                   randconfig-002-20260302    gcc-13.4.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260302    clang-18
arm                   randconfig-002-20260302    clang-23
arm                   randconfig-003-20260302    gcc-14.3.0
arm                   randconfig-004-20260302    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260302    clang-17
arm64                 randconfig-002-20260302    clang-23
arm64                 randconfig-003-20260302    clang-23
arm64                 randconfig-004-20260302    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260302    gcc-15.2.0
csky                  randconfig-002-20260302    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260302    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260302    gcc-14
i386        buildonly-randconfig-002-20260302    gcc-14
i386        buildonly-randconfig-003-20260302    clang-20
i386        buildonly-randconfig-004-20260302    clang-20
i386        buildonly-randconfig-005-20260302    clang-20
i386        buildonly-randconfig-006-20260302    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260302    gcc-14
i386                  randconfig-002-20260302    clang-20
i386                  randconfig-003-20260302    gcc-14
i386                  randconfig-004-20260302    clang-20
i386                  randconfig-005-20260302    clang-20
i386                  randconfig-006-20260302    gcc-13
i386                  randconfig-007-20260302    clang-20
i386                  randconfig-011-20260302    gcc-14
i386                  randconfig-012-20260302    gcc-14
i386                  randconfig-013-20260302    clang-20
i386                  randconfig-014-20260302    gcc-14
i386                  randconfig-015-20260302    gcc-14
i386                  randconfig-016-20260302    clang-20
i386                  randconfig-017-20260302    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260302    clang-18
loongarch             randconfig-002-20260302    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
m68k                           virt_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        vocore2_defconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260302    gcc-11.5.0
nios2                 randconfig-002-20260302    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 canyonlands_defconfig    clang-23
powerpc                      pasemi_defconfig    clang-23
powerpc                      tqm8xx_defconfig    clang-19
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260302    clang-23
riscv                 randconfig-002-20260302    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260302    gcc-11.5.0
s390                  randconfig-002-20260302    gcc-13.4.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                          polaris_defconfig    gcc-15.2.0
sh                    randconfig-001-20260302    gcc-11.5.0
sh                    randconfig-002-20260302    gcc-15.2.0
sh                           se7705_defconfig    gcc-15.2.0
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260302    gcc-14.3.0
sparc                 randconfig-002-20260302    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260302    clang-23
sparc64               randconfig-002-20260302    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260302    gcc-14
um                    randconfig-002-20260302    clang-18
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260302    gcc-14
x86_64      buildonly-randconfig-002-20260302    clang-20
x86_64      buildonly-randconfig-003-20260302    clang-20
x86_64      buildonly-randconfig-004-20260302    clang-20
x86_64      buildonly-randconfig-005-20260302    clang-20
x86_64      buildonly-randconfig-006-20260302    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260302    gcc-14
x86_64                randconfig-002-20260302    gcc-14
x86_64                randconfig-003-20260302    gcc-14
x86_64                randconfig-004-20260302    gcc-14
x86_64                randconfig-005-20260302    clang-20
x86_64                randconfig-006-20260302    gcc-14
x86_64                randconfig-011-20260302    gcc-14
x86_64                randconfig-012-20260302    gcc-14
x86_64                randconfig-013-20260302    clang-20
x86_64                randconfig-014-20260302    clang-20
x86_64                randconfig-015-20260302    gcc-14
x86_64                randconfig-016-20260302    gcc-14
x86_64                randconfig-071-20260302    gcc-14
x86_64                randconfig-072-20260302    clang-20
x86_64                randconfig-073-20260302    clang-20
x86_64                randconfig-074-20260302    clang-20
x86_64                randconfig-075-20260302    clang-20
x86_64                randconfig-076-20260302    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260302    gcc-14.3.0
xtensa                randconfig-002-20260302    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

