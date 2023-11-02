Return-Path: <linux-acpi+bounces-1151-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369E27DF013
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 11:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643A21C20F08
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 10:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C564D14273
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="To2LZVuW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D7CCA4D
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 10:12:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03398133
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 03:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698919954; x=1730455954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tGQmHILfY7P/U0hixDDVbuxsHPcdqb8ehiyBUAM3IU0=;
  b=To2LZVuWvp7Ep5jTlsFWKT1NXUpcBJ37rTp6J8yGUiS/MWJt/zM0mcJE
   busPZfUF/3EiVNbd7p7NadEcwl4h0Hxw9RZJnYGnnZUv4NXR2+C2qeq/M
   2rVFAd/hbrsD7bN5FmfR9TVm5Jzw0ALEjYKTf6SM970aRgJqaYAf2HA/Z
   s4eEn8TNwbakqnV1/x4dz20daSxBXvPKIA9th7w4LPO7tYtAJ8CHVpxPc
   Kuugo27GqKsntFPECCV+pjozQD/5xxf0QFQQPPCOgdeBDYDTP8vk6PLON
   D16jkBflyeAqWkRciNL5k1MXsrHO+87XOfjUAuLG94K32T9T7JUxZnTyR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1550392"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="1550392"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="737707817"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="737707817"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:12:27 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 78D4912055E;
	Thu,  2 Nov 2023 12:12:24 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 1/3] acpi: property: Let args be NULL in __acpi_node_get_property_reference
Date: Thu,  2 Nov 2023 12:12:20 +0200
Message-Id: <20231102101223.1186166-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231102101223.1186166-1-sakari.ailus@linux.intel.com>
References: <20231102101223.1186166-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fwnode_get_property_reference_args() may not be called with args argument
NULL on ACPI, OF already supports this. Add the missing NULL checks and
document this.

The purpose is to be able to count the references.

Fixes: 977d5ad39f3e ("ACPI: Convert ACPI reference args to generic fwnode reference args")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 413e4fcadcaf..9ff24d9c19f1 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -851,6 +851,7 @@ static int acpi_get_ref_args(struct fwnode_reference_args *args,
  * @index: Index of the reference to return
  * @num_args: Maximum number of arguments after each reference
  * @args: Location to store the returned reference with optional arguments
+ *	  (may be NULL)
  *
  * Find property with @name, verifify that it is a package containing at least
  * one object reference and if so, store the ACPI device object pointer to the
@@ -907,8 +908,10 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 		if (!device)
 			return -EINVAL;
 
-		args->fwnode = acpi_fwnode_handle(device);
-		args->nargs = 0;
+		if (args) {
+			args->fwnode = acpi_fwnode_handle(device);
+			args->nargs = 0;
+		}
 		return 0;
 	case ACPI_TYPE_PACKAGE:
 		/*
-- 
2.39.2


