Return-Path: <linux-acpi+bounces-7995-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92EF96581B
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2024 09:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1108A1C228FB
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2024 07:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B914F1531C2;
	Fri, 30 Aug 2024 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YR9oJD4F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E0F44C7C;
	Fri, 30 Aug 2024 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725001884; cv=none; b=mlRAQYWs48B1Q3f8CCe2gPjr0fvRymyu/f3FZ8RxF7kgRvXqhx1odLlVXVNzFIkPJfD5aaRAKcvOVzIJvWQXRbmMLm/Qgckvjmni+21HDdLMoNrNI04s05qyjCF9DodbSA2sZA3z91tZztV59APIkgSwbA2tEYfhqE8ZtWZiwoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725001884; c=relaxed/simple;
	bh=Q9zo8i84cdABomh+rkak0lKLEIIWvG4IvVr6aF7PKMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DNlMo0admVpYprXCcFjtGaTP3E7QYULICY5mcMEB5U7HchIrW9wFEQOcDGhCF3Mjj0lLaiyfZKn8xc+jxEIowQgHkGkVd9yRzR/Iis2fAlZ3n/t+j52Bfheeb3kQaUHcjsDBqCIk24W0o+8lKLZMdiGnZvRzXR+60gCceSsOQRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YR9oJD4F; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-201f2b7fe0dso12691275ad.1;
        Fri, 30 Aug 2024 00:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725001882; x=1725606682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jVk8LINkbTRQSWBWSOj1f6VAOaUL2cUfSgT/UyEtcj8=;
        b=YR9oJD4FzIj+33OkZeA1oLTZcN/7/AQbRbqu5NWr2VgzFHKFJzzUXKtETdXtMi6kpa
         e2bxd4Ur4405ogUTrkqdH6HLZgYQCyZ1ei0i82mpaZdtVtkb1dVQ998rOGy/MZ8kEPY0
         vYA+2FMYiehYX8wcRmoaDqJ05/5h4UkGm2qxiKklTz7jHyq0Loa9e0XwQg1i9wx8gmsJ
         0rcrFFboi6OAvVWqpFG2zcxn4FWUNvxxgoPcjoZDznkOwW5Zlaf3ZxXLVT40RcVaozMX
         iGI7QUAxngwSadswpyFtCYPyoZaW85bGFr5eR9whUse63h6xnm/6GMgh84KMpiTCirRr
         8Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725001882; x=1725606682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVk8LINkbTRQSWBWSOj1f6VAOaUL2cUfSgT/UyEtcj8=;
        b=vXUxMUILLhjBwygAvJTCjIcryVpnl4vvXNgsfLT7QQbQlatVEWi8t1zxoGdgoyPhLS
         8n7uNYkQKOw4s07tGNTocFMvWCKCZiHgqM9Oleh5O+U6EgoKEcyYmZpN7sY6Dz7naZ/Q
         I5/Hiinpz4DaEVQPZ/Ltm3hHKhsDQQZlQX1jKlFWsJWZ7jFcVZo2DDBZIShKEbnaQXvy
         q7btNLbSk6ccB+MZklfbQ77UhvkUS/vHt4nPzE+GTEj+sDrnPWRa51BA6xEGURDbLM+X
         k4i4U87RSjmx34wn6mrm91OC2jcXQ/tmqhkYmi21j/iVvaq1pyIUGjFEzRAeVmTk0xXl
         GPAA==
X-Forwarded-Encrypted: i=1; AJvYcCUpFNZ9Tk4mMm/gP8RlXppd4g5ucLRFa2jbEbgijt5rEyMHyS7UUfH9NTHexx4QOz2LWleEx2gHVPxFrsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfqm2UPUmQHuGpD16tZ5pQF114Ubze99olVcudsWotMSsfGyni
	2K4qluYY+zU4bhgFmTOj5IsdgcU8onw3M9RPWU1KKV820fV6ZRlRMB0xX+HIeLE=
X-Google-Smtp-Source: AGHT+IEG86tnZcFSGgrjOxo6oZCRr3aVnnMeXGdSQvX8M1+dO29teMaRbeJ7yb+I7rzB4yHNGS6kzA==
X-Received: by 2002:a17:902:ec8e:b0:202:4b99:fd27 with SMTP id d9443c01a7336-2050c4d38b5mr53444925ad.51.1725001882185;
        Fri, 30 Aug 2024 00:11:22 -0700 (PDT)
Received: from fedora.. ([106.219.166.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2052a485dacsm5243615ad.212.2024.08.30.00.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 00:11:21 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com
Cc: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] ACPI: arm64: Calculate size from pointer instead of struct
Date: Fri, 30 Aug 2024 12:41:10 +0530
Message-ID: <20240830071110.120350-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calculate the size from pointer instead of struct to adhere to
kernel coding style.

Issue reported in checkpatch

This commit has no functional changes.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 1b39e9ae7ac1..6a87ec243c56 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -56,7 +56,7 @@ static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
 {
 	struct iort_fwnode *np;
 
-	np = kzalloc(sizeof(struct iort_fwnode), GFP_ATOMIC);
+	np = kzalloc(sizeof(*np), GFP_ATOMIC);
 
 	if (WARN_ON(!np))
 		return -ENOMEM;
-- 
2.46.0


