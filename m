Return-Path: <linux-acpi+bounces-1648-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0FB7F2789
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 09:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5271B20E5D
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 08:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CA83B29C
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViOdeK6w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C69790;
	Mon, 20 Nov 2023 23:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700550513; x=1732086513;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j1YTYr5QMSSnYnwbqsWG2+lRzMcgqrlEjIafePktic4=;
  b=ViOdeK6wLhqEp/vX2pe3UP+iZhZYRq1A0Ke1HlPcwKDsNzQMMDOdahXP
   49UqcwakGzI7f0J1xx5L1vodxEYdXYszkl76xbP7d/yueaJ9OaCBMSxSX
   dUDSEjzlZZB69IH5EkFx3Y3X4o4SH0CXXTidhS7l5Og9K8+QXfX1qOpvo
   yx6WBy8hrNnGkseZLmTVmO9B9PprzxckWoIYoLXapNh5lMVgerpj5oRiH
   gTCNPWGjGtyzgMV5iPAZvcYLtpg08wyaej17viNd8nsIL3lwr7LuGfgyy
   3YJHbnDnGVdc0PKZp+SobyUc2NljDwV/pSJfHgFIZoqfE8ycgZ3unvvXO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="376817041"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="376817041"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 23:08:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884097545"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="884097545"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 23:08:31 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id C9EE611FC2D;
	Tue, 21 Nov 2023 09:08:27 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH 1/1] ACPI: scan: Fix an error print in DisCo for Imaging support
Date: Tue, 21 Nov 2023 09:08:26 +0200
Message-Id: <20231121070826.1637628-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recently merged DisCo for Imaging support used a wrong printk
specifier in printing a message. Fix it by using %zu instead of %lu.
Also use "bits" instead of "bytes" as these are indeed bytes.

Fixes: a6cb0a611273 ("ACPI: scan: Extract MIPI DisCo for Imaging data into swnodes")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/mipi-disco-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
index cad72d1fc127..7286cf4579bc 100644
--- a/drivers/acpi/mipi-disco-img.c
+++ b/drivers/acpi/mipi-disco-img.c
@@ -533,7 +533,7 @@ static void init_csi2_port(struct acpi_device *adev,
 	if (ret < 0) {
 		acpi_handle_debug(handle, "Lane polarity bytes missing\n");
 	} else if (ret * BITS_PER_TYPE(u8) < num_lanes + 1) {
-		acpi_handle_info(handle, "Too few lane polarity bytes (%lu vs. %d)\n",
+		acpi_handle_info(handle, "Too few lane polarity bits (%zu vs. %d)\n",
 				 ret * BITS_PER_TYPE(u8), num_lanes + 1);
 	} else {
 		unsigned long mask = 0;
-- 
2.39.2


