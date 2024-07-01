Return-Path: <linux-acpi+bounces-6708-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD52C91E4E0
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 18:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7371C216C7
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 16:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6969D16D4D9;
	Mon,  1 Jul 2024 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/baOQLy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E5A16D31A;
	Mon,  1 Jul 2024 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850253; cv=none; b=mikL8PtaHUp8Vw+lRDFQfeFLSeZS0mMPj2JmtBtmZr7qq1vSxVMfDWbf4nNnDJQdvs4QURXBKwTHq0pECZBx2uTiCYDbUhFazbBxHguAz69PN0gqHIyrNnYKBZu+1mnLdwAV5EQNuBoypcPlBSIC2dRurnicAi/+oRAieWCUoSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850253; c=relaxed/simple;
	bh=JJBkH7Al13LxC//C0xc0C9jvMQejnq/a8D4NLDpgFR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ykb2Ai0D6mJaGwrUmkXte1Vu1TQ9yzbkNSEy/aJsg/G8W8wLEGi1b55NtSvtpG2xzesey4/L0GWU9O68n2Ie2iU76w4yjj8CnfPk/dC12PySLRUvo3+Y2ymhfSTuLwF89hLhinAhoRulBM3JK/0qsEZi8pUcTqk8dhcZjIrVsxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/baOQLy; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70811f7ab8eso149411b3a.1;
        Mon, 01 Jul 2024 09:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719850251; x=1720455051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoEcYR1g5oH3dAILbBlutSD+nWIJxLrC3IcTtmXSnwE=;
        b=k/baOQLyb0oNwE4nC5Bk22278T0bLkoA5l/ATWyIS6NBTlosfUN+zAOLFDapMqWXyx
         iasjNuRSp0vuJFrffE50E2oULcmZ9Fn6aAwCWEGTlfLmeE3w/PImuBAA6NT8Ygka2I8F
         T7kj5sqaCYKJhxnOUFnCtON+YqdUEYSRyG55kyZdV8Op2tZISFp5jq3+ZEdYV416Cfui
         0A+aAK40gzQgyhpky/Ehr7JZH2lj3qBjijxM+WdJgx78jdTPNvjViTao2ObJrsYtDH9S
         Q7QwwZ4tUA7fL0+SJIoRwmRZ+mt+q2SQTBAXbDbIjTHjcG0ErHuSxjZVOlKuH8iy7fVq
         MXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719850251; x=1720455051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoEcYR1g5oH3dAILbBlutSD+nWIJxLrC3IcTtmXSnwE=;
        b=PYf5Qs/E8ZNdI8uU2fuJlvhK51kqzqt9bZmYS3so/HWde7IrQvTx/1t8i4XIR1o0Y0
         7RXrUg3i3BDiziwI+PDGWe6j2YdWuFJDQwYdIQRha9FnLgiAQo+upE/pXprah2iis6mt
         j61eP4tUUjBC/EHoPDkurJfQZJYqcnoVrdJXYwHp+8xZrJ0k5jkg13J+pckPgVzPb5tt
         gocNJC+hYeSJsrPYjM+WyU+xEvIVEDtrJbvNOziNbLMk9lJBJV5qM1vFGjVp7n8X0Rxh
         vGLecgqXPkc9IK6vi8JvExqy+mcdEwWwyyw7iOpORpD/HjybeEn7n5HwOHQ6SdjyJg0d
         yHtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcGRNHercahEzO933ZXILuY+gs8QQVQGT3m/6oVcQuE1aAoCEq9dPhwm7StA6tB+44B/0m02Gm03cT3ol4763gVqxjgLM6qvyJD+ZdDoOwMqNcDiiqvD2Y0V3SaE+9/0Qd6Fdf174656327I65Bvu0NWbawcor4Y0m7RzdE2RKsA==
X-Gm-Message-State: AOJu0YynbWL3YdwxTjxeWJLKAg7Xgpl6SHDXL0ygZnbnzqqIX464Y0Pd
	ZOa+mGpbDNzEV5iZvz7J/p2Dhmpb48NAhwyCtd3DtY4V8WJ+/Qny
X-Google-Smtp-Source: AGHT+IHv5njWpXlLJKd7jZGo50/1bQI4dmpYuwRc4avqH65vW2H8edCc6GRajls/zL2hTY0cM1nU0w==
X-Received: by 2002:aa7:8016:0:b0:705:c237:4429 with SMTP id d2e1a72fcca58-70aaac182c2mr5965307b3a.0.1719850250915;
        Mon, 01 Jul 2024 09:10:50 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6d100d79sm4452638a12.82.2024.07.01.09.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:10:50 -0700 (PDT)
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
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] ACPI: processor_idle: Fix invalid comparison with insertion sort for latency
Date: Tue,  2 Jul 2024 00:10:39 +0800
Message-Id: <20240701161039.80008-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <46742c5a-5df4-46d1-bf5f-b74067866fec@amd.com>
References: <46742c5a-5df4-46d1-bf5f-b74067866fec@amd.com>
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
Cc: stable@vger.kernel.org
Reported-by: Julian Sikorski <belegdol@gmail.com>
Closes: https://lore.kernel.org/lkml/70674dc7-5586-4183-8953-8095567e73df@gmail.com/
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
v2 -> v3:
- Remove #include <linux/sort.h>
- Cc @stable

Note: I only performed a build test and a simple unit test to ensure
      the latency of valid elements is correctly sorted in the randomly
	  generated data.

 drivers/acpi/processor_idle.c | 36 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index bd6a7857ce05..17cc81340b4b 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -16,7 +16,6 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/sched.h>       /* need_resched() */
-#include <linux/sort.h>
 #include <linux/tick.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu.h>
@@ -386,25 +385,21 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
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
@@ -449,10 +444,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 
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


