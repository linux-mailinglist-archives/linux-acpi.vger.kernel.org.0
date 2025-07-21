Return-Path: <linux-acpi+bounces-15256-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBE1B0C581
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jul 2025 15:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C4E3B10BA
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jul 2025 13:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3C02DA752;
	Mon, 21 Jul 2025 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgpG5A/W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532A1420DD;
	Mon, 21 Jul 2025 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105852; cv=none; b=C/TEtk1Tpn6bGzojMguHqMfznaQMbYXBA0XbGHXWDSzjoaeZF43ehCrVvrQ5Ndlidhco/ZPgkpUGFQPpUvs3GYRkKsY9igFnl5ry28n0P1rg78W6DFaEG9XlnfGp8xT4SahnAV5mo9qW8A7CeCznyeBJBieTDajfiZkpVuv9Mgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105852; c=relaxed/simple;
	bh=513tMf7iicIdDU1soghAQ1q8hTKcIhjVMG50axlhca0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZZDJSeQZszvmQq9CrSi/eqyR/jr+FvRcUQObIYm9YFcS6fNNBQ1yVm5XBQXjQPkLn4zzf1ha7McMz03L3fB1oJgfjie6wLnCfejlqoExTCh7d2E9rCSU1Tv4AU3iHzpcaxayfagEjUuZrb1Rb8iSP996uaXOnXOjcu9DbCEFjIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgpG5A/W; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-454f428038eso36999125e9.2;
        Mon, 21 Jul 2025 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753105849; x=1753710649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EMe6pRC005fOwaPOugF9qce8y2RRWdU1gEZZYXHHtOo=;
        b=VgpG5A/WJDcIi5rShXyQaW0BAXwpJ6AwFkWJX27FS0V5cljEOEHCTYYy+leXIxmI8S
         q2Tg7MZ/6kUy5NLaXxH7D8evTsIhuRZLjxvFWRW16WCCPgppXQoXSXIgiEpiOiPW4izC
         VgkQP1FKzS034VRIIi2MOfBaFa4CA2uiTZ6IKJx8AmEFOTtZb/htd7hfJuRVdI0KG1EE
         5pSWM+rim/4CZXaMSEHRslV3KRUWbqLLgxkAHnyee4UeqLzK4tS/xR/rWdOyWWi5IqXA
         1Jd5ymXwFBdP36DuYR3KA4iSJYUKS5EWBZqYI8fO+leQ/083nO4giCEqupEpj3g8JuX5
         K9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753105849; x=1753710649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMe6pRC005fOwaPOugF9qce8y2RRWdU1gEZZYXHHtOo=;
        b=E+NlzNPnbcnw/LqYijbEPJHjcXhsK6ruot5TfFaioZtsZqSqee7RkjzoCc2x6ywTbC
         KcradQ11oaiPKmZOExct3inuHnbMH/dU35WFt0PWJfNtxBtzvVqGPBG5LQHHiGP/fvag
         wQuboXqFo8it266rlycPHOsP8/JzCx+rRJwW60fpYnULK2B8I3c+ZWuzToYKCV8SqWKt
         74ZxyBuYoSBh+fpBsgZx7TRBjQr8oZElWhEb0e8Onep/IIXpg9JmZFbHG5pyE6Pc01Ya
         Mv7caZu92xwsHVMxT07c1tK1VWZeRVoK1cgMaZOTSAx0T0gVdTPDjg01HlfPZjUkMbmO
         afMg==
X-Forwarded-Encrypted: i=1; AJvYcCUyJsoKRUhCDlMaaMA0yS7p5PT674rl7aeihraTMRHkoEaGa9kmdUsTojXV/lzUiEazNEex9awNNddE++gR@vger.kernel.org, AJvYcCXw3xi/caENIelZhXtB2SnZ+D48lNZZ8/Ma+dm6NqmDmKkpsnQvonILLz6Mr5FioaWAIrYWk9cth6zF@vger.kernel.org
X-Gm-Message-State: AOJu0YxvFC6khcCBk0DjH/LZdfbb/hup5PpqkONdQhgtkMeQT0y4MMKb
	iloS5uL0hQVHqyMWyn56Iyn8x9dFHM5BQCqKg9LITT0WQRwqWjNdz34Z
X-Gm-Gg: ASbGncuUk0pjbQ13mZkc6I/haCxG9d+y48MnJ2F65otCS+ZdLnxZLlG74eN3r0o7vci
	eygrSoIA7s/jrBNJTghWVicxVYEaKZxuipTMNOs/ADfkTs4tNjgvdICUBzOFm0uQupGsTVADjVr
	X659ZdgEGA6HfPZjUyAUUk4D6ory95wFl2m30xRNPxSpLumhO8yQZfEZI1Z/u9I53vvgKfy68mH
	Ql5kps2wSEaILR4Vovk4enD7WvPbN8JuKD4yKGtrblbP77rAj58urhEhLU6GyBIqUyUrONabywd
	NfNAWtJ6EVH+LhDLaFW1HFoXeOeGSmRfsWqtTFU4QVxtioFgE6Mya7OmPp4nS3XkX551B1W50MX
	vHj3SckzQP2Mu95Tuyrhk
X-Google-Smtp-Source: AGHT+IEWxz2ukH8WNYyFaAsNQWUH6XpTNFQRIupr3Lnn0/uerqUny1xGkgFJRyZGq+ChjwK9aMkYNQ==
X-Received: by 2002:a05:600c:5486:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-4562e39b9a1mr210179265e9.16.1753105848730;
        Mon, 21 Jul 2025 06:50:48 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4562e80731bsm159818925e9.15.2025.07.21.06.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:50:48 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ACPI: processor_throttling: Remove space before \n newline
Date: Mon, 21 Jul 2025 14:50:16 +0100
Message-ID: <20250721135016.2500117-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a extraneous space before a newline in a pr_warn message.
Remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/acpi/processor_throttling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index d1541a386fbc..f9c2bc1d4a3a 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -235,7 +235,7 @@ static int acpi_processor_throttling_notifier(unsigned long event, void *data)
 		if (pr->throttling_platform_limit > target_state)
 			target_state = pr->throttling_platform_limit;
 		if (target_state >= p_throttling->state_count) {
-			pr_warn("Exceed the limit of T-state \n");
+			pr_warn("Exceed the limit of T-state\n");
 			target_state = p_throttling->state_count - 1;
 		}
 		p_tstate->target_state = target_state;
-- 
2.50.0


