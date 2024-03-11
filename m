Return-Path: <linux-acpi+bounces-4244-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A8E877DE8
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 11:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23EDB207DF
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D27224D7;
	Mon, 11 Mar 2024 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XwksFKoe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A83B22064
	for <linux-acpi@vger.kernel.org>; Mon, 11 Mar 2024 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710152124; cv=none; b=puoq5BRmNiIJbSnVRWCdITv79LLIDXmT/qGeqThbAKByDFgeCzCSaqxGyjMAmSe8Z4+hTox7cmcXMDrbevTAYk4TmG+HKf8mG7ijOR1hwWNYlFADF4E3fKLL0HzfUVkDqrWo0Hgl73QpflVgs+bRhqgcEyjFLIWOy5X5+nOOkb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710152124; c=relaxed/simple;
	bh=p135Q4Q3addbiz2SLDzjUZC0X+81uVq29BmYG4rOTh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UZrvEiyuT80Jx6d6Vh166GQAZ8HV3MnW2YAJKV0QE2HMvbCqDTWiKWiyYm/10h96jVgevleVYFfD/cgFvNuWMnpUkiBr6tBTKjX6xay+cyfWR2DjPQmhpKAo6vIlU0gBfutsyP/aKEmZdB2p50RV/mPGM7Fb+loaEqkS9DeIeUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XwksFKoe; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710152122; x=1741688122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p135Q4Q3addbiz2SLDzjUZC0X+81uVq29BmYG4rOTh8=;
  b=XwksFKoeeyzDAKVNYLqVcUxLENqOOzQk3wgq3ybZdT1Ll6XNJ97SD4vu
   jqL1mVGeBv3UfLP3VuWK4Cb+H+49E4IWNgv+oknoFaYQakLo+mky10lja
   hp2edxl17NfPyZaiGYQeP0t3MphHCff5hQIeaMaIUJwkV81eOdmKQHFlR
   apN7trKoOTTC2L0OLh/ue76A9gCNxoLhx1cAqy0JhehYKYHZUMmI3sOHn
   6UowHzbsSm9mksnrqpYBWKvC9/EM3biTij5YXW0tHe9O95C9muSSCyYq9
   d2zWvFtOPv4w/hHRy/Lo8rmHwGuDDPZSofWcVjAte9F1TgFtO/G8krCOa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15535340"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15535340"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 03:15:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11689073"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by orviesa008.jf.intel.com with ESMTP; 11 Mar 2024 03:15:19 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	robert.moore@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v7 4/4] ACPI: NHLT: Streamline struct naming
Date: Mon, 11 Mar 2024 11:16:58 +0100
Message-Id: <20240311101658.2343816-5-cezary.rojewski@intel.com>
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

Few recently introduced structs are named 'nhlt2' instead of 'nhlt' to
avoid naming conflicts. With duplicate types gone, the conflicts are no
more.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 drivers/acpi/nhlt.c   | 36 ++++++++++++++++-----------------
 include/acpi/actbl2.h | 22 ++++++++++-----------
 include/acpi/nhlt.h   | 46 +++++++++++++++++++++----------------------
 3 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/acpi/nhlt.c b/drivers/acpi/nhlt.c
index 599dce778334..b75c780951e0 100644
--- a/drivers/acpi/nhlt.c
+++ b/drivers/acpi/nhlt.c
@@ -16,9 +16,9 @@
 #include <linux/types.h>
 #include <acpi/nhlt.h>
 
-static struct acpi_table_nhlt2 *acpi_gbl_nhlt;
+static struct acpi_table_nhlt *acpi_gbl_nhlt;
 
-static struct acpi_table_nhlt2 empty_nhlt = {
+static struct acpi_table_nhlt empty_nhlt = {
 	.header = {
 		.signature = ACPI_SIG_NHLT,
 	},
@@ -65,7 +65,7 @@ EXPORT_SYMBOL_GPL(acpi_nhlt_put_gbl_table);
  *
  * Return: %true if endpoint matches specified criteria or %false otherwise.
  */
-bool acpi_nhlt_endpoint_match(const struct acpi_nhlt2_endpoint *ep,
+bool acpi_nhlt_endpoint_match(const struct acpi_nhlt_endpoint *ep,
 			      int link_type, int dev_type, int dir, int bus_id)
 {
 	return ep &&
@@ -90,11 +90,11 @@ EXPORT_SYMBOL_GPL(acpi_nhlt_endpoint_match);
  * Return: A pointer to endpoint matching the criteria, %NULL if not found or
  * an ERR_PTR() otherwise.
  */
-struct acpi_nhlt2_endpoint *
-acpi_nhlt_tb_find_endpoint(const struct acpi_table_nhlt2 *tb,
+struct acpi_nhlt_endpoint *
+acpi_nhlt_tb_find_endpoint(const struct acpi_table_nhlt *tb,
 			   int link_type, int dev_type, int dir, int bus_id)
 {
-	struct acpi_nhlt2_endpoint *ep;
+	struct acpi_nhlt_endpoint *ep;
 
 	for_each_nhlt_endpoint(tb, ep)
 		if (acpi_nhlt_endpoint_match(ep, link_type, dev_type, dir, bus_id))
@@ -116,7 +116,7 @@ EXPORT_SYMBOL_GPL(acpi_nhlt_tb_find_endpoint);
  * Return: A pointer to endpoint matching the criteria, %NULL if not found or
  * an ERR_PTR() otherwise.
  */
-struct acpi_nhlt2_endpoint *
+struct acpi_nhlt_endpoint *
 acpi_nhlt_find_endpoint(int link_type, int dev_type, int dir, int bus_id)
 {
 	/* TODO: Currently limited to table of index 0. */
@@ -136,12 +136,12 @@ EXPORT_SYMBOL_GPL(acpi_nhlt_find_endpoint);
  * Return: A pointer to format matching the criteria, %NULL if not found or
  * an ERR_PTR() otherwise.
  */
-struct acpi_nhlt2_format_config *
-acpi_nhlt_endpoint_find_fmtcfg(const struct acpi_nhlt2_endpoint *ep,
+struct acpi_nhlt_format_config *
+acpi_nhlt_endpoint_find_fmtcfg(const struct acpi_nhlt_endpoint *ep,
 			       u16 ch, u32 rate, u16 vbps, u16 bps)
 {
-	struct acpi_nhlt2_wave_formatext *wav;
-	struct acpi_nhlt2_format_config *fmt;
+	struct acpi_nhlt_wave_formatext *wav;
+	struct acpi_nhlt_format_config *fmt;
 
 	for_each_nhlt_endpoint_fmtcfg(ep, fmt) {
 		wav = &fmt->format;
@@ -176,13 +176,13 @@ EXPORT_SYMBOL_GPL(acpi_nhlt_endpoint_find_fmtcfg);
  * Return: A pointer to format matching the criteria, %NULL if not found or
  * an ERR_PTR() otherwise.
  */
-struct acpi_nhlt2_format_config *
-acpi_nhlt_tb_find_fmtcfg(const struct acpi_table_nhlt2 *tb,
+struct acpi_nhlt_format_config *
+acpi_nhlt_tb_find_fmtcfg(const struct acpi_table_nhlt *tb,
 			 int link_type, int dev_type, int dir, int bus_id,
 			 u16 ch, u32 rate, u16 vbps, u16 bps)
 {
-	struct acpi_nhlt2_format_config *fmt;
-	struct acpi_nhlt2_endpoint *ep;
+	struct acpi_nhlt_format_config *fmt;
+	struct acpi_nhlt_endpoint *ep;
 
 	for_each_nhlt_endpoint(tb, ep) {
 		if (!acpi_nhlt_endpoint_match(ep, link_type, dev_type, dir, bus_id))
@@ -215,7 +215,7 @@ EXPORT_SYMBOL_GPL(acpi_nhlt_tb_find_fmtcfg);
  * Return: A pointer to format matching the criteria, %NULL if not found or
  * an ERR_PTR() otherwise.
  */
-struct acpi_nhlt2_format_config *
+struct acpi_nhlt_format_config *
 acpi_nhlt_find_fmtcfg(int link_type, int dev_type, int dir, int bus_id,
 		      u16 ch, u32 rate, u16 vbps, u16 bps)
 {
@@ -244,10 +244,10 @@ static bool acpi_nhlt_config_is_vendor_micdevice(struct acpi_nhlt_config *cfg)
  *
  * Return: A number of microphones or an error code if an invalid endpoint is provided.
  */
-int acpi_nhlt_endpoint_mic_count(const struct acpi_nhlt2_endpoint *ep)
+int acpi_nhlt_endpoint_mic_count(const struct acpi_nhlt_endpoint *ep)
 {
 	union acpi_nhlt_device_config *devcfg;
-	struct acpi_nhlt2_format_config *fmt;
+	struct acpi_nhlt_format_config *fmt;
 	struct acpi_nhlt_config *cfg;
 	u16 max_ch = 0;
 
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 31a716a74340..f237269bd1cb 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1894,7 +1894,7 @@ struct nfit_device_handle {
  *
  ******************************************************************************/
 
-struct acpi_table_nhlt2 {
+struct acpi_table_nhlt {
 	struct acpi_table_header header;	/* Common ACPI table header */
 	u8 endpoints_count;
 	/*
@@ -1903,7 +1903,7 @@ struct acpi_table_nhlt2 {
 	 */
 };
 
-struct acpi_nhlt2_endpoint {
+struct acpi_nhlt_endpoint {
 	u32 length;
 	u8 link_type;
 	u8 instance_id;
@@ -1990,7 +1990,7 @@ struct acpi_nhlt_micdevice_config {
 #define ACPI_NHLT_ARRAYTYPE_LINEAR4_GEO2	0xE
 #define ACPI_NHLT_ARRAYTYPE_VENDOR		0xF
 
-struct acpi_nhlt2_vendor_mic_config {
+struct acpi_nhlt_vendor_mic_config {
 	u8 type;
 	u8 panel;
 	u16 speaker_position_distance;		/* mm */
@@ -2031,7 +2031,7 @@ struct acpi_nhlt_vendor_micdevice_config {
 	u8 config_type;
 	u8 array_type;
 	u8 mics_count;
-	struct acpi_nhlt2_vendor_mic_config mics[];
+	struct acpi_nhlt_vendor_mic_config mics[];
 };
 
 union acpi_nhlt_device_config {
@@ -2042,7 +2042,7 @@ union acpi_nhlt_device_config {
 };
 
 /* Inherited from Microsoft's WAVEFORMATEXTENSIBLE. */
-struct acpi_nhlt2_wave_formatext {
+struct acpi_nhlt_wave_formatext {
 	u16 format_tag;
 	u16 channel_count;
 	u32 samples_per_sec;
@@ -2055,17 +2055,17 @@ struct acpi_nhlt2_wave_formatext {
 	u8 subformat[16];
 };
 
-struct acpi_nhlt2_format_config {
-	struct acpi_nhlt2_wave_formatext format;
+struct acpi_nhlt_format_config {
+	struct acpi_nhlt_wave_formatext format;
 	struct acpi_nhlt_config config;
 };
 
-struct acpi_nhlt2_formats_config {
+struct acpi_nhlt_formats_config {
 	u8 formats_count;
-	struct acpi_nhlt2_format_config formats[];
+	struct acpi_nhlt_format_config formats[];
 };
 
-struct acpi_nhlt2_device_info {
+struct acpi_nhlt_device_info {
 	u8 id[16];
 	u8 instance_id;
 	u8 port_id;
@@ -2073,7 +2073,7 @@ struct acpi_nhlt2_device_info {
 
 struct acpi_nhlt_devices_info {
 	u8 devices_count;
-	struct acpi_nhlt2_device_info devices[];
+	struct acpi_nhlt_device_info devices[];
 };
 
 /*******************************************************************************
diff --git a/include/acpi/nhlt.h b/include/acpi/nhlt.h
index bd66c15e7336..3d6e8a5ef693 100644
--- a/include/acpi/nhlt.h
+++ b/include/acpi/nhlt.h
@@ -23,12 +23,12 @@
  *
  * Return: A pointer to the formats configuration space.
  */
-static inline struct acpi_nhlt2_formats_config *
-acpi_nhlt_endpoint_fmtscfg(const struct acpi_nhlt2_endpoint *ep)
+static inline struct acpi_nhlt_formats_config *
+acpi_nhlt_endpoint_fmtscfg(const struct acpi_nhlt_endpoint *ep)
 {
 	struct acpi_nhlt_config *cfg = __acpi_nhlt_endpoint_config(ep);
 
-	return (struct acpi_nhlt2_formats_config *)((u8 *)(cfg + 1) + cfg->capabilities_size);
+	return (struct acpi_nhlt_formats_config *)((u8 *)(cfg + 1) + cfg->capabilities_size);
 }
 
 #define __acpi_nhlt_first_endpoint(tb) \
@@ -99,24 +99,24 @@ acpi_nhlt_endpoint_fmtscfg(const struct acpi_nhlt2_endpoint *ep)
 acpi_status acpi_nhlt_get_gbl_table(void);
 void acpi_nhlt_put_gbl_table(void);
 
-bool acpi_nhlt_endpoint_match(const struct acpi_nhlt2_endpoint *ep,
+bool acpi_nhlt_endpoint_match(const struct acpi_nhlt_endpoint *ep,
 			      int link_type, int dev_type, int dir, int bus_id);
-struct acpi_nhlt2_endpoint *
-acpi_nhlt_tb_find_endpoint(const struct acpi_table_nhlt2 *tb,
+struct acpi_nhlt_endpoint *
+acpi_nhlt_tb_find_endpoint(const struct acpi_table_nhlt *tb,
 			   int link_type, int dev_type, int dir, int bus_id);
-struct acpi_nhlt2_endpoint *
+struct acpi_nhlt_endpoint *
 acpi_nhlt_find_endpoint(int link_type, int dev_type, int dir, int bus_id);
-struct acpi_nhlt2_format_config *
-acpi_nhlt_endpoint_find_fmtcfg(const struct acpi_nhlt2_endpoint *ep,
+struct acpi_nhlt_format_config *
+acpi_nhlt_endpoint_find_fmtcfg(const struct acpi_nhlt_endpoint *ep,
 			       u16 ch, u32 rate, u16 vbps, u16 bps);
-struct acpi_nhlt2_format_config *
-acpi_nhlt_tb_find_fmtcfg(const struct acpi_table_nhlt2 *tb,
+struct acpi_nhlt_format_config *
+acpi_nhlt_tb_find_fmtcfg(const struct acpi_table_nhlt *tb,
 			 int link_type, int dev_type, int dir, int bus_id,
 			 u16 ch, u32 rate, u16 vpbs, u16 bps);
-struct acpi_nhlt2_format_config *
+struct acpi_nhlt_format_config *
 acpi_nhlt_find_fmtcfg(int link_type, int dev_type, int dir, int bus_id,
 		      u16 ch, u32 rate, u16 vpbs, u16 bps);
-int acpi_nhlt_endpoint_mic_count(const struct acpi_nhlt2_endpoint *ep);
+int acpi_nhlt_endpoint_mic_count(const struct acpi_nhlt_endpoint *ep);
 
 #else /* !CONFIG_ACPI_NHLT */
 
@@ -130,46 +130,46 @@ static inline void acpi_nhlt_put_gbl_table(void)
 }
 
 static inline bool
-acpi_nhlt_endpoint_match(const struct acpi_nhlt2_endpoint *ep,
+acpi_nhlt_endpoint_match(const struct acpi_nhlt_endpoint *ep,
 			 int link_type, int dev_type, int dir, int bus_id)
 {
 	return false;
 }
 
-static inline struct acpi_nhlt2_endpoint *
-acpi_nhlt_tb_find_endpoint(const struct acpi_table_nhlt2 *tb,
+static inline struct acpi_nhlt_endpoint *
+acpi_nhlt_tb_find_endpoint(const struct acpi_table_nhlt *tb,
 			   int link_type, int dev_type, int dir, int bus_id)
 {
 	return NULL;
 }
 
-static inline struct acpi_nhlt2_format_config *
-acpi_nhlt_endpoint_find_fmtcfg(const struct acpi_nhlt2_endpoint *ep,
+static inline struct acpi_nhlt_format_config *
+acpi_nhlt_endpoint_find_fmtcfg(const struct acpi_nhlt_endpoint *ep,
 			       u16 ch, u32 rate, u16 vbps, u16 bps)
 {
 	return NULL;
 }
 
-static inline struct acpi_nhlt2_format_config *
-acpi_nhlt_tb_find_fmtcfg(const struct acpi_table_nhlt2 *tb,
+static inline struct acpi_nhlt_format_config *
+acpi_nhlt_tb_find_fmtcfg(const struct acpi_table_nhlt *tb,
 			 int link_type, int dev_type, int dir, int bus_id,
 			 u16 ch, u32 rate, u16 vpbs, u16 bps)
 {
 	return NULL;
 }
 
-static inline int acpi_nhlt_endpoint_mic_count(const struct acpi_nhlt2_endpoint *ep)
+static inline int acpi_nhlt_endpoint_mic_count(const struct acpi_nhlt_endpoint *ep)
 {
 	return 0;
 }
 
-static inline struct acpi_nhlt2_endpoint *
+static inline struct acpi_nhlt_endpoint *
 acpi_nhlt_find_endpoint(int link_type, int dev_type, int dir, int bus_id)
 {
 	return NULL;
 }
 
-static inline struct acpi_nhlt2_format_config *
+static inline struct acpi_nhlt_format_config *
 acpi_nhlt_find_fmtcfg(int link_type, int dev_type, int dir, int bus_id,
 		      u16 ch, u32 rate, u16 vpbs, u16 bps)
 {
-- 
2.25.1


