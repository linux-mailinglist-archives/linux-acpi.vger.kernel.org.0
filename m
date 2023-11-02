Return-Path: <linux-acpi+bounces-1153-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A615B7DF018
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 11:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B391C20F40
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42985168C9
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzwFOI2l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB8B12B8C
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 10:13:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D5B131
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 03:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698920008; x=1730456008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Z/QjL4c11dFL7cYIx9QB1bsJdnkklZS2hx2d7+OSs4=;
  b=PzwFOI2l1n3dVMArQxH+IsH0LgiTCGl/TpJ2R84L/gTPiuxk7Iz05p01
   3LA2tKzbFuiadY0yN1oGG6zfuVSZM1UVKi9vBL0ghRzMWFhtxKvlMAZSd
   sQj8h2iB8ROZJzUuCKz/10gpvcsHFhLFY7vimmVtX1vVx5y5EAl47l7YJ
   WtU6CwqB8j4OPb8m+25sA/Qu4+2ixfjtzWlTq2n0/T9QbOkWehmyr7v8W
   tMe8W8uczPMX5ssbILPhEykWV3RuI5hGmsZpNGFOuv0zrvVobNk9Jb+PT
   CEIGrGdr54I75llOtLtZktAhEGn5XcIsVEoEbQJDkMAsTsD5CpbsgHQmz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="7318643"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="7318643"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:13:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="904969781"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="904969781"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:13:22 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 466DE120819;
	Thu,  2 Nov 2023 12:13:19 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 2/3] software node: Let args be NULL in software_node_get_reference_args
Date: Thu,  2 Nov 2023 12:13:15 +0200
Message-Id: <20231102101316.1186215-3-sakari.ailus@linux.intel.com>
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
NULL and while OF already supports this. Add the missing NULL check.

The purpose is to be able to count the references.

Fixes: b06184acf751 ("software node: Add software_node_get_reference_args()")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/swnode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 1886995a0b3a..079bd14bdedc 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -541,6 +541,9 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	if (nargs > NR_FWNODE_REFERENCE_ARGS)
 		return -EINVAL;
 
+	if (!args)
+		return 0;
+
 	args->fwnode = software_node_get(refnode);
 	args->nargs = nargs;
 
-- 
2.39.2


