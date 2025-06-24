Return-Path: <linux-acpi+bounces-14573-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77AFAE70B4
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 22:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A56164F9D
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 20:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFED2EAB89;
	Tue, 24 Jun 2025 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxnD+2w/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE92E9EB4;
	Tue, 24 Jun 2025 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750797002; cv=none; b=Gy7KCe82B2CBVaM5wbMiJlVjCXNrl28xOPBs2xQDrEKf7i0mzDz5SCMo4KoYWKFXHNlyI5ETPcftQzCJVAyq7C/TtxaYGObXFsAK2iXb59Se1nr0r/SYSlyJgv77zYFQUPHmDidY79VlgLy2LOpkaESlpCp5kZU3hIow7jmZfCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750797002; c=relaxed/simple;
	bh=G5jHjUAFPaNxb766dDm6aPO5ukHke3MtXDLhg1dG6YY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XC9S6faHHUJE5rk964vezRzv8mA5UK8/iDdTNsITNN3IzjW9aDT8CS/p+dmLRG1CTIDf8/jfMN2CfcV3U5D+4OT+49rqBn185tvzfWBKZIqzPYxu7eVPDYmNW1BdSI7SBngSI2vmYWwLrnwbOvYLHx4sMYyHMBxj3bbYgx3ybMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxnD+2w/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso588552f8f.2;
        Tue, 24 Jun 2025 13:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750796999; x=1751401799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cc1cJV8t9VucNYTqwHrmhx6iEFKvUQnQDzRDdocCpb4=;
        b=KxnD+2w/QDVTMYS+KSpYaZ3IPmwVMpqex88t5g31MygVz4ojgC5UX9lJUmUbQcGozq
         WQ1qCQwORp1JQN3Gcdc9nTfaDJF/UX8p+J7/S22xD1NMB9BhCzo3dKPQJxzU7OL+izP9
         XBdmPVjwKxeSdKovcwp6LowwXOjPWsizi5e8Hck7w1SVdJNK+De3Ts/1QmB8VMritpxG
         2+JnrYaBqbOIjDR3RyrH4ih2bsn0fl040MISY1UYEmoKz0dMUdFG8TjqBsCnCweZHkj6
         QZv8ejhi38h2yWibsQ4dBmo9PiPMSLPET8lwe9O7AUeaSIr6CLLujSy7N4c2UBgW58x5
         +Fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750796999; x=1751401799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cc1cJV8t9VucNYTqwHrmhx6iEFKvUQnQDzRDdocCpb4=;
        b=hmwQV6uIFYGe4HE1K4YP7URDcL/q5nKA723cxCVeGAndlerwXk5DZJnMIdEZsjoagf
         BWBIRstS+G+eyuzFNoT8qROK8xivQ+pV9Lb0bvimCBvdVeveCj/++vD1m+8VG2UxEkCg
         LlHszPIE+2q7y/eMuVXVtfp6aL3ivcc4q8rSYxnoWacdXKVqWmvFApNMqj1DrzJwo1Vc
         ryb09SuWJIIw6pNfVPkxfMUZrfZlXA8YZcxQQowviaWhDQXV6zRnk8J9yBB6Zq8IzXbI
         gwRXb7oifhFVwJwriYa4vhXOZZ9pXoOtUcZ0JkSHEOP+snZ/HbAo8V1Wlh4C3NhTxCvF
         9UWw==
X-Forwarded-Encrypted: i=1; AJvYcCVUADtnpzcDKzY30nhJ004k8eDDLHUlCsMXbrrTJiyxeiVqwLlevNlAeeEvYF9EI7J3k2MF6jshqk/m@vger.kernel.org, AJvYcCWXB+tSItltDj023XIhpp/iWojrZPv0+pFg4w0eCEsMFbgDKjQ6lHlBv8OqBVWipDMcs2xEVwxtLw8itrWM@vger.kernel.org
X-Gm-Message-State: AOJu0YxnYHcpdOTQRhsqWP8OpcyGW7IfZbzGa/g5V3VHiCNLmUhxoUAG
	FL4G2/woMRRKF+HuzBAzHb3H3DZjO4o+uMOgfUHgwIOlX3PXGJQUbguh
X-Gm-Gg: ASbGnctk+S/Baw4REiK0P4xs9VdWsen3JtoH8x3mYL5Xhx87a48LDwC36b4PZMQo1en
	M0RKYQ+WfeF2hovcv5qs4+pGbxqhmhIPlrnZGOwccmCNICTG4zweGlpeoyET8hNo/JqY6ahT+SK
	88asyeL+SjMPE+0j2fNEvy2kvf29YL7a6z/rz9Tk3im3Uj0BS8S6TIZgK5+U/lhc0saiFy+ldFX
	j/wOSOm+PG3E+RQpxgUBl2AHt3yYUcyU6rvCrHP55lqdVJfJ3ah3od2xwJj7MhDwdukuX/28sxs
	6SJxScACJtGzvi9iIVPppaoP/186AO5ASjOApZMto/fcvY5agnrmhhd3MI/XhdvdF+HO/wQ=
X-Google-Smtp-Source: AGHT+IHslSSf7KvDz7QkNZn4Jopu99GX8X8EENWK+B96+OCkA6cc2nKI3QeRmFM3Q4mtkbi5MWCS8g==
X-Received: by 2002:a05:6000:4a0d:b0:3a1:fcd9:f2ff with SMTP id ffacd0b85a97d-3a6ed60c8d2mr137549f8f.12.1750796999442;
        Tue, 24 Jun 2025 13:29:59 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4537c6e2f64sm13745905e9.2.2025.06.24.13.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:29:59 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Ira Weiny <ira.weiny@intel.com>,
	linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ACPI: APEI: EINJ: Fix check and iounmap of uninitialized pointer p
Date: Tue, 24 Jun 2025 21:29:37 +0100
Message-ID: <20250624202937.523013-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

In the case where a request_mem_region call fails and pointer r is null
the error exit path via label 'out' will check for a non-null pointer
p and try to iounmap it. However, pointer p has not been assigned a
value at this point, so it may potentially contain any garbage value.
Fix this by ensuring pointer p is initialized to NULL.

Fixes: 1a35c88302a3 ("ACPI: APEI: EINJ: Fix kernel test sparse warnings")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/acpi/apei/einj-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 7930acd1d3f3..fc801587df8e 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -401,7 +401,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	u32 table_size;
 	int rc = -EIO;
 	struct acpi_generic_address *trigger_param_region = NULL;
-	struct acpi_einj_trigger __iomem *p;
+	struct acpi_einj_trigger __iomem *p = NULL;
 
 	r = request_mem_region(trigger_paddr, sizeof(trigger_tab),
 			       "APEI EINJ Trigger Table");
-- 
2.50.0


