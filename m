Return-Path: <linux-acpi+bounces-9738-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7B39D5C57
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 10:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E09B22BA7
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 09:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10391DED71;
	Fri, 22 Nov 2024 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Swx+cqMp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF17B1DE880
	for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2024 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268908; cv=none; b=IMX/MrHhavYZTM/XNNl1GydXIJVFYzdJiSPXnhgSdYP7215zlnGJAM4XNY1IbcgXBGosJM1kJJ3+YJJ3eQ96LJOiUg1p42JuHlSDXN+0lfkpHcRd5tNqEhg9EsiSzGPBPta5HzKIjCjzWByU8bPgg2MXpR1NL+qGvpXMIkYlvqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268908; c=relaxed/simple;
	bh=BYuLHzueav0sdSprQfzk88q4Y6f26g51RU20Q1WXi6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLM+ED/nBYTeCNWasWZ56BMjAK7QWn4GQDLSyr4Fcr7XQBeDyEG8b6b+cNdaulGfaPGVP8B8MNCRy/a8b0YYiZGdS7paZqi6r6/68wdtexA7UsrFWT3IS6zkQgY3R+BXNk3AzReitL791t/1+SfkOVZrAfCTcrRnSSFxTyKUByw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Swx+cqMp; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4613162181dso11148311cf.3
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2024 01:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268905; x=1732873705; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Acc8f5vjpjnUsttSTKqKG5ha9p9/8KASrkXH0sEj3iU=;
        b=Swx+cqMprFgLvaSl+WDnFWbXqyPb1COCP+tO98Oly3pcw1UZozCkYWVS6Lm4HkTodX
         olgFILbOfld5/PZpesnWfV6rDfOJh/U5TXIqY38hNUR2xA9Ev7fMhIwvbgzhkSYZF0dd
         0BrfQbG/NtOPfLf/s4ibj1f1jTKgBMEotrx6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268905; x=1732873705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Acc8f5vjpjnUsttSTKqKG5ha9p9/8KASrkXH0sEj3iU=;
        b=KR83ER3zehLQBfJMy8B6SRPtlcO83a9rZN9C9UWw81T8GuLHtUfVU8orCyQRwcPVlc
         mIdh3pemU4pWzLtdnxkT/Gs8j4k0DacVM/B1b5J+9i7QehLDBoHUwRx5mh0nmL/oBFIj
         dQbKqOhFFpxy28pE2v42pdCLyEcW42cAcL25dtUgbWriRfMo/c5H7hL36o2dtV5fJK3l
         AZHMX/PCA4jKa4diUCtZtf+TyV/IsgVur0OverSxGBc7aAWq1TLlvr46DU8gsMDRlxG1
         /spqQ8p3oAZuPTywbe1CMZsI3RqwvAsot1XvxRqEVSnFometlJoimG4YUOyLt2Qa3pPP
         2PPg==
X-Forwarded-Encrypted: i=1; AJvYcCXVI0bjonhI8Xk7LT1C14giR4z9b3ICur0JiYfec1pB37EdWC3Gppbdfhufixa6XOwhEJWerDB7Mn/g@vger.kernel.org
X-Gm-Message-State: AOJu0YxgzHO9pGRh/hNQoypYjwtXCvpbuna0rB5gwAcPXQzAihKTFX1S
	oal1HhYSXY1I1jmvznsN6xTBDkp8CRZ2OL6YSUApDMdeuj93yhCe+wyEN7GVEQ==
X-Gm-Gg: ASbGncuu4v6YMYrLmat8G/1CGmv1pWEPMoTIPGSd52pNtv7RHiuAhC3XuZwPqzHPeZA
	PAOvtvaL4uMx8O8zMkx8bqtPUXha3S1N7uJF5x6GKYIdoKSeZG5mX81q3a9SJUV2hdbdyk3+QDo
	nK7IVNjhy0DvuXSrS/qw6ZteLBWG4bfgTMpIrDMcM9lf5GaCPUkFyMI92EXQY9eI1UBrZxcBjsi
	txwc/NbEQpvzwJsJrAGY/c7UsH4dBkuYvCWPMTJAPMNFwPkcQB1FrknRe0skamDGnJqVReS/ORS
	CekCjLzoaz+5wQKizYj+S61I
X-Google-Smtp-Source: AGHT+IECFL9WoKiDiu1xKptVQF2T2gvsl28cr0HW2a0s9qqj6Aj7Q+ZZVLocd/R1cde01FoPlwJaWg==
X-Received: by 2002:a05:622a:1ba9:b0:464:889f:a413 with SMTP id d75a77b69052e-4653d5344f9mr24237121cf.6.1732268904929;
        Fri, 22 Nov 2024 01:48:24 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:23 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 09:48:01 +0000
Subject: [PATCH v2 4/7] ACPI: header: implement acpi_device_handle when
 !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-ipu-v2-4-bba65856e9ff@chromium.org>
References: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
In-Reply-To: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Provide an implementation of acpi_device_handle that can be used when
CONFIG_ACPI is not set.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/acpi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4d5ee84c468b..85d7649ac17d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -777,6 +777,7 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 
 #define acpi_disabled 1
 
+#define acpi_device_handle(adev)	(NULL)
 #define ACPI_COMPANION(dev)		(NULL)
 #define ACPI_COMPANION_SET(dev, adev)	do { } while (0)
 #define ACPI_HANDLE(dev)		(NULL)

-- 
2.47.0.371.ga323438b13-goog


