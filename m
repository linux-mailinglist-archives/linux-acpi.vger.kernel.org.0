Return-Path: <linux-acpi+bounces-6682-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C9591D310
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jun 2024 19:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861C42815A5
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jun 2024 17:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1583C15535D;
	Sun, 30 Jun 2024 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkuGZOG7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B01D12FB34;
	Sun, 30 Jun 2024 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719769001; cv=none; b=N9/4esXkbYs1JH/RaaaYpsx+H+zDPKHrExN7Lxmj+dm7Z9mJc9idzq6cgcpu6QeswMBn1Fv/rH4zETs/MBcAjL1zWDLPV6S3xQxU3BIqF5PBgmfd9w9hL8VlgmjgvnWnNDsF74MrLc+cbAyeBkm+/Tl+sXUKu2jPXxgTEbqrS8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719769001; c=relaxed/simple;
	bh=CEC/uj+jHgVHI5ry1SInCzFe6GhCVaTspmdYEMfm9Eo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mS5d0Q9vGoQsR1vu2THnFRDDPD+nAYOIHDgZR1jpe79ldmXLah4MeKWkksuXulmOlmLXf956hvZXDSVlLFICRWZ/BsLGgStBjYVrD5YEUhP+gcImx/btviGv3kHZOyAzwgCbVeQe3bLaXkeoNehpvDMt0JKuZyzgOpkgqDZF16s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkuGZOG7; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so25508131fa.3;
        Sun, 30 Jun 2024 10:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719768997; x=1720373797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dy3gLu7I5dJFeESwGxccqcPXiCFfnXkkk3gsTdwYcCI=;
        b=jkuGZOG71feBJTnWxahUpJp6sdEqr/GOINstHobk3HS7k2wfjkeUay1agZ3hmHmPAZ
         Flkj/r4NiTtnYbyNpz5HF8fy4yArbB4FnQ4byhJvd7W8ZWvdF0WtRAMM7qLpBybgFAZN
         En//0d56bHnwqJMybO1W7jherFtnVw+Bwr++79a5/Mvj4eUJ4/Gppamu9GyA/0U4/nz3
         p7AqIn0D0wdH8H2Tev1UPrr4mtnsf9Kx1USu157XiqhSfBvqElGMQBsZ+ZZtPq1gc2xM
         vmKm7nsxJRu0I8wy5Nu7d9uWPQKbXHldNHCj5hyoMv5BEQdMR4ugNMFaDSPuZH8tYYRy
         8azQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719768997; x=1720373797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dy3gLu7I5dJFeESwGxccqcPXiCFfnXkkk3gsTdwYcCI=;
        b=a+8Myp5I/rgZBIMUjKEorl+AEkzlMgiw1TeSs4lDZbuqdrL67IJ4+Xsh8qGAuJ79Yu
         6eIibpZAoB1KmvIxrJ1Lsba0uzpFQYfBsLeo3rsyIY8BFtVkQF9A3sjH/zk94Q7jZOrd
         i/Eu5RqcAGX8oO/G4yztXChQasO8rExJGWPTJRK832F6JzrTxeLzyQFGGBTpHW79aSAU
         m94pfUKEv7OJDvkrZrmQxProlusAfhft+k+2lXPfjPqr/FSxEu++pd4IHOQKeTBSutAY
         qmy3oT6UXsAMbVEDuXEqpcdgZipNgYm9aicJsEIXOCAKOkZ+7gEQ2eEPo7+Wqsm+Il2a
         shgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaDlYNCK09WSVf4rtPU3PpT7gPekcD1f2Zm0Rn5qrPpXxgrdyTBh4AGFL9p6aVF5QEPBlhSLP0/kvnHTYQMWxUsLeuYpSmHt1lHJbjJqPEWeolhve90nyU/jyTHpa1fW/VXcNesN4YSw==
X-Gm-Message-State: AOJu0Yzui4ZOLi+A7j373vHdpkjY70QCNbgvkdkCVsS6fuw80T4XaSey
	jegp70CSN87Q+Miu00yD8SxpBPgcw2G6Ewk5UKXXTa+ujDl1G7EJ
X-Google-Smtp-Source: AGHT+IEluxmXHWuWL59Y3dBrov94K52axD5ahoJlnyO9WMAgLtJbqeeymhVYBmVpEr7qOY961jxTow==
X-Received: by 2002:a2e:3e15:0:b0:2ec:3c55:3056 with SMTP id 38308e7fff4ca-2ee5e6c9951mr19863121fa.44.1719768997070;
        Sun, 30 Jun 2024 10:36:37 -0700 (PDT)
Received: from qamajeed.Home ([39.45.181.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-425787f37casm34202085e9.1.2024.06.30.10.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 10:36:36 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH v2] Updating a vulnerable use of strcpy.
Date: Sun, 30 Jun 2024 22:35:10 +0500
Message-Id: <20240630173510.9481-1-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing strcpy with strscpy and memory bound the copy.

Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/acpi_video.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 1fda30388297..6113baffd53f 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1128,8 +1128,8 @@ static int acpi_video_bus_get_one_device(struct acpi_device *device, void *arg)
 		return -ENOMEM;
 	}
 
-	strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
+	strscpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME, strlen(ACPI_VIDEO_DEVICE_NAME));
+	strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS, strlen(ACPI_VIDEO_CLASS));
 
 	data->device_id = device_id;
 	data->video = video;
@@ -2010,8 +2010,8 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	}
 
 	video->device = device;
-	strcpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
-	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
+	strscpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME, strlen(ACPI_VIDEO_BUS_NAME));
+	strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS, strlen(ACPI_VIDEO_CLASS));
 	device->driver_data = video;
 
 	acpi_video_bus_find_cap(video);
-- 
2.34.1


