Return-Path: <linux-acpi+bounces-10614-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6888A10B28
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53FB47A0668
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7611FBCA3;
	Tue, 14 Jan 2025 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlyUUbfa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7BF1FAC58;
	Tue, 14 Jan 2025 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869134; cv=none; b=VES1DdRoUSWM16vlAqV1PBsEcV1hhSsRYmgTvg+R0U3H2IuA/P61YWvrNwP2N1lU/P0vj24hua9NFHg+YD16pGGrV/lOWhfWJtoILjfl7PzSgaEF+jWVytisHxewP2//SgBUCveNMYPAviRqkIgNRiL7GYzPD8/OjRbz/2IZNl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869134; c=relaxed/simple;
	bh=ocEPmb6v6CNCH626Ps0INYHmMydv0QIuVt2uKlkQjXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UG19hm3x3BkK5YgUt6qJGG8nwvsPY772mls+I7Zz64ANALU4re7fFia95Wp4VCKMfjvbRZNUyQZ8HwdTa9R6+9LHTdrCDtrGPMPKWdPwiCPbwU+uTEf8MwRcHMtnxPQl1ulZT9qmpE6hDW/GxjVvol6VRFU3JaJJpCyypYQWPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlyUUbfa; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4afe4f1ce18so1803358137.3;
        Tue, 14 Jan 2025 07:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736869132; x=1737473932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbX6zSYl+GrY6mSqcnAlyzx/v+yDl2thYqQomAWOUe8=;
        b=VlyUUbfaGZq1BdZueE+NwtVhzlxjTDrXrPGkz50UhCrGfst/W/GW2G16bJ14JqDJko
         I2MzTyLBO3lcwjoNSEHckeyIco/UNjizkI/OBfcOgAmonjROMvAN/8n9B0Oqs+51xkNQ
         VzpffkhXrQntPl90vJL/l7tGGRiwP9F3n01CnktQ5ozfvsbYm3iz+2zTWpokgHQHudD4
         Bi1cyIo6xz6Qj++2RkcBWsZ9p/e363ESMrdQWYTDRDNKBPY0QIKREKd3jysG3K9TF7eI
         xLoTX6gvIP/lVTmErvslhqyHn2p1drSA6QuGlY12G0JEPnMH7hCAlYnIULOnu5gZK8vA
         zNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869132; x=1737473932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbX6zSYl+GrY6mSqcnAlyzx/v+yDl2thYqQomAWOUe8=;
        b=lEbRK7Tps7i+3EVJeBMgewAB+R6w89Udp3QuYgG3zZ98qanzN5Lc0guV+N9gWmT0bQ
         6CSQleCbbbkOC+qhuUWLw4Sbn5a8XUwqVQo+KxJ2K3jRm2qGZJcdPDEqwhpupNHo62NY
         Q2cADxJhyIKZ1VglBNxX8wH9kw6NuxdwJ19MGQuyCPSzsiiI2Yg3OIS4LlSTf4cLp2aW
         qd3uVrQVvC1VG3rhKe8BiCNsqS49h8adQm+2iQ2ej/QRgRILUhSVAl79vDsEeQHEBSVf
         Che4U4hnPDKR9qRhsWyvgkuX1CxUIgCNJVs0+2y1osgmuJDkpu+QkGMPnJ7DIHUEzdZ1
         NQcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhmYzS4RVZTYy2dlm3/W7JxhRJIj16ob1iYy7H0KobVa9mANBIVfQtCcXflGgtLkhpqfGlN36PtDD7mUIE@vger.kernel.org, AJvYcCWTOkj4jBIDAKMSYg+U+b+VWC14b+Aa3jA091b8La9qMh8/mtv9rbH/HLYWvnSTBzUp8+77cIn9/SUm@vger.kernel.org
X-Gm-Message-State: AOJu0YzTC5vpl5/W4tCDvsiAqzGScombRCHRF9AVvdLBbCjNg2kA7lKJ
	SPxY04g2k3r1BN9Iu+79b0OUMynVnLe6QH2Bq3E47Dh9GjITm+arkPngwg==
X-Gm-Gg: ASbGnctZO7tkXQ1ggrUNavcejquPfg1ut2Osl6IKz47AWtwAhrvVlg5PxPfrtZA2pyc
	YKh/zJXZ2nsR/nQKdfHgpRZdtUBc4nmEim4Eapmq2SmaePgoVvyYsJaUedbqcW3aDecSGArZxzh
	YQubnsDsvqU9CAh5je+duvw9ZqYd/8CqzfX9L+s8zbom2WqtsepELBpBb6WL1EJDPbjRpZ55m8I
	ARl792kIg/t1fDINF/bdbB33eok9V8FyxSu1CYYiipA89M6bkyUMyEVAQuaTEJP
X-Google-Smtp-Source: AGHT+IH17vY8aKcAnlycPor9NYsRFSQumf8UVMZxmixyh6XYWHZ72ElG/BLvlthYhAavCP0WnzFiBw==
X-Received: by 2002:a05:6122:1206:b0:51c:aa1a:2b5b with SMTP id 71dfb90a1353d-51caa1a2d10mr6543827e0c.4.1736869131902;
        Tue, 14 Jan 2025 07:38:51 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cd7c56d30sm277e0c.14.2025.01.14.07.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:38:51 -0800 (PST)
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
Subject: [PATCH v2 13/18] platform/x86: inspur_platform_profile: Use devm_platform_profile_register()
Date: Tue, 14 Jan 2025 10:37:21 -0500
Message-ID: <20250114153726.11802-14-kuurtb@gmail.com>
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
While at it, pass inspur_wmi_priv to the class device as drvdata and
replace uses of container_of() with dev_get_drvdata().

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/inspur_platform_profile.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 06df3aae9a56..e1631de6ad86 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -194,15 +194,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 	priv->handler.dev = &wdev->dev;
 	priv->handler.ops = &inspur_platform_profile_ops;
 
-	return platform_profile_register(&priv->handler, priv);
-}
-
-static void inspur_wmi_remove(struct wmi_device *wdev)
-{
-	struct inspur_wmi_priv *priv;
-
-	priv = dev_get_drvdata(&wdev->dev);
-	platform_profile_remove(&priv->handler);
+	return devm_platform_profile_register(&priv->handler, priv);
 }
 
 static const struct wmi_device_id inspur_wmi_id_table[] = {
@@ -219,7 +211,6 @@ static struct wmi_driver inspur_wmi_driver = {
 	},
 	.id_table = inspur_wmi_id_table,
 	.probe = inspur_wmi_probe,
-	.remove = inspur_wmi_remove,
 	.no_singleton = true,
 };
 
-- 
2.47.1


