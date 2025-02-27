Return-Path: <linux-acpi+bounces-11552-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B19A47E01
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 13:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EED16325B
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 12:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CD622FDFA;
	Thu, 27 Feb 2025 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lJ0OCCkY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17606233157
	for <linux-acpi@vger.kernel.org>; Thu, 27 Feb 2025 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659847; cv=none; b=mnUZMGiTpSPHYLQ4jKUx74+le982CjhFKBmoyT4nSPHkpG5RK5+DgXO6AAWCtomGiriwhLiKyB3EHrtdwGpMXEXiU2KWE7DJ/wJB0RlqEmF+Oyzz4igVKyFp7ZJa+slZYk5ONzVImIFFJVoAzjCl8wdJZKWY+yHqgSCH/pAgCak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659847; c=relaxed/simple;
	bh=Of9PqcRio9hOrtrXaK3C+7d5d06uoPfQDo/STc3oCQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkCyInq0kvnh0AT5oFn46fdvLYd5+5wBquGoBeTWh7s+YPECjKvknxYSGJJlVjMdKrw8jBFJsqGeVuGGXC5MEFYky1U8pYlbZTD8blDZ6+xzL1HO01eYYir0SHxYYuS0pzch22i8+uKs95nwGhYPH12Zeas/PtYXSxlxIVhyr0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lJ0OCCkY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220f4dd756eso16024885ad.3
        for <linux-acpi@vger.kernel.org>; Thu, 27 Feb 2025 04:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659845; x=1741264645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcOi1q1j+KD4L6iG3zLb6+WxKLL1t6DJV3NbpeiJXTU=;
        b=lJ0OCCkYqSPgtJ4dZ5CW1e4TJpEUkvQ8TruxrJkxp+sYc4S39EiAnZNewqSQbILB63
         forlY5KP6QqdDUb2i/QCV018Kf6KZDc/9RmNfZL/xnF1qeyjPRsuQntu7K4iaXuYSiWi
         /rgckz/qfXN8oAOVC3D4sTS+u0wkLMrUEyrQELnMvSqclFHk8aPKkBe33fUaSy6d8LdY
         NxctfU3nxHEAcCa+GnEoMChDPAO+omjxcXTTDegi8hEZ6AVchmfwBetA6R1ESy7x9TRR
         AuyT7nVDMfN8y6RwWEdGWQi3EUQtS9guYWx6uPBuM0gJnITHIY0VidW50RM5rXrobUun
         Mf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659845; x=1741264645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcOi1q1j+KD4L6iG3zLb6+WxKLL1t6DJV3NbpeiJXTU=;
        b=gp84stiSZM34ErAJCAKiCThaEGXaZwtfW/i0jhiDW/S6iqGP1XB+cZF+KSpCt6g9Lg
         g68/6fkuXcRxYjoueq8HYx9KRuG2nlpbc4H9ALl4JGMbJptlu06K5/MFuFsoscTfhTpA
         eTf7+pV+gaNEUmAYeNX3UT94A3Oc6kgWdUx1/vSqQd+k/9QzjtMtlIVX7pLQ13WMBlT7
         zonNh6ZC1UyQGyOviPeCp1n4p1v/Yn7qtG7YacwVA1QZowR7qiz5VuumP9Oh6LFcOSHL
         GsU2s1wEZEJQfb7x/n4f11ZbnNrgK18OWy3aoxxppfmheSwGf6VdBVjFdO0MwMZ4VXxa
         Wq2A==
X-Forwarded-Encrypted: i=1; AJvYcCXKKcVspV1phPSB9bheyjvSD5aPQ1jKi1Fk9SjHvAYf99hn6tR0WCtfbc2jedv7yWMvCjfDd0p0dZ6k@vger.kernel.org
X-Gm-Message-State: AOJu0YwqlX906Mp2yqWD7wtnVXkicZK/EVJQ1G3VveRBlvh1wCeYNWJY
	/zkd00ce4dtrwVBulPn8UndvOFtH2073JX9+l/n04zxsIg+Jo2xwDUssx14x9ON3AxFu9p9eKrx
	PM78=
X-Gm-Gg: ASbGncvbLrhGa7OxRB26tiAzIkpXdo4thvZ2dzOUZW3M44rOtpvXFH7s51A7C1wOh28
	U9f9EUHkv3k6gAAz4xUu7PpPUeZO6hfl7OiiH0Vd5SAq9QXkUml1S8OqFqR9voZaiiRSCwl8BbF
	Jgid9ZtkotpfoNcTjjjcA238tg9krsiCuKsbLKxrmLHDi4+D6k3IsKlThrqFiSaU47imSu+rh00
	xs9LFgNthHNGF1bik9QhThJ2f1oAv3lkYwIy0Wut2CZSEfByhaXwnjugmerd5djyojFiUSJr+Wf
	gDPfKU9VbF/hebWpcpbhfyF7VK4a8sYyVxCx
X-Google-Smtp-Source: AGHT+IFpHziUTuaJEINi+EgHoRKrGPAz4AsnUhhSqo24MLZ7IPH1ipJJRVjiescHNO1qawzm+Z45XQ==
X-Received: by 2002:a17:903:1c6:b0:223:4a10:311b with SMTP id d9443c01a7336-2234a1033camr48544315ad.1.1740659845617;
        Thu, 27 Feb 2025 04:37:25 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:37:24 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v1 09/10] riscv: Add config option to enable APEI SSE handler
Date: Thu, 27 Feb 2025 18:06:27 +0530
Message-ID: <20250227123628.2931490-10-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

APEI SSE handlers can be enabled/disabled with this config
option. When enabled, the SSE registration is done for GHES
entries having notification type set to SSE. When disabled,
registration function return not supported error.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/acpi/apei/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 3cfe7e7475f2..be1eaba9b093 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -45,6 +45,11 @@ config ACPI_APEI_SEA
 	depends on ARM64 && ACPI_APEI_GHES
 	default y
 
+config ACPI_APEI_SSE
+	bool
+	depends on RISCV && RISCV_SSE && ACPI_APEI_GHES
+	default y
+
 config ACPI_APEI_MEMORY_FAILURE
 	bool "APEI memory error recovering support"
 	depends on ACPI_APEI && MEMORY_FAILURE
-- 
2.43.0


