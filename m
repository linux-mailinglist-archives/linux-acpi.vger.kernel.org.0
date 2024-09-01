Return-Path: <linux-acpi+bounces-8059-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC06967BE3
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 21:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBCFB214F6
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 19:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24F5537FF;
	Sun,  1 Sep 2024 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQVPxUsD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE546F2EA;
	Sun,  1 Sep 2024 19:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725218113; cv=none; b=AlTEjgYEUXRG5OJGIPLlQrBTRKI4N4X+Pcqb/pR79Wk78ZG5r1IAwtDiZgGsLSl6AcqfjLq7RsWFsboymqzqWJpj13qGyi9l1l1UBmUzMqjyYPMaVf6TtVuFGoUHb8uWu0K1gim7FDN90BMb6SqkVEEY8XFiX04nwOyN0j//cYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725218113; c=relaxed/simple;
	bh=+qfJw1DSQU87+Rsqvosf3PH4tbdVDaKcL2ea402s3Jo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GEz9l5J5yZ8B6+eEBsOKNxuRrzexGEAz8Lxom3Dlv8lmhk/SR13Q6nTvtzF/8nWnBDPMnr+LMaPQmuO94T89PEJ8FFT9C3Ff4EijkhXSZ008yxGK9h5M0Ee6AbFKonmTrAviabmFYuAVjsHs8d6NSQHGVvl8KIvq7PPsZeB/rLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQVPxUsD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bbc70caa4so19438175e9.0;
        Sun, 01 Sep 2024 12:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725218110; x=1725822910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIvOM+3Ea3JTsKoS99LUD0McsrINcC5NvVi721+L7d0=;
        b=NQVPxUsDBXQ04ZllwvM85BuH2cLKdrYtbQ+dMGEfdh0ldlMVbxmXvprsprnfVafxwC
         YWqTAH8/t0ZdkRMJ9GherU4YPDmYn9Zr8SPjdiQr/bQUFysJ/uHNPK2Rdzqf8kQjHn/x
         yAMZyfG/FmZwilblsUndr1OvXcaRijYKCuYDikXuVTD7zjA1kS11lNLVgJ+pw/L5rLSe
         TL1AfgM8fkpSg8K5DXUXYLmPQZXFa8RLTyn5EgZmwvb7IQ3dzT7lJVKN2MKslv9eE6Xt
         L7tLd1V9MCoyfFh9S6Y5aQCdao95lrvM1h2w3FvjuHtmR/zpZn/sWyry0d+TMA8AqtQk
         Khcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725218110; x=1725822910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIvOM+3Ea3JTsKoS99LUD0McsrINcC5NvVi721+L7d0=;
        b=FnP0p+gpxiChzZxazuLygjrcgTie9C9O1vh+ci0QbAGWIB5L4G+zPzubfCZSinz+jM
         TZikU39hEoIaDFuHhHocn0a4Owp6KfoCLjupIu6qNgjhObD9tkjlyBVVid8KH3eBKbFF
         cQPmQ65SobHQM82gsX3wrmhz3i25ykzoL4O6MOcqkG4cZr1O7ZuU8OCHuHF3r3BBTdo4
         9f1G3Lnfn19GjyRliuRn58hBXeVw2TZTP6B+601RpgGV2GsScR1B+efbL2s/iKLPpH4+
         mxbLL0B6UhoYwYg/u3Ze7fXZrwU7Ey/wSGDJ2ZZ79SJQinzL5iNKjc5EgHnvVCy2qpHo
         zlaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR1Ic+oZ2VanK4wf9oPpWRflOZw7+IdmpCF9p7xhAZCyaXiw97N97f734OqnocUO/r6jqIOcf2zxcS@vger.kernel.org, AJvYcCWRzyfDbKkiCCyQuhh0Nze5c4tpGd/m4+whKoaEgY228lrjqJBJfde5PVMxJYc8b0fZJxn+4o6P2ok7DO2t@vger.kernel.org
X-Gm-Message-State: AOJu0YzSJdFmu7HNQ2aqIb5v4ZSmqloSW/UYae7VKwWUgfMOgyl9qxSK
	g07Aw0FK+UuB1fCGLot2si061W0WtDE4hdU1zKQ87fFtVMWnxIpw+gKAZHuk
X-Google-Smtp-Source: AGHT+IET8id7t5c5uC/5laJ2QyAvkvcr4Agu6zeeyPezHPxUC9Wr/WP02kksM7s5Q6hF4Hd5oQy9lQ==
X-Received: by 2002:a05:600c:1d89:b0:427:fa39:b0db with SMTP id 5b1f17b1804b1-42bb01e5bffmr94967795e9.27.1725218110018;
        Sun, 01 Sep 2024 12:15:10 -0700 (PDT)
Received: from qamajeed.Home ([39.45.200.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c61a7f03sm2530455f8f.55.2024.09.01.12.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 12:15:09 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH] ACPI: button: Use strscpy instead of strcpy.
Date: Mon,  2 Sep 2024 00:14:09 +0500
Message-Id: <20240901191408.419465-1-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240804123313>
References: <20240804123313>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strcpy() with strscpy() in the ACPI button driver.

strcpy() has been deprecated because it is generally unsafe, so help to
eliminate it from the kernel source.

Link: https://github.com/KSPP/linux/issues/88

Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>


<This is more than advertised in the changelog>
The patch has been updated.
---
 drivers/acpi/button.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index cc61020756be..51470208e6da 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -547,20 +547,20 @@ static int acpi_button_add(struct acpi_device *device)
 	    !strcmp(hid, ACPI_BUTTON_HID_POWERF)) {
 		button->type = ACPI_BUTTON_TYPE_POWER;
 		handler = acpi_button_notify;
-		strcpy(name, ACPI_BUTTON_DEVICE_NAME_POWER);
+		strscpy(name, ACPI_BUTTON_DEVICE_NAME_POWER, MAX_ACPI_DEVICE_NAME_LEN);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_POWER);
 	} else if (!strcmp(hid, ACPI_BUTTON_HID_SLEEP) ||
 		   !strcmp(hid, ACPI_BUTTON_HID_SLEEPF)) {
 		button->type = ACPI_BUTTON_TYPE_SLEEP;
 		handler = acpi_button_notify;
-		strcpy(name, ACPI_BUTTON_DEVICE_NAME_SLEEP);
+		strscpy(name, ACPI_BUTTON_DEVICE_NAME_SLEEP, MAX_ACPI_DEVICE_NAME_LEN);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_SLEEP);
 	} else if (!strcmp(hid, ACPI_BUTTON_HID_LID)) {
 		button->type = ACPI_BUTTON_TYPE_LID;
 		handler = acpi_lid_notify;
-		strcpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
+		strscpy(name, ACPI_BUTTON_DEVICE_NAME_LID, MAX_ACPI_DEVICE_NAME_LEN);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
 		input->open = acpi_lid_input_open;
-- 
2.34.1


