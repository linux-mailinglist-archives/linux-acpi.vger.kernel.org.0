Return-Path: <linux-acpi+bounces-10159-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9D29F3C9E
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 22:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0221887D1A
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 21:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F001D54CF;
	Mon, 16 Dec 2024 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RirRtlIs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14801D434F
	for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383847; cv=none; b=hD6SGaqSvzRw/tDt5FZ1b1Tc+eY012NaSThINVAcCyJsi0GMB1E4W+Q3QRGfOkrxYAuOA9ruWSShyYxogbM9z2XuC5a6gVNzSxqFkqOwn/DFEN+e5Wk6uv+gUJPScHV/Mhm4siSyhIDAfB/43aa8ZD0tBbEkUmbPJkhZzQfai7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383847; c=relaxed/simple;
	bh=kKwZloJ+pxiytz9zfwyv5msK5QwJz26A7aW8bSu0I3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hvEvS36u5OGzuqe+VhZmaTAZXkrB2SeaEqZTpJclhrcn2l5AiibWLQ790bxEW2FcGvFJnSC5kpfCd7G4nV3ERjLFLRrbIBwtDpV9W/Hb3IOlvXOWNOQ679fAnrrPvWWMEeiI7+MZ1Jr2iXcpvxa1VnR22v1zZjtV2QGGFdMYiHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RirRtlIs; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4678664e22fso43341961cf.2
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 13:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734383845; x=1734988645; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kM2B80UZkeR2LPczGOfVlIBqSwSauWzJe2cC0H2QDRc=;
        b=RirRtlIskXwmaHipMITx24EyeCZsFaL6QXksT07tn27TpSzPZLiLexMe/AHK5oulAU
         J5mQxx7d268giF+o/uF9Qmggcagd+VNuPUu6p6Mww8FdZ4Ao+PCnALLzulW0N/kNNNaD
         eXDLvJ0+QHlHtKHntzuTQqEsEctSu9LdG+wfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734383845; x=1734988645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kM2B80UZkeR2LPczGOfVlIBqSwSauWzJe2cC0H2QDRc=;
        b=tVZCWWS3RxGk01ph/Jd5+wlntQdpY1mTCEdsfZg+ViRGDxgXl0gtKyfKM2A/y/8yrF
         UB5hlnAqZSHdtZNd39qDidR90a/cmoqECK/yLClrmILsQJRReAKaFAeGhM2V4f5ZEQcH
         jN7lCmx/j3TTwjvUg6grXrHaII5GHhOooO4Mt1pUdsv1hdBs04VvjQKMg/ro52gYz09T
         NrsjGVMfk0eGui3+XslX2KE5+Di1JHd/bLFtV+C0plHEC5WNlTmsWZtXjAsoOZhLyI4m
         ZDQ9IDT3NkppeB14HIh9WAdRtWBe+0E4bOExSB4VJNGwFMaRONSL2ZrTk1ZQsR91v9pM
         XOqw==
X-Gm-Message-State: AOJu0YyT4G4kMdeQ9e0PrmE+m/mTs1bZAg8pNZjzrq2Te17piacdr18k
	584zGolayNiDx9Uq5O5bi7O4ygasLyI3HWdKx8djifP0e/5zqVkkdT8ohwX1dQ==
X-Gm-Gg: ASbGncvvejCgUxZRbDQc8Dke44M7xkjp/0Rk7+mDRARF/S3MwjYus7PFTY3YErSBAjM
	Vxxs1TDo3XEAzWtSy8SV9owU5YwtZvN8WLxZiJOB0DMDb4nCA4tmvYVUtcH/L8iYpNrMHHPy6uU
	3AsQ90GQfLuGsI/bLaRlAVo0wlP668POb1X1Mv86aQDTSOWHap5bazrE/VWVhEkWnOdl8agr+zk
	AH10smw78R+Pg6XwiuUSaDEQ2Bx5psVSa/uYDHobpduvvoHcUNWB66CTvz1FxDaoLYALQ/iv7gT
	1T6kKWQWtWGbF32oVzPTKC9quAjoW+0=
X-Google-Smtp-Source: AGHT+IHSGnqI6FhkQaL0069bHSXiDXW28qApI4WsVyO7HAsa7gVNw+XbMJ7VfZy9PvrVRyRjuC0jMg==
X-Received: by 2002:a05:622a:1487:b0:467:45b7:c495 with SMTP id d75a77b69052e-468f8ad232emr17931231cf.15.1734383844801;
        Mon, 16 Dec 2024 13:17:24 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e85c03sm31927501cf.69.2024.12.16.13.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:17:23 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Dec 2024 21:17:15 +0000
Subject: [PATCH v5 1/7] ACPI: bus: change the prototype for
 acpi_get_physical_device_location
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fix-ipu-v5-1-3d6b35ddce7b@chromium.org>
References: <20241216-fix-ipu-v5-0-3d6b35ddce7b@chromium.org>
In-Reply-To: <20241216-fix-ipu-v5-0-3d6b35ddce7b@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-usb@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

It generally is not OK to use acpi_status and/or AE_ error codes
without CONFIG_ACPI and they really only should be used in
drivers/acpi/ (and not everywhere in there for that matter).

So acpi_get_physical_device_location() needs to be redefined to return
something different from acpi_status (preferably bool) in order to be
used in !CONFIG_ACPI code.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/acpi/mipi-disco-img.c        | 3 +--
 drivers/acpi/scan.c                  | 4 +---
 drivers/acpi/utils.c                 | 7 +++----
 drivers/base/physical_location.c     | 4 +---
 drivers/media/pci/intel/ipu-bridge.c | 4 ++--
 drivers/usb/core/usb-acpi.c          | 3 +--
 include/acpi/acpi_bus.h              | 2 +-
 7 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
index 92b658f92dc0..5b85989f96be 100644
--- a/drivers/acpi/mipi-disco-img.c
+++ b/drivers/acpi/mipi-disco-img.c
@@ -624,8 +624,7 @@ static void init_crs_csi2_swnodes(struct crs_csi2 *csi2)
 	if (!fwnode_property_present(adev_fwnode, "rotation")) {
 		struct acpi_pld_info *pld;
 
-		status = acpi_get_physical_device_location(handle, &pld);
-		if (ACPI_SUCCESS(status)) {
+		if (acpi_get_physical_device_location(handle, &pld)) {
 			swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_ROTATION)] =
 					PROPERTY_ENTRY_U32("rotation",
 							   pld->rotation * 45U);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 74dcccdc6482..93d340027b7f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -723,10 +723,8 @@ int acpi_tie_acpi_dev(struct acpi_device *adev)
 static void acpi_store_pld_crc(struct acpi_device *adev)
 {
 	struct acpi_pld_info *pld;
-	acpi_status status;
 
-	status = acpi_get_physical_device_location(adev->handle, &pld);
-	if (ACPI_FAILURE(status))
+	if (!acpi_get_physical_device_location(adev->handle, &pld))
 		return;
 
 	adev->pld_crc = crc32(~0, pld, sizeof(*pld));
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 6de542d99518..526563a0d188 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -494,7 +494,7 @@ bool acpi_device_dep(acpi_handle target, acpi_handle match)
 }
 EXPORT_SYMBOL_GPL(acpi_device_dep);
 
-acpi_status
+bool
 acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
 {
 	acpi_status status;
@@ -502,9 +502,8 @@ acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld
 	union acpi_object *output;
 
 	status = acpi_evaluate_object(handle, "_PLD", NULL, &buffer);
-
 	if (ACPI_FAILURE(status))
-		return status;
+		return false;
 
 	output = buffer.pointer;
 
@@ -523,7 +522,7 @@ acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld
 
 out:
 	kfree(buffer.pointer);
-	return status;
+	return ACPI_SUCCESS(status);
 }
 EXPORT_SYMBOL(acpi_get_physical_device_location);
 
diff --git a/drivers/base/physical_location.c b/drivers/base/physical_location.c
index 951819e71b4a..5db06e825c94 100644
--- a/drivers/base/physical_location.c
+++ b/drivers/base/physical_location.c
@@ -13,13 +13,11 @@
 bool dev_add_physical_location(struct device *dev)
 {
 	struct acpi_pld_info *pld;
-	acpi_status status;
 
 	if (!has_acpi_companion(dev))
 		return false;
 
-	status = acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld);
-	if (ACPI_FAILURE(status))
+	if (!acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld))
 		return false;
 
 	dev->physical_location =
diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index a0e9a71580b5..6cc2614b8f86 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -259,12 +259,12 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_dev
 {
 	enum v4l2_fwnode_orientation orientation;
 	struct acpi_pld_info *pld = NULL;
-	acpi_status status = AE_ERROR;
+	bool status = false;
 
 #if IS_ENABLED(CONFIG_ACPI)
 	status = acpi_get_physical_device_location(adev->handle, &pld);
 #endif
-	if (ACPI_FAILURE(status)) {
+	if (!status) {
 		dev_warn(ADEV_DEV(adev), "_PLD call failed, using default orientation\n");
 		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
 	}
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 03c22114214b..935c0efea0b6 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -213,8 +213,7 @@ usb_acpi_get_connect_type(struct usb_port *port_dev, acpi_handle *handle)
 	 * no connectable, the port would be not used.
 	 */
 
-	status = acpi_get_physical_device_location(handle, &pld);
-	if (ACPI_SUCCESS(status) && pld)
+	if (acpi_get_physical_device_location(handle, &pld) && pld)
 		port_dev->location = USB_ACPI_LOCATION_VALID |
 			pld->group_token << 8 | pld->group_position;
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b2e377b7f337..19f92852e127 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -43,7 +43,7 @@ acpi_status
 acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
 		  struct acpi_buffer *status_buf);
 
-acpi_status
+bool
 acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
 
 bool acpi_has_method(acpi_handle handle, char *name);

-- 
2.47.1.613.gc27f4b7a9f-goog


