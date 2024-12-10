Return-Path: <linux-acpi+bounces-10052-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2A69EBA75
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 20:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3F81677BB
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 19:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBEE22ACC9;
	Tue, 10 Dec 2024 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f2U1IB2M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00322A1E3
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860586; cv=none; b=VOxGQ0R1lKG8SIm831q8ftKQIzMM89X548skXOC7MQiisnerQPzqd5LnIbqpMv3N3ieAmE/o1xFe/gNxZzjFzK8SQa4J8pfxnKbpIkjXbR8DmElfhTYQIns8JhdUXxuqTGiuTAs0M0fYdRXMfD1iP3bGGP/7NQBiQ5T9aV0CfbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860586; c=relaxed/simple;
	bh=YpVt1IJK5kIz3EzNG0TljucOUwJ/2fX8gxiI1v679o0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=paKLQ9vWEReSw0lioUWpbZnYEszgDHChfLVNLYhSQ1mT08ZA1X6c8QMoID0MoRiLSw+5yjx9fKDIgNslGpdTAxQsy6Y5cuALTuD6zt1bgOb8eYfiwPvtVXJGAgvZzYyNl+Mp470XX60z4bxvysyRdglmQhaApGGtMIVoxpmMCnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f2U1IB2M; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-85c5d4f3d58so659774241.3
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 11:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860584; x=1734465384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wo4Brw2DCcVsJ26CFqfG+Q/anJpN5TVrr8Upgev/TjM=;
        b=f2U1IB2MM4pHGi6h3UpxH8PSKZ6clBOZPiOblYq05btEOJIzc9916Snj4+Jp3OQrHc
         UbvDG3LfFc3Z0BRlooNqPPrd4cnYfDF0JLbzINax0Rxoefm2NTjD8j7ZpsZLAoOOXaJd
         dfX8rHqUmXbJYJfP4XmDlydxxCMXboiPEZPAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860584; x=1734465384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wo4Brw2DCcVsJ26CFqfG+Q/anJpN5TVrr8Upgev/TjM=;
        b=X1z9GWb2VXFjuCdfbyVAyHdNBUizKBGfkrcvwq0HZO5lC4+f1T7+ivsyGfLV2n6FkE
         NqsirIBch75LeK5dMm/qh6ds7mEx19DcszYSDnL0BkqPSsvW0/6JUevDqEZ2P51zJ9aq
         Ce13wCpWOXjpupHiqXMHyfxgvoNCGC/b8tozejbiXTSLUWb1H7LARpxcYGW692Z9EHB8
         F+lW14NXoG5kdP9yN20HuLZ6RvZzwExg4QXMym4yci838gM8kkd3La7iv8lxXzAlIgqq
         04lbDhDKidwCq4IA1K14nAFaEPd4TZZbPlmNqpvpr5TxuqBKDwxmp0wihhNQRYFOZZii
         l56w==
X-Forwarded-Encrypted: i=1; AJvYcCUuNpyh38JbkoKEKwOjruhn4NBHZyypNECMfy2hUnKQ8KDfkf9nWjWpyv26lev+2SllFxzLQ9tmFf/L@vger.kernel.org
X-Gm-Message-State: AOJu0YzOhynyf0mfBV+C+NlcLU6cLw0sGXPelwOWiKis3Fh9W3EN6of+
	AJnFr38QidxuUuBsId4ihxQIy14zVns7gU2UH15SaNN0MppB7RvS37P9nTsY+A==
X-Gm-Gg: ASbGnctmRyv/GaasOw/TGHjQSyp6ZKob56u7AVbY9QnmUJw79GX371CH5mP6uacQtDR
	8cEJNLTL8NRlCboaBQf2f91GXfSATNwBn6dqMRi9t7bTyyvCta+P2PcKB6mKP8OEYlKWB7k5IfO
	MjtSHUpFmKKx4JisaJMYY7CqLIjV1jhk4b/644IK8ErhOFG+if4TbOWnyzovMhlo96/Jqdi+H1c
	KqxFoqUwOl9ItyJXxK6+krjxQwTFOX6C3dQOl0Lp7+A6Y9WWBwtP9pB2b/AdQV3OTJfGyhqsXp+
	4qpa4ifgtmHBh4A0N4ki4ZTOnwPf
X-Google-Smtp-Source: AGHT+IEmzXYFoUfqOj/dIppTnK2q1X3UMKlfoOVpixdTmMHqeSiokiuDcOibXmJMwEkU4cB2noY0sQ==
X-Received: by 2002:a05:6102:5092:b0:4af:bef2:c8df with SMTP id ada2fe7eead31-4b1290d6f1fmr862642137.17.1733860584010;
        Tue, 10 Dec 2024 11:56:24 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:22 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 19:56:03 +0000
Subject: [PATCH v3 6/7] ACPI: bus: implement acpi_device_hid when !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-fix-ipu-v3-6-00e409c84a6c@chromium.org>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
In-Reply-To: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Provide an implementation of acpi_device_hid that can be used when
CONFIG_ACPI is not set.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 4f1b3a6f107b..c25914a152ee 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1003,6 +1003,11 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+static inline const char *acpi_device_hid(struct acpi_device *device)
+{
+	return "";
+}
+
 static inline acpi_status
 acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
 {

-- 
2.47.0.338.g60cca15819-goog


