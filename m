Return-Path: <linux-acpi+bounces-7260-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DBD946EAC
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Aug 2024 14:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94AAF281A2E
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Aug 2024 12:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BD23218B;
	Sun,  4 Aug 2024 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDzxx7bn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6183980B;
	Sun,  4 Aug 2024 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722774860; cv=none; b=JNHrZoIOJmg5SK2c7SZTzpkmWijtMpbnX7YQQSR03Ymetic/sL2el5LOLaWjTlySGvIb+Zg3lK6KrVmAjpP5FDwKVfAm6n16xsZ5AquzKf3bf1bH5dWk+8L4nNlmCYQ8EWPQXB0NKUD5ET+AvIvikfld3Kw2aGraWKnpeoVHK60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722774860; c=relaxed/simple;
	bh=qKrV7gMBJYdctQasGKyPGOySWCilXjwbToZF2hb5yfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cxr0xrvjs/Rgx1+ITliJw+jgrz2lyEFzulqP5D7JT+LrYxgW6cBU7eSD/wcEfyvDUEjmGDI2tVr6Eh0ZiVug1oqOyM4vi2msAB+DpaSpNiGITed6EG/ALk1qpmd6SsfDUHrbWNeHNwL10Avzm7SsVjXq01iTV3i+ciunexz6814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDzxx7bn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42816ca782dso64565905e9.2;
        Sun, 04 Aug 2024 05:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722774857; x=1723379657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fma4zyxhIgdDMLW4SBzIssnydwDrG667PvqCwFWkyjI=;
        b=kDzxx7bnA8ebI2YZWRBE0tf3X5LPstIr9n6zRBADGUYCbbTM6HeB7j8ylkrLNNZss4
         Fa4iwFZR4qFwH2B5yA+u+ql8R4iHcqkjp3AtFm297YR7qc93Gypg5GTcvhD1BfbbiPQl
         BY0i+C126FKQeJhO46IoQ4x2boo2IDeUfDmRri0vH0AYilLLquXDYgTHrp/CMZV0tPbo
         WAcDv/8XJxtRLMeKKz5WClKLGmTc1eUem9BM0MDFSFKeIzLGEyEzZovS1ZIyJVraEtPO
         JH/EQ4sDocsv2jLE5gNLLPjmAkMtHqxnXhiB29lQjlWkudS5pamQj3CwjWe24Bkt+Cxf
         b+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722774857; x=1723379657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fma4zyxhIgdDMLW4SBzIssnydwDrG667PvqCwFWkyjI=;
        b=T3ChvaHPnuT8f6xX9iCOhgUYyzLoNhn9xc3vOAdgoy2cw9ZHOx+P7efqao7M9AZM6z
         rp2SpZ+RMrXdfzvFTqztTxc+0Muo3tW5V3qlOKJBo0JZOrIAk30E5lXUw1pSlU2NhNjU
         axlbAO+U6OgwB6cbsdqHWYuoxg0dX2eGifQhsgh3AMS2Bs86X5OT2tA//bK7LSe9VKkn
         /uzImz7ahXKXYdshPjdVk//wJMYykLFxpfThGDuIQHYAG7QS7J4sHIeIuH5EDZIqUCiQ
         /FjPr96RWb0Q+lMtiQf/700b2qahkIbPPg+ilj5uJDOvpEZnUdQK+kFE065KYa/DZnT4
         h5rw==
X-Forwarded-Encrypted: i=1; AJvYcCVB2TPHoK936pI2V5PR/Cwx+3A9v/eisoxgtqdjIKmD+OGtIxD8eC9I6LjREArNxh24iFYOwuChU0jyC6bFd7YGzfWpSKu0qpoWuX9S6Loq5M1LaeWwvNVtyBIOFeFot3SeO7j5lGZLsQ==
X-Gm-Message-State: AOJu0Yz0mwqJb5Y2OxiiyCI7mChQKwwBwBcbZgPtzyPTv+Z8nqCRh0SD
	CZ2DufobwziurTtxzRQynP1ipFsgOPtSRlUXOi9N2pTQuLzonKtm
X-Google-Smtp-Source: AGHT+IHTZ9obbVnBYeOOZXkEHxu4lhjAf6KVmLWiieaUMPqYkGv9pryQnxIOCyzxoVj+0nXSKRW55w==
X-Received: by 2002:a05:600c:3c82:b0:426:6220:cb57 with SMTP id 5b1f17b1804b1-428e6b7c53bmr51782105e9.25.1722774856774;
        Sun, 04 Aug 2024 05:34:16 -0700 (PDT)
Received: from qamajeed.Home ([39.45.131.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e88f833asm92848145e9.47.2024.08.04.05.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 05:34:16 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH v2 2/6] ACPI: acpi_pad: Use strscpy instead of strcpy.
Date: Sun,  4 Aug 2024 17:33:09 +0500
Message-Id: <20240804123313.16211-2-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240804123313.16211-1-qasim.majeed20@gmail.com>
References: <20240804123313.16211-1-qasim.majeed20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strcpy() with strscpy() in the ACPI acpi_pad driver.
strcpy() has been deprecated because it is generally unsafe, so help to
eliminate it from the kernel source.

Link: https://github.com/KSPP/linux/issues/88

Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/acpi_pad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index bd1ad07f0290..e49f89bbeacf 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -417,8 +417,8 @@ static int acpi_pad_probe(struct platform_device *pdev)
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	acpi_status status;
 
-	strcpy(acpi_device_name(adev), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
-	strcpy(acpi_device_class(adev), ACPI_PROCESSOR_AGGREGATOR_CLASS);
+	strscpy(acpi_device_name(adev), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
+	strscpy(acpi_device_class(adev), ACPI_PROCESSOR_AGGREGATOR_CLASS);
 
 	status = acpi_install_notify_handler(adev->handle,
 		ACPI_DEVICE_NOTIFY, acpi_pad_notify, adev);
-- 
2.34.1


