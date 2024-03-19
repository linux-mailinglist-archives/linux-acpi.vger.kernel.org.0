Return-Path: <linux-acpi+bounces-4376-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0D587F9C8
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Mar 2024 09:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FCFE1F2186B
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Mar 2024 08:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BD454775;
	Tue, 19 Mar 2024 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvNmmM9O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5495854665
	for <linux-acpi@vger.kernel.org>; Tue, 19 Mar 2024 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836935; cv=none; b=VUdO2gX87GFfCk8+JUjRWojk7CghmssZDcFxRRWT9ehdV/Nf6II77eDLEbMiZAYEk2SQs/30Cm99bOAC4tc2yy1ufBswGJf89TtWKVXI+5AIrsLUg7BtjeJgucwb8iUV1yvMignN6d7LaUyibPW/0cjKNw276Mk684xf3xzqUE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836935; c=relaxed/simple;
	bh=TkLvHIIp7tSz9HKWPW8vknaMTYj6iqn+ASIY6II0ijU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fexccVRNmGpAukNDKFRFuKnLIU20DgxDL4snVo8Z+ri5ZzLlRtYyNIFKEcFjSr3KpKzQxd7VlVZhZIudvIJ+8lA6jpR2kwBFvpjvvVlKGaODbtyJrSgrSDz5O937/4n29H0fksAb9DR1BXI501dd/HWRBU0EPmZiV+iVXLiJGxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvNmmM9O; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710836934; x=1742372934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TkLvHIIp7tSz9HKWPW8vknaMTYj6iqn+ASIY6II0ijU=;
  b=WvNmmM9O15hQMkBpiWrNpUNIzSbJM9UWF6LwZ7Rk//ziOfHaUIdgxBxu
   +4vwIWB3q3uHtMVq51e+ggPkhWNJzH4yj24w2BqMVrZ7hn+w771aBcmhq
   m5FK/tJupR+dfbRJRLXErkASvCHVUf6fXWMKAmt9IwsiaHt0uB/9FN2h3
   gatpq/D3HcUvZAcfxpYCUoJxM+O7IDEbM1dGNSEkd4CPIy4FtLlmbUyW6
   XZgLzrYoTnyPsJAZNiNU0KYLou5AovTvxjHn4rtqFB/wXDbpbbbnbvUed
   0ULuAvYK/u78y61pxex746K3XxEkoOaX+JCUeg4fqcrhJl/wbCo0iMw49
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5621348"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5621348"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="44809084"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmviesa001.fm.intel.com with ESMTP; 19 Mar 2024 01:28:51 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	robert.moore@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v8 4/4] ACPI: NHLT: Streamline struct naming
Date: Tue, 19 Mar 2024 09:30:18 +0100
Message-Id: <20240319083018.3159716-5-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240319083018.3159716-1-cezary.rojewski@intel.com>
References: <20240319083018.3159716-1-cezary.rojewski@intel.com>
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
index ab722a95cbb5..dc1bd0df9228 100644
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
index 7c394e7bc2bb..2108aa6d0207 100644
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


