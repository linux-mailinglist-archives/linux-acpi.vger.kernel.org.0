Return-Path: <linux-acpi+bounces-18125-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E98FBBFE1F2
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 22:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2FC64E129F
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 20:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226FE2F83C2;
	Wed, 22 Oct 2025 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz1qgeCp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F582F7AA2
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163634; cv=none; b=ezjdXzAnuaNzKdo/ztCb/sP9H+PlRHUSZyMuCguUJDhaXICGHkeI9lkwN42wkMR7NpQ1qKFo3BLfg/9HS9AMdriRJDXP7FhWlWrwVbgkt723IyShoTo7P81OXGnXP8HPeHTrmGIyo+kN+2UA9v2BDMJAlpL0mCyeaLAo8XS/oto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163634; c=relaxed/simple;
	bh=DztsLj3vdv3FYw0cPl2uS2ogmDunqfckdWo1ml2REqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l8MxQYGu0oT1DOHZGz0K9FmqyITVEUVQcDBrrRueXucGpM1NvYA3WovAE/r3uAP5mR1qbLYHzOzx55MqYifB009R+x7P6DCNIAUy6qgdqA6d6uIv8VVGnWHwPbPqbu1dPkLpcFwkZevClA/ARxI7KGZYSe8fuaTc8sv36qF2Y9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hz1qgeCp; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-430c17e29d9so357585ab.1
        for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 13:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761163631; x=1761768431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VwbN+wurLTlI3kZfG9YY+LmisCptQEnBinwXCuD+yAQ=;
        b=hz1qgeCpqBUZZFb5VyO/yLXkt3Fm0AHzgo8yuuor30thglPC58BBNZ4D3ihi5z/cEM
         TAN3tpCkzn7jf9Ry82Uj3fItsgdMXyDRBkjIiYEqwfu9a/Dpcttd5AhrXNEThXxvovDV
         HWnvkN7jrcuyJSnXvzoD0dJiqWDUTm4pCq6jc3h8fmkOs+DpB8lPmYMfYAaFZf6FlJ3I
         l/5w7hBe5MmoynaNj2VYl7H+aZgoUbaREH0H0sPHveXN8imSuyOXEEgAZWafUAEm8ZKn
         Kf/BZhMFgrZp/qGK9Mmyq3e3S/OSc9LbSJ04eaPWRkuR7nYogQvHiNAuAAr/TadYgRN6
         j+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761163631; x=1761768431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwbN+wurLTlI3kZfG9YY+LmisCptQEnBinwXCuD+yAQ=;
        b=h+Y0GamV7qw8ypci3FHhRFHAnRIOg5vM3rtHjrkusyN7P/LwMFhM42H7VmqZFMrZeJ
         sLefTH9X4TwwySWJzYNvVIWpAHtkh3Hv79XNH9aR9tiz9c2V0HKavxqI+WFjRdDBeiBs
         Ox9+wDNIaLSlsHaSjEZwk47kuzJStF3r9izjqA5D5mfAkyzdMTVdn/8wlENnx13rKNeJ
         gopSGRt3evqCneg7Orru+zELPqdZPi2zlW1ugAFzckUzLEv5kA3nZBrAA4ag1bNp8Jxm
         GcKJu18vUNpj+C3SyUDr4TrbA+ApgPXQtXTgzPxcPLf3/JffMSV8KuyevXHKetI3UfKq
         Zp4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9+PSbkMJQmIEigbE1cVcc3BbT/P5lbFEV2+ECDM7EorV6gLnudtQ9b2X3xeJgSYtpHU6pzkP5JQf5@vger.kernel.org
X-Gm-Message-State: AOJu0YyvSXddDJgeU+avhAr0LXErPYDkGGYoTVH9gpRamuQRXhOCTPBS
	HNLmpWxJfVRNa/IzjBAAo3kouosqUPB4TXUeiyHcKwSQO56WrxHU+52/
X-Gm-Gg: ASbGncsw35GvuEOKiztxmgvy1ZcEJLsiGijtVFqh/RJpcDjddj6c55j3689sR1klax4
	ptS36E+kt/hKgoK8QbeLSUJCP0veSo+6qJ7Jqq0shwZKtEg0VP8Qjdv07TT8GAJ8mOg1cJdnHGU
	752XxFhokuoG9+T4QZ2hMJvoDo723M5QEk9P8xwYmDiCGVSD/Zma3wPaWUTMTjZccZuiBF1KjVv
	0N6DWevoSBoMk7baO+/MTrTxzLbGl8vpZs5UQ75A031OKd8Fa8866jzfsDasKe5JBXgYcr+XFEW
	v2iHua+2F2F/VQwmUyVeC6JctBBq9m7Ft0OUlBB/oRJQi7Ybq4GUVcnvyONFLmfcX0SBcIZsQ8m
	qEH8xPOHkpGUXc77sz1rpQwAQCOkXlmphE/MwsvrXpRfCTxjc7b4X+jaZBISzNP4bi8D5AJCk96
	eRlRAEys8pOxW6z/DyPUmdDIy4+BcFub0j+Vj3+UhircDbb3lXYtB6kcFZ/QcuKxoiKDNkVDtFZ
	sZb
X-Google-Smtp-Source: AGHT+IEi13vxAW3QWGvs47oIZZEeT5MJtjo5ggN538BbVhSvNenvFcif8+DslNFd6WG9e5ojjv5SEQ==
X-Received: by 2002:a05:6e02:156c:b0:430:ad98:981f with SMTP id e9e14a558f8ab-430c524b96bmr287934085ab.4.1761163630603;
        Wed, 22 Oct 2025 13:07:10 -0700 (PDT)
Received: from abc-virtual-machine.localdomain (c-76-150-86-52.hsd1.il.comcast.net. [76.150.86.52])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb5432ca5sm18991173.16.2025.10.22.13.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:07:10 -0700 (PDT)
From: Yuhao Jiang <danisjiang@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: [PATCH v3] ACPI: video: Fix use-after-free in acpi_video_switch_brightness()
Date: Wed, 22 Oct 2025 15:07:04 -0500
Message-Id: <20251022200704.2655507-1-danisjiang@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The switch_brightness_work delayed work accesses device->brightness
and device->backlight, which are freed by
acpi_video_dev_unregister_backlight() during device removal.

If the work executes after acpi_video_bus_unregister_backlight()
frees these resources, it causes a use-after-free when
acpi_video_switch_brightness() dereferences device->brightness or
device->backlight.

Fix this by calling cancel_delayed_work_sync() for each device's
switch_brightness_work in acpi_video_bus_remove_notify_handler()
after removing the notify handler that queues the work. This ensures
the work completes before the memory is freed.

Fixes: 8ab58e8e7e097 ("ACPI / video: Fix backlight taking 2 steps on a brightness up/down keypress")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
---
Changes in v3:
- Move cancel_delayed_work_sync() to acpi_video_bus_remove_notify_handler()
  instead of acpi_video_bus_unregister_backlight() for better logic placement
- Link to v2: https://lore.kernel.org/all/20251022042514.2167599-1-danisjiang@gmail.com/
---
 drivers/acpi/acpi_video.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 103f29661576..be8e7e18abca 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1959,8 +1959,10 @@ static void acpi_video_bus_remove_notify_handler(struct acpi_video_bus *video)
 	struct acpi_video_device *dev;
 
 	mutex_lock(&video->device_list_lock);
-	list_for_each_entry(dev, &video->video_device_list, entry)
+	list_for_each_entry(dev, &video->video_device_list, entry) {
 		acpi_video_dev_remove_notify_handler(dev);
+		cancel_delayed_work_sync(&dev->switch_brightness_work);
+	}
 	mutex_unlock(&video->device_list_lock);
 
 	acpi_video_bus_stop_devices(video);
-- 
2.34.1


