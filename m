Return-Path: <linux-acpi+bounces-3451-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAF3853230
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Feb 2024 14:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D8E1F231E5
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Feb 2024 13:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6324F5646C;
	Tue, 13 Feb 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkktxk/J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CEC56466
	for <linux-acpi@vger.kernel.org>; Tue, 13 Feb 2024 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831975; cv=none; b=bPlyuYpK09i6SjMtKKZ9JkMYWUWlS3LhkPhtVet0YY2HDYZ9sMloMf51vpJqM1HDPH/j9dVnD42lM2mnUtikvxo+FzF012C+a7OVLIZ6Lj7fNTwW/P0Tla0ND7CbfpzChIEFMKCXOb5rX7UFBwFwqa0oZrKC7/0I6nbGoZkDmhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831975; c=relaxed/simple;
	bh=lhJp13aKccQVnVMitYg8BP4PHIHmRaUxm0qo0/2x0IA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y4fTGGZQ7DpLBRWFvNsq996Xr5cscvZd4kKIaL0L+jlA25TpOPS+q2U15guWtmuasU7lVUvW/RByAfPzFGrQ2YBBraxN/Kp4/y0lLcx1+Qkg558fST+bfwJatgGxhQiPJcrxx2jOYSosvlzqujg0HgRvT09vqj1bq5VR3i9CMyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkktxk/J; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707831974; x=1739367974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lhJp13aKccQVnVMitYg8BP4PHIHmRaUxm0qo0/2x0IA=;
  b=dkktxk/JnBMxF1oTKCiy4zcsdkbVwUY1q0WHXH2UzQWalxF1BE4JmkLS
   rWH+Q6d4/vjHcLVdWwwKWqf4NnpyNW4Qiixrrm+/0v7BYuxci1ZqFKji8
   sT3OzWfumuHvJEiuOXtWcpANkd2OWHyZNzrSwyQeaXVK/R53VPnno6vYz
   b7ntaTmw1nOSaaD1dW4zASI9ypa7YBkaFqqhJfV9KmfQo+jP4x57inym7
   boVaYsImptclPDRvpprVtrhsQwFfx8MKgdGKeq3ZWh+XqE532hx8vGECs
   m7PUiTbh/Mwf4gLuzThLgiwhE9zdWNy/q9EAbHJJMK3RBVExWuJ+HekxY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1743673"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1743673"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 05:46:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="3207228"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 05:46:11 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 74C0C11F871;
	Tue, 13 Feb 2024 15:46:07 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v2 1/2] ACPI: utils: Make acpi_handle_path() not static
Date: Tue, 13 Feb 2024 15:46:05 +0200
Message-Id: <20240213134606.383817-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213134606.383817-1-sakari.ailus@linux.intel.com>
References: <20240213134606.383817-1-sakari.ailus@linux.intel.com>
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


