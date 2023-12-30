Return-Path: <linux-acpi+bounces-2646-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E94278206D7
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Dec 2023 16:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FFC281DD1
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Dec 2023 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D74E8C1B;
	Sat, 30 Dec 2023 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHK7wras"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEB78F59
	for <linux-acpi@vger.kernel.org>; Sat, 30 Dec 2023 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-595564b5764so8038eaf.1
        for <linux-acpi@vger.kernel.org>; Sat, 30 Dec 2023 07:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703948966; x=1704553766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K+5a0h6kawcvXMQO0ceQqDZ7266onlQzKRqNiyfwbms=;
        b=PHK7wrasI7dmYGGbPCTYbZ8ycJrqFwcwZTfOQ/ytF3DoDQAzy8o6fs2mRtvqGaiqk/
         iBX9KDwgghwQrCMQQLyEEjMCR0F/GXWLdQ+nTo+lIKZwaIm/nDlpFFjfG+oTUK9m1IlU
         J/d0Y2tkx97OWKG4bD8nhGKAcqMVb51ghfdTYJIBROjFHDlLU+Pdu74K/A76RCPdKzi6
         CT8bo+SiSaMrQsk4veIbCi2tT7fABoEk+gVL4/3dk6Ygtsnp+zAPT1iqpszjdgT8wfTl
         wQQS1M0FnZQ1uixuHXaCTFoAzIY01vOMHtz4RAKOMeY6mSNfU+fRP0gTxwKmXHRZpkUy
         gu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703948966; x=1704553766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+5a0h6kawcvXMQO0ceQqDZ7266onlQzKRqNiyfwbms=;
        b=qI6ffSLV7sPIsoTd4pesRWxrCB/ocyKIxiD2CB0WVt8tujJfzSC4yvyw4tiZBt0RCP
         Zd4GkrL/oB+0J6Wyf1CzGdWbGFYr7GEd88u1b/OY6GkNxrNbRkfdnJO801969/C6my7e
         NUJOpqDIHlSD4LON64SLzwP1abyGVIKIYbitQFZRl3HW76pa14pt0EBdcYWJgYDJyfyq
         sI8Ri3z0iYLq27JvJYlqYHprHCA76UDUITwUjc0BHLOqqGaNENOjkLqCQf7+YB0sGvTT
         vyhcEElbZkK7vUAVUEWLnjw7nNJ681mQDfRiOVlCR7QXMwqPmJWEuWtDV5ze7KMBHkSy
         qCtQ==
X-Gm-Message-State: AOJu0YzFL0Zzgy89RskUTkVtXJfFaXykgcWYvj6rQXTflkzCe+jm6Si3
	2mqNyBbUtM0ShummIRzGgSfUije4Qus=
X-Google-Smtp-Source: AGHT+IHRla23pS02frgizSFQbOhWs9fQRhv0BF6RwYxVqH5DcHekxH3OBG3qlO1+EFHazisaGzyEEQ==
X-Received: by 2002:a05:6358:6:b0:174:f246:9e28 with SMTP id 6-20020a056358000600b00174f2469e28mr13574208rww.0.1703948965837;
        Sat, 30 Dec 2023 07:09:25 -0800 (PST)
Received: from davidm-laptop.home (hlfxns018gw-134-41-185-34.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.185.34])
        by smtp.gmail.com with ESMTPSA id x6-20020ac87a86000000b00427f00990b1sm3499324qtr.28.2023.12.30.07.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 07:09:25 -0800 (PST)
From: David McFarland <corngood@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: David McFarland <corngood@gmail.com>
Subject: [PATCH] ACPI: resource: Force irq1 edge low override on Infinity laptops
Date: Sat, 30 Dec 2023 11:09:16 -0400
Message-Id: <20231230150916.1843117-1-corngood@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 297a88587031..f692604b773c 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -484,6 +484,18 @@ static const struct dmi_system_id tongfang_gm_rg[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
 		},
 	},
+	{
+		.ident = "Infinity E15-5A165-BM",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM5RG1E0009COM"),
+		},
+	},
+	{
+		.ident = "Infinity E15-5A305-1M",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM5RGEE0016COM"),
+		},
+	},
 	{ }
 };
 
-- 
2.40.1


