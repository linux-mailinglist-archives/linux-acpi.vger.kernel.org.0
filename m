Return-Path: <linux-acpi+bounces-4176-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A78875E8E
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 08:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594B71C21543
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 07:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65754F5FE;
	Fri,  8 Mar 2024 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERo/2rZC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD634F5F9
	for <linux-acpi@vger.kernel.org>; Fri,  8 Mar 2024 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883056; cv=none; b=kbC4IHlM29zz1kyahswZoXM/SYpZuOkyQxvxtRJpSqMJyYBz1Tpblum4dDQJuoEl6CICaFBgSdDzyfSGXpYgY0vxbAeX/+CpjIasCCOHQmpz+v+q+lz91zfyG6ARPSErbMYovEHXbk17AyTuTxoMNgndJvIQlY55KZT54ZmIX+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883056; c=relaxed/simple;
	bh=vW0X54LcIFK6xdIHsf9sdlfXF/+2DACdn4J590QU6M8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dy20XzatRmD7Pck7Z8tlJ7gjsmbs4TB3z0RvKh9G849TfTMnOdMP8tyb/sxUgRHjFueyTg/ig8Dy19XRLLBD5Duo6io+Ua7R1TAfER/PnTx9qytdmx/dXgfiCQ6HN0+204HXDWwL4jlQPQDwmaChc2HeMYr22cV8lhm/vcdQsvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERo/2rZC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709883055; x=1741419055;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vW0X54LcIFK6xdIHsf9sdlfXF/+2DACdn4J590QU6M8=;
  b=ERo/2rZC2w5p9MuUdGSmvlDFvP0WXZaGCz4zVwErJBDKyIByuQzo/ftF
   RVeUgNNMXhANI8KE+K9IFtYLOFqvtfPye3hkcTZDgXBZwCr4fW7p3k8co
   jmVm+2GYsBxlJTmjAnxeNnIXzeprxMr5uEZiwvQbPn1lnp0HxO+viY+FR
   WIizFNFEa4OJX2p+YtDb987xSByTs5SQbTOIDDJ5KD9LWcfZ3jRjfY0zV
   PPI9NMfQ0YVeqeQgBSqqJTWAWiY2Jlrqr04I3Ua2zobuCGCJwU1blPiUt
   x5rCYzZip918qA/x2AVXKbu+baUTseSB8wu1sebue5F9+Xw6f33PKfJ5h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4771715"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="4771715"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 23:30:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="10472216"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmviesa008.fm.intel.com with ESMTP; 07 Mar 2024 23:30:52 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	robert.moore@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v6 0/4] ACPI: NHLT: Access and query helpers
Date: Fri,  8 Mar 2024 08:32:36 +0100
Message-Id: <20240308073240.2047932-1-cezary.rojewski@intel.com>
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
 drivers/acpi/nhlt.c   | 284 +++++++++++++++++++++++++++++++++++++++
 include/acpi/actbl2.h | 299 +++++++++++++++++-------------------------
 include/acpi/nhlt.h   | 180 +++++++++++++++++++++++++
 5 files changed, 585 insertions(+), 182 deletions(-)
 create mode 100644 drivers/acpi/nhlt.c
 create mode 100644 include/acpi/nhlt.h

-- 
2.25.1


