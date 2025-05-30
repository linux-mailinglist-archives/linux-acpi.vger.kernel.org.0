Return-Path: <linux-acpi+bounces-14027-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A027AAC954F
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 19:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10393AC7BF
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 17:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA5D25DD12;
	Fri, 30 May 2025 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSWR9CKy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE9F22DFA3;
	Fri, 30 May 2025 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627696; cv=none; b=BsbHZjcrieO9JPKyqx2Dyy1qbIJh3WEWxDs/Tnpa+t90jUat38zfKRrhhQZltlhuY3m0vb6k6z5Ftis/4kxNtg9bYW/mH7iBZTfscsOgeNleFoKcJrskZoFFXWmUQpK4k3Ca2t4YgngAK5WBLpQ1I8UNmBXw9nD+AJYbOEW2UUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627696; c=relaxed/simple;
	bh=afJSsEoeyNncZPJRpEWWyUsv9XUzBnoSUUqjD9g2U5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cxm6HDJvmmmiFZAt1PPD7gHdJK+xX+HSZUy2A2FFUpFHiB2vbAsoUOqP9Z44e6JtIPPTDoMeWQkXGuoFpN/9cxhOCmNHHKquf9ASwsLM9xK5kuFlu5KS7okxob4nyCgkvId5yOUiS9Vtt9B2Kf7CyXvRmNqb9ad+aXwHyN2UYoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSWR9CKy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-442f5b3c710so19114055e9.1;
        Fri, 30 May 2025 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748627693; x=1749232493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kjxoToXJDlv+POyGIuKi3i3ilCXa6eLtO0vMoZzC63E=;
        b=aSWR9CKymxQcwHwCGqXPCSDi2o3bdDb37jdiRNI/NP/Da+JHoHEBUmF8tBpsuLx4AK
         tUCAP7xwXO88ox3tIvJ0AxMttfYWpBYMZmONI88LN8OQg1DJcvsU+L3nmUJHqytsjzDl
         UcXQjj9s6ED32olzRnunF5mNrScHSNUGzJT7vuoj4WGGq+ThpIAkMHa24aopkmuCoZo/
         Sx7JREeM+n6xqM2wY2dd9L8X2lhySNaXug5yc3ggLIUcGUPg1nrr+FqiOIlxhEqlUw83
         YgKFjlgoj3i5KHfyXW544NX2wHZl7ovksEnn5wypJCCQ9nnX7zvTSlth6GvKwwPWgkVZ
         09TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748627693; x=1749232493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjxoToXJDlv+POyGIuKi3i3ilCXa6eLtO0vMoZzC63E=;
        b=TjMA+W8OJCAzo0mBYiHCWwE9WgJLIL1pdp7wCVO2HySMRVfQ+t56OJ+8XOAJb9kHoP
         RxH7pKOHcaheXfaGPtQINhmiY7IHtsMa507whH7pqf8aEpQFR16KigzzxUoOajQSbixl
         hWkfNtNy8pcV9uzaqrZSlKlQvFyP+CCzYx9s/ElSxThEM7LnAZ5yjnIot8IRDL9kBWQQ
         gr3vph94otMfoDKGQp2TJ1COO0+scO64YKDfExu4qyO3l1BLAOfauPeBeLcey++b0loR
         aO8SDfJIyjlvYNmHG/773C11UPFAHy0l0NET11OFacmPDTSrzpziovo7jY80IB97NMee
         RMvw==
X-Forwarded-Encrypted: i=1; AJvYcCX3bagt4FdlN9bnqTnPHY87HJb7OAXAEUtm+JbdQZ6PmiduSDT7fGzZVx0DnfsT7R8F6eHnMzziZCRh@vger.kernel.org, AJvYcCXcbGvBqV5Q1pe2N59weXvYUxFffAEHfe7c6mDw1cX/cLJbgbABr7Y13plXuD9QR23vqm21ErxlCHTGyU5v@vger.kernel.org
X-Gm-Message-State: AOJu0YxxIBgNoYkG/wQfS23Y4cXWoMyDN7XeySRKuWKyv31glJupD2Xc
	V8Af1tMmzLhNgKE/FzEGkjgmbPaBU+Y2FAj8gJBHop17gp1A1MPjVyWT
X-Gm-Gg: ASbGnctTpH/bWlB2Ffcdb7hiTmQVd57xepHY4aYR0sV1c/rPDqzg+Qp1mEqDZ/5AmNi
	lVNF4hc3Grhg0toGyP3f0E8Uv2U9v0Yx77fMpYIlekNOKhC/AYblGtQ+n1eAIYVLW1+D7hvsr++
	dmh1Oe/54djVSSXcQPN1c6KMPGrhNdCNuBCrLosjbTz6yFMYbon5Wdnek9SPmazJ4ZH7Bj+v9Gx
	CIGhE0AnA3cnGYbxgRlJQ6lX+tGVhr84uh5l4XHAHhVkD9qMZv/ECg161IGPgNKW0Mgtxnnb1nb
	PbSilHzHBdJGxd+7tTkS/68n7dePdYVAgh14gaxcM5UFmli7ICaPljWBoECoor51dA==
X-Google-Smtp-Source: AGHT+IEhr2N3LMQLfOqjfiyCqjiseC8V2a5mOVzLYV2OcizhkIMwXqUo0/ClUu8jbLkLM6aFx7i4Hw==
X-Received: by 2002:a05:600c:1e1b:b0:441:b19c:96fe with SMTP id 5b1f17b1804b1-450d6537a6cmr46734105e9.10.1748627693013;
        Fri, 30 May 2025 10:54:53 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8f1adsm24506375e9.7.2025.05.30.10.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 10:54:52 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: rafael@kernel.org,
	enb@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khalid Ali <khaliidcaliy@gmail.com>
Subject: [RESEND PATCH] x86/ACPI: invalidate all cache lines on ACPI C-state transitions
Date: Fri, 30 May 2025 17:54:19 +0000
Message-ID: <20250530175420.1277-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Khalid Ali <khaliidcaliy@gmail.com>

According to ACPI spec 6.4 and 6.5, upon C-state
transitions (specifically C2 and C3) it is required and explicitly
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


