Return-Path: <linux-acpi+bounces-6692-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A0191D728
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 06:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CEE286C87
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 04:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EBD28385;
	Mon,  1 Jul 2024 04:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QieRuDgl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770E517C61;
	Mon,  1 Jul 2024 04:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719808961; cv=none; b=eiuIU5WkAEJ5liCJMx0gf3GF8fPbUxIruwzjYOM3z9igdqb0MUv7/9ElrwbzJJUEN5XxjObFWLzyLkC0o8DIhsdYc0xEDzxnO4z1nlXC7DJjsToPWI/J/wZTaXc/ZHmaaS5T5MjPSicCwP2Hp3kwSrhSWzvE0g2mbJ7HKL0cXMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719808961; c=relaxed/simple;
	bh=8t/KdAzxqkS/7p07GxkZ0bFQhYV3CS1hbsMUGQ4NktI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jzfRPbykx6Gro34amjXTfhzgY1gO/ge/pqqhn98Pt47/a4UPHabXY6Uq2HWODctOuxbKQvT4PUKOi/ff/R8klPCTDSQ7lS/ALZtm6+cDGj1f4Pvg2DwTUMvSBBHDxOC5dgqzXfjLlRE6awhfW3KIhOULdkPLTYThWG0hef4uR+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QieRuDgl; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-719843c8478so76144a12.0;
        Sun, 30 Jun 2024 21:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719808960; x=1720413760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8YffMYnGN0uxObMvEtbv5MkYWHWmd5kg/aBxvT37pI=;
        b=QieRuDglrhRRqQQeGsTK57L6ZTGHmnQT3JE4VRXEONa1j73l1gVSVszsgk+w1somcX
         78DimDLPrlLDqAzin/P8RTInSHK7LR3cUwL6AguELCMAhc99o3glus6FVBMg9pn+S/NS
         Dx3N/Vvax7ovulGZNdBZob5AwkRxDsseCErJT2XulAjjVTkgtwIv3GoUNaXWUFKTow59
         hty7dxzT+zQW4twu3Sig8XjTkYY4BsG80IfGfnPdrSN+gnxZqVtBupSrmFWnvhBt6r7j
         uDAOSuS7C53vv1oJKgt+GPO8IpFqfC8dWKF/5PrzWseBMvTMUEMwkCTQiyO9e1g89MY+
         Uhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719808960; x=1720413760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8YffMYnGN0uxObMvEtbv5MkYWHWmd5kg/aBxvT37pI=;
        b=D4Ui1ltaAB/2rl+jgBSaLsXdmEp/nKrdQwh2aGwVQDDiVks6u0b3HbBVXx12W7faOi
         qwJvA2nLHKJDu/KDxx+6fOfPdCKSc3ggfzWxKL/5bLGj9kBQKMXpL4mxlfAGb91HExHQ
         /8tQouK30JEElAzXzd1ED8KmEyF3ctO8+qcxow6PSTkKUpHUg3irXS2jDrWlAyhX8B/p
         N+d7Oea573vE498BWN89Nwi2OjG+FI+3e4ZHv6bF0Ae1l8KEFIYWXViAoOtRgQ+T2DE+
         nGPOrWlb12rs6iLZysB3ZMTN/ZsBvIjdZvL9q8wOCtzRZJE7Cx/+uRKvYzcklVgFAPPO
         QjNw==
X-Forwarded-Encrypted: i=1; AJvYcCVe/7DvUjrL9j0cJmivhB1NunfG1IfGF4qKWbeO9zbo6w2vFxnGCldMGSLtPl4zDI8oGMrfKnDiSNNBqNK6uAOxWs9AzTZWrDNg06UAGNs23IxJNR83yl5KBuvsnU9w+jnoMkXuGk3Tjw==
X-Gm-Message-State: AOJu0YzgJ9D7ycL0kyHFvH93rlRUQWHgAmHROlLGwf9k2hs8Y8SFXoJY
	+LXtqHRyaXGGgFh2NnTV3uKuQvlNFJ3oygNjsfW68iuFWaS+0uL9Ruus0g==
X-Google-Smtp-Source: AGHT+IHcbdyNFOmrDfxkQwPMDupIwNySdkVbFUyk2wdUvXKuxcCIR8tGWdbWR7laH0m2coQeAkGLbQ==
X-Received: by 2002:a05:6a00:bcc:b0:706:61bb:7094 with SMTP id d2e1a72fcca58-70aaaed0574mr5211840b3a.2.1719808959476;
        Sun, 30 Jun 2024 21:42:39 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802564b50sm5485130b3a.67.2024.06.30.21.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 21:42:39 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	mario.limonciello@amd.com,
	akpm@linux-foundation.org,
	jserv@ccns.ncku.edu.tw,
	alexdeucher@gmail.com,
	belegdol@gmail.com,
	regressions@leemhuis.info,
	linux-acpi@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2] ACPI: processor_idle: Fix invalid comparison with insertion sort for latency
Date: Mon,  1 Jul 2024 12:42:32 +0800
Message-Id: <20240701044232.42266-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZoHKhr9896+Kf65F@visitorckw-System-Product-Name>
References: <ZoHKhr9896+Kf65F@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The acpi_cst_latency_cmp comparison function currently used for sorting
C-state latencies does not satisfy transitivity, causing incorrect
sorting results. Specifically, if there are two valid acpi_processor_cx
elements A and B and one invalid element C, it may occur that A < B,
A = C, and B = C. Sorting algorithms assume that if A < B and A = C,
then C < B, leading to incorrect ordering.

Given the small size of the array (<=8), we replace the library sort
function with a simple insertion sort that properly ignores invalid
elements and sorts valid ones based on latency. This change ensures
correct ordering of the C-state latencies.

Fixes: 65ea8f2c6e23 ("ACPI: processor idle: Fix up C-state latency if not ordered")
Reported-by: Julian Sikorski <belegdol@gmail.com>
Closes: https://lore.kernel.org/lkml/70674dc7-5586-4183-8953-8095567e73df@gmail.com/
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
v1 -> v2:
- Avoid swapping if arr[i] is an invalid element.

I do not have the appropriate AMD hardware to reproduce this issue and
test the patch. However, if the aforementioned reason is indeed the
source of the problem, I believe this patch might help.

 drivers/acpi/processor_idle.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index bd6a7857ce05..813c718b9108 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -386,25 +386,21 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 	acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
 }
 
-static int acpi_cst_latency_cmp(const void *a, const void *b)
+static void acpi_cst_latency_sort(struct acpi_processor_cx *arr, size_t length)
 {
-	const struct acpi_processor_cx *x = a, *y = b;
+	int i, j, k;
 
-	if (!(x->valid && y->valid))
-		return 0;
-	if (x->latency > y->latency)
-		return 1;
-	if (x->latency < y->latency)
-		return -1;
-	return 0;
-}
-static void acpi_cst_latency_swap(void *a, void *b, int n)
-{
-	struct acpi_processor_cx *x = a, *y = b;
-
-	if (!(x->valid && y->valid))
-		return;
-	swap(x->latency, y->latency);
+	for (i = 1; i < length; i++) {
+		if (!arr[i].valid)
+			continue;
+		for (j = i - 1, k = i; j >= 0; j--) {
+			if (!arr[j].valid)
+				continue;
+			if (arr[j].latency > arr[k].latency)
+				swap(arr[j].latency, arr[k].latency);
+			k = j;
+		}
+	}
 }
 
 static int acpi_processor_power_verify(struct acpi_processor *pr)
@@ -449,10 +445,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 
 	if (buggy_latency) {
 		pr_notice("FW issue: working around C-state latencies out of order\n");
-		sort(&pr->power.states[1], max_cstate,
-		     sizeof(struct acpi_processor_cx),
-		     acpi_cst_latency_cmp,
-		     acpi_cst_latency_swap);
+		acpi_cst_latency_sort(&pr->power.states[1], max_cstate);
 	}
 
 	lapic_timer_propagate_broadcast(pr);
-- 
2.34.1


