Return-Path: <linux-acpi+bounces-1128-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28FC7DDF6C
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 11:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4E31C20B9D
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D5C10A22
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dpj9CZNK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311646FDD
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 09:07:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93EF107
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 02:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698829665; x=1730365665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/vdIfbhMH/CuJP3bMUq8UwkevHnXHvj/UDmgJ39rw50=;
  b=Dpj9CZNKvoExE9/B8lOa3x/nce+rpysXdOFrblZUVeMkb3a8Wy4Xdpw1
   oTqJo4IBhWvfzVtcq7mCCjA+Pf68Wk4oKTAVe3oU21KNtXzS7iWTTHita
   GQRp+J3n9tKz6higK57vAOnqRNBYUTFZvfHU+WGh7+y4VZoATfW0KzAoO
   VISMJFzIevto+VYV+dWMk6p8VqSndr/7RxlaOUYbBPkdrFJsgnEuJeokm
   ZFyphAp4JR6NpTnFMRWbZnrGXzf6XXSmCAXt+u8rDRU8Wctt/nza2orhs
   Yg/YDGv1vrdKuaFdoXSToF28U9c6JG5g2/GtivEEtK7woepWW7RBIE3zG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="1314619"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="1314619"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:07:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="1008052030"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="1008052030"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:07:41 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id CAFB311F9E8;
	Wed,  1 Nov 2023 11:07:38 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/3] acpi: property: Let args be NULL in __acpi_node_get_property_reference
Date: Wed,  1 Nov 2023 11:07:35 +0200
Message-Id: <20231101090737.1148303-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101090737.1148303-1-sakari.ailus@linux.intel.com>
References: <20231101090737.1148303-1-sakari.ailus@linux.intel.com>
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
---
 drivers/acpi/property.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index d60ee0510311..fa473fc2617b 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -879,7 +879,8 @@ static struct fwnode_handle *acpi_parse_string_ref(const struct fwnode_handle *f
  * @propname: Name of the property
  * @index: Index of the reference to return
  * @num_args: Maximum number of arguments after each reference
- * @args: Location to store the returned reference with optional arguments
+ * @args: Location to store the returned reference with optional arguments (may
+ *	  be NULL)
  *
  * Find property with @name, verifify that it is a package containing at least
  * one object reference and if so, store the ACPI device object pointer to the
@@ -937,8 +938,10 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 		if (!device)
 			return -EINVAL;
 
-		args->fwnode = acpi_fwnode_handle(device);
-		args->nargs = 0;
+		if (args) {
+			args->fwnode = acpi_fwnode_handle(device);
+			args->nargs = 0;
+		}
 
 		return 0;
 	case ACPI_TYPE_STRING:
@@ -949,8 +952,10 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 		if (!ref_fwnode)
 			return -EINVAL;
 
-		args->fwnode = ref_fwnode;
-		args->nargs = 0;
+		if (args) {
+			args->fwnode = ref_fwnode;
+			args->nargs = 0;
+		}
 
 		return 0;
 	case ACPI_TYPE_PACKAGE:
-- 
2.39.2


