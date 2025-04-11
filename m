Return-Path: <linux-acpi+bounces-12985-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA44A866A3
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 21:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF6187A9C9F
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 19:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A7C22D798;
	Fri, 11 Apr 2025 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOj/yDL4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E4013C3CD;
	Fri, 11 Apr 2025 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744400907; cv=none; b=P/OW91c7sKIiIV6Q/Ti9HhOUJHx3f/2PzSFkWkGAboZjdSBZpRWAuSufJQlhkRRucBTcvKqEQVtZzGwRcogo/X2LKrrEeJeaCbdL2jmwuCmhp4Z+9E43XSEsrlsTjV/2lEy2fyRYANIWhbA+QkvMicomDJZ4po/Wcnkt9h+8fwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744400907; c=relaxed/simple;
	bh=S7wbx4z2viKpNfh/TbwztKNkVe7sXf9RouUCSiXpzrM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NWasxnFzVhxWyWOvS3BWmiL/pePYmHuKCbIAvfgCygVGL49Pe5y0OcBpt+9uP1U07dJyQA66a1Onv9fppps3Q5HS7T8TJ5/iu1VVm+UbMO5qo+yJU7cL1m+wzgyUdb1Ia4679kIi6YjPUVDHFpGsFILb9s1fUa7pxkFXDfshkEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOj/yDL4; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c7a5ee85dcso40777985a.2;
        Fri, 11 Apr 2025 12:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744400905; x=1745005705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+pRntXP7VibmaqmzV/GwYuKDTGapH8yv3I9kSeDpHMc=;
        b=XOj/yDL4DquQIO6WV63aRxzMqJtCPWoljKqbc79BJ8strONEgQuZX2jAUNeZ8xnOkS
         4JYNBK5afeulBinqQ2+C/+j6nFhrrzuoq8vEQ2MsEv4liox32qIvgWteFpRWz8lUuVuK
         6b2Ng7TlDFs5dB0Aj54FVI5aTkUL+RgWSHDPOanM1Mx6j/YLzsPcxpRIRFN0IQ954tBd
         xIAKnemcEgdLJpG2KSpZ+i3VASv3zhU5LiU/xinYXtDSJqT1mUwuwjAAssGWfbZ4q8VM
         b92PvgqJwwbyj5v7B7KUwjMsgtYDe2FY6NlqTE0UUtKFcjcLyZ/bEsb9KAHt4ry8tnHL
         UIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744400905; x=1745005705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pRntXP7VibmaqmzV/GwYuKDTGapH8yv3I9kSeDpHMc=;
        b=ABOmBooHOaV0kZv+gODUmqTtmUVm0CkV81613bW7FiAGf6SLiVLWznlwDsKjTD0dMI
         7rPgJoAZY8ILQcHiYQftIKl2WmVLHF4cYAGAcvVZMlQrmc4Xy2kO5Nf9kXFZVz0EggL8
         WRXE2QzL0OiLlwpf4mRiuY54qik+zW0lzRhunPtybXRA0rB6YzWM4M6oCCO/7jPagQSE
         DKYUR6bwClB/T+wil/1Fo4J6VetPBlk9YnYnPTRFYxvdvKWU56GLqPehulHos11fS9dr
         i9ARqsERcV8ra0kb41tS2lYQcqE1SCmvN1J6wdfA9H72dj61PkipBoGmjQLfBR5NErie
         4wmw==
X-Forwarded-Encrypted: i=1; AJvYcCUxFWAeEg4RRo7WYKcRU30vCN46jY2pkvelepZeYpFiFKDyd1hj5qdc0vFRw0ckqgBP/EgjKMoXELg4vsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUPMAneDmOJWORGniuhU7csxGDYWU1jQ0/5GBJvcncs4i2pv8D
	8Y2REsonbrLvPB42ALkpGfSHrjHW6L1cYryNJ7eAXg11q5dkF40=
X-Gm-Gg: ASbGnctUbfnPMWllMD8j2ccVZLU7b3mkzEEJHA3EjgeIZPpRQus+Z9cxEZ93BEE/93t
	smkGk/bdDkywpQBNayiiiXQWGmR1psqCYg1fLduTIX1sQh0BjQLeOzMymSpnwGArC5lKqpmletL
	lXmXrO1v+wP0UaqtR67wXQboPqFEIiRThxt22Kc2oW06f3JlCfuhRiX80Stbl6BX9xJKfY5W2P3
	8Y6SXGn5b+h5JcR/bk2aOqkXIu+ig7XSnZA8YpbznP557zX6tpLlY2s2fXPcfkS+OUuvIKgTtNB
	JYO0UYq1Mug5NnEhevCmfwEWSFUd0OlJ03o/Tw==
X-Google-Smtp-Source: AGHT+IE+DeUkY1FXhB5Zap8w+jJjeuXQJphIE2aTwQhSj6A1oSifYPg6CjvZfLBerA55tBG/P+XwVw==
X-Received: by 2002:a05:620a:1787:b0:7c7:aee7:b959 with SMTP id af79cd13be357-7c7af1dd1e4mr207959385a.15.1744400904846;
        Fri, 11 Apr 2025 12:48:24 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a895163asm305909985a.27.2025.04.11.12.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 12:48:24 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bhe@redhat.com,
	kai.huang@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] x86/acpi: fix potential NULL deref in acpi_wakeup_cpu()
Date: Fri, 11 Apr 2025 14:48:20 -0500
Message-Id: <20250411194820.3976363-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The result of memremap() may be NULL on failure, leading to a NULL
dereference. Add explicit checks after memremap() call: if the
MADT mailbox fails to map, return immediately.

This is similar to the commit 966d47e1f27c
("efi: fix potential NULL deref in efi_mem_reserve_persistent").

This is found by our static analysis tool KNighter.

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Fixes: 2b5e22afae07 ("x86/acpi: Extract ACPI MADT wakeup code into a separate file")
---
 arch/x86/kernel/acpi/madt_wakeup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index f36f28405dcc..b386ec4b87c2 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -143,6 +143,10 @@ static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
 		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
 						sizeof(*acpi_mp_wake_mailbox),
 						MEMREMAP_WB);
+		if (!acpi_mp_wake_mailbox) {
+			pr_err("Failed to remap MADT mailbox\n");
+			return -ENOMEM;
+		}
 	}
 
 	/*
-- 
2.34.1


