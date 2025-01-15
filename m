Return-Path: <linux-acpi+bounces-10662-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 560C6A11AAC
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76414166CCE
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD8128EC97;
	Wed, 15 Jan 2025 07:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1yS7rdk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450E028EC8D;
	Wed, 15 Jan 2025 07:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925179; cv=none; b=be2yoCEv73BVTAHlY8PHT5e6rCkhHyxuEjljqq687nFLtI5/vkiGu7o1MeD4I3ux37vtRtLs/CjvpiHRtLka8dnRIPWn0u+yWZFQthweSqRcMI1E/w7fXIoLauSAVxO2gOkdL4RYsDcfkxdHfU6OzmuUP2ocL60IvBLpM5jy21Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925179; c=relaxed/simple;
	bh=SyfEQGHP6LGcWMnqkteiLZdrNsvZbSA19OO1o9QRFfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfdY7zhHUfZPKLV1fIZaoZSsuQHwe0AqEMi4s6S0gWC2FGi4d57BfnSQ1yp6DiHLH7P/c90K9f4ke6HD22hz8r0f4mQbwORkOw7vylcxUIBMMY7eZSkIGNbcQ1Sk5v8X2KD9EalaW259+8tKx0lwuOiWiLTtVMmA0yiUhiiwRLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1yS7rdk; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-85c4b057596so1386869241.3;
        Tue, 14 Jan 2025 23:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736925177; x=1737529977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aJR6DdYv47JT/4lcD3sQqlqAq2WEhI3FMDLoR8PT20=;
        b=V1yS7rdkcbKjWXvJbdMjga3jXoyXCe9mKv49+Y1UIpSSZBy2tTrvNUaW+LCq3K9gMi
         Y46/xWpasVIIryO9184dPfrcC++GSfQAuMHYOfH0NOSYZ07X7v8tGdVsf31J9zyF8Wwc
         wwlGZ/iNi/UQoS1VFXVB5rOWX5V8yV0QxehhMS/LsoUT6dNQRL9nANtvNV7sM5AQIJHU
         qUqsZYaoBzJxmibosOVsUR2VFzOMrbE+egSwbXomI8JvED1GmwCCwej3AKiNFraNkkIs
         CwjM+WlNMo1pfq6qWm4CE0gVAn1/0TlWHqW6ppAqYputmlN+seZ9pVjys2kW7sWxdmC6
         upuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925177; x=1737529977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aJR6DdYv47JT/4lcD3sQqlqAq2WEhI3FMDLoR8PT20=;
        b=i8hi0rdNhB+e89SK/T8rBs6yL4/UHFrxK2BhQO2uiG7n7SJ6QsUgTCdTjeXj18WToB
         7mM9omncwpQrJlbG42yAvZHeyu1tHtYxq2NifKHnqIDYLWBr3FCYTwxQ8HxDQz0RZhGQ
         SjYRI3TcbghLhD1/mJMpQPWHTMSNJH+ZstY0Wg56+o5qOSqlOwDmffl1lCcrTqFif5n7
         8HBIdsXFVlaFBSI42g2hQCj+0KMG9IX2GfRB7B+5evtIznkt1++zfVgn/7zox+ZepHAD
         TOOW7/1oYn4W3FCUchX6Az8guaZusBhUjSvjcjCfLU5iz+ufvugOgJfOe1IRPhaw+urS
         hV/g==
X-Forwarded-Encrypted: i=1; AJvYcCUdcF0vbC0IpN+qOG1GgN0k7Lp6FX6XIL0Vjgfxlj+OxMsfZh07he3Jc3H/isPU6amZMFVTgocQqWfF/xKd@vger.kernel.org, AJvYcCWrKWqrIjKzcf9ktR9Y7j1+qMpn2dI+NY6Q/PwEzKyHFQeOORiQpv9x3Eh5MY4BpDrM1gjsPEUvTyFc@vger.kernel.org
X-Gm-Message-State: AOJu0Yypjb5wXsVnQOMxkgv2FaoBo6PquXDHuLVS4uLDTSyHNSXtVCdI
	m5CZvxe35hhLgMOhViWCaGT86FS5ARaEPn6fhCk35dzhoulS9fo/q4+bJQ==
X-Gm-Gg: ASbGncs3b/FQE7qRzsCJww36jnmsoq4wYYSgO/aT6ZIDV1rjAA5UUddOjTWvilIrT8Q
	3P3yzahxphGf6m6vtBQFD/0cD4qCaxtx7iEEzw0kLyM3jNOWY8mpM6fX8x11/qjOij+xWaUTv26
	d/d5zk0zQwqAXolv48GUkUFn5rzMtg+oeQM4NlJbnR5apId8igR1vRZ7z+uR37eggUvNmTt1yuZ
	V56GPe/UDgq/AR6XzmCyT9JsEvhGTXlj7yVNcBjhDZHoM4mJTlbSZil82Dgaf1v
X-Google-Smtp-Source: AGHT+IHzzBrq0F7G+S/vKNe+90+H6gLjAkWejibhgo8I4PqoLhH6TsiDXllh/UFjt7wMqIg21XwxLw==
X-Received: by 2002:a05:6102:4192:b0:4b2:5ccb:1596 with SMTP id ada2fe7eead31-4b3d1069a8bmr25880149137.24.1736925176882;
        Tue, 14 Jan 2025 23:12:56 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f033ffsm5084366137.6.2025.01.14.23.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:12:56 -0800 (PST)
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
Subject: [PATCH v3 14/19] platform/x86: thinkpad_acpi: Use devm_platform_profile_register()
Date: Wed, 15 Jan 2025 02:10:17 -0500
Message-ID: <20250115071022.4815-15-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115071022.4815-1-kuurtb@gmail.com>
References: <20250115071022.4815-1-kuurtb@gmail.com>
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
 drivers/platform/x86/thinkpad_acpi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 5c250867678f..54ff3e6b8b1a 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10649,7 +10649,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 
 	dytc_profile.dev = &tpacpi_pdev->dev;
 	/* Create platform_profile structure and register */
-	err = platform_profile_register(&dytc_profile, NULL);
+	err = devm_platform_profile_register(&dytc_profile, NULL);
 	/*
 	 * If for some reason platform_profiles aren't enabled
 	 * don't quit terminally.
@@ -10667,14 +10667,8 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 	return 0;
 }
 
-static void dytc_profile_exit(void)
-{
-	platform_profile_remove(&dytc_profile);
-}
-
 static struct ibm_struct  dytc_profile_driver_data = {
 	.name = "dytc-profile",
-	.exit = dytc_profile_exit,
 };
 
 /*************************************************************************
-- 
2.48.0


