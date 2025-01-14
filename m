Return-Path: <linux-acpi+bounces-10610-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76974A10B1A
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6BA67A1A8D
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBF91F9EDC;
	Tue, 14 Jan 2025 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4uWdzS5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EF21B21AB;
	Tue, 14 Jan 2025 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869120; cv=none; b=f+0rQW/5Dq12w+lzSnTeHMDE1HSoYGIcV+gh+ZuOhyRpPyhwLuFLhGMn/VW/28XplvlDmrt/U3grx5JJI7q01GZtE3Y/F1ceagtykEvJN3ak7Xt9/NUdVzbJ5UyYVuEou9liiw03Rgu2j/RK+jmb2qb3bbK/Z2L/z0WRuQTatO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869120; c=relaxed/simple;
	bh=JxvVIpyZV1grpmaMFFZN95BrlRBdgJNNmmmCjxdlS4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8Z/m/QZPXZBQSrAC2l+tWUUwv46Yy0dM7tMnAHUI9yC/EYux0EVM16UbOUtXA1LdPd6brwDFdRNR4s5eJQb/VgK+f8//kiEHEIzDypLAHexr8E95aF/7vYBX1oPMyzockfMSS9D8d5+htJkOUa/sDzi1cJ8z1UQ6pJOfQfuw18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4uWdzS5; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-85bad9e0214so2316593241.3;
        Tue, 14 Jan 2025 07:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736869118; x=1737473918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2pWVrzJjBm06ENHhWY4kQXqQzfJ1Rq4okzDBvR+GD8=;
        b=O4uWdzS5jFERWZVo4GiA1M1zzcNYFvxdMZLlGAXqImU4kg7KfwGlj35iwwWZgxnx+K
         vJOEVjdsiwTdCTZ4NsRGbmldu3xuOQxkczQ/59GimZmZO2yFhoHPKitJIyqOnc/QSy0P
         9WqbwGomWO90D3zq6YZ0joCnKSN3L9HPm7vIdUpwrfKs97qvUOcvR18t7ZGWIkK+kfQf
         Ht6aW4oFQEsZ08z2Sx6Im6JTnSA1QWLn8xEOUbx/r2vd1IiAUeXxXEZIFAsDnDO0MGrM
         6MxVeOqedRvVGo/yI4W4ZDLVO7MfjVliDXIOc1ANqxVy0JldNZT2ZUVNBu/wcXo28AUb
         Jqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869118; x=1737473918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2pWVrzJjBm06ENHhWY4kQXqQzfJ1Rq4okzDBvR+GD8=;
        b=VLoJvCeeTPiaT8BJnpso24wYKUF4maItRWJWgBiclO/brCP5fbrhWfb9rRXZypBe0h
         L7jdxhKqQd3udnQQLuEQsAKn+6BM5IyJUOcKShhRN2jsv0T5kZGnRtiu6WswnexErDJ3
         UTGYutO/4TNHEGn9IiIkGTmCey+QEYJCnCRjjLTSlF6oQZABHHA9oJdjg00UME7qO7dC
         Knh1Qbq5eIi7qxy/TR0wYAf69vtNBNyLQKdwYrtOvaSnT8dQBy0x+h9ie2nGwGTC75Ch
         HBCGLAo4PxcGA/TggO4q+O9U50ooNfidMTH+KqY0O/40QMzlJD+AFITKoIR7eOi+zXq7
         l5lg==
X-Forwarded-Encrypted: i=1; AJvYcCUAxqxT11Ej2b93+Dy48QntPIWoZf6YmQ+muBD6WXBhj7ccMO+L57uXjsjy0W63EomrUslvA1AT4ouE@vger.kernel.org, AJvYcCVoakHPAOa8dM/+iDCwWo1eKLEV4IgXnsu28KqCjSWDgAsAKNbKB4rPiLkqJfk08LQvDiDyHXkOktAvBtDT@vger.kernel.org
X-Gm-Message-State: AOJu0YxJTgjnuMkTexafw20iaAwGgCm4mrq9X5A3TrLdgczL2aWGIemy
	9XspQALn2/vIRPq3aeFDbVTIOe4cZaF89VIx2UKLZZ99RyrlcLBQ6rAHKA==
X-Gm-Gg: ASbGncu/KdE+07C4fRx1b2WAdr7YBkaG2hOUVehR0EtUuwnLTpw0ory2pS9iy1izUq1
	s7wNVn4XuROJ5dDURdAjT8ifwWXCwmF3J2hKZuBhC5TJkCZI/Glh7qIT0LEw65WT9+vIcmxwJBa
	5JlHki+J421pnBwNA/te6K9afjgYgGR7zvsQrDuWHdj3yLLtSrBIg2VJ3OFopDFaA6C6/Frz6wK
	lcracOY5o2/B934GFWH79IgJ0z+j3KEzSl4jYeDv3i8fqPrHi0i3XhGROiFwgw6
X-Google-Smtp-Source: AGHT+IGy0e4pp7Sd+xRs7NZ9RQYuiul8M4nm6R7Nsi9+12cpn/npe5cHxYFPkNfQ5WjVXbxHDP/J8Q==
X-Received: by 2002:a05:6122:3bd6:b0:50d:6a43:d525 with SMTP id 71dfb90a1353d-51c6c22ea8fmr20290461e0c.1.1736869117642;
        Tue, 14 Jan 2025 07:38:37 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cd7c56d30sm277e0c.14.2025.01.14.07.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:38:37 -0800 (PST)
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
Subject: [PATCH v2 09/18] platform/x86: asus-wmi: Use devm_platform_profile_register()
Date: Tue, 14 Jan 2025 10:37:17 -0500
Message-ID: <20250114153726.11802-10-kuurtb@gmail.com>
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
 drivers/platform/x86/asus-wmi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 3d77f7454953..f8437cff66df 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3895,12 +3895,12 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	asus->platform_profile_handler.dev = dev;
 	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
 
-	err = platform_profile_register(&asus->platform_profile_handler, asus);
+	err = devm_platform_profile_register(&asus->platform_profile_handler, asus);
 	if (err == -EEXIST) {
 		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
 		return 0;
 	} else if (err) {
-		pr_err("%s, failed at platform_profile_register: %d\n", __func__, err);
+		pr_err("%s, failed at devm_platform_profile_register: %d\n", __func__, err);
 		return err;
 	}
 
@@ -4859,8 +4859,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_sysfs:
 fail_custom_fan_curve:
 fail_platform_profile_setup:
-	if (asus->platform_profile_support)
-		platform_profile_remove(&asus->platform_profile_handler);
 fail_fan_boost_mode:
 fail_platform:
 	kfree(asus);
@@ -4886,9 +4884,6 @@ static void asus_wmi_remove(struct platform_device *device)
 	throttle_thermal_policy_set_default(asus);
 	asus_wmi_battery_exit(asus);
 
-	if (asus->platform_profile_support)
-		platform_profile_remove(&asus->platform_profile_handler);
-
 	kfree(asus);
 }
 
-- 
2.47.1


