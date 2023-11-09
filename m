Return-Path: <linux-acpi+bounces-1374-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 683B57E6846
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 11:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04639B20B14
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 10:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A4519475
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROHxM4Eo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D3E16418
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 10:10:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5AB2D78
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 02:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699524620; x=1731060620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IHpMNOCrEKGmJCvVxepQRrs3+NvigcRXWywvKZ/CPns=;
  b=ROHxM4EoPUoC+TZYhA3UZqixhL4oABD+IkemZj6LzoAEd/JFcxUQBbQe
   hIOjVI1QFgRUpeWOWruDABDoxthFaf5IWWRRfWRNhhd8il1fj6biAipHI
   9B0atq84WwbJDBWXn603qlOi5gYA+4LNc1GPZjFiZsB7Tp4YAIe5hrb3z
   3iP1yyDFD1RQfrcGCCHC5V13PtNVRMey3YeQKkP3+tbkkx6m9OOkogf/w
   aV5zbykTtWhajUGQsx1v3mc8kd4EGh8eDZDSEJzXf9sxM9qJUm5ZzfmEI
   mbCrdwHSUXdx0ccvoDaao+qHNyfZX4Qkkj/5KR8ePk1/hLlH3yOE/ianZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="369289678"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="369289678"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 02:10:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="756841703"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="756841703"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 02:10:18 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 285C511FC2C;
	Thu,  9 Nov 2023 12:10:15 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH v4 2/3] software node: Let args be NULL in software_node_get_reference_args
Date: Thu,  9 Nov 2023 12:10:09 +0200
Message-Id: <20231109101010.1329587-3-sakari.ailus@linux.intel.com>
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
NULL and while OF already supports this. Add the missing NULL check.

The purpose is to be able to count the references.

Fixes: b06184acf751 ("software node: Add software_node_get_reference_args()")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
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


