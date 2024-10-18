Return-Path: <linux-acpi+bounces-8857-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237549A3D85
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2024 13:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E87E1F243E4
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2024 11:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E8D5684;
	Fri, 18 Oct 2024 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBlSRqri"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73045F4FA
	for <linux-acpi@vger.kernel.org>; Fri, 18 Oct 2024 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729252211; cv=none; b=WiKZAhnkPdQozP5iHM4fb2Nef2Dc0Z7BDHyCaCvhOncdJsyCaKOBWJ6GpecxURrvPoRpGvXzEFPc4Nn6XMl21bAUgbaCs+IN30FSFJaOoPEBmFvx+77l6/KO0ds49JBaHBwzrq59oZ1KMSk+5XNHbIavngntCtCGP0StnvJitdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729252211; c=relaxed/simple;
	bh=Je1lPvUTwvDWnt5V8ziCkhNcNULEiPWbpKTRB+kolpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1YuoiUL9bia/PjeGTmfoXPhy5YPSuqN2bDoROFNUbC+pQjWBtlBcnvXlqAMgGUACV6XLvYjhvdqIyDvgZWYshxYXBrCzk62lKC7nuVEcJVgrTuOblaX2j4L/PbMJN/IUAQqUr5NWjXq0znoBBcv2EYh+5mJ6qr7xVyxas+5/TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBlSRqri; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2eba31d3aso1395339a91.2
        for <linux-acpi@vger.kernel.org>; Fri, 18 Oct 2024 04:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729252209; x=1729857009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U2ZeeuJ8In8OyDMLm3MkecNXq/H7DDjtX6sK27/ZkQY=;
        b=CBlSRqriX+sP3KCcPIMQIpKT3sqKBKNCPYcdnxEHtqRyG/SsDYJilWYAzen3Pr5u5+
         4ACUekHVhWaY8V/9yaiGNienBZlbeS/GuJte5Ek2CA+nSMO/8FwxW09/a/iMUO4hIVVs
         8HyMrK/uzihP2RJkPkyKsJ2BTHFWykZfWBuEIbAFrI6FfD4bVBLjLwDb4zXy7yFs+m8i
         tYGh558i5yV78ywzYTbb70M2TjsBjfU7IEEXpdmEYNCuk3sD3o5pSaGH+86WAsEbPVIt
         K/ud5kfgHEa30wKNngo/+RQR6ZvMb83WDBI/UxN9DUVDYbWPL3SKQ+1cy/pCliCkSw9h
         x4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729252209; x=1729857009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2ZeeuJ8In8OyDMLm3MkecNXq/H7DDjtX6sK27/ZkQY=;
        b=wh53qP7/qIZasWXtR6XCc8wXmqJTzoM2ekUcBGzBgIKAJ0um5Dnq0U+py/nFpGRCBW
         f/595uD+0jFV+clFvQ4prYMXcy5xBfv4yrmRyNZaQUWNUtRdEDlhULoRBxa67iotErsF
         F9a0gcb3fTmoQGzZxd6nRgmC2k6CX2WPEZjZ2cszaUoqfjlA8W9HKaoVqwaBPA4jKc4b
         +krFw81zv5Wzh4GrnUW3MqGUCChCKTT7M0YJkIfRwIp+pTSRtBxeBf03qGrhVZ8tP5L3
         tmt4/50iDdVuiJbdGpjrJtmpNT81JxAq1NZsn7BgZhitThBURJji+LoV/SEcJ7lePCN6
         zh6w==
X-Gm-Message-State: AOJu0Yyeyds+U5TWhCh/SWyb71g2ibyej5HxoqHseRSXr61eD8ZcISY2
	GC3L58jwzkUw57geVRvPEp9Nd+MtjvnG677zBAloZLw+faFOhTHScuuCgQ==
X-Google-Smtp-Source: AGHT+IFO1VunZZXSOvAgHlkhg1tPDV3330UyuqhIqrMdccXkdviFAznHeZhCETN++U2oDt1Kp+AziA==
X-Received: by 2002:a17:90a:2c43:b0:2e2:af88:2b9f with SMTP id 98e67ed59e1d1-2e56161af09mr2668788a91.16.1729252209273;
        Fri, 18 Oct 2024 04:50:09 -0700 (PDT)
Received: from localhost.localdomain ([106.0.59.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5612d25f7sm1610054a91.48.2024.10.18.04.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 04:50:08 -0700 (PDT)
From: Shubham Panwar <shubiisp8@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: Shubham Panwar <shubiisp8@gmail.com>
Subject: [PATCH] ACPI: button: Add DMI quirk for Samsung Galaxy Book2 to fix lid detection on boot
Date: Fri, 18 Oct 2024 17:19:46 +0530
Message-ID: <20241018114946.4670-1-shubiisp8@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Shubham Panwar <shubiisp8@gmail.com>
---
 drivers/acpi/button.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 51470208e..7e84662cf 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -130,6 +130,20 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 		},
 		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
 	},
+	
+		/*
+		 * Samsung Galaxybook 2, initial LID device
+		 * is detected as closed , thus causing suspend loop after boot.
+		 */
+	
+	{
+        	.matches = {
+            		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+            		DMI_MATCH(DMI_PRODUCT_NAME, "750XED"),
+        	},
+        	.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+    	},
+	
 	{}
 };
 
-- 
2.47.0


