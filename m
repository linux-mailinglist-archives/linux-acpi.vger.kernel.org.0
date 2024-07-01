Return-Path: <linux-acpi+bounces-6721-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A47391E9E8
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 22:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75A21F21D16
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 20:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F70917108D;
	Mon,  1 Jul 2024 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tr7LeHmk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFF9152179;
	Mon,  1 Jul 2024 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719867409; cv=none; b=n6wbxJf9cGqHhAHwsXm6jFjv1EO6IZuO7JqiXXuGMEZrAtdoYZPeHzIftZHS+5IRu8ttXqe6F9PDn4eCG85ohj77DltB0pmjurbEdvBlsNSQLrgPHjHnObtYHsZi6I4liKYa6JJZNfMThNFzuUgu64BQRWWkfpWuTeFMaoL8z9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719867409; c=relaxed/simple;
	bh=yivC1wh3WXB0Mkllna8y0JKmSTpJlJbqbl1AdYH3amQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F0iWLOH4OpKfnvdrTyou03+9eFLXDIl9AbaR2w+2juDq+y7NpHMlKKqCoxF/9DkJXrVZaPegwU4oZKfspuxvHK07Ogfvp2/3djneHrl2G0YmpdsDEbm94OPwMpWccEqM0h07O8lkkHrWvBKzDROI5moqa3K1H2fakDjfYyWfv18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tr7LeHmk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f99e2dc8cdso2216875ad.0;
        Mon, 01 Jul 2024 13:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719867407; x=1720472207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOUox0A8P7WdAUwxhtPV8qdrltE7pejNVtILSbSQpN4=;
        b=Tr7LeHmkZ82U7MMBhSOKoNBbF4p/ILq32h2Otp0pQXrbIRUvQZjiNRbTFP+ZR7ZYG8
         nbal/ZKIiUkNTd3MeParMNjkKCh2iL0NamHB7YSxghIjaGieqHun8DPYhi8gC7XWOhHB
         3Z/6a9aOCg5BRMA0ejHTX5QEoGNRtaTlzv6X0fD3waxmDQE2R31wAaEImInc5mwXSRUD
         2zG/dPswYJxGWWcbTGqeufxJvvtKnhPV4YfGw4uAU9oT5DL1iY/R1b16FtqCPyQn+8xK
         eVcGHO1B8KJcfiPj3JvcobU7dzcp7M8zjsKLv2SfB6BjzJjxkHfkP1Kn2M8pTQI6gfVk
         6BZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719867407; x=1720472207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOUox0A8P7WdAUwxhtPV8qdrltE7pejNVtILSbSQpN4=;
        b=ebKuRXik2GXU3WTEn4UKY1TTDfei7KVayxxxXEaunDlup1ZOxDNg6w2ZRdx3Jwj4Mg
         xV9tZ5eLZ/sBzGbIueR0+5iwuIkcIQUY53Qqs8vbp5ga0ubIEAUSQC3sWshzX3CpdwIS
         cwpVHcsPTnsfCD7R0mpNO7YbGzJskOOxuw39p3PysbXlfE4ex3dxj8JAPZXrpOeTFx0Y
         dNmzgvnVK4ncR6nZSYKmEYHgAJf+np3EHhkpkAzy26hIPn6aI4f66O617yl6cz2mlg8o
         sI918DzEjbK58sqyae5HCYdIOsFZi1IBmcm8c/fqjxEUYzRrGROWy0288T86Wdy2/YjY
         /hSA==
X-Forwarded-Encrypted: i=1; AJvYcCWISLuNI9QZXVV5THTJIRy7CqJUZzKHz7t6fjGzerUEER8+0VwxeFGfSm8PwRXohw7GodPAs7sjPjo3t8sYgXg/i+MOAUOUCpXa7tImW20kyAywTykh9z74n6b7ejg7iBJs3nzEl+9/XIJDoBw7OQT2SKwL8G6YJQbmAROXCd8fVg==
X-Gm-Message-State: AOJu0YyBbEidqzZRoISkDjEwzQU87/HfYHZj1MJ5C+bXIPHFd8zvFHFG
	t3E5l3toG/mZ+4fQck3Igm+V9dtsviIjWsrenWscS166vW0Krzqx
X-Google-Smtp-Source: AGHT+IFrTruC3H2GBbF3mUj3lqAiD5H9fk9Ju69ci44bdKZ4SKOiR//a/zscmxKXvRePm7RkETeIMg==
X-Received: by 2002:a05:6a20:7286:b0:1be:d897:797a with SMTP id adf61e73a8af0-1bef626edbdmr9916444637.5.1719867406736;
        Mon, 01 Jul 2024 13:56:46 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15393d1sm69402285ad.157.2024.07.01.13.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:56:46 -0700 (PDT)
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
Subject: [PATCH v4] ACPI: processor_idle: Fix invalid comparison with insertion sort for latency
Date: Tue,  2 Jul 2024 04:56:39 +0800
Message-Id: <20240701205639.117194-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJZ5v0iY=S+WKWvDAAWxLcOwvpOG5Cck1gQv4p+FfW1Nca0Yqw@mail.gmail.com>
References: <CAJZ5v0iY=S+WKWvDAAWxLcOwvpOG5Cck1gQv4p+FfW1Nca0Yqw@mail.gmail.com>
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
v3 -> v4:
- Rename the parameter 'arr' to 'states'.
- Add empty lines to enhance readability.

Note: I only performed a build test and a simple unit test to ensure
      the latency of valid elements is correctly sorted in the randomly
      generated data.

 drivers/acpi/processor_idle.c | 37 +++++++++++++++--------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index bd6a7857ce05..831fa4a12159 100644
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
@@ -386,25 +385,24 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
 	acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
 }
 
-static int acpi_cst_latency_cmp(const void *a, const void *b)
+static void acpi_cst_latency_sort(struct acpi_processor_cx *states, size_t length)
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
+	for (i = 1; i < length; i++) {
+		if (!states[i].valid)
+			continue;
 
-	if (!(x->valid && y->valid))
-		return;
-	swap(x->latency, y->latency);
+		for (j = i - 1, k = i; j >= 0; j--) {
+			if (!states[j].valid)
+				continue;
+
+			if (states[j].latency > states[k].latency)
+				swap(states[j].latency, states[k].latency);
+
+			k = j;
+		}
+	}
 }
 
 static int acpi_processor_power_verify(struct acpi_processor *pr)
@@ -449,10 +447,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
 
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


