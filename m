Return-Path: <linux-acpi+bounces-18347-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A19C1C387
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 17:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 798A35A5608
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 16:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA12F34CFC5;
	Wed, 29 Oct 2025 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPTPgjgT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6467B34888D
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755636; cv=none; b=uu2C+SpLkcGbn1T3uvBe8s6eVGGYlmjcJ52KJa7M9iOldLCgzFHdDgLEvG8QKhgCYc7/gMe5qSUlX3EKHop1eaAiOEExo0vRctEjdSf6RsNa+CKd5L41o5JIQK3TycI8kcq3xlh18xaqtodsahqu8PpXL4NysWi7ovBRDkkRyAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755636; c=relaxed/simple;
	bh=x/c8Gau2O3gfj3+358hMm8pmNs7v1wm+QbURDM7KfoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjFWprSzjDK/QWGxmHpFVTh5atK0RCsj3qqpkmJnVC4oEhzx+E1Ddz4PpfoPy37ssFBGdfYJ1fd38MDAqKvEtIk4g8LQL8U4bLISU+2eO2h4OTdvJJq19/JoA4J/6CnzPFzRa8kg0z/V3CM4CENw19R5jLzADzEVwVgdoRzoP0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPTPgjgT; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so18726866b.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 09:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755632; x=1762360432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3ZWzIw+tzavBMOmDgztL9+WJKK3w3KSDq6YVOazGFI=;
        b=nPTPgjgTOV4QvNiw767EkPXP8nZH+vMB95IK/uUyEapExC1xYDWPM9TY7fbFAnRlyR
         5go9001Apeiz1bCEoM9ktB19pnCqBYoMUiyerZmB97OscW9O+xPEWD3Y6x1trevTW6Gl
         gtcCynIa2cisxbIx6H8ZplCo7ErSv7aVeY2Jmyd1HkESnUSaaT5C6jz/K9oiV202/a/O
         ZCLReL5xckIEkVq8agGcgTNlA51Si/lOJzd6MVTxeioWIsLWGosNJ02BzgImHOjNw+nS
         ckb+/uuvh3BfuFZedwV9ZcgQrZ6O8PkRxXJZ+nnx1vURNkUTUuBoe6Rt32URkixI8fci
         PCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755632; x=1762360432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3ZWzIw+tzavBMOmDgztL9+WJKK3w3KSDq6YVOazGFI=;
        b=R1fo7Y/84yda7pObIVlFWeoB0QrwqKxbD3iKga5U9v8NYFBMbtT9gATayzyBdwQdEB
         1CCZXr7VYxU6RGt93uoz9eovM7OORvsW/OuY7VhfmRCz/TQ3riNe8f4FP4C0tyAhyWxI
         8Q5AyBMpM8VwbZdLdFCGhl9ncK5WS5oUq+TSLivKDvnX9o66yPgIP16M5awwxfiKnGK/
         0uN79rfWR6McJ33T6hxLBrAmjqirGY9bN3tqlA5eEV5/C34E2kGiTRkGz/K930Ak/ia/
         Xdt8E5DyQpUaXieRfhEC/hJrcpbnz/z/7wNx9hua8m7dCTd/kHy9SABRGIIc7ywuIiYI
         ne0g==
X-Forwarded-Encrypted: i=1; AJvYcCXybBiJ/WQIrU1YHRaMJ2xIVaqu8cG1fm+erO9b10IlxsRq/SG/TRL6ozGHJoeM9byr7EMF+mLmAtf9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzo/XkWR3Yyo7qHR+wMMAEKOB6bHrtXk87p9hJYM7CqWApIiby
	EWtiZyLLy0rxIaN0nCGy1xuWwWJ4uBKDP5Jadb+ELBLArykqtFXuHaH0
X-Gm-Gg: ASbGncv88jW/0gsBlGz7wkIW4nwfDrnr5knh1+pokI1ZkrkwJL7xJLjIHRxv9AVgrEG
	lZG+Vnz9pXq/2MaB5Wrf8q0IfJKd9Y/Czoh0mdEri734qDv1cLDuYJ2p4a58+O30Z7lRxQGT0Fs
	4lZVLiS1eoaa47mnC5zzcSjsuh5EqYz0hHJaC7u3P0IeEmV3v9eLJjV0Bcoc+NJNmgOFh0j3usY
	LgoNmUbI452cVh/JE5mjFI5hUUUuuY27u9QvsAGPcH7o+f0DK6Fcjc3wZGNyBb2FzXSgSv7JK2d
	5gRza2I01LD1IznZymYHJlmsnAe1lYMZq3lJyBKjN6LPoFTzGPIcWlAEMqZPB7C1yp2C0vwXl4d
	+/SZhny7pei1vDGz5bKOlm/U2hmWhG48U4x1ORFqAMkTZeqPQGtQ3lQqplpSzbnfw+KervizKZN
	ZvcngrSZqncMGhezKOW1qeIsYiS3cYcCD8kzLU7FeJCTB0cgTHUyhhTfYR3pd1R2ZZehGS
X-Google-Smtp-Source: AGHT+IHRieiPBGU6MC5P5jZHI6G/6PD4P6RVg3Iggx9u+yanu4koYZOv2T4MUr84z07ifr1PiVwzxA==
X-Received: by 2002:a17:907:3da4:b0:b6d:8da0:9a24 with SMTP id a640c23a62f3a-b703d2dc3fcmr322653366b.9.1761755631652;
        Wed, 29 Oct 2025 09:33:51 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6da1e2226fsm1067814666b.20.2025.10.29.09.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:33:50 -0700 (PDT)
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
Subject: [PATCH v3 4/7] clk: ingenic: tcu: Use contextual data instead of global variable
Date: Wed, 29 Oct 2025 17:33:33 +0100
Message-ID: <20251029163336.2785270-5-thierry.reding@gmail.com>
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

 drivers/clk/ingenic/tcu.c | 63 +++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
index bc6a51da2072..8c6337d8e831 100644
--- a/drivers/clk/ingenic/tcu.c
+++ b/drivers/clk/ingenic/tcu.c
@@ -53,9 +53,9 @@ struct ingenic_tcu {
 	struct clk *clk;
 
 	struct clk_hw_onecell_data *clocks;
-};
 
-static struct ingenic_tcu *ingenic_tcu;
+	struct syscore syscore;
+};
 
 static inline struct ingenic_tcu_clk *to_tcu_clk(struct clk_hw *hw)
 {
@@ -332,6 +332,29 @@ static const struct of_device_id __maybe_unused ingenic_tcu_of_match[] __initcon
 	{ /* sentinel */ }
 };
 
+static int __maybe_unused tcu_pm_suspend(void *data)
+{
+	struct ingenic_tcu *tcu = data;
+
+	if (tcu->clk)
+		clk_disable(tcu->clk);
+
+	return 0;
+}
+
+static void __maybe_unused tcu_pm_resume(void *data)
+{
+	struct ingenic_tcu *tcu = data;
+
+	if (tcu->clk)
+		clk_enable(tcu->clk);
+}
+
+static const struct syscore_ops tcu_pm_ops __maybe_unused = {
+	.suspend = tcu_pm_suspend,
+	.resume = tcu_pm_resume,
+};
+
 static int __init ingenic_tcu_probe(struct device_node *np)
 {
 	const struct of_device_id *id = of_match_node(ingenic_tcu_of_match, np);
@@ -430,7 +453,11 @@ static int __init ingenic_tcu_probe(struct device_node *np)
 		goto err_unregister_ost_clock;
 	}
 
-	ingenic_tcu = tcu;
+	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
+		tcu->syscore.ops = &tcu_pm_ops;
+		tcu->syscore.data = tcu;
+		register_syscore(&tcu->syscore);
+	}
 
 	return 0;
 
@@ -455,42 +482,12 @@ static int __init ingenic_tcu_probe(struct device_node *np)
 	return ret;
 }
 
-static int __maybe_unused tcu_pm_suspend(void *data)
-{
-	struct ingenic_tcu *tcu = ingenic_tcu;
-
-	if (tcu->clk)
-		clk_disable(tcu->clk);
-
-	return 0;
-}
-
-static void __maybe_unused tcu_pm_resume(void *data)
-{
-	struct ingenic_tcu *tcu = ingenic_tcu;
-
-	if (tcu->clk)
-		clk_enable(tcu->clk);
-}
-
-static const struct syscore_ops __maybe_unused tcu_pm_ops = {
-	.suspend = tcu_pm_suspend,
-	.resume = tcu_pm_resume,
-};
-
-static struct syscore __maybe_unused tcu_pm = {
-	.ops = &tcu_pm_ops,
-};
-
 static void __init ingenic_tcu_init(struct device_node *np)
 {
 	int ret = ingenic_tcu_probe(np);
 
 	if (ret)
 		pr_crit("Failed to initialize TCU clocks: %d\n", ret);
-
-	if (IS_ENABLED(CONFIG_PM_SLEEP))
-		register_syscore(&tcu_pm);
 }
 
 CLK_OF_DECLARE_DRIVER(jz4740_cgu, "ingenic,jz4740-tcu", ingenic_tcu_init);
-- 
2.51.0


