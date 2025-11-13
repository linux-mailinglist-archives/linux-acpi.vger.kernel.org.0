Return-Path: <linux-acpi+bounces-18882-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD472C5A209
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 22:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 999E34E8E47
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 21:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB3232548E;
	Thu, 13 Nov 2025 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLeo9aAX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C875324700
	for <linux-acpi@vger.kernel.org>; Thu, 13 Nov 2025 21:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069207; cv=none; b=oRE6fi5/GYVvyRAJWd+qrz6nsoGCVC8AETbppjEJxHlU7jlCjOUP5MEBCr8JWCujYmE/EsGQ6kde8whU6pdhPKwK7fQO8vBD0TtYtWUR2iDQN0PvO5Q2ifpDz8exbKPjQNcV56weHE+u/DJtGIHZ7/ucUP1C5C8kyi4slbsRpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069207; c=relaxed/simple;
	bh=EAYHD0uflfQd6sszqckCoZM9plV9potl4DoHq6i9A4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGkCfqBLLwmAAl+dliSgdU8p2ho6lZaj6jz7KFIg3pqAhcAe4wz45aCYJ+6TxfdvPM5v+U8wHMmEO0EPLbThXBwc2x30ijURt+n8QliQOOjojNaf8Mr1LDpLZoUNj7yMGC7ptbwco7ti+Ys6OXeVhZFBLu3vTrCT1Wh/C/XUm54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLeo9aAX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso786942a12.3
        for <linux-acpi@vger.kernel.org>; Thu, 13 Nov 2025 13:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763069205; x=1763674005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SI5IT2ccA/LcmNZQUHmcdI+iq0zqrTHDtVhV8fx+VI=;
        b=SLeo9aAXvz8+jnJn+Ek+oV6/IpdfpReJeK6ysMpgYnJH5+YGaMaPuaU7pRv161/0fH
         6cD5fybdcAOoQnIFr1sP66XKYxAJNwq2OFRZzsrLpUZvbY7E1JWx1oV9NCFkaQzW03cR
         g144UbZXLtBsqwtilem+qzxqRJ1JcFGou6vU8XH5MdW8vm+KNXeCJURweMjcy6kSCVGt
         drzF539RFvBIWkUynQrjuKVrwi6x6O6kmtmLBwhdKRptbwlbAzPmzdJ/btdQNcsauhiy
         F+vTKj7XaLjBd6I4FnG6h7/xqEwHcV5porkrSeKftdFATtZp8mj4Rvz9wvPG9t66y5m/
         i+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763069205; x=1763674005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2SI5IT2ccA/LcmNZQUHmcdI+iq0zqrTHDtVhV8fx+VI=;
        b=Yi8ehDZgxPwZzjarNFVEOda/r8+9o6O/O5zL7AnPnDZq65vO/stNKDLmwFia6bdiUv
         0kL55ZvHk1wbvQiSVh2zKNEWfyZK3vLjLJdmABcq7v37gBlwBQqrsCaWBYvNpZVNcir2
         Z3BL0qH9GpNkbfSVs62jhYSy28zG6D9GvR89JYvhInXjNd0mhIWwSA8BwD85hvxVVUf7
         C2y6WoiYY8hBbzK5QG4bFr5HMAA5ExXTAH3IvW1miBBHpGbjvkPKMawymI42CJBAXdIu
         rk6E4kupI0TyJ0N3z/KQoyzQBTIY1c9m0gh/jFALt59Byp4LBJ7xat6763dY3tGkUqHw
         2aqA==
X-Forwarded-Encrypted: i=1; AJvYcCVmBELvxjg9W4VlML7OVJp9BIPGFFL59/JQxyfRvjINFxJSUQ04jQhqUgGVeFOkeCDcSaFFKSpCY6Zg@vger.kernel.org
X-Gm-Message-State: AOJu0YwxIR/bR8yZiFi6BgrvYuunsEuJkpL9EMueWzJblGVMW0/Cl2TH
	MbjvBpR0xMygUKfs1OvrcHIfOeQgnA1VlqCHhH2nSqJ/L25oYahfnjzA
X-Gm-Gg: ASbGncsXwNryN9LCnkmSah5ovgHQl5F/XVowCvJYH08KJi7WBHYUZnGdPXyODDzaLpl
	r5BbnGxHkDAX4WM/w7dWdZuC1+hPx5OI1lWLpetnPdXM8Xb12SyaUhA6LRoDEhnF9Tj3IxMLVwt
	3t26tI3Zctjbf2uzOqtIg1Ty7fN610TjZatPKY/Lznd22jRsqTgu6N8CQw+FaX2XKTf074lt/fI
	23Jnf5PWjsZhMbNKf3ytrX4gav5cqkMuVUMDculipDNQYnhdwn9qyNsE4kiG3WjMpfkQVc91c7Y
	h0WDhXjL1BotOoPvGuw1XvOnABgglZ04Fl4kb2ekak1rdPG/UBlrvTWY8ggqKWDk/C2PVAguhEd
	rupfhhaKH0okhs9OC33rmEzsRZeHTRoPAEnVRAGoVqOAvwQx8OYv+TUOF83wYxg3dVVPjjwFQmn
	ndlUuLTDmh6vY6IlxFpulNoUBovRrksGv10htZrj6v4W4oAqyJ0BnfFXd4MKKfZYN9Sfo=
X-Google-Smtp-Source: AGHT+IE4bqe47dgeG8a0SwzrDMd8To6AhA03KdcpEfj8eolNH4fytB9FGHHkvfol2Cp158xttn8Vgw==
X-Received: by 2002:a05:7022:1581:b0:11b:65e:f6f with SMTP id a92af1059eb24-11b40f98007mr318605c88.14.1763069205472;
        Thu, 13 Nov 2025 13:26:45 -0800 (PST)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885eesm1811414c88.1.2025.11.13.13.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 13:26:44 -0800 (PST)
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
Subject: [PATCH v3 3/3] platform/x86: wmi-gamezone: Add Legion Go 2 Quirks
Date: Thu, 13 Nov 2025 13:26:17 -0800
Message-ID: <20251113212639.459896-4-derekjohn.clark@gmail.com>
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

Add Legion Go 2 SKU's to the Extreme Mode quirks table.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/platform/x86/lenovo/wmi-gamezone.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platform/x86/lenovo/wmi-gamezone.c
index df475e52f79d..381836d29a96 100644
--- a/drivers/platform/x86/lenovo/wmi-gamezone.c
+++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
@@ -266,8 +266,23 @@ static const struct dmi_system_id fwbug_list[] = {
 		},
 		.driver_data = &quirk_no_extreme_bug,
 	},
+	{
+		.ident = "Legion Go 8ASP2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8ASP2"),
+		},
+		.driver_data = &quirk_no_extreme_bug,
+	},
+	{
+		.ident = "Legion Go 8AHP2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8AHP2"),
+		},
+		.driver_data = &quirk_no_extreme_bug,
+	},
 	{},
-
 };
 
 /**
-- 
2.51.2


