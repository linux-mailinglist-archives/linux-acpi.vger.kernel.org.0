Return-Path: <linux-acpi+bounces-8866-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B939A5368
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Oct 2024 11:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA8F1F2201B
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Oct 2024 09:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDD347F4A;
	Sun, 20 Oct 2024 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xezrpjh9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503A156B81
	for <linux-acpi@vger.kernel.org>; Sun, 20 Oct 2024 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729418340; cv=none; b=EoYGjka6MoCCifq2tJP0EOIyJYwWqaBFlzheEFAzL3krgfeMJTa5ah8Ax3gjhWt4Szi21MmR9RRgUZqhuusL7cQxaE/0arN5uvJ5O3NfIdhjx+H2Ah/Czlno9100kcZy3O7ERyc18UBr9aCoufs8nBJTgobd5PukkR7cB8wa6hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729418340; c=relaxed/simple;
	bh=c/xF12CRMjBW275//few5ITmMOvj11NnvQl59gra8Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XIbf8z5hWLJd9m7zOysMbYx4pwzIO0x/WNtiSC/zCw7kWHiNjjNjgKEGyA6z2UotwIIUIZt/0S+OD9/390Ts6ZtIjZGgOcqX30fjYEiMJQ6r5PjPZdUyXCQgE77YZLyYKAf/6dlNwZa8x/LwfcJQ9LbLehQfRsKBCGP+Brzu7IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xezrpjh9; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e2a999b287so2732422a91.0
        for <linux-acpi@vger.kernel.org>; Sun, 20 Oct 2024 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729418337; x=1730023137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bHphyOG2Gr9tzg50t0uQ4pxzQvEucKxsH4KsxFbRESY=;
        b=Xezrpjh9GusxrbGCqR4lqkRh+db/dd4MS/B8Jcmhd1G8a4OuZFuXoyC6e2NshMGBRe
         xyU9hxowGmJ3BxXpMVAp+bsLzlj52ldrIxY3wA2EbLVQCNV1tlr4O8bloI9xYKIa+UZg
         x4K67Ha25ERNd/JViJPbLtWZ54LYWL5kwKgAupnr7Dwx8Dc2ANf5Tv1d9waS9iN/onmJ
         /gTvpxFts7bGsMYmA6NLr46gfXhcgnJbi94XsZpn2XHTlDWXqV/gsKFnZPVLludySP8k
         9P/9yMn4DhfCFClJw6c1KY4VqPEbP5JD7YIGmD/Q5VNBqZy6zfuwqvjJ8eHkpst6SXfj
         yhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729418337; x=1730023137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHphyOG2Gr9tzg50t0uQ4pxzQvEucKxsH4KsxFbRESY=;
        b=IzSQMD0yxITYOoQZwL6rO8PLb17Fr4t6vQzJLEjMguASTCPA0HkhRHCEOI5gKoGyd6
         abROiH164BoTP6TNF/nil39BH4aibRQz6IMpShoMdEfBU1KnBf6Aw0QkcPFCJGWpFOvt
         BsaSd0wwFijnV61+4EE8vmM5UFAH2eyVkhPKxidYkFYVofmKcSx8q82eBs0UqQRe+7P+
         j4hi+rVhJqui/bB7cfnWk6HxiVBMeufR377u9iDti3InsyXEb0LFLBOUIEoJ8dsLi+Z1
         D08AgI+Rp4WAu4m042HtGvosBHcEGQ/ZUr292H1ZM62AfW457kvMCKzUuvKuF+UqQVph
         VB+w==
X-Gm-Message-State: AOJu0Yxa33L6ffg16zrzVYlWJ0KNvX2j3gfGX8e9g8NLDqurXM26CfSz
	+It7/rQrXACH5khTxjY/9jn2LgjFxclsKHN1Bk8THvVzrcR94yl7iyRoDw==
X-Google-Smtp-Source: AGHT+IGCj/+srD6rV2YLC0DQ+dsAtsmPN4EWBZYvt+/J0WFbdME+Er1NPGbKUbem0Qy8qPKea3R/JQ==
X-Received: by 2002:a17:90b:197:b0:2d3:d063:bdb6 with SMTP id 98e67ed59e1d1-2e5615d619amr9595650a91.4.1729418336659;
        Sun, 20 Oct 2024 02:58:56 -0700 (PDT)
Received: from localhost.localdomain ([103.235.165.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad388effsm1135968a91.34.2024.10.20.02.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 02:58:56 -0700 (PDT)
From: Shubham Panwar <shubiisp8@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: Shubham Panwar <shubiisp8@gmail.com>
Subject: [v2] ACPI: button: Add DMI quirk for Samsung Galaxy Book2 to fix initial lid detection issue
Date: Sun, 20 Oct 2024 15:20:46 +0530
Message-ID: <20241020095045.6036-2-shubiisp8@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
- Removed extra blank lines
- Fixed whitespace issues
- Added appropriate commit description

This patch adds a DMI quirk for the Samsung Galaxy Book2 to fix the initial
lid state detection issue. The _LID device incorrectly returns the lid
status as "closed" during boot, causing the system to enter a suspend loop
right after booting. This quirk ensures that the correct lid state is
reported initially, preventing the system from immediately suspending
after startup.

This fix only addresses the initial lid state detection and ensures proper
system behavior upon boot.

Signed-off-by: Shubham Panwar <shubiisp8@gmail.com>
---
 drivers/acpi/button.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 51470208e..7773e6b86 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -130,6 +130,17 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 		},
 		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
 	},
+	{
+		/*
+		 * Samsung galaxybook2 ,initial _LID device notification returns
+		 * lid closed.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "750XED"),
+		},
+		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+	},
 	{}
 };
 
-- 
2.47.0


