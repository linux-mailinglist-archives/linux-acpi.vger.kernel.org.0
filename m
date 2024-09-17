Return-Path: <linux-acpi+bounces-8324-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F20397B63F
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Sep 2024 01:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD2DB24391
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Sep 2024 23:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA26174EFA;
	Tue, 17 Sep 2024 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbPQyOsZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0B8A29;
	Tue, 17 Sep 2024 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726616334; cv=none; b=S7BfwzNUT/ZcGB6Ctl6ui1qANsr1MmLKntNdeFuXB3j4J3HaFcM/DrbqbQZfOWJhpBVs5+NePKmtsqyNKKVEv3UxYlyHXm6UhF5OCqZ39THXPPNa4YyUspQGNFnMwVDIs+HLoDVS9oKdOHwFtL/5oWh/iK6V8mJmA+WkC3Jk/a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726616334; c=relaxed/simple;
	bh=9dLqI6VMyyIafJzqhANNhGowYfulg3mQ892EOdSpBNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q5ZygB/yKmLm3wJoPQjl5zZMMXpoJEfybbwRv1rtRuSTqZDFf2A4PLBRC521Gw/FatUNnNbVOhfhb9Z9LQzk33AEJNi27UTK6G8E9dbjy0AK5HnwoP8t4uRMIJKbf2/hPtCQLVhKv//csTxVVp0ojeZwk/MBvWq2xFJL0Z0OdY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbPQyOsZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-206b9455460so2161595ad.0;
        Tue, 17 Sep 2024 16:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726616333; x=1727221133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KcWP11N1mECLdbFjOwZ7f9h1sIQvx2jN9KcgmIHEfqs=;
        b=lbPQyOsZIqvIm+tYnxSz6wiG6tX218ckBMV5uPWWlhPY7/PxE2FB3sRTfgMoIeBJwz
         fpq8U1vF/550FjSuyvTL08bAU8imd6xUWQLjhVrYrhIo3k5rnnf3QkFD3fQBDydRaWnm
         ea//FHbsrKpNZPcie1oU9uLnS/5tJjjqZap40zsigB2tStV3jq8TUMEfYM5WgMY+/VSq
         PznM+kIuYWOFo8XUfeTNMvQrNBrVEX3AsvC/4bGZs66A2YL8jUz5s7W4rRKON0h3hWYM
         0zU7u67q/wRq/NFJln1eEn2jkr1cwtIjnalmw9YxAq1F/BOORt95J07uitbwWU+nB8zf
         oaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726616333; x=1727221133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcWP11N1mECLdbFjOwZ7f9h1sIQvx2jN9KcgmIHEfqs=;
        b=py56KdaWVlUkB+7SAmHDLarDedRAjohnzG93j45u0JyrrNsLEtO/1e2l3YXgny0zsK
         KwEDAAOG+BxqhGWwai+reUzvMK0emwvnw8rCKaFVi0Rc87owevVT1u19iPCN/vKvv/Af
         5DlOj6QdgbglVuWYNBObdcS/fKqkt12N8y10ThEC8u1zD2+W+P9CF14oFpdDp82R7t5d
         W5Nt4o/a++3p33TEJVQMV5gjoRJzZggj2+0OP4jk0AkXsNioz2iz6G9wy/XWlPAPKcRE
         s0FrzG6FNwrXnMS5bYLRuS3sh0Z3I/bwEk6tVtaquWUZxwPMVKOtIWTZo3feVqJHmPB0
         Uh4A==
X-Forwarded-Encrypted: i=1; AJvYcCWBNLWycDBHkVUUyiIczPNDGKjJZtxXQ7pgJ47PKVfbBRgtwXK5Wa03T7m/C8qg52SX9AmbUjios6jWzt3l@vger.kernel.org, AJvYcCXzn0hHr/Pc+S63+II4E57GC/7gOyyn5K2+LlNXAIRL3yM+GjzGP02nC3lmOuxCVCoMGKIeJ2H6Q8/2@vger.kernel.org
X-Gm-Message-State: AOJu0YzeTl+vM36JxyT2lV50mbUVi5yybF6rPjdx2DWsrYXehIHoNSVG
	lq/bVAeAz4xTkYX6dCyvve9cBMqXovrfLa22JK3bgeKlm1bdZ4t/
X-Google-Smtp-Source: AGHT+IHm9WpKunvYUYVdRVcqdRL0Bvu5XN7F6kHqwZuyCwxSybIQSyzr4LjktjFz8vvpFTrPR48dmQ==
X-Received: by 2002:a17:902:e88b:b0:205:8763:6c2d with SMTP id d9443c01a7336-2076e56e3c5mr288594445ad.9.1726616332643;
        Tue, 17 Sep 2024 16:38:52 -0700 (PDT)
Received: from localhost.localdomain (111-240-85-119.dynamic-ip.hinet.net. [111.240.85.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794740131sm54880525ad.290.2024.09.17.16.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 16:38:52 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Min-Hua Chen <minhuadotchen@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] acpi/arm64: remove unnecessary cast
Date: Wed, 18 Sep 2024 07:38:24 +0800
Message-ID: <20240917233827.73167-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DEFINE_RES_IRQ returns struct resource type, so it is
unnecessary to cast it to struct resource.

Remove the unnecessary cast to fix the following sparse warnings:

drivers/acpi/arm64/gtdt.c:355:19: sparse: warning: cast to non-scalar
drivers/acpi/arm64/gtdt.c:355:19: sparse: warning: cast from non-scalar

No functional changes intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 drivers/acpi/arm64/gtdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index c0e77c1c8e09..24bd479de91f 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -352,7 +352,7 @@ static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
 	}
 
 	irq = map_gt_gsi(wd->timer_interrupt, wd->timer_flags);
-	res[2] = (struct resource)DEFINE_RES_IRQ(irq);
+	res[2] = DEFINE_RES_IRQ(irq);
 	if (irq <= 0) {
 		pr_warn("failed to map the Watchdog interrupt.\n");
 		nr_res--;
-- 
2.43.0


