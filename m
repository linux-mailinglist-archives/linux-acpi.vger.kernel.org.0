Return-Path: <linux-acpi+bounces-10454-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE889A07B3A
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 733417A03B6
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11A221CFF0;
	Thu,  9 Jan 2025 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlWZfCZT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A25B21C19F;
	Thu,  9 Jan 2025 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435303; cv=none; b=XtET4svDS/NCfUryhztq/3adVKIwrq5l1CJlVyFYwHDIJAx0rg7lIh/nx3/y5jBiM3kkBxe0yXqfZ42+Kh4/TyEJ7dwyjsbYY1OokSzPwbQw6gyZ6VPxsxpIFfIZtChNGxCYHb6FgF1Ik6iez+91pRssmI0Ft95dUWgz5a41rJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435303; c=relaxed/simple;
	bh=xXd7/bxWsamtyu89sAy0WEtkdtiHL7TrPuPupG6cCEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWBZkRVmwtHIATMQXkqVZuI7PR8TN7RGGFhF8pDHZAlNJHyzO+/MwET5Uf4vDWmFyjWYVCwTXMhbxfnX0rdLf1RmTSI7C8MWMCWJ/RD+Nv5VP/mc6Rs2F6pVYMOa6qCawZbbphYCzMHdtbuDE7xPHM2AbRnwhZn/pJ2L1qAbYZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlWZfCZT; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4afdf096fc5so314390137.2;
        Thu, 09 Jan 2025 07:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435300; x=1737040100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pKRMBIvNnmP7mlypvEctiZQvcwUOdv+eJehK0tFBB8=;
        b=hlWZfCZT+ziC0SU29j3pasPRflCdGhjif/XxswOlfR6r1Un6c9jVJ1iw6y8cn0KjbU
         aejyPi/WjEHyE8G6/tIatkycsuvatYODNNYHkMp+is8E66SVuUYGyiB0Yd5p49BmAcAW
         xaOCcL/T44sR5l87DchmSo3zQfGXmHkCwbzfQjMFKRZMileysPe40PjgcjBh67wAo9Vn
         oXBVnqRTXDEfkdSOwL+blXzZRC8f0MJdDslWtHfWZSCTD8QXSNl+uTK6WUGUFp+vd1uw
         jBnZJPpGE7OQIMdTX+RVZv60yqW6w3z6XTko4tU2kwM7XYjEQnEKbHDn0uL2b8KccTB+
         AnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435300; x=1737040100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pKRMBIvNnmP7mlypvEctiZQvcwUOdv+eJehK0tFBB8=;
        b=jdB8JtV7PKbvz7qnZzmyXACjmzp0dSJmdvDKJn3zx+6Nw1VFZmZk3+X9H6jsWYxenL
         lKDZF9bdrGrk6/wOOAI50bXPj4SCNu6Hp20+nHWPQXoqdfrj39DQ2Jp4MiP2b8mWxaqk
         NpCqdPbFqgho9bk4cwgf4gvkwTmXOHDNfKmbuMtsEpxlN/1OO8qHQJoJgKNuD3/xxEze
         ++9TfMkYAvr+/pLquOhO74y5+zhVZibba9Mq/3fqYT9KbcySDnDF9XjngoSY1bFolMDc
         zig0YpqXNOrDrPVJSOPY8prCxzYyCHw5h3I7Rr5azl2ax+yx6/ItDuaxSk0nm/m0wKvc
         iiZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLG+V1pyFE6ncDsv7rK3UhACUAPWeuQAsKVLhWZqnQKZqxv+d85zDf52JsWR/G3gcce3KHbkzOPqX0CxXs@vger.kernel.org, AJvYcCXfAt75dyvy9Mqa3QKxLNpxmOD2PZdGfE7FaJCKU0fjwDc64S+kvnyetggkZgDHsKdT8rp0NbcaI9bi@vger.kernel.org
X-Gm-Message-State: AOJu0YwA3Hq77ADvfBmPa/IGHVF4v0Y5dFMXi7hHCDI5CZDJ/38T+ADg
	pkB+Il63sf4IN/3TCRwUGyRhpEZLXlOVLESswbKfzP7fOSBRly3tG+NeRV4g
X-Gm-Gg: ASbGnctToW+pu4nnBH4Wb97nC93EgICVqYohyr9lwkAsCpCO9Ari5I+M9rch6xF61I9
	yO29mhe0L/A6kD8nb+vVjGQAZbuCX3tFU5D8Z5KXze6ajVkZwz3uWaz0cPwQt7+WIhXuVl3vk/4
	QrIZbpWHDPLmQ8Pj0DmclEgsCMhE2Bx71qkf42616w0Bdk6vgd1KAAVHLyNVhP022XVe/aH+BOC
	C0A8GfNG907J6OwIvM0CwygCpuubDeuqfp+8moBYEWDilInUnCz9VwRuJhnQhCh
X-Google-Smtp-Source: AGHT+IGnQgCC9RcckDWj29i2/mHE9ovkbWx1Wu2mUVNLteeCviq1oOTEOHDEs1A5UcyKdPR2fTrCPA==
X-Received: by 2002:a05:6102:3591:b0:4af:be6e:f0aa with SMTP id ada2fe7eead31-4b3d0eccc9dmr5986327137.25.1736435299857;
        Thu, 09 Jan 2025 07:08:19 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f4a5ddsm1019887137.11.2025.01.09.07.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:08:19 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Mario Limonciello" <mario.limonciello@amd.com>,
	"Armin Wolf" <W_Armin@gmx.de>,
	Joshua Grisham <josh@joshuagrisham.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Hans de Goede" <hdegoede@redhat.com>,
	Kurt Borja <kuurtb@gmail.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	"Lee, Chun-Yi" <jlee@suse.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Lyndon Sanche <lsanche@lyndeno.ca>,
	Ike Panhc <ike.pan@canonical.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Alexis Belmonte <alexbelm48@gmail.com>,
	Ai Chao <aichao@kylinos.cn>,
	Gergo Koteles <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH 05/18] platform/surface: surface_platform_profile: Use devm_platform_profile_register()
Date: Thu,  9 Jan 2025 10:06:18 -0500
Message-ID: <20250109150731.110799-6-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109150731.110799-1-kuurtb@gmail.com>
References: <20250109150731.110799-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace platform_profile_register() with it's device managed version.
While at it, pass ssam_platform_profile_device to the class device as
drvdata and replace uses of container_of() with dev_get_drvdata().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 .../platform/surface/surface_platform_profile.c   | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 00a1178e552f..efb6653ed1d5 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -161,7 +161,7 @@ static int ssam_platform_profile_get(struct platform_profile_handler *pprof,
 	enum ssam_tmp_profile tp;
 	int status;
 
-	tpd = container_of(pprof, struct ssam_platform_profile_device, handler);
+	tpd = dev_get_drvdata(&pprof->class_dev);
 
 	status = ssam_tmp_profile_get(tpd->sdev, &tp);
 	if (status)
@@ -181,7 +181,7 @@ static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
 	struct ssam_platform_profile_device *tpd;
 	int tp;
 
-	tpd = container_of(pprof, struct ssam_platform_profile_device, handler);
+	tpd = dev_get_drvdata(&pprof->class_dev);
 
 	tp = convert_profile_to_ssam_tmp(tpd->sdev, profile);
 	if (tp < 0)
@@ -234,15 +234,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 
 	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
 
-	return platform_profile_register(&tpd->handler, NULL);
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
2.47.1


