Return-Path: <linux-acpi+bounces-20152-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D4DD0E15D
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 06:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 170E130049C0
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 05:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76C2221554;
	Sun, 11 Jan 2026 05:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OkSY4cCE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F0AF507;
	Sun, 11 Jan 2026 05:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768109569; cv=none; b=DM+gNjT107aRhl7ep7bOH2xKoLJcWp9T0fFfcCJgZ1Iv8wEMSJmJu70MRFSviO22oG3REAsGxq3eF01J/ZZz+yz1D7d1NicaYz7mqynbnGpDLg958qPnmqVPiJ53+wojHjqfKzsG2dmiox/jITC7hJJ2EOkJvE4RSKBZa49JlGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768109569; c=relaxed/simple;
	bh=ThaGW99bSjPIXtpZK4DbvpI9gx7q4i8q8JKy/UWNBGE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HfDmnDxKqkCMPKuis0OkUEcz2e/fnD1voMU1yMxe/D+x+c+n8Lxw7gt2VmHujhNL0GO3KnfSfrXJueKy1YbZR9256W4l+OkuzpZzKiEd9vjRKH8HayaZYXCARpNCv4RfOUc4+GmEajQLkzSx6ZTyFMwtga3gQNXADdwnW/ulP28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OkSY4cCE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768109568; x=1799645568;
  h=date:from:to:cc:subject:message-id;
  bh=ThaGW99bSjPIXtpZK4DbvpI9gx7q4i8q8JKy/UWNBGE=;
  b=OkSY4cCE1xN/9YtXLxdSq0sFwC/dziDKMrlgEhEWBriseggyLua6WT3t
   VbYXEdsZXJpQDqzmS/OWnaz7Oyvwu6KKNFB18hzbOXxqBe1htpBF4WaZP
   bfGeDiJNltS3OB6GkiLC9jnhjIHjpDLV+Au7ktnFslC9vJklrjiZ3HsEq
   Gl2W/dEcdnSQy/iJzJ/sKVA3USV6O6F7QoUXI/p0sDOrXP+tCH8xfuTzE
   can0s2NeJaaeblqeK7R2MnijGkZtZGjMoiiP7U7KoiKx15Qdspytq+nzw
   EhCgzllylMcrHuje8S9LJg2yFdoBaNQHu9RdGoelXNt537Av7eJgN9S36
   w==;
X-CSE-ConnectionGUID: zBna8QJJRfKbmC2GK9vG9Q==
X-CSE-MsgGUID: fSscm0jJQvagDZPn3Yk0Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11667"; a="80065636"
X-IronPort-AV: E=Sophos;i="6.21,217,1763452800"; 
   d="scan'208";a="80065636"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2026 21:32:47 -0800
X-CSE-ConnectionGUID: 6bJEnwvrQvyLdywNMcc8SQ==
X-CSE-MsgGUID: /b8EQrx3TBmxkSAj2olELg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,217,1763452800"; 
   d="scan'208";a="234502067"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Jan 2026 21:32:47 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1veo4B-000000009eI-39tu;
	Sun, 11 Jan 2026 05:32:43 +0000
Date: Sun, 11 Jan 2026 13:32:36 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 3d05eb1ff7f0d630cd8e80c294648acd06fb8b55
Message-ID: <202601111331.E865BiR4-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 3d05eb1ff7f0d630cd8e80c294648acd06fb8b55  Merge branch 'pm-sleep-fixes' into fixes

elapsed time: 7850m

configs tested: 55
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.1.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.1.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-22
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.1.0
csky         allmodconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.1.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-22
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-22
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.1.0
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.1.0
microblaze   allyesconfig    gcc-15.2.0
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.1.0
mips         allyesconfig    gcc-15.2.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.1.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.1.0
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.1.0
riscv        allmodconfig    clang-22
riscv         allnoconfig    gcc-15.1.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-22
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.1.0
sh           allyesconfig    gcc-15.2.0
sparc         allnoconfig    gcc-15.1.0
sparc64      allmodconfig    clang-22
um           allmodconfig    clang-19
um            allnoconfig    clang-22
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.1.0
xtensa       allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

