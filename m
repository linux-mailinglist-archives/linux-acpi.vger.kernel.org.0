Return-Path: <linux-acpi+bounces-19327-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4B9C8F3B0
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 16:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F323AA97B
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8A1335547;
	Thu, 27 Nov 2025 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVycLHNY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CE733509A
	for <linux-acpi@vger.kernel.org>; Thu, 27 Nov 2025 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256576; cv=none; b=kZanb9voOJ8+iyJFP7jNkdsTEPGCR3IeGy7QGMv3FEqywwjaD2mjHeD9Z1XgBgIjezexWYIvpUXHebP6LjF4JEv8/Rjn1Mv61enAjHhMLCM5jNoKHkT6SQpyrm7CAw4ncLjB2NTKD0ey1AHvINQBpKTtAhH7DOzGaoDu7ZJn/vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256576; c=relaxed/simple;
	bh=AWNkJhYiQSm4mam341FTvs4ijlPyZ/HkhkFPW01BwM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7l0oxiHXn3Xq19YG34JzbSLN71wTvXXOfRXsyzbMQ3vWQ5Epxd/oh54Zp1ED533fVfNZhj6sRWfw25aSm/0n1rT/MqFKlM29qxfxGRZYRLwF36GMes1lAZcee55KnN6937jwsQDbJfi7dSIx3r7NPsgLQDZESeBHMPTCU1tO0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVycLHNY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2958db8ae4fso9887525ad.2
        for <linux-acpi@vger.kernel.org>; Thu, 27 Nov 2025 07:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764256573; x=1764861373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcvRrylsz8y/5M5RPfO3ICptGfI1sgN5Cn3FTmzcBZk=;
        b=FVycLHNY8xRLuaaqDGGv2Zi6HW4Sbk2XMb2nyCU+fm3HVx/BU3jtVS1KLz9TfScYPQ
         sypqfTAhS/chWJ5wOnypgCO1e7inaDPeuJAT7RM4s/UyL8pmlwNwOI91RxPJ8inoT1JT
         c+ash+G1ygFct5VJFbeI8BxQ43oXFc1qj7O4FQ9251vledxaVMmdGJKVKwTeFuYx7yWz
         Wnf4wCBgwnckcapMPU9KrB+3lN49FGHa+plG+kuHe0CXGOWWAhEMMxI9y/I0gcySYHhc
         Wwpl9ZHUctweesnOjP31F6ml9VbDiIgM+wlL4JW+dV41ZblrWSu5FMitKKgRtXwFD3+l
         n/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764256573; x=1764861373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FcvRrylsz8y/5M5RPfO3ICptGfI1sgN5Cn3FTmzcBZk=;
        b=h7joj/G3xiFZ5MEmnKiZLzzK42TalDMLrrr3boL3eMZSm9GcOCG3FQxTqn7C8IViob
         RiS/6B06WY5kNA9AKpVT6RmJ1+7RWJp2OyeBhZuADBH726uCuos0mZZ4O9sfDjcoM5Rh
         LhQEEmEktuqBPnkZByaf4DVdaEVyi5scdF7Uj66u3x9yP5+AgY7fFmxQP2s7jTMycnqz
         iKUZXalE0sCp7PEn8Wn3/NHkD5Q0+nKaFkQN8DXOAm3gous+FeIAeYQe2Y5xcquvnAuW
         zchAEoq3TL3qMFm2AIB2fkjGv3jlbSz91/JBtwx9K+GYq6EOw3qkz8lKdR9X5clF6zkH
         s/8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqs30bl2sK7czrg3DAqLhhtpdkv3qjyWT9C/hHdhBYXAtJgoXNcYtwXva8OkXUN+VNLCUkJtUaELvX@vger.kernel.org
X-Gm-Message-State: AOJu0YweKuA+omTcahlUcH7N7ZhxaWrA70t05rRMDSld1gnAKtVpHADn
	jE8D47U1M9JDjwEDpT5UG0EF9O4NYYrWEfRl/5MUhwMknMpJMhPvPlvX
X-Gm-Gg: ASbGncsHodn9MBNcyNcwHV304b7jWkTSktLLAXl7Lw7I47AOdUxb2y4TuJL3te1vCKc
	sokkKhJxBzsfExaXuxe6Jo0Nn0O2u8RecbSS6B2IWJHPIdg1IwliYnaWgs/yAmW8Vib+nKWtI2K
	2HQswsBW2h+dxI08rpFj0gIlnIwMhMuXOb4WeloZDKEAIqw/x9LlHRDVr+pqx2HLseMJ7fPOJIW
	VEvgiZ4XzR2XWSeEb1GESlVnBm9n7s+jOXSAWTrhJURKfq+LvD5KCfrBWQ0OPECJdGThFXymEDL
	Vm0S/jgDaLFOWCc2J+3GqeRqBJZd2N/2R22Oyhtpy7OETbECEemeFwnVq/xcUpVKVdY7fH5BZVw
	NM8cqBxVyZQpGOfYAug7hC66F39qkWXMiDqS/bSRrQpLj5JH3SepSGRreyZTZWHbVJVYhXMrBF+
	SQ4pNRXJYpT3LC+m1u+dv1U4kbUY6NTAaxTyAXsEjF77en2U2PDb9x+cSkplLLAvZTv4U9QDOt0
	2U9eQ==
X-Google-Smtp-Source: AGHT+IFbJD3W3TjYyXHCl+ByEYJBSKUdDrYv+tvqK3Wa3b2N0x9VAT+uS1rulv/XgzRItzjJ76/F1g==
X-Received: by 2002:a05:7022:438e:b0:11a:51a8:eca with SMTP id a92af1059eb24-11c9d812055mr17767856c88.18.1764256572310;
        Thu, 27 Nov 2025 07:16:12 -0800 (PST)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb067088sm5099656c88.10.2025.11.27.07.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 07:16:12 -0800 (PST)
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
Subject: [PATCH v4 1/3] acpi: platform_profile - Add max-power profile option
Date: Thu, 27 Nov 2025 07:16:03 -0800
Message-ID: <20251127151605.1018026-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251127151605.1018026-1-derekjohn.clark@gmail.com>
References: <20251127151605.1018026-1-derekjohn.clark@gmail.com>
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
 drivers/acpi/platform_profile.c                        | 7 +++++--
 include/linux/platform_profile.h                       | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

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
index b43f4459a4f6..ea04a8c69215 100644
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
@@ -506,7 +507,8 @@ int platform_profile_cycle(void)
 		if (err)
 			return err;
 
-		if (profile == PLATFORM_PROFILE_CUSTOM ||
+		if (profile == PLATFORM_PROFILE_MAX_POWER ||
+		    profile == PLATFORM_PROFILE_CUSTOM ||
 		    profile == PLATFORM_PROFILE_LAST)
 			return -EINVAL;
 
@@ -515,7 +517,8 @@ int platform_profile_cycle(void)
 		if (err)
 			return err;
 
-		/* never iterate into a custom if all drivers supported it */
+		/* never iterate into a custom or max power if all drivers supported it */
+		clear_bit(PLATFORM_PROFILE_MAX_POWER, data.aggregate);
 		clear_bit(PLATFORM_PROFILE_CUSTOM, data.aggregate);
 
 		next = find_next_bit_wrap(data.aggregate,
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


