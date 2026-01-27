Return-Path: <linux-acpi+bounces-20638-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BPoI8YyeGlRowEAu9opvQ
	(envelope-from <linux-acpi+bounces-20638-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 04:36:38 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBDC8FA2C
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 04:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3977D301624B
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 03:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6522B30BF64;
	Tue, 27 Jan 2026 03:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z9Asx6pY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789C2D24B7;
	Tue, 27 Jan 2026 03:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484994; cv=none; b=np8qILo9ku/Cn85bci97b/GIZszXUscd0WdzQ423izqS3hKp0PS/Rr/hSO2H21FuWezvDDtQeH/rWUeZU4s2/RUJb38vQHwSwIkCTU/98Q0KmiuN0T+tPejO6BvSUjg4JtB6ax/ioUeUDS193YVAdVYYbFYIxe8T4lQoP6cAZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484994; c=relaxed/simple;
	bh=u17euDZY/BsBw+KliQjZoDeBfkn3mJPhvseGigdBFss=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sSP/wod9J4H+jYLwqe1D5Sp+5cVPdeOfeQZMOh7OCcwzwuhKXUj6FaFcA2ECUyT9OdmKfakLRZRYPBOn7lXAJ7fKn9wSm2mLeGJ36SG70jl9knI9gcMjxIoNRZGOtkE30DGODzo98SN7goEriYhFXn6wZ3P1tJv0KfdTUZOK8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z9Asx6pY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769484991; x=1801020991;
  h=date:from:to:cc:subject:message-id;
  bh=u17euDZY/BsBw+KliQjZoDeBfkn3mJPhvseGigdBFss=;
  b=Z9Asx6pYvirWdzCqdtFxJRHZcjlJHgjrJmIoYU+qGEzA/wUK7CyUHLrl
   sAUXhvBkiyYqAHV1WI2Y6Fb1n4GM1ZE98uuwUgqGR7UIoSiWZxpB1Bqj0
   Fyb0HpEQyz0oPK5aEGYD5iaWQZPctv0gZdHDOpRwW2imc9bPKurP8kgXB
   p54Qs00JLsAZWENHEZ1XtMRYtGdju01CeMKU1knjqUdp7WbCleLYJyNPS
   Zlbqz41Md9E5qKUywRceBsL0wT4FUCgnpVLyB/749o4bXOaiXLzsv5Abn
   g1CM8ypOnQpjcxC6zviwXIUHUJWa/KpY2v9SwUVhqMd3mwESgD9RpI54w
   g==;
X-CSE-ConnectionGUID: 7fBtG8p/RVG52k7K48G0FA==
X-CSE-MsgGUID: o4pndMTfRLWc3GZ2NWunjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="80971397"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="80971397"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 19:36:30 -0800
X-CSE-ConnectionGUID: Rotbs+IjTUaY3kX66zPAKQ==
X-CSE-MsgGUID: VNWTI/nUTVWKRUR6KOdVRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="230805893"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jan 2026 19:36:28 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkZsQ-00000000XxY-37k7;
	Tue, 27 Jan 2026 03:36:26 +0000
Date: Tue, 27 Jan 2026 11:35:53 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 4345a8f2c8d5452fdb6746ea09b5478df369b76a
Message-ID: <202601271148.VJJFLPC1-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20638-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FBDC8FA2C
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 4345a8f2c8d5452fdb6746ea09b5478df369b76a  Merge branch 'pm-runtime-cleanup' into bleeding-edge

elapsed time: 916m

configs tested: 267
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260126    gcc-13.4.0
arc                   randconfig-001-20260127    gcc-14.3.0
arc                   randconfig-002-20260126    gcc-8.5.0
arc                   randconfig-002-20260127    gcc-14.3.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                   milbeaut_m10v_defconfig    clang-19
arm                          pxa168_defconfig    clang-19
arm                          pxa3xx_defconfig    clang-22
arm                   randconfig-001-20260126    gcc-11.5.0
arm                   randconfig-001-20260127    gcc-14.3.0
arm                   randconfig-002-20260126    gcc-13.4.0
arm                   randconfig-002-20260127    gcc-14.3.0
arm                   randconfig-003-20260126    gcc-10.5.0
arm                   randconfig-003-20260127    gcc-14.3.0
arm                   randconfig-004-20260126    gcc-8.5.0
arm                   randconfig-004-20260127    gcc-14.3.0
arm                           u8500_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260127    gcc-15.2.0
arm64                 randconfig-002-20260127    gcc-15.2.0
arm64                 randconfig-003-20260127    gcc-15.2.0
arm64                 randconfig-004-20260127    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260127    gcc-15.2.0
csky                  randconfig-002-20260127    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260127    gcc-15.2.0
hexagon               randconfig-002-20260127    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260126    gcc-14
i386        buildonly-randconfig-001-20260127    gcc-14
i386        buildonly-randconfig-002-20260126    clang-20
i386        buildonly-randconfig-002-20260127    gcc-14
i386        buildonly-randconfig-003-20260126    gcc-14
i386        buildonly-randconfig-003-20260127    gcc-14
i386        buildonly-randconfig-004-20260126    clang-20
i386        buildonly-randconfig-004-20260127    gcc-14
i386        buildonly-randconfig-005-20260126    gcc-14
i386        buildonly-randconfig-005-20260127    gcc-14
i386        buildonly-randconfig-006-20260126    clang-20
i386        buildonly-randconfig-006-20260127    gcc-14
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260126    clang-20
i386                  randconfig-002-20260126    clang-20
i386                  randconfig-003-20260126    clang-20
i386                  randconfig-004-20260126    gcc-12
i386                  randconfig-005-20260126    gcc-14
i386                  randconfig-006-20260126    clang-20
i386                  randconfig-007-20260126    gcc-14
i386                  randconfig-011-20260126    clang-20
i386                  randconfig-011-20260127    gcc-14
i386                  randconfig-012-20260126    clang-20
i386                  randconfig-012-20260127    gcc-14
i386                  randconfig-013-20260126    clang-20
i386                  randconfig-013-20260127    gcc-14
i386                  randconfig-014-20260126    clang-20
i386                  randconfig-014-20260127    gcc-14
i386                  randconfig-015-20260126    clang-20
i386                  randconfig-015-20260127    gcc-14
i386                  randconfig-016-20260126    clang-20
i386                  randconfig-016-20260127    gcc-14
i386                  randconfig-017-20260126    clang-20
i386                  randconfig-017-20260127    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260127    gcc-15.2.0
loongarch             randconfig-002-20260127    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                       bvme6000_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           ip22_defconfig    gcc-15.2.0
mips                       lemote2f_defconfig    gcc-15.2.0
mips                        qi_lb60_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260127    gcc-15.2.0
nios2                 randconfig-002-20260127    gcc-15.2.0
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
parisc                randconfig-001-20260126    gcc-8.5.0
parisc                randconfig-001-20260127    gcc-11.5.0
parisc                randconfig-002-20260126    gcc-8.5.0
parisc                randconfig-002-20260127    gcc-11.5.0
parisc                randconfig-002-20260127    gcc-13.4.0
parisc64                         alldefconfig    gcc-15.2.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      pcm030_defconfig    gcc-15.2.0
powerpc                      ppc64e_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260126    gcc-14.3.0
powerpc               randconfig-001-20260127    gcc-11.5.0
powerpc               randconfig-001-20260127    gcc-14.3.0
powerpc               randconfig-002-20260126    clang-22
powerpc               randconfig-002-20260127    clang-22
powerpc               randconfig-002-20260127    gcc-11.5.0
powerpc                     tqm8540_defconfig    gcc-15.2.0
powerpc                     tqm8548_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260127    gcc-11.5.0
powerpc64             randconfig-002-20260127    clang-22
powerpc64             randconfig-002-20260127    gcc-11.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260127    clang-22
riscv                 randconfig-002-20260127    clang-22
riscv                 randconfig-002-20260127    gcc-13.4.0
riscv                 randconfig-002-20260127    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                          debug_defconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260127    clang-22
s390                  randconfig-001-20260127    gcc-13.4.0
s390                  randconfig-002-20260127    clang-22
s390                  randconfig-002-20260127    gcc-13.4.0
s390                  randconfig-002-20260127    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                        edosk7705_defconfig    gcc-15.2.0
sh                            migor_defconfig    gcc-15.2.0
sh                    randconfig-001-20260127    clang-22
sh                    randconfig-001-20260127    gcc-13.4.0
sh                    randconfig-002-20260127    clang-22
sh                    randconfig-002-20260127    gcc-10.5.0
sh                    randconfig-002-20260127    gcc-13.4.0
sh                            shmin_defconfig    gcc-15.2.0
sparc                            alldefconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260127    gcc-15.2.0
sparc                 randconfig-002-20260127    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260127    gcc-15.2.0
sparc64               randconfig-002-20260127    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260127    gcc-15.2.0
um                    randconfig-002-20260127    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260127    gcc-14
x86_64      buildonly-randconfig-002-20260127    gcc-14
x86_64      buildonly-randconfig-003-20260127    gcc-14
x86_64      buildonly-randconfig-004-20260127    gcc-14
x86_64      buildonly-randconfig-005-20260127    gcc-14
x86_64      buildonly-randconfig-006-20260127    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260127    clang-20
x86_64                randconfig-001-20260127    gcc-14
x86_64                randconfig-002-20260127    clang-20
x86_64                randconfig-002-20260127    gcc-14
x86_64                randconfig-003-20260127    clang-20
x86_64                randconfig-004-20260127    clang-20
x86_64                randconfig-004-20260127    gcc-14
x86_64                randconfig-005-20260127    clang-20
x86_64                randconfig-006-20260127    clang-20
x86_64                randconfig-006-20260127    gcc-14
x86_64                randconfig-011-20260126    gcc-12
x86_64                randconfig-011-20260127    clang-20
x86_64                randconfig-012-20260126    gcc-12
x86_64                randconfig-012-20260127    clang-20
x86_64                randconfig-013-20260126    clang-20
x86_64                randconfig-013-20260127    clang-20
x86_64                randconfig-014-20260126    gcc-14
x86_64                randconfig-014-20260127    clang-20
x86_64                randconfig-015-20260126    gcc-14
x86_64                randconfig-015-20260127    clang-20
x86_64                randconfig-016-20260126    gcc-14
x86_64                randconfig-016-20260127    clang-20
x86_64                randconfig-071-20260127    gcc-14
x86_64                randconfig-072-20260127    gcc-14
x86_64                randconfig-073-20260127    gcc-14
x86_64                randconfig-074-20260127    clang-20
x86_64                randconfig-074-20260127    gcc-14
x86_64                randconfig-075-20260127    clang-20
x86_64                randconfig-075-20260127    gcc-14
x86_64                randconfig-076-20260127    clang-20
x86_64                randconfig-076-20260127    gcc-14
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
xtensa                  audio_kc705_defconfig    gcc-15.2.0
xtensa                       common_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260127    gcc-15.2.0
xtensa                randconfig-002-20260127    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

