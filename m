Return-Path: <linux-acpi+bounces-10068-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E82819EBD74
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 23:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EB9169062
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 22:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE1323EA83;
	Tue, 10 Dec 2024 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZPlmdnOn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44123EA76
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 22:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733868352; cv=none; b=mVK2bPROK8U79JSDOQSESHzrvjong7LmE77w4BrajkAoIJNZ4pjwUrEdiDWvaLJhPKe0SUi4LAb0sNw2G4JLzKzMg9LZPrkC2Xhpum+dl3Adb73EqqLsdQF2j0E8HN8601Bs6y2Ty7wF0BmLqHsuQWCsJVYNBfNSGg5WZXlJk50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733868352; c=relaxed/simple;
	bh=Fh3n7PO+dBFbjqXgXF7FsyhtwUGk4+k4X3Y2eq0ifU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8c4lNcjFyEMcoEJgv9/R+QV5r1tXhbugqlEE68Ww2CNucjSTu0indjqGl5EW6wqo+g2WdTcRU1S7Soym7fA1XSiCQ35viE3th8ZIwe9gerFsIVpxY9tmMB6aj0cLHpASXmb7DZq7+LvpLxoEDuGBhzVUUhudCyRGVlX8b6nr7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZPlmdnOn; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d89a727a19so905756d6.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 14:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1733868350; x=1734473150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAbRT3t6URREoSf/WrSmqWIQoci4Yw7h23phPh/fk7k=;
        b=ZPlmdnOnmen35vIY7iDVA41Snl46w80ILte2Oo6TSP8IcyhfgV9KXL+g0Q99zSJHvv
         IdvxlJGNpjUDwA3QkCzGtS85/0JVzsdP0XCH+5a7nRwyfYk6wDNhRN8iNoXa3o7VtDVe
         Mhf0aG9cPCqf7UixaK+oPiL5B17fozdxwp/alWSeaIRnS6FUfxUCGtOU6S5L0UqqaXC1
         +I1Wy796XCKMrUM0oVQ4MeRGpl/6McUrbSpk+kNxt+ulj//oR+L18o1ca107zSBj/XJm
         yfg3r04gh6EWackkjmxtWhdfj7Qx0+X7kScSAfmZukVbWc0+C1vu0g1uMzZiwVPsXYlm
         o0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733868350; x=1734473150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAbRT3t6URREoSf/WrSmqWIQoci4Yw7h23phPh/fk7k=;
        b=MHZ+GS24HIqKxErrOPaAqVLhiZUVZKfG+dToGe+O51TMUD5yMB7IJGpIoIDlofiH39
         3Jt76binN5OjvwUTlHglNERegsDPJbl6DuGNOd6h+PqHFw4T1BIpSA/bC+o6yCieStOs
         GrhG7MvCwQB8uI4DV9qAF5tme5Qf3wdbzJJqsnql2Oi++g1M02TumzrzjQ+37FmnA0f9
         i2ngE/EhF2gLEHUhtxe625qatbFdW3v7mNBeZEtief4J9TG/5iZoal1iOvjqlNn6N6pe
         0zId8k5LYyC8T4P3VFvq+PetdAYP48la63dPnT4SNS7/kowS/ygvrvjkwsc502mV6UpK
         pMAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqA7ukbV9QzHSf8eqSH6T/c9pvpE9jlenpAQTFAZyqAyzGfeb9rxzQKuun1xQjKCw13lyd/m/A3IKm@vger.kernel.org
X-Gm-Message-State: AOJu0YxGE4v2NQakQz9K7ou0AQOjV3nEiZi17poNman5z3+G/spB0xBL
	Uy7ljbMEU0kiWHVp8sotq2GEJN8pJagVVG5eB//aXwOE0G3yaMLOqnmhZ0k74w4=
X-Gm-Gg: ASbGncvkLvJTIfvsTy/F9jRVUWyYdt8vQ3+EWLYhbzO4R8GMmAvyJt4mqm4sVgwreqJ
	qX5ipsSzifN/lbBkHxnMCAjAiI9cTl5mCfETJ3eUQQVEj4TrnO4EO903xY6aKIYDvCifITM02Nx
	J71EGVT8Y4iCMhVaZd0juG4w1tfkboflorhZwXOVLGvebDxRotJaQhl+b0AbwPdWMoeWEYqRtVQ
	dUSwOCKhW7yQPSSLuP9PggX5gXZ6JBJx9IQTl2L14v4UyjdOXxgBUYhSv3i6rcFwg1lMR4YbWTV
	QxkP/XbYsQ3o7TomoP1SeghB17n6AJq/OAErxio=
X-Google-Smtp-Source: AGHT+IFa401/2CB5gCylFx+OUusnw00jP99YqBV6GuTzUiOFDtq2M92ekuKX3e9+dJid45ADWSbIGg==
X-Received: by 2002:a05:6214:260f:b0:6d8:98a0:23b6 with SMTP id 6a1803df08f44-6d9351fb640mr8120916d6.4.1733868350323;
        Tue, 10 Dec 2024 14:05:50 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8eeb132e1sm49707756d6.35.2024.12.10.14.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:05:50 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	ira.weiny@intel.com,
	gourry@gourry.net,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	osalvador@suse.de,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v7 3/3] acpi,srat: give memory block size advice based on CFMWS alignment
Date: Tue, 10 Dec 2024 17:05:17 -0500
Message-ID: <20241210220517.3744-4-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210220517.3744-1-gourry@gourry.net>
References: <20241210220517.3744-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Capacity is stranded when CFMWS regions are not aligned to block size.
On x86, block size increases with capacity (2G blocks @ 64G capacity).

Use CFMWS base/size to report memory block size alignment advice.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/acpi/numa/srat.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index bec0dcd1f9c3..af7d51222933 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -14,6 +14,7 @@
 #include <linux/errno.h>
 #include <linux/acpi.h>
 #include <linux/memblock.h>
+#include <linux/memory.h>
 #include <linux/numa.h>
 #include <linux/nodemask.h>
 #include <linux/topology.h>
@@ -339,13 +340,22 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 {
 	struct acpi_cedt_cfmws *cfmws;
 	int *fake_pxm = arg;
-	u64 start, end;
+	u64 start, end, align;
 	int node;
 
 	cfmws = (struct acpi_cedt_cfmws *)header;
 	start = cfmws->base_hpa;
 	end = cfmws->base_hpa + cfmws->window_size;
 
+	/* Align memblock size to CFMW regions if possible */
+	align = 1UL << __ffs(start | end);
+	if (align >= SZ_256M) {
+		if (memory_block_advise_max_size(align) < 0)
+			pr_warn("CFMWS: memblock size advise failed\n");
+	} else {
+		pr_err("CFMWS: [BIOS BUG] base/size alignment violates spec\n");
+	}
+
 	/*
 	 * The SRAT may have already described NUMA details for all,
 	 * or a portion of, this CFMWS HPA range. Extend the memblks
-- 
2.43.0


