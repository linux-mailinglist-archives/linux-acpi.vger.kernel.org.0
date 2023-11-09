Return-Path: <linux-acpi+bounces-1373-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BAA7E6844
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 11:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620C71C208F5
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 10:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D75199A0
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5wRoCmS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC2E15EB6
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 10:10:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639072D65
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 02:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699524619; x=1731060619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NA/sJdCrLqbFypsfbxjkXbC8FskGu2awhv9fbmjjLzo=;
  b=J5wRoCmSadeiAeaYWU9u4K53BkCBypevKeZnVYRsVS6HRbpwucaDCAHi
   xe6YjKT9nLBQMQIDeVzoPjNBCP/oLuVgzi6diVUy+7lKJcmkIFI+1YlRY
   w0PpJ728x7RPCDO13HJXuvZpo2Jt1T4je5UB36iSeBBq0HMd/U0cYYqEI
   lSYaHl4Q7OcQ+1jqcCw/QSfILOZv4O8aSKG1J4pf7vmYtUQJOnd6npKOO
   o+Ji0U+tVJ4zIqDnDtiqayQsx88Azyz5firHikZ5EAwXUjUCjfVWSMyTg
   TOqvQYp2rLdqJyeLoROqcgyB4+U/h4XdP3rD8KCt0JOTKQSf1tK2gRXsv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="369289673"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="369289673"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 02:10:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="756841700"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="756841700"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 02:10:17 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 2B62B11FC11;
	Thu,  9 Nov 2023 12:10:14 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH v4 1/3] acpi: property: Let args be NULL in __acpi_node_get_property_reference
Date: Thu,  9 Nov 2023 12:10:08 +0200
Message-Id: <20231109101010.1329587-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109101010.1329587-1-sakari.ailus@linux.intel.com>
References: <20231109101010.1329587-1-sakari.ailus@linux.intel.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/property.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 413e4fcadcaf..93608714b652 100644
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
@@ -907,6 +908,9 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 		if (!device)
 			return -EINVAL;
 
+		if (!args)
+			return 0;
+
 		args->fwnode = acpi_fwnode_handle(device);
 		args->nargs = 0;
 		return 0;
-- 
2.39.2


