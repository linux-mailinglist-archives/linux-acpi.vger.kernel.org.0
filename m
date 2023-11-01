Return-Path: <linux-acpi+bounces-1130-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAE27DDF6F
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 11:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253702804E1
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15E111C8E
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/yHxh8j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE20746B
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 09:07:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277DFF1
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 02:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698829668; x=1730365668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FlKHw1b9YO7rIlDQQa3rbDIiZQ6oaFI4czBtQ8o7KMA=;
  b=l/yHxh8juRFZsijKuc3kDPVUOjCr2kV1d2VYxbFJKB/QhPjlpW8GFS95
   NY/rT6Cyx3CzgFjK0yO/UQHteTTuReGMeKoY4Tfd05k1M6nO1fTSjBJHo
   ID3GCmSoD4Y8vErfsqzD8ULfGkTJzVP+3nw0YXR8coZKla65pTeyRNiAN
   8riqyiYRSJY1UXqgWXC6pE1uazgaku4psMcwILOdhLblMyIwf1droorWJ
   aKtRLClIhbe6KJq7eedZ0w0GgqpusL2CeiMmAnl6CXOvaVW+qDfEvg+8u
   8YxHbLOwRSVN3OrOBHUiZb1KwZETMvzaL/HfGTQjr6+EVo2NcqOhuYUT6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="1314624"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="1314624"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:07:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="1008052031"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="1008052031"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:07:42 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 7EF9A1207DA;
	Wed,  1 Nov 2023 11:07:39 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/3] software node: Let args be NULL in software_node_get_reference_args
Date: Wed,  1 Nov 2023 11:07:36 +0200
Message-Id: <20231101090737.1148303-3-sakari.ailus@linux.intel.com>
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
and while OF already supports this. Add the missing NULL check.

The purpose is to be able to count the references.

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


