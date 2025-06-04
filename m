Return-Path: <linux-acpi+bounces-14135-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E659ACE5CB
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 22:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A04C1899741
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 20:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6887B215787;
	Wed,  4 Jun 2025 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHIE/QX1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5D921A444;
	Wed,  4 Jun 2025 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749069336; cv=none; b=kuigY1E2iiT4wC2+R9XjMyk9b3K0yHFNvw0z55eMZe9HEtdDgjqCwEnT5xM5SuaIal3TwYFeH2Hp3t9MCsXl9BSRu5ZEkNkkcZSRFoO5TDc5V3l4FKF2htJ1soEDwmS6VUTjCA1y092nBoobAR9dv4AsZsrxdQxhjWosUAaogTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749069336; c=relaxed/simple;
	bh=DB/HoxMOhe37qkJl3j8P/riE3CCdjUbDOahDdcFDTrk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=T1rKDk2QSSFrc4zgJM5zoAEC004fLcu8uBc/6M1q2ZYbkhPBa55OaqF54HXCicojyCinFF1YgSHe+AmAGh6lI+9iVlDCHhMZDMT+g29Wz8szi5+jSzeeYenG0pZGyDKGCtwySBJZoA3fsudHS2Z3HfJPpHNhuqOlNeo0mYhGdQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHIE/QX1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749069335; x=1780605335;
  h=date:from:to:cc:subject:message-id;
  bh=DB/HoxMOhe37qkJl3j8P/riE3CCdjUbDOahDdcFDTrk=;
  b=bHIE/QX1WOFwGdHE4b9jSpmuibFuGGgdZvPZlSUf2TCWMau3SJVjSmS2
   d0ySX8L0m2jqab80nh6Z4Vr0GDYsKsURmZXCL8wYUXH1N8+tscCqHW4AK
   99lYVbTNMXGReo8RCrLr+MID08WcmaNUfcHITbYWSI3FVuJflJzwFeLML
   BtRHwLeneyZZK0BHIF8w6ei8Xywaiso/S6LZix52JEyMvYPr1/1aua2CD
   uUOX8Di7mBcpj8AVz5gH55YR/t0uFCi9ID8T5N3OJZLwlw+rNztOQhdRr
   HSNsvG5l0mbqTZ2cNBOHXyVcROhkL3lcvoKp6cqZ9zjQW/rA/xdpDnTPB
   g==;
X-CSE-ConnectionGUID: jt8VR+MsTP6lL7XXQmMTKQ==
X-CSE-MsgGUID: LnCWxResQ5iatjIYB9Pm2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="50863558"
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="50863558"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 13:35:34 -0700
X-CSE-ConnectionGUID: e6UYdZAhRQCUWU8BTClICQ==
X-CSE-MsgGUID: gweNmWxPTSmdm0vUcrmInA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="150170048"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 04 Jun 2025 13:35:32 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uMupd-0003SS-2p;
	Wed, 04 Jun 2025 20:35:29 +0000
Date: Thu, 05 Jun 2025 04:35:23 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 8887abccf8aa16795f23ef3a3b25650cb8aa804c
Message-ID: <202506050412.BOBlNYMN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 8887abccf8aa16795f23ef3a3b25650cb8aa804c  PM: sleep: Add locking to dpm_async_resume_children()

elapsed time: 1437m

configs tested: 35
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
i386         allmodconfig    gcc-12
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

