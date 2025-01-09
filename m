Return-Path: <linux-acpi+bounces-10461-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 135C5A07B58
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6011F7A3CAE
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B645E22258D;
	Thu,  9 Jan 2025 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj7YboJF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CF221CFFB;
	Thu,  9 Jan 2025 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435348; cv=none; b=jFzhdAPeoHbEN6DGNWvCShJP93eRYxd7c4KiZSJsbfcU5AR86fvnAHUc+v1GdLIAtgxSnQ+s3vfaw7U2+5xFRQIhITlsttYJQRDcOpQmdKYOIjkQJLvh7GNu6LjGusPiRTVA4XiSRlqU4EbB7m9doG6q3kzWTMIsvRVcUM6GQ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435348; c=relaxed/simple;
	bh=qLNpxdQHmr4FUi3kZDQjLaRkVRppkBFUeext+V90VxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tkm/sqmx9nxLy+MTtQztqod0elWuteCItEujREWT+wCNcYPJg8KfMAI52gsjzOt6HkiYYWYGhyJ0KPmI3cuTjqhY8kCIl51Bi2STWTywK48L6beG2jxDUGlD05MFFHNZ5zD21OPEItNvBYcNCdsBg5Qp55VdhCkHiYMwuWvyvck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aj7YboJF; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4afed12283eso781444137.1;
        Thu, 09 Jan 2025 07:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435344; x=1737040144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=re4+pG1FRpqOGyXJCRSQNyItv7j72+FDLGCOtmj2Lig=;
        b=aj7YboJFSTP5uhfB+vzM6kdlLnZhY0vmRgcKTyw0dSTrd402k+9skMr9qiJZn2hxQ4
         08Jf9ZasqkSPfaEN7M7EH4Wt9UlJljx5l3fiQXs+m//K6vW8VaGEqlL2Ldrzbc3uU/jE
         8pJQpMsUIaLLQ2MGx8fDm6cHYDHcXtAsArGw7CV2AnKc5j5gzrP3lnbGVpaM6VACY3av
         Zrvhd2nDvVCG9XHm9bKvMfy03LArWl24mOnh6gHVF5AtDkDUw5XMeTov9BO1VbatJaqo
         RfyytwtBL9ubMdLHeZzRz0EEZ0/v0FZC0zzBUvQfqbRagEUyC2S+zj2nQNTvtr0wI5F1
         fLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435344; x=1737040144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=re4+pG1FRpqOGyXJCRSQNyItv7j72+FDLGCOtmj2Lig=;
        b=Bx0okKaLsfACGrsrd/9dSTKKrpvWNcL1uV+prVfMRZNd9Tb8yRwqUGQf5OJ2o0FFFQ
         dIu5C+ae6ys7oHe9Bn/Cta7td6M5VLpXcoULo2xgaZRkxsZ/mAU5KQe7NFfNyKLgd0nQ
         SjeFrKFeFCzbP+VKeLxzsAgeMitOCuTRMcYXZPPv1lwrRsB8oq9XXIrhtwqj9gzPvMIb
         GV3XpVqlv6kt9QqfOdNtZqtbBpqgXB3vPGaSMljjQmC5BcXpopy0IGVuYikRluhQOQaJ
         16NAegezHFITR+PkdWMFrQPaK8KW8hYJpKvWuP5fv3g+u48AWZ1CGxJhQ0QHdT0++Xe/
         YEjA==
X-Forwarded-Encrypted: i=1; AJvYcCUlUZ04O1kWaAVJI1QT2AFwkx7ed4NMYxAQk5HKAu6bCIT6p86djvAvdynb1sJVuBSTPdPUTFggCRxptwnF@vger.kernel.org, AJvYcCXSAEo7nsVS4pkO7GweDI4sV+9DdK1avQWmnVsG0QCmfu3s12Q7ig47CQ1uFkV4LGGEROXoYvXP9yF+@vger.kernel.org
X-Gm-Message-State: AOJu0YxBytdwSdRFATJp6X+xvWFCHy8+z/QvEkwFnbOvwq4zrBDiQ64u
	N57NOn4flpUOsGxH9PXfEvwNjd5sinfWquLhhRrdl85owF6slp3trxkIcuOd
X-Gm-Gg: ASbGncvQL5+0aKXGa+H4wd3gbvsNEJRaE3rlILqmSUm3YVrsK6/5OSDUB2pUfVHpajD
	ez7IOQlkDBXxGr9lIvoeJCIRuMMa62R1WYE8quffyKVDHxawLyQJXPtTnUhmDMe7cduMOccNkyg
	myUC88ppjane7P6Pfjit3k5qZeZoHXEn12aQJdeyKBD2OFfEskbNgT30AesUNQrINNKB9feUWuw
	vLKIapwWsRHTbqnl1Mn0upRt79YfrIFlLbBkSxkjZiU1RrN8rqBz2XTnJQMuUjh
X-Google-Smtp-Source: AGHT+IEujRA0A36aLkuS6cpy6MKnOsgT8lfTISL9cm4bumoexauwj4sgzoivPoOWFQM+FXLk+rZ+Tg==
X-Received: by 2002:a05:6102:440d:b0:4b1:1a11:9628 with SMTP id ada2fe7eead31-4b3d0eb96c5mr5449671137.24.1736435343867;
        Thu, 09 Jan 2025 07:09:03 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f4a5ddsm1019887137.11.2025.01.09.07.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:09:03 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Mario Limonciello" <mario.limonciello@amd.com>,
	"Armin Wolf" <W_Armin@gmx.de>,
	Joshua Grisham <josh@joshuagrisham.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Hans de Goede" <hdegoede@redhat.com>,
	Kurt Borja <kuurtb@gmail.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	"Lee, Chun-Yi" <jlee@suse.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Lyndon Sanche <lsanche@lyndeno.ca>,
	Ike Panhc <ike.pan@canonical.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Alexis Belmonte <alexbelm48@gmail.com>,
	Ai Chao <aichao@kylinos.cn>,
	Gergo Koteles <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH 12/18] platform/x86: inspur_platform_profile: Use devm_platform_profile_register()
Date: Thu,  9 Jan 2025 10:06:25 -0500
Message-ID: <20250109150731.110799-13-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109150731.110799-1-kuurtb@gmail.com>
References: <20250109150731.110799-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace platform_profile_register() with it's device managed version.
While at it, pass inspur_wmi_priv to the class device as drvdata and
replace uses of container_of() with dev_get_drvdata().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/inspur_platform_profile.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 43cb2a927fdf..543e4bce1a57 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -87,8 +87,7 @@ static int inspur_wmi_perform_query(struct wmi_device *wdev,
 static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
 				       enum platform_profile_option profile)
 {
-	struct inspur_wmi_priv *priv = container_of(pprof, struct inspur_wmi_priv,
-						    handler);
+	struct inspur_wmi_priv *priv = dev_get_drvdata(&pprof->class_dev);
 	u8 ret_code[4] = {0, 0, 0, 0};
 	int ret;
 
@@ -135,8 +134,7 @@ static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
 static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
 				       enum platform_profile_option *profile)
 {
-	struct inspur_wmi_priv *priv = container_of(pprof, struct inspur_wmi_priv,
-						    handler);
+	struct inspur_wmi_priv *priv = dev_get_drvdata(&pprof->class_dev);
 	u8 ret_code[4] = {0, 0, 0, 0};
 	int ret;
 
@@ -196,15 +194,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 	priv->handler.dev = &wdev->dev;
 	priv->handler.ops = &inspur_platform_profile_ops;
 
-	return platform_profile_register(&priv->handler, NULL);
-}
-
-static void inspur_wmi_remove(struct wmi_device *wdev)
-{
-	struct inspur_wmi_priv *priv;
-
-	priv = dev_get_drvdata(&wdev->dev);
-	platform_profile_remove(&priv->handler);
+	return devm_platform_profile_register(&priv->handler, priv);
 }
 
 static const struct wmi_device_id inspur_wmi_id_table[] = {
@@ -221,7 +211,6 @@ static struct wmi_driver inspur_wmi_driver = {
 	},
 	.id_table = inspur_wmi_id_table,
 	.probe = inspur_wmi_probe,
-	.remove = inspur_wmi_remove,
 	.no_singleton = true,
 };
 
-- 
2.47.1


