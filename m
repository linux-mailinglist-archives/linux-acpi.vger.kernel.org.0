Return-Path: <linux-acpi+bounces-10659-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D2EA11AA0
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49DD3A2786
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79FF23352D;
	Wed, 15 Jan 2025 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fi19p4q+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFCC22FDF5;
	Wed, 15 Jan 2025 07:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925157; cv=none; b=TDyl4q5B3KHzbdzqrA+e8Q/WxNB7wOR90gAyv/5/gfemZxBwBA5AADXXinvP/f1Soi1m50P+jkCy2o3wscAZjD2KlfXYlZQmuhNtYtzkwazWN5tTpA1Ps0u8rQLt3oT6gKhiHHnJGRoSqDr91hHW32uHZDIzl09R2frtMW6q1ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925157; c=relaxed/simple;
	bh=RYBV3WHqYGGLVMJtlf+XdZc5lVADyrz5mva+EyzjLU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOe41ChtmddT90IHWEOgupstye+faa703sMbdkoxLQ39qObStPMqQlKhpdWKquHxNExAMAYjzgJTAsL8LiHjKWm22kFtQ2r8iY9c0ufZO76i3XOmYNKcGMjK1U/UL61YhGWhdL9cr/odgCOdeTj7gxdaZWRGCeOrK3JoQ7wUi6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fi19p4q+; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4afdf300d07so3692356137.3;
        Tue, 14 Jan 2025 23:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736925155; x=1737529955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BywPHAK5iwjfpxiwZUmDd/hXBkyns5UQD/vx5CTXKmc=;
        b=fi19p4q+/6CWDYGRL0hYV8dsg8RwHzBepuZ/nwg/Ct6kS0jByrcvZZNpiiQIw1Cqct
         /b5BqMJXR0ylBb1+O4XEy5lAf7+JQ68ktYtdkQXkwSRa9+0f8DpqudU2qw7FfD6zjabE
         rjXc/xmG97VQKVhsJDn3LsI31T4KCn8Q8uOWJpF+9NXceuRCfIfXlkwKrzHq+lzpQwx5
         Lt1vlKtJB+2bthXvWT8aC+dGSsLzkPXk2Itr7ht4WOkuAlSKX6nRyExLQemDSaUt3nbr
         Mb9MjSRxYA5VRQ/1mpOhmNXQdGHooUSfozJ0k/AVvjcgSnh2PFRLAiKlHBoEzLGJ7m1X
         ol7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925155; x=1737529955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BywPHAK5iwjfpxiwZUmDd/hXBkyns5UQD/vx5CTXKmc=;
        b=P0DYGiIF0PHgb8JIiCfQfC7m+41iYn6wVa5Y2rFGYJ4fD1TqkgDH1IDpbzI5viazOf
         j8EztyNabkZkm+SDrki74aXF2WUct0HNQ9Egad49UdErCssHxnMxjOPGxeQcKJwUSjlp
         dzUvA1YDYrNlz21Q9DjEpIFXyj3kgyzOXSRRunZWl6O7E+PK0/pdbamSWpuuxhJDuxUg
         UXsnB3u+XXsPnzlLllcuByGPxJ+6fetsf+t8COhYbgS+rA0ZprujCeTaF+dRQAfIFbdb
         61Ta7LMvpZL14VZZ8LsiehJlSj6hJ2Jc80/CrW5lzFyse2dHfsZJ82NHbOQLe/7ow271
         zGzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp/5HogriskRWbDgHGGmM0cXVRfQawotyhCn/q1bixB10rkAlGbiL3+JcwjCNNwl3ZKBdSC/Woc5Wakb1E@vger.kernel.org, AJvYcCWH0yIXaM7vHzwR1VxO9TA2CENVGYiTh+SRMDVhhS78BIPPfF+5fgxmpjx5hhT5Du+IORwjdmmGuv4g@vger.kernel.org
X-Gm-Message-State: AOJu0YwD0OOeOz1yQh/CIv8TwEE2twW21eiSPKspD+3qPytm2JqV3mah
	K7AWP8lM8sx3SCxXFCs0Qz5+rUUPoLeDAIdv7wqYoFuO3Wn2EsE92XvkrA==
X-Gm-Gg: ASbGncsMUT6k47VX/CGaiXHE/8viQkKM6mUqstjVCTrYeoxPFeGbWNVLTcGebTUst/o
	kTdet6pD1iuDRLd/j7niicUnb5dh66RW4pBwctYpGtTOwFClozSXzO9sXE7WNqgToFYWLoIDBCE
	BlY9tbrBBHBn63XpL+UlEWj+bvIUpmig/rrUMMINlD8DEe3aYxPHtXEduXu8VIb+byILCr+Txh4
	bRf6oNE8LysTUYKhRai3tRzxL4KotixT2w754dKASMoqs7bNWXX5sYBUc+YpVCq
X-Google-Smtp-Source: AGHT+IFY/GoVlMclviETG+R1AFZXYR1yDAMEjS2fnmaE3MToUP/90i9XUgSxGcoBmngjiyE3ApWMMQ==
X-Received: by 2002:a05:6102:b02:b0:4b1:1b07:f7c3 with SMTP id ada2fe7eead31-4b3d0e6376cmr25070480137.20.1736925154757;
        Tue, 14 Jan 2025 23:12:34 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f033ffsm5084366137.6.2025.01.14.23.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:12:34 -0800 (PST)
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
Subject: [PATCH v3 11/19] platform/x86: ideapad-laptop: Use devm_platform_profile_register()
Date: Wed, 15 Jan 2025 02:10:14 -0500
Message-ID: <20250115071022.4815-12-kuurtb@gmail.com>
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
2.48.0


