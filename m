Return-Path: <linux-acpi+bounces-8304-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F54979828
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 20:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682941C20A7E
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 18:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2585D1CB31D;
	Sun, 15 Sep 2024 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpJSiQdH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADC31CB305;
	Sun, 15 Sep 2024 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726425557; cv=none; b=UF5hRYe5bj15iM5aCNBLfYzYLkjTO/PKqGdpEOTBWudoMtZP2AYgAaOrxtDuR8RGlF9kRFlt0pKJRjwYMt0EcetDDtswreVHBodbApA1ksw0pxqqCCs6Haj2go7WW6NRXztotjoLuP2MPJv6ZETxUPBMNla5SJW0HGSKGfaqoUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726425557; c=relaxed/simple;
	bh=vsw4VlosWx3TOjVGtEP+SF0UkVD2Ut0zdhdnxz1BVuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeuNqXe4gWj8nS9+P3GHe9m/qjm9UxatnodSYWHr0zY/gUK5ZpYVHxqLB7Zub3qFdvER1R6W4lGpC/+8dRmQG1jQvOj0q+D1gqJcwmovJ5872fRTrqljP3PHc2u5yPeSwlrbxMHrIcs4bLeo29+g0JnkO1xQm0IsysJHnl0ew/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpJSiQdH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374c5bab490so3188741f8f.1;
        Sun, 15 Sep 2024 11:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726425554; x=1727030354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omNSK/K1b/yVIWDRt5RBipClGzi9V4Xr720SCbqQvCY=;
        b=CpJSiQdHwoYO5R1V2JDHOBJsn+Nzn8s4p+8aPy5xiSOCl6FGj9q79A91XhYpkyA8Gm
         0A0U3ARqXfhf27LSN3y8q6DROFwzvvgTTGzS3R5p3HoB/JlMHX3NNRtRc1K5Cnu7Ltne
         faVXF10TqoqO5wQUPeM6fRFh8TUKMOWte/oBJdOVglzw54yroW+uWOU3OPXN56tOzulI
         jpF1XrzopuRa1XZKAI3R+6sNhHvzeRmYXm1Lhdy27CO7rSYk8vleyGc8VkJU6rClrnyJ
         ENBtzBwjaXVmyRg5hgUCtYa9LrhaE/ovSl2cQLseZ/i7W1mACba1aWK5r3CHs7niKo3g
         79iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726425554; x=1727030354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omNSK/K1b/yVIWDRt5RBipClGzi9V4Xr720SCbqQvCY=;
        b=Qd3/llqieCrGTCoidDZJPNUfLCTP6674FzmNb79yhTLhE5fnTQVN8nccXvv1mq/liM
         y1g1f+GYAXZpEUCKZGEa8TGYveY9a9Ylj0dD5vbwFdQmGuOn/ceZFzeRLhZ+nnB6XMBO
         7KG4TaJFbrShUqTrEM/bmpVSvnlrBdx69Vg+zPDaXMdXf26Kaalk/IaygV/Ze8aST4jy
         CmkUjjBjk3Go5rIZpDY661LeglM+1rQW9u9+IFsxUvotK+IvgI6sQx+3/le3CzdKu4g9
         FSianCCO8Rjh9O87mRyqp38vJpQ0835/z8Zf+AfBKqGx7bZIjSd9Gl27XbOY6kq65AjY
         dKDw==
X-Forwarded-Encrypted: i=1; AJvYcCV+pufp9UPsXqltX9WUSrzZ6bON1wNUnNEGKCHjwCeuvwT78fqPTxTsyX7RDk99cHRoEta4xNVGNfscjKoP@vger.kernel.org, AJvYcCXF8wOt6Go9OKxlzG/6odvf9swzp3F3xomIvh45aqQVe4zilUKsXHbhmIU6xwb4LnIw7+r36gtgajSY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2BGuXybk0cG8s13s07h7yt9UBHar6h6CCtpcqk3GLLGen2LMO
	r1hbWFpzJnehLruIXpjjCSznDNboYe2flhDdoosNa5KzuXaS4dVB
X-Google-Smtp-Source: AGHT+IEdO325oEONbhdFkRchx2jRN8hMK93gNwFipthgutWHSGciUxIK52QSSf4Mtfuf+FgcBes1dw==
X-Received: by 2002:adf:fdc7:0:b0:374:bfd8:eeee with SMTP id ffacd0b85a97d-378c27a8612mr7616903f8f.10.1726425553644;
        Sun, 15 Sep 2024 11:39:13 -0700 (PDT)
Received: from qamajeed.Home ([39.45.198.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f2001sm5162357f8f.48.2024.09.15.11.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 11:39:13 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH 05/10] ACPI: pci_root: Use strscpy instead of strcpy.
Date: Sun, 15 Sep 2024 23:38:17 +0500
Message-ID: <20240915183822.34588-5-qasim.majeed20@gmail.com>
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

Replace strcpy() with strscpy() in the ACPI pci_root driver.

strcpy() has been deprecated because it is generally unsafe.
Eliminating it from the kernel source.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/pci_root.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d0bfb3706801..d0b6a024daae 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -689,8 +689,8 @@ static int acpi_pci_root_add(struct acpi_device *device,
 
 	root->device = device;
 	root->segment = segment & 0xFFFF;
-	strcpy(acpi_device_name(device), ACPI_PCI_ROOT_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
+	strscpy(acpi_device_name(device), ACPI_PCI_ROOT_DEVICE_NAME);
+	strscpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
 	device->driver_data = root;
 
 	if (hotadd && dmar_device_add(handle)) {
-- 
2.43.0


