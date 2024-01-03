Return-Path: <linux-acpi+bounces-2695-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EB182316C
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jan 2024 17:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB72B1F24A4A
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jan 2024 16:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C2A1BDCE;
	Wed,  3 Jan 2024 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9cPQl5D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8F61C294
	for <linux-acpi@vger.kernel.org>; Wed,  3 Jan 2024 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bb7e50679bso961693b6e.0
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jan 2024 08:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704300168; x=1704904968; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BzlCR7QAEo8wXBHAZmjRG29JIGwWPeNycNkXZZBBC+o=;
        b=S9cPQl5DJijey2duLNW7yiODBAN+sslSEDwRssPHRVd+O/3ee/NEAWua5xGivRgMv4
         J+NMJ/yYz5xjmdiABkflIWDY75cc7O8Ce/l8DUrNT/woU8PmR7es+u0p+S8yypURGvdv
         s3K98M0TpRkfxqGOgOK0uOoL7uGnu3+qNhxbOamd6ASq7phesyhlvZuOo2ZiRCgenPSW
         TOs1TTbkOjIcL7oDlyqvKigIHObhyJMFQtxdc/LSqOL2H12xUpc6U2E98UmjIX/FFwAy
         CQnWu2Jci9xTADh66LoBpfhtVT9Tz8pppbQxRrVdf/a1z/XVAXshj2JCLSOOjRkQLPzQ
         pZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704300168; x=1704904968;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzlCR7QAEo8wXBHAZmjRG29JIGwWPeNycNkXZZBBC+o=;
        b=ljlsH5xZuypAcDIFmkFhifkNXdZ6VpzKo/kWDK+5Wy/GBQpJlXrWunNNIv4QkaghEe
         sw0i+lfAQBLW48XTtPlGJA/PdupazxPWNGYsqxjWIvTqjFzf7a4jdEkUwzk/a5ngG9vQ
         vKcmgzrX2DIoI8ungtbay4gi6tibVbV4P5DlS2meYKkZ1H+ZHfAKTD+uAeJWl/Hl38D/
         sb9qwZYmYL/spCe0n+euWEp5ea4CKYtOZCp4T9LxMtNwH6fWd1Cv7FbRUvsbmpe7kuN1
         cKQOzwdtyyzJffc9gLKORoNT47ZIbmTl/fxnS43fDvDQpwfszrMTLH2LDRpTbZYY4pkU
         2OIQ==
X-Gm-Message-State: AOJu0YwhYgmcmc6AqQLoW/CDQSiMbHRwoBBpV3MpMPzdKmcrx04M3lEl
	LlhbUezsQ0ekjCxuWK++fhA=
X-Google-Smtp-Source: AGHT+IG/T1ZdfwfPvZcfDS0j5/o9MNuvYTuOMwg0flmtTPc5C5iZIdMUIB/PT5MpMuaM28RlvH+Qmg==
X-Received: by 2002:a05:6808:19aa:b0:3bb:74da:bf82 with SMTP id bj42-20020a05680819aa00b003bb74dabf82mr41762581oib.4.1704300168449;
        Wed, 03 Jan 2024 08:42:48 -0800 (PST)
Received: from davidm-laptop (hlfxns018gw-134-41-185-34.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.185.34])
        by smtp.gmail.com with ESMTPSA id u10-20020a0cee8a000000b00680c9b1a407sm799290qvr.116.2024.01.03.08.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:42:48 -0800 (PST)
From: David McFarland <corngood@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,  linux-acpi@vger.kernel.org,
  Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3] ACPI: resource: Add Infinity laptops to
 irq1_level_low_skip_override
In-Reply-To: <fe82ff9a-3d9d-43a6-ae83-7b9953d3cb5d@redhat.com> (Hans de
	Goede's message of "Wed, 3 Jan 2024 17:21:13 +0100")
References: <20231230150916.1843117-1-corngood@gmail.com>
	<CAJZ5v0jab+jao4=7r1LOJhNn2Pq2fc_nQ1KS02_=9Z30Eyww9A@mail.gmail.com>
	<87il4a4ipc.fsf_-_@gmail.com>
	<fe82ff9a-3d9d-43a6-ae83-7b9953d3cb5d@redhat.com>
Date: Wed, 03 Jan 2024 12:42:46 -0400
Message-ID: <87edey4bcp.fsf_-_@gmail.com>
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
to irq1_level_low_skip_override.

Link: https://lemmy.ml/post/9864736
Link: https://www.infinitygaming.com.au/bios/
Link: https://lore.kernel.org/linux-acpi/20231006123304.32686-1-hdegoede@redhat.com
---

- v3: Rebased on bleeding-edge

Sorry, I should have realised based on other commits referencing the new
global array name.

 drivers/acpi/resource.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index c3536c236be9..575dad7aaaa7 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -489,6 +489,18 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
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


