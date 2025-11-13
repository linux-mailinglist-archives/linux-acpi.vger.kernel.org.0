Return-Path: <linux-acpi+bounces-18880-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FADC5A1B5
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 22:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709DB3B1739
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 21:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CCE324715;
	Thu, 13 Nov 2025 21:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeK1dBjm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC366323416
	for <linux-acpi@vger.kernel.org>; Thu, 13 Nov 2025 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069206; cv=none; b=PX8TpOEh/UAj0fe5mWvbQ0g5ShyLktPgtqnuHXJiOWv6g5HLasP/sOCw5+ZDxeAKYNmIRRJ1c516siFHF+crACBL6fcvGgVwu1NZpR7D+wlawLcSPpSsNMiTaZTh7HMAZaIdpGaXxlqpuv4ZRfIXX6379gGigYknUcl0vBM/HP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069206; c=relaxed/simple;
	bh=Aowo0IlaBztSOOQxDvKMq5NmrZZmaP5pZMs9pRTujV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvYdQ84BoftQ5fvhzhhIs0RpOC3Z56tHr5F2mC8SCM0m7idlIGkJixWdRotm0njekQURGZ1Z7ekLoGa0SrPrwKKUx4ygbj7PEdtoN0khrwr9/1AeZoeOFQO6EjzLWC24VDbVj8NTT/vsBlfC2SrqYfqlclTunD+sQ7kWwdH+54U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeK1dBjm; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bc0d7255434so841563a12.0
        for <linux-acpi@vger.kernel.org>; Thu, 13 Nov 2025 13:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763069204; x=1763674004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gup8jlztTqVVoO7AH7wg8TZA7qN2MbWnEYHaxHfLc6M=;
        b=eeK1dBjmAF3nRhKL4Sn+8bDmP+zlgZWX6piXua+ugK7M9e///LbcAJchYWzCtjv3iM
         yW8reGZeDY2IWJFpmJGbjC5wd/+QMRJPjkfoQkPoo2YRKZe99gPZGtHxk8ZN2Fl899ly
         2R5ELAjKUtrgLjdls6sEhxy5py48oKnJBc2JuJlmvb5jGhVU7IpCxgvwzjQ/xZIjjl2l
         Kf9wmgBXR40kqCm31UFsygx5ycSnrFVwBAuO2F54nGJJEG2Qrr13fEMHUdlrIpdjcXU0
         7uhhd6bP4Ydv2EQsxcoKvzuXvHQ8fLN6lPj9NscAX93U5pOlmmzBrviLg8Acw8gEo7x8
         prcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763069204; x=1763674004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gup8jlztTqVVoO7AH7wg8TZA7qN2MbWnEYHaxHfLc6M=;
        b=gvGanRZsUzNYo0bGzyNaCot1ec5NCCqDZENQqHW0M6s4MeT1/FYryjbBZ5LbLUJpYV
         EgyFkkyOQ40oRRACqgQm5VORjcazMQ8yJX6eTEhSErzVYCyzdEaK9PGet51RaHg5EUg1
         EcJqdPg3wvQLXngMs1tqd8Y/kl6D7N1OB7DTYaQPph7cU4Di8DUqA/TLdJP1inYp/IkM
         d+3o3Tz2bLcTuk/9scTvs2xQdmFwEQIIlSo7V0slaeRDIv6htnsBt/T8nz6P9q/vI301
         Q0N0PirGc7B/Lt7ddUFJcW4Fa9RSDNwtoRfWIr7EYWNDO3RNTNe+HBEbQLPL3zFIfhVa
         YTUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV15ts5sFIdKVSvP9VDVJQqkCAd3rIPTOgha9MCfmlyR/wk/uz1wjYWU3q4FEHQ5nrofdyUWmbIME/a@vger.kernel.org
X-Gm-Message-State: AOJu0YyQth58QdovDtARnsA8iObUIk5l+dlDaz2/c4VFFlwqaXKiCNHE
	LgfVxPbaGtY0/nIr0RmuYSTPiY29w13xWVcGG2soRJWWPbRyBa1/oXO/
X-Gm-Gg: ASbGncu38MEp/YQd1hn6TQPueYx8GMRSSsxeQde1jjPQ9rhSyPx+Bfk25ypq8TsIe4p
	W359kcAQ4YYgdETsPb+vii5K9obPvA8XcMKo2tKI/Ot011b/DHnM9GI4S3JC33B6U7g0dMkqrgh
	SlyUrewi3/E19JKWHF307XbYTwZBDOHWv0cURrE7YvRZk495sqW2/JPzsr3vqWDj/dKzMTSpyYU
	azv4jq23mHvrxt51MFcnYqXotkPjb0ZSBjLZGusHTsMt5S7ivet+KMkcIYDGUJlK6UWRxW6MQ7+
	iNm/xzh13G7ixggM+mTCvIGETKSAsfZUqAT8Gl817/r1GdVVDFXIozdViG3E71Iha+nxdeJP5P+
	tYxvOyEICxN+8r//lIKnaI+aRuxtHmz1IC/ugwBfdrtYcYeW61Kurc7R+gb/s57jf/rnl5JGyIX
	Y0LnQQzNdLrwwGIn9JDlKqYBYiMgfBUqtsrWMcf1Lg7ezFfmcCi1LZp6yiNUL5UNqdbzY=
X-Google-Smtp-Source: AGHT+IHDHzMyGrR9XzZFFbHiUHCu+jeBztlrSt+PxD2cgPY1wVsNA1mn7BCOfms8yNm5tlIFGPONXw==
X-Received: by 2002:a05:701b:240e:b0:119:e55a:9bf0 with SMTP id a92af1059eb24-11b40f9404fmr260328c88.12.1763069203573;
        Thu, 13 Nov 2025 13:26:43 -0800 (PST)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885eesm1811414c88.1.2025.11.13.13.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 13:26:43 -0800 (PST)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Len Brown <lenb@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mario Limonciello <superm1@kernel.org>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v3 1/3] acpi: platform_profile - Add max-power profile option
Date: Thu, 13 Nov 2025 13:26:15 -0800
Message-ID: <20251113212639.459896-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251113212639.459896-1-derekjohn.clark@gmail.com>
References: <20251113212639.459896-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices, namely Lenovo Legion devices, have an "extreme" mode where
power draw is at the maximum limit of the cooling hardware. Add a new
"max-power" platform profile to properly reflect this operating mode.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-platform-profile | 2 ++
 drivers/acpi/platform_profile.c                        | 1 +
 include/linux/platform_profile.h                       | 1 +
 3 files changed, 4 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/Documentation/ABI/testing/sysfs-class-platform-profile
index dc72adfb830a..fcab26894ec3 100644
--- a/Documentation/ABI/testing/sysfs-class-platform-profile
+++ b/Documentation/ABI/testing/sysfs-class-platform-profile
@@ -23,6 +23,8 @@ Description:	This file contains a space-separated list of profiles supported
 					power consumption with a slight bias
 					towards performance
 		performance		High performance operation
+		max-power		Higher performance operation that may exceed
+					internal battery draw limits when on AC power
 		custom			Driver defined custom profile
 		====================	========================================
 
diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index b43f4459a4f6..aa1dce05121b 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -37,6 +37,7 @@ static const char * const profile_names[] = {
 	[PLATFORM_PROFILE_BALANCED] = "balanced",
 	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] = "balanced-performance",
 	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
+	[PLATFORM_PROFILE_MAX_POWER] = "max-power",
 	[PLATFORM_PROFILE_CUSTOM] = "custom",
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index a299225ab92e..855b28340e95 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -24,6 +24,7 @@ enum platform_profile_option {
 	PLATFORM_PROFILE_BALANCED,
 	PLATFORM_PROFILE_BALANCED_PERFORMANCE,
 	PLATFORM_PROFILE_PERFORMANCE,
+	PLATFORM_PROFILE_MAX_POWER,
 	PLATFORM_PROFILE_CUSTOM,
 	PLATFORM_PROFILE_LAST, /*must always be last */
 };
-- 
2.51.2


