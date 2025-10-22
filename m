Return-Path: <linux-acpi+bounces-18069-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEE1BF9EFB
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 06:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE8B44E6907
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 04:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFBC2D594B;
	Wed, 22 Oct 2025 04:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exoWGZHQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ED0261B9E
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 04:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107126; cv=none; b=EUrIPMNhD/OFdSdW153c7Er3UqzFOCWB1HJGDabhrZrvNcZxYrqJqQTeQga0qNdUrfXYMSbbgmL6QlYo1I/I1CoTf9PXCQkYxm3lQdtsOL5x+0xuB8PKT5QwgC5pAw7Gt67c2BMbx0xZpEIbHT8n9baCj1cP2N5w0JChWzWzaWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107126; c=relaxed/simple;
	bh=bsYa6X9KROYy7hv3d72FhLZXSqZ0WWU/HZUA1g//G3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O+29yCZkSNRGyVlKb7fR9auQGIWG2Yf5MmSdH0jNptEYwnZzF4I+9SlNMzgpYk8mcv5pGy2VDZxDF9NKWXitJ4UNK5mgAkMkR0YZN570NHe3x1BZ/Vva1aEUn25Bb+njh6qXdwndw/9j7HGFk0BncB4DXPjZdJbpYUJ0YPDKm/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exoWGZHQ; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-430c151ca28so25135005ab.2
        for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 21:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761107124; x=1761711924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t2LfB28zph799goFY4PIl5Hu2JZs6ZC/o5ejBi3O62Y=;
        b=exoWGZHQQDbNsbubt6n5JRRZ29qcKqLgoZYz0OCI/KQnHCdc1oB4YGwFEeXT8sJIwO
         h+ynMzFrroOOfnRd4EVAxKOy70jPHa1ttXVW5wAZXwKbpsrfnU0SAhoUhA6PI4zKS9mN
         j0JGlV0nv7KFeSLJw0JRgWDt5qX/sBOfEUlLLuXKfzAcTnDyVXesDG5OtSn0QLM2ZcSY
         fH2qwHlQUB/+MXGTr85NZiIwpDAAILuY/rk5afuhkQmV0guOiP+xPj8LU9aGiIfR730w
         LdKFsfR3F/YVUeVyEsdK1/vyN0SAL8tYf1Noe0XAUKqC7hBXBqGf60GAVu8/kbVvCuVx
         ofnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761107124; x=1761711924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2LfB28zph799goFY4PIl5Hu2JZs6ZC/o5ejBi3O62Y=;
        b=VrRQVnC4+vfohkRmD/v3nlQj12SBVuFbMFCc1mt0iwzMt9Hd83d4gn1N9mjKrYbDJu
         DpO7YbIxmdB7Ug5vnpyF49uKAU7Gh8Y2co0ZfdmLQOnwe2EjOSDsCQK4zzLpPxg6lP/0
         I5P5lQXHl2hmkJN28L3ZXC4OM1G7fqu6K9X4pe7psUlob3SAOR9WSve2an71BW8ECorG
         U6bz7jQ3SZkVaemi4k3qPrC868u/LNdF+BY73qsk2XJupT/bUBASpIAS+/Oa4lvcabT5
         iMU+Gx8ST9S7aYfHYXMuHiLy/RlFu7WsTnc1BCjGziq2cPSiFbQ73Kj65CfYc2+0r13L
         Wp7A==
X-Forwarded-Encrypted: i=1; AJvYcCULPktRfpid6J/KKLr3iLpE/JVp23/vocnvMqpRUwCg52fQXh0FiMx7RgLAc2HZnJjTRGlBP9HwOHlQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzdI21T5IEyu4UgwQC4Pqtk4qLpCGOEFIA+B2/0fr7ztNtt3mn4
	UswQQuMT7TGSD6/v2jMzDbw4devVsmXkpMHW9QEAgnkaPVqmtKv97iuh
X-Gm-Gg: ASbGncvA39l5JGlyNg6pMgBPZX9rYcEFkyZ3gp2sAyhF0+daFgCsgNAKAU28llcF8DW
	utNnNs2IU7FwGNfQ1ZProuRPIIaSAejkGKoz40ZzIgiV3A2UeAB/a70YeLSd0wJL/A134Te8G0C
	tfEKVvRRVFmwPWzkPBaVSB0LAbneCSTz6RNcLb5YJRiSv2R1uBlkXTnU6fhjPCY48dcuaBMFhKC
	SPwoUbnOHy+ntfNeCxj+IQ3zD8/o56pOD/3eKU4O3YIBiztQn717zvGwY2ajkJC09NYnp8v1RX3
	tvSZxW6cAmqpz4szTKGqcpVz5yLe/n2JVa/kWC6fBMYQBAYwMt6KMU2nftdsBdGr5QmOpiE3wcu
	MS7sPjWtgGR88Vl5KNV/SivfVOXjIu/6jej6eHtnD8q2EKZdbn6vB5s+Y07l/Cx2H2Ws9O6PJB3
	0ypkRcwpF1uv/4J+rR7CZrFK25P2+NY3yNhb6KRG2ImhH1ocNBqYSLNk/+vAH1VzjcLfS3IfrM1
	hPXOQfsSsbscKGJGIVOcC0Xaw==
X-Google-Smtp-Source: AGHT+IH49shBuQugYlN++wVSTOrOUhHiUw/C0tNQMZKmX9SB2vKCC6aIZVhWNKA0jz+AhfPi3lDZ1A==
X-Received: by 2002:a05:6e02:4510:b0:430:cad8:45fc with SMTP id e9e14a558f8ab-430cad847a8mr245028055ab.29.1761107123942;
        Tue, 21 Oct 2025 21:25:23 -0700 (PDT)
Received: from abc-virtual-machine.localdomain (c-76-150-86-52.hsd1.il.comcast.net. [76.150.86.52])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07ccc89sm49925505ab.40.2025.10.21.21.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 21:25:23 -0700 (PDT)
From: Yuhao Jiang <danisjiang@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: [PATCH v2] ACPI: video: Fix use-after-free in acpi_video_switch_brightness()
Date: Tue, 21 Oct 2025 23:25:14 -0500
Message-Id: <20251022042514.2167599-1-danisjiang@gmail.com>
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
switch_brightness_work before unregistering its backlight resources.
This ensures the work completes before the memory is freed.

Fixes: 8ab58e8e7e097 ("ACPI / video: Fix backlight taking 2 steps on a brightness up/down keypress")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
---
Changes in v2:
- Move cancel_delayed_work_sync() to acpi_video_bus_unregister_backlight()
  instead of acpi_video_bus_put_devices() for better logic clarity and to
  prevent potential UAF of device->brightness
- Correct Fixes tag to point to 8ab58e8e7e097 which introduced the delayed work
- Link to v1: https://lore.kernel.org/all/20251022040859.2102914-1-danisjiang@gmail.com
---
 drivers/acpi/acpi_video.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 103f29661576..64709658bdc4 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1869,8 +1869,10 @@ static int acpi_video_bus_unregister_backlight(struct acpi_video_bus *video)
 	error = unregister_pm_notifier(&video->pm_nb);
 
 	mutex_lock(&video->device_list_lock);
-	list_for_each_entry(dev, &video->video_device_list, entry)
+	list_for_each_entry(dev, &video->video_device_list, entry) {
+		cancel_delayed_work_sync(&dev->switch_brightness_work);
 		acpi_video_dev_unregister_backlight(dev);
+	}
 	mutex_unlock(&video->device_list_lock);
 
 	video->backlight_registered = false;
-- 
2.34.1


