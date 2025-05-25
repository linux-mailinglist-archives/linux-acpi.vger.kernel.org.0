Return-Path: <linux-acpi+bounces-13891-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC15AC3626
	for <lists+linux-acpi@lfdr.de>; Sun, 25 May 2025 20:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A55718934C3
	for <lists+linux-acpi@lfdr.de>; Sun, 25 May 2025 18:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DCF1F4C83;
	Sun, 25 May 2025 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6ys5cxh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00F41F2C44;
	Sun, 25 May 2025 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748196305; cv=none; b=OYkGc/qesfNI6jOXQstKAl2sh7tefj9LfAjcLCvlbUWLyFuQGrl/js1OoJSeUZvQfZLpRAQC73DwkOlrKUNTC4DRe2XTPzBi0PFr2ARxsY1phF7bNI3HD2Dg8flEKeqoUS8sIC5qFxtdAfJhPpHnPQehVy3/pOmhLL4fDPrfVCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748196305; c=relaxed/simple;
	bh=UEyT1pHakFVzPNhDsCguw3RO5aCfnyuTBkTCbqhcDig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NuCJnXah4dhz/c//6kaDHyYiDj//yQ81ULT9196PP+Y+Z256q7zz+HkFjVriD8Oznrq7KM54fn4VnnRS1nM66U/7VjpzPfrAXDEn5ny1HOZYD0lE26xaV8yEjAgXYJ3ksFyFxl1awile+qwpm5Wj/qF8dzYR5JIiwUqRb8ai47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6ys5cxh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so9431745e9.2;
        Sun, 25 May 2025 11:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748196302; x=1748801102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVKFYyD1oSY4+ApZBLJcuBPiQP9r3k9ZVrPBJZKw9wU=;
        b=L6ys5cxhhpHmBVW+QtiEcqzHZaVrbLml1RCLKBfOPzRkeQvFROjxumSADpb5KtGayw
         +GnR4QK4G5H8OPzxVWgJjMCZ2u4+cJAbfqvODk4VrsypgGBH7QKAtLaAKY/PtQB6l7Ov
         u1TzZRFxWcOjVk8xc4XRl2kyrqkdF7Ez3dCDKqNvblxlgt8VOgVpcoeSuoQ0iEkk6dHi
         m+20WkuERMFiEDJ+HRQmle+wiTjwnPI53KyczNPM7tylGqi9mDJEbimAJ8SRXxZ9z8u3
         wLvMTEBl0aEkYWtQW7IJ347evYRfNqFRzKUDVfaY8ANUIxipqgLcnBUJWskAv8WZNObS
         gKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748196302; x=1748801102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVKFYyD1oSY4+ApZBLJcuBPiQP9r3k9ZVrPBJZKw9wU=;
        b=uUeKZcYmpdFuK7X6pE8ZB3Y6ZG/jw8yqBAZl1Wj4v5FBiuawSreFYLLKcgrmNz2uhg
         DoqglRdpbiA94QffucIbhXygW38tO6mZHDNIePw7oKXhSuI0HPEHjUezqk1bSrjAW3+V
         yMZOye6PPtcyb4GJXJGc0ZxwLnvVsMZL9ujk9xCYpexcZjVY2yHHqhmXIn5GRMoRtLWz
         Rl/DXvU1XBz9f1yY/bGouOEoogY8G7ynQ0/hGQ9Zt1Kj6kNR0NZkOPOyWAFZePIuzFml
         Eb/AjNzCwQPU19xFR+NvwwTPGBRQGd/2VpWy2MOyC/q1BtMq1mN4yJaeG1y3OklkQOur
         pqeg==
X-Forwarded-Encrypted: i=1; AJvYcCU90RdlFsz2c6np78MmQ6uWtEh02NVAl11tq2KhFII3Rmwf79jhiELL7wyW4IHpWsdR6hl+bi83GNCu@vger.kernel.org, AJvYcCUdLuqAdfkuYbZZZd7dKdxEz5XA8ObMHK1tDaTQZbafCPLcreDVZEHCUUU7Tvyhs0cmw4D1cfc4svJohnZg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/bAUH0XrYXu7+gIRHG6UDX1r/ibW6ZaBcFRuRKYFywNDXbtWS
	PkQtseiA6Jg8W6Crab3/1uJcfmhh122UA7VbLJf8L5BLArXmQmGHoSam
X-Gm-Gg: ASbGncuxdwvSwJkhTfHWCQAl+G90RrwOIVlTrKWERHxNFiJd+DTnEO/ef8PpdCZr7bn
	lrGrx2Dru0RFjcVqlIPb53VD9KhHYAEPTagWRN8UwVP14M5O53q1gwK2Mru3NqgStGY6SDZcJO5
	g8ddIn9OgF4ocNNlyBdo5atLcU4Kh3U9qAk76Xrr82bg3jdajKtaIHQ5ttDsN58UHhmp6VwHZfJ
	1OYb2ty86/xab94uJqSOwvOWBEvYIrMbYlrWsIJc7TLJXdFh7f9g1C2zoa5suZ4RWu31OtUPDgN
	DHF3fjGRee1g8mXgkRsMU9fUUTlIQm6/OkUsOPJ9jGZZ1GeGqbqLReJFrFoGqNawyA==
X-Google-Smtp-Source: AGHT+IEHfg1uAoXP3YxY9kopRipOcC4EFMsn7CMAfN1zBrNw85aiCAUIDgW2f/sDcr3P3NHJYzai8g==
X-Received: by 2002:a05:600c:3f08:b0:43d:fa58:700e with SMTP id 5b1f17b1804b1-44c930191bcmr55647345e9.33.1748196302044;
        Sun, 25 May 2025 11:05:02 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4cb450867sm5876612f8f.57.2025.05.25.11.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 11:05:01 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: rafael@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: lenb@kernel.org,
	hpa@zytor.com,
	x86@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khalid Ali <khaliidcaliy@gmail.com>
Subject: [PATCH] x86/ACPI: invalidate all cache lines on ACPI C-state transitions
Date: Sun, 25 May 2025 18:00:42 +0000
Message-ID: <20250525180052.1004-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Khalid Ali <khaliidcaliy@gmail.com>

According to ACPI spec 2.4 and 2.5, upon C-state
transitions(specifically C2 and C3) it is required and explicitly
mentioned to invalidate and writeback all modified cache line using
WBINVD.

However the current ACPI C-state entry using monitor/mwait instructions
it have been used CLFLUSH by flushing the cache line associated by
monitored address. That what all about this patch addresses,
invalidating all cache lines instead of single cache line.

Let me know if there any reason and decisions behind the current
implementation.

Signed-off-by: Khalid Ali <khaliidcaliy@gmail.com>
---
 arch/x86/kernel/acpi/cstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index d5ac34186555..eb3d435e08ad 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -222,6 +222,9 @@ void __cpuidle acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
 	struct cstate_entry *percpu_entry;
 
 	percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
+	/* flush and invalidate all modified cache line on C3 and C2 state entry*/
+	if (cx->type == ACPI_STATE_C3 || cx->type == ACPI_STATE_C2)
+		wbinvd();
 	mwait_idle_with_hints(percpu_entry->states[cx->index].eax,
 	                      percpu_entry->states[cx->index].ecx);
 }
-- 
2.49.0


