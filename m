Return-Path: <linux-acpi+bounces-3396-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F6C851054
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 11:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A310282D18
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A5517BBE;
	Mon, 12 Feb 2024 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSPLXa82"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB2517BA1
	for <linux-acpi@vger.kernel.org>; Mon, 12 Feb 2024 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732520; cv=none; b=JTpx8WbSn3U5lgUGiz0bkD6giA5a86VJcr1H509jodvvvEj3wCONyeNNEWGqu+n5DWO7/G7axXeT6p2q3E5zQqBtE28m2dSOrB43lfsp0SDR0P05STixcoju+TlYlIZszgnsPFnvsZP1RdWDwFXBTVoJnIX1j18iZ9fLY7C5qY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732520; c=relaxed/simple;
	bh=lhJp13aKccQVnVMitYg8BP4PHIHmRaUxm0qo0/2x0IA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B4e/LuOL2cs/EWPlmj2HyuBwwSsq7lSXZOGLlTdqQQZe74CbJuiLAjuLlCmbsK1LN/s09t52Q6KlID9NKYEL3EHBrmqMwt2lkR1GpbuTfbquwtz8CJlprqrbYpB6PJIpmJc2S84ac/SjykgH2nFvSdLSp5iKDYG5F/PSleJD+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cSPLXa82; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707732519; x=1739268519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lhJp13aKccQVnVMitYg8BP4PHIHmRaUxm0qo0/2x0IA=;
  b=cSPLXa823TIyb+QxWiC3cDrsZ5vbi1HzyTJCbVIuukaNDOnrdBiAiqPl
   Bru6xNKOo2v0yVtUYhL8t2VodsWvKlbmFx4fJZt7wBMUoKNLugnwNFEtx
   1bfeBf71eAtKQ/kqUMubJ90mt2BBbxTTpb26cqKyIIaKqpyu+nGnFKJvV
   FfGgO4SCUIAWcvbpUy4WnPTOhMjq3sjhd91Bbrbx9J5IzsWf77zk50T4s
   xzBdwzyTXJuq6ksTGG6aBv0IRDfneP4fvUULj0D36wcwVuHIUUbOjnOfw
   wGDS13Hbd33NwQQfWa+60ab9vcA+NwgEMrai3mNVUI7QJeLM49s/JQ3Q5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1828606"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="1828606"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:08:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="33617876"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:08:36 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 992B911F9DB;
	Mon, 12 Feb 2024 12:00:33 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH 1/2] ACPI: utils: Make acpi_handle_path() not static
Date: Mon, 12 Feb 2024 12:00:31 +0200
Message-Id: <20240212100032.346422-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212100032.346422-1-sakari.ailus@linux.intel.com>
References: <20240212100032.346422-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_handle_path() will soon be required for node name comparison
elsewhere in ACPI framework. Remove the static keyword and add the
prototype to include/linux/acpi.h.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/utils.c | 2 +-
 include/linux/acpi.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index abac5cc25477..202234ba54bd 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -559,7 +559,7 @@ EXPORT_SYMBOL(acpi_evaluate_ost);
  *
  * Caller must free the returned buffer
  */
-static char *acpi_handle_path(acpi_handle handle)
+char *acpi_handle_path(acpi_handle handle)
 {
 	struct acpi_buffer buffer = {
 		.length = ACPI_ALLOCATE_BUFFER,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b7165e52b3c6..a170c389dd74 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1170,6 +1170,7 @@ static inline void acpi_ec_set_gpe_wake_mask(u8 action) {}
 #endif
 
 #ifdef CONFIG_ACPI
+char *acpi_handle_path(acpi_handle handle);
 __printf(3, 4)
 void acpi_handle_printk(const char *level, acpi_handle handle,
 			const char *fmt, ...);
-- 
2.39.2


