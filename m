Return-Path: <linux-acpi+bounces-1155-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 903837DF01B
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 11:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDFF281117
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 10:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C887B14A87
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+nckL6N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3A12B87
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 10:13:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4E8128
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 03:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698920005; x=1730456005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tGQmHILfY7P/U0hixDDVbuxsHPcdqb8ehiyBUAM3IU0=;
  b=m+nckL6NxwSMacGAk6lZrN9R7UOeoMt49cjkicgbBFaPW6CR6QVnzOfy
   6w9EHy0w92kz/O+VyBSNiDccsGiTjeYNEbOSwhkW7L7/TOEVN5QEYtfth
   ItsC4Iejb6+OEkxTJd74tvohB3zUX3592aR9Px6stb6/ktlnLtYMNP2o0
   5k4HnwID3k4ZUw1gM9QLCsTcmiEjQeP5kSWPkzfDSJhcKOPXR4jblVISS
   vMjSdW533hLwblK1qqZvuW+oJYBjR2DbnxIlQv5v3Bmal8WxaQFjJ8WA0
   EVZyvK2pinEsKV6D06oReuDpCl84viYkSRBahy5O3LnF6mM0/Khjx6+E3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="7318637"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="7318637"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="904969780"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="904969780"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:13:21 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 43D2412055E;
	Thu,  2 Nov 2023 12:13:18 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 1/3] acpi: property: Let args be NULL in __acpi_node_get_property_reference
Date: Thu,  2 Nov 2023 12:13:14 +0200
Message-Id: <20231102101316.1186215-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231102101316.1186215-1-sakari.ailus@linux.intel.com>
References: <20231102101316.1186215-1-sakari.ailus@linux.intel.com>
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


