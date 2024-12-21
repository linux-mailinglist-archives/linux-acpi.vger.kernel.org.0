Return-Path: <linux-acpi+bounces-10242-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 548DD9F9EF5
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 08:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A99F1888555
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 07:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EBD1DF755;
	Sat, 21 Dec 2024 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akQLvrQy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312671AA7A9;
	Sat, 21 Dec 2024 07:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734764979; cv=none; b=XygDdI3uCRGXSOTWXGo3BGIsEl2jWDwrLU0sjA3UNjNvN8VA+gsDtZDMUEPsDsZNMfAfkOo9YT4T8EuyGiONtlbIBDqKW42mlH6rRPQkz64XPTK/G2+nBOz3nVsk9S1vh6iRwAKtdAKPazH6zh5YYxhgnzE2vgvTETL13rQiiTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734764979; c=relaxed/simple;
	bh=rHrYOEQiSwzsyNqESU5IgZGhOMkjQnxtSauNm0Ywmuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tM3plUHZIbbc90yGosTug/cL9fbIaXga3DhtlXhJGsKpRaMNQWFPD0hha3IJaaK8TqdYZnPaERKDsUrA8xflij9v7wA2J+wUxrbapfGDhV98LE1H/cYc+1uw/JEfT8g3kTd501brlqJFr3fxHe70ksh2AIcUWZ4LoxzJKVTGQss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akQLvrQy; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6eeca49d8baso24009137b3.0;
        Fri, 20 Dec 2024 23:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734764977; x=1735369777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PCvMqGqH1fVw7iWJpsBFnnyPu3XWrMWmH8Xe8W+oUI=;
        b=akQLvrQyvR1062dMvXClhR95lMYS4YKam1HQ6GoSLL9xip0WNi83+8MsW8Q83/py1y
         QK+/AUb4HxrNmtzSyT2MvNy7aozFx7CHWl/CRB7Etv5MGrxUETN3IT6K9qQFJv/71Gv7
         yPA1cqtkcEh4jNB14XqFlzrSry4kPFu1AjRfHzaSf435SS5V0qc4zPMj8new440rwjKX
         pTkwtDWy+wpXL2nESkfJxdRSAw6nYlcAtuFYotuKKwAohjI2/hDvPWBXnB3RpjDspeCQ
         PD4fDhn6t+OdZWzA+S6ysj8PrrSt2vR7zmtbgH8pKNmRWm3OCj42B7m8cgXIsG2mOQd4
         +6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734764977; x=1735369777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PCvMqGqH1fVw7iWJpsBFnnyPu3XWrMWmH8Xe8W+oUI=;
        b=kEpf4ORB+Rsjh1PK3hhEiL4Fx9rDBpsfZuzp/eyRo5BBeAGTa2U9RfBEALOV2hAntF
         GJ1UClA2OyM/h077Zb8GX0SvcdW3oK+DvHAs3318IwcgoMg7X+PE9I2DAik1CRhdVDg1
         gsrhEtOkeLOOSo0uoaVZK0Os5sLe4I9Ne3DbcEyLZh1any0tGc3R4HLNtGo5KsvqegX+
         eIrh1dGa+DCycuBHjpHHUn8UWbyd8XoTzQnvbFwv7dJbdIm+JM/Gt3wpTNaV9ES20V29
         MdWlEICFW8SDWWah5NwBsjCP5ekr00vDmFugmWZMkc5ohsYY+yL5ZayzBMFvsu9YNrZd
         SAgg==
X-Forwarded-Encrypted: i=1; AJvYcCU2vDbS27SrV5YOuEIzWM1VXMXVL+qYuQBzE0TVaJ7YX9PlgWTPlbBi9N5Y+RHmBbY88CUktjhUyrkB@vger.kernel.org, AJvYcCXSPOxIMrmbJr9Q4Kpzcfg/2NwsK/o4bNVPM50heokE9Zw/59uQjBzn/0/YK7erFiuFohzbH/iVpHIRVTIz@vger.kernel.org
X-Gm-Message-State: AOJu0YySOJcqkoEvOWPvZuMDAbAobfp7NQpoLSB6G9/dk4TQJi5V1bZk
	oYKNeUNYX7AOW76bq6EASXIKAxhneLNFysX/hoW6WV0VcBRMg2uGP8PYjQ==
X-Gm-Gg: ASbGncswEAY01nkrDMMOyPjCzU1pfHpw6gYs7s+bTsoAze3f0D5lalbw0jXDN2GmfqP
	g0r4LWvv2ZgKemJYSfVaUb7VpXkbV6VmGpVLp1VCcHI7Kx0+rdNiGZyaAZCBvZduFxbyFqEFva3
	daFsXfTpremH7S6oYgIq5QnZAjlS9+MuC7kotxZEu8jszFICXjviiyH3MEwBkAdLktv/Gy97V1f
	un+JA3MaodctAQqZpVb3OdQ5gECHdzi4yYDLvRQImmH2HJTbKALkVug7bdPzosj
X-Google-Smtp-Source: AGHT+IHdJCttYS5HUwRlNjfiWhYKUkGpJvYhydw587M04xMH0sda3+632f1ECt+tNkNL5kFSPu1lhQ==
X-Received: by 2002:a05:690c:6f04:b0:6e2:41fa:9d4 with SMTP id 00721157ae682-6f3f7ec3e77mr41905537b3.15.1734764976704;
        Fri, 20 Dec 2024 23:09:36 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e7498215sm12367977b3.60.2024.12.20.23.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 23:09:35 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Gergo Koteles <soyer@irl.hu>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH 1/2] ACPI: platform_profile: Add devm_platform_profile_register()
Date: Sat, 21 Dec 2024 02:08:18 -0500
Message-ID: <20241221070817.3764-4-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221070817.3764-2-kuurtb@gmail.com>
References: <20241221070817.3764-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platform profile's lifetime is usually tied to a device's lifetime,
therefore add a device managed version of platform_profile_register().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c  | 27 +++++++++++++++++++++++++++
 include/linux/platform_profile.h |  2 +-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 75a1415190ac..d0c88decef8b 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -519,6 +519,33 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
 
+static void devm_platform_profile_release(struct device *dev, void *res)
+{
+	platform_profile_remove(*(struct platform_profile_handler **) res);
+}
+
+int devm_platform_profile_register(struct platform_profile_handler *pprof)
+{
+	struct platform_profile_handler **dr;
+	int ret;
+
+	dr = devres_alloc(devm_platform_profile_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	ret = platform_profile_register(pprof);
+	if (ret) {
+		devres_free(dr);
+		return ret;
+	}
+
+	*dr = pprof;
+	devres_add(pprof->dev, dr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_platform_profile_register);
+
 static int __init platform_profile_init(void)
 {
 	int err;
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 0682bb4c57e5..d8114435865b 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -41,7 +41,7 @@ struct platform_profile_handler {
 
 int platform_profile_register(struct platform_profile_handler *pprof);
 int platform_profile_remove(struct platform_profile_handler *pprof);
+int devm_platform_profile_register(struct platform_profile_handler *pprof);
 int platform_profile_cycle(void);
 void platform_profile_notify(struct platform_profile_handler *pprof);
-
 #endif  /*_PLATFORM_PROFILE_H_*/
-- 
2.47.1


