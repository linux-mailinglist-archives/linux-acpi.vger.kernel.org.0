Return-Path: <linux-acpi+bounces-4240-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95FB877DE3
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 11:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937EC280405
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 10:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9152122338;
	Mon, 11 Mar 2024 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LEEGTAVt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82517999
	for <linux-acpi@vger.kernel.org>; Mon, 11 Mar 2024 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710152115; cv=none; b=DMjb4yIYKzLNgJlNYdJcUKIadyIXDAtgToCfn2sX3Ym136BMGK/uISP680DhCVNfemyJxe8jhQ2eDyOndElQCwST7yAIfL6t0EZlCCyodAvC1CTsZ4NtyIfC+WqA048AsiHPuOkYgxhhYgmycVBGszJ6Jv7DECs7X4cFoXh3UaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710152115; c=relaxed/simple;
	bh=7DKafyGBNkBCSoYx5HMiGAzX+Y6+wgH2x2fRQeOgx2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ONy44zJFCXOKHA4tJts6175MJ4Ea1DMaILFam1fyFEdYDhCC8W6ZkO+u1yir0RTZwnHTrXEdr1f9u6GZm6OvxqjPtl0p/9mkOP15REXwZ3EnNhuRg2YL0tcA+fflTu/0X/XjWyUXjHzTlbH4G3CbB/O2JyJF2IqIn+mRvRirNGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LEEGTAVt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710152114; x=1741688114;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7DKafyGBNkBCSoYx5HMiGAzX+Y6+wgH2x2fRQeOgx2M=;
  b=LEEGTAVtjVE0dQ8FYTfK0EAkfpFfy2kRqjnOUSNo2rhzmJDnHtZ/Zrgz
   +mWNUe+B9nDuU3zkzPs9RMYF4PGL1gXLqAOXf4Ii0VqB1jXTxH3sebfHx
   +mdNRM3SyXOT9kLCCXymZ6kfvm4fRF5C+ebbmVUn2NvzASWEZrz+OaVew
   9gnyBw4y45GzmK+bbtpc8Evc7DxLPyIAx1M4Gtob0cwQIv/+WvXnv3J61
   SoEcFF+WRP5egSihIc/fmbj58fpZWmPyOY95tMDP0rsv8nynZPk8yU4EO
   udHCWGDF0XQkARyUyOJgwEusjaLLA17oiex+r0srZvy4YhiLr1I4rT0Dj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15535311"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15535311"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 03:15:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11689016"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by orviesa008.jf.intel.com with ESMTP; 11 Mar 2024 03:15:10 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	robert.moore@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v7 0/4] ACPI: NHLT: Access and query helpers
Date: Mon, 11 Mar 2024 11:16:54 +0100
Message-Id: <20240311101658.2343816-1-cezary.rojewski@intel.com>
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


