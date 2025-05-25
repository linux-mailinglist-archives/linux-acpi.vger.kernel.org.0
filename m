Return-Path: <linux-acpi+bounces-13892-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19326AC362B
	for <lists+linux-acpi@lfdr.de>; Sun, 25 May 2025 20:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8633E189402B
	for <lists+linux-acpi@lfdr.de>; Sun, 25 May 2025 18:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B0D1F5852;
	Sun, 25 May 2025 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSpxIH/w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2201DFF0;
	Sun, 25 May 2025 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748196659; cv=none; b=Y3MaCJCyGIIq2GSdcjSNN2MYHB0M+acxOL68GKkpZ9b8pNU2RGYEm5m0US3xgb+u51XFeJ+0fiuKfMxrITzyp1w3B3n5aSJhF1kRO8gdGnJluOSR/d+giwBIpk37tV7s64r73Jz9t18vgCzbnccCNzqjxzaQAz0STX+xIw3y584=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748196659; c=relaxed/simple;
	bh=stVEtjIHd3wZqymECvx7ImDWL3r+ODxWwlTBtG7lOmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UJoikeftOLG+EjVB3ExJ4AIbFvujAitYyWx03dtsaed0f0GKT+15AFzj+0DWVBDW5+LsOA4qYXIlhZuhZO9EGNKSeH4ZhpqtL86B+BGG2yy9D7QHta6hXAM1dd5YYGcVq6uE42lggdazK19p2ux3JosudEgioeDs+OV0S1YDDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSpxIH/w; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-44a57d08bbfso11712415e9.2;
        Sun, 25 May 2025 11:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748196656; x=1748801456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/9pzAUSWKDrDz9iRzV9VSUrybeThukixXcP4OIiKgOQ=;
        b=NSpxIH/w1sj75hn1HVrIKYQlyg7U/9sIIKIlHS5bZTe/i5hcwcvgN3yPevQpT8HEZY
         cR1kbRhrPOWJuw7wTHOKUJR6YkzePGI9cn5OCDYTVo2S4y24Muv18kOScmw7G0gRjHbv
         Z5G5JE1/xrkdgGIBpfz9tPYiZL8qpDt/wBcw8peyOAWUjfIVYRdUtgJkNC15kuZG8efx
         WNcH50Ab4R3+GLtTC9VaGbLH9So6jqZqMiA5lYsJtH8CXZ7tYFiumdaorDe9Dt9g2GDp
         U09vKzcXmoEtwYSrq2+h3JlH6FcOUxnIK/U1HSRg7/F74ZlJAnZG5bx1cOqXMmppYt6S
         qAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748196656; x=1748801456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9pzAUSWKDrDz9iRzV9VSUrybeThukixXcP4OIiKgOQ=;
        b=C5yMv6J1wv4+dEu6S2TW8sz1Wq4VnMZnZLDghCYBVmkFVR7YjZ63/NCVeib5A/Hfdy
         Gv6On1ltQbmORNE3EMp80AtZ58lwk02R0wqxab2ocHqHn6neGic62ZkTVqQ0MnT8tokL
         A5fJNv/aLbQ1zItldYerBa1+5ni8FMQm0geoSjFPQsMEjdMbS9cxU2lOvE47gcjm9It5
         gPwtZLyfFJmbjZ46NVY69t+ZeHRyIprEbGnhIDqRrtc+geKeYk/GGhBvtv4c9Z7F4fxB
         e9WZSkR0pU0UKuLNBDvP4UZ3rGamTec0pQyIb1T+SJfgZkqjVoZBcZuANfDMB2l1pGZB
         Rssw==
X-Forwarded-Encrypted: i=1; AJvYcCVj6QcHDeVTyeA+JIskzMSFrlvSJlcxLXzS7m6vV8+RLYX8CzbVrE0auZq5YLU+XetmXih/O8sdpLbJfSIG@vger.kernel.org, AJvYcCXY0jlNF29hf0Al26s/goyZnRjS3NYri3DT19ia/N5RgJZG7c6sImJl0PkfpCXXMJf/1KtwR3cqWve7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7TqOI54mQ01DUUFXfjoZ4DAAeK4ZEYPJxrrgCNg7inX6jb3lb
	TyEvnF9hrLI76qWoRlQG1sVt8ovlBBzLFY13oBUuBCPXDVWuLcOn1FeH
X-Gm-Gg: ASbGncviFa2met6dUE5AOjJJGHd5jequxPPqw0jzRG4IBeMh85Lpe80keADgGWFkPd6
	04cAumqaCXZlWiT0jqCNpJ6X0W1bGiBYXSGeAG6FNchfRVsC2JrMb7GxFHDanzH6/yC20EYqbdA
	88zGWmf+iyUZql1Gy6XovERQcpqpslbA8jptRnG8fCusYaGzI0eQyXJKWSs4LBK7kOh97ZJG5/r
	5a4KvUfiVbhHuWeeZoiBWWqY/3oDFmLfmp7zp0kKaAW0dJ4SPENxpoG9PsiXdiDC6+WkHlSFZgL
	U7XKtdkCaWnjeKLXHuLuybD8VmEdWWvMO1txsQBEP/MBgHYo1mHsehJStLDn0RSMwg==
X-Google-Smtp-Source: AGHT+IH+W5mD6xAgBUrmXlhQi1R/98f8p2RRH4QAQeaz6RvafIKTPcisjNcCk2vn/ekNxBtYOFf8Ag==
X-Received: by 2002:a05:600c:3b8a:b0:442:f485:6fa4 with SMTP id 5b1f17b1804b1-44c95aad94fmr58261175e9.31.1748196655896;
        Sun, 25 May 2025 11:10:55 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78b2f19sm208658265e9.32.2025.05.25.11.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 11:10:55 -0700 (PDT)
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
Subject: [RESEND PATCH] x86/ACPI: invalidate all cache lines on ACPI C-state transitions
Date: Sun, 25 May 2025 18:10:24 +0000
Message-ID: <20250525181025.1071-1-khaliidcaliy@gmail.com>
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


