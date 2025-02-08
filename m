Return-Path: <linux-acpi+bounces-10943-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB03A2D2A7
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 02:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5283AD6FD
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 01:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436F0286A1;
	Sat,  8 Feb 2025 01:33:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CC910F4;
	Sat,  8 Feb 2025 01:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738978428; cv=none; b=Bee9zsB0Grf1/hfyu29ZTOQ5kxT+Z4Ss54FlxdTaahrLoiZGQ6/kEb+93ujdkCDP+vvZYiz9pDBrxS7lwW5Txw0qDcNraa6krGVFxx1GR+TKriFgOUq/wruEJ0DWjqWSq+SGHbS4vkiiP9Lcuqa+j1GCo308xGQbs9T9OvqAg2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738978428; c=relaxed/simple;
	bh=GxOLxSZueC63DzJgTkeQHmGRYHjvD0nEUQ46oDovHIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lS98tMbuNBwgadMAc8gICspuRpYBjCxGbHVRz434Q6C9eSxU4YgF3ng98bmSgPCoHoLiZSdW6XgOURxSGfCIHjE+NRo8UnZj3Y928KMiFKR7kDmaSbHBKR1Kzg1/4lCgT3ox0+6sMIjFpRiSq5wgrIkY3nKz4lUyN0ujAwIyUNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-21f3e2b4eceso45829965ad.2;
        Fri, 07 Feb 2025 17:33:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738978424; x=1739583224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9aR645TINf+OJeKiUGqWF7NfKIx0eqZK/lJlyTHjXo=;
        b=W+eMK6aIXi2uHN9f4Scs1yrQ8nsCWpMLyLMv/207CMBTlN7d1nrfCPNYMMm58XZ9JY
         E3puuQmGWqRI+MDARKflwkoOBO8h0HdW97avjMBQw7NehgLljRYCb+nobazYR2cIoTuL
         A9vtRHkD0tuGU03XoHeD5PkTVlJlGXTXSyIwmO77RRZtMCg1i8BeMJowpBqOrE24hBWi
         q16CRNcxa3YOZlzLe6NAmNCGwZHD3Tk72qyxrxL+mz0aVLADcorOZl8/D273c4nIwVUE
         L0Ky3uZ10xxvM5OcMt0Z20EQ4XQ1PjkO8sxBHoCHQsUorAvA2bQwQe1U4qeyWxwzBurC
         OmRw==
X-Forwarded-Encrypted: i=1; AJvYcCXhfAMWmKTZoZ180WTFrBrLHMO6kuisVwQ6CniX8/brxF2WXBmq5+0DkHVBGR9HwtnoFxD7DHhdsuwkPVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGGZq0SXopjSqzn8rLRNAOpk37t2oeNOXIyhNagsrRbGZVnPwu
	QBw7PrK9MmWbNritbXZraazkkOSuF43Vw/uhaU9QkR+CooeZiCb8wqL8DblHc34=
X-Gm-Gg: ASbGncvBsT/+3wqi+G0NZBeawoVw/4MWVpRTeMg7v4QehIhYQQld74nxQmr7RGFlHPl
	ZBrcvSvPERNRlkBVezAsp0oDfhRBDBKlJfprF1Zshh7ePz1PaCFByPSyFef9xQ1WxWVlIRAtLvA
	u1IxBUBL81VpmlAHJ1ZeVo8Mrhop607f4Vmsq0n0OUTl0bxQziiLtayY9AJCLNNjuzBAx5sl2Rl
	9AxhtnqCZngfEz5BWkIHULV6Bztr3zTlgcPQnEl5mq8dJTr5BnqoeqwBhTZJ6ApDykHVAoaoSsa
	u8RWU+j9Qv0i3ymevBgTsH4hCPUwzSyRxnlBgiU=
X-Google-Smtp-Source: AGHT+IGx93suXpvROXQSc5BRJzdr7nZZ9Xq4fKtj8KLwBggZWfB5tRefZEanVToU14wEgBQOGTZyAg==
X-Received: by 2002:a17:903:1c4:b0:216:4169:f9d7 with SMTP id d9443c01a7336-21f4e6a00f4mr97730175ad.2.1738978423995;
        Fri, 07 Feb 2025 17:33:43 -0800 (PST)
Received: from kylin-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653ca1csm37084385ad.58.2025.02.07.17.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 17:33:43 -0800 (PST)
From: xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	rui.zhang@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH] ACPI: thermal: Fix incorrect comment about trip points
Date: Sat,  8 Feb 2025 09:33:35 +0800
Message-Id: <20250208013335.126343-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function `acpi_thermal_get_trip_points()` no longer retrieves
the "_CRT" resource.  Instead, it obtains "_ACi" trip points. Update
the comment accordingly to reflect the correct behavior.

Signed-off-by: xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/acpi/thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 95982c098d5b..0c874186f8ae 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -803,7 +803,7 @@ static int acpi_thermal_add(struct acpi_device *device)
 
 	acpi_thermal_aml_dependency_fix(tz);
 
-	/* Get trip points [_CRT, _PSV, etc.] (required). */
+	/* Get trip points [_ACi, _PSV, etc.] (required). */
 	acpi_thermal_get_trip_points(tz);
 
 	crit_temp = acpi_thermal_get_critical_trip(tz);
-- 
2.34.1


