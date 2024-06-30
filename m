Return-Path: <linux-acpi+bounces-6680-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E30091D1A8
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jun 2024 14:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2AA41C20AAD
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jun 2024 12:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4937013C3E6;
	Sun, 30 Jun 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0O3ir7O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86781E535;
	Sun, 30 Jun 2024 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719751767; cv=none; b=Xg0qFHuwRGWNDfVLOBAAoVcEmFe7IfOpZth6iRVgsQSRQjgHv3OJF49mB1tT1x2UtlXmXNPwYqgRd9aUAuz1fdULPToSRB5dAd362+s3O2JIuV9O/9ULFv74BJxGx0PrOYWgvMqep3Y30V6kmnE/KUg35zOOZsZeBGd7rR0Ejz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719751767; c=relaxed/simple;
	bh=a9O/NzgMe8+fDWtOKPMlEACFmvGKExpbZLnMk8fchX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lTOWYBurfa0EK/qWojiUNFLww2sCUa6gfmsWyIcjJT+jn3b/HPOvsigEsbJ9o4ER4sLWfcY3Rq+67yLN4UnL9tWj1iXHvJOY6iQwrl0ABimNk9fk1yIyVU6D2ivWTwMcCbRSG30qSFXHnAa2Wp4YOtkPEr5rg83M/OPY/WomoNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0O3ir7O; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42564a0d3ceso13491315e9.0;
        Sun, 30 Jun 2024 05:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719751764; x=1720356564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tg5zNNEzFCoSVGWs3dv8lzrslyjqsfj67eSpfY5+Gsc=;
        b=J0O3ir7O716oOagJt4U4Rpz8fNcMoT8WoIQMFy0LsQInK8/63M8bxGtYFLU+93UZRF
         PDwm0jZIzQ8snn2JGP5c5hSgx+8rr89/R1QrSB44n6Z8xuHhhhyYYctxnpKn53Mv5Qrh
         vPeB2kbRUz3PpxutHYHhROB1dj+9KR5W/I6aY+5vRzRMs7XGRXu6fjOaQzk1BN7Ax/5m
         8w/EyRtmQLevJ/REnmnIxG0mYol86X7Y965d0v9e1fwDXmu2HNABwcoeowZiC6BLxDXj
         kq8qfVBPdsSuQKGLbUxXGC03WsKxtBDS4/5sOhTNJtSDUMsEnvq2OelE8zVHfBAE41vt
         5E/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719751764; x=1720356564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tg5zNNEzFCoSVGWs3dv8lzrslyjqsfj67eSpfY5+Gsc=;
        b=UEDherPfoexamCRXiWAeDRIrkCoRulpjlcJcrWfKwcZKVSEQrzrb7L8wuM6qWNXG3q
         zAmK7yqWu1WMh69cZ7QGrD7hHWdyTmQFUOWcXOCvBmK63oOlvbhlcDXUWL6lx3nCsuDa
         xuD0/Sr1gZ5Hs5n2czo6wAaDvHl3fJje5uxgiTAPR/sSTig3qhg4UKnA1peASB+ImjFR
         oPN3DP39ULmKfg2aFynvzVnOTpRJSggSYFYNVuv86GeHZmJcULDTcZumYJJodMew+SSH
         5GiifgTxRu8KXWmMzhzm5yTPdE7/BsQ9ZnyCoU/oV66AY5CXi2EFh40PwubzITr9A1g6
         Rh6w==
X-Forwarded-Encrypted: i=1; AJvYcCVcWqNLuCG0k3f1uzpIbxYCUaCiPeTQyKzyI5ihd25W1XzfNK6z5ugKjfM0XSu0Kf99wu8Y5vMlsmaCj3DE7NZ98g8rxr8uuElj4SZdgk3Dhi7EJ9yrJRoXJ55j2JZDtLSJ5jlulxo20Q==
X-Gm-Message-State: AOJu0Yyl42IY68fU5etDEQu7mfzG/9gCi0pIrOkE2Gt2NdxHkdsJM+2d
	HlkXgfWot07Av4g4LvewfY2uOSRr5m1hF8FjW0KTQcBxVLW5pAGA
X-Google-Smtp-Source: AGHT+IE+vPZwRbkYpYEM7vADTRG1SV+oBbAzMmcCt28aKRwgND0NVkVoELN8evaf0L1tyHCz8L3Z5A==
X-Received: by 2002:a05:600c:63c8:b0:424:a48a:99ff with SMTP id 5b1f17b1804b1-4257a0257cemr19983065e9.8.1719751763580;
        Sun, 30 Jun 2024 05:49:23 -0700 (PDT)
Received: from qamajeed.Home ([39.45.181.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b097bd6sm112411665e9.30.2024.06.30.05.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 05:49:23 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH] Updating a vulnerable use of strcpy.
Date: Sun, 30 Jun 2024 17:48:29 +0500
Message-Id: <20240630124829.189869-1-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing strcpy with strscpy with memory bound.

Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/acpi_video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 1fda30388297..700f0e8fdba2 100644
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
-- 
2.34.1


