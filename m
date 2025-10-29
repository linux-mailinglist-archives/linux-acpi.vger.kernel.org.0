Return-Path: <linux-acpi+bounces-18346-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC92C1C43E
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 17:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC2FA5A532F
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 16:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE8934AB1C;
	Wed, 29 Oct 2025 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6u7zSRA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EE1347FC6
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755634; cv=none; b=AWcozwkBrGwKmzZAhFCaIEiRR3UzuU0381j/aHvDQRjXkWkwJ1d9+jtMsEXn+3SWUeTWoEanQKA8kKOcvAhTy9eLKsTfAzPqs4bgldUDNqWxhzD3HCA5XcZ21i09M8K7M6PwgxGuI2v1M654iocvngKdPFt5jOQJHl2tBq2peRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755634; c=relaxed/simple;
	bh=T06l1/4GOHE/LpDkePy4eVSTWo0uNva18SmJ0icOHLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btptMs/kJNmw5MDGkUPocgwSfYFmaoDpK9+TI4VVNcn9RX8VZepB70aUIT9mdU/uUtFYgbZthThMV3bIep0NUGdyBt42FKACMwUmONNphmV/dKJAHKqFRwCwDJwpm0d/9+q5R1x+QlK6PJJwuRTvo6s/jp+KytaF0dpvA3WYJus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6u7zSRA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso15654666b.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755630; x=1762360430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XbRLU+7LExsM1Q2W4kgKdkH4Wh0K6zsU36k2L5dwa0=;
        b=a6u7zSRALXcD5cAfl7zziHXqingpPMwA+3HQpLoOUYAN+T4DZYbzvXQku88P5LytsG
         dSepd0zu7KwPEm+SLTpu7V5mZsAQiytCslwBZjiW4yUtTcTJQVUXYl8R4juqoTdj51JI
         hCf1+U2YwclJoZF5yhDg/VxPsE6YKgy2pkmrqgE4KuIgw4dbPiW6aPL5RpFKbASmU9Fr
         AQZoN4oxCVq06kTWykouoPPTYq731ySwec2CxMhlePbiX0q6OgoGOpbNmyKXbrtrsNd6
         Wt1rhpU4kMgjFyK9e0qmJH4LqvKrN/HO0Gl3VvRi3eWCGseFGqkfUaC9te4+Xnky0T79
         IADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755630; x=1762360430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XbRLU+7LExsM1Q2W4kgKdkH4Wh0K6zsU36k2L5dwa0=;
        b=sTni6ED6Z4CCwN31flKvRJ228cU1d4l580Obd1Qil4KzzH256Kl9aVslCrTKiTkC5+
         enP8HT6KaExhF70Hi+W3RVCH6q68AYi1llT2bDwMUKch+Rbt0xtaD4JAyf4n8B0NXttu
         +eU/I4Z0AHVM2SSObeVAUMJr/dLCw5kYmI+Gxue84rYD30IHZoxWntGyiiDKrnf1dwB6
         yQJnWZ24Ph3IGGu5lq+xLexzBaqhUYUF8DiJNrtL0oODTVhWb3OMAYwZBaq+YVHijw0Z
         j5s2KtJdE4nH+TJ9l5Iezd+dxxPPRTsbeoLOBudp+J3RJ0UzQ+NChMe/QC7dWW2icN02
         etaw==
X-Forwarded-Encrypted: i=1; AJvYcCVn3QLquPPBKZa4uo7itAS4ZGGhs4ZB9J4/fLH7bFtto92NK9wStfbpYxwpCB3dKEvoHcMv6Tq9PKIK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2yfrJKc+x/RbRVJIeshhBEgjgMgChU8CdSr7r51itb1YAIAgQ
	4ZKXBtjMQu54zjFmW0dwNnI75ftCYaGVsB29ZLXqNOgpUpq9WIgHggEy
X-Gm-Gg: ASbGncuMPAYrB3/Efsw1OevXrBYqSSX2XaUCu6Q5IBKKxOhd6x1RM2jzyw8EyD4/C/X
	rh1k70vyJdGpm3jPCYWs14jDq/KSFeXOBM279H2Zgf3RhbeIqfrcpRn8MMoQ5WOaWoWNYuB/lPA
	2Cifcxl2Z2xkNRRMqj0uugiD0qVIbYCqIlc+4BvKeu7Ht5jAW9cAHQhBkp9JTZ8pCvEXUj0Vlw5
	e+IvYPj3zO4sVB1F3tucYXMY1Qv0Y+9B7bahaC1uWajvvOVS7Dbn/ii9A+tZhJox/5/iqRiMQlu
	ZALLe/Kf1hIxFW0xz0yFPJwkt9U3y4eDf75sNCcVbBknP3Brz+1ORsIVcMJ6j7RsaiGFBr6P7mH
	cMngNbkfVBPlON5LfrUBAKq/Yb4aB5X55wiDJXv2EYl9vvsv5fQ5nTF5dKHpgsXNThsSE+sv1mR
	9EeB14x4gEzXpYxlx3irRxdGHF8WhTFhLrF3Dekdgo4hBzOLkdUJb+5llGTz1Lsqq1DV/r
X-Google-Smtp-Source: AGHT+IFQlpirQWvqETIaDsilJH4sjQW05iHSTqO+BVFy04krtNR3muOIO8OYFK3MmzGZwCCaLhUORw==
X-Received: by 2002:a17:907:1c8c:b0:b3e:580a:1842 with SMTP id a640c23a62f3a-b703d557003mr393915166b.48.1761755629552;
        Wed, 29 Oct 2025 09:33:49 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6dad195456sm939661066b.72.2025.10.29.09.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:33:48 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] bus: mvebu-mbus: Use contextual data instead of global variable
Date: Wed, 29 Oct 2025 17:33:32 +0100
Message-ID: <20251029163336.2785270-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029163336.2785270-1-thierry.reding@gmail.com>
References: <20251029163336.2785270-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Pass the driver-specific data via the syscore struct and use it in the
syscore ops.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- adjust for API changes and update commit message

 drivers/bus/mvebu-mbus.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index dd94145c9b22..d33c8e42e91c 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -130,6 +130,7 @@ struct mvebu_mbus_win_data {
 };
 
 struct mvebu_mbus_state {
+	struct syscore syscore;
 	void __iomem *mbuswins_base;
 	void __iomem *sdramwins_base;
 	void __iomem *mbusbridge_base;
@@ -1008,7 +1009,7 @@ fs_initcall(mvebu_mbus_debugfs_init);
 
 static int mvebu_mbus_suspend(void *data)
 {
-	struct mvebu_mbus_state *s = &mbus_state;
+	struct mvebu_mbus_state *s = data;
 	int win;
 
 	if (!s->mbusbridge_base)
@@ -1042,7 +1043,7 @@ static int mvebu_mbus_suspend(void *data)
 
 static void mvebu_mbus_resume(void *data)
 {
-	struct mvebu_mbus_state *s = &mbus_state;
+	struct mvebu_mbus_state *s = data;
 	int win;
 
 	writel(s->mbus_bridge_ctrl,
@@ -1074,10 +1075,6 @@ static const struct syscore_ops mvebu_mbus_syscore_ops = {
 	.resume = mvebu_mbus_resume,
 };
 
-static struct syscore mvebu_mbus_syscore = {
-	.ops = &mvebu_mbus_syscore_ops,
-};
-
 static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
 					 phys_addr_t mbuswins_phys_base,
 					 size_t mbuswins_size,
@@ -1122,7 +1119,9 @@ static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
 		writel(UNIT_SYNC_BARRIER_ALL,
 		       mbus->mbuswins_base + UNIT_SYNC_BARRIER_OFF);
 
-	register_syscore(&mvebu_mbus_syscore);
+	mbus->syscore.ops = &mvebu_mbus_syscore_ops;
+	mbus->syscore.data = mbus;
+	register_syscore(&mbus->syscore);
 
 	return 0;
 }
-- 
2.51.0


