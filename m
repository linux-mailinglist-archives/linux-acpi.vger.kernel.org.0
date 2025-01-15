Return-Path: <linux-acpi+bounces-10658-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B15F2A11A9D
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A4618879B9
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76100234CF9;
	Wed, 15 Jan 2025 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0Ps1oi9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEAB234D0C;
	Wed, 15 Jan 2025 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925150; cv=none; b=UpuilNuz58ZomHdVQtY5IMA/QhsJlIHhvvVxwoRnU3XfbFUOtSVEuAFmSwHS1qB5wRkdgZQItl5njPIndumi9+3o0N1VawTRjgFj3HgiDqd3ozQF7b2MLdmkT8/2alc1jyhOwwgfSXW3Z6ZtKSwCiI80/xU7ycPPRcmFuS1geLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925150; c=relaxed/simple;
	bh=si37KGSHX/ewSFMJ+nzgzSZQFSgJ2idpK6K/FB1yymg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TE1O7C+eoHpsDGrj9S6YiVrKIf1MhaJ6yLQg5JtIy4r4BldtGzX98CVqFa7tE0gE+X+0PARC52pdjNSMg3ZfCJ/euMqQgBaWcwIhHKr18xgOjtm9OuoNLS7IbkjgyMNuEFCmOwz/muxpDas1+uYYRceKDpxmwJKNXSHtC30+ZAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0Ps1oi9; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4aff78a39e1so2091156137.1;
        Tue, 14 Jan 2025 23:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736925147; x=1737529947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXqMhXSFhpzzUaGn7Ji6wnQLUeEerxmcX7mppMJSFzk=;
        b=P0Ps1oi9A3EFjb0NQHlfWPg6e/V5sea9d+7BTxhXadowEOb7OqADkaTcnRvTX1bbcg
         ScxQJ7VsqodK/Ig/rwAIkq7W5cKG9Om3L4sudKSwl2DrAJR5L/r3qVW/3gsWZ4PQgZa1
         GDtiHE+HDje+hAd0xVJDJAvgpdzRvtvmsz2HBVdcS1yU2vbOfKcmVfk0Boi9Qec9Gr93
         xCvxWIQ5bRmtS1boHbVGjw1yLcpcI7oRdUIG+Py1oyaZTgUa3VtF1chSRiQnNM8FQ8Fz
         qGy2Y9tu0Pa7NpBxpKTBbJMfT7/5XqhqPnpJ3mxj/T1qmDmqL9ZQQ61M2Kdqbbw7EH5E
         x3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925147; x=1737529947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXqMhXSFhpzzUaGn7Ji6wnQLUeEerxmcX7mppMJSFzk=;
        b=luB8Xm3FBeS27PeM4VSXkU6FLEKJGQAoRCT7Pl+p7IG+Z/vyDOdEAzv45+ivI7crss
         Z9VVuqTB1xUT4fY07F4e0nlm70QIdw69lrLySkX+h8DeUVVMXuMFQl8E+Qlq4anVszes
         Sr0fWukMcCcxCsIoDmGrxkjL0n/0oGJWG27WWE+fkC0nL62hQApUmYr61dYvS3nyAG9s
         4u8/iDrfmCLq/xYyTlr/I1U9Xi3xlZKFjbLpSPKdoZUhJuolvyfYp5aTvGhhUQgiSkur
         mOjKW5Vb8OetMFyyG1Ph7OT3/Iz/q6P1JI33LfhR1kQQuHRgXw1k97pEdRDDmbza8v1W
         kXqg==
X-Forwarded-Encrypted: i=1; AJvYcCW7+rYxIibSPNK3CugYz3Isgs1nFFMwFCLtLAilRzEYYNEMgM5cTcrjn8oVPPPmgCp2/08VD7P1Ru7GUiNg@vger.kernel.org, AJvYcCXl8rLgm5Vh2qLgxNubgUSMnqnUp+ZIqVx6T9p6R+xasqVzdZHatsDdafRIPaCf5D0oXXxgKegMWvmM@vger.kernel.org
X-Gm-Message-State: AOJu0YwAK+EmEwaVjcd4ypO9zR2ANxWG5SGSOb07fkbaa81A2nyvUr+i
	yiyGYiQWozKWX7u1J3Ro3v7a3ZQgph4ErzBQqXO1dOP6Ne6Q3e6Xk9NqzQ==
X-Gm-Gg: ASbGncuSU8ni05eUU9JKjHSNoUZ9t1YfNB0e/Wfb0VrCTkY0Gqwrj18/UIZCy+kx3a0
	1MKqUhy+kiYd75dWHCMJXnEXWzXI7nYsjjP+x64fwodLt460LKi3y7R45I73/hRg66HuM23uX+t
	8Rkyn3Nc4Fo0F/YI10CxLNf5C0SZDoEXi+A7rwep0Re5PPPSssv5/+4Ba1d2z9n1gglBh5n6qUp
	JfoTFRdniFk79otpLlG6n/3ODSWAZZyWdYxqZTV36FXbkk8pnMjnrQ+uXNsuwWG
X-Google-Smtp-Source: AGHT+IE8cMN6763yvEseYS7F8mziXmnwL3gCNkh7QukZh3CWLkVXZlQrlkzMi/+c2+Nx0S8pkb6fiQ==
X-Received: by 2002:a05:6102:80a2:b0:4b1:1caf:f61b with SMTP id ada2fe7eead31-4b3d104867bmr26190938137.18.1736925147245;
        Tue, 14 Jan 2025 23:12:27 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f033ffsm5084366137.6.2025.01.14.23.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:12:26 -0800 (PST)
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
Subject: [PATCH v3 10/19] platform/x86: dell-pc: Use devm_platform_profile_register()
Date: Wed, 15 Jan 2025 02:10:13 -0500
Message-ID: <20250115071022.4815-11-kuurtb@gmail.com>
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
 drivers/platform/x86/dell/dell-pc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 32b3be0723f8..2759bb608b1a 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -281,7 +281,7 @@ static int thermal_init(void)
 	thermal_handler->ops = &dell_pc_platform_profile_ops;
 
 	/* Clean up if failed */
-	ret = platform_profile_register(thermal_handler, NULL);
+	ret = devm_platform_profile_register(thermal_handler, NULL);
 	if (ret)
 		goto cleanup_thermal_handler;
 
@@ -298,8 +298,6 @@ static int thermal_init(void)
 
 static void thermal_cleanup(void)
 {
-	if (thermal_handler)
-		platform_profile_remove(thermal_handler);
 	platform_device_unregister(platform_device);
 }
 
-- 
2.48.0


