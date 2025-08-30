Return-Path: <linux-acpi+bounces-16213-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEBCB3C850
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 07:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 247C17BD8B3
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 05:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1412C21F9;
	Sat, 30 Aug 2025 05:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JQD9o7gX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD5829BD92
	for <linux-acpi@vger.kernel.org>; Sat, 30 Aug 2025 05:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756532077; cv=none; b=fgDnWAvEaL3v+vXVZ/xCy9bA91daTvhc74wv3G6P7Sn67YXsGhrQ355dsC1jhnkIqK/JaVy4201hGDdgWBwA/1MvbBGNE3LQKFdWjfgifEtP9BTfcMgxTCKFJEFxzBFoDuCQtFSuzxWt04qZLBPptSlzHnIChElYprTloVCX4j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756532077; c=relaxed/simple;
	bh=uO/ODjE/zYZVgbm1CU9iXym5pNf0yiWRr0Jb7Ejew9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OEepORzkp/F282+M4vMxh2RtblstyjwRLU3TWFpJZfTAncYYDv9VZeh7uvfic2wad8PpSjf1wrgd/DIrE9UEdu+b2tldNRn8RyZ4uB7NBF/q68UU9NinA65/qcYTi0DuMg6cHCSOTRxoN77y12bFz9rExPEhuXeIaG8B7k8R8EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JQD9o7gX; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-61d2adb3258so142128a12.0
        for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2025 22:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756532073; x=1757136873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yg7CRJ0dQKyS1GOrInJ1XjZDl9JOndiYGx9QvzOWypY=;
        b=JQD9o7gXpMWrnz1CQE2zJMTvayxDEvs9QKNoFxY7eUCLXYZL0IyhoW611ZEqdHn3SF
         Y8rq10tI56GNavGlaeFPPwwhto6qbhaPrwV6BvRhKw6xrpxELaY4i/6z1/u0lb8IlSwo
         FdYfk2QqJHUh2xuOFxocqNc5wEalPaDWx/KmPXXN4aSLb5U3DYRxidrJoOTYtCDdu6rV
         hTz7Lo09Ag7ueRrXEL3qHdTrfFGbi2V4P26aBq6jIh1qbEArNtAGsUhSjkAKmIGGvgFT
         cMtdlgaDMI9nZ/dGyaTKgXXYE7BEgIwVuefenjLfVwiqoEBgoOp52Woc0fzZdC22xi+F
         58Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756532073; x=1757136873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yg7CRJ0dQKyS1GOrInJ1XjZDl9JOndiYGx9QvzOWypY=;
        b=j+MehR+TI67WXwQ7qHcPVKmHdNVTojGEg/6BmKyFLGmermnnhuzkeIWAXk/EwUsRxk
         jVnSmms/IxMScl4Dvoobn7ekwiitqqpud2fF2le/Pj6SYuD/8ZYSpn7jOPcVc2dnQANX
         MPnPHjW4YWz6kPnpECKMeMiYrdI5E1QMfqnmK4s5oFgCtRg+shUBxIxCoRAHkot4VDRC
         kPDbL111tygibMYqsyrTs9KgUvXz1f4ecUriLQDKSZmhY65dLxSIJsthURuehcbbXoVO
         w21vbmPCNb/MN/8YY6fnEMYUrccTQNMWlmmliKCAleG4ZrA/o1e7ACtr1Wy3CAzDtHSs
         2XWA==
X-Forwarded-Encrypted: i=1; AJvYcCV+gVR9Yes6kyCahg5COxt+3cmUUX4dmy1XqYiJ/ONrM1uJl84LnlBJpurEdNNzcHEWB/hY4Eq02KEt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7UwiwvlCVs6SjM5xHSlDeKjlEcOpimWVQZr/wq7/ZhRdkKwKb
	c6p7AxU0mvvrcQHDrIKexLunWFtlY3tTP1hJmmApDlQajA3m8yW6qYsICqsD3TTMCgaThL2s4kL
	qUU1F+Q==
X-Google-Smtp-Source: AGHT+IEt/4Q9x3GXVaT8543rG9eCaojjztEKwpl3WFkiLwBvUvkuJUh+sjRu8HQmFq7S5jcqpBu8z9GpTn8=
X-Received: from edeg15.prod.google.com ([2002:a05:6402:564f:b0:61a:56c3:d3d2])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:27ca:b0:61c:5a8c:9a4e
 with SMTP id 4fb4d7f45d1cf-61d2699752fmr748665a12.4.1756532072715; Fri, 29
 Aug 2025 22:34:32 -0700 (PDT)
Date: Sat, 30 Aug 2025 05:34:02 +0000
In-Reply-To: <20250830053404.763995-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250830053404.763995-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250830053404.763995-11-srosek@google.com>
Subject: [PATCH v1 10/12] ACPI: DPTF: Remove not supported INT340X IDs
From: Slawomir Rosek <srosek@google.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, 
	Slawomir Rosek <srosek@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove not supported ACPI INT340X device IDs from scan handler.

Fixes: 3230bbfce8a9 ("ACPI: introduce ACPI int340x thermal scan handler")
Fixes: 9cf45756a4b9 ("ACPI: DPTF: Support for Wildcat Lake")
Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/dptf/int340x_thermal.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 26522ddfcbaa..7d1308b1f513 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -21,12 +21,6 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	ACPI_INT3406_DEVICE_IDS,
 	ACPI_INT3407_DEVICE_IDS,
 	ACPI_PCH_FIVR_DEVICE_IDS,
-	{"INT3408"},
-	{"INT3409"},
-	{"INT340A"},
-	{"INT340B"},
-	{"INTC10FF"},
-	{"INTC1102"},
 	{""},
 };
 
-- 
2.51.0.318.gd7df087d1a-goog


