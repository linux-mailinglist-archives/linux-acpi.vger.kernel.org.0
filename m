Return-Path: <linux-acpi+bounces-950-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6383C7D6BDB
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 14:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2738B20A72
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 12:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2BE27EC9
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i29CdDs5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EAF273CD
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 11:18:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B28AC;
	Wed, 25 Oct 2023 04:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698232715; x=1729768715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FBsgi0f5RSq42TrQbFfpfnW/pY1sLDlris71usgmqQw=;
  b=i29CdDs5hpEiGQ/o5KOI6Wm9I0jbG2aDGpKTdb/rAf5+GG0afbO6lXg3
   mtAKKFgjCPl3DTXkVA4J+2JvYRZZgRmCFv9GdDq9bmctwbgmLWSt6yq2Q
   pgWQi3Ccr22gRJ1ioXRUuFkXnynSeX/K+hybVdxkjrjh0aFCDwo2KM1c7
   bGTZDzSHx8U1Aq9eWXvmicNCnmVMQzz+6bFpXePI4BaYVAZ1pDg96bYoR
   Mt7Fu3wmCJDdNSQH6q5eSUXZW00oevyJf8bPVKG4elutc7leXjZPOu/JX
   laGefowj6zkSvTEQ01QNzMtZTj/KlfxFaBonTvhGyEPmfjnzJZowfvooc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="391154626"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="391154626"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="762425094"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="762425094"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:20 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rafael.j.wysocki@intel.com,
	andriy.shevchenko@linux.intel.com,
	lenb@kernel.org,
	Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 2/6] ACPI: acpi_video: Use yes_or_no helper instead of ternary operator
Date: Wed, 25 Oct 2023 14:18:02 +0300
Message-ID: <20231025111806.2416524-3-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025111806.2416524-1-michal.wilczynski@intel.com>
References: <20231025111806.2416524-1-michal.wilczynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use string helper, instead of manually computing "yes" or "no" using
ternary operator.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/acpi_video.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index c14b44f99e35..e17474949bbb 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2032,9 +2032,9 @@ static int acpi_video_bus_add(struct acpi_device *device)
 
 	pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
 	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
-	       video->flags.multihead ? "yes" : "no",
-	       video->flags.rom ? "yes" : "no",
-	       video->flags.post ? "yes" : "no");
+	       str_yes_no(video->flags.multihead),
+	       str_yes_no(video->flags.rom),
+	       str_yes_no(video->flags.post));
 	mutex_lock(&video_list_lock);
 	list_add_tail(&video->entry, &video_bus_head);
 	mutex_unlock(&video_list_lock);
-- 
2.41.0


