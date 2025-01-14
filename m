Return-Path: <linux-acpi+bounces-10613-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 787DBA10B25
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F601884B80
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9CA1FA827;
	Tue, 14 Jan 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKij4dNF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBA81FA8EA;
	Tue, 14 Jan 2025 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869131; cv=none; b=DrgMmuypa8m6hfg0uDUnpsyqeSHYr/wH+bp3UlsfhiGymJ63flLQLmOi24M6sjbunUJ19PII6Jq5dIyibrp9RQ6XlqXgRhSEHcIMfrQYyONv699Od7C7k6lXJkxY33GXgvs9NGzefB4yuHSdI9skdRRSUVHlwx/7d/mhL8rSHdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869131; c=relaxed/simple;
	bh=OtaXeoTDZtrNzDBhk1xT4EjjrFvsnzfn6Nw03ExD3zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fa7MGeRRIC98Je81McF9dHZitkoJJqE3aFd7uTtpklSczYKI8ZPUk7teJb7teabXtr3KRvbWm/YL6SNNYdmlMsKjGEDgGSkf7vI+ZqsCR9O4kG1K1nmuzZRqfPLBaDggWb23RVDnCtOmxrwQMjI8JW7Yu0jifTIjR2nJUl+pc8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKij4dNF; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-85c559ed230so1284104241.0;
        Tue, 14 Jan 2025 07:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736869128; x=1737473928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJniO3t7T19J4QvsezHavUaUIRpK6Ahe+WmaIyTfoGs=;
        b=gKij4dNFi0+nQ8NqZEXjlrrMocrG4wP2C13XLBa3ROtidn40go7LfaVFbXLtsuHmWh
         FoKOz+7HaR22WDcJDRskgbt7yrGb/JojEuMdAd5lSDwuhkoOxVRs7W2zaGsu5fy/fPlc
         DVmOgON0EqEq06S96l9Latoa+JaCaYcQTRrmU51GL9NOugUluh+ogwiK0pdH3/cecpL1
         7VLMujCv1N5fV62PnCXogSdQVdDKmb2o2uPOfTKsP3d4q7u6fh/BCSlIOK1FrkKPvYlk
         TOodt7db+tvUwk5Zt4Rj2J9ApXLIRHQMlLt5j9KpOrD2B0II23TmCmCFz/K87IlQOIki
         2SNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869128; x=1737473928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJniO3t7T19J4QvsezHavUaUIRpK6Ahe+WmaIyTfoGs=;
        b=B1Hr+bRVd/jangjW+En4zzFiGvuTSPQ9kiBc7JkQFNp87yllHpn1t/1ZKzxrOBwV2W
         hT0SLKHE0U/OXNOZDh9zYsDMpEQ9wMsNe8oSGL3nNHVcq7sloG5QKNExK7kAzQBND+Xc
         QYyfF4oaOF58NEJSlNODn7ZSSph9m+CRx3BlGo5PIClzTKN0PV+MH2k1CgkP3D1g8NfD
         1QL5Thf1DWKyHWkiro6mCLG8LvgCqFQ5h6RbucaWKXWdW0mByBrr7A1tQlWunK61Rgj+
         b27yiONuCfapyqoGtXqqzLLUdqfCPJRwjhCKYqBBphI9TZaMYnPjoqe0gJsqiU5n9ooO
         P37g==
X-Forwarded-Encrypted: i=1; AJvYcCW2mqJllTX8SfPCf9F2UJGOMXtCvGfD7dSZ2ZeJqymO/XosAqCxmoFqk5aW0a763RDHsOD/Ev6snK2C1qJL@vger.kernel.org, AJvYcCXlqJc7mP7YAdyeHeGnOvkd9fC5azw2vaiyckf4Hxp6NEQGUsCxbxMbCPz51et66JEsd+cTZWNxfsrM@vger.kernel.org
X-Gm-Message-State: AOJu0YwCJu5iXL43RjNVJ7tBkxZBLj7VpvbtfuLZqJ7iYOGyjxyUAVJw
	sJ+kepaPjrIbj5jANLqcSNJ85PKtwiXELDaY6dxxbardbX1XWFzK1aQPXQ==
X-Gm-Gg: ASbGncvC50tQdC+e7Fx01CX9I65vVb71UGymNY3l9vTz09OuKcsxW3PFJ+Oa0XoK49U
	h0YjJRYakvgjzjbTQlt+dLIdch0bWKXmadm8cXCtmLQW3bVicjvloU8I6HEMnpJbqSqtEQ/je7l
	Jk7BV/ryWvkF34MF5Wy3E8vCoAZN4Bz5Cyht+rFKT9A3pG/GilFNHyFNQsrUNssQUYMcuqlYQSl
	vAXWhRG8WyUhfMVEXOmynbcHeDwUWbXqBCQjaxL5WxDQwXCuyDS7Us108XLCoy6
X-Google-Smtp-Source: AGHT+IGBpePlxFwHjDm+w/jjW/Mci8UAISuPb4mMsDfb14ZKKq/DFpc9Dpm6WVP3bGjTFVVbws5/Ng==
X-Received: by 2002:a05:6122:32cb:b0:518:9dca:f0fb with SMTP id 71dfb90a1353d-51c6c535ebbmr20853048e0c.11.1736869128084;
        Tue, 14 Jan 2025 07:38:48 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cd7c56d30sm277e0c.14.2025.01.14.07.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:38:47 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"Len Brown" <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Mario Limonciello" <mario.limonciello@amd.com>,
	"Armin Wolf" <W_Armin@gmx.de>,
	"Joshua Grisham" <josh@joshuagrisham.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Hans de Goede" <hdegoede@redhat.com>,
	"Kurt Borja" <kuurtb@gmail.com>,
	"Maximilian Luz" <luzmaximilian@gmail.com>,
	"Lee, Chun-Yi" <jlee@suse.com>,
	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
	"Corentin Chary" <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	"Lyndon Sanche" <lsanche@lyndeno.ca>,
	"Ike Panhc" <ike.pan@canonical.com>,
	"Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
	"Mark Pearson" <mpearson-lenovo@squebb.ca>,
	"Alexis Belmonte" <alexbelm48@gmail.com>,
	"Ai Chao" <aichao@kylinos.cn>,
	"Gergo Koteles" <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH v2 12/18] platform/x86: hp-wmi: Use devm_platform_profile_register()
Date: Tue, 14 Jan 2025 10:37:20 -0500
Message-ID: <20250114153726.11802-13-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114153726.11802-1-kuurtb@gmail.com>
References: <20250114153726.11802-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace platform_profile_register() with it's device managed version.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 75bcd8460e7c..1304dfc65aab 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1652,7 +1652,7 @@ static int thermal_profile_setup(struct platform_device *device)
 	platform_profile_handler.name = "hp-wmi";
 	platform_profile_handler.dev = &device->dev;
 
-	err = platform_profile_register(&platform_profile_handler, NULL);
+	err = devm_platform_profile_register(&platform_profile_handler, NULL);
 	if (err)
 		return err;
 
@@ -1714,9 +1714,6 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
 		rfkill_unregister(wwan_rfkill);
 		rfkill_destroy(wwan_rfkill);
 	}
-
-	if (platform_profile_support)
-		platform_profile_remove(&platform_profile_handler);
 }
 
 static int hp_wmi_resume_handler(struct device *device)
-- 
2.47.1


