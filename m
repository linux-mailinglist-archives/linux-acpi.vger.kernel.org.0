Return-Path: <linux-acpi+bounces-10703-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B972AA12FC8
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49493A6145
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 00:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26CC6F099;
	Thu, 16 Jan 2025 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNFwCqQD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6324D8C8;
	Thu, 16 Jan 2025 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987284; cv=none; b=CFFBLdFjus4e1ZwNiFWJm+Q27BbK+d65FH/i/c6w6AnyHZCPf1lvqqhXNXQv7oLJMP4aLAr1yP9A52/v1Hb3V8iuV4MizJOa597hn4SkiqXJFZCB0wRApuTcacjNuH4TNrsm8HCl1+kubHEfO51bEMnbTgDlE6k70lZLovgsrZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987284; c=relaxed/simple;
	bh=5lHhJZMdlBxC7EJ1nt3bE/lkNoHL2EQeG34ow55ZKgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lS5wYTpJMsNrBTX+ULO/5CJ6IZMzvuP5y5i4ft0O15Dr80OEWMpWsj3eznIofylKwbCA2ekyQO7XZdxUn8lCpehJMD75UbZaeb92/Wghla+c4ORMbxOvTGsc9OOGqxoeJ5XzG3hGQZQ9sIxddaRWn5QAukyek6oNJ8HrfPx5Nso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNFwCqQD; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e573136107bso663798276.3;
        Wed, 15 Jan 2025 16:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987282; x=1737592082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYIr3Ci5kGUoWCBBMwBtv7J4eqGAZWzjWsOsN0G37O8=;
        b=XNFwCqQDEGJ789rQWoBNTakVv46wUp9bnPLqtFpCblNkAuFYlJ339pyvdM52giPFfr
         A6D70fWwLeaHsUS4t9fsKShtU8u8xLOCrxqrmQItEj7lSDlXX6VZqmjzAMKbgQ6lTl/L
         YvfOe+/ihToOBFCDSbAdwbd9VTp186iNY05YhibxnwLSh1f33bOzfX5BY68UEqKYWKJS
         bcmxqb8WAqUTP2AfTootfDANh6XeI4/G9UPvVwo79myRmlMs0+f+fJgiphTTqGpnAPUm
         EK+exSkxZplLD5okz8sVo85+jMeFc971VryR/NBzS58nrUUswxby60wga+idTxSt82q6
         YGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987282; x=1737592082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYIr3Ci5kGUoWCBBMwBtv7J4eqGAZWzjWsOsN0G37O8=;
        b=DWTZzxxoO0b3f3W3LGWU7jKEGOTaTyS3Me7negxz0y/aMyLW5IS6ODSXwdCm4GpLzD
         7j9v/+zXT6z4j1J/T5LrRyZj9sOWsumNmBaxEutOH7VWo8tf3S9dmrWqaEvW0NcRn+4h
         LCRYbHSMuHxxIKHc9BMBdjjt9wKG56/B+Bg8gx8L2R/AiH7bnvZpHrMpZb/wlxIao/Il
         QzXLYMWDzhj1Y/A2444s2hGCTLQw9exaGVE7IU84Br72Tj3TteHz41/LvsrgTwK1eUrW
         6D4B7tx6UiIeUJo+NirQODCDmOMpwGkGToFbl2MoNEWM0lMRbdXvNqq/5y2KDBNQ5hut
         BrJA==
X-Forwarded-Encrypted: i=1; AJvYcCU4k9Vk+Je4ZCXpHDSkbHiz9j7gEz/tLsIHywqa1usZarLb13ESkIlMV4QzOkJfTnTZ4XcrseA5O3WS@vger.kernel.org, AJvYcCVZlj/3RwXiZzplKM6vc0rtiUkROMpvcArfidEfHbf+B8rULqA3XWrSbf/EtI9bWqCkA+RCp6E96Lh8uIJd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2/Rqtv7/ioWxCtguy1oWTdwjGNOCorvRRbJEtT8Ag8sYWXf9d
	c9r97/lCpvVpSAweDIM48M79rXAzQB/9Hj+vbR0ve1wwu8dYcURMjv6REw==
X-Gm-Gg: ASbGncvlVZf9vDO/id0hHJHSaocgGERkx6jzdt8GLYChdQXsX5a8T+uWGxJ7R5XDfFy
	6ptIw3ahI6pU9MirX+LioaIGleSzuXvTg2vyhN3tZzoFu4XCGRdGq+IjEWTsQ90TI3fCVh39Gpu
	LOSnyt/q8JP0WNjDDtH3i5lfaP48KJ8nAYohXNOnudoHmHPcEbVYBkEVZdu62bAYeEmKHn30Fsg
	QBebL1spPGhoPzlhCL2DCAnU5rN+GnhqExjX8wEct448HaKQY6EsWgWM0FLxEv2
X-Google-Smtp-Source: AGHT+IGzsCHvMUN24+b/RXlYC53lzjiiB1XZyyH/iKmpJgZD2HJphppTzDAqE4OYMTEyPdK1ecYT/A==
X-Received: by 2002:a05:690c:9688:b0:6f5:4304:fb8 with SMTP id 00721157ae682-6f5430412bfmr254089517b3.18.1736987281574;
        Wed, 15 Jan 2025 16:28:01 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bdesm27229077b3.50.2025.01.15.16.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:28:01 -0800 (PST)
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
Subject: [PATCH v4 06/19] platform/surface: surface_platform_profile: Use devm_platform_profile_register()
Date: Wed, 15 Jan 2025 19:27:08 -0500
Message-ID: <20250116002721.75592-7-kuurtb@gmail.com>
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
 drivers/platform/surface/surface_platform_profile.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 48cfe9cb89c8..bbdc873cb788 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -234,15 +234,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 
 	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
 
-	return platform_profile_register(&tpd->handler, tpd);
-}
-
-static void surface_platform_profile_remove(struct ssam_device *sdev)
-{
-	struct ssam_platform_profile_device *tpd;
-
-	tpd = ssam_device_get_drvdata(sdev);
-	platform_profile_remove(&tpd->handler);
+	return devm_platform_profile_register(&tpd->handler, tpd);
 }
 
 static const struct ssam_device_id ssam_platform_profile_match[] = {
@@ -253,7 +245,6 @@ MODULE_DEVICE_TABLE(ssam, ssam_platform_profile_match);
 
 static struct ssam_device_driver surface_platform_profile = {
 	.probe = surface_platform_profile_probe,
-	.remove = surface_platform_profile_remove,
 	.match_table = ssam_platform_profile_match,
 	.driver = {
 		.name = "surface_platform_profile",
-- 
2.48.1


