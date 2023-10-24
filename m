Return-Path: <linux-acpi+bounces-865-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCB47D4780
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 08:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D987FB20B6B
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 06:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBFC134BD
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlROYcq5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100141FB5
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 06:20:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31B510C9;
	Mon, 23 Oct 2023 23:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698128452; x=1729664452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ozdZnaBJZ2vqKdOuWyOWr4NX6JLrJWxExqsMlsM/PrM=;
  b=IlROYcq50+jtDybwrbvMZ6DJQAAoxA8hoan2f2XuJkwOLJhp1HbEDzgK
   DWxbG17JspBVze4BQvra9eDSl4nm9UDBlufhmBPEEcnmR21x2QwEJXUsw
   EBmDB02/wrDG8kEqRocG84kv3QerdTuftjrZUI0WAuE7F7IvouH5HLZbJ
   o3yeJ8U1jBp1aB0l7TzgcxRdtfxar2LV2AyvfMfCrx52gYzJ2NJjYP7RO
   y2uFFhM26lQ5t7WT6ZGAVMiP5zSlbsBU2BXnV1BTSsTZfWaacVIP05PPn
   S9vcKlasPgF0bO+DA7lmU1vonXyGk9ucA84bGbdSqnjoYjZZGC5bHZL/X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386806579"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="386806579"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 23:20:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="751891383"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="751891383"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga007.jf.intel.com with ESMTP; 23 Oct 2023 23:20:47 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: rafael@kernel.org,
	len.brown@intel.com,
	robert.moore@intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	mark.rutland@arm.com,
	will@kernel.org,
	linux@roeck-us.net,
	Jonathan.Cameron@Huawei.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 3/6] ACPI: utils: use acpi_dev_uid_match() for matching _UID
Date: Tue, 24 Oct 2023 11:50:15 +0530
Message-Id: <20231024062018.23839-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231024062018.23839-1-raag.jadav@intel.com>
References: <20231024062018.23839-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

Convert manual _UID references to use the standard ACPI helper.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/utils.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index be21b77059af..28c75242fca9 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -942,8 +942,7 @@ static int acpi_dev_match_cb(struct device *dev, const void *data)
 	if (acpi_match_device_ids(adev, match->hid))
 		return 0;
 
-	if (match->uid && (!adev->pnp.unique_id ||
-	    strcmp(adev->pnp.unique_id, match->uid)))
+	if (match->uid && !acpi_dev_uid_match(adev, match->uid))
 		return 0;
 
 	if (match->hrv == -1)
-- 
2.17.1


