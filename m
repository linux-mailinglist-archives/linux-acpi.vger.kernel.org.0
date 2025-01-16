Return-Path: <linux-acpi+bounces-10710-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B3EA12FDB
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661481888611
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 00:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBF215665C;
	Thu, 16 Jan 2025 00:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aO76NYyK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0037114B959;
	Thu, 16 Jan 2025 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987310; cv=none; b=FvGPHFFDaC0wyTOuZk+YIhqVQhi39SSjBNTl57MDqSrLuEyPzG6hJaI9Y/LsURFXgoHROYRQ4WR2bo4mt54Rw64XdP/udzvXaalaXguYV85M5F2uo1YA/L5yX60r7o4u3Oq/yAtapYq+YCFaZl+e4z9WxykvRLzpt2STkKuUeCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987310; c=relaxed/simple;
	bh=TuqkTUywP0clh8XEH44dh5+/J0kdOPivjgDX6bUOK3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlisbTQRMBlmnIom4Zql0DQ69Ur80eMU/nyBVDIdqyz7H4thSZxjKUxm9Z6gkJAeTTOw/X46Nqj1zUVafHMUERhk2ZytHtdeeDfAnMWiQ0uXu8breLtgq8K90TFS3fYRTblLVFrJaenLYkE/4czp6ER9rWASxxfFEEe+nUcEUFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aO76NYyK; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e5773c5901aso2588858276.1;
        Wed, 15 Jan 2025 16:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987306; x=1737592106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tH21uZjKaqDAzuZeRzdoCYUXWCsDaoqo3oPQNE/9v1M=;
        b=aO76NYyKM6nHoGGKdo6OUg4FtRk8r/Aztfa2A3q4t5v6LTlbqHhWhXzcgKVAYXCVwW
         R9D1GxDdEM7qDB3xtz+0YRO3GsCf6sP8y+1q8nbNATeOuKJ6iT6qC3uwhQdBh832D0Bk
         aV1WpuJITf8xss1+nwZB8cjyz6y8W2vI4L1pK2Pc+jmbqJIzeuLN9+P8y22CvUNOa0QU
         ijVgfVKwh60BCUq5iGc7Pt+xa3lYE62fy6yUQbuWgmsNuOGfsruW9CN4JRXo95nbmhaJ
         qCtUcrl+DshYmvp3rhjnYu/hDnXHkuADxryknC10oEGR0jueyk2ZcUoh+L15LEEnXIiI
         jL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987306; x=1737592106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tH21uZjKaqDAzuZeRzdoCYUXWCsDaoqo3oPQNE/9v1M=;
        b=bMFy3aSPLQdbZlNJ0d9YyCKiYyZlqygMkeucvz31Y/ocI5/2pjWH79OppKu3wyVVpC
         NNnuYXzCdU3WKt2TE/t2zOylsqSIiOfll05xOGE9BW46mll3KbueE1g0ZOBMVcrBialO
         fFcnW0bPTzHS6E09xRNg0s74I9Fcv0UC3cFzlY2J9LUdpkaBNKqgeTk89DfvEAfGsH/5
         mjBPKJ6xrAcVTofZ9E7s2c4qZRwUDkIE856WBSwcgRoDtcBtwIXVd3bnJNvwPJzS30Lw
         kPmzusKuI+GLzP+AkqmgZsi5tBr8GKTrSXkXW1uk+D8DW4MrPL52EY0uNYarnn3WSP7t
         ErBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8/fZ/Zlv1GdO7G5cXZq5tZ4aaTzzsVDtbW56IY57QFA1CrYn/yb3SMVo1RmYEwERbDWkrC/KmoG4IDVbU@vger.kernel.org, AJvYcCXoq230NM06XsEW7w7i6bAry1YNweqQdlPqJj3N0igQ+ER2fYUDqJeln8ftRU9RJlqLhsawcECbRWED@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvn4hpHRddxgQF9+aDC3Px7VKzGFk1QWUXR380sjuwEQYN8jQ7
	ZFBALNhxbEyu999FlWQaoQtNZDXo/10kDwSyCZuOJu6GbdjOW4UGbVKSXg==
X-Gm-Gg: ASbGncs0i2/afgSDdyk4l6Fqfp7qLhbfGtwTyXTPMBeE4x8OwzBGVSiHChsetKOvtgh
	DGg7xnSXtQshmYCabtfaEpxdBu3xd6WVUItZucGEKTSv5VBE6plQVhTU6YUoobAVWZP9S1228I2
	NxLsTimUOwNmfPXVV4m6xpOKE24xDyWaD/MdVXNrpQ68RjfM2HuBZ5k5XkMsKigwthetPtmSe3l
	rFnlxT5aI82PqtefdSW4WNmi73Yab7zfIfgoUB5i7bgizzuXYsK/Gqya8K3q88H
X-Google-Smtp-Source: AGHT+IH2I5tV6mgNgQcixCjG+koy1ChbFHil6bYsGZfPPvoZmIvSUH+xNP28yO5U/MyEFwLSXonV0A==
X-Received: by 2002:a05:690c:6b83:b0:6dd:b8ff:c29c with SMTP id 00721157ae682-6f6c9b409b4mr43521037b3.17.1736987305730;
        Wed, 15 Jan 2025 16:28:25 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bdesm27229077b3.50.2025.01.15.16.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:28:25 -0800 (PST)
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
Subject: [PATCH v4 13/19] platform/x86: inspur_platform_profile: Use devm_platform_profile_register()
Date: Wed, 15 Jan 2025 19:27:15 -0500
Message-ID: <20250116002721.75592-14-kuurtb@gmail.com>
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
2.48.1


