Return-Path: <linux-acpi+bounces-10130-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B4A9F0D6B
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2024 14:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2456C16941C
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2024 13:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AC91E0487;
	Fri, 13 Dec 2024 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdP/ehl6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266AE1E00AF;
	Fri, 13 Dec 2024 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097082; cv=none; b=ZBKFq+GP1EAgzpmlJeIo0xVImEknGIez8NdOZ08qNF/FCGc43EKux/fXZGal3PIgD8Zbi0FClexsoosrf0Vzkatjz3JSdUzeVLGHSDFWUWHkJ+iIXbyK1QQyfuk0fnOPYsmDOwdCApsa4DbsBNwGd+sbF+tRkHiCbsc/he9f5gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097082; c=relaxed/simple;
	bh=RYbRWaSDYuspkQLWKW9UGqYCbzVbTONjwsUN4tu1Bdc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I7znZUauloEjEwGwNW5o4HrZjAZBlItgKBExOpD2lhwoqLm6qontoP2s2i+9GOYPsB4GFo8N4OuIRHDSzoO7sU5gO1FypiYQCUHdALIbk9fscCNxCC8LXX2HtlsYKVornl8zEs+fyWF9Np1WovlTJG+SVuB8MQVfz8d8C/kqXXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdP/ehl6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734097080; x=1765633080;
  h=date:from:to:cc:subject:message-id;
  bh=RYbRWaSDYuspkQLWKW9UGqYCbzVbTONjwsUN4tu1Bdc=;
  b=ZdP/ehl6j7BoiESlOtxoNc6MVKqnMzI8xt/RYL0y/tkuNONEYNmiZnQ8
   bgI7FXDs9u9q+6ngViPkm/QwS3Kp0PAdzX2cb/wwTKfEwnyskOhQRO4vp
   LeIXEZDLJUATrnaECmU2Rhomrk+Bf8eqNnI9XMrPzTuO3UvkbOv5socy8
   g59cRCAuv8jbLXRFJ6yNNwD7ts9DAZxgRIVliO0SidIU1wATwxh1GTSo5
   XcwSe4d49JLMoWRRi3o2TWCCsj9a9he4L/sGNQQIa4L9fQmpR2mMgs+Qk
   vXk/HsQ0+mmHuqQDRvltR01g4uEVVLSqo4yqA3Mvp3iAjaf5rbRiKjQVJ
   A==;
X-CSE-ConnectionGUID: O5WS5/ZOQsiXgoDQ9EjNuA==
X-CSE-MsgGUID: 9KR27u72Rpya6Nh2kGOHJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="34784147"
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="34784147"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 05:37:59 -0800
X-CSE-ConnectionGUID: US3s7X0sRvmhXsd/cutf5Q==
X-CSE-MsgGUID: 5bGmQQcEScysls2XRWb3Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="101627191"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 13 Dec 2024 05:37:58 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tM5rf-000C3x-1l;
	Fri, 13 Dec 2024 13:37:55 +0000
Date: Fri, 13 Dec 2024 21:37:29 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 d36ebd181c1e7b1b427812e6e8cbf6e33dac842f
Message-ID: <202412132120.UvNZBtAM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: d36ebd181c1e7b1b427812e6e8cbf6e33dac842f  Merge branch 'pm-runtime' into fixes

elapsed time: 1459m

configs tested: 85
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
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
hexagon                          allmodconfig    clang-20
hexagon                          allyesconfig    clang-18
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
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20241213    gcc-14.2.0
parisc                randconfig-002-20241213    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20241213    gcc-14.2.0
powerpc               randconfig-002-20241213    clang-20
powerpc               randconfig-003-20241213    gcc-14.2.0
powerpc64             randconfig-001-20241213    gcc-14.2.0
powerpc64             randconfig-002-20241213    gcc-14.2.0
powerpc64             randconfig-003-20241213    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
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
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20241213    gcc-12
um                    randconfig-002-20241213    clang-16
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
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

