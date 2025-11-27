Return-Path: <linux-acpi+bounces-19329-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33135C8F3B3
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 16:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12FD3AF0C0
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 15:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BBB336EC2;
	Thu, 27 Nov 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL1wqSw2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9076633557E
	for <linux-acpi@vger.kernel.org>; Thu, 27 Nov 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256579; cv=none; b=te/e4E3nUhBvFNYfH0cRDhGffumwJvlecGFVNZuwCYlVzHQA/+5KnzNUMY3X51p+eaBlDKvkKZl/Z5z0ZzU1YrbAwh4nQA4imoD1YaDQNx9zlS8Kc7PWWxtrMkAjv3lEA8sVYfRDnX+GCiRvkNz4ClLTnyOD+TJMLbIfgdC85D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256579; c=relaxed/simple;
	bh=EAYHD0uflfQd6sszqckCoZM9plV9potl4DoHq6i9A4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItErqmjei+FZ582H35OjmlP6K9scC2ydVyke0yRuO/U5LRTJFH6ZebTRSD9Q/aGOZkff+C5hUbwsxv7r5+s2OAhJuaX7yARqEKBK0ZxGdU5lwaH4Jc9ZcB3iDQs0SOIsWt10Abw06PznFKb+LBGrghuJNV/LcwSvZYYFM5o/z6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WL1wqSw2; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so1146504b3a.0
        for <linux-acpi@vger.kernel.org>; Thu, 27 Nov 2025 07:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764256575; x=1764861375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SI5IT2ccA/LcmNZQUHmcdI+iq0zqrTHDtVhV8fx+VI=;
        b=WL1wqSw2h9maYpLMe+Aoz7zsV1mRG8SxFJEUoTLop1jyl9mr4Opl+O+jsYhQ6XSYCQ
         iV+TGTYl6pMZq+EiCGel0zZuQ0ha+bku6KXtjmYaidTcieXGjrycHkaZQ9eetuZetU3D
         2mPDV/wd/PSt6VQgm/mBcFeppx6jdSHZuEtbvkjmE1rj1FhGAjq6DdYckOsjZHgkXhu2
         zlEXGY0yo+A7GsguADhfca3aU/oNv+WRmfP3crf+xX6C+lsfCGDU2imbS1pcTT5oB+fR
         hBNafEJm/Ec/790+miaS7bSFo9WTAp4uB5qSV+7g5+jitsQK8G56hhH2AztpTg/cJRqe
         9Z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764256575; x=1764861375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2SI5IT2ccA/LcmNZQUHmcdI+iq0zqrTHDtVhV8fx+VI=;
        b=qhES/wgZB6kBXV8MnxlIIvv7dyndlNppX1UeD+dBSYe3EVYHNmgY7X5IKcGg5d2Lof
         7N5jQOtD3IV7+sY4nd7tt5DNIJ87QylJaE2t/CrGR5aTGyw3IZQcjBH+4sQjuCdTT0ed
         U/NdB+lU8jaULgHNSzKLy1iQxELEZSlNg2HGyjeJATB/6DrILUmrO8VbRk2Uco0UbHt5
         gH4jlLm9ruB1ulHK27zltIjhRv7GnhVb7KZtB1ias+deVAs+EJ1c1xyTucnM0VA9r2Ar
         oaInRxCc0vgpcxj7yyPApMrB7l9NdkMle5LwDd4zwidZz4A4lLZivybbpmBfgvTDsLwK
         w+wA==
X-Forwarded-Encrypted: i=1; AJvYcCVDmLgtrRRkX/gIBPMYkcn+g+MCjHQJ/I7/5a6zGqOPJxbuK4KxcCI7MFwREJWYW7gobqnL/szm44CD@vger.kernel.org
X-Gm-Message-State: AOJu0YwBdQcfKdlhn34asz6+MB/Y7N+IzsWN2ofZWjNLHVIpPWUM1l7P
	cF46fjShueYRdwl5czXhtvN9zYzRGkr5Yz6MgqgeBmMrhAiUxqdaLGqY
X-Gm-Gg: ASbGncs5xTNIfqgwJxouhxMjH3vs8tCDjJnr1wBhutLa1euEhCkfmYTSM1OwvLqSaR0
	aFyCxx7AJfCQ+7a+NMy9JU5dVoB7lp0e4zuURXo6EYkwGtfpxVjU6/MrfZpBrfjN72+flY8wy0R
	zBd4qKf4ti9jjtYfG13/vlqzEGnH/W2ubT2touWoh0G3vyvHRlbXTi/N16HlZ8Zb3wBQah79mqI
	xITnVADWmgquRJULn0NxN4LK9v8IAeeZaNB6V5740vcjt3tzHZTLCVbcHGheCfbKk4gUtAA91kI
	eoC365w7E4dYKKAsA4WSt8V5/FqQY8JOc/ce0pv3N2AyUkUlcIGLxPtvdLSLQObH9RR3WLAk+mq
	D/ZK+8NRYp7rq1/2AksAi9ZX/REFYz5BYIvPLjhpsEjX4NbGhjf7peXu0wKYLucuedVkF4rIKq7
	zOrXWdLZBBFz8I6r1gm0KjZFW3JY142Pae2yPkYkeEYhnIt+d0syQ5LCEXg/lysf8phCY=
X-Google-Smtp-Source: AGHT+IF2C4VQYvmJzN4VQiQ587h8aO8/w5xYj9vrh6mYj3laNxKF6BXlbjKrvVYNuGLe/wityRhDKg==
X-Received: by 2002:a05:701b:208a:b0:11b:b064:f606 with SMTP id a92af1059eb24-11c9d85009cmr11987237c88.26.1764256574538;
        Thu, 27 Nov 2025 07:16:14 -0800 (PST)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb067088sm5099656c88.10.2025.11.27.07.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 07:16:14 -0800 (PST)
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
Subject: [PATCH v4 3/3] platform/x86: wmi-gamezone: Add Legion Go 2 Quirks
Date: Thu, 27 Nov 2025 07:16:05 -0800
Message-ID: <20251127151605.1018026-4-derekjohn.clark@gmail.com>
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


