Return-Path: <linux-acpi+bounces-17638-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3815EBC010E
	for <lists+linux-acpi@lfdr.de>; Tue, 07 Oct 2025 05:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC803C46E0
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Oct 2025 03:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E7320110B;
	Tue,  7 Oct 2025 03:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnGyQZj9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1D92165EA
	for <linux-acpi@vger.kernel.org>; Tue,  7 Oct 2025 03:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759806566; cv=none; b=bEwZRzuEDgJcN9G7FTuwGabQFPjOCbTXPYchnK+r0a/MAWuKjpBbNJTpMO4b0bngk1sA9MHTjncyFZa7IfFCSJbZ1ZEMOsVhzjL9UL0SEvUb+hKYygpNnl2F2KlNMkX+2pZ/+CCSN+Sn1PlMQBGlFBGRAZuvVZGdeTkZBs/ZCXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759806566; c=relaxed/simple;
	bh=Rs0o3iWI4hT/DZwGXQZI1uA8GSaafSIEbBpfGh28sa0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dBCDMYvTCDcpFKwa/e8M3vxXtEvhWGa8JCUqQEbZ4Bl+w6LqgGPfAt+CgfGt3OwbDmIcBYpUl/WqGZXIrkSgYDxhEe3TcSNlDwb/VhxSwVfgePcUT2kRl+auxsMHG17G6/Uano66Im1T2yd1bG78VXxAbfKUJqs6WXJ8nsfKyh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnGyQZj9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759806565; x=1791342565;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rs0o3iWI4hT/DZwGXQZI1uA8GSaafSIEbBpfGh28sa0=;
  b=CnGyQZj9qDCuRMMZwBQpoNSlPvIBcfodhI+AIa1m8Z6H7CYnMMioM0vS
   Nms2VQlK+Dy0SpDWdTlDoCp1rf+YrDC+90/SI8XWuzWHgaVyvZYuHUtCe
   zdEmANGWZt6AdEirtDbh3KvEhoH1mEB4AS5Fc6vRMnS7eAGeGwv7JsxT/
   3GIXQ3HqiMFCf/B2/L1Jg/g0igGjxek2PWIafdq7iLtzEdNllua/uxMLQ
   R2qAc0DP36TAt54KreG+o+rsr/MQkDBu6oTo2KZKreIiLu/DDB/N0esXf
   axqb0f/sFFCWnyJ8UijjtPFQirUdrKkPt46mGSJKIfJPHJq2YE8gfqpeB
   g==;
X-CSE-ConnectionGUID: LARPBCwiQHecsY/c2zyq/Q==
X-CSE-MsgGUID: Z06ssJMRRy685/wLjBj1Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="61020846"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="61020846"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 20:09:24 -0700
X-CSE-ConnectionGUID: 4+A+ftZcQyivpz+JSGQX5g==
X-CSE-MsgGUID: HrSK+XxJS7yc8byYJUKvnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184411315"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa005.fm.intel.com with ESMTP; 06 Oct 2025 20:09:22 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] ACPI: video: Replace backlight_device_register() with devm variant
Date: Tue,  7 Oct 2025 08:37:30 +0530
Message-Id: <20251007030730.3192901-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace deprecated backlight_device_register() with
devm_backlight_device_register() to use device-managed
resource allocation. This automatically handles backlight
device cleanup when the device is removed, eliminating the
need for manual backlight_device_unregister() calls.

Remove the manual cleanup code in acpi_video_dev_unregister_backlight()
as the managed version handles deregistration automatically.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/acpi/acpi_video.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 103f29661576..e56665977ed7 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1741,16 +1741,15 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 	props.type = BACKLIGHT_FIRMWARE;
 	props.max_brightness =
 		device->brightness->count - ACPI_VIDEO_FIRST_LEVEL - 1;
-	device->backlight = backlight_device_register(name,
-						      parent,
-						      device,
-						      &acpi_backlight_ops,
-						      &props);
+	device->backlight = devm_backlight_device_register(&pdev->dev,
+							  name,
+							  parent,
+							  device,
+							  &acpi_backlight_ops,
+							  &props);
 	kfree(name);
-	if (IS_ERR(device->backlight)) {
-		device->backlight = NULL;
+	if (IS_ERR(device->backlight))
 		return;
-	}
 
 	/*
 	 * Save current brightness level in case we have to restore it
@@ -1841,10 +1840,6 @@ static int acpi_video_bus_register_backlight(struct acpi_video_bus *video)
 
 static void acpi_video_dev_unregister_backlight(struct acpi_video_device *device)
 {
-	if (device->backlight) {
-		backlight_device_unregister(device->backlight);
-		device->backlight = NULL;
-	}
 	if (device->brightness) {
 		kfree(device->brightness->levels);
 		kfree(device->brightness);
-- 
2.34.1


