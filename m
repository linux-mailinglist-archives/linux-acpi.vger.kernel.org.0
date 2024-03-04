Return-Path: <linux-acpi+bounces-4086-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA02A8706A8
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 17:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D8C1C214ED
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 16:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0A7487BC;
	Mon,  4 Mar 2024 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHebgy7f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AD4482FA
	for <linux-acpi@vger.kernel.org>; Mon,  4 Mar 2024 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568725; cv=none; b=Jf+7fZS+DK5ZT7a/K2KLsTDIfGUszPsoZoUf2sIm8Sk4VpjuGkUABMnAOgPmIaNO4+YpoIe/IRxZU+ettReaTpAaclbUK1+qdwSNJ/odccoMbcV5RjF8sXgDc1bXz3vkuOemS/IEsEPjk6EqNjJlyxRLj8fCR9jwrnXR5TCY/X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568725; c=relaxed/simple;
	bh=9ylEbnGBAxKweUtmtjYAhB1C6ZhA6XSZZrqJuf1ucMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GBa8jg0wEis/DHfpB/lBY58SvuSRjRzlTAanHMNbBBQb2HnZ1ywfB80aKCYITC8KRWAbLhYicqnmZ7jTMCY0MuMDJWSlsZMZ8TiEJdNglJFf796FWb7TXW/HiZxte+aQ8GnY3eH1urgEg4hczIEJ3xW0PfRYD6MrlSWWkJx6F3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHebgy7f; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709568724; x=1741104724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9ylEbnGBAxKweUtmtjYAhB1C6ZhA6XSZZrqJuf1ucMw=;
  b=jHebgy7fyGqy3m4eVUswDUgyONW3p2hibWg+LDHBmu8DoQwBC0jtAsdX
   dL2SX903FqsfV7vuki7q2uX4dQeTgPrA1CWJi47GhoBfilN9BtqnsAwQb
   bafmicXT2wMViV+mF/kgf3PuXRdpGM3xAUJGrMIx/jdc9jEzoodYQs8an
   1a6rWOi6b2nYx2HAEjQ2l91dGkKjmS1PK3fHjvqP3SN2Mcd8mBMfwITZA
   nNbJCXTIbAiV92MGAZo9Gcx+6DcMvyFdlBqfcKjpEZQotsFrQj8hsbfCq
   IHZeNyfqggCMk5Gnme+i+tZAV3y5yqjH4cT7uyKjrYy7X+cC8JlOsVzR3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="14646508"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="14646508"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 08:12:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8967345"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmviesa009.fm.intel.com with ESMTP; 04 Mar 2024 08:11:58 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	robert.moore@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v5 1/4] ACPI: NHLT: Reintroduce types the table consists of
Date: Mon,  4 Mar 2024 17:13:32 +0100
Message-Id: <20240304161335.1734134-2-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240304161335.1734134-1-cezary.rojewski@intel.com>
References: <20240304161335.1734134-1-cezary.rojewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
'nhlt2' rather than 'nhlt'. Follow up changes clean this up once
existing code has no users and is removed.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/acpi/actbl2.h | 182 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 9775384d61c6..37dc59d57b05 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -2141,6 +2141,188 @@ struct acpi_nhlt_device_info {
 	u8 device_port_id;
 };
 
+/*******************************************************************************
+ *
+ * NHLT - Non HDAudio Link Table
+ *        Version 1
+ *
+ ******************************************************************************/
+
+struct acpi_table_nhlt2 {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u8 endpoints_count;
+	/*
+	 * struct acpi_nhlt_endpoint endpoints[];
+	 * struct acpi_nhlt_config oed_config;
+	 */
+};
+
+struct acpi_nhlt2_endpoint {
+	u32 length;
+	u8 link_type;
+	u8 instance_id;
+	u16 vendor_id;
+	u16 device_id;
+	u16 revision_id;
+	u32 subsystem_id;
+	u8 device_type;
+	u8 direction;
+	u8 virtual_bus_id;
+	/*
+	 * struct acpi_nhlt_config device_config;
+	 * struct acpi_nhlt_formats_config formats_config;
+	 * struct acpi_nhlt_devices_info devices_info;
+	 */
+};
+
+/* Values for link_type field above */
+
+#define ACPI_NHLT_LINKTYPE_HDA			0
+#define ACPI_NHLT_LINKTYPE_DSP			1
+#define ACPI_NHLT_LINKTYPE_PDM			2
+#define ACPI_NHLT_LINKTYPE_SSP			3
+#define ACPI_NHLT_LINKTYPE_SLIMBUS		4
+#define ACPI_NHLT_LINKTYPE_SDW			5
+#define ACPI_NHLT_LINKTYPE_UAOL			6
+
+/* Values for device_id field above */
+
+#define ACPI_NHLT_DEVICEID_DMIC			0xAE20
+#define ACPI_NHLT_DEVICEID_BT			0xAE30
+#define ACPI_NHLT_DEVICEID_I2S			0xAE34
+
+/* Values for device_type field above */
+
+/* Device types unique to endpoint of link_type=PDM */
+#define ACPI_NHLT_DEVICETYPE_PDM		0
+#define ACPI_NHLT_DEVICETYPE_PDM_SKL		1
+/* Device types unique to endpoint of link_type=SSP */
+#define ACPI_NHLT_DEVICETYPE_BT			0
+#define ACPI_NHLT_DEVICETYPE_FM			1
+#define ACPI_NHLT_DEVICETYPE_MODEM		2
+#define ACPI_NHLT_DEVICETYPE_CODEC		4
+
+/* Values for Direction field above */
+
+#define ACPI_NHLT_DIR_RENDER			0
+#define ACPI_NHLT_DIR_CAPTURE			1
+
+struct acpi_nhlt_config {
+	u32 capabilities_size;
+	u8 capabilities[];
+};
+
+struct acpi_nhlt_gendevice_config {
+	u8 virtual_slot;
+	u8 config_type;
+};
+
+/* Values for config_type field above */
+
+#define ACPI_NHLT_CONFIGTYPE_GENERIC		0
+#define ACPI_NHLT_CONFIGTYPE_MICARRAY		1
+
+struct acpi_nhlt_micdevice_config {
+	u8 virtual_slot;
+	u8 config_type;
+	u8 array_type;
+};
+
+/* Values for array_type field above */
+
+#define ACPI_NHLT_ARRAYTYPE_LINEAR2_SMALL	0xA
+#define ACPI_NHLT_ARRAYTYPE_LINEAR2_BIG		0xB
+#define ACPI_NHLT_ARRAYTYPE_LINEAR4_GEO1	0xC
+#define ACPI_NHLT_ARRAYTYPE_PLANAR4_LSHAPED	0xD
+#define ACPI_NHLT_ARRAYTYPE_LINEAR4_GEO2	0xE
+#define ACPI_NHLT_ARRAYTYPE_VENDOR		0xF
+
+struct acpi_nhlt2_vendor_mic_config {
+	u8 type;
+	u8 panel;
+	u16 speaker_position_distance;		/* mm */
+	u16 horizontal_offset;			/* mm */
+	u16 vertical_offset;			/* mm */
+	u8 frequency_low_band;			/* 5*Hz */
+	u8 frequency_high_band;			/* 500*Hz */
+	u16 direction_angle;			/* -180 - +180 */
+	u16 elevation_angle;			/* -180 - +180 */
+	u16 work_vertical_angle_begin;		/* -180 - +180 with 2 deg step */
+	u16 work_vertical_angle_end;		/* -180 - +180 with 2 deg step */
+	u16 work_horizontal_angle_begin;	/* -180 - +180 with 2 deg step */
+	u16 work_horizontal_angle_end;		/* -180 - +180 with 2 deg step */
+};
+
+/* Values for Type field above */
+
+#define ACPI_NHLT_MICTYPE_OMNIDIRECTIONAL	0
+#define ACPI_NHLT_MICTYPE_SUBCARDIOID		1
+#define ACPI_NHLT_MICTYPE_CARDIOID		2
+#define ACPI_NHLT_MICTYPE_SUPERCARDIOID		3
+#define ACPI_NHLT_MICTYPE_HYPERCARDIOID		4
+#define ACPI_NHLT_MICTYPE_8SHAPED		5
+#define ACPI_NHLT_MICTYPE_RESERVED		6
+#define ACPI_NHLT_MICTYPE_VENDORDEFINED		7
+
+/* Values for Panel field above */
+
+#define ACPI_NHLT_MICLOCATION_TOP		0
+#define ACPI_NHLT_MICLOCATION_BOTTOM		1
+#define ACPI_NHLT_MICLOCATION_LEFT		2
+#define ACPI_NHLT_MICLOCATION_RIGHT		3
+#define ACPI_NHLT_MICLOCATION_FRONT		4
+#define ACPI_NHLT_MICLOCATION_REAR		5
+
+struct acpi_nhlt_vendor_micdevice_config {
+	u8 virtual_slot;
+	u8 config_type;
+	u8 array_type;
+	u8 mics_count;
+	struct acpi_nhlt2_vendor_mic_config mics[];
+};
+
+union acpi_nhlt_device_config {
+	u8 virtual_slot;
+	struct acpi_nhlt_gendevice_config gen;
+	struct acpi_nhlt_micdevice_config mic;
+	struct acpi_nhlt_vendor_micdevice_config vendor_mic;
+};
+
+/* Inherited from Microsoft's WAVEFORMATEXTENSIBLE. */
+struct acpi_nhlt2_wave_formatext {
+	u16 format_tag;
+	u16 channel_count;
+	u32 samples_per_sec;
+	u32 avg_bytes_per_sec;
+	u16 block_align;
+	u16 bits_per_sample;
+	u16 extra_format_size;
+	u16 valid_bits_per_sample;
+	u32 channel_mask;
+	u8 subformat[16];
+};
+
+struct acpi_nhlt2_format_config {
+	struct acpi_nhlt2_wave_formatext format;
+	struct acpi_nhlt_config config;
+};
+
+struct acpi_nhlt2_formats_config {
+	u8 formats_count;
+	struct acpi_nhlt2_format_config formats[];
+};
+
+struct acpi_nhlt2_device_info {
+	u8 id[16];
+	u8 instance_id;
+	u8 port_id;
+};
+
+struct acpi_nhlt_devices_info {
+	u8 devices_count;
+	struct acpi_nhlt2_device_info devices[];
+};
+
 /*******************************************************************************
  *
  * PCCT - Platform Communications Channel Table (ACPI 5.0)
-- 
2.25.1


