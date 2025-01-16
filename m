Return-Path: <linux-acpi+bounces-10708-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C79BA12FD5
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9E21881A39
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 00:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C365B29405;
	Thu, 16 Jan 2025 00:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esG1dWQo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135FF148838;
	Thu, 16 Jan 2025 00:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987302; cv=none; b=Lb3PEJYOansIQW/yG9vvQXVA2ojOQ9xTeTPLnW6A4fR63I6fVyB9tVoLQrWOgKEMJoYQ/023+cCj/iV/253Z6/886U0TE5/WLAIY6Km09PtI8uy2NZtFCz4RAyJCxHZaHsrYNweMrTWSjvoImawdOZ3nZrFqYqPMR1CcrpjCEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987302; c=relaxed/simple;
	bh=oCmDv5Wbdfc0zQfiwQu5GgJMWPLheGCp3njACHeDYE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGHXUnR9FIeK47L3qLvTj4rn4vMg09OSNBA5Q7AlxJBxRhUGgHBmcTrCB7DE8FqhgSNny2buNw47yVpqwLgZ28Id+4yvtFw3g0YcWnSwfIMrPlAzIBXT+jB5iVMnmna3aZCUos2Rt3Bflu4RqHkyDYNcNJ2uYXvGRfPgx1adOoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esG1dWQo; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e4a6b978283so2727341276.0;
        Wed, 15 Jan 2025 16:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987299; x=1737592099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y97wOLhlP8Ii1C+c5Dq1Ud9TpCVhWUQBWdqdzRT3wXw=;
        b=esG1dWQo0ESD8mFSP3P+t2WiASZYLRNS3QuW/PQE0zwnfMJLqeKuLsGLY/AgIyR6Fw
         BoE0PgnuPCLAU3UEtOI9YXmdKzKA9ujlbidM3DpuDtoT4NV10EdJAq37AP4j1btPfUlq
         P9Q3KriGN0xF/G0aE/9q8COVaotkXurc45T8xCTikwz7LkMknQXRWNF6r9UhOklrpA/n
         npyERyxYIyNblg/SrtInWTip/kK34YA8eVsApCta8uoOO5Gt4vsOutpmTT9eTB7bWcpQ
         I7E46W1WwXlkB4HTLhwbJVlyYayxW3ZBKEINurZ7OQlOxvAF4zdX44Jp1NFichxCXeiY
         wxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987299; x=1737592099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y97wOLhlP8Ii1C+c5Dq1Ud9TpCVhWUQBWdqdzRT3wXw=;
        b=VsbUP/dhRD5MiAZefac7YqshQqhI9Ku4MsDjrn2oNFHwQb3TzA87TZ2D84D66eaiJV
         bwXMGSWmyrqyzQ1On+dU+iF/f5FUb2i9N8PQWlWBC/Bpyfj9pUv+PRPXZfU7QOO4BnxK
         lOI/KrKbjfOrVyxuJkL3/pgxjzvc96iRfvSrCPIAV/a6G37Wca8atZF933ciKO+8QyHP
         mr4Z4JltOucdJvEG05kYwcfpQwb8N8i9zFFT4UrcbWRf1EBGjkiKIOiwX1p8g5V8D/9Q
         IZkJQ3RBdWm2mMRoltDBCo1d4p5qLu4RVy83Y0a3WFqecFwXxLCsM++iOc+fVZDQ3nje
         m8Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWocpAv6RE9zrxj1SKINdOCzRTKkNYjeK7TP86O/vZ0GpQvTCrsVNfDpJxAENQ0AJdlCj0ycn6heoNJ+OkU@vger.kernel.org, AJvYcCX8OLNNFfnPXSCyeuC+oeyqzHnASSZcxZP1ElDaRoC/DgnJkMpF3rs78bItlfxCgLXMe1M2E+NmhkYe@vger.kernel.org
X-Gm-Message-State: AOJu0YzYQn5LtTEwsHNqxANzzDV9Miba5eUKh23JqiMhh18Y0iAxhJQ9
	CVs1U5AFOPm3g3ZZ9hRRoQk4RD9xamfddVlJ6vep5ADcBwqZC6RToEwURg==
X-Gm-Gg: ASbGncshZBkJN++G7lYUr5r+2fYlhwXgCe7oPKzEa80XTegJVC/Lvrs85PpOrTvFExX
	QZTh0+spBmZchWu/CowT+iHRhwCLrM0wT2FHHbNfZl92olhOgIsAmItdE5A6QrB+VaXbGQ8pbIJ
	ohpdTbCkEnnnPSZGnEq6O+Ud5VhQK6K5jv7KseKu7ex0Q4FZOs+eUw6lbjneXiSGGGei2WsSqbG
	mBowjoJSWEgI2l45huJx98ylv4BxfPJ8zfRAS2AwQsSKKEpf0LySNJwt1bU1esf
X-Google-Smtp-Source: AGHT+IHPM9Ckc4LBHOUOdqSWN9DBwGcIsR8myxqVnjSJ1aOKgJwoX3DjYjKwf7BdSomz0oDTH9sxoQ==
X-Received: by 2002:a05:690c:9c02:b0:6e2:41fa:9d4 with SMTP id 00721157ae682-6f6c9b5df5emr46481737b3.15.1736987298824;
        Wed, 15 Jan 2025 16:28:18 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bdesm27229077b3.50.2025.01.15.16.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:28:18 -0800 (PST)
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
Subject: [PATCH v4 11/19] platform/x86: ideapad-laptop: Use devm_platform_profile_register()
Date: Wed, 15 Jan 2025 19:27:13 -0500
Message-ID: <20250116002721.75592-12-kuurtb@gmail.com>
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
2.48.1


