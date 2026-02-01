Return-Path: <linux-acpi+bounces-20808-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLRrOsOZf2kZuQIAu9opvQ
	(envelope-from <linux-acpi+bounces-20808-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 19:21:55 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92307C6E3D
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 19:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB5333001010
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Feb 2026 18:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7E2280324;
	Sun,  1 Feb 2026 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh/o4eRI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A074274669
	for <linux-acpi@vger.kernel.org>; Sun,  1 Feb 2026 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769970113; cv=none; b=udFunMjrHre3e4uel2On2Yu7elGY4U02wYzvjOTOrPdjKWZEseG7ah/a11ntBSF2pFOK4VexuWfCayu11dkMbZ64t6uoxLxDErcmLXJvbIX5kCuooG9DTRw7o175YPA6dfjfZ6D2cby5Jpm7IvFEepHT+hYHNxkAr0Vd23/5owI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769970113; c=relaxed/simple;
	bh=ifpEA+fzHgyIbirKJKn1wJrl4wHKSf5jVLm3dOmyb9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXTWUXF4NwmVDPFTxE/TYZpm/OO6mv8ltyDn5cOFTndHT/FlAFJEtdy2+UT0XVxFZNLhPnOKQxIURvjWqTaiIRobUm5q+hc3yL+v0xUTbSpuLT3sv1DUTrcbI/ZdCWqzt6ZSY2e1sRtE2rzIG0PijJNTlxaw8W/2hjV8RI+2iqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lh/o4eRI; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c868b197eso2667427a91.2
        for <linux-acpi@vger.kernel.org>; Sun, 01 Feb 2026 10:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769970111; x=1770574911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rXoPKzs5Nz6Ocvm/PYFIBQC+JTSF0Nmu5luN9ipSXfY=;
        b=lh/o4eRIqFQtvNnrGm+ceBUcG9B9w4q+yVCj4R6wUdSCK+FEw9q+zveNV2x10wUIiV
         CbaAulb2WlMGK1I6TGQjtavuaU3USyYx8rS5XQODt0cUP9N/Mpp6vBey2SbQGQ5TFDRN
         btU5ND3wTI1ROKPL6cSIcJFV4c5Vho08PGXXd+3tnWz1siVE0vjm24zIp3qXM/2t+TeN
         uoRmw4W7kG86wsxJ7cVvCol8lTQJqvsGitoizzh3VWdcekH431UwT4Ng/a1XU0B8gqNx
         V5s8tAosUzVgwa5b29+wNDB1b0wRbD6c4t6ei0N4bcd/GYa2w8MDkrb8FPkPh6qh6PUR
         9yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769970111; x=1770574911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXoPKzs5Nz6Ocvm/PYFIBQC+JTSF0Nmu5luN9ipSXfY=;
        b=vGFiNENcSE92ffMrW0uMJwXgmMC7rlQ5EVqZBW56YmeB9zxzIy/BYbY8cA4Itr/KUF
         0CEivZABrzXNCKtq/5jNfznV3+7v+SQaMuRYr+50uMzHKgQwiQS5e0PQr7fpIaf/43hB
         YVy8Ep+sKppSuD0oJ4gFMP3aC02A2dKpmdUuzOZd6fDSqOk0iTPfBInYBx5HH2oSuoS+
         JRp6QbnHVXbqokP4w2tHuMg8cPmRCB4wZ54fJKAGw5gNV9A/XElfvjGK1k5+bT8xuuvQ
         uZzo0os/XCKMr0MPB+QjEdLxCVNHgzEv6sM9rgSH8A1lQbFLiVyxNzKigxqbPSworpJS
         EVOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsOLNfCT9OMAfgd7nxcBIIgUpEjvJ1636tm1CHQZ5cnf+/TY/KkyYceaTPwUQBLiuczgvus0H0wu/L@vger.kernel.org
X-Gm-Message-State: AOJu0YxW1irPa/3eSEOm8ISake0/rUBzrmo7GDkc3jUef591NOQN0uL4
	RNuZpYIUCYfv0uP4nV5OzN1pqHWfJUUvCjV3CxzshNXdMNJ7jvJjoFb3/ahIFQ==
X-Gm-Gg: AZuq6aKgyinHrhvvbnuhUgxeRK8eh8x3euT2ZZ3M36kD4zgWxsVwb+/T0BXaEV4y+MU
	Z5GqO4v2pDHeUlE1uR1sp/LKd4opkjc2xXDlMpiMDTWtpd+1y7lolEKU3M/cTwIVPEmbAweFxYg
	GKDF+f67zzcZkd+jI832N1C5dG7Y/uvz+5hMs+wm0OsHIg/Nta9uWFf9U/on1D6ILhZQJFSEn+H
	rR8De3se5syDnLxTHVdbM8FHxxJyb55Iiw2cXsamvZPfFZiQBxQJW+zoMznk0IakGGTolJmKbkv
	3Y7IpLEE20Q2gZioIrzivtzK+oRS7v+Zce5J/wURzI1AUdVl04G+Kx7UOXHGfkzxWlU5VAUjt4/
	b9Q5ZmTrVUqex4VTM0BxM1pi5wSeZmqfqpDhU3gkmUUkyFknK1N7k4uhwBWSDVSZe8NjyLpTnez
	4V6iglGIDAn1SPOYnK
X-Received: by 2002:a17:90b:4d09:b0:353:e91:9b38 with SMTP id 98e67ed59e1d1-3543b3bac1fmr9070089a91.34.1769970111493;
        Sun, 01 Feb 2026 10:21:51 -0800 (PST)
Received: from gmail.com ([2409:4081:2d1d:b4be:89d5:e086:c91c:ec66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f3ed0dasm12599461a91.14.2026.02.01.10.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 10:21:51 -0800 (PST)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	robert.moore@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] tools/power/acpi: Replace unsafe strcpy with snprintf in apdump.c
Date: Sun,  1 Feb 2026 23:51:41 +0530
Message-ID: <20260201182141.5039-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20808-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumeet4linux@gmail.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92307C6E3D
X-Rspamd-Action: no action

Replace unsafe strcpy() calls with snprintf() in apdump.c to prevent
potential buffer overflow vulnerabilities when handling table signatures.
The snprintf() function performs automatic bounds checking to ensure
the destination buffer is not overflowed.

No functional change.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 tools/power/acpi/tools/acpidump/apdump.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index 7a6223aa703c..b566f9b832f1 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -308,15 +308,17 @@ int ap_dump_table_by_name(char *signature)
 
 	/* Table signatures are expected to be uppercase */
 
-	strcpy(local_signature, signature);
+	snprintf(local_signature, sizeof(local_signature), "%s", signature);
 	acpi_ut_strupr(local_signature);
 
 	/* To be friendly, handle tables whose signatures do not match the name */
 
 	if (ACPI_COMPARE_NAMESEG(local_signature, "FADT")) {
-		strcpy(local_signature, ACPI_SIG_FADT);
+		snprintf(local_signature, sizeof(local_signature), "%s",
+			 ACPI_SIG_FADT);
 	} else if (ACPI_COMPARE_NAMESEG(local_signature, "MADT")) {
-		strcpy(local_signature, ACPI_SIG_MADT);
+		snprintf(local_signature, sizeof(local_signature), "%s",
+			 ACPI_SIG_MADT);
 	}
 
 	/* Dump all instances of this signature (to handle multiple SSDTs) */
-- 
2.43.0


