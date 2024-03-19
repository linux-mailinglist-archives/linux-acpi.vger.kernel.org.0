Return-Path: <linux-acpi+bounces-4374-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2BF87F9C5
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Mar 2024 09:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E1F1F21F69
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Mar 2024 08:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0784A54773;
	Tue, 19 Mar 2024 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfyZs2eb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BF25467C
	for <linux-acpi@vger.kernel.org>; Tue, 19 Mar 2024 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836930; cv=none; b=SKPEFVn3vSIv84xcdi81WvD4dcq85vBKtj32FPvx1iHAG4LPf22Opda8Tg/TY+cL4gIdtqt8uEGca49+DIjrJfe8/ZdlEUj2LztHoQ408yAgflazXzg7tpixTnILirUtOVoxgVd9TblPOfaCDdXAbbz6KGs6Aem/lxtZNPBz2vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836930; c=relaxed/simple;
	bh=wPX8zyMI8mFReS0pUCkHdA51f0xyFzfwutfX/ms3h/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VGoeHTYHWapzdYsfujJ/85LUDVfuUM+AQo8I6RpC81RfOoOcFcXTPB93U32STZt18itITwBo/Hl+r730em0hnNIVkrQXtlAsSScwuXMEpqpMf7tpM2m9WBfOkImlIrGlwUG/udDypYBMICKHFf7OqJhSRKJ7+u6aGPoySPPgAkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfyZs2eb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710836929; x=1742372929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wPX8zyMI8mFReS0pUCkHdA51f0xyFzfwutfX/ms3h/c=;
  b=lfyZs2ebrNK3LL1osQx+XUdU2/5hfzoF9Y7Nv34cgiRaY9RSTs3VN/jF
   tEIegST2P4UU/BKiMfvkyK/3FfkXk127vTZdcRfV2XX4HYAueJNBQnf8X
   x5Qo6NeLoabFbEYZwRE/l+Vfb7A84RyO+Edl/9Em9vN8SQGs2M995Y04Q
   Pr/tAhBmiPtE3Ak1DARD7aWBzBR5WHsZw2jRmW0E70rcxisOdMP5OKBNH
   11m4GkfOtdzWLOzcyEhOODR2SVRkxfzoQ/0hwXb+sfNb2V6AW/Sbf6jX3
   55pIS7dEYM8UMDcWK/Zzm6JETHBgjC1f+3EtN54fVHQx0UxY+b85saiye
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5621343"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5621343"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="44808980"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmviesa001.fm.intel.com with ESMTP; 19 Mar 2024 01:28:46 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	robert.moore@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v8 2/4] ACPI: NHLT: Introduce API for the table
Date: Tue, 19 Mar 2024 09:30:16 +0100
Message-Id: <20240319083018.3159716-3-cezary.rojewski@intel.com>
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

The table is composed of a range of endpoints with each describing
audio formats they support. Most of the operations involve iterating
over elements of the table and filtering them. Simplify the process by
implementing range of getters.

While the acpi_nhlt_endpoint_mic_count() stands out a bit, it is a
critical component for any AudioDSP driver to know how many digital
microphones it is dealing with.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 drivers/acpi/Kconfig  |   3 +
 drivers/acpi/Makefile |   1 +
 drivers/acpi/nhlt.c   | 289 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/nhlt.h   | 181 ++++++++++++++++++++++++++
 4 files changed, 474 insertions(+)
 create mode 100644 drivers/acpi/nhlt.c
 create mode 100644 include/acpi/nhlt.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 3c3f8037ebed..c45a4238c5fd 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -484,6 +484,9 @@ config ACPI_REDUCED_HARDWARE_ONLY
 
 	  If you are unsure what to do, do not enable this option.
 
+config ACPI_NHLT
+	bool
+
 source "drivers/acpi/nfit/Kconfig"
 source "drivers/acpi/numa/Kconfig"
 source "drivers/acpi/apei/Kconfig"
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 12ef8180d272..197e1e7154cb 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_ACPI_THERMAL_LIB)	+= thermal_lib.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
 obj-$(CONFIG_ACPI_PLATFORM_PROFILE) 	+= platform_profile.o
 obj-$(CONFIG_ACPI_NFIT)		+= nfit/
+obj-$(CONFIG_ACPI_NHLT)		+= nhlt.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa/
 obj-$(CONFIG_ACPI)		+= acpi_memhotplug.o
 obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
diff --git a/drivers/acpi/nhlt.c b/drivers/acpi/nhlt.c
new file mode 100644
index 000000000000..ab722a95cbb5
--- /dev/null
+++ b/drivers/acpi/nhlt.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright(c) 2023-2024 Intel Corporation
+ *
+ * Authors: Cezary Rojewski <cezary.rojewski@intel.com>
+ *          Amadeusz Slawinski <amadeuszx.slawinski@linux.intel.com>
+ */
+
+#define pr_fmt(fmt) "ACPI: NHLT: " fmt
+
+#include <linux/acpi.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/minmax.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+#include <acpi/nhlt.h>
+
+static struct acpi_table_nhlt2 *acpi_gbl_nhlt;
+
+static struct acpi_table_nhlt2 empty_nhlt = {
+	.header = {
+		.signature = ACPI_SIG_NHLT,
+	},
+};
+
+/**
+ * acpi_nhlt_get_gbl_table - Retrieve a pointer to the first NHLT table.
+ *
+ * If there is no NHLT in the system, acpi_gbl_nhlt will instead point to an
+ * empty table.
+ *
+ * Return: ACPI status code of the operation.
+ */
+acpi_status acpi_nhlt_get_gbl_table(void)
+{
+	acpi_status status;
+
+	status = acpi_get_table(ACPI_SIG_NHLT, 0, (struct acpi_table_header **)(&acpi_gbl_nhlt));
+	if (!acpi_gbl_nhlt)
+		acpi_gbl_nhlt = &empty_nhlt;
+	return status;
+}
+EXPORT_SYMBOL_GPL(acpi_nhlt_get_gbl_table);
+
+/**
+ * acpi_nhlt_put_gbl_table - Release the global NHLT table.
+ */
+void acpi_nhlt_put_gbl_table(void)
+{
+	acpi_put_table((struct acpi_table_header *)acpi_gbl_nhlt);
+}
+EXPORT_SYMBOL_GPL(acpi_nhlt_put_gbl_table);
+
+/**
+ * acpi_nhlt_endpoint_match - Verify if an endpoint matches criteria.
+ * @ep:			the endpoint to check.
+ * @link_type:		the hardware link type, e.g.: PDM or SSP.
+ * @dev_type:		the device type.
+ * @dir:		stream direction.
+ * @bus_id:		the ID of virtual bus hosting the endpoint.
+ *
+ * Either of @link_type, @dev_type, @dir or @bus_id may be set to a negative
+ * value to ignore the parameter when matching.
+ *
+ * Return: %true if endpoint matches specified criteria or %false otherwise.
+ */
+bool acpi_nhlt_endpoint_match(const struct acpi_nhlt2_endpoint *ep,
+			      int link_type, int dev_type, int dir, int bus_id)
+{
+	return ep &&
+	       (link_type < 0 || ep->link_type == link_type) &&
+	       (dev_type < 0 || ep->device_type == dev_type) &&
+	       (bus_id < 0 || ep->virtual_bus_id == bus_id) &&
+	       (dir < 0 || ep->direction == dir);
+}
+EXPORT_SYMBOL_GPL(acpi_nhlt_endpoint_match);
+
+/**
+ * acpi_nhlt_tb_find_endpoint - Search a NHLT table for an endpoint.
+ * @tb:			the table to search.
+ * @link_type:		the hardware link type, e.g.: PDM or SSP.
+ * @dev_type:		the device type.
+ * @dir:		stream direction.
+ * @bus_id:		the ID of virtual bus hosting the endpoint.
+ *
+ * Either of @link_type, @dev_type, @dir or @bus_id may be set to a negative
+ * value to ignore the parameter during the search.
+ *
+ * Return: A pointer to endpoint matching the criteria, %NULL if not found or
+ * an ERR_PTR() otherwise.
+ */
+struct acpi_nhlt2_endpoint *
+acpi_nhlt_tb_find_endpoint(const struct acpi_table_nhlt2 *tb,
+			   int link_type, int dev_type, int dir, int bus_id)
+{
+	struct acpi_nhlt2_endpoint *ep;
+
+	for_each_nhlt_endpoint(tb, ep)
+		if (acpi_nhlt_endpoint_match(ep, link_type, dev_type, dir, bus_id))
+			return ep;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(acpi_nhlt_tb_find_endpoint);
+
+/**
+ * acpi_nhlt_find_endpoint - Search all NHLT tables for an endpoint.
+ * @link_type:		the hardware link type, e.g.: PDM or SSP.
+ * @dev_type:		the device type.
+ * @dir:		stream direction.
+ * @bus_id:		the ID of virtual bus hosting the endpoint.
+ *
+ * Either of @link_type, @dev_type, @dir or @bus_id may be set to a negative
+ * value to ignore the parameter during the search.
+ *
+ * Return: A pointer to endpoint matching the criteria, %NULL if not found or
+ * an ERR_PTR() otherwise.
+ */
+struct acpi_nhlt2_endpoint *
+acpi_nhlt_find_endpoint(int link_type, int dev_type, int dir, int bus_id)
+{
+	/* TODO: Currently limited to table of index 0. */
+	return acpi_nhlt_tb_find_endpoint(acpi_gbl_nhlt, link_type, dev_type, dir, bus_id);
+}
+EXPORT_SYMBOL_GPL(acpi_nhlt_find_endpoint);
+
+/**
+ * acpi_nhlt_endpoint_find_fmtcfg - Search endpoint's formats configuration space
+ *                                  for a specific format.
+ * @ep:			the endpoint to search.
+ * @ch:			number of channels.
+ * @rate:		samples per second.
+ * @vbps:		valid bits per sample.
+ * @bps:		bits per sample.
+ *
+ * Return: A pointer to format matching the criteria, %NULL if not found or
+ * an ERR_PTR() otherwise.
+ */
+struct acpi_nhlt2_format_config *
+acpi_nhlt_endpoint_find_fmtcfg(const struct acpi_nhlt2_endpoint *ep,
+			       u16 ch, u32 rate, u16 vbps, u16 bps)
+{
+	struct acpi_nhlt2_wave_formatext *wav;
+	struct acpi_nhlt2_format_config *fmt;
+
+	for_each_nhlt_endpoint_fmtcfg(ep, fmt) {
+		wav = &fmt->format;
+
+		if (wav->valid_bits_per_sample == vbps &&
+		    wav->samples_per_sec == rate &&
+		    wav->bits_per_sample == bps &&
+		    wav->channel_count == ch)
+			return fmt;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(acpi_nhlt_endpoint_find_fmtcfg);
+
+/**
+ * acpi_nhlt_tb_find_fmtcfg - Search a NHLT table for a specific format.
+ * @tb:			the table to search.
+ * @link_type:		the hardware link type, e.g.: PDM or SSP.
+ * @dev_type:		the device type.
+ * @dir:		stream direction.
+ * @bus_id:		the ID of virtual bus hosting the endpoint.
+ *
+ * @ch:			number of channels.
+ * @rate:		samples per second.
+ * @vbps:		valid bits per sample.
+ * @bps:		bits per sample.
+ *
+ * Either of @link_type, @dev_type, @dir or @bus_id may be set to a negative
+ * value to ignore the parameter during the search.
+ *
+ * Return: A pointer to format matching the criteria, %NULL if not found or
+ * an ERR_PTR() otherwise.
+ */
+struct acpi_nhlt2_format_config *
+acpi_nhlt_tb_find_fmtcfg(const struct acpi_table_nhlt2 *tb,
+			 int link_type, int dev_type, int dir, int bus_id,
+			 u16 ch, u32 rate, u16 vbps, u16 bps)
+{
+	struct acpi_nhlt2_format_config *fmt;
+	struct acpi_nhlt2_endpoint *ep;
+
+	for_each_nhlt_endpoint(tb, ep) {
+		if (!acpi_nhlt_endpoint_match(ep, link_type, dev_type, dir, bus_id))
+			continue;
+
+		fmt = acpi_nhlt_endpoint_find_fmtcfg(ep, ch, rate, vbps, bps);
+		if (fmt)
+			return fmt;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(acpi_nhlt_tb_find_fmtcfg);
+
+/**
+ * acpi_nhlt_find_fmtcfg - Search all NHLT tables for a specific format.
+ * @link_type:		the hardware link type, e.g.: PDM or SSP.
+ * @dev_type:		the device type.
+ * @dir:		stream direction.
+ * @bus_id:		the ID of virtual bus hosting the endpoint.
+ *
+ * @ch:			number of channels.
+ * @rate:		samples per second.
+ * @vbps:		valid bits per sample.
+ * @bps:		bits per sample.
+ *
+ * Either of @link_type, @dev_type, @dir or @bus_id may be set to a negative
+ * value to ignore the parameter during the search.
+ *
+ * Return: A pointer to format matching the criteria, %NULL if not found or
+ * an ERR_PTR() otherwise.
+ */
+struct acpi_nhlt2_format_config *
+acpi_nhlt_find_fmtcfg(int link_type, int dev_type, int dir, int bus_id,
+		      u16 ch, u32 rate, u16 vbps, u16 bps)
+{
+	/* TODO: Currently limited to table of index 0. */
+	return acpi_nhlt_tb_find_fmtcfg(acpi_gbl_nhlt, link_type, dev_type, dir, bus_id,
+					ch, rate, vbps, bps);
+}
+EXPORT_SYMBOL_GPL(acpi_nhlt_find_fmtcfg);
+
+static bool acpi_nhlt_config_is_micdevice(struct acpi_nhlt_config *cfg)
+{
+	return cfg->capabilities_size >= sizeof(struct acpi_nhlt_micdevice_config);
+}
+
+static bool acpi_nhlt_config_is_vendor_micdevice(struct acpi_nhlt_config *cfg)
+{
+	struct acpi_nhlt_vendor_micdevice_config *devcfg = __acpi_nhlt_config_caps(cfg);
+
+	return cfg->capabilities_size >= sizeof(*devcfg) &&
+	       cfg->capabilities_size == struct_size(devcfg, mics, devcfg->mics_count);
+}
+
+/**
+ * acpi_nhlt_endpoint_mic_count - Retrieve number of digital microphones for a PDM endpoint.
+ * @ep:			the endpoint to return microphones count for.
+ *
+ * Return: A number of microphones or an error code if an invalid endpoint is provided.
+ */
+int acpi_nhlt_endpoint_mic_count(const struct acpi_nhlt2_endpoint *ep)
+{
+	union acpi_nhlt_device_config *devcfg;
+	struct acpi_nhlt2_format_config *fmt;
+	struct acpi_nhlt_config *cfg;
+	u16 max_ch = 0;
+
+	if (!ep || ep->link_type != ACPI_NHLT_LINKTYPE_PDM)
+		return -EINVAL;
+
+	/* Find max number of channels based on formats configuration. */
+	for_each_nhlt_endpoint_fmtcfg(ep, fmt)
+		max_ch = max(fmt->format.channel_count, max_ch);
+
+	cfg = __acpi_nhlt_endpoint_config(ep);
+	devcfg = __acpi_nhlt_config_caps(cfg);
+
+	/* If @ep is not a mic array, fallback to channels count. */
+	if (!acpi_nhlt_config_is_micdevice(cfg) ||
+	    devcfg->gen.config_type != ACPI_NHLT_CONFIGTYPE_MICARRAY)
+		return max_ch;
+
+	switch (devcfg->mic.array_type) {
+	case ACPI_NHLT_ARRAYTYPE_LINEAR2_SMALL:
+	case ACPI_NHLT_ARRAYTYPE_LINEAR2_BIG:
+		return 2;
+
+	case ACPI_NHLT_ARRAYTYPE_LINEAR4_GEO1:
+	case ACPI_NHLT_ARRAYTYPE_PLANAR4_LSHAPED:
+	case ACPI_NHLT_ARRAYTYPE_LINEAR4_GEO2:
+		return 4;
+
+	case ACPI_NHLT_ARRAYTYPE_VENDOR:
+		if (!acpi_nhlt_config_is_vendor_micdevice(cfg))
+			return -EINVAL;
+		return devcfg->vendor_mic.mics_count;
+
+	default:
+		pr_warn("undefined mic array type: %#x\n", devcfg->mic.array_type);
+		return max_ch;
+	}
+}
+EXPORT_SYMBOL_GPL(acpi_nhlt_endpoint_mic_count);
diff --git a/include/acpi/nhlt.h b/include/acpi/nhlt.h
new file mode 100644
index 000000000000..7c394e7bc2bb
--- /dev/null
+++ b/include/acpi/nhlt.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright(c) 2023-2024 Intel Corporation
+ *
+ * Authors: Cezary Rojewski <cezary.rojewski@intel.com>
+ *          Amadeusz Slawinski <amadeuszx.slawinski@linux.intel.com>
+ */
+
+#ifndef __ACPI_NHLT_H__
+#define __ACPI_NHLT_H__
+
+#include <linux/acpi.h>
+#include <linux/kconfig.h>
+#include <linux/overflow.h>
+#include <linux/types.h>
+
+#define __acpi_nhlt_endpoint_config(ep)		((void *)((ep) + 1))
+#define __acpi_nhlt_config_caps(cfg)		((void *)((cfg) + 1))
+
+/**
+ * acpi_nhlt_endpoint_fmtscfg - Get the formats configuration space.
+ * @ep:		the endpoint to retrieve the space for.
+ *
+ * Return: A pointer to the formats configuration space.
+ */
+static inline struct acpi_nhlt2_formats_config *
+acpi_nhlt_endpoint_fmtscfg(const struct acpi_nhlt2_endpoint *ep)
+{
+	struct acpi_nhlt_config *cfg = __acpi_nhlt_endpoint_config(ep);
+
+	return (struct acpi_nhlt2_formats_config *)((u8 *)(cfg + 1) + cfg->capabilities_size);
+}
+
+#define __acpi_nhlt_first_endpoint(tb) \
+	((void *)(tb + 1))
+
+#define __acpi_nhlt_next_endpoint(ep) \
+	((void *)((u8 *)(ep) + (ep)->length))
+
+#define __acpi_nhlt_get_endpoint(tb, ep, i) \
+	((i) ? __acpi_nhlt_next_endpoint(ep) : __acpi_nhlt_first_endpoint(tb))
+
+#define __acpi_nhlt_first_fmtcfg(fmts) \
+	((void *)(fmts + 1))
+
+#define __acpi_nhlt_next_fmtcfg(fmt) \
+	((void *)((u8 *)((fmt) + 1) + (fmt)->config.capabilities_size))
+
+#define __acpi_nhlt_get_fmtcfg(fmts, fmt, i) \
+	((i) ? __acpi_nhlt_next_fmtcfg(fmt) : __acpi_nhlt_first_fmtcfg(fmts))
+
+/*
+ * The for_each_nhlt_*() macros rely on an iterator to deal with the
+ * variable length of each endpoint structure and the possible presence
+ * of an OED-Config used by Windows only.
+ */
+
+/**
+ * for_each_nhlt_endpoint - Iterate over endpoints in a NHLT table.
+ * @tb:		the pointer to a NHLT table.
+ * @ep:		the pointer to endpoint to use as loop cursor.
+ */
+#define for_each_nhlt_endpoint(tb, ep)					\
+	for (unsigned int __i = 0;					\
+	     __i < (tb)->endpoints_count &&				\
+		(ep = __acpi_nhlt_get_endpoint(tb, ep, __i));		\
+	     __i++)
+
+/**
+ * for_each_nhlt_fmtcfg - Iterate over format configurations.
+ * @fmts:	the pointer to formats configuration space.
+ * @fmt:	the pointer to format to use as loop cursor.
+ */
+#define for_each_nhlt_fmtcfg(fmts, fmt)					\
+	for (unsigned int __i = 0;					\
+	     __i < (fmts)->formats_count &&				\
+		(fmt = __acpi_nhlt_get_fmtcfg(fmts, fmt, __i));	\
+	     __i++)
+
+/**
+ * for_each_nhlt_endpoint_fmtcfg - Iterate over format configurations in an endpoint.
+ * @ep:		the pointer to an endpoint.
+ * @fmt:	the pointer to format to use as loop cursor.
+ */
+#define for_each_nhlt_endpoint_fmtcfg(ep, fmt) \
+	for_each_nhlt_fmtcfg(acpi_nhlt_endpoint_fmtscfg(ep), fmt)
+
+#if IS_ENABLED(CONFIG_ACPI_NHLT)
+
+/*
+ * System-wide pointer to the first NHLT table.
+ *
+ * A sound driver may utilize acpi_nhlt_get/put_gbl_table() on its
+ * initialization and removal respectively to avoid excessive mapping
+ * and unmapping of the memory occupied by the table between streaming
+ * operations.
+ */
+
+acpi_status acpi_nhlt_get_gbl_table(void);
+void acpi_nhlt_put_gbl_table(void);
+
+bool acpi_nhlt_endpoint_match(const struct acpi_nhlt2_endpoint *ep,
+			      int link_type, int dev_type, int dir, int bus_id);
+struct acpi_nhlt2_endpoint *
+acpi_nhlt_tb_find_endpoint(const struct acpi_table_nhlt2 *tb,
+			   int link_type, int dev_type, int dir, int bus_id);
+struct acpi_nhlt2_endpoint *
+acpi_nhlt_find_endpoint(int link_type, int dev_type, int dir, int bus_id);
+struct acpi_nhlt2_format_config *
+acpi_nhlt_endpoint_find_fmtcfg(const struct acpi_nhlt2_endpoint *ep,
+			       u16 ch, u32 rate, u16 vbps, u16 bps);
+struct acpi_nhlt2_format_config *
+acpi_nhlt_tb_find_fmtcfg(const struct acpi_table_nhlt2 *tb,
+			 int link_type, int dev_type, int dir, int bus_id,
+			 u16 ch, u32 rate, u16 vpbs, u16 bps);
+struct acpi_nhlt2_format_config *
+acpi_nhlt_find_fmtcfg(int link_type, int dev_type, int dir, int bus_id,
+		      u16 ch, u32 rate, u16 vpbs, u16 bps);
+int acpi_nhlt_endpoint_mic_count(const struct acpi_nhlt2_endpoint *ep);
+
+#else /* !CONFIG_ACPI_NHLT */
+
+static inline acpi_status acpi_nhlt_get_gbl_table(void)
+{
+	return AE_NOT_FOUND;
+}
+
+static inline void acpi_nhlt_put_gbl_table(void)
+{
+}
+
+static inline bool
+acpi_nhlt_endpoint_match(const struct acpi_nhlt2_endpoint *ep,
+			 int link_type, int dev_type, int dir, int bus_id)
+{
+	return false;
+}
+
+static inline struct acpi_nhlt2_endpoint *
+acpi_nhlt_tb_find_endpoint(const struct acpi_table_nhlt2 *tb,
+			   int link_type, int dev_type, int dir, int bus_id)
+{
+	return NULL;
+}
+
+static inline struct acpi_nhlt2_format_config *
+acpi_nhlt_endpoint_find_fmtcfg(const struct acpi_nhlt2_endpoint *ep,
+			       u16 ch, u32 rate, u16 vbps, u16 bps)
+{
+	return NULL;
+}
+
+static inline struct acpi_nhlt2_format_config *
+acpi_nhlt_tb_find_fmtcfg(const struct acpi_table_nhlt2 *tb,
+			 int link_type, int dev_type, int dir, int bus_id,
+			 u16 ch, u32 rate, u16 vpbs, u16 bps)
+{
+	return NULL;
+}
+
+static inline int acpi_nhlt_endpoint_mic_count(const struct acpi_nhlt2_endpoint *ep)
+{
+	return 0;
+}
+
+static inline struct acpi_nhlt2_endpoint *
+acpi_nhlt_find_endpoint(int link_type, int dev_type, int dir, int bus_id)
+{
+	return NULL;
+}
+
+static inline struct acpi_nhlt2_format_config *
+acpi_nhlt_find_fmtcfg(int link_type, int dev_type, int dir, int bus_id,
+		      u16 ch, u32 rate, u16 vpbs, u16 bps)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_ACPI_NHLT */
+
+#endif /* __ACPI_NHLT_H__ */
-- 
2.25.1


