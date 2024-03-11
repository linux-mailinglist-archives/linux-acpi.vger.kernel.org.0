Return-Path: <linux-acpi+bounces-4241-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AA4877DE4
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 11:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBE51C20F46
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 10:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BFF2375F;
	Mon, 11 Mar 2024 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5LCt+T5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B69422064
	for <linux-acpi@vger.kernel.org>; Mon, 11 Mar 2024 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710152117; cv=none; b=p/7k6VayAuGjdi91yA7eGYr32mRM+IGM5237btbAQ2Gg+pkA9DtgmSLbc9qyK8C7qLXjt5maWGA0gd7gM5B2Bl5QS9cDGJ9UPttxzNYowrnY0Fp49sHB09TGNcH5Lnu8VFwO/mmYz4yUA/nGhTdAT+f2wYjXMVHl9Ly+kH5lTXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710152117; c=relaxed/simple;
	bh=4ofYxvw0sp/NeBW71fBYgoEXxbrVIpf10jtGEyhZyEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B9MQENP+ieL3a37RwpvUggWoOdqd7I34ok2bilakqvDUJ8h2Na6qwRZ2O/FZ/qVzr4UOVCVtMeAq8pDWq8NXwOPdRTPiAdj9PT4MY6FwVZB4OmpStZ/KSGkvBeAX7D6tfWDLfrH1MCq8xbn4Q4sdI+lAxA+T8vug9X9bzrY2NgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5LCt+T5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710152115; x=1741688115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ofYxvw0sp/NeBW71fBYgoEXxbrVIpf10jtGEyhZyEM=;
  b=Z5LCt+T58vuKc4lMdDBhIg2y5O5NoYS21p/tQ62fgJWTpgioe4epWzL1
   KNxl67v5PiKzoJn0GuMVe2oJtthcm43V/Cwwf+SEuVplzYpRBrCBBI/2O
   rbneL1CbO7uVJAus/5VcusqNlBW7AIan6X1cnaTuADmsbhdx42Eg4+0qn
   CsUqGliyFi8Xa8D4nhGGBKGi8IRQxUuPjQJ2IVh+jwwtEoRpzfBN/yAm5
   QznUu4q6O3UtLgYaTrd5PSv3qQ0JB66OYT1Td1cEGRGRRns296ryIJogh
   S76buZEV/uOI9B8bXH7Hja7Rzm29wqTgDeuIQcF3sy1fcXabzBFst1mwu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15535315"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15535315"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 03:15:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11689035"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by orviesa008.jf.intel.com with ESMTP; 11 Mar 2024 03:15:12 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	robert.moore@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v7 1/4] ACPI: NHLT: Reintroduce types the table consists of
Date: Mon, 11 Mar 2024 11:16:55 +0100
Message-Id: <20240311101658.2343816-2-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240311101658.2343816-1-cezary.rojewski@intel.com>
References: <20240311101658.2343816-1-cezary.rojewski@intel.com>
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
 include/acpi/actbl2.h | 189 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 9775384d61c6..8030a1743100 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -2141,6 +2141,195 @@ struct acpi_nhlt_device_info {
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
+/*
+ * Values for link_type field above
+ *
+ * Only types PDM and SSP are used
+ */
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
+/*
+ * Device types unique to endpoint of link_type=PDM
+ *
+ * Type PDM used for all SKL+ platforms
+ */
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


