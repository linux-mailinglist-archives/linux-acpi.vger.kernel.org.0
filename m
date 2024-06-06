Return-Path: <linux-acpi+bounces-6242-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13618FF500
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 20:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81C61C26EC4
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 18:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F7A4E1DD;
	Thu,  6 Jun 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="W3+7CrDF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E944E1CA
	for <linux-acpi@vger.kernel.org>; Thu,  6 Jun 2024 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717700010; cv=none; b=mmJc3vRi8tH8quVyuwKfgnwDD09yyYp5j1He/JQCl7KdQMgDG9cBoPW0V8equmXFLoIewBFK6HHWND3fuHRyiU0CSEzfYt6VB+led/hWHgtsLzAozCDdsT2MaxFXiT+JzC1elcg/+NjH0bn5TuBa4AU+bxbrs8tEADeoLIoXpFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717700010; c=relaxed/simple;
	bh=om1n47XePQtjI/lLgidIuMniQGl6BwDPK4rXrD+4YZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sFHlq5BEGqD32vp36B2bSgfHuRDGrqel4NNgau6yUnkEXqf3FIJMqwO0w5RTeQ3YRM0zAHXab4AW0D6/cUO0FAQO7wwtjrhC130ngTKCzA4gxe2j6N8ENyDvhkTr8v1RcUM1OST379Ktjrwdu74DoP0MKNIA4CNvRbq9di13a+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=W3+7CrDF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a68b5f18fc5so158041366b.1
        for <linux-acpi@vger.kernel.org>; Thu, 06 Jun 2024 11:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717700007; x=1718304807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zeGjTLLISyTtH1AgP/c8JS96JX38uoEOXIRqVTS6/9M=;
        b=W3+7CrDFBe+WIVTUDyjqaVB2cREbIijKrf1Kd5fReNBbsvxx0cW3FU6Fiv9HJv3PRW
         2E7ZTFBdt/LXGWc23rUhnvCXDUVRKIHUeK3xmJnQiVAx0OnaKAP6XY7179k9RvXSLGjS
         ToY+xGgMlF4BgNoTXf82jitUAjzIQAggp+bFD8L5drqExRN5ajuM0cDJSAIZ7UHBmN96
         uNcGjI2Fi9NVjoJ+zpmzfd7ikq+0alik9RMyQ5Z4vU910pUHjOgXP8wI7lS1Si4Wecqz
         AAr3tsO7U02ALhzmOrp3C9nSWA+8nF6ggrJ162GamfcnowyBy9a+IWK5cdnDHlHgFMN7
         lJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717700007; x=1718304807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeGjTLLISyTtH1AgP/c8JS96JX38uoEOXIRqVTS6/9M=;
        b=mCAzP8tg2ELaC1KbUlitPSEeZJK8J+UvX0TwjOVVYqhHqqiRkpj6Nny+Vde3jSwwLp
         0ZWOpgnTTWcsjtOfmEQ1Oek2cENuKI+jCG4bfN+qh3f7Hv9/XcewcRoH4WbNHozBlrY+
         4EVUbM5zWuxd/9TtbROFoouwpLXZbOkSuKbe/9TjkCaeOJh91Y4Kok27VAEgiIEMgtiT
         tmXGpCmgo05FsMgtujuiqdNAtb4ez3Fmr0mIQmsWyjNEIyFGeQnf3qjmuxQsHYPkfYJ/
         SVAFO6tYE4AZXkAxYajbuK2lcQ7k3qEAJmJ+gsXfdxeymuRZfuWMFi8xlbMqa9GRfs0V
         KMjA==
X-Gm-Message-State: AOJu0YzFxLjtsVzCBCrYpWimOZ9mm8pqR05qmTmOuAuX5KnXwlTmczWE
	XioxVS4OrKIUNt5V9CTuLsB+N0FJSUXEoWBnJ2HbgYx9IPVebcTCee8IJyjItic=
X-Google-Smtp-Source: AGHT+IEx6zqhhAPgHVJ3Am/Pmt3iRNX4TeauA1h0PfHvUlHWCZBgHIV+NRaAEiIgeUrw/R2X5rdpRA==
X-Received: by 2002:a17:906:4816:b0:a59:bdb7:73e8 with SMTP id a640c23a62f3a-a6cdad238d1mr28297666b.53.1717700006767;
        Thu, 06 Jun 2024 11:53:26 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-164.dynamic.mnet-online.de. [82.135.80.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806ea19esm130890066b.128.2024.06.06.11.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 11:53:25 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] ACPI/NUMA: Consolidate header includes
Date: Thu,  6 Jun 2024 20:52:02 +0200
Message-ID: <20240606185200.1596-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header file acpi/acpi_numa.h is included whether CONFIG_ACPI is
defined or not.

Include it only once before the #ifdef/#else/#endif preprocessor
directives and fix the following make includecheck warning:

	acpi/acpi_numa.h is included more than once

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 include/linux/acpi.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 28c3fb2bef0d..bb18e7bf8826 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -24,6 +24,7 @@ struct irq_domain_ops;
 #define _LINUX
 #endif
 #include <acpi/acpi.h>
+#include <acpi/acpi_numa.h>
 
 #ifdef	CONFIG_ACPI
 
@@ -35,7 +36,6 @@ struct irq_domain_ops;
 
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
-#include <acpi/acpi_numa.h>
 #include <acpi/acpi_io.h>
 #include <asm/acpi.h>
 
@@ -777,8 +777,6 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 #define acpi_dev_uid_match(adev, uid2)			(adev && false)
 #define acpi_dev_hid_uid_match(adev, hid2, uid2)	(adev && false)
 
-#include <acpi/acpi_numa.h>
-
 struct fwnode_handle;
 
 static inline bool acpi_dev_found(const char *hid)
-- 
2.45.2


