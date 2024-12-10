Return-Path: <linux-acpi+bounces-10050-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8D39EBA6C
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 20:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A240D1888F56
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 19:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CC3229B06;
	Tue, 10 Dec 2024 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eS0bQQSR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7D1228C9A
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860581; cv=none; b=tAhTh+XRPw8D7yFOFqcT8MdBiE6lPe+ujMhoQDgD12cnaR9b+jZtjlH8XdZFUhv33DBfypwJOoMTtdsyYhWfq8jRSfSO2Co+vPM75Oh2tpW177o5vNhzaYSqaq8Fjbt0qIhzKvGQHTIh1HVxxAY4Nfs5JzL96U2YOljafK2eg88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860581; c=relaxed/simple;
	bh=oQ6DOmEDhAhaC7ko0Me30Rr/Q1eMZQPunpUP2qNklrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZi14iLKICMI6VPOVXY8kRT6cZ27S+k3NfGJH4sT4AjQAPLJ65TaP69U8rxvIVPbGCdYEwYH6R8KgNGW0qDU5JQbWooTMocTEZIJtRc7M2xacUA49pPYUt6SqsgRea+mmiLciu/hqT35Vyc2XNC5yH8N/t0lhGIsvfkMAF5w8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eS0bQQSR; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-51889930cb1so484170e0c.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 11:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860579; x=1734465379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lezNY8dR9ljfu1iEN3ZQdA0hj9drLp6T4ntvpJiXGhM=;
        b=eS0bQQSRKOkRTg1R00Lzul3TSSpu/eJPD7952BfrCPISozqKj5oTrH2z+ycumAO7P2
         aqMeIYtSUBs9+yuennfm1GB1PlaEgI6Lvc0xLC6rU8Vc+wEEuIKK5bNUBtqUmCbogqVG
         KMc46btlPwz1ne0c0cRg0s/yOEeBRJApCUoHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860579; x=1734465379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lezNY8dR9ljfu1iEN3ZQdA0hj9drLp6T4ntvpJiXGhM=;
        b=vpB1YoM9VUHcr5cKyeAodKKybhKo4Y7aUeiorZm+xti7M/gWehDlyNDx/yhQpFKbvA
         zxdJVH3yIN85kWHSHAOCpL2hhxmdHtg7XjfuVrXKxbMGwRaymDTCH6paERpUaLCiDfYL
         s5VydVaWuCUoxMWpy62HPSgZ3Ib4b0sRrd7fCHg4O6F3hVHCTDvtngRz4kgkHOIm7wBt
         YflbzaWATa9B8Rqou6LewA9IH/pVGw7S1YswTDOPRb3Fx5BomhQ0Zqlh2m9KniSu/le8
         JE+O38v26wV9G8aVISMcFugshIZNGmUkoXUjizKZLxi9riIcFpWgfNiSLe4kDms2qmq2
         1GlA==
X-Forwarded-Encrypted: i=1; AJvYcCWOXNYPY1tPC+jvm8Ru0+N+NlDR+opIiLnc/oqX2RDgfLVDC6CL9AugBPv5caxJ+xtEK0TVeIo1B+CU@vger.kernel.org
X-Gm-Message-State: AOJu0YzBfdm7W9KH00ZFff/nqpbwJS2grTdpZH/vIUxi72mPyfpPh8GO
	0TWdxhkIEWvy8BqKv4017gUhNm5yWrXBULABQRdaHroqbc7PBckUakWSrIQEYw==
X-Gm-Gg: ASbGncu7TspmZc0PhVh3CZ8df1H5UD+8U+do946VYwouEfmHDOa1kbI0GZoikuto4Hf
	16UOGm7AOBQjNLgFAUoC2aoZbNiCyp5KnmvBf+ywCg7rqN+gry3BI/78TFUdoIHl9KOA+bq9OI5
	s7QVOC9V+mH3842hl+mQLwk5EJlZRZKBnSPBhgEvXauNDpqKPBqbLM05B9zPj1B8ulxCO2yNCWg
	O45pVVWlaTqmvD74f6fhQUWlU5om3HU8jAPHpGarZvX332lz9pF0uu/bwdqOB7pdmkMqEB0HDjQ
	aq3bKnTwuym+TuB2wqySbs5KKgy1
X-Google-Smtp-Source: AGHT+IEMhYnLWvQoSWZmZsMGZeYTR3YN9TLWCv16La+76YSYWE5jDBmdmVAao50oTu5BwjDFJ7Yo7w==
X-Received: by 2002:a05:6122:1d8b:b0:515:c769:9d32 with SMTP id 71dfb90a1353d-518a3a34d65mr938780e0c.4.1733860579349;
        Tue, 10 Dec 2024 11:56:19 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:18 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 19:56:01 +0000
Subject: [PATCH v3 4/7] ACPI: header: implement acpi_device_handle when
 !ACPI
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-fix-ipu-v3-4-00e409c84a6c@chromium.org>
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

Provide an implementation of acpi_device_handle that can be used when
CONFIG_ACPI is not set.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/acpi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 05f39fbfa485..59a5d110ff54 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -787,6 +787,12 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 #define acpi_dev_hid_uid_match(adev, hid2, uid2)	(adev && false)
 
 struct fwnode_handle;
+struct acpi_device;
+
+static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
+{
+	return NULL;
+}
 
 static inline bool acpi_dev_found(const char *hid)
 {

-- 
2.47.0.338.g60cca15819-goog


