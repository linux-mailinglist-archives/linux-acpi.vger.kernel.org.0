Return-Path: <linux-acpi+bounces-2689-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF1C822F1E
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jan 2024 15:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D31D1F23A4C
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jan 2024 14:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693ED19BCA;
	Wed,  3 Jan 2024 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+Z4RH/e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155301A584
	for <linux-acpi@vger.kernel.org>; Wed,  3 Jan 2024 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4259e075f73so7544491cf.1
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jan 2024 06:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704290641; x=1704895441; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=am2HhNaBSuyUY7cDdseofLICnLKWP0etynAL2oIyWMM=;
        b=S+Z4RH/eS5N1QXj+56ycpYDsq2TQxuuBHwVqMgHSl5lmIt79+O6KpE+DNvtYV5GOKs
         5IvdcOK13TONEelW43PpD1KCPbC4hqDW9pm3J2rV1GAgUiIc6Ccu0VPAxluUK7/3jqZy
         yOw3wUx7uMdfp8em/I572poxSVaxek5ygOi6xzWl4/i0bCCVyrHdZCM9V1Yl6/ascfOj
         CzgWJoSm5gkO6Yy/t5tZjLgCsHBmI0YQHFa0TSfDO02JXBtuXyFWFdpWSUCujhHZJLfS
         3UpZ13j24QdaQi1FetbGX3SWKssrd8wv4YTW+IR6LVS22rh9S2tIM4try9wkFoiPXCki
         kdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704290641; x=1704895441;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=am2HhNaBSuyUY7cDdseofLICnLKWP0etynAL2oIyWMM=;
        b=ulvoF4NJesP/ZF8uL8SHa+rbXMTw+IXiQzchktD9jLbZ9OssSJBh765eZcgHhW5L9h
         0IFqx01Z4X17iwBc+3Bdn4XQLUL2p20LHcO91BKUYCkwTEkFL7DG16pcAB/x/8iaL2Sv
         /adahOk5QIR8TtcGiTN5su6KKXJmX5hGR3hj5xwLhlwnJSLjbfYKcBcC0eOh6crMe+/H
         khIAMZSqs+ilU0NAl/dxLiJZ55OMcZWF54qTkyPxE2l51fpEkKy5N2TFVxRIV+66g2yG
         YbQ03icoKujfgZwQYT6Q4+0oHlrvnM28KcUr3zrqNlp4cubXtVzwKXAcu/vouCjkBj5v
         GF4Q==
X-Gm-Message-State: AOJu0YwtUL0mFliDCP/j8JCHdUjiYGQ9ZxNCF9XuAI9y7s77N8WyURHK
	rkQVjNvggLGaVOMV74e6Mew=
X-Google-Smtp-Source: AGHT+IGCccxJDs97PskujUMZAQ9fTjSC0JDbVxBf+aUBESpbIosIjFaBdG9rtLTstscWgkUkJ3mc2w==
X-Received: by 2002:a05:620a:1926:b0:77d:9ac0:61dd with SMTP id bj38-20020a05620a192600b0077d9ac061ddmr42448778qkb.2.1704290640876;
        Wed, 03 Jan 2024 06:04:00 -0800 (PST)
Received: from davidm-laptop (hlfxns018gw-134-41-185-34.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.185.34])
        by smtp.gmail.com with ESMTPSA id t15-20020a05620a450f00b0077d78c5b575sm10120613qkp.111.2024.01.03.06.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 06:04:00 -0800 (PST)
From: David McFarland <corngood@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,  Hans de Goede <hdegoede@redhat.com>,  Mario
 Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2] ACPI: resource: Force irq1 edge low override on Infinity
 laptops
In-Reply-To: <CAJZ5v0jab+jao4=7r1LOJhNn2Pq2fc_nQ1KS02_=9Z30Eyww9A@mail.gmail.com>
 (Rafael
	J. Wysocki's message of "Wed, 3 Jan 2024 14:47:43 +0100")
References: <20231230150916.1843117-1-corngood@gmail.com>
	<CAJZ5v0jab+jao4=7r1LOJhNn2Pq2fc_nQ1KS02_=9Z30Eyww9A@mail.gmail.com>
Date: Wed, 03 Jan 2024 10:03:59 -0400
Message-ID: <87il4a4ipc.fsf_-_@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

A user reported a keyboard problem similar to ones reported with other
Zen laptops, on an Infinity E15-5A165-BM.

Add board name matches for this model and one (untested) close relative
to tonfang_gm_rg, due to the board names' similarity to GMxRGxx.

Link: https://lemmy.ml/post/9864736
Link: https://www.infinitygaming.com.au/bios/
Link: https://lore.kernel.org/linux-acpi/20231006123304.32686-1-hdegoede@redhat.com
---
 drivers/acpi/resource.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 297a88587031..6b64ea4e9c80 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -484,6 +484,18 @@ static const struct dmi_system_id tongfang_gm_rg[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
 		},
 	},
+	{
+		/* Infinity E15-5A165-BM */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM5RG1E0009COM"),
+		},
+	},
+	{
+		/* Infinity E15-5A305-1M */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM5RGEE0016COM"),
+		},
+	},
 	{ }
 };
 
-- 
2.40.1


