Return-Path: <linux-acpi+bounces-1140-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB36D7DE0CF
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 13:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955FC280C62
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 12:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDE5125A5
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VT3KSCrT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08A379E6
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 10:51:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB91610C
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 03:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698835869; x=1730371869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bfpydvJ3kBqg+Sjvm3/inasxtr6mpue1JJ1FUNGH1ss=;
  b=VT3KSCrTC2ng3vIGoabQgC01OD7Nj/JG6clmT9q2UOS2f+AXd69BoaUB
   DEhtT/5Q6nJBUlkVZWO2pt8/HLiCD5IYyXHP2+uiCHv2jgfDTLsP74K/s
   8+usBh5UMO23E43mhcgYlwX1gl8Ef48UUDn+7SN3VpSwgVUn0lCLXFiB3
   pY6N+qmIwdnLHkYmTomE1sbsqwmvHQ95jn1AD5+r57j/pvrZ4uX+WVdya
   wMTU5C8mKAf0pDx7JKobBf5IGV3W035BvUP+VrtNnHsVZZpMQgWUcKxpA
   tG9yDQKgZOaJxdLxfr7z5r4IId4Ib4/xDfXTcOkS08L5t0MWPPiNWqRtN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="368682691"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="368682691"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 03:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="760902864"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="760902864"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 03:51:06 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 2B53312098A;
	Wed,  1 Nov 2023 12:51:03 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 1/3] acpi: property: Let args be NULL in __acpi_node_get_property_reference
Date: Wed,  1 Nov 2023 12:51:00 +0200
Message-Id: <20231101105102.1154620-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101105102.1154620-1-sakari.ailus@linux.intel.com>
References: <20231101105102.1154620-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fwnode_get_property_reference() may not be called with args argument NULL
on ACPI, OF already supports this. Add the missing NULL checks and
document this.

The purpose is to be able to count the references.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Fixes: 977d5ad39f3e ("ACPI: Convert ACPI reference args to generic fwnode reference args")
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


