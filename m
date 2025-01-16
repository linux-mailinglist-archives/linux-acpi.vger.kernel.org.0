Return-Path: <linux-acpi+bounces-10706-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAE6A12FCF
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96E81660D1
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 00:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D57E13AA38;
	Thu, 16 Jan 2025 00:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnY17bpd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7741F13635B;
	Thu, 16 Jan 2025 00:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987295; cv=none; b=FJwezJd7f+bEwHzjoBx0WdW+aZsfwPTFuq0dAyCu2i6Ayqd5YtId9ifYrGxRu5IumEX5heimFgNreUDgevkrlzi43oLgWgSNb3gNw1Xl98I3IdbjJVZXz6Q0maIZvhI5zVWfmeACfTJ0VWGR/rObs9OThOZ3NUbG+Cc27wfq84I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987295; c=relaxed/simple;
	bh=JfmFlGKxXkJnyQgsY5mWDMnSLwBEOmQsizMRgW1LcWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uT3Pi/cVKUMQE1ilRYiefx/Oy1sjI+jwuGzxPVDyAv5g0o/WIblE83etfMJijDa3u4abLXht8sp2nE4QZ4ON4gCPcpIYlatxblUNM1PGnp6OyGa5GU/5VRLYiPOT05+MzsLuV9UsZ9OQ9GUHi+0g9nTGFMVaBVdXbXWwUnTn4co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnY17bpd; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e54bd61e793so723203276.2;
        Wed, 15 Jan 2025 16:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987292; x=1737592092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuLkcK3Ctj1sqTsmObJPyaZYWZ4by3q++1JQzw3spu8=;
        b=YnY17bpd4at+P8DQb7ijDZSLSKOzyIsXueUE118obH5IYJfU7fVLf/7vNGJhPQhVj4
         orla1zKZnqeRW7gzJ+GeZBjIO39DnsRy4dJe540+Z1PWkXsIhUZAUudxBP8m5o2qxYn0
         MejStOO+cqCuGwE2dvCENyE1FgL/KKrPWv802pZ+5X3zy43nLaI3OgelkDV6AExfolkn
         uNmcNTf70glYgB8np7edB6jFo9psKw7tu8Qje5GdqXzJrvzrrlhNiKNUx+j/HYBybH7E
         vat2dKXlvne443o/3t2U1brHr+foI1oEw6qfvGVn67RefeGnx5oSym4zQXir5dTXwM1n
         Asjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987292; x=1737592092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuLkcK3Ctj1sqTsmObJPyaZYWZ4by3q++1JQzw3spu8=;
        b=DIML5x/BJjwJujUnPhJZ4jg2t415rSQzb4+fQIqTixkbKKqGViZRS1qQ+vECSxMN+y
         II7xu4AZoG5aistZ9w6/XHPk7CWhhDAjfMnqSn7y15/5vyo1KAvSJzqgdD0iClMMd1QJ
         eXAp2MSHfyBaxUHrMsFjbRaQZVUS3oBRpSkP/gQZ+f+jP5kfX5P7ShM6/Ihms6ED78zg
         eeAFSYqhMngbjvnef3BeN4mPfNOu5bTJnrIHVuQU3Tk2WvSTLKBmmoD0n87KDDgYB3Fs
         KYo+H5SC8Ar9N8N0Q+qEEEJexclHPV7Y46vWygd4X5i1ODbEN4X6UJyLXatf9h/7Ykt6
         JlFw==
X-Forwarded-Encrypted: i=1; AJvYcCVgVF7ugLFdOz11zDj1kBWD0rApHkr8JfbcfAqN82vWyaDUvnzfJYq5YFVDHXZIroo62C4VK+TVdssuSxlF@vger.kernel.org, AJvYcCXt7wAamVno1sz4JDcz+6oKg6UUGaLin4vr0/Djq3tQloOQSsb3VfIe+Lck888hjWiX3o0w4XyyK7yi@vger.kernel.org
X-Gm-Message-State: AOJu0Yy09sAgMcIER8XgcVugQY6Tp+gYbn3JZ5Cu3gn+28c+MlXbVFs4
	h9uY27QE+PrRLpM+jmQ+DvS/tD7L+IjSRQFEhEIWFBtTFO7yvPCfQCSzrA==
X-Gm-Gg: ASbGncv0HmsU+/fRPDOLjMpXEuJWBKLGvzJM9v6n6CM8s6lpMET+ZYfPp92yRcpMCN7
	Hd4NkqfstN24Bfy+AY0yNRbUX9cBFA1HQR4Q+YEmIIiT5DdTx+yL0fKHFAIN1n3NOR2yjzBtP9C
	xljGvw6Jx03AExYPGejgkUN8C5WZ7gKZVXe2sl9p4rTz2aQJuU5eNH6R28Sl0zn0ogOU5cpH5p4
	1pn/cw/y6YJLyswYoS04HVLkxYnPkTWJkzaoY4UqRUMZVkxGn3TAT8UrZepYAS7
X-Google-Smtp-Source: AGHT+IFytx1Y6z/zCJyAP/uO9OWAKT3dJoayh3lZfJ6bnsay/1lCs4+d2N3PnLaOi0X9hPas6zu05A==
X-Received: by 2002:a05:690c:387:b0:6f2:9704:405c with SMTP id 00721157ae682-6f531224982mr287535497b3.15.1736987292109;
        Wed, 15 Jan 2025 16:28:12 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bdesm27229077b3.50.2025.01.15.16.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:28:11 -0800 (PST)
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
Subject: [PATCH v4 09/19] platform/x86: asus-wmi: Use devm_platform_profile_register()
Date: Wed, 15 Jan 2025 19:27:11 -0500
Message-ID: <20250116002721.75592-10-kuurtb@gmail.com>
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
Also replace pr_err with dev_err in case of error and make the error
message more user-friendly.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index e775ec7371ce..dc713a5d8042 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3895,12 +3895,9 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	asus->platform_profile_handler.dev = dev;
 	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
 
-	err = platform_profile_register(&asus->platform_profile_handler, asus);
-	if (err == -EEXIST) {
-		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
-		return 0;
-	} else if (err) {
-		pr_err("%s, failed at platform_profile_register: %d\n", __func__, err);
+	err = devm_platform_profile_register(&asus->platform_profile_handler, asus);
+	if (err) {
+		dev_err(dev, "Failed to register a platform_profile class device");
 		return err;
 	}
 
@@ -4859,8 +4856,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_sysfs:
 fail_custom_fan_curve:
 fail_platform_profile_setup:
-	if (asus->platform_profile_support)
-		platform_profile_remove(&asus->platform_profile_handler);
 fail_fan_boost_mode:
 fail_platform:
 	kfree(asus);
@@ -4886,9 +4881,6 @@ static void asus_wmi_remove(struct platform_device *device)
 	throttle_thermal_policy_set_default(asus);
 	asus_wmi_battery_exit(asus);
 
-	if (asus->platform_profile_support)
-		platform_profile_remove(&asus->platform_profile_handler);
-
 	kfree(asus);
 }
 
-- 
2.48.1


