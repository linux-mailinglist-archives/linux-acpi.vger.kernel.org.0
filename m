Return-Path: <linux-acpi+bounces-7261-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4C0946EAE
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Aug 2024 14:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D35D281B1B
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Aug 2024 12:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDBE3B79C;
	Sun,  4 Aug 2024 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYfnkNt6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBEC3BB47;
	Sun,  4 Aug 2024 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722774864; cv=none; b=gI9yTZWHlL3gj1bMjF1RgNBIESM7ZXcUUj0ctoKMeRrhJ42Qx6h3vAVKFJgRi2Dtb0VufrG71L925QiPFKsMx/mPrLsTCMkcIL4BSmTd0hgtvPhXikcU37pUijIVUK3ZwypYsOYlWDokvYBTRACvo/m4Ry4LAxgaQuWDuY+hNE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722774864; c=relaxed/simple;
	bh=N+ucF3kD6h2ejO88EwEDCCGNA0WUdAxEbTxcjhQVl8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rURvZi2kHsA65w5DGJa3dlW/nT8S1eRxyBflvqu8ZuiZmEOFqX8RCu6xHD7ecnZSqNNQ9EwfCB+EDd+1NMC5qL1JZR5xAMGOUOEoroLrxnOjt5jPAFIBqAcfxAzcuAwpiCGKEA0IiL61WdmBd98kC9kgGqbxfJ6X1jjmg7KD8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYfnkNt6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-426526d30aaso64095495e9.0;
        Sun, 04 Aug 2024 05:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722774861; x=1723379661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdlZpOag27f0gMB82jj2VY18Tsb1Bo/ztoizSX32Pcc=;
        b=HYfnkNt6UrxQlgYUiIaMnQXZpL8AIB2uEQJOdHPo8kIiyJcqEG3VFljRw4gWXAo2qB
         EcvOE2100/QldlSdfHNeg/7jyQj/xWPZcZP5ignarqK4eNhGydlc6IRQ5DqpeDuUm/6P
         +vtO/vs8hHw9zqDCO2Jx40BjRPwKveqF8gvEOXh6uRBbtABwmDUC5jjzhHHpbMtpgRoz
         NwYHNwK1Xajrh6XrxcG5JISi7JaeKzp33i12XJaq6yDrxwYjImBAcGKu7zayoohbHhxs
         TodtEVfYe2D6p5mDtpwY7P4LrQLZSmDdZ7inb3TW9Uv8Fz5LTNbOBSjxjOi2pDJkmpQH
         bqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722774861; x=1723379661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdlZpOag27f0gMB82jj2VY18Tsb1Bo/ztoizSX32Pcc=;
        b=Ba9XsHo0fraHIDxcKyZ6BX+Ifz2UslSrWYguU/48IZIpUTJe9gasHCBz9YHRYAgVoX
         9hNf0ThrJ7Me488xzxVIkPUKDEc+3EExlnN4UMGPmZOitn0avibaKOF7nJ2DW/WL+wxF
         j+pnnt/SG+4YfWh2yiYpic+C7qPB8MKuYqb1oXkj3RB0uMd4l0c2L+gmwMFtF/S60sEv
         OvudnJdv8QWtfwGMdDmNqM8oXe4di83YueJeCnxxf0o6vUkquUtGhUJCbsjVlRHPRVOn
         ViGevTmkc5JO6GZJeBjj35HianukhxMcEcJyzx4ZAkmV248jJhZNM0hfoFrZDkJb5XJE
         qWTw==
X-Forwarded-Encrypted: i=1; AJvYcCW7rbAsdUpJZV8TyHbrP2nIhElajrxFFXYG2/7HGLhllJcFnGhasEgpNziL0pUAEk2deCsspaDBewOD2eacIGihdKbfeM36XXjfbrV6qpWU6jwqCSTMhOowDMa8NMRP8DwQlcZOY6muyw==
X-Gm-Message-State: AOJu0Ywohml7u5LQB/fwRfbR8L6BACb/0O670WcWYCarI3iIrUxottbs
	oZ/z9vcow8L7cngQuWZ6vFIdNnWvCXrOv+yVJX/7yymk/nOdn8nT2oErkYoO
X-Google-Smtp-Source: AGHT+IGwYB276FSsAH7KK/f1NzmK2qi/ac7oWkLJ+FAbU7mC5RPSlglmSoThm6zdsD+8mRlLVVkiTw==
X-Received: by 2002:a05:600c:35c2:b0:427:9dad:17df with SMTP id 5b1f17b1804b1-428e6b07b0dmr54482985e9.12.1722774860906;
        Sun, 04 Aug 2024 05:34:20 -0700 (PDT)
Received: from qamajeed.Home ([39.45.131.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e88f833asm92848145e9.47.2024.08.04.05.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 05:34:20 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH v2 3/6] ACPI: acpi_processor: Use strscpy instead of strcpy.
Date: Sun,  4 Aug 2024 17:33:10 +0500
Message-Id: <20240804123313.16211-3-qasim.majeed20@gmail.com>
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

Replace strcpy() with strscpy() in the ACPI acpi_processor driver.
strcpy() has been deprecated because it is generally unsafe, so help to
eliminate it from the kernel source.

Link: https://github.com/KSPP/linux/issues/88

Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/acpi_processor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 7a0dd35d62c9..8a8826a2242d 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -394,8 +394,8 @@ static int acpi_processor_add(struct acpi_device *device,
 	}
 
 	pr->handle = device->handle;
-	strcpy(acpi_device_name(device), ACPI_PROCESSOR_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_PROCESSOR_CLASS);
+	strscpy(acpi_device_name(device), ACPI_PROCESSOR_DEVICE_NAME);
+	strscpy(acpi_device_class(device), ACPI_PROCESSOR_CLASS);
 	device->driver_data = pr;
 
 	result = acpi_processor_get_info(device);
-- 
2.34.1


