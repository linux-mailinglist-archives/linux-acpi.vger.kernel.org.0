Return-Path: <linux-acpi+bounces-10129-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8AC9F0D5F
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2024 14:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DEC188BD50
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2024 13:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89AB1DFE1B;
	Fri, 13 Dec 2024 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqtRwlxj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D6B38DE1;
	Fri, 13 Dec 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734096962; cv=none; b=frOJEVlfawQFoxOSG17rz5/+Rv235mJ6arrOr4mwberfpdT7TvKahnT6yS7ycbvcn4s9gHcwewu3xSWWNVhDQKEpjLiFCaRLq2RkwELLqhoOC8L1Wql9PSO0pFi7xaUPqhogo9mAniRmAqCU54s/Kn9sbH7Q/l7KtpsWk+93ueA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734096962; c=relaxed/simple;
	bh=fy8JN0I7A6ZsQ/kqXcwYkqTeZzaGdUq3iTIsvru1u2Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CGSNqWorReCwdbMtgLKAZ2XY/ochroMOMk2gcz6oNSGJ15BQhju31XfkJvj8xeHiHK8wAUqKtZnVoEEzsKzC7Y7ifFO2aTQLn0ucEXIjrEqWj/D9gG1CrK+rCTyyGoRB1SJy8Mv4Thz6qpmqRryqZE8gUn45DESwvlfz5yCSkWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqtRwlxj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734096960; x=1765632960;
  h=date:from:to:cc:subject:message-id;
  bh=fy8JN0I7A6ZsQ/kqXcwYkqTeZzaGdUq3iTIsvru1u2Q=;
  b=CqtRwlxjykghQTB4Xf18oQFOQSyM1ky6cDr0A9IhhwSolJpe+oGAvmoS
   TDLB6MFVxmlXcDaKdTimDKWU7dxHzdT5Hln2EaMfiybffln0Wi27cdCNP
   J5zDd37KxenjVFuMMmClJ1+OmLfFaq8Zwxvx1f9Vw/6dWjEx0Lujc0JWm
   AucHDnYoyHCd8Rtd5iP9NkfqStzGYEgnHvKIEoLI7DmrpWchoX6VJsu1S
   Z8NWInGjfemRZEqgs0PAHgMXK9ScOfFxKIP2UuFm/CvtC1MkbSYA2R/9Y
   FWCD1azGaF/ZzDv6Wi2eyMd3GxWdPm9/WkdshCDAO+81ji4pPDr+Q2Zkg
   A==;
X-CSE-ConnectionGUID: xhGO4KuNRcqwYMyAi5EqNg==
X-CSE-MsgGUID: QdT8Y6BnSCCLXOIAH2Z8jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="37396058"
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="37396058"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 05:35:59 -0800
X-CSE-ConnectionGUID: 1JrH20oiSdu5bb5vH0MfHg==
X-CSE-MsgGUID: /yuU4UrDSUaZVUuOE5NfRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="101382613"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 13 Dec 2024 05:35:57 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tM5pj-000C3l-10;
	Fri, 13 Dec 2024 13:35:55 +0000
Date: Fri, 13 Dec 2024 21:34:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 4503c4a2dc6dccbec2069b7b2f3ae09f5224de6c
Message-ID: <202412132147.PHCvGBGR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 4503c4a2dc6dccbec2069b7b2f3ae09f5224de6c  Merge branch 'experimental/intel_pstate-testing' into bleeding-edge

elapsed time: 1456m

configs tested: 72
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                   randconfig-001-20241213    gcc-13.2.0
arc                   randconfig-002-20241213    gcc-13.2.0
arm                   randconfig-001-20241213    clang-16
arm                   randconfig-002-20241213    clang-18
arm                   randconfig-003-20241213    gcc-14.2.0
arm                   randconfig-004-20241213    clang-18
arm64                 randconfig-001-20241213    gcc-14.2.0
arm64                 randconfig-002-20241213    gcc-14.2.0
arm64                 randconfig-003-20241213    clang-18
arm64                 randconfig-004-20241213    gcc-14.2.0
csky                  randconfig-001-20241213    gcc-14.2.0
csky                  randconfig-002-20241213    gcc-14.2.0
hexagon               randconfig-001-20241213    clang-20
hexagon               randconfig-002-20241213    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20241213    clang-19
i386        buildonly-randconfig-002-20241213    gcc-12
i386        buildonly-randconfig-003-20241213    gcc-12
i386        buildonly-randconfig-004-20241213    clang-19
i386        buildonly-randconfig-005-20241213    gcc-12
i386        buildonly-randconfig-006-20241213    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20241213    gcc-14.2.0
loongarch             randconfig-002-20241213    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
nios2                 randconfig-001-20241213    gcc-14.2.0
nios2                 randconfig-002-20241213    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20241213    gcc-14.2.0
parisc                randconfig-002-20241213    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20241213    gcc-14.2.0
powerpc               randconfig-002-20241213    clang-20
powerpc               randconfig-003-20241213    gcc-14.2.0
powerpc64             randconfig-001-20241213    gcc-14.2.0
powerpc64             randconfig-002-20241213    gcc-14.2.0
powerpc64             randconfig-003-20241213    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20241213    gcc-14.2.0
riscv                 randconfig-002-20241213    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241213    gcc-14.2.0
s390                  randconfig-002-20241213    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20241213    gcc-14.2.0
sh                    randconfig-002-20241213    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20241213    gcc-14.2.0
sparc                 randconfig-002-20241213    gcc-14.2.0
sparc64               randconfig-001-20241213    gcc-14.2.0
sparc64               randconfig-002-20241213    gcc-14.2.0
um                                allnoconfig    clang-18
um                    randconfig-001-20241213    gcc-12
um                    randconfig-002-20241213    clang-16
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20241213    gcc-12
x86_64      buildonly-randconfig-002-20241213    gcc-12
x86_64      buildonly-randconfig-003-20241213    gcc-12
x86_64      buildonly-randconfig-004-20241213    gcc-12
x86_64      buildonly-randconfig-005-20241213    gcc-12
x86_64      buildonly-randconfig-006-20241213    clang-19
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20241213    gcc-14.2.0
xtensa                randconfig-002-20241213    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

