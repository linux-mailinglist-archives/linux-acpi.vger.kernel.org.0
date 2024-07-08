Return-Path: <linux-acpi+bounces-6801-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAFE929A4E
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Jul 2024 02:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234C71F2122B
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Jul 2024 00:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C76A19B;
	Mon,  8 Jul 2024 00:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fusetak.com header.i=@fusetak.com header.b="S/vN5LTn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9010818E
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jul 2024 00:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720397197; cv=none; b=pLd4egu4mRfewQqI9IWLCr4YFaP3wa+SZr3aptKnp4W4FLDISlYo08Er78UXaiDPBclijtmazl0qkj5A3p1jmikILc1eQnP5JSPJL1EL8qmK5xRsuubO+BGAe0nDuGOvV+mTYBZb1v1uD/OeC9TuCXtm6udkldnZAsX9kqY/bSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720397197; c=relaxed/simple;
	bh=Ed227rTJTRKb15N4gh0qm0jJKaGWOvcE5Ga7wap2ak8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hU1OR0atiju4NCZvkXfHXQF5atFWUcWENDq+TqBLk75PIWhRjWLU2SN059K6FLis+8j7Y6uWAZCRAiDigWvuK9PMNLygkPyiS6KojuXGc4gzYLENJP4BHZaNwV9MV5kN8pCGIUytUKPUM8jm1+HmUCD/20pEMrdMaS96J6nuIac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fusetak.com; spf=pass smtp.mailfrom=fusetak.com; dkim=pass (2048-bit key) header.d=fusetak.com header.i=@fusetak.com header.b=S/vN5LTn; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fusetak.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fusetak.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79ef7635818so171893085a.3
        for <linux-acpi@vger.kernel.org>; Sun, 07 Jul 2024 17:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fusetak.com; s=google; t=1720397194; x=1721001994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EfqbVBNHZIB56HdwvPuy3F6TWH0ICBNQN7SH/0/xgdA=;
        b=S/vN5LTnMDcQQ1OF55EzBp7/6H8il2h5bocdaE4Y+lfVKcbAm5U3V4VT/MGv7wYEDh
         32aqpYNdvY1YOPM9zuJrneaQEgwZ0pfQDj7oJ0R5jL0b38g8NFercC1ho7laah2PFdmw
         b5BgJL3TRHZLuQTf4Xw6+gnLtyJyr/PalK3nSYLuwUFIPxupC498OQhL93YpsOmvEsMp
         GX4pLUK6ASsmZtrL/Ki5Dm5k9yEweGhrp0L8SJ6h8xvtLlRZMT64k49Egl1hGJ+i5LQS
         pSw3Xaq1AOuMSWf6Pi/aSvXAbK8i5YTQoORWMymUZjg/oLHPBwHCHyjdXh27Jf+FZ5bR
         8N0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720397194; x=1721001994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EfqbVBNHZIB56HdwvPuy3F6TWH0ICBNQN7SH/0/xgdA=;
        b=K9ZwFCDDY/ZFsSqMplrBVINwkhHjiaUSXKxO/36JnFbJk3WkcEACyMqCp0gbFIq6vN
         LyYnivBNeehDyqj6AJKhxUYR1MmEeZL0MphKXJTOvVyLu/J53ChGSQ51PwKYCw1WzO3D
         X2Lm9KlgkZQkx6tI5JpRA5xr2E3Q6lVezukJVFWDJ1WAqV6sN/XmW1ZvpGiXX/f96UOs
         1gaKduhwTQ1ScD2T5pzHxWKjAsvTidihKf8wOFN52hijp95ErzoBpRrEwEQK4ON4zxGW
         MCHwRfY7Yh+ThKO66Sdm3rGgzhgDTs8vkoY2wtg5UqMVzWs/wKDoNV4bMgdv7IAhx2Om
         bJlA==
X-Gm-Message-State: AOJu0YwJDS0GBGLrddeQ3E4NB1j0bKUa04AhYflHGD9Xzxq+zuC/WpH+
	ARtnScBeDAHqUtILgioUb81ZgeG1oTCcfiQmt9UqBlzicPlreawWSSiRBJmQBFwQzOWABeuLpUL
	M02wZ9A==
X-Google-Smtp-Source: AGHT+IGaGfLx6Cpi/WSkHy4kThbq+k0j1+eGAkJCZP0m7Sqg5CDyuGVAjwP0Obn4N3irk4SClRQhrg==
X-Received: by 2002:a05:620a:2956:b0:79d:5ff7:aa83 with SMTP id af79cd13be357-79eee1a5932mr1373064985a.3.1720397194297;
        Sun, 07 Jul 2024 17:06:34 -0700 (PDT)
Received: from fusetakDesktop.internal.fusetak.net ([2607:fea8:4d9f:ec87::1059])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f04ee5cc5sm184658585a.67.2024.07.07.17.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 17:06:33 -0700 (PDT)
From: Tamim Khan <tamim@fusetak.com>
To: linux-acpi@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	Tamim Khan <tamim@fusetak.com>,
	Amber Connelly <amb3r.dev@gmail.com>
Subject: [PATCH] ACPI: resource: Skip IRQ override on Asus Vivobook Pro N6506MJ
Date: Sun,  7 Jul 2024 20:05:50 -0400
Message-ID: <20240708000557.83539-1-tamim@fusetak.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to other Asus Vivobooks, the Asus Vivobook Pro N6506MJ has a DSDT table
that describes IRQ 1 as ActiveLow, whereas the kernel overrides it to Edge_High.
This discrepancy prevents the internal keyboard from functioning properly. This
patch resolves this issue by adding this laptop to the override table that prevents
the kernel from overriding this IRQ.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218929
Tested-by: Amber Connelly <amb3r.dev@gmail.com>
Signed-off-by: Tamim Khan <tamim@fusetak.com>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index b5bf8b81a050..7478805df3a2 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -524,6 +524,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "N6506MV"),
 		},
 	},
+	{
+		/* Asus Vivobook Pro N6506MJ */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "N6506MJ"),
+		},
+	},
 	{
 		/* LG Electronics 17U70P */
 		.matches = {
-- 
2.45.2


