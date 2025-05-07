Return-Path: <linux-acpi+bounces-13589-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3039AAE468
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 17:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1E74E76DB
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 15:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBB028A1E5;
	Wed,  7 May 2025 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDeX0HAZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2A2289358
	for <linux-acpi@vger.kernel.org>; Wed,  7 May 2025 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746631252; cv=none; b=MY4XUOxJamnJyqZBdnLVmKi1zC5os18fRVdEw7KAFpIOcqWSjfkAIvQqrWFC339eBGQBVApuzqKw8fRicbGVP8LB6wnRq8bv3Eg9s9iiC5Zn0fCKuD6t7iGYZF1dzpwfnug2dz9axRpwgYsSCBj4UdVF4Lo7N7Q4Xk543Kjl9Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746631252; c=relaxed/simple;
	bh=Q/4cDy2daokCHRuAKMI+zYNWvXXLfIv9JvBRagRcqMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BJQV4XcVXP0rh92BhABwGh1GjJ+VeQiYWUMwotrP4BaZ6qMPDQXpGs4LDUrXJ7mOxS7B4YBtNpSo+7xK1FnObOe3WA2jdVpsR9y/nOwoG2GAUdC+SQEJoMM0iYU8WJkklbqAKHbjum/oqy3IiQwds6SCRHTm842lSmPTYk58Rwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDeX0HAZ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac7bd86f637so217603966b.1
        for <linux-acpi@vger.kernel.org>; Wed, 07 May 2025 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746631249; x=1747236049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=86P87XsBGCoqJSisq9XyUEwQyZoFsxfiJg6l7nSj/Yo=;
        b=fDeX0HAZWjpC4nsKy3pUJnuWooWvlYseYzIgLMTWMKd14vSEfQUs0qiOBcxRL2Dbvr
         pxHCKXEbkVeC5BT5eV1ccYkREg/kn3d7Glf2GIflqmTyMs5Rm2TTnUvtmjycwaoZ3TlY
         AEM87aqi2mY/RpjxNumwkImyly1MbVbM+89LgGKZfSBlhy/7ZjX6zrXTjznPSF8mdUia
         jLN/ST2m8Ycejzpcqi/dFieBKpdFt9LSf/c3LLX74DYRWJ/US/i8YIOPqJh26Hg02dHg
         XGqE9xXZhMs133okkD0OO4+3BrIkS34rfVlxq/7V3WUVqg2zi8MWkXT/OhdBXhng/4UI
         vB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746631249; x=1747236049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86P87XsBGCoqJSisq9XyUEwQyZoFsxfiJg6l7nSj/Yo=;
        b=UkQ6XhqP/8ptdg5xi5vxPv16begkbADWLv/yF7JfEl8SNq3zcIH2i7wKUGHbqkBNFC
         HVa6TMtxBascbp+DaAxz+NCo8eQLk/fu2+e4GRKUog2a19N0k1rTxLoTG/QusJwsUK0w
         LsMB2qO1gPkwADEQ0tFvxUyG8DN7I43LMR27YtweRQZ0Ywm8S8IoO2F7xT1kIwAUew8Q
         4wPnLEq4rtl820XHL36YMDh8EAoZu0i3QZCEOsgWq/3R1iRmHHLrSQZA34TkHnTFJgW8
         9vR+sfpQPfs4V19NoguX/jhPqwIwVUW3TATQbK08JH2q+CrAkGxRInI9cg5mKPINZFeB
         OBKg==
X-Forwarded-Encrypted: i=1; AJvYcCWMsbOX3NYRTeAtpWSN3p+7Q2vuLiBUzd6UDIzepZgzMCbV3izJCbFmiSG2lt+em+Kd04KDG9J/5d4L@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4FypaBjMnbFOOO6+wO+r7168xwdy0p1sFyfBJpF4IAZoPnI20
	WBtfWlhK4J21hFhQXM79zURdjq9jZ1Pjw+JqUYVaZs7G0rgN8jJo
X-Gm-Gg: ASbGncvnp2hIRt9GkgqehSx7jwi1fH/xRx7ddAuJNQIke7p/o6nessz/SC7n2yfZhZa
	q1FpdyiK/taoFVWzIxo69qstIUYFmHUhZY2n+SjYtvVd5eHfByCpVB3fIONd+THxE2cumxLdvM7
	K/WIRFZHc25mJkECnClFC7xtG24Raz86wpWWDg9LViL5tDoYgPUgYSD7kaXrcUvIgopoOxNUWKR
	zOtYGyTnlNpXF0E/oc0+QYn+M4guvUsvfFUVzRyMJlrSgGcSJb2wlUGlxOU9PWM2SCuAv8pG/Vu
	RkVEjGvM8GMUPAjRGQaCVElPS71UJk+HbsJJ1OIm5tFgxs0rMQpp
X-Google-Smtp-Source: AGHT+IFJOz+hM/atyuzW8Ro4vxwvTSN7B5TcW5gFCeQ7LS04K1WokNMsqUcdXI0V9aKqtcXIJaSPLQ==
X-Received: by 2002:a17:907:3daa:b0:acf:dca5:80f7 with SMTP id a640c23a62f3a-ad1e7974c37mr352094066b.26.1746631249142;
        Wed, 07 May 2025 08:20:49 -0700 (PDT)
Received: from localhost.localdomain ([78.172.0.119])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fbf7e57ce4sm837530a12.35.2025.05.07.08.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 08:20:48 -0700 (PDT)
From: goralbaris <goralbaris@gmail.com>
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: acpica-devel@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	skhan@linuxfoundation.org,
	goralbaris <goralbaris@gmail.com>
Subject: [PATCH] acpi: convert strncpy into strscpy
Date: Wed,  7 May 2025 18:20:45 +0300
Message-Id: <20250507152045.12266-1-goralbaris@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strncpy() function is actively dangerous to use since it may not
NULL-terminate the destination string, resulting in potential memory.
Link: https://github.com/KSPP/linux/issues/90

Signed-off-by: goralbaris <goralbaris@gmail.com>
---
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


