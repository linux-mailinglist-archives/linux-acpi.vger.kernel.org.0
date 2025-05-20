Return-Path: <linux-acpi+bounces-13830-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F779ABE119
	for <lists+linux-acpi@lfdr.de>; Tue, 20 May 2025 18:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689B31BA5DC1
	for <lists+linux-acpi@lfdr.de>; Tue, 20 May 2025 16:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA7A26F473;
	Tue, 20 May 2025 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abmimnaF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039A6257AFB
	for <linux-acpi@vger.kernel.org>; Tue, 20 May 2025 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759730; cv=none; b=mzXRNavPqvGcEGkc9w0w7faqaCxL6vGunwZh8aMkCFW1PUdLur2OEEEcsyDurze8FHRMeVlEDuqLnegSe60QyClFAuumX17lEamUStsdgp0FMKoIzLE2zGjjgL/KZzRKS1BgUNUGRrGJIiJjUxz3fu6ujZDJaOMrwgqe/K4bEe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759730; c=relaxed/simple;
	bh=DXtNUfWvj2BEdRTkqaOsp53rwbRczpAnjfVf3cndUS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lmJMl/cdVt9WB1+zD1Q4pzDeKGsTW6jx3mB5krN/TJXQ3YWgfZCz0PKEWF6GELbm6j7wYEmLJdYyZX/KqlZOhsJynwcO9gwhSgxp6BnC9AR8xjMqdFUEY9Rz1d4F03/JV49Ypx7OBDMw3Kh9o6KSSSuFGzaVKrz1HHNxhYnCSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abmimnaF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so47011695e9.1
        for <linux-acpi@vger.kernel.org>; Tue, 20 May 2025 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747759727; x=1748364527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX/xTTJv673giKzShX4ULe6HYBzR7J67EwT0wiQt9tc=;
        b=abmimnaFox8ihsUAZudXIPj7QN7a7m4bQdc6+Keu8OVDApJg5GU0rIHkXMLy9pt0tJ
         GzzNtHnpD2hKcSfgPkHPbddqwnMg2ZpR2GA3hX20Btb/GkHYSqQ7dzr48c9z+8W6qfEP
         6RmIKnRmKcKhIs8pHU1oKpRT644mA81IsetZDY+uXDlrcmo7RVSBGMPqqv/nBOtFFZVK
         7p6EBlPg/mhCJ6F7Gxm/3h65hvPCu9eMH2XOFuN8/kZ3w6TDTo+kPDdmGaO/baAeFoTz
         tAUbYbfZsT60ZU8kO7n//+4b7TDjSXelf2w9JZK/m/lDUT4IWghRI5qwPSBR5ex5MVCF
         TgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747759727; x=1748364527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RX/xTTJv673giKzShX4ULe6HYBzR7J67EwT0wiQt9tc=;
        b=uaGNCdY6DqTUYGKBnaoyuDYhvh1Ui69+JGDNhDYHdHiHdDVnOFV0VtJDS0vOHFIYfq
         qEPbFd+UpmAL0tdN5BmoXzT5tKNxVCgxb57zv0aWsLQo0cHosJ0nh15cz++Rvx825DJ/
         VJbXH0F0xj2NREdf+NJuDTCmWb0LjMPfai8drtD8OT/wNydi6RQKwdY9y4uakfetA8bR
         Fu2ZX+8cKGjXp9Wp1JXPTMNvzYMIWQv4nGoyYaH2Nb1gns7Ssl4Ou2p99ihUsZ09/NVu
         LzwMXSjueOFWydI4CItXAFzz3gF/levch2SdGMxLYUbQRz7nFl+ony5qRJQJr34ZOrNg
         ZHnw==
X-Forwarded-Encrypted: i=1; AJvYcCUc6p9zrvuRVFcsz08akHqiWTMfzT5qlylJjaj5bsreot0MPYsWGLXWcVWx3c4v1pD2gwJTOeyAx8G8@vger.kernel.org
X-Gm-Message-State: AOJu0YwWFZkgyd0znI0zz39KQ9iwkz77J09+pCyvpS/PSy1vrEX6AWHt
	1MNq0cUyylq4troK/unztFnkTjtdxn/J1z/PMNG9Wjw/9P8rp29SlG9D
X-Gm-Gg: ASbGncu+Br+M/+sKoClIIlLJw4PtmGqCl9rRmgC4FLtHb8Oq+NQtXYyc0ey7ZbDlWU/
	wsW2TFDFDETfXBTEyVyoifxRsKU/opRend1gqY0k3E1CZHFp9u/B5e4EbYcktig5b2Z63YOkyB1
	4fHwjLKmalWhp+wbEC8O22McAiDGZNOiRn9F1X4IzKyNQIHJf7E7VvCtHU4sdhugx9l4yX2AJ+j
	HS/1W1VFzcOKdwo2atqbVJ4K6Dkxz2YEUJXX/tq4QJXLqcqCi0xr+bAlQBfKAChYhblykFV1Ssh
	JOAWVpUlSzfa98Cmzh+t+FyZqUozYqkTmzg7Sx8cMI84D8YxWD9RILvyfzA+K20=
X-Google-Smtp-Source: AGHT+IHDT70S1ARAbUv6HAp7abwv12dONID6pWotK54QvtsjTevUA/NG27tOXymDxylQzVHpQdworQ==
X-Received: by 2002:a05:6000:184d:b0:3a0:b308:8427 with SMTP id ffacd0b85a97d-3a35c84bda9mr14099902f8f.37.1747759727073;
        Tue, 20 May 2025 09:48:47 -0700 (PDT)
Received: from localhost.localdomain ([78.172.0.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a364d2636bsm14306852f8f.99.2025.05.20.09.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:48:46 -0700 (PDT)
From: Baris Can Goral <goralbaris@gmail.com>
To: goralbaris@gmail.com
Cc: acpica-devel@lists.linux.dev,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com,
	rafael.j.wysocki@intel.com,
	robert.moore@intel.com,
	skhan@linuxfoundation.org
Subject: [PATCH v2] acpi: convert strncpy into strscpy
Date: Tue, 20 May 2025 19:48:13 +0300
Message-Id: <20250520164812.7689-1-goralbaris@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520163540.6893-1-goralbaris@gmail.com>
References: <20250520163540.6893-1-goralbaris@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strncpy() function is actively dangerous to use since it may not
NULL-terminate the destination string, resulting in potential memory
content exposures, unbounded reads, or crashes.
Link: https://github.com/KSPP/linux/issues/90

Signed-off-by: Baris Can Goral <goralbaris@gmail.com>
---
 v2: naming issue solved
 
 drivers/acpi/acpica/tbfind.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index 1c1b2e284bd9..5536d1755188 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -57,8 +57,8 @@ acpi_tb_find_table(char *signature,
 
 	memset(&header, 0, sizeof(struct acpi_table_header));
 	ACPI_COPY_NAMESEG(header.signature, signature);
-	strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
-	strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
+	strscpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
+	strscpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
 
 	/* Search for the table */
 
-- 
2.34.1


