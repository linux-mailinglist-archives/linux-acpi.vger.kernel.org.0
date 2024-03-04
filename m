Return-Path: <linux-acpi+bounces-4085-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBBB8706AF
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 17:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF79B25D0F
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 16:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FD1482ED;
	Mon,  4 Mar 2024 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxHHN5ym"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE7F3CF40
	for <linux-acpi@vger.kernel.org>; Mon,  4 Mar 2024 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568723; cv=none; b=MQOO8srIAu0GiGpN8ac6o78J3OinKYNS/+vtVcwlNH9LgFk70IVEK2rOk5A2wT9RHHMKaPv8GmND/SPrdSx3piFbwMW4obW1mCLEL/phbpnBUTA8GowEJ98yqi1PZJVGv7Ih5VrUEiljZzHfWaBWPpUcVD2WT1jgB1DUw0nCAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568723; c=relaxed/simple;
	bh=AbzY7pJqyxsYDqgk52E+SSdLLdLjQERVDbPxkT/nbNI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P8cIN13opEEqafwWisttGFm6YxnnmIhXBLEtw46snC9BwDalwIX5z5pENbPbXXuzL+xi5fe9RhbBEFX8NOlIZgWcL4cUu+ko0LwlIig5ExD0DSq+/Ga1+qSloeIhwqU9XWInYgtUMvjS5A+rNaltIHHBJdOnYwb3yLVtf+uDEKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxHHN5ym; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709568722; x=1741104722;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AbzY7pJqyxsYDqgk52E+SSdLLdLjQERVDbPxkT/nbNI=;
  b=RxHHN5yman1PnwdD5Q+vuoRV4B1h8R/jNbvZDKzx711MfwWeXm4V7Myk
   aGrj77x2Yc2gsuh0FUe4HNhaNZHSVgglHUxVc4A3vlHYcm//AULj9iLd1
   /JwwdWK9ZnaFwIfTGH2B3yAnZaJqURca3fCX5P4+r/dymY3o3vRI7TzTZ
   yzqiH9ihuxknvvbH+QaMeNmsj+5R8brQdD1QMpwpl/Wjdw5vlSN/f+2aZ
   vIafTTMxP2h9YcbxhJbyxuCA4n9xf14CP0ge+pRgdce8mj+Gq+0DS0bMe
   R/22jKZ5yeqHGrJ9jKCzsBMKh7nhiFmE+2cftkSLaofDOWcUYNceNw3VF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="14646503"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="14646503"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 08:11:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8967307"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmviesa009.fm.intel.com with ESMTP; 04 Mar 2024 08:11:56 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	robert.moore@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v5 0/4] ACPI: NHLT: Access and query helpers
Date: Mon,  4 Mar 2024 17:13:31 +0100
Message-Id: <20240304161335.1734134-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal of this patchset is to refactor existing interface of
Non HDAudio Link Table (NHLT) table so it becomes useful for the Intel
AudioDSP sound-drivers. Right now the useful duplicate resides in
sound/hda/intel-nhlt.c.

The API takes form of query functions that help access device or
audio-format configuration space. This information can be then utilized
by a sound-driver to perform necessary programming and facilitate
streaming over I2S/PDM interfaces. Once the series is merged, existing
sound-drivers can move from utilizing sound/hda/intel-nhlt.c to this
very code and ultimately the former file can be removed.

Paired with equivalent change on ACPICA [1].

-

Non HDAudio Link Table (NHLT) is designed to separate hardware-related
description (registers) from AudioDSP firmware-related one i.e.:
pipelines and modules that together make up the audio stream on Intel
DSPs. This task is important as same set of hardware registers can be
used with different topologies and vice versa, same topology could be
utilized with different set of hardware. As the hardware registers
description is directly tied to specific platform, intention is to have
such description part of low-level firmware e.g.: BIOS.

The initial design has been provided in early Sky Lake (SKL) days. The
audio architecture goes by the name cAVS. SKL is a representative of
cAVS 1.5. The table helps describe endpoint capabilities ever since.
While Raptor Lake (RPL) is the last of cAVS architecture - cAVS 2.5 to
be precise - its successor, the ACE architecture which begun with
Meteor Lake (MTL) inherited the design for all I2S and PDM
configurations. These two configurations are the primary targets for
NHLT table.

Due to naming conflicts with existing code, several structs are named
'nhlt2' rather than 'nhlt'. Last patch cleans the situation up.


Changes in v5:
- split find_endpoint/fmtcfg() into tb-less and tb-aware variants.
  This is to make API scale with 2+ NHLTs and removes the need for
  acpi_gbl_nhlt to be accessible globally.
- acpi_nhlt_device_config now a union that encompasses all device_config
  types.

Changes in v4:
- relocated ACPI_NHLT kconfig in the drivers/acpi/Kconfig to a more
  relevant area within the file

Changes in v3:
- uncapitalized acpi_gbl_NHLT
- fixed compilation problems when CONFIG_ACPI_NHLT is disabled
- dropped Reviewed-by tags in the 2/4 patch due to above, those were not
  one-line changes

Changes in v2:
- minor wording improvements in kernel-doc for patch 3/4
- dropped parentheses around loop cursors in for_each_nhlt_*() macros
- readability improvements in compound if-statements within query
  functions
- dropped NULL-checks in query functions

[1]: https://github.com/acpica/acpica/pull/912


Cezary Rojewski (4):
  ACPI: NHLT: Reintroduce types the table consists of
  ACPI: NHLT: Introduce API for the table
  ACPI: NHLT: Drop redundant types
  ACPI: NHLT: Streamline struct naming

 drivers/acpi/Kconfig  |   3 +
 drivers/acpi/Makefile |   1 +
 drivers/acpi/nhlt.c   | 284 +++++++++++++++++++++++++++++++++++++++++
 include/acpi/actbl2.h | 290 ++++++++++++++++--------------------------
 include/acpi/nhlt.h   | 180 ++++++++++++++++++++++++++
 5 files changed, 577 insertions(+), 181 deletions(-)
 create mode 100644 drivers/acpi/nhlt.c
 create mode 100644 include/acpi/nhlt.h

-- 
2.25.1


