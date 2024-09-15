Return-Path: <linux-acpi+bounces-8307-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B0397982E
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 20:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752DE28147D
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Sep 2024 18:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B901CB535;
	Sun, 15 Sep 2024 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPmRTXsM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC0B1CB526;
	Sun, 15 Sep 2024 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726425563; cv=none; b=OQrgp7lhs2ZVSEXUb0s2BhnCOhauAkQoI3MEvPvPuQLdRiBGXVdnLsqdyhF3dCneKD6P9FRg9OM/fPm0T/H2mgACA3TfMdH+pgjt4eMG6S1pAlstqcmg4jVuyGhfQSaKFKK9bBzjrjDh+NF43llgal1pfYpx53DvMVw146nzd2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726425563; c=relaxed/simple;
	bh=77ScDo/H8XfauKgfDfyBcDt73P5mP0LNk72Aymjn6vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1OoJwc0+HgjPD7Cl2NKwlhwbb+ijE4xWoqLIncf/wWHKwGsdprFGxW/BAX2Jg7UJOZIpE8F8opRKFfX8ieNyd+WI3NMA3psmxiv8oQheTEiU8ylPgKcypK8gkshuqoY/YEPhfoEdtGEyAggkh7iABq4bCMSb32Y9LfTAoy+hU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPmRTXsM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so6366455e9.3;
        Sun, 15 Sep 2024 11:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726425560; x=1727030360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zJjfctgmHb5rq29kJFRVJL5UzIqHrkvzW9kdGp1IUQ=;
        b=QPmRTXsM+Nt072SymxALoktiY6nDba3FUrqZ7RZob3h8RLWi79WrOyOSNESdeQ8wFy
         Kr9ourRp+j+V5t2rrEq15nQJ7rgF2BUAeaIIqfVfjgoCAO8pH4AeSg9RBxhdxD8Bj8xZ
         3nGBJoqiRRgvRDgfDSvJPV3x1KKK0dZ3Eum7Q4WG+yMLl4lcN33Bc0qcMrf17hPpcnz0
         bu/RfiKEIgFZbfeb8XnaE6tUm0CWY8e+5WwQtg/X8Y2E6vsjP988DEDMk/2P+FHEefUb
         AEVtM+fYX+u/p5ACo29IyBnMS48i1KnJeROvN5eRrDpA4tNf0y5EMFceeU6Mloj4hGw6
         17SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726425560; x=1727030360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zJjfctgmHb5rq29kJFRVJL5UzIqHrkvzW9kdGp1IUQ=;
        b=jmDEY9j7uFwNi7be/uz3pCOKGREUqPkH7TWV/PA6sxmH2Ln1Kvr1J/p6eC0tuicTEG
         q4HffbUskfajuvEDJ5FdmoZSFqPIeOO4Q9HStbA1PcmqlJu9g68XNYCdpeGltIHK8PZa
         6l/HR5CzYT9FRfeq1caZZBLev58Z3Zqbv3oA4Nqw/Cf4f3ZU5PmF4ueABvaA8Wih2jPT
         uDmALKJee4UcMbU87KX1NtCQkg/BImYCoCreW7edb9Gig6KQt3+8cv3CFcwDfzyeHXwL
         IshefwizLt6xYDElidxIQmyyB/eV9JnNF3MCik7akXt/Qg2YUgZAN8q2aBkmI5ukIa/0
         TSew==
X-Forwarded-Encrypted: i=1; AJvYcCUxV86BUq3B8rI53nGSoBeWi7jyJSZdbDzyiSA2rPfG4H7E3i4F3IDwb7/JNxDveWDAxN0E/AFicn9dWgTb@vger.kernel.org, AJvYcCWngLqR+nrHiM86C5jB5yaIN2eVOkn/1XZnHVjCNoF7CVmCrWza/5GkmvcxWye3aKhXJoa9mt1j3Aim@vger.kernel.org
X-Gm-Message-State: AOJu0YwjJefg0uwIAdA5m8t9fnyawCZ7qdFRU7ZNM3gcZnIf/XlYAyjw
	eUv+lHd+POwPYZq3Iy12X5m6IkKxIEZQjqhzXThRxRQ1SzoJOk9y
X-Google-Smtp-Source: AGHT+IErZTgyigxk6edPyw3No2PEfK3oK4pb+YmwhvE0s1hGJ1HE5N8zJQsBSnMW8V18vCJUHr8vyg==
X-Received: by 2002:adf:8b9e:0:b0:374:c03e:22d4 with SMTP id ffacd0b85a97d-378c2cfeb7amr7213531f8f.1.1726425559993;
        Sun, 15 Sep 2024 11:39:19 -0700 (PDT)
Received: from qamajeed.Home ([39.45.198.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f2001sm5162357f8f.48.2024.09.15.11.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 11:39:19 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH 08/10] ACPI: sbshc: Use strscpy instead of strcpy.
Date: Sun, 15 Sep 2024 23:38:20 +0500
Message-ID: <20240915183822.34588-8-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240915183822.34588-1-qasim.majeed20@gmail.com>
References: <20240915183822.34588-1-qasim.majeed20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strcpy() with strscpy() in the ACPI sbshc driver.

strcpy() has been deprecated because it is generally unsafe.
Eliminating it from the kernel source.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/sbshc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index 16f2daaa2c45..7e2ddc74a1f0 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -257,8 +257,8 @@ static int acpi_smbus_hc_add(struct acpi_device *device)
 		return -EIO;
 	}
 
-	strcpy(acpi_device_name(device), ACPI_SMB_HC_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_SMB_HC_CLASS);
+	strscpy(acpi_device_name(device), ACPI_SMB_HC_DEVICE_NAME);
+	strscpy(acpi_device_class(device), ACPI_SMB_HC_CLASS);
 
 	hc = kzalloc(sizeof(struct acpi_smb_hc), GFP_KERNEL);
 	if (!hc)
-- 
2.43.0


