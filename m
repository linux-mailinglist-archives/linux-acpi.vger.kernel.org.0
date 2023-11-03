Return-Path: <linux-acpi+bounces-1174-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B247E018E
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 11:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A28281DD5
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 10:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53AE1548F
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/sVcho+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892CA6FA3
	for <linux-acpi@vger.kernel.org>; Fri,  3 Nov 2023 08:36:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1B1D42
	for <linux-acpi@vger.kernel.org>; Fri,  3 Nov 2023 01:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699000596; x=1730536596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Z/QjL4c11dFL7cYIx9QB1bsJdnkklZS2hx2d7+OSs4=;
  b=F/sVcho++rZLDvEVtWrlPML9R4jgZHk8X11S39Hu+Cj7x+Pm6WxGgL54
   5ixwHb6EsEHuwTFo9SpT/CK98+ve9XbpaX9QLUAFqjmfeYBydLMQamBVG
   owVih84JRmYI7Zi64ch4PKyznnNUGJ5YSKmLfuvjb0Tyk2vmK2N7EiG9q
   6AX3bXCmc1M7N8Gf/iKcfgam0VyPkf4E7aIsNtm2ND/6Qhg5IzfF4SCg7
   myjNaFuNeizIvtDjr6hkYFrQJoKLj99sQQUiBw2EKp8yPMC13NMGpR+UD
   kcpdOXkEJPni+mM1dJoEZBYYn/URh26Kr+AFM//fQMEKYADQ4finkjpzn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="373943769"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="373943769"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 01:36:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="878574864"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="878574864"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 01:36:31 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 57497120F62;
	Fri,  3 Nov 2023 10:36:28 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v4 2/3] software node: Let args be NULL in software_node_get_reference_args
Date: Fri,  3 Nov 2023 10:36:24 +0200
Message-Id: <20231103083625.1229008-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103083625.1229008-1-sakari.ailus@linux.intel.com>
References: <20231103083625.1229008-1-sakari.ailus@linux.intel.com>
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


