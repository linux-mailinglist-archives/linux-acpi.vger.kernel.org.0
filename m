Return-Path: <linux-acpi+bounces-6743-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC729247CD
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 21:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0EA41C20DAF
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 19:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74B054657;
	Tue,  2 Jul 2024 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayTDMh5Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0644A1EB25;
	Tue,  2 Jul 2024 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947047; cv=none; b=XBw1wJOJZKcZlEJ7engeFw0S7fBJ5WSjtvWMVxnChUyieYQkN4eD08e8RAxilfVgIpkG1Dx1QvqKN7NN7VUnid4T5Wt8XEsAcsB1tkrXBP8F3N5f33+Qn6iIaahd44HDbXBBiF016vnv0+Cve/WLeYeiOIk6D4B/JMFlX6xaoqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947047; c=relaxed/simple;
	bh=72jQsOwZhtv7NmowAKLnAHDBjN6SnciL4Pl7yt/yJs0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iNOnIuINgpNkdaEYHmlDHmfyBh3Kz1GmULkAXOwmZR99GozfEPkdZ299rmGbzb1zCEwBVwxzex3qk1NneiKDxEhseySiabNengBNwz1aWIDYwI/YUWDU5Ik+HTCvE1A7KUKlmE294T2wd7RSvao+iYivJzFxOqTrwFmgrAFeshg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayTDMh5Y; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-424ad289912so32115845e9.2;
        Tue, 02 Jul 2024 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719947044; x=1720551844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4wKiM0LoVnSJlvFGJ4zMxAkn2aVFBxR/LJM4ELZBaDg=;
        b=ayTDMh5YNNX5QbXG7Rxey4KKXyx7bw1z4Q8P+TlVmvmG+HVHb7dvZ0oDImLVBorXor
         OUepvCQYb/tYzSoN4A8AL067bdp9zs/KHyWPXGT+D31sIFAbopsMzHoproBPpLXIgLsC
         HSc9xbN3ZZ5fYSFUWbx6NW5NnHU3GXBPMK17UXOs3hCvTvzNXP9KMgn2UrBPKysHIO+O
         1QGVNQS/vK36cYXRo7jCGSPdlUQ5kRHm6bYHFaPSX9Uxagj3z41OcIORJdGDInDZx0KZ
         uXoadjFCi0mEj7N8uiF85teTS/b+U4drAHzQhG2Bl9NvsmwBMwxJhjVoQKuD+8MzU6BK
         2FmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719947044; x=1720551844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wKiM0LoVnSJlvFGJ4zMxAkn2aVFBxR/LJM4ELZBaDg=;
        b=Jy378if44e7Bcu+8xcxOB/rNTrESeASGIOVfFXV4cxilriqeUsVmd2Z1LW0MSwm3sm
         FBSvDWj8C2wMV/tje7PTtfi4nG0JawsInJ6K5lytv9Vxy5Crfsd8oXb9syYptjncKySt
         B/WDNRUKtKhx0dXLJVhLQXKEgPy5wy0q26l9tq+buE+NV2riaPQ4tVedoQAqCmLVqB78
         vEm+HxhLMbk6NbUyfAdTk7ks2v6OGUVk8s7ZcHf4eksNsPqM5JfxzKyuBcwQeDRrpZeI
         +VrdqkY40ey+JJ+8LBuX4iYyLlpCcn7lKYqU8j+1KFEoYFls40iZXetviHEkvGkQgzfu
         29xg==
X-Forwarded-Encrypted: i=1; AJvYcCVB2aaZvBy0GEiaGGhVaKe+JfQH0SyDpspCSGcmWOFDViOWq5L00WTRC81ixx2FEkEf1iVDdfOK9Mw2GWOEY9D+m68nz9cw58GLBZaAyVtsEZoouFxHRBXQ2VxJdcPyAU20jz8WqQRiLQ==
X-Gm-Message-State: AOJu0Yy2UJyt6KrO3AxdMlp0q/so7dEnm6Qr0czgffUGc4r3PBN0HP58
	WeB43G+mw4FubQQBWjrJT10uX3kV1Bq+w0LB4RDrwIz7IePvN5m4
X-Google-Smtp-Source: AGHT+IEg7Ylb0a0AliUiVMF+rVgKJlQM5K3IpV+SBP/fB47GeoimS1/x+hfjjTAv03cj8BzLban4yA==
X-Received: by 2002:a5d:404f:0:b0:366:e1a6:3386 with SMTP id ffacd0b85a97d-3677571c5a7mr5535190f8f.44.1719947044099;
        Tue, 02 Jul 2024 12:04:04 -0700 (PDT)
Received: from qamajeed.Home ([39.45.181.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e169dsm13909412f8f.65.2024.07.02.12.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 12:04:03 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH v2] Updating a vulnerable use of strcpy.
Date: Tue,  2 Jul 2024 23:55:24 +0500
Message-Id: <20240702185523.17716-1-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing strcpy with strscpy and memory bound the copy. strcpy is a deprecated function. It should be removed from the kernel source.

Reference: https://github.com/KSPP/linux/issues/88

Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>

> In what way exactly is it vulnerable?
strcpy is a deprecated interface (reference: https://github.com/KSPP/linux/issues/88). It should be removed from kernel source.
It is reported as vulnerable in Enabling Linux in Safety Critical Applications (ELISA) builder.

> Why is a runtime check needed here if all of the sizes in question are known at compile time?
Runtime check has been replaced with compile time check.

---
v1 -> v2: Commit message has been updated and runtime check is replace with compile time check.

 drivers/acpi/acpi_video.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 1fda30388297..be8346a66374 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1128,8 +1128,8 @@ static int acpi_video_bus_get_one_device(struct acpi_device *device, void *arg)
 		return -ENOMEM;
 	}
 
-	strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
+	strscpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME, sizeof(ACPI_VIDEO_DEVICE_NAME));
+	strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS, sizeof(ACPI_VIDEO_CLASS));
 
 	data->device_id = device_id;
 	data->video = video;
@@ -2010,8 +2010,8 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	}
 
 	video->device = device;
-	strcpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
-	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
+	strscpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME, sizeof(ACPI_VIDEO_BUS_NAME));
+	strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS, sizeof(ACPI_VIDEO_CLASS));
 	device->driver_data = video;
 
 	acpi_video_bus_find_cap(video);
-- 
2.34.1


