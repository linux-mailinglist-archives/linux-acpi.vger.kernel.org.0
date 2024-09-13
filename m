Return-Path: <linux-acpi+bounces-8278-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01093977E2B
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 13:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EC63B25DA8
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 11:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7091D7997;
	Fri, 13 Sep 2024 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5LvGTxz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868A11B983D;
	Fri, 13 Sep 2024 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726225533; cv=none; b=mwZOPAJPDD0iYxBqSrX8UrJQJeqFIVhBZOe5p56Jwwv1nfPNG7akSvY7OiN5mvodcMGKknWHE5WT9Ea+g80zdmzU+7oQaEkllc/uNXOTNlHJoiyD986ZQfmGZSD4FX3WkKvHSbwMMndbqs5qZH3DurZstVIGpUC4MpCKxidRubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726225533; c=relaxed/simple;
	bh=ewzilHymwJkVYJD/EBs/SQy+YwQAnMiz205hV0F9T1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KtHWkUCEmLnXOvkOImeDyLu3x3j8ay7/+LReQpMq+liBVmAK3UD/yVsidHUEEn//x9dbH1i0zMbhunlUnk7jI6HD78/F39EMsnQwn2iSTBUB1bIbB8zNGwVUDAAO38+2CmgABNUoQ2VyQzR7TWXOwKk+kUMPphZLVNNpmwx8ZEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5LvGTxz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726225531; x=1757761531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ewzilHymwJkVYJD/EBs/SQy+YwQAnMiz205hV0F9T1M=;
  b=I5LvGTxzva756Vv+tNQe2+gozIF/VZwT1CimGPld+4GAoLHrSnaFhkr7
   Prv6dNzZVisqchAW4PGwftHw6zCvaO+qzy0glLBVZ06uaNs54JMWOr7DJ
   gUgxm5FTQCwtndG5XwAbFATMJ3PpHOxYxSj4DohojO6dMvBiezsoHoNzC
   7pLwdBnwsPs9iz2ExGmK8YcMQ7h3BIsccJpqp5cu1dVq+xrdMW1+Xc/KO
   5aUlrTfYxhUom8DdHpFPbPP9YFIqohNRgCe4rswL0c1Wqwr6i1wLN7JMJ
   ObTp5wLcJRHatvaE6qEcof4CabVWWRc5pwHI8Ua/9MDERDujFQkb6PgRu
   A==;
X-CSE-ConnectionGUID: vYChR0jrRN+UAeBU1WWX8g==
X-CSE-MsgGUID: tQqqWM/cSXu0d2VV+A5v2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="35787433"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="35787433"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 04:05:30 -0700
X-CSE-ConnectionGUID: +KILJ2epSlevX+/Je2ukLQ==
X-CSE-MsgGUID: D22jCgLxQ2G/j+Z14qWaEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="72384256"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 13 Sep 2024 04:05:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6E4F9387; Fri, 13 Sep 2024 14:05:27 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/1] software node: Simplify swnode_register() a bit
Date: Fri, 13 Sep 2024 14:05:23 +0300
Message-ID: <20240913110523.3584749-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By introducing two temporary variables simplify swnode_register() a bit.
No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/swnode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index b0be765b12da..810c27a8c9c1 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -908,6 +908,7 @@ static struct fwnode_handle *
 swnode_register(const struct software_node *node, struct swnode *parent,
 		unsigned int allocated)
 {
+	struct kobject *kobj_parent = parent ? &parent->kobj : NULL;
 	struct swnode *swnode;
 	int ret;
 
@@ -934,12 +935,10 @@ swnode_register(const struct software_node *node, struct swnode *parent,
 
 	if (node->name)
 		ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
-					   parent ? &parent->kobj : NULL,
-					   "%s", node->name);
+					   kobj_parent, "%s", node->name);
 	else
 		ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
-					   parent ? &parent->kobj : NULL,
-					   "node%d", swnode->id);
+					   kobj_parent, "node%d", swnode->id);
 	if (ret) {
 		kobject_put(&swnode->kobj);
 		return ERR_PTR(ret);
-- 
2.43.0.rc1.1336.g36b5255a03ac


