Return-Path: <linux-acpi+bounces-4089-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45B18706AD
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 17:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8290B26A7C
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 16:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A161D482FF;
	Mon,  4 Mar 2024 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LdfP4w8K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD09495E5
	for <linux-acpi@vger.kernel.org>; Mon,  4 Mar 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568729; cv=none; b=jPYEhxOstb+bnIudM59vypLy9u4x88aTgFrw1+ke8UnciDMa3HyIHzI585kqjAMk1owwpu/54e16od/Gt2nyD0YlnpLro1v8zhgduErCjf2gid9I8OujrBd8GlgKYmaEAh1NzMLu1cVqG+6JsYjK7SwNMPzWxH6MH7kX0Y2/VlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568729; c=relaxed/simple;
	bh=Xwsi7WfNEhXe1srcOUmH+30pHbq9BnTBnmqjEdsYXT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LiTmU1EtTtQuD9SL9VwAKSQHEMFRU6FJm846AFGATYInQNY0r7YcP8jhx8Hcq0Ea3BdGRmQHZohCgLd0l+OIW8KGhU6xgnWg/4OvOHg0A9jSceGU4I6sUGuy4UruLGJtzF481flhnPCtJSZUlXSTQxaoaxABeJNp4QImaz0hrI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LdfP4w8K; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709568728; x=1741104728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xwsi7WfNEhXe1srcOUmH+30pHbq9BnTBnmqjEdsYXT8=;
  b=LdfP4w8K6zKSNlp+ST+TyEvLIWtfbFa+rBhdUHGcZDg1p/2/8qkX64ws
   9Mlq321w1TrcASCsfd/Fwx5t3ZdUBVWaGIHOaKt6+FeSl+8KW0SN3/A5J
   zkkbjtu/SPMOLW6gRrAoA9OrclUik8UJeS+BBNuJVkHEd+x2pF4xQd/9Z
   w7+2pPKIS4OmSeNGHYER8FL2kA7H3nIgaesjoy58f1/1btsSyJ1CjBFoO
   HML3exOecODnM9DjGNUKpIgkmhvJ1Skz7FPmjfOdBxpLzEzO0JZM69BF2
   4oQAqMyjZ5iVBzBPsNR38Y1wTXR4PVNApkBfz9kLeA5EyKY6wAHCG1KAm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="14646527"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="14646527"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 08:12:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8967423"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmviesa009.fm.intel.com with ESMTP; 04 Mar 2024 08:12:04 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	robert.moore@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v5 4/4] ACPI: NHLT: Streamline struct naming
Date: Mon,  4 Mar 2024 17:13:35 +0100
Message-Id: <20240304161335.1734134-5-cezary.rojewski@intel.com>
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
index 4a0e39ca89e9..b161444a6c3a 100644
--- a/drivers/acpi/nhlt.c
+++ b/drivers/acpi/nhlt.c
@@ -11,9 +11,9 @@
 #include <linux/export.h>
 #include <acpi/nhlt.h>
 
-static struct acpi_table_nhlt2 *acpi_gbl_nhlt;
+static struct acpi_table_nhlt *acpi_gbl_nhlt;
 
-static struct acpi_table_nhlt2 empty_nhlt = {
+static struct acpi_table_nhlt empty_nhlt = {
 	.header = {
 		.signature = ACPI_SIG_NHLT,
 	},
@@ -60,7 +60,7 @@ EXPORT_SYMBOL_GPL(acpi_nhlt_put_gbl_table);
  *
  * Return: %true if endpoint matches specified criteria or %false otherwise.
  */
-bool acpi_nhlt_endpoint_match(const struct acpi_nhlt2_endpoint *ep,
+bool acpi_nhlt_endpoint_match(const struct acpi_nhlt_endpoint *ep,
 			      int link_type, int dev_type, int dir, int bus_id)
 {
 	return ep &&
@@ -85,11 +85,11 @@ EXPORT_SYMBOL_GPL(acpi_nhlt_endpoint_match);
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
@@ -111,7 +111,7 @@ EXPORT_SYMBOL_GPL(acpi_nhlt_tb_find_endpoint);
  * Return: A pointer to endpoint matching the criteria, %NULL if not found or
  * an ERR_PTR() otherwise.
  */
-struct acpi_nhlt2_endpoint *
+struct acpi_nhlt_endpoint *
 acpi_nhlt_find_endpoint(int link_type, int dev_type, int dir, int bus_id)
 {
 	/* TODO: Currently limited to table of index 0. */
@@ -131,12 +131,12 @@ EXPORT_SYMBOL_GPL(acpi_nhlt_find_endpoint);
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
@@ -171,13 +171,13 @@ EXPORT_SYMBOL_GPL(acpi_nhlt_endpoint_find_fmtcfg);
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
@@ -210,7 +210,7 @@ EXPORT_SYMBOL_GPL(acpi_nhlt_tb_find_fmtcfg);
  * Return: A pointer to format matching the criteria, %NULL if not found or
  * an ERR_PTR() otherwise.
  */
-struct acpi_nhlt2_format_config *
+struct acpi_nhlt_format_config *
 acpi_nhlt_find_fmtcfg(int link_type, int dev_type, int dir, int bus_id,
 		      u16 ch, u32 rate, u16 vbps, u16 bps)
 {
@@ -239,10 +239,10 @@ static bool acpi_nhlt_config_is_vendor_micdevice(struct acpi_nhlt_config *cfg)
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
index 9ff89c8a8d95..7ce740c70ad8 100644
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
@@ -1983,7 +1983,7 @@ struct acpi_nhlt_micdevice_config {
 #define ACPI_NHLT_ARRAYTYPE_LINEAR4_GEO2	0xE
 #define ACPI_NHLT_ARRAYTYPE_VENDOR		0xF
 
-struct acpi_nhlt2_vendor_mic_config {
+struct acpi_nhlt_vendor_mic_config {
 	u8 type;
 	u8 panel;
 	u16 speaker_position_distance;		/* mm */
@@ -2024,7 +2024,7 @@ struct acpi_nhlt_vendor_micdevice_config {
 	u8 config_type;
 	u8 array_type;
 	u8 mics_count;
-	struct acpi_nhlt2_vendor_mic_config mics[];
+	struct acpi_nhlt_vendor_mic_config mics[];
 };
 
 union acpi_nhlt_device_config {
@@ -2035,7 +2035,7 @@ union acpi_nhlt_device_config {
 };
 
 /* Inherited from Microsoft's WAVEFORMATEXTENSIBLE. */
-struct acpi_nhlt2_wave_formatext {
+struct acpi_nhlt_wave_formatext {
 	u16 format_tag;
 	u16 channel_count;
 	u32 samples_per_sec;
@@ -2048,17 +2048,17 @@ struct acpi_nhlt2_wave_formatext {
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
@@ -2066,7 +2066,7 @@ struct acpi_nhlt2_device_info {
 
 struct acpi_nhlt_devices_info {
 	u8 devices_count;
-	struct acpi_nhlt2_device_info devices[];
+	struct acpi_nhlt_device_info devices[];
 };
 
 /*******************************************************************************
diff --git a/include/acpi/nhlt.h b/include/acpi/nhlt.h
index 02c764e599fe..90cb09cd0bce 100644
--- a/include/acpi/nhlt.h
+++ b/include/acpi/nhlt.h
@@ -22,12 +22,12 @@
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
@@ -98,24 +98,24 @@ acpi_nhlt_endpoint_fmtscfg(const struct acpi_nhlt2_endpoint *ep)
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
 
@@ -129,46 +129,46 @@ static inline void acpi_nhlt_put_gbl_table(void)
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


