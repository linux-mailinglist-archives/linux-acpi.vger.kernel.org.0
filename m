Return-Path: <linux-acpi+bounces-10704-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A88A12FC9
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CDA67A3123
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 00:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BF478F40;
	Thu, 16 Jan 2025 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOJAQkxl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5B770839;
	Thu, 16 Jan 2025 00:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987287; cv=none; b=XKwJNjzyhIgt2GLYki+d1EG04adPAEU6xC+AuWD0RbWqiBhyIPnhXMXRAow7gVUm0ACG9/GMF/t3RtD9Vk/T1gfqlpUqFj+Nb6BXAqDxuaea+LF3kVtAtoV+Fm5eNSzuh3TCgGdZSQbpfwhRhfhLLwTwi+Gi7W44Nufb0PCWfms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987287; c=relaxed/simple;
	bh=sguZygPLbyJOctvX0uUgwRDSSW9Koge7hOKBBLBwBnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RltgM12ePtEo2MlPUfXGwZLcGNmJ3NKOH0RdwDAjtlwdOnPWclEQZf69FZIA7NmG25CYh0AdVmzB+TqvHZqHBCwcbpJ8JqyvxnZkrhBB3cJ0LyXONu/7GgPsiKX+fvwGOPL35Bg+wW1FhygfIc5eu0IG7whhVrejyXpu/av+hf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOJAQkxl; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e53537d8feeso629327276.0;
        Wed, 15 Jan 2025 16:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987285; x=1737592085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKkoYd0q2q/OHzDbyA/33XiyMuA6S/vNHJ2GgcskFpQ=;
        b=AOJAQkxlyV5/whCPB88uc+mD9X3gZfmo8D5EIDzRNgEZOfiq/YrgKcJfd2mdF5VTAi
         AVRCYxTiQ3vRHeW6TpLEhpViQey3r9laMIsRlHERpkSztewU88pqKtquHCietplFg0RF
         pJeEyRYmqZghuM7bCNUpKXgbqeNCNJ9iE+dDRIgNC+QmQiIWgN+1MXLRrEpZhl3TNSk5
         gBV+PZBX3lvm/qTMKRiijTZfV6GCFlH7AFPIGxa7x5wVYnRj7ns1FQALUm2llYBY9Svq
         U3pawWIdsot8GszC1vUWhhw2OlcfyPnJCIdCYflTGVvos24+GDjLtABjlu+60YUHOXOg
         q4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987285; x=1737592085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKkoYd0q2q/OHzDbyA/33XiyMuA6S/vNHJ2GgcskFpQ=;
        b=KTtqOBBgARie9EAmNrMOuSbf43hMitSY5u/ZnIJpHlR0PCRCNPVIwGGs3ps7s8pDsb
         syv7umAVRAwDHJKkpjz8mvErVvLI9QCU6BcLC42nDGCyR0lP5n1aKyL1X9pA4fM4QjWg
         H+SoLvjGGCj+GNaR8ij9C1tUBefLkrO3KxFNqinu0KSCy69h7kzSzrvjr7Xc3uKnP9n/
         oSTeyVLIwW/XK8FlVgPJthevtwQi88Ywctol/znUvUioC6YYDxhqeHDOHgO9lmETkKvq
         pzyXxaLQkWR0N28hpCqmdG5n+JzaWJ5IluRuISnjx0VvUEbopQ1uyPP/R1q4M8vGBd+h
         smWg==
X-Forwarded-Encrypted: i=1; AJvYcCWE6wXyXycfFQqp1rSQySsWYqvQDCvXX84dfLu7hMlKU63+P+5OsM5qQLTQcFibPRPlpdUhRi/UgxmmJlZ+@vger.kernel.org, AJvYcCWQyxj8yH26GiNgKip9QJM4Wh84jW87hCPcT6oah8/d4BSwlzsBO3HBJ8vtmS4dsMgVwE/1GjAdjXYd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4J6diPNB+tFFnjykpFYAT/phN5dykSWP9WMmZtfDWEZZHXGvC
	DuQuKTDKC1nbGr85aCu2N1LuuWpuNPtHu3d/ZAjdPQPW6AooKHzMOIwusA==
X-Gm-Gg: ASbGnctIv/O8phIfbHVty4r561Dpc4srF1s1GZhUq8h63gWxoQM14+KBp7TMfcgnlN4
	acjnLCocKXus1/W7JfarCk5V7hkLMF5QoKhJuISD2CFHbhePYXmkymdXhzsvfTd3Yv8osW6kbnC
	BUSwmmk1OhmdkqIsWJnq6Ue1lDPEi6WLcoc9HJUYrcIsbu6njl45yPH0Tx8rUXB1Pu5Lnbzdz+w
	1U0Sox5kOLaxe2nttSwmFpREwQObVohYLAss9+Fd8DAUPacQBLaw376+gqwN9O1
X-Google-Smtp-Source: AGHT+IHgBf+VBtY99Jhaip5v7Ep3qqpeuYxcQ6hzPYWCUH4wwhKw3eAWL3yuxyek0XKBQL59sf6FNQ==
X-Received: by 2002:a05:690c:23c6:b0:6ef:7312:d05e with SMTP id 00721157ae682-6f5312398f0mr277603527b3.19.1736987284950;
        Wed, 15 Jan 2025 16:28:04 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bdesm27229077b3.50.2025.01.15.16.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:28:04 -0800 (PST)
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
Subject: [PATCH v4 07/19] platform/x86: acer-wmi: Use devm_platform_profile_register()
Date: Wed, 15 Jan 2025 19:27:09 -0500
Message-ID: <20250116002721.75592-8-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250116002721.75592-1-kuurtb@gmail.com>
References: <20250116002721.75592-1-kuurtb@gmail.com>
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
 drivers/platform/x86/acer-wmi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 4d62a61cb241..d201ca0e01d6 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -2080,7 +2080,7 @@ static int acer_platform_profile_setup(struct platform_device *device)
 		platform_profile_handler.ops =
 			&acer_predator_v4_platform_profile_ops;
 
-		err = platform_profile_register(&platform_profile_handler, NULL);
+		err = devm_platform_profile_register(&platform_profile_handler, NULL);
 		if (err)
 			return err;
 
@@ -2684,8 +2684,6 @@ static int acer_platform_probe(struct platform_device *device)
 	return 0;
 
 error_hwmon:
-	if (platform_profile_support)
-		platform_profile_remove(&platform_profile_handler);
 error_platform_profile:
 	acer_rfkill_exit();
 error_rfkill:
@@ -2706,9 +2704,6 @@ static void acer_platform_remove(struct platform_device *device)
 		acer_backlight_exit();
 
 	acer_rfkill_exit();
-
-	if (platform_profile_support)
-		platform_profile_remove(&platform_profile_handler);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.48.1


