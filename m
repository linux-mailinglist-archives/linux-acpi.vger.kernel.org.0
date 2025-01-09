Return-Path: <linux-acpi+bounces-10459-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CADB0A07B4C
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C284D16966C
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B72021D5A3;
	Thu,  9 Jan 2025 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9LZ29SD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9672206AE;
	Thu,  9 Jan 2025 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435334; cv=none; b=vA3VrkVWg/hUe0PWlqdRRP8zwqtgd2QdwwNb493ePNVBZ/r3uGZv0u63BNqquTxk9D/ls6EWmaAthvrqMD4tHYFgIqqrKmQdDM40lEHxtMFpnxh/uKJWvBfGpEhpkxhgQ8Kv5hmOOYqBukh8WTGRuq+VCC0nxZ83BiaMtCiV6xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435334; c=relaxed/simple;
	bh=+pQFibEAjx3fhuHAJNt/J0bsuHSnnAYKNMWP2WmQ4uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8ZthmI8UTAOKW4trUnlCX3chqifN/kHVVPiWHxzgHFmpOPGH2FjsSrsArHAXjOnzsp5KyeffyK8oFDNfhFf+u4uRymhetf/R9Lvq5ZIkfA/VA0HZjkvpbz1SBEyIh9dwwDWSROrVfh7HZpV/nuXSLOsfM9ZA02/2QpTxbosKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9LZ29SD; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4afd56903b7so359944137.1;
        Thu, 09 Jan 2025 07:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435331; x=1737040131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjDgxfYVgerBzLzfq9ijJVLGFXFEgkBOlqWQa/hqQF0=;
        b=g9LZ29SD5SiYsTCo7vvISWBXrLBVc7H6GMsfpiuPuwPY+zv+AjvG3ycc6rykUD+zIH
         sd/TG/qEkDi8wRWr2s9ftvL86OQvhQINzVHi1x46mIgz/aES0YRXjWRqW3nFCcFdRxiI
         U2SrMGBVyD0M9C+y2yX7o7RHzEBDf+kWr6+bcjO2YfwZzYob75aLyvWfGyaF5G1afGkM
         F0EaobzXc1BFaRU2o1+6gRFTrWr9Bx+ryAdkuBxfULpIbjJQ+36WyXR8NNBFqjsciHXi
         1VEErVsot4KE1qn3npKmqpRzkXrD6rGw8c+EkNmFCfnPvRwiIReEofiSx0k5/rs29GHh
         8+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435331; x=1737040131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjDgxfYVgerBzLzfq9ijJVLGFXFEgkBOlqWQa/hqQF0=;
        b=dm9yeZkEsvEGr+oRiE7V9W7Z6E2j3F9azpgBY3yotWNU1nZAD9VnnbtiF5SM4enx94
         NxA7g7LhyyZt4gdz42youSz7PWQAV1FFlkFnPNEvzTYwuVYwYV3NiU3MS1W2wQFx1hV1
         DJczCkIqkAyfRZVLHqNUKZsWl0CMCsQjmZq95un+QIB+wFuBDHPY9s3DOBwQm7s1YY0n
         yTIMaerec/hYtwbKqrAvWqXZ+LyC9sWbbYluknngLfqcceUBALwSVclH0AEH+TmcvlO+
         yFRUJsYryT0j4TuBbsa+7h7MpogfggyWvGkEDd3MZWIbJXgcnKY+0n8gYFP+e7cY/qWg
         dHGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN9Ktq0OrzksESUj4Omg75frsOLyTDVRgzOH6sE3UaytMyjTnO/a9v84fe35L/hH7jshlGmWrMBHMW@vger.kernel.org, AJvYcCWTF6R4UGfQ6jcBbTTvR3PpOKcqgpcOB4VlsWu9i9XTz1mkNskiTyavoy839Mckfj2ZUm2FGmmT2dfykSJV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3zn40Qjrxl4cWiks9gxh6n0DGSXD7u0JU+jVVDsjV8M7GwBGe
	fmx0fVL+XRCys0VJqjUYeRvrsc87fGV6ac19BbCcV8buB0EHHrfIRfbgJQbS
X-Gm-Gg: ASbGnctoFHBli4rL/st90A+C0jgIGc+7dBPS4mafzWByL05nQWRY7G0aNLtG5aBbLTM
	UOSJnUCsrYJTFPPJyBWPKAiaL3//A6O6yUD+jDPhcuw7pzJbLBJZ9ONK1JQlnJ+7s2JMTk52w+J
	S293BpVfuS+aE/S7u6NcNkc0JyDy2sbzGwjgBYzEzYkwYAZTFgfKxx0pYABxPfX4YNqiD85WDXH
	OYwHHSbvS/zJUIXNDoYumKYxREaASRSVGSJ+1kKDnYT3IgF1dIT2MxFr6s6fwRC
X-Google-Smtp-Source: AGHT+IE3OpgIgY8w4vOlfqAoadsrw3xphaYjGr34L9DX9hWpRlW1LEhdiSl+3kVD1AlwTW6vgUuw+Q==
X-Received: by 2002:a05:6102:50a5:b0:4b1:ed1:56ac with SMTP id ada2fe7eead31-4b3d0dd7df6mr6395494137.12.1736435330794;
        Thu, 09 Jan 2025 07:08:50 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f4a5ddsm1019887137.11.2025.01.09.07.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:08:50 -0800 (PST)
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
	Colin Ian King <colin.i.king@gmail.com>,
	Alexis Belmonte <alexbelm48@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Ai Chao <aichao@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Gergo Koteles <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH 10/18] platform/x86: ideapad-laptop: Use devm_platform_profile_register()
Date: Thu,  9 Jan 2025 10:06:23 -0500
Message-ID: <20250109150731.110799-11-kuurtb@gmail.com>
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
While at it, pass ideapad_dytc_priv to the class device as drvdata and
replace uses of container_of() with dev_get_drvdata().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/ideapad-laptop.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 43e4d9d8d595..d34d565172f5 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -936,7 +936,7 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
 static int dytc_profile_get(struct platform_profile_handler *pprof,
 			    enum platform_profile_option *profile)
 {
-	struct ideapad_dytc_priv *dytc = container_of(pprof, struct ideapad_dytc_priv, pprof);
+	struct ideapad_dytc_priv *dytc = dev_get_drvdata(&pprof->class_dev);
 
 	*profile = dytc->current_profile;
 	return 0;
@@ -989,7 +989,7 @@ static int dytc_cql_command(struct ideapad_private *priv, unsigned long cmd,
 static int dytc_profile_set(struct platform_profile_handler *pprof,
 			    enum platform_profile_option profile)
 {
-	struct ideapad_dytc_priv *dytc = container_of(pprof, struct ideapad_dytc_priv, pprof);
+	struct ideapad_dytc_priv *dytc = dev_get_drvdata(&pprof->class_dev);
 	struct ideapad_private *priv = dytc->priv;
 	unsigned long output;
 	int err;
@@ -1123,7 +1123,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
 	priv->dytc->pprof.ops = &dytc_profile_ops;
 
 	/* Create platform_profile structure and register */
-	err = platform_profile_register(&priv->dytc->pprof, NULL);
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


