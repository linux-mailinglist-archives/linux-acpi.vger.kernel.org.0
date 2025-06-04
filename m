Return-Path: <linux-acpi+bounces-14136-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544AAACE5D9
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 22:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16643178ABA
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 20:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D231F2BAD;
	Wed,  4 Jun 2025 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ccTg2o9o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F80472636;
	Wed,  4 Jun 2025 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749069996; cv=none; b=hDIQH3UzlP2B1pW8sh9RSUd1hahkeozGEErstKHuXwMH0aKFYgqSaHXKtQeHwrMSai9Q4g/qVq+OMu76IYjWCB2nQRJkVUee8j51e3qL5qF5y+1oGbfVaTSQYAxTtgZ3z9xJWqE2YvNS5Q22ITvim4wxH6itgcwbHlk0vF32fTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749069996; c=relaxed/simple;
	bh=OVnzDCVSO9DItB2ytURbUms5BJsi53j7l4uIMYDoTK4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CAj5r7OVkMV15826Zp7ENonQXjuiHe1ZDqQB1R7uHVBVNfbXX9vILJMmFVpNyu9G0JiYP2I5Mjxr+QZNVwNye750q/iOj1XP8jOuRQoHxJc5jKe1dPHiKDFxTj1kBcRASYRdy8VolTcUKedC3Titbc88uo5QTU0rFD57XLs/UbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ccTg2o9o; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749069995; x=1780605995;
  h=date:from:to:cc:subject:message-id;
  bh=OVnzDCVSO9DItB2ytURbUms5BJsi53j7l4uIMYDoTK4=;
  b=ccTg2o9ocRip1WpFhxuDJCrO3VXsfdli5raPX+pj/HO7H/c9Nrf6zdKC
   cZXuIf8UuYTfYcPQDiPA4GnHrz3asuCFqN/Uni8oVf+y6/rbjPXMDt7hz
   iF7joaEZjC2mDmwUXL1Ti2S4PxSkFPgF+MSzT2ibKIRQFk5v060a7awC3
   AkwsNn3sUX6/6O35Uo8UWaXuDhqkOsjJ8pwPQGSNNFcZ/5AKsOY+AMIqP
   IYOkWqv/U6HoB2wL1XzRFP7yE/15vOnYvrvmdjNnA75mzx8p7N1RBt7qJ
   PIZ5zN0XOX2JMvEtI7FeHHl0BiJj2QRkSsrS/JOUaztwLQ6Ltd1AbZpos
   w==;
X-CSE-ConnectionGUID: FUj/N6swSjq7RqTFJF1wLw==
X-CSE-MsgGUID: gLAdgfz+QNeKz7ZV8NGOxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="61789427"
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="61789427"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 13:46:34 -0700
X-CSE-ConnectionGUID: 88YSN4CXTEWlJgCHLvrlDQ==
X-CSE-MsgGUID: 99mSaQsOT1C/PKd3qmjGtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="176175877"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 Jun 2025 13:46:32 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uMv0I-0003Sn-2G;
	Wed, 04 Jun 2025 20:46:30 +0000
Date: Thu, 05 Jun 2025 04:46:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 fcb316420b91986403917f1a336f8af0f5e4cfe1
Message-ID: <202506050411.4VH1U6Kz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: fcb316420b91986403917f1a336f8af0f5e4cfe1  Merge branch 'pm-sleep-testing' into bleeding-edge

elapsed time: 1448m

configs tested: 34
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        allyesconfig    gcc-15.1.0
arc          allmodconfig    gcc-15.1.0
arc          allyesconfig    gcc-15.1.0
arm          allmodconfig    gcc-15.1.0
arm          allyesconfig    gcc-15.1.0
arm64        allmodconfig    clang-19
hexagon      allmodconfig    clang-17
hexagon      allyesconfig    clang-21
i386          allnoconfig    gcc-12
i386         allyesconfig    gcc-12
i386            defconfig    clang-20
loongarch    allmodconfig    gcc-15.1.0
m68k         allmodconfig    gcc-15.1.0
m68k         allyesconfig    gcc-15.1.0
microblaze   allmodconfig    gcc-15.1.0
microblaze   allyesconfig    gcc-15.1.0
openrisc     allyesconfig    gcc-15.1.0
parisc       allmodconfig    gcc-15.1.0
parisc       allyesconfig    gcc-15.1.0
powerpc      allmodconfig    gcc-15.1.0
powerpc      allyesconfig    clang-21
riscv        allmodconfig    clang-21
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390         allyesconfig    gcc-15.1.0
sh           allmodconfig    gcc-15.1.0
sh           allyesconfig    gcc-15.1.0
sparc        allmodconfig    gcc-15.1.0
um           allmodconfig    clang-19
um           allyesconfig    gcc-12
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64          defconfig    gcc-11
x86_64      rhel-9.4-rust    clang-18

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

