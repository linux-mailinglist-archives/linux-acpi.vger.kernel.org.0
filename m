Return-Path: <linux-acpi+bounces-20430-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 135C6D3B606
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 19:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12EC93025126
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 18:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD2D38E124;
	Mon, 19 Jan 2026 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVaYkFjc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF67532B9AE
	for <linux-acpi@vger.kernel.org>; Mon, 19 Jan 2026 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848236; cv=none; b=l96Y5na9YXuL9OrBK0XbCvxkeMw9iIG8lIWkBT8Ny1pdU0pwCuX+0U+24yEJYuC5R3s5x+UaA2nS0uRJKUgWa5noqAs7W/B8DLAuANEiKouKYKuSGacYjuM+adECifKP9euH49TE2P5IxcyOgpPhKECrtAjR8/J27CEPkoE2nAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848236; c=relaxed/simple;
	bh=EORSyWTZBwNF1raDitypZ1JbYxUbDPTZfmSxwsWftPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rf+UlXXUBmwhv6PU3+cJP8VxFtz57Y3oiWZNNZhA6EnHfcTXtBV/TincMKCpe/615DELWqieh3EgQp1ASlDX/bulsXClt94078EPwsGngxuailRvTXIssNaSzk7AK4Cq+U8/4r1edIeJRZA30Qvr/2tvFjEZtW8JfIfXNiR9eHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVaYkFjc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0a8c2e822so10147585ad.1
        for <linux-acpi@vger.kernel.org>; Mon, 19 Jan 2026 10:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768848234; x=1769453034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5rQM+3IbfMPNIay1Twh0Q12FnCMhsPC2tkfESLTSnl0=;
        b=RVaYkFjcNB+tNs+p8Yy/KTAn1t5fKcinQwsG7PYclvjJzMvK0QV/xRKSYXkZEO5lof
         2nnX57Tw7zhecLr1qt8ieNq92hO1iiQcpHc1tnFw9GIzjAwr5+W19bG+TesBeYvuYVU5
         GPIYgLQGczrEMRdmLrPI8wcm35gOwoZKtxT5uPcfoGsk2P+7Pi899650ek1VgWaaE4UN
         SbpebThWjjozr1PgzhAv1mS3O7b1BcrIX57cAIuL74AED8HEyvssg9Lq2E0TrjrFMoQF
         UMleZ1inBJTSZZnCo6dCRNCg8l9iOld/3T2qtda84IfkfylcSXoaMj6F7mSz96kvSkR6
         Yo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768848234; x=1769453034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rQM+3IbfMPNIay1Twh0Q12FnCMhsPC2tkfESLTSnl0=;
        b=Z9dGDJDK1LkkB4Qm544reqfFIJdd64jlUxwj7CxECDVCLHeNgfqbAWKdqznkopdGVM
         KylpJ4cCDubZgDcvby57hvgZpGxBk4mxzl9CU0WKFjTNXuMvxp2J6VbW8VBj/hlVwdFF
         mWY6IPZhWVpRCLE37ydll/6nfbhSIK2RgZ7K3TOB4xz5/BvhxOvF2CjAXqjdgWpg3CaE
         7Y9pgGJdkxJZgIBW8bZym1YoNoGqcohoCGbZJYZgNqWsPwCZva2PCBtJ+dPnOYiqKJcY
         PLyaaWydJ52iixm81d72ik/sVxzV5OxZ8rmAjr2XJ8zloUqflWXePcGG8IFCQr+8wyj5
         GGQA==
X-Forwarded-Encrypted: i=1; AJvYcCV0i5aZzjjaV+lFfGefD7k2j9eMam9uUYS/mXj4Rmb7fbpcAY46bXxTxOczgPad/7od7z3flO35TIKF@vger.kernel.org
X-Gm-Message-State: AOJu0Yylv5RsX0gtj5QHQ4i4i5NuZjmEXYqJGx6E2JmOf5CI9HRC5i9R
	E/kOoYTTGr1+wKfvGWh7jS3RxqnvQMhMB5QWaMHEyoSO49LS7bCdkzQd
X-Gm-Gg: AZuq6aJwvwJ/BD+LW6jnwJOnPNGzSECdYOLfA5GJtvtQKHPQ6zRN3orzFXPBxODDe9p
	EhOvVoQSOnZ5M5IV2jEgYPgi4UD+QASmth0SW3fDgRqZIlkLWqT/J5cQsStkDgbNvPAJH6jJY0q
	h9aryvcE+njTESI+/YL27gLsfsCnRHliQylGpEjYmzO3DYcLFzD9KKhhUDa4p8zLo4WtE6WIE61
	P5kJ1CxlfrNNuupaPCLmhxPn0GQKSXCgH8b7+/gyNQMO5OE5JWeqmmf6II9w4dHFAkhxOUxqKYr
	iNLUQNwt2WeMjpMKVRc96RkAUJts17Wg//q0yx5mQem+wG5n9v5a69Un1jbqEb/7NrnRhfkKzJV
	vYT+kPzjonGeiLx6s2L2Y3decYRSjQsuAvfc18044VrY8anZfywJEzrQSiVq42vgJ+o5nqeP1e2
	IcdRlV6J6rzRXIJ2tbrXEhDCJdkV8BycwXHS0u06pUgS1yp18=
X-Received: by 2002:a17:903:2304:b0:2a0:9424:7dc7 with SMTP id d9443c01a7336-2a7504df561mr3155255ad.4.1768848233978;
        Mon, 19 Jan 2026 10:43:53 -0800 (PST)
Received: from localhost.localdomain ([132.237.156.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190eee39sm99854165ad.45.2026.01.19.10.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 10:43:53 -0800 (PST)
From: Shubhakar Gowda <shubakargowdaps@gmail.com>
X-Google-Original-From: Shubhakar Gowda <Shubhakar_gowda.P_s@dell.com>
To: dan.j.williams@intel.com
Cc: vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	nvdimm@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shubhakar Gowda <Shubhakar_gowda.P_s@dell.com>
Subject: [PATCH] ACPI: NFIT:Advertise DSM function 0xA (Query ARS error inject capabilities)
Date: Tue, 20 Jan 2026 00:14:36 +0530
Message-ID: <20260119184438.19942-1-Shubhakar_gowda.P_s@dell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ACPI 6.6 defines DSM function index 0xA to Query Address Range Scrub
(ARS) error injection capabilities. This patch adds support for this
DSM function in the NFIT DSM mask so that userspace and ndctl tool can
detect platform support for Query ARS error injection capabilities features.

The patch updates NFIT initialization to include DSM 0xA, logs
supported DSMs for debugging, and uses the existing DSM infrastructure.
No kernel ABI changes are introduced.

Signed-off-by: Shubhakar Gowda <Shubhakar_gowda.P_s@dell.com>
---
 drivers/acpi/nfit/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 5a1ced5..6cc863e 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2113,6 +2113,8 @@ enum nfit_aux_cmds {
 	NFIT_CMD_ARS_INJECT_SET = 7,
 	NFIT_CMD_ARS_INJECT_CLEAR = 8,
 	NFIT_CMD_ARS_INJECT_GET = 9,
+	/* ACPI 6.6: DSM function 0xA — Query ARS Error Inject Capabilities */
+	NFIT_CMD_ARS_QUERY_CAP = 10,
 };
 
 static void acpi_nfit_init_dsms(struct acpi_nfit_desc *acpi_desc)
@@ -2152,10 +2154,13 @@ static void acpi_nfit_init_dsms(struct acpi_nfit_desc *acpi_desc)
 		(1 << NFIT_CMD_TRANSLATE_SPA) |
 		(1 << NFIT_CMD_ARS_INJECT_SET) |
 		(1 << NFIT_CMD_ARS_INJECT_CLEAR) |
-		(1 << NFIT_CMD_ARS_INJECT_GET);
+		(1 << NFIT_CMD_ARS_INJECT_GET)	|
+		(1 << NFIT_CMD_ARS_QUERY_CAP);
 	for_each_set_bit(i, &dsm_mask, BITS_PER_LONG)
 		if (acpi_check_dsm(adev->handle, guid, 1, 1ULL << i))
 			set_bit(i, &acpi_desc->bus_dsm_mask);
+	dev_dbg(acpi_desc->dev, "NFIT DSM mask detected: %#lx\n",
+	acpi_desc->bus_dsm_mask);
 
 	/* Enumerate allowed NVDIMM_BUS_FAMILY_INTEL commands */
 	dsm_mask = NVDIMM_BUS_INTEL_FW_ACTIVATE_CMDMASK;
-- 
2.43.0


