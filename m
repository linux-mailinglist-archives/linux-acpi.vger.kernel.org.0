Return-Path: <linux-acpi+bounces-20429-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 971C8D3B562
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 19:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86999309B654
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 18:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBCA27B4E8;
	Mon, 19 Jan 2026 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1cJBiYe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B623B2BEFEB
	for <linux-acpi@vger.kernel.org>; Mon, 19 Jan 2026 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846664; cv=none; b=Z1WxB4br2UzMpdUb2xx7JLxFLH9uGHbFxORtwtxple+CoZrvubIqXd6oNsP4GcyFGZ5wL0g3+QJ6Tks21XtYkiUpov2sCBWhL1WZtez6ZFPrymjAQo893vd7VionFICxO1wzqcOe52KrEZkgvRV0SzECGPfUJB+NvXqsy+s1TFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846664; c=relaxed/simple;
	bh=/jm4Mas2zraHDvT9PHW0pLh2gbG8Dc3XSEFgWHhsUK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UFcyRKnbSLL4AevoymNYPYAde715/Aj0HHFryIuB8AWwl6SMbTqbY4uzsIil6zHpQYQhxa99e1EqApvWMhSfYElPEv5axAt9NAXk3FwVIFEqNGawP07IhSHUfRK9Jo2J+OOm9HjMKQohGeZ/7rayALGH/rT1eDouuhmgzg1kxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1cJBiYe; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29f2d829667so11099515ad.0
        for <linux-acpi@vger.kernel.org>; Mon, 19 Jan 2026 10:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768846662; x=1769451462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X2A95NLnAAenZYeB6sIfMlTKuGidxofuewRgFBA/sdo=;
        b=d1cJBiYeKO+IniwoVqNF3t6b3xUiLO+KMmeixIdAD1ioyioVePg9NepgX8jJ6skRlz
         rMvwSiME40XxgrHYOUh6omj84e0VUx/52BLiHr/14IUCOP6CFbuBLefQmJXo19GSFsW3
         75E1xkXYNnahYtP1v7hu7NN5iSzmTzqVPCurtF6TGq9t/BPdR1JaGiMsGHTE3jlWbJh1
         lR22bU39uIqL2rl1KwA1mjrGvWYOEGpgyCysJL4Rn2al+DfVhuqCI/MJ/VdqFPUz/rgo
         Q1HvsvrRM3kAkf6p+/T4ZYnHPdOC+/FVWjwDg/bO9wsVKKQyMZSsDAM4niEmu4e58aod
         ZmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768846662; x=1769451462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2A95NLnAAenZYeB6sIfMlTKuGidxofuewRgFBA/sdo=;
        b=JpWbH0KG65BNi1U0DWS2lEaw3OWb/FeD9ImExh+rM6JgLHF+tpWYOsxJHNcWhKridl
         Suw3v7LamwcDesg558KHA9iLjoYEtYtVP09mkvawpigCJzvjbWWEnpNH3Bp1PTF2OkuJ
         ZvVV1b3xi5c6XGBUNK2S4oIujd8qwWvo0RrZOStX4yKwTzW6+bjaW+dzgGBOpWoq//hh
         OIp1XCn2Z9cuZ2vorE1lfHJq1k77+Q7fupJaZ/qEQa5xBO+etTM5OYMt2A/FyWBwDJzN
         WKy/ib3ikJMMEO5aubEaLXobzmxRHGs3ERAHNrZZ2A0pNGQKszABmC4tsEnzQkZDJagK
         8ugw==
X-Forwarded-Encrypted: i=1; AJvYcCXsrfaOB/4Hp4v/CCFQsb5YQJ7h1YX9kIS1EUEQsrBQsJDFvCsAFG/P1SNjZMTLiCK4yZe1a1uO4re3@vger.kernel.org
X-Gm-Message-State: AOJu0YxXLkeik5DvBt4kKCRXfvyQGL4fSI5tLWQHJ0+LDkkn8GKy6DiR
	Reb24kTtWNs7WlmpxLiTX7x+Ps/5aSvX2X0Sa/DmteIzvaEhPYUyh3UA
X-Gm-Gg: AZuq6aJ09YOKSbhfRYgv4UFMWVpbCSso6ORQjIDZAGSaDfCeX/6lRcP/SvlW/2xpEI8
	jcBI6jC0zJXp0dPQHqHa24Yd7mZuIwEgfHmOIb0xE9yWHjQFG8TA5XlzQAdU1L+wOcUHCJivePy
	i4Nm7mVSe/3UoeKI8sIougDC56cbA5IPxO8f9k2vvzTI2kWFfCRRFh7vL0uJ34Ero1B5+0wtDLU
	HLk3kejnoxcLgXC1rp+/EtcX1d/SVYodiBY9jYkaAWvOWgmQc5cCdQF8sDOChcjyyORCrB40lyr
	AgPwStjnkEBFi/tulXkAEol4wtzAsI8UMO2xllDMaNdQD7uQXu3KQuOyJQ5dyglH/XBsGOaxGu0
	vXwQe2IDBFoutlv7nQoSqGj4AHoGP0Xkqru9FXwhHvUcg/hpV00bpgqBf3ReJLjCcNFCyEwa5r2
	bhD/T5kRfqoVn3UbyXsaHW4Fh1jHxiZ2HYG1gA
X-Received: by 2002:a17:903:1a2c:b0:2a0:d07a:bb2f with SMTP id d9443c01a7336-2a7175283d3mr88983575ad.3.1768846661950;
        Mon, 19 Jan 2026 10:17:41 -0800 (PST)
Received: from localhost.localdomain ([132.237.156.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dbebasm102334145ad.55.2026.01.19.10.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 10:17:41 -0800 (PST)
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
Subject: [PATCH] ACPI: NFIT: Advertise DSM function 0xA (ARS error inject capabilities)
Date: Mon, 19 Jan 2026 23:48:22 +0530
Message-ID: <20260119181824.15408-1-Shubhakar_gowda.P_s@dell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ACPI 6.6 defines DSM function index 0xA to query ARS error injection
capabilities. Advertise support for this function in the NFIT DSM mask
so that userspace can detect platform support.

No kernel ABI changes are introduced; this uses the existing DSM
infrastructure.

Signed-off-by: Shubhakar Gowda <Shubhakar_gowda.P_s@dell.com>
---
 drivers/acpi/nfit/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 5a1ced5..8dcd159 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2113,6 +2113,8 @@ enum nfit_aux_cmds {
 	NFIT_CMD_ARS_INJECT_SET = 7,
 	NFIT_CMD_ARS_INJECT_CLEAR = 8,
 	NFIT_CMD_ARS_INJECT_GET = 9,
+	/* ACPI 6.5: DSM function 0xA — Query ARS Error Inject Capabilities */
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


