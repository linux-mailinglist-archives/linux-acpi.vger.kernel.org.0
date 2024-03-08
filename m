Return-Path: <linux-acpi+bounces-4180-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD646875E92
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 08:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE2D1C21C2A
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 07:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87574EB5E;
	Fri,  8 Mar 2024 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFbDhDmx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F024B4F1F1
	for <linux-acpi@vger.kernel.org>; Fri,  8 Mar 2024 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883064; cv=none; b=WEiSY/xNBeUa7+f/qcT2KxeH+HArUK4UJ9I6Su6lTRaTGZCZu9BBMyOiScCuH0+Eg+HccXeGT8Cu/3o+ZE9ZCDoJ1Rnt4lfRdYDdbTtHqTj1tue3vg6s/Rax9mx6A5N2qVwGurn6P/TLoooBDeN6lYoEjPPK33Y0eWML4VfzS9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883064; c=relaxed/simple;
	bh=Yfe44Kqt5IDGq3RMBQa9JBfISJMKTePyxG/LjwDdPKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U00vf3Qk7NDrWOZ4sCYGut4iHiI5B5VwlXwMtULc4rNWVy4SIgK9RlGAVYiJy0gySD/IF2akf8gfaaK4sHZtMISy5W30tRNrpBZs25QfL2JPYK7aS2DVXCD5emV2VzqB7MFc1KCXYL4O7R8hRvFjZVyJiH1EyEUJnGVbFHAv/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFbDhDmx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709883063; x=1741419063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yfe44Kqt5IDGq3RMBQa9JBfISJMKTePyxG/LjwDdPKQ=;
  b=DFbDhDmxtn6GiPxZjyhsyUXOqZNo371RQSpZ2MOry3bw9RJinHJnXtU4
   Ln/bu+PnduWNxMAEedcBRiCE3/pIHP4JQ5wGYc/nlGBkL+PGUcqosZYA8
   7NrXfpbUH960R+/hCsI8p1N0f+rUkra7jeFCyRzolnGb6vQT00fAV1gxe
   3xF6f8nmveSxwhYa1GSGo7I1NRPtj2sO80zTEL96H5+Pke6WrlQWpH1/o
   RsJ4yyKFhxWe5MlTsx6tQbBrRdxoLl9llBHUiia5hzpydZd6QY7Bt4FKd
   ULiBe3vGDmAE7HyOkjVgJ0Zl/mG5Jhd7pPJljhGrZNt4PgwN5tjcL32lN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4771726"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="4771726"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 23:31:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="10472234"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmviesa008.fm.intel.com with ESMTP; 07 Mar 2024 23:31:00 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	robert.moore@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v6 4/4] ACPI: NHLT: Streamline struct naming
Date: Fri,  8 Mar 2024 08:32:40 +0100
Message-Id: <20240308073240.2047932-5-cezary.rojewski@intel.com>
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


