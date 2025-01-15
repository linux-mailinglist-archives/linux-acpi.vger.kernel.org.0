Return-Path: <linux-acpi+bounces-10664-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EB9A11AB1
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297253A1F4F
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC903DABFB;
	Wed, 15 Jan 2025 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPvj0b+o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCF23DABFE;
	Wed, 15 Jan 2025 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925195; cv=none; b=Q8zO5f8/43OhK32ZKtqGkrVPnrw1Tbvbacajq95ReOQKIvcIKrBMzox/83cFNiphNJjr9+KN0gv9L+3Vv/EhwVMJy/2UvpdQPoIhnFOcIR7N3Ev/zUdfZloqFkCMvCFI5DXz177equ55AZATZEIMCUDh0cQuiLTxOGzsCgn4Gio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925195; c=relaxed/simple;
	bh=peKlMULYKbhUxnauJG3cMHQTyc0I9bp43emAqauWqho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lr2G3Bc8pCM7fERVpF7ypQFxsNeYYG51cy8dRVdiVyOkyykQiUeXm+C+NdEKKkvL4TdD+8OOxx83RPhq79S2iMNXSk3CaeeGivdmiIv0pMk/IGAEx1Rhg9Z3Uc0H4Z03s4JR42h8uRPyLAhB8bgSIpmKpTPNM0HXprSNxEpF9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPvj0b+o; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4b1279ca1d2so1870198137.3;
        Tue, 14 Jan 2025 23:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736925192; x=1737529992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgDJuLF/A0sxRdnv5k+7wxzIykATCCCsCWNWr0UTVc0=;
        b=hPvj0b+ooZGsTGQAuYeUBYwf98vm8CAacnBmI0fiRdsxABfyHVN7J3OZT/A24X3CLx
         C/kHvh00hgPQnZFmku8/3qsVSWqNdqYm0Hi88AlfJZGnMbvItfQ36zc00Nl2ql5qSEc9
         cxS4sby4pBmFvr/tHx0LyxupiNxFPz8UTf6n8EYQopFVwQaWbl1vP0CC6Mq3zYHIt+R4
         BWKkj2xEqMSff1xgQXT9qILj9lstm5h1fXmNprGIvsJO2P9nfltg1jG5IVe0DlAl6GBu
         i0ghmWbGEO9o57LDaF7syR7+wRRZZYQ+AeipCTkv8TCIw0lIFVkrvnA0sCWpSob05ORG
         GxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925192; x=1737529992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgDJuLF/A0sxRdnv5k+7wxzIykATCCCsCWNWr0UTVc0=;
        b=UZQrvIDSlw4YrFWFmKzSc0TzsHzbZpGLNQ5joHU0yNk3zHQYC0SQQHSD3LbLfJXsZf
         jU8igsPal9iy+Bn6/f8Pp+kzHLKofrqAjPebM4+wuDZmLEYQEecTcXwqaLH02BpzJwta
         lBc2bJWFS7w5kqnERT7nVga0TlMTxMlJG0SESZRoy6eNk0SN7enByza9SDEf+vQAnZP5
         p6MwKUehue9ojzddMmrF0BL89M7CJxi8pWE6gxng6t4xyrdo5wqaF/1YqR/4QnqyL32F
         0UYqTbzIVSwO4shEOGG8KnF9LEyWFkl6HSJv6G6tR9rpEvyOLyuor1d4r+8TxfSn3Fv6
         UjOg==
X-Forwarded-Encrypted: i=1; AJvYcCWb0hKwWlT/xHT3ccBdX3JsNvdH/ZKUVERchpRJP+2vmMYyUUIzXZc/qxseSXwyzJk9rk2meUnez1WUXywo@vger.kernel.org, AJvYcCXf74i3Y3LqjAdNoZByeQjc6NXprS3VhhPB3P2z3aUEmniQzTSCo9hdguE30uVJz0sScZL7eFIQaMW5@vger.kernel.org
X-Gm-Message-State: AOJu0YyhRX561gAgWKTjj3reg2uUKpjbmxzNI3E7XILr39ov0x9nq+uu
	5nnTp1shnIU+of2erP23WNfUrHXorQs5ASIIVv/BkGrVlKjhTNMYgRdO5g==
X-Gm-Gg: ASbGnctkp/1oHvPxDgFvPp5iJAObStjAPmeaja7pZsCKwt4GI6LkD4K+OQglr5/aOgI
	O3j1zIBHoj9QlOjZ/a9JqOys/O1ami7T5ehbMNN3lFpk17Q6DCE387FHxzMkBqKVghacja6CSgn
	UJCqXfcgR3p4FzjyTEu1sgfwWoPDR2VBbSLDNrN8jXimxe96gmbVA50gGcc3V2v9YcPitd8jPMj
	0q1JzaHEYXIJRQA3QJk/Sa3j2pvYCs8a0uZglVYe0yy9HlkLPv6PSwYEZy4MDp4
X-Google-Smtp-Source: AGHT+IGAjQBi0cdKj/tm24nvCo/6aX7+GLTjz+iSsgCQ6G8Z0ARTz4gA+mWCkkDZZqfleBVptRt6BA==
X-Received: by 2002:a05:6102:b02:b0:4b2:cc94:187e with SMTP id ada2fe7eead31-4b3d0fb4cfemr24376348137.18.1736925192274;
        Tue, 14 Jan 2025 23:13:12 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f033ffsm5084366137.6.2025.01.14.23.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:13:11 -0800 (PST)
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
Subject: [PATCH v3 16/19] ACPI: platform_profile: Move platform_profile_handler
Date: Wed, 15 Jan 2025 02:10:19 -0500
Message-ID: <20250115071022.4815-17-kuurtb@gmail.com>
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

platform_profile_handler is now an internal structure. Move it to
platform_profile.c.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c  |  9 +++++++++
 include/linux/platform_profile.h | 11 -----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index a1dfa168f51f..f27005a267a1 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -14,6 +14,15 @@
 
 static DEFINE_MUTEX(profile_lock);
 
+struct platform_profile_handler {
+	const char *name;
+	struct device *dev;
+	struct device class_dev;
+	int minor;
+	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
+	const struct platform_profile_ops *ops;
+};
+
 static const char * const profile_names[] = {
 	[PLATFORM_PROFILE_LOW_POWER] = "low-power",
 	[PLATFORM_PROFILE_COOL] = "cool",
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 778d4c661c3c..eea1daf85616 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -28,23 +28,12 @@ enum platform_profile_option {
 	PLATFORM_PROFILE_LAST, /*must always be last */
 };
 
-struct platform_profile_handler;
-
 struct platform_profile_ops {
 	int (*probe)(void *drvdata, unsigned long *choices);
 	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
 	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
 };
 
-struct platform_profile_handler {
-	const char *name;
-	struct device *dev;
-	struct device class_dev;
-	int minor;
-	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
-	const struct platform_profile_ops *ops;
-};
-
 struct device *platform_profile_register(struct device *dev, const char *name,
 					 void *drvdata,
 					 const struct platform_profile_ops *ops);
-- 
2.48.0


