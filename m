Return-Path: <linux-acpi+bounces-4372-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A9187F9C3
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Mar 2024 09:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9111C21B95
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Mar 2024 08:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB47754746;
	Tue, 19 Mar 2024 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="boN89ypT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CC1548EA
	for <linux-acpi@vger.kernel.org>; Tue, 19 Mar 2024 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836927; cv=none; b=mY8vGbIggM+2+mjFTRE6UmB/7JwUKM5cNKT3JbQcssn0j+5BlyYsJ0f/GQxgrpl7H1V9jftjRWqkbN+pSLhckmHJsSDMhh/nawbm6Ryl0SheKhvOyL13n4Phy7VhDP0vrFZB3SHTWK6IZzgtg8NXqi//HY0djxy8DqnNwjqqf4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836927; c=relaxed/simple;
	bh=h7BrpAwQ6QzdzxUH5xwJh7dNpL89171MEZNa8doUcQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ins1ay6RGOO9t38IH/tRuN9wovNACDWyg1o5+cY8kxBJI2qrM2GsXV3VSGLH8dC9h9ZhNoji7CUj8qTXheFnP3HdSGX9dvea/pDgFnG+TpVpK9UMUMQzG4tWkh7Cy4WYraXPGKn3jJlUJOf+7KhvBi/dpVsBswrBaum/hzPqrT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=boN89ypT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710836925; x=1742372925;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h7BrpAwQ6QzdzxUH5xwJh7dNpL89171MEZNa8doUcQo=;
  b=boN89ypTODtiDzo38c+hbTRVzr8tVZ6b+Rn+Gs75qnS5fRndQG6wX6NM
   JOM/zgRQFV8mBM650kso4aM3Adt4RnrAhPOBb1AoXJS5V+Ng4BPM6hGej
   ChgHub+OqFORRDCyJgKWoc3ihkmPI8aY86OWl0aL8LSLC9JgoVLL7mclb
   WZM9ZRaSS/DMoTp/fo28UPAbMS3l01YBYZlV5BUAah1WGtq02XsyFhIx2
   5ULcUhMrKdumaEazTex0aKdvUdSetLwV+6OlnEm9huZs8YJavxHTZWU01
   i2rrfZi+tGpCNtn666ADKfIpnKa79nvrxz+k49LcPXzy9hWiFUrmqF9A+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5621340"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5621340"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:28:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="44808836"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmviesa001.fm.intel.com with ESMTP; 19 Mar 2024 01:28:42 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	robert.moore@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v8 0/4] ACPI: NHLT: Access and query helpers
Date: Tue, 19 Mar 2024 09:30:14 +0100
Message-Id: <20240319083018.3159716-1-cezary.rojewski@intel.com>
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


Changes in v8:
- fixed file headers for all added files
- commit messages now carry links to ACPICA PRs and relevant commits ids

Changes in v7:
- added missing headers to nhlt.c/nhlt.h as suggested by Andy

Changes in v6:
- added comments explaining usage of LINKTYPE and DEVICETYPE constants

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
 drivers/acpi/nhlt.c   | 289 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/actbl2.h | 299 +++++++++++++++++-------------------------
 include/acpi/nhlt.h   | 181 +++++++++++++++++++++++++
 5 files changed, 591 insertions(+), 182 deletions(-)
 create mode 100644 drivers/acpi/nhlt.c
 create mode 100644 include/acpi/nhlt.h

-- 
2.25.1


