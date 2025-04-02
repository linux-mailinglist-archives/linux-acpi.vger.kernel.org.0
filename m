Return-Path: <linux-acpi+bounces-12629-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75225A78582
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 02:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 203187A517F
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 00:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751D0195;
	Wed,  2 Apr 2025 00:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C3+O/Edj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11D8B652
	for <linux-acpi@vger.kernel.org>; Wed,  2 Apr 2025 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743552948; cv=none; b=oEDhJWsgzg8nFuE/RE8lM4VOWl5HqQJj5fGy3x3k7pPhE40JX69mQmxc5J+DjBiRVBIeXI6+mna3bPs//XbvAPRA2plSF7vexNApd3GGTyAEoy0oZRsEX73AjgVmMoWXNvHQfBNbB1McPvNsvkmRacagtKk2uFE6sWuIcVS2Rtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743552948; c=relaxed/simple;
	bh=wCYQ8SvvzczoXncD7qORdCTb2+eOtVmfN0herbB81vw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gulv9I4hQRphKGlwiEdZBuwtQexcgCZRSHzJ3FJzUsXeAqxvxMVkuxTGHY4hkYVy9ZWCnnml8ZOszNsfBrRZKTV3P+nh/mdKQjqFUOJAcsk8IvGlF/utA+/P7G6bSfXHZnWlts59gn6FB9ymq8iR+acHuH4dxQhTTmr/UbssrVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmeurin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C3+O/Edj; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmeurin.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2255ae39f8fso6011465ad.0
        for <linux-acpi@vger.kernel.org>; Tue, 01 Apr 2025 17:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743552946; x=1744157746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Rozx0LRj9ZB3KRmS37eTT3hVgaR52gsxk2FJLT9i6Y=;
        b=C3+O/EdjdFnhQEcO6exwE730twGMO4ynY78hLy/Q+XxEm7L5hZARh16SZnnAo2HJAt
         ZUKozm2NC5Oqd3HGMDhOIR7a9Idv1lcVEl6FTK5WGLRazkUNdj4SR6lPruE3yvIj5nNP
         4KgSgzPq6uU6IHEIAM+jgyWTwZl9HJEDKUy2M3cDBqCnLOw/aWuSBJeukSsyZlQuiOgE
         pAQTQTvX1YK77luj9uX+SDQs6kmuzXXjCxHqAcDeV95y+BTNRJ8hlNca4N85CW4EZ5EX
         nsNPve5CphvYXoHEUilPpTsR6Bw1M1xkHsmXlj2EUuU06iy1y28hvDNSsExO4Xt8IwSB
         ZjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743552946; x=1744157746;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Rozx0LRj9ZB3KRmS37eTT3hVgaR52gsxk2FJLT9i6Y=;
        b=G3mh/TC7dYI+Gjyhr6s6XqMsJn9i4/yz5yJXcAVZytDJtWN/Pxq3wYQtHPUJAj7elQ
         hapYJZjiQLIVDrjs/PI/+5+5Hso+bAcWSauNWvqMVR2zmju5fzktuK685rNuaa9MH+ar
         Uc9FRiCY4WV7CCFAphvPJFI2BcJF16dFq4lhMuKZ5qL/haCmfivD85LJCvPjInSgUxct
         zIrRGrh4FnLHeXVQbXDXGu7D1l8IDdzWSuLKH/vbt6g2yRKnGVKIwX7OH5oz7S7F4wZ+
         BRGNd0CFV0eRmaD3Ob2wbSwV7xd54kIxhovo2PfX0nEKWOOfB8h7JEreW0Gb0DJfTciG
         r7Sw==
X-Gm-Message-State: AOJu0Yw20nJh6tmpqTB2RRqpa6Hk/pvlN02X4s8tm2JWT+N84JXZvVUz
	agwWA4MP425UyxitxE2yXE8/D+aFuvpcw+zydNXI5uYLssYfsZEjq/2ukYpk8AUHG9xLJ+uBgzQ
	zXN42bQ==
X-Google-Smtp-Source: AGHT+IGjqqGzPLeYp/DY4j3wFWini/uUJXzqWdiX5BTT7/eVUFPOHogteoIaNhxkOFT7q+nFdRmhrlAnLBXo
X-Received: from pfgs27.prod.google.com ([2002:a05:6a00:179b:b0:736:39fa:2251])
 (user=jmeurin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a11:b0:732:56a7:a935
 with SMTP id d2e1a72fcca58-739cadb5245mr92324b3a.12.1743552946172; Tue, 01
 Apr 2025 17:15:46 -0700 (PDT)
Date: Tue,  1 Apr 2025 17:15:42 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250402001542.2600671-1-jmeurin@google.com>
Subject: [PATCH] ACPI PPTT: Fix typos in a couple of sizeof() calls.
From: Jean-Marc Eurin <jmeurin@google.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jean-Marc Eurin <jmeurin@google.com>
Content-Type: text/plain; charset="UTF-8"

The end of table checks should be done with the structure size,
but 2 of the 3 similar calls use the pointer size.

Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>
---
 drivers/acpi/pptt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index a35dd0e41c27..f73ce6e13065 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -229,7 +229,7 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
 	node_entry = ACPI_PTR_DIFF(node, table_hdr);
 	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
 			     sizeof(struct acpi_table_pptt));
-	proc_sz = sizeof(struct acpi_pptt_processor *);
+	proc_sz = sizeof(struct acpi_pptt_processor);
 
 	while ((unsigned long)entry + proc_sz < table_end) {
 		cpu_node = (struct acpi_pptt_processor *)entry;
@@ -270,7 +270,7 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
 	table_end = (unsigned long)table_hdr + table_hdr->length;
 	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
 			     sizeof(struct acpi_table_pptt));
-	proc_sz = sizeof(struct acpi_pptt_processor *);
+	proc_sz = sizeof(struct acpi_pptt_processor);
 
 	/* find the processor structure associated with this cpuid */
 	while ((unsigned long)entry + proc_sz < table_end) {
-- 
2.49.0.472.ge94155a9ec-goog


