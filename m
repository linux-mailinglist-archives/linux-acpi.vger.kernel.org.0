Return-Path: <linux-acpi+bounces-18221-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0DAC0A46C
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 09:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565493AD41E
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 08:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBB02765D4;
	Sun, 26 Oct 2025 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m16Ombbe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0895E227EA4
	for <linux-acpi@vger.kernel.org>; Sun, 26 Oct 2025 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761466369; cv=none; b=BH1OMf+ldRQ09DnWvW0O76tT9KBuMlTeIthhUQQ1fzxJwZ8h601jgPwyLbToqRxmUsP2Oz51TE1oA3onqFg9Y/0jS1F5tNrRe5DG/ppY3n7YvguLD3rXedRD9fhLkZUL11EPTnGJtjpKFinnBpndEOaaoq+TRNFzNlqNLra2p88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761466369; c=relaxed/simple;
	bh=KfKya3ApWAx7jEzc+tOxx/V5zzMsaSdiqYDUBXDK5Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9M3oJn0DYYR/WmYjUOkt671b+izdikCxUuOH/PFnKgtOGlRQLBML+ydUktiAVBaD0avxBQp7CtKm6zXSo09ZvM7RgIFTdaWSyn0fiSSHqjBDdTKNQzvP75eX8D8CaepR/EY8jcKC0ueivYqR+U7U7XotsH4X4a6ZQ8VCO/WuJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m16Ombbe; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33bbc4e81dfso3957854a91.1
        for <linux-acpi@vger.kernel.org>; Sun, 26 Oct 2025 01:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761466366; x=1762071166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkzT8rhILn4Qaqc6zAgBKines7TQJhCcdPvDF4nghIs=;
        b=m16OmbbeNBdH7tl0pbdJjpRNXV8H0HXm1gCgoBRdq+n6ayfQK7rksGMNgFAuoDMqME
         5CQIPD06ez00bMznBwkthsCpY4pZBslVg0nTWpNLIp1zxxX2j/uA8jnuWytztXCedT5O
         8fjVjFYKKNKHUH8gbeHsI2GUlwdLcW8TwktZUzZ5zaUoZujAKz8mxKFu3hVEsTZxy2nM
         77e9wnWD6ZBUPdDgYWpoyaibgVmzOF18GW77nlvpevJCUBxqI66VRka0EJs1XRd1zXNH
         o+996Vm+auguJ7BW+ncEib165QwYUJ22Luw8AFUYTUCvJBscn5HaFMy0gKSVC1FQAugQ
         xo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761466366; x=1762071166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkzT8rhILn4Qaqc6zAgBKines7TQJhCcdPvDF4nghIs=;
        b=Vpys19q7a51DlpNQgaIOyqqdkGRmDf69TqhMqhhmtbGUQgaw2s63j7g1EKKSfiTfwc
         Eyyy9PpF4dxT6z6J4dra4yqF3Mjt/I1OB/K04xcAnJsyTpSA5//R1Lf6jQZbVpEaNfyT
         xsyIePEMy8bkEJF4NOSCt3LAZk+wq9oB1FgpHmE29WA6Y7mmJ5mB8zUvV+pGM7EGZyoL
         uk8XZcAtzbFWPL873omWbFIX/x0omlXWrskGUGOFhh2rin2CGpS4QgCQlYNDNbwWz/8V
         Qh+kNKDSCd9hL3Mbn1wvT7B5HxoX/20bze0fR/lJguY9OtfbdOrCJ4s3A9vcNUYkukVS
         v1Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWGfJDwdn3SjDjzOfHNxRcWQLY6B+2VjsujBHzYIuDgLSiLEhO20En9SXC8er/RFtiZHZqoUdRxzQVO@vger.kernel.org
X-Gm-Message-State: AOJu0YyIOaAeO2RuhclmRqLnco4X5zM58nguE0zmolgYdWty5oFQbSz0
	jaLmdVLivGJESfCnFZjyA08jPMQBQMxQ7TKLq95p7wYfbsh8xNOpF8XM
X-Gm-Gg: ASbGncu24gcdvopdTC9sOUpIEihe5Ilc8T1jE1zz53B9mv6Efnqkb1DabIj90fSutYs
	O8cFk9kfyU4lMOyDa9VrFo2fa89/fCaJ0o/tGMJTile4cRcJjwZL4q+P4JkZ+A1IAqt4Xf8eZiq
	KmYDXAyfLfyW2Hv8L6hbSlRFhgi935v2mbWxrN8YYqAF/WzcrPqoTRFwJpOOBYzr432SYsz58Iu
	vBvtM6EkoPKokOXVk/hIzQ7y4gH8nygXqulzIPNGzioktAiL9kgL0WRWFi/nTVE9Cxy4c0uJdjh
	QQm4Gd4g7EoEE4NflQ0DPsfS+b/t3AHQi2AkiBSr0GPOMkR92ewVvOvoFr7zYZHYbgyr5Dk18j0
	o4pE7vsABBk91LbxCcZb/0E3eEtqOiCbAMxBL9BUVrSmpCox8wdUUbY0tRh5OXQZYc244ZzZZbj
	SuLj+ZeA2/Q9MM7drQW855oJPfEHww7le5CkW/sMOZbHlN/kwMt0+WXw077jogTQovdd4=
X-Google-Smtp-Source: AGHT+IE5idy8ltBz4yyQv4LyCXJVQoIVOtH4PVAtTVzDIlLpQ2ipbqC0Mv+dwtrFwZLdO15KZ2mv4Q==
X-Received: by 2002:a17:90b:17c3:b0:33b:ae39:c297 with SMTP id 98e67ed59e1d1-33fd6502cb7mr9996760a91.16.1761466366364;
        Sun, 26 Oct 2025 01:12:46 -0700 (PDT)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fee8014f6sm2374654a91.0.2025.10.26.01.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 01:12:46 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
Subject: [PATCH 1/3] acpi: platform_profile - Add Extreme profile option
Date: Sun, 26 Oct 2025 01:12:38 -0700
Message-ID: <20251026081240.997038-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251026081240.997038-1-derekjohn.clark@gmail.com>
References: <20251026081240.997038-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices, namely Lenovo Legion devices, have an "extreme" mode where
power draw is at the maximum limit of the cooling hardware. Add a new
"extreme" platform profile to properly reflect this operating mode.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-platform-profile | 2 ++
 drivers/acpi/platform_profile.c                        | 1 +
 include/linux/platform_profile.h                       | 1 +
 3 files changed, 4 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/Documentation/ABI/testing/sysfs-class-platform-profile
index dc72adfb830a..9bee8deb4dc9 100644
--- a/Documentation/ABI/testing/sysfs-class-platform-profile
+++ b/Documentation/ABI/testing/sysfs-class-platform-profile
@@ -23,6 +23,8 @@ Description:	This file contains a space-separated list of profiles supported
 					power consumption with a slight bias
 					towards performance
 		performance		High performance operation
+		extreme			Higher performance operation that may exceed
+					internal battery draw limits when on AC power
 		custom			Driver defined custom profile
 		====================	========================================
 
diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index b43f4459a4f6..78da17e16d9b 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -37,6 +37,7 @@ static const char * const profile_names[] = {
 	[PLATFORM_PROFILE_BALANCED] = "balanced",
 	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] = "balanced-performance",
 	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
+	[PLATFORM_PROFILE_EXTREME] = "extreme",
 	[PLATFORM_PROFILE_CUSTOM] = "custom",
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index a299225ab92e..2bf178bde2b5 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -24,6 +24,7 @@ enum platform_profile_option {
 	PLATFORM_PROFILE_BALANCED,
 	PLATFORM_PROFILE_BALANCED_PERFORMANCE,
 	PLATFORM_PROFILE_PERFORMANCE,
+	PLATFORM_PROFILE_EXTREME,
 	PLATFORM_PROFILE_CUSTOM,
 	PLATFORM_PROFILE_LAST, /*must always be last */
 };
-- 
2.51.1


