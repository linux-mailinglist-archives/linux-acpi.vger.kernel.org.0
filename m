Return-Path: <linux-acpi+bounces-4179-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6F3875E91
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 08:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C891F234F7
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 07:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3178F4F1EB;
	Fri,  8 Mar 2024 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVBfC7Bp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5203E4F1E0
	for <linux-acpi@vger.kernel.org>; Fri,  8 Mar 2024 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883062; cv=none; b=p3XJo1t+DA4SjMPUt3kBJ1wiX1eLPrQDjL7w1S/MJMa2qFjQR0UT91CkOu6yLmoVq+cTcWthZ0AH4dhGe84siX3oDiTPE4qh5CxuwzwiA7U7j83XVoktvTsESGppHicq02Od6KEQoBFH2/Y9sMj9LQJnsyd7cEAIw8CmwRyiRx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883062; c=relaxed/simple;
	bh=yhIQ5ut2TGi29Xd6cmzIGuOECw1MorBumAs/o7ZC+h8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cJA48JXNNwHwOeHN0d5i0ImTwIA7+bp6N8lMRzkmNaLb1ajvSvOgsc6WYIk7NtVMPP528qV1tzrdZNCeCBDEkNzWTER+1gq++1aimPBXSLIBFsxt22aXexDKwHw6PFY4By5f/ZqMPajoZ+SpOm1Ok0OPXxa4Wn/Cdt+EO99biBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVBfC7Bp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709883060; x=1741419060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yhIQ5ut2TGi29Xd6cmzIGuOECw1MorBumAs/o7ZC+h8=;
  b=NVBfC7BpexvAT6SjjMqv60fVukUhu4U2jt2tjzcxdcheO8+GMulQEzOV
   YpqjbrICRyeSZpAB+8q/wWm676Kn/LRL5qK/mlbAWApd91O1oGNHvL6ZE
   I+5PzKn7VdxsX3IdzvkCdKHJiX34qvxjTP6nfftxh4/5zQnPurv83HYWW
   euYaMhZW8QLtlb3JkR/yprPZJSu+n7CF9SzwupEe9qus+9HDxCKnzBzuM
   wyYOTFvlCguBT0KT6Go5ioBrpzJSMTRNmEyCuEDpKLpKN8Sa8RLhEV6G2
   wBHAw55mxSzSDhGQbSK96J6AdqzQLzqOqXg52a0b77WdZdMjvLZrIhBSL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4771722"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="4771722"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 23:31:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="10472227"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmviesa008.fm.intel.com with ESMTP; 07 Mar 2024 23:30:58 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	robert.moore@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v6 3/4] ACPI: NHLT: Drop redundant types
Date: Fri,  8 Mar 2024 08:32:39 +0100
Message-Id: <20240308073240.2047932-4-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240308073240.2047932-1-cezary.rojewski@intel.com>
References: <20240308073240.2047932-1-cezary.rojewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no users for the duplicated NHLT table components.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/acpi/actbl2.h | 254 ------------------------------------------
 1 file changed, 254 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 8030a1743100..31a716a74340 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1887,260 +1887,6 @@ struct nfit_device_handle {
 #define ACPI_NFIT_GET_NODE_ID(handle) \
 	(((handle) & ACPI_NFIT_NODE_ID_MASK)        >> ACPI_NFIT_NODE_ID_OFFSET)
 
-/*******************************************************************************
- *
- * NHLT - Non HD Audio Link Table
- *
- * Conforms to: Intel Smart Sound Technology NHLT Specification
- * Version 0.8.1, January 2020.
- *
- ******************************************************************************/
-
-/* Main table */
-
-struct acpi_table_nhlt {
-	struct acpi_table_header header;	/* Common ACPI table header */
-	u8 endpoint_count;
-};
-
-struct acpi_nhlt_endpoint {
-	u32 descriptor_length;
-	u8 link_type;
-	u8 instance_id;
-	u16 vendor_id;
-	u16 device_id;
-	u16 revision_id;
-	u32 subsystem_id;
-	u8 device_type;
-	u8 direction;
-	u8 virtual_bus_id;
-};
-
-/* Types for link_type field above */
-
-#define ACPI_NHLT_RESERVED_HD_AUDIO         0
-#define ACPI_NHLT_RESERVED_DSP              1
-#define ACPI_NHLT_PDM                       2
-#define ACPI_NHLT_SSP                       3
-#define ACPI_NHLT_RESERVED_SLIMBUS          4
-#define ACPI_NHLT_RESERVED_SOUNDWIRE        5
-#define ACPI_NHLT_TYPE_RESERVED             6	/* 6 and above are reserved */
-
-/* All other values above are reserved */
-
-/* Values for device_id field above */
-
-#define ACPI_NHLT_PDM_DMIC                  0xAE20
-#define ACPI_NHLT_BT_SIDEBAND               0xAE30
-#define ACPI_NHLT_I2S_TDM_CODECS            0xAE23
-
-/* Values for device_type field above */
-
-/* SSP Link */
-
-#define ACPI_NHLT_LINK_BT_SIDEBAND          0
-#define ACPI_NHLT_LINK_FM                   1
-#define ACPI_NHLT_LINK_MODEM                2
-/* 3 is reserved */
-#define ACPI_NHLT_LINK_SSP_ANALOG_CODEC     4
-
-/* PDM Link */
-
-#define ACPI_NHLT_PDM_ON_CAVS_1P8           0
-#define ACPI_NHLT_PDM_ON_CAVS_1P5           1
-
-/* Values for Direction field above */
-
-#define ACPI_NHLT_DIR_RENDER                0
-#define ACPI_NHLT_DIR_CAPTURE               1
-#define ACPI_NHLT_DIR_RENDER_LOOPBACK       2
-#define ACPI_NHLT_DIR_RENDER_FEEDBACK       3
-#define ACPI_NHLT_DIR_RESERVED              4	/* 4 and above are reserved */
-
-struct acpi_nhlt_device_specific_config {
-	u32 capabilities_size;
-	u8 virtual_slot;
-	u8 config_type;
-};
-
-struct acpi_nhlt_device_specific_config_a {
-	u32 capabilities_size;
-	u8 virtual_slot;
-	u8 config_type;
-	u8 array_type;
-};
-
-/* Values for Config Type above */
-
-#define ACPI_NHLT_CONFIG_TYPE_GENERIC              0x00
-#define ACPI_NHLT_CONFIG_TYPE_MIC_ARRAY            0x01
-#define ACPI_NHLT_CONFIG_TYPE_RENDER_FEEDBACK      0x03
-#define ACPI_NHLT_CONFIG_TYPE_RESERVED             0x04	/* 4 and above are reserved */
-
-struct acpi_nhlt_device_specific_config_b {
-	u32 capabilities_size;
-};
-
-struct acpi_nhlt_device_specific_config_c {
-	u32 capabilities_size;
-	u8 virtual_slot;
-};
-
-struct acpi_nhlt_render_device_specific_config {
-	u32 capabilities_size;
-	u8 virtual_slot;
-};
-
-struct acpi_nhlt_wave_extensible {
-	u16 format_tag;
-	u16 channel_count;
-	u32 samples_per_sec;
-	u32 avg_bytes_per_sec;
-	u16 block_align;
-	u16 bits_per_sample;
-	u16 extra_format_size;
-	u16 valid_bits_per_sample;
-	u32 channel_mask;
-	u8 sub_format_guid[16];
-};
-
-/* Values for channel_mask above */
-
-#define ACPI_NHLT_SPKR_FRONT_LEFT             0x1
-#define ACPI_NHLT_SPKR_FRONT_RIGHT            0x2
-#define ACPI_NHLT_SPKR_FRONT_CENTER           0x4
-#define ACPI_NHLT_SPKR_LOW_FREQ               0x8
-#define ACPI_NHLT_SPKR_BACK_LEFT              0x10
-#define ACPI_NHLT_SPKR_BACK_RIGHT             0x20
-#define ACPI_NHLT_SPKR_FRONT_LEFT_OF_CENTER   0x40
-#define ACPI_NHLT_SPKR_FRONT_RIGHT_OF_CENTER  0x80
-#define ACPI_NHLT_SPKR_BACK_CENTER            0x100
-#define ACPI_NHLT_SPKR_SIDE_LEFT              0x200
-#define ACPI_NHLT_SPKR_SIDE_RIGHT             0x400
-#define ACPI_NHLT_SPKR_TOP_CENTER             0x800
-#define ACPI_NHLT_SPKR_TOP_FRONT_LEFT         0x1000
-#define ACPI_NHLT_SPKR_TOP_FRONT_CENTER       0x2000
-#define ACPI_NHLT_SPKR_TOP_FRONT_RIGHT        0x4000
-#define ACPI_NHLT_SPKR_TOP_BACK_LEFT          0x8000
-#define ACPI_NHLT_SPKR_TOP_BACK_CENTER        0x10000
-#define ACPI_NHLT_SPKR_TOP_BACK_RIGHT         0x20000
-
-struct acpi_nhlt_format_config {
-	struct acpi_nhlt_wave_extensible format;
-	u32 capability_size;
-	u8 capabilities[];
-};
-
-struct acpi_nhlt_formats_config {
-	u8 formats_count;
-};
-
-struct acpi_nhlt_device_specific_hdr {
-	u8 virtual_slot;
-	u8 config_type;
-};
-
-/* Types for config_type above */
-
-#define ACPI_NHLT_GENERIC                   0
-#define ACPI_NHLT_MIC                       1
-#define ACPI_NHLT_RENDER                    3
-
-struct acpi_nhlt_mic_device_specific_config {
-	struct acpi_nhlt_device_specific_hdr device_config;
-	u8 array_type_ext;
-};
-
-/* Values for array_type_ext above */
-
-#define ACPI_NHLT_ARRAY_TYPE_RESERVED               0x09	/* 9 and below are reserved */
-#define ACPI_NHLT_SMALL_LINEAR_2ELEMENT             0x0A
-#define ACPI_NHLT_BIG_LINEAR_2ELEMENT               0x0B
-#define ACPI_NHLT_FIRST_GEOMETRY_LINEAR_4ELEMENT    0x0C
-#define ACPI_NHLT_PLANAR_LSHAPED_4ELEMENT           0x0D
-#define ACPI_NHLT_SECOND_GEOMETRY_LINEAR_4ELEMENT   0x0E
-#define ACPI_NHLT_VENDOR_DEFINED                    0x0F
-#define ACPI_NHLT_ARRAY_TYPE_MASK                   0x0F
-#define ACPI_NHLT_ARRAY_TYPE_EXT_MASK               0x10
-
-#define ACPI_NHLT_NO_EXTENSION                      0x0
-#define ACPI_NHLT_MIC_SNR_SENSITIVITY_EXT           (1<<4)
-
-struct acpi_nhlt_vendor_mic_count {
-	u8 microphone_count;
-};
-
-struct acpi_nhlt_vendor_mic_config {
-	u8 type;
-	u8 panel;
-	u16 speaker_position_distance;	/* mm */
-	u16 horizontal_offset;	/* mm */
-	u16 vertical_offset;	/* mm */
-	u8 frequency_low_band;	/* 5*Hz */
-	u8 frequency_high_band;	/* 500*Hz */
-	u16 direction_angle;	/* -180 - + 180 */
-	u16 elevation_angle;	/* -180 - + 180 */
-	u16 work_vertical_angle_begin;	/* -180 - + 180 with 2 deg step */
-	u16 work_vertical_angle_end;	/* -180 - + 180 with 2 deg step */
-	u16 work_horizontal_angle_begin;	/* -180 - + 180 with 2 deg step */
-	u16 work_horizontal_angle_end;	/* -180 - + 180 with 2 deg step */
-};
-
-/* Values for Type field above */
-
-#define ACPI_NHLT_MIC_OMNIDIRECTIONAL       0
-#define ACPI_NHLT_MIC_SUBCARDIOID           1
-#define ACPI_NHLT_MIC_CARDIOID              2
-#define ACPI_NHLT_MIC_SUPER_CARDIOID        3
-#define ACPI_NHLT_MIC_HYPER_CARDIOID        4
-#define ACPI_NHLT_MIC_8_SHAPED              5
-#define ACPI_NHLT_MIC_RESERVED6             6	/* 6 is reserved */
-#define ACPI_NHLT_MIC_VENDOR_DEFINED        7
-#define ACPI_NHLT_MIC_RESERVED              8	/* 8 and above are reserved */
-
-/* Values for Panel field above */
-
-#define ACPI_NHLT_MIC_POSITION_TOP          0
-#define ACPI_NHLT_MIC_POSITION_BOTTOM       1
-#define ACPI_NHLT_MIC_POSITION_LEFT         2
-#define ACPI_NHLT_MIC_POSITION_RIGHT        3
-#define ACPI_NHLT_MIC_POSITION_FRONT        4
-#define ACPI_NHLT_MIC_POSITION_BACK         5
-#define ACPI_NHLT_MIC_POSITION_RESERVED     6	/* 6 and above are reserved */
-
-struct acpi_nhlt_vendor_mic_device_specific_config {
-	struct acpi_nhlt_mic_device_specific_config mic_array_device_config;
-	u8 number_of_microphones;
-	struct acpi_nhlt_vendor_mic_config mic_config[];	/* Indexed by number_of_microphones */
-};
-
-/* Microphone SNR and Sensitivity extension */
-
-struct acpi_nhlt_mic_snr_sensitivity_extension {
-	u32 SNR;
-	u32 sensitivity;
-};
-
-/* Render device with feedback */
-
-struct acpi_nhlt_render_feedback_device_specific_config {
-	u8 feedback_virtual_slot;	/* Render slot in case of capture */
-	u16 feedback_channels;	/* Informative only */
-	u16 feedback_valid_bits_per_sample;
-};
-
-/* Non documented structures */
-
-struct acpi_nhlt_device_info_count {
-	u8 structure_count;
-};
-
-struct acpi_nhlt_device_info {
-	u8 device_id[16];
-	u8 device_instance_id;
-	u8 device_port_id;
-};
-
 /*******************************************************************************
  *
  * NHLT - Non HDAudio Link Table
-- 
2.25.1


