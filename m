Return-Path: <linux-acpi+bounces-10612-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB86A10B23
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3CB18836D4
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5281FA8C8;
	Tue, 14 Jan 2025 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LK+08hGD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019C31FA827;
	Tue, 14 Jan 2025 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869127; cv=none; b=n99Qk3cddTQjUAwzoLAWPcwafmXxXlKnaYbmMJd3cC9/VkR9zt34lof3gKUCiFDBw0qPPMHnPN5W7LejBaN8CTekhjWmI1yDXZ4ead5bNrjt9mMQV/Lh5GIStC7ZIJLpS0D07kr113WmtHhbd0WPFIzTX4TYlNlzw0Fo9hDQ/cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869127; c=relaxed/simple;
	bh=gl/SOIC2X634UbiGuktHx/7A9X+vzhlckF6BTL92tHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANd4lr1c/KCEN3G95dYi0wGrJuGu0gChG5nligbFuO/AEuGzF/bvEcCCiUGsgduHce4iqhel4ALHZuxjiymzSjwSYq+RI1iYmvAY1ApioTy0p72snYIiJGJM4FjVgUu3sCpLJs1TGzAFc6VEJxbweZXYKmRkL8yLMxDnciJUWvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LK+08hGD; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-85c559ed230so1284089241.0;
        Tue, 14 Jan 2025 07:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736869125; x=1737473925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFTbZ7iv7BPB/8NmRhAt6iNwWYwsczqikHPXY9Sa0mE=;
        b=LK+08hGDtJ4RA0+1SLzbTA2V49wh8L3pwto1qIgzqh6q5Kxrw57Be209eLQQnVgk+0
         FkZKQ4ZqW5oc5nezQXdndtq+ya+Q30y/n2iwCKN5Yzd6WCMv4gKnqO5heudFaUx7tBQW
         dwEFgzhp9evm8a7YJDjPAyNTEOGLJRUqt/BHpthOzxnyM0K1oX3o4z7bTxdcItWLYZLx
         lVzUKZfAMhwTMcy98Xj4j3ZSsfgTzX8TbCWCkO4C6VVWlf/etuE4V+NdiEVvlYykcErm
         BrHuA56L9wuu4fhWAvhOO/JMMj+XynNKn9XlvF/0tR2osW5UlTPfmlLFB8xNFYnDL8mJ
         M9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869125; x=1737473925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFTbZ7iv7BPB/8NmRhAt6iNwWYwsczqikHPXY9Sa0mE=;
        b=d8Fm2tVAMgU2Kxc+pR9J4PulzdDlaVp+nR1lcUiFKwZPdTZKnG+zBW3RUbITMKS8FG
         bd4x5gaDuOZ/bkBNhqVfwNOAJcfme8Y4szK14taMBvdkbstdksefFt4C1dnPgydTGIjm
         4Osggg9ZyxKoIxqVi0+0tT8CqxhLGnYUldmqxBTVrz0DHFGDHcOvlGOrjftpPLTIsXTv
         fDvBjnZsh1lF+UwRL6NJGeif1lzHa+XVmxbYsvFPnNKDb/th31LT9nqIn7oiXzbFBzjP
         yP1xTvDMwRdIHonlduo0GQyqctcAEfHGvo5i4SAI1Ey+reLdGkvS2q/nF1E02ZU25LK5
         4OwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgMSOYW+YnBmp2UsUOtsUr4wj06Y9LDW9Ybz04SdH73W2upcmU/u41JByDTkal7v+SDXSF8x/YAQS2iMNT@vger.kernel.org, AJvYcCWCFJT7z14G0BXOrqok7L9Tojzurh9g5/q4PeCxQzWwqI/ugxPYDyVl25GKZnfOirGszMfSQ1hqHYKC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp2j2iweVac0cqKZMhJcnVGcCl9lFKX9DI6HDLuG03n1aP5GHg
	fYAddQm9U9ChzmbcxU6wjbmbAByuD2ByAO7yovNKe6srhwu5CK+qa1vTzw==
X-Gm-Gg: ASbGnct0vFxGifTjyIuVkYMDWeiP9awm9ZLpCoS0Zdo4w2tDq2GPU2c3sdDxoF46c8e
	dzzETq45AQWu9hZXXTb4dG4gw8kfL04nKFSZCtTO+9DW/088X0VbxhQr85gsz3h9rJN6Pb5E3Qr
	IMc1CJp4ylfyrZrggjTNgXEnd7z8NND61G5AO5sxvX8mDvftYX14l+iGH85YoIUduXyilUCtYWC
	UcCRsQJuVG4LBW3ptspSKZ4vQnreLnQkpRyhHY5mvt3sA+8drGBqJLsSgYz76TL
X-Google-Smtp-Source: AGHT+IGvT/ZeMxJlA9rw4hi8w9QATsb1SxAYVSEiccQLYP7H0xAtv7k0009ktaRsCn4DtrRdOocP4Q==
X-Received: by 2002:a05:6122:458b:b0:518:8bfe:d5f0 with SMTP id 71dfb90a1353d-51c6c2b3d25mr19271001e0c.0.1736869124740;
        Tue, 14 Jan 2025 07:38:44 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cd7c56d30sm277e0c.14.2025.01.14.07.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:38:44 -0800 (PST)
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
Subject: [PATCH v2 11/18] platform/x86: ideapad-laptop: Use devm_platform_profile_register()
Date: Tue, 14 Jan 2025 10:37:19 -0500
Message-ID: <20250114153726.11802-12-kuurtb@gmail.com>
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
 drivers/platform/x86/ideapad-laptop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 050919a28d2b..87c1e087770a 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1123,7 +1123,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
 	priv->dytc->pprof.ops = &dytc_profile_ops;
 
 	/* Create platform_profile structure and register */
-	err = platform_profile_register(&priv->dytc->pprof, &priv->dytc);
+	err = devm_platform_profile_register(&priv->dytc->pprof, &priv->dytc);
 	if (err)
 		goto pp_reg_failed;
 
@@ -1145,7 +1145,6 @@ static void ideapad_dytc_profile_exit(struct ideapad_private *priv)
 	if (!priv->dytc)
 		return;
 
-	platform_profile_remove(&priv->dytc->pprof);
 	mutex_destroy(&priv->dytc->mutex);
 	kfree(priv->dytc);
 
-- 
2.47.1


