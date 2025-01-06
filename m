Return-Path: <linux-acpi+bounces-10362-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D92CA01EA8
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jan 2025 05:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40AE188331C
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jan 2025 04:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B191A2631;
	Mon,  6 Jan 2025 04:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfboWHD3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A546A192B94;
	Mon,  6 Jan 2025 04:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736138822; cv=none; b=QaFAS7EINjhDvQiQKGvXUyRCIvWdQEVWnwwDWrSR1xelTuPOW8cmiID4OSTvUcMqh/pvWNVJW+78oILDNwvY4AziWGiE2jKUYHp7xtpDdDxQMlFKn7RgbactSadABTUuRm41eoUZTZCF5Eql50kfREZziafAgKjXJUt6AzcpfWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736138822; c=relaxed/simple;
	bh=iqS56rdCDRQkd8dpkz0VGRA/xw51VU7F0mVu39SM+n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6fubAZVSWjnAVkh2cLxtwh8Ctf24y+q+PluToUIDZfdhTUV2+BR7d95kjeR9pUfVJX+yBo2Ax4S+GC7v2RLRglmKrmoZ+hc3Jmu6uzJ44ggUXM42mFjCwKeNce/guBit+cTxP8rduPPKYZVW/3lEBFB8dT4CkWvR8RZ0uwCwu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfboWHD3; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-85b88a685e6so5779135241.2;
        Sun, 05 Jan 2025 20:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736138819; x=1736743619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXYdp/X/WGGGepK5thiLo0iYK0sMhuoGCqWWVppHTrs=;
        b=OfboWHD3JfWQHyw/18CWW2Ec/k0E/PC1audEbdtq9njU40KjpUHraXv6gqlVEkIK0v
         wpkleT1Hr14XmTn8vtjerVA2Uoap7nWhWDe15+GQ44otMtMFSFzCVS5fxj4LsVFUKOX/
         apRhVWDXu9Rls2R4xLBAD35Jx4fYEQP0G5P6/WMUKuu3mkW5sPB3QlIdOlHY9PVt+82i
         4q50bok5x6s6BMPxwzlZodoIsVXymB2jqOAqxDKKcKYIzmFz3Dd1ONtcH4oWr+1tg0lJ
         iurub1su5Mmr8ngIsBqZUqeVtp0WW438gW6ByFgleLPz+qCP73Dj7OF419ZvipLIkUNX
         K1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736138819; x=1736743619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXYdp/X/WGGGepK5thiLo0iYK0sMhuoGCqWWVppHTrs=;
        b=g4HioUFk3z2Qln16ts2T6XI09x/4mfn92kEkOIWGApatUZvf0KQIBcQ0ZBuSnUt+wh
         2Jnlckqqrp/noGZSXKmJl4QIZXiPVgPyzObxcIaYuaVHRWKdQ9aLMxu0LEjNUW6Er5j6
         kyVpvQ/MMiGg515yMUP28X7FTPpKpVueXuz+/i/C0qxXzFo3/DVD4+OcH2I+0+9sL/zS
         PX8m1ZbaAz+LadUDSS+o34LL6qKcNrysgtxA9HD1UrKKvv5XtEWo9a1dLy2UR6L7MOPQ
         9o8fG2ZUnBeIbLN2B4eZe/X8kQChqh4waYN4wdFoezFpgJfxxdrVxRgQXCKmLZ6fkG4M
         2QmA==
X-Forwarded-Encrypted: i=1; AJvYcCVEo5/8YoNGb/L0bPzdiAk7z/UxW0apr9z3QMjfs7uDmO5rBsMphg6bhp85+bMUfBd8SxrCV06Dz/BN@vger.kernel.org, AJvYcCVOGp20OsOEb8L+Ft1hhIzIm2wKFm+DYyzWuoBd0TLsK0mIkyiiZLmlOA1ANgRWx+9Kscyb04uBdluU9KwI@vger.kernel.org
X-Gm-Message-State: AOJu0YzlpNfFgGRqHm0+YXwy6dqdOXTVq0BhFBDvqV7S2tmmDhXawIGZ
	HHRezdnQDl5WPzNSENoS8Hf0AHinSsbxcrGilBodw85XAR4BF/5mQlsAh9Ku
X-Gm-Gg: ASbGnctrhTS3loqK/MAXUxtV5moScud2aE7jOpamZsetv7a+CiDoco+w636EdWcFRRs
	IxSHePPrZG881OW/c9E1Cpr0JujI/GKx4acubyxIOMHVAwrQukJT525S1BARANCVP6C+H4CwxsC
	U6K3uIhzhcwWRRdDHNJnTWgIZarHoYt19/bW7P5ErZtXACsBi6AGrWTp7dSPUmajg6iCPucIez9
	lJZc27ZCzSX/qnwTfSMh2DnI+MTtaKtRCfAESCF0NNmLgTW+UOhXZafIgqCd9Su
X-Google-Smtp-Source: AGHT+IG39OANV7S3S3UHkc84naX2A9O7SRpBXiBCtRQ04Xyx9rUtHVjQrTzCUI4c0+Rs8qBerMrkig==
X-Received: by 2002:a05:6102:5127:b0:4b2:77df:4660 with SMTP id ada2fe7eead31-4b2cc3225demr43069341137.4.1736138818977;
        Sun, 05 Jan 2025 20:46:58 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b2bf98d1c9sm7083507137.4.2025.01.05.20.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 20:46:58 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: josh@joshuagrisham.com,
	hridesh699@gmail.com,
	derekjohn.clark@gmail.com,
	Kurt Borja <kuurtb@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Lee, Chun-Yi" <jlee@suse.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Lyndon Sanche <lsanche@lyndeno.ca>,
	Ike Panhc <ike.pan@canonical.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Armin Wolf <W_Armin@gmx.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Alexis Belmonte <alexbelm48@gmail.com>,
	Ai Chao <aichao@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Gergo Koteles <soyer@irl.hu>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [RFC PATCH 3/3] ACPI: platform_profile: Add platform_profile_refresh_choices()
Date: Sun,  5 Jan 2025 23:45:51 -0500
Message-ID: <20250106044605.12494-4-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106044605.12494-1-kuurtb@gmail.com>
References: <20250106044605.12494-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let drivers dynamically refresh selected choices safely, while holding
`profile_lock`.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c  | 23 +++++++++++++++++++++++
 include/linux/platform_profile.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index ec749c2d0695..087280d786b1 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -459,6 +459,29 @@ int platform_profile_cycle(void)
 }
 EXPORT_SYMBOL_GPL(platform_profile_cycle);
 
+int platform_profile_refresh_choices(struct platform_profile_handler *pprof)
+{
+	unsigned long backup[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
+	int err;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		bitmap_copy(backup, pprof->choices, PLATFORM_PROFILE_LAST);
+
+		err = pprof->ops->choices(pprof);
+		if (err) {
+			bitmap_copy(pprof->choices, backup, PLATFORM_PROFILE_LAST);
+			return err;
+		}
+
+		_notify_class_profile(pprof->class_dev, NULL);
+	}
+
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(platform_profile_refresh_choices);
+
 int platform_profile_register(struct platform_profile_handler *pprof)
 {
 	int err;
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 7f266a60b41a..7d543dd8c164 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -50,6 +50,7 @@ int platform_profile_register(struct platform_profile_handler *pprof);
 int platform_profile_remove(struct platform_profile_handler *pprof);
 int devm_platform_profile_register(struct platform_profile_handler *pprof);
 int platform_profile_cycle(void);
+int platform_profile_refresh_choices(struct platform_profile_handler *pprof);
 void platform_profile_notify(struct platform_profile_handler *pprof);
 
 #endif  /*_PLATFORM_PROFILE_H_*/
-- 
2.47.1


