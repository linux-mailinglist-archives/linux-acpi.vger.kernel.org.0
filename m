Return-Path: <linux-acpi+bounces-15179-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E28B07208
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 11:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B4D3B97F8
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 09:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4C62F0E49;
	Wed, 16 Jul 2025 09:42:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB322EF646;
	Wed, 16 Jul 2025 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658937; cv=none; b=WBvB5s54CMDCHxQ/PEO5osJwoxBjdz9UifDKfGFXge7vAqxFyYdn0RCRRgVzkTOEBsZzZEJyIw2Eq+DomINgz5thej+Z971JOf3OFq8Ie+s0YSwyLoxa8cJku0kttWtjUMCWbCNuI4ErZV55vfvxkhtxRSxWuLp7f7NJsCLtqh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658937; c=relaxed/simple;
	bh=VpVP5wDdJUADopR44kBGcroZazLAbCqHn1yQXetBaB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XeL3PVre/pEtTcfexUyeKP2IFY7tW7a/KDmPCGczNcdFEq7JvcNAe6DVW9gi/77YoNVkwo1mVUsZwmmzB/BWxwXf/qPtPmODDQu4w7onj5++YzhZnM6alyct3A6YL5ecN7QR0WOKha2RtUcD+z0CrSSCbTJBW+pRDw4k5/A3ya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso1332449266b.2;
        Wed, 16 Jul 2025 02:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752658932; x=1753263732;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFSywZB5jlv0hgu5XQpZ5VJL9BXcLP8sDIeWcu7IkK8=;
        b=XekID/izfc+2rVp5PWVfTTKHoDH4LXABl5wUn1wBOkK9EhcDduS3VZe5ehVLkynXRV
         j84kFxYgkxncPD21wIImndwV5wqzEMgy/XqctKrzqcxHWn/+m+0aueo3exMuOCCGBpnQ
         76qSqCMysTVhPE/kSnivEnHZ0jnPgnQ0fRO3Fs/BJsAZKe/juIr1T76TdDE6joyCLe0l
         uOCnYRzmi/TNoFs9tt3Fn9PefYsJZcbb5NvwV2rQboexEkAD5SjEBHsP8Rqt+5q28Mt2
         peIYE70nDhaFkrkRgJ3fh7p+Bj1P2LWEKOnlqlqtYNnRPGLXxUYUuyIDqEu1NUcSh88Q
         +mjg==
X-Forwarded-Encrypted: i=1; AJvYcCV31EIRblLDrtWVxjV44h+HDNeZ9oopJb0JrbcJXruEwuFUV4wIHEMtO0ynNfCZg5N0sVq2V3zA6Bv5K6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDB+ohXWubwYLCy/k9/V7vd7ZdJMMZd1nUAesFqt62lQOROfFE
	uihXjM71cwqjyseibOetV78u5XsBVkz7WY7yCfBGdbkZ+2DS7/kzoYIX
X-Gm-Gg: ASbGncsNokfy2D/LzABVJA7JyFu03BtuB3JNs905qY4vvPEkzn83oWdoo4OEodo1cBk
	yE0N6ku2+DQXglJGfi8YQmkWPk/YOoRONbSg99zO471b0r5mKWFRkcSBrZ/mN4lS5DCyQGzVyXY
	uVgCyrxl554SVoftq+QJXMtdfSoisViSo92QqgicqEpQz+SonNKE9db0MZRyeLJdl2roA4SLrqy
	MmA9fPAv8bfSQ8T36hk1DR+SRfAy5qaFzxfg+MYYBct8dfBxW0+tER1NKcU68Rq9VNdJXGV5yxV
	8GZ8XPZfAmkIiAHPGZZaLqDBLzPhQZAbtu0NUz26HVoZsOR1jsSHV71Hkel0ChawKaKGQIacLxl
	NgJDuDEC/vrbL
X-Google-Smtp-Source: AGHT+IGQu+odODYAB1D2AI4zb6eNSRou+CjyiarGYyccEHFqscLgIPqzpZaUfTHzVSOC5ARYzOSqYQ==
X-Received: by 2002:a17:907:894b:b0:ae3:90cc:37b3 with SMTP id a640c23a62f3a-ae9cddddbd9mr201034766b.17.1752658932108;
        Wed, 16 Jul 2025 02:42:12 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e829629dsm1164430966b.138.2025.07.16.02.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:42:11 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 16 Jul 2025 02:42:01 -0700
Subject: [PATCH v2] arm64: Mark kernel as tainted on SAE and SError panic
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-vmcore_hw_error-v2-1-f187f7d62aba@debian.org>
X-B4-Tracking: v=1; b=H4sIAOhzd2gC/2XNTQ6CMBBA4as0s6aG/lCUlfcwhEA7wCykZGqqh
 nB3I3Hn9i2+t0FCJkzQiA0YMyWKCzRCFwL83C8TSgrQCNClrsq6rGW++8jYzc8OmSNLo7XVF3T
 eKAeFgJVxpNch3tpCwEzpEfl9DLL61p+l7J+VlVTy7EdbYRicMfYacKB+OUWeoN33/QMX3ZF1r
 wAAAA==
X-Change-ID: 20250707-vmcore_hw_error-322429e6c316
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1948; i=leitao@debian.org;
 h=from:subject:message-id; bh=VpVP5wDdJUADopR44kBGcroZazLAbCqHn1yQXetBaB0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBod3Py9RV5rOmNyM93i9ucAzXR0Rg4SeTvLEoCf
 LrVQ5xHwJ+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHdz8gAKCRA1o5Of/Hh3
 ba6YD/497AWz3l/e5LLZNjAOgecknbGypw5z5LO5ryICEBddhQfKzvBikVlIv3QlaZomDG9vQ5h
 zCr1hgF+GLrWHiup+QvuN4vM7wa/1BStxBaderz0wnbVptevHKnrhAt0E0ntwGeHECe/rRmqhY3
 e+zINnrBKUO8MFhjHiHpDj3RtOWLLfEePGEdcyF3VbBdhgWzqAK0grxkKjNasftQr0kOea0GRdH
 meK3Fn2QRFDom0u0kyuPP9fR84d7eV/BILcgaxS4czDYQUk6qxUbJUdDzPGiovckW/Lliwwvr3A
 UjSfzG24mI9X0a2zC7sDVVkcCQfikwCiv5uNkg/GqLpSDpinmNIgTIiZjTfoGASZ0KV67e4TcFs
 g1ILLfJq1Iq7ggRgQyt7QYzDpmtMbYs8s8VK/Y68wCe1/fLaJdsmYCc0DdYEb5uRNdzykUgseP4
 v9lPxwaHGtWl0j0Q5ksencE6mWwBJtJdk7Z278dUij57eTImN8YdpFIt0ieL6FP62hbLaRgFFjp
 aX5o9ABtUTjT28Y8ynhhpu0iajjnn8cgQdKOg6YWR8mP/SBUBHseEsFZX3ix8nWAhaTHjB+7mt2
 LAulzyE9/3H75BdCM9gpeHDN3nqXuZ2fh/wHGnxKPHqNoFSrIAFECv0dqPIKmTDWqMm8P1Ka7RY
 NU0FOdMRYuGFJBA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Set TAINT_MACHINE_CHECK when SError or Synchronous External Abort (SEA)
interrupts trigger a panic to flag potential hardware faults. This
tainting mechanism aids in debugging and enables correlation of
hardware-related crashes in large-scale deployments.

This change aligns with similar patches[1] that mark machine check
events when the system crashes due to hardware errors.

Link: https://lore.kernel.org/all/20250702-add_tain-v1-1-9187b10914b9@debian.org/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Also taint the kernel on Synchronous External Abort panics (Will Deacon)
- Link to v1: https://lore.kernel.org/r/20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org
---
 arch/arm64/kernel/traps.c | 1 +
 arch/arm64/mm/fault.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 9bfa5c944379d..7468b22585cef 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -931,6 +931,7 @@ void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigne
 
 void __noreturn arm64_serror_panic(struct pt_regs *regs, unsigned long esr)
 {
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
 	console_verbose();
 
 	pr_crit("SError Interrupt on CPU%d, code 0x%016lx -- %s\n",
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index ec0a337891ddf..004106ff4bd03 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -826,6 +826,7 @@ static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
 		 */
 		siaddr  = untagged_addr(far);
 	}
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
 	arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
 
 	return 0;

---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250707-vmcore_hw_error-322429e6c316

Best regards,
--  
Breno Leitao <leitao@debian.org>


