Return-Path: <linux-acpi+bounces-10714-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67152A12FEA
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0113A1C86
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 00:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0070D18A6B8;
	Thu, 16 Jan 2025 00:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9/LKaHO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D3216DED2;
	Thu, 16 Jan 2025 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987321; cv=none; b=dABSks18e8ChFC6jBt775RRTj2euqIgRBcNtIlaZLhfXuQXhGdiE4FnIrpOK2glplkHLqXtycqWdM12oCO0BmrcitA6Xyl8epjgIKRD1yDpo8MzFzef46NoEhKYJ8/m5429I5giSRrbe4Ce/njFNXwtsHo4IXhkID+qz93ogNoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987321; c=relaxed/simple;
	bh=c7WV89U2MFpgTdLlwzo2lJbFtY/Q/Ya4Y4LAGRPh6fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhytsJiQBhJoMA41lOhWIERi1j4BPYHMI4aGfFwW6/DzlBpxKBn8I5ZhA6tjg8NDYtNMcHlvrwSlY3kHVxDtoZDSxEsayrWEKNWriiylkqXIcTh1yD8DON7uZnndABvczl46PMePC6vIzB9RSVXjsK8d/4tFYQUh4uiJ5fjhGIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9/LKaHO; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e5773c5901aso2589026276.1;
        Wed, 15 Jan 2025 16:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987319; x=1737592119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXguU2fUVOVkIHUYVkPvywDE9Ssyzuu+IyFpXxSYJ3M=;
        b=S9/LKaHOIiJUZQ6XIrvwWzsNWhJlTPo6EI40Se7H82+FJrDMohvjrcw1lQabKugHUD
         Bl576W0dzrzw7jtvvCH/+GYvFzdTZ2Y8v+p+SFNbMJzJ62DRRh2aYFXISnpCDh494Hrn
         6gbDJwkua8yhI5wIrpJz8eSBVl2OXiVwUg9toL7SytnrT8XuryJblLH1yFSgYVgFYV2w
         CNFXBegcp8vL1qeUTinG+pSdcyqhzFMtr+2LmKAI14S1/HKQ3rTrXnMiqUdzeAhZ4Hd3
         sMEgrp3149D8hXHDoQcdSmDYLYPt7IzVyGQsxOjNoReAavIZszBEjc4yO1Sl7v6W33KX
         EjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987319; x=1737592119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXguU2fUVOVkIHUYVkPvywDE9Ssyzuu+IyFpXxSYJ3M=;
        b=vGYcipFmYJDMDFJh7M01L7B9nNb4xeKW9EWV0QUV5CA5zIo6KaMvyAb29qvvphz6MY
         wLPY0lsxtHa8yuicPc8ucLV/VReqO72AuwYORe90DbBL5ivwaRX6EL7MH3WPt2/h1pm6
         fU3//EVNgHSAtvD6WhWWfUuGJVU0y/DY/q9Je9utCeC049bCPCuFyYsHQN9R8tzr6YKd
         DLgwQuOFVDkN/dYJo+9hi0m4w6/gBxWLZPhkMeg9U3tEDZ/G6XFWzlI3xXN9nLcM0fWm
         flOK5YLGYpvnqwq7iY3xmi3KQRiM/ZqGj7/Lxzy44HWMekpSFTRMTC4vSAuBMsqDCdXe
         v52w==
X-Forwarded-Encrypted: i=1; AJvYcCVsACaG/4hDxJ40uckuf5vo1GNwh0TfrOzyk4i0xXv8h7c0Nk2ydtMjrguulSlSzR051a4kvZ5Oy33R@vger.kernel.org, AJvYcCXXeoh8DCJIQ+dta1+Wmw03YKWcnMy5/ysYfWt+bj/nwozmNtiWRI0eqdOrA+TkXhLSBfAMfqPkUz2LfeSB@vger.kernel.org
X-Gm-Message-State: AOJu0YyqBU+ss6uMpJuVjPhWSDSqtJjMpBso9Y6a67SkKZEl4/ymud0y
	cw3FMiJ9ZyhXq+zGPvZIuuryohJVSJ/N/Ka6H8BQogP4A9xqVlHTR+S4cQ==
X-Gm-Gg: ASbGnctTcIB2rRnllSLBIuE2yYdjuyh4JVYd8PiYdTI7trEHNJOurLnM2+xz7o+GQ7Y
	rgv/G7ygWFohd288wX0sCc1MXNmOlVSMhPQqKZapcFuhhAGo0ReB/kZ+ig9/9jMm/D19/2bWvJC
	q3X0I9psSzkiDOCAO/DqRueww7ti6CK/SQzurkffk4ek20tzlvpOFRSX0kGdW5wRqHhj0ULq6kK
	few5NQo94diYr4f2uLwVm/mdEyNjdeYwMSpjqQT1YlArYBG/R1WuPnRUZ7ZSRMf
X-Google-Smtp-Source: AGHT+IEGB2pWdkEriTpziMDEYcLoWSBr5x4o4A+jOtKgsvzN6lUK2pJa/tgarYK8DqJag54CL46pvA==
X-Received: by 2002:a05:690c:4b09:b0:6ee:6a2a:a517 with SMTP id 00721157ae682-6f6c9b5490cmr47162887b3.18.1736987318984;
        Wed, 15 Jan 2025 16:28:38 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bdesm27229077b3.50.2025.01.15.16.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:28:38 -0800 (PST)
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
Subject: [PATCH v4 17/19] ACPI: platform_profile: Clean platform_profile_handler
Date: Wed, 15 Jan 2025 19:27:19 -0500
Message-ID: <20250116002721.75592-18-kuurtb@gmail.com>
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

Remove parent device *dev from platform_profile_handler, as it's no
longer accessed directly. Rename class_dev -> dev.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index f27005a267a1..8a1454e66cf1 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -10,14 +10,13 @@
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
 
-#define to_pprof_handler(d)	(container_of(d, struct platform_profile_handler, class_dev))
+#define to_pprof_handler(d)	(container_of(d, struct platform_profile_handler, dev))
 
 static DEFINE_MUTEX(profile_lock);
 
 struct platform_profile_handler {
 	const char *name;
-	struct device *dev;
-	struct device class_dev;
+	struct device dev;
 	int minor;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	const struct platform_profile_ops *ops;
@@ -90,8 +89,8 @@ static int _notify_class_profile(struct device *dev, void *data)
 	struct platform_profile_handler *handler = to_pprof_handler(dev);
 
 	lockdep_assert_held(&profile_lock);
-	sysfs_notify(&handler->class_dev.kobj, NULL, "profile");
-	kobject_uevent(&handler->class_dev.kobj, KOBJ_CHANGE);
+	sysfs_notify(&handler->dev.kobj, NULL, "profile");
+	kobject_uevent(&handler->dev.kobj, KOBJ_CHANGE);
 
 	return 0;
 }
@@ -517,12 +516,12 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 	pprof->name = name;
 	pprof->ops = ops;
 	pprof->minor = minor;
-	pprof->class_dev.class = &platform_profile_class;
-	pprof->class_dev.parent = dev;
-	dev_set_drvdata(&pprof->class_dev, drvdata);
-	dev_set_name(&pprof->class_dev, "platform-profile-%d", pprof->minor);
+	pprof->dev.class = &platform_profile_class;
+	pprof->dev.parent = dev;
+	dev_set_drvdata(&pprof->dev, drvdata);
+	dev_set_name(&pprof->dev, "platform-profile-%d", pprof->minor);
 	/* device_register() takes ownership of ppdev */
-	ppdev = &no_free_ptr(pprof)->class_dev;
+	ppdev = &no_free_ptr(pprof)->dev;
 	err = device_register(ppdev);
 	if (err) {
 		put_device(ppdev);
@@ -554,7 +553,7 @@ int platform_profile_remove(struct device *dev)
 	guard(mutex)(&profile_lock);
 
 	id = pprof->minor;
-	device_unregister(&pprof->class_dev);
+	device_unregister(&pprof->dev);
 	ida_free(&platform_profile_ida, id);
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
-- 
2.48.1


