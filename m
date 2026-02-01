Return-Path: <linux-acpi+bounces-20807-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WfWiDziZf2kZuQIAu9opvQ
	(envelope-from <linux-acpi+bounces-20807-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 19:19:36 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84565C6E1C
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 19:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 184443004231
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Feb 2026 18:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB563274669;
	Sun,  1 Feb 2026 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zjy7kpwq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E5219313
	for <linux-acpi@vger.kernel.org>; Sun,  1 Feb 2026 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769969971; cv=none; b=us5YESZEUmnpOlAvTaWS1oRVm/CGdmODD2+S5l1339llkS+z5B1DLGnT8Wy7tKuYgM5EToDuFl3MW1rQI9O606kDsngI2QXMsXDKrCwzBUUPn4Thz59CEJAdbIYlAZ2hs9uZRBHJx51XtvxFGJ8mlIRzzHMjqXPndLyPXlllD60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769969971; c=relaxed/simple;
	bh=9UEAYs8BOtkPMSZ+aZJXJjA/lA1oMnfd0ad1J+W/DCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QLC+E21nlkWbfkYfiimHQeRd6SSJzfoVcaE7f8Hv093aH9XiLtklp/50FRHy3jnq2UGADT9cXjE9y9gGhU0mWQ8PmDbEPRdcqvyrS43trL+NDVJzkzDnkZbwLIRs0i5+DItY9YpuexIPjfoww8fMTQic5Fd4r6Z1n9swwCnOttQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zjy7kpwq; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0c09bb78cso30409775ad.0
        for <linux-acpi@vger.kernel.org>; Sun, 01 Feb 2026 10:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769969970; x=1770574770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w0qHBL38GMK6RiP1vSDBko5Oah8ksm+tgX8bU2a4jHo=;
        b=Zjy7kpwq9NfZU3fX2L1si5S5AaLE653n+vGw9RmR4ZPo7eWAbEnr43AP3Ke/BN2y20
         DQQGXCApr2TDmtRaNx1pMAQYxK9ipfMfodCqi6VwgT5HGnOddc/Viq4MPLsa/oMgD+rD
         yiaBbtxB0fUjnTAB9hoNgnqzSkhvkbrXHSC+NRyAQdjWeqzSXiZRBHfq3Hpl9A2vASaS
         mBdKapyCuGfniM8IZM8MC0dOJ2IVQ/WrJmQK1k5Z0Uari68OYlWYig/snmJQDGyyZj2k
         UL9fEnmXcUUE3PSTEbd8joEW+d8L5CUXkf7qGMECQXJDGrcGE1qZPR4gYkGrileovJZm
         a8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769969970; x=1770574770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0qHBL38GMK6RiP1vSDBko5Oah8ksm+tgX8bU2a4jHo=;
        b=ABF+9K6kjG6Gs64pfPB7lr2eycRd9JVjAUE5R+PGvAt/WRdya8RPEZqNrfHlMH+jrZ
         LLECOMzlhoNM2bafWKJ68oWzcCqv3wsHs9zgD6cgzlL0poDr6HY0uwDhSa4TKInoWrOQ
         agp29QNs+2wts9/pgvAw+VFNhp2fkJzk+sql906FYbfa4fFoQ5okHMcbI79BQBUQXV/x
         5Ua87TfGgOrySd6FQiz32uVT+etEITXlPpAzXyTTHAyuKhtlSbCsOHGV5ZHusPoeMu1q
         1deQSoOOENxSQHdhE5XCfBojbDhovsK+gvg2zLf5K1bUDh/Kw/ETzAGsaAA5UU2uxiyc
         NYHA==
X-Forwarded-Encrypted: i=1; AJvYcCWu31Of9Y45KbprPNsAs+C/0J93e7VGw29+o0UXnoAa8/237i9QSFSA3ZHRfuD7mQyjKoR8EygA9pWx@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcoqkht2nOJqb0HedSRi1LImwwuXFw/JlkTuCnIVJLBmdR0qYa
	5RaC+in193HCp9ah/lgMABXC7aheGJn9CpQAN+6zf35y6GZ1x0Zst8Ux
X-Gm-Gg: AZuq6aJi2d3mfYDyQrDYF6CnyRUZh4kZw6INj6awA5scO9voJzI6nfaVDwDa7sOU7XD
	L0bfvilyC7KufHl0wLGbLr1U61vi2HPA04zfQ3rizKC/KoiZmT9F+l7RDqsR4nBYYcNztrlkHtH
	yDHlRdRqytJxD8NlB0gY1TfsPAobCRKMvS/6hTYnrGCHoM5xXjrX1MugIDHxCewPMB8eh3X+Rm0
	aU0Uu2sMgyBst86ih2lq0IGFWpOtlbpS1tXdh7CyicMCfzwdHwVI2MPuLPW9UzC2EtAKRUjYHE3
	XrtI+soFQX2U7uZo43TZ5Ec0+LOuKErYcKgABm2Bpwn2VUDYN2kHsUW+mrVjaeJqWyLiXZmk3vG
	wPL8kStE9nv610WvxYAN/9lvWB5Hl6ROc7JlJHh+n2fnmP7TffeirpTU+dCpYrY3QLgAHK05lFr
	UZyrvveQNylZhHwxvMxT4idNBjUTo=
X-Received: by 2002:a17:903:2f86:b0:2a7:a6fa:eddf with SMTP id d9443c01a7336-2a8d99514femr91910555ad.17.1769969969660;
        Sun, 01 Feb 2026 10:19:29 -0800 (PST)
Received: from gmail.com ([2409:4081:2d1d:b4be:89d5:e086:c91c:ec66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b7f9a9esm125644925ad.102.2026.02.01.10.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 10:19:29 -0800 (PST)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	robert.moore@intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] tools/power/acpi: Replace unsafe strcat with strncat in apfiles.c
Date: Sun,  1 Feb 2026 23:48:24 +0530
Message-ID: <20260201181824.4999-1-sumeet4linux@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20807-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumeet4linux@gmail.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84565C6E1C
X-Rspamd-Action: no action

Replace unsafe strcat() calls with strncat() in apfiles.c to prevent
potential buffer overflow vulnerabilities when constructing filenames.
The strncat() function performs bounds checking to ensure the
destination buffer is not overflowed.

No functional change.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 tools/power/acpi/tools/acpidump/apfiles.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index d6b8a201480b..c7b71579aae6 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -131,10 +131,12 @@ int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
 
 	if (instance > 0) {
 		snprintf(instance_str, sizeof(instance_str), "%u", instance);
-		strcat(filename, instance_str);
+		strncat(filename, instance_str,
+			sizeof(filename) - strlen(filename) - 1);
 	}
 
-	strcat(filename, FILE_SUFFIX_BINARY_TABLE);
+	strncat(filename, FILE_SUFFIX_BINARY_TABLE,
+		sizeof(filename) - strlen(filename) - 1);
 
 	if (gbl_verbose_mode) {
 		fprintf(stderr,
-- 
2.43.0


