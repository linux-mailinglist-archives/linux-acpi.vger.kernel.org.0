Return-Path: <linux-acpi+bounces-8308-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14311979830
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 20:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9D2281113
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 18:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B490B1CBE89;
	Sun, 15 Sep 2024 18:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDJZcsGc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031741CB52B;
	Sun, 15 Sep 2024 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726425565; cv=none; b=txZ49Z+4G+X1eZfVx7U7uBC2N7zhDx2mxYPxZs6nArlQCbbBwO6iVaRL5+go/G9+sXw/LfbhXxtOQCaKmZoQSOn5IoxG9vETcm3zao9cubTFXWjvyHEAQXQ2jNkY/f9ZhpSZalUGr4D4tSJsJBFYzBZiN3xDgOYKfm0BuVzCx8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726425565; c=relaxed/simple;
	bh=OnJ05WaDShiGNVjIgf9Nqis6sYSVm0mgO+tOmfk+c+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6tUwC5QEu7sUuJ41QPSpmIFHm7tn/TgMICCZtQdji8g5vRfsz1xNLvQU+VYXOnBt0Gscm4Qq5sMnEx1CFtzptNkKz0yV580B5OqkMGh4pORLGRrQj0oAjI8j+rpPi6OW0Eh2Y5gZL4UwdFqYV78p6AoioB7sHru38HYJEVTOVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDJZcsGc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42e5e758093so4101965e9.1;
        Sun, 15 Sep 2024 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726425562; x=1727030362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELjpz1rBiExxDnOz7HNOv+Qd7/rDFxM45ncqcBQusKM=;
        b=gDJZcsGcaZKCdaCZILZk93nZ5OJfh49B8aDrE0F7gMQqVtkxWlSx3QxjWFMB2xcQ3O
         2T0forKhWJfjRX5YX4OM4rolmnmCyQklO6i3yUfLXwZMZ8vZXfvb+wbfRRq8OrCiQm0C
         S7hURR6IsZbQ4N5n98HSK47gMl/efweqA3TwiNMqO+t1HpQwkwUnnvSD6ZilWstx/Guu
         +mY9eF0KDsiG78OCcS6x9NnI2l7uoiOOhjNi4F/z2aUSPatw7zXzRQH2qiQiRPOWIBeU
         iTCjnAuqNCtkIXLQke0iem6fWw2g0Yv8TbZy3KGh4pcbMvBdwagPbp6x/2fvgQwHcGC4
         PWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726425562; x=1727030362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELjpz1rBiExxDnOz7HNOv+Qd7/rDFxM45ncqcBQusKM=;
        b=Pe4oZm9dm7RxgoCoAzCww5exEGLYmU8AbN8xDZE6W7cV5QeAmUzL3+or9UGhkoxEXS
         nEZw607JEBrV2Y/8CS9CLxOD/JAOzbmzPw73XRPMQkJhVG1FmZ3WxZc5do0HWHDjW4DM
         HpaTlcpILee0eeUdZ+BKrrMywrkAnqRVfNpnj0WnjgXc3fCPW5z/afEkJeGD5G8aja9C
         ahreNe9n3E2pb+SIMaf9E+l08FAfT3xCDXJRsu2fbnOfd8uyMMsv/irPVBMXamvvKm7K
         8o/4hZcJwrZ6bKUGsTtI+XAcYzbL+kKdnFR2+ca1kZwiV1wQ/esZeCPsRE2qg9JjypbL
         HDwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEn4c7zkCFmVTZ3rPs7N1Gkoh5AKJx/XVJgIAopnpg49pM78BsIkZvxyNpIphMFzBMej2y1O23u0Xt@vger.kernel.org, AJvYcCXHqQNwnDw7P3Lv4yu/4l3AhsdDYxM8MoCmn1e67AmFq+19rtR1aXEVfhdVGEax4LEkXSccpGZTGTvjKo5g@vger.kernel.org
X-Gm-Message-State: AOJu0YzCQJHWxWekn/vx6KoQVqukaYzIITX5Eo+hJ5jbYmv+0MIGmk0I
	tobW1xM+6lqKqfJjnevRvpXl3gkqCxJxeYas5z4yWOsMLOZU4Vd4
X-Google-Smtp-Source: AGHT+IGc+8EVYbbHRnc+S9A51fe6p45mZnlxDkSKI0VSBuoApwbj05Y4YqLOpH0KR8uWuJPX+1HBoQ==
X-Received: by 2002:adf:ec0c:0:b0:375:133e:27f3 with SMTP id ffacd0b85a97d-378d61711d5mr5251133f8f.0.1726425562084;
        Sun, 15 Sep 2024 11:39:22 -0700 (PDT)
Received: from qamajeed.Home ([39.45.198.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f2001sm5162357f8f.48.2024.09.15.11.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 11:39:21 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH 09/10] ACPI: scan: Use strscpy instead of strcpy.
Date: Sun, 15 Sep 2024 23:38:21 +0500
Message-ID: <20240915183822.34588-9-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240915183822.34588-1-qasim.majeed20@gmail.com>
References: <20240915183822.34588-1-qasim.majeed20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strcpy() with strscpy() in the ACPI scan driver.

strcpy() has been deprecated because it is generally unsafe.
Eliminating it from the kernel source.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/scan.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 22ae7829a915..61cfd8106f3e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1179,19 +1179,19 @@ static void acpi_device_get_busid(struct acpi_device *device)
 	 * TBD: Shouldn't this value be unique (within the ACPI namespace)?
 	 */
 	if (!acpi_dev_parent(device)) {
-		strcpy(device->pnp.bus_id, "ACPI");
+		strscpy(device->pnp.bus_id, "ACPI");
 		return;
 	}
 
 	switch (device->device_type) {
 	case ACPI_BUS_TYPE_POWER_BUTTON:
-		strcpy(device->pnp.bus_id, "PWRF");
+		strscpy(device->pnp.bus_id, "PWRF");
 		break;
 	case ACPI_BUS_TYPE_SLEEP_BUTTON:
-		strcpy(device->pnp.bus_id, "SLPF");
+		strscpy(device->pnp.bus_id, "SLPF");
 		break;
 	case ACPI_BUS_TYPE_ECDT_EC:
-		strcpy(device->pnp.bus_id, "ECDT");
+		strscpy(device->pnp.bus_id, "ECDT");
 		break;
 	default:
 		acpi_get_name(device->handle, ACPI_SINGLE_NAME, &buffer);
@@ -1202,7 +1202,7 @@ static void acpi_device_get_busid(struct acpi_device *device)
 			else
 				break;
 		}
-		strcpy(device->pnp.bus_id, bus_id);
+		strscpy(device->pnp.bus_id, bus_id);
 		break;
 	}
 }
@@ -1453,8 +1453,8 @@ static void acpi_set_pnp_ids(acpi_handle handle, struct acpi_device_pnp *pnp,
 			 acpi_object_is_system_bus(handle)) {
 			/* \_SB, \_TZ, LNXSYBUS */
 			acpi_add_id(pnp, ACPI_BUS_HID);
-			strcpy(pnp->device_name, ACPI_BUS_DEVICE_NAME);
-			strcpy(pnp->device_class, ACPI_BUS_CLASS);
+			strscpy(pnp->device_name, ACPI_BUS_DEVICE_NAME);
+			strscpy(pnp->device_class, ACPI_BUS_CLASS);
 		}
 
 		break;
-- 
2.43.0


