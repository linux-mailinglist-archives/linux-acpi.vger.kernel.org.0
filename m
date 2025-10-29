Return-Path: <linux-acpi+bounces-18318-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD30C1A0F0
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 12:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26C9402105
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 11:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E103335060;
	Wed, 29 Oct 2025 11:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Vkte4XJH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12582BEC53
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737247; cv=none; b=s3jWB1q7/0WrAea7valO+7oWLEHf2d4dBKoGS0Ss1ltQgHTW4F8QWy9F1hYu/aJpMXmrI6qpvuxL72XOJW24ZyZiNf/V+b8Fm6gpgn7eYJn+kCdxYHK5XesgulymhhqT7dl81TkeIay/9o2kJHnNlPno5t9wSgQ3uVW3KK3uJTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737247; c=relaxed/simple;
	bh=fk1jo/sIeI52ZoZ8R5y44DiLeZbX3mH6843B2DjcmcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGwjUMrwVAflfWK4TwWFuGtjnuQhQkL9dQDHeK5qLSZDUKTrhJjadyJpvtjXBzVPIdBjM2dK6J38VdlU7dKPS7NdYqe5XF/FZSCoRyxcn7HR40wqwYZyTcmShfw8qLO7N0dGvcGQHDrRITYTX7X80EQuwsndFPa8hsdDDYkkaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Vkte4XJH; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so6648034a91.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 04:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737244; x=1762342044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVrGZiCOO3VoWU6as4Ya4YNojK7gFL/5DgKPuB9HXfo=;
        b=Vkte4XJHdQ7ORuA8Lc1UhIpabVmbOk2guYMjbsJD+e4TKmOwbkVTqBOodEFa1kzeb3
         i5pY/z+AiUiY5c94cjBf90bRiI59wOaKUqb5Yl2s8rbGoIGxXAKOE+s82JBB6vcrdvL6
         mrd5NU5a6p9oqTVAo++He+73fovBhqeWxWL9TR6mJIRQ7KQ5UVSOXkvvyyolFOIMUg7Y
         DiBOOvK66RVcgmAZ6FTDdOBDbfZxY9wnabxor9cl2hOJue5wmpzMi28ZR9R2AHzd6J81
         FD2h+v5Q6zcQKLCNb5YBSnFIqOmv+1JEjj1Whs7Cdr8Uo6Sq0O6A7U5A/UYKd5c8N5Pu
         piDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737244; x=1762342044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVrGZiCOO3VoWU6as4Ya4YNojK7gFL/5DgKPuB9HXfo=;
        b=GVkcOWzHkd8M8A0CazkBvPDobQ/gTumTBtCyeSR+ZJ9va41KUxj7GGzHa4EjxjH6xF
         FBLOyhdpl2YC0yXD6Vjnmtr1yYnletnEHFHLxIJZ/6Kh8v0TDxbOJ73ffWkPW6Ul/d/9
         6zrIW5japAD7PGW4Mb9KKGGATtUO9eXA3fs6GGCU6wCOJUY/U1ZtK5slOPbXcsNhDXDc
         AkjtgxCHEW3UFXcVi5W6PqcQCMCill1QdiuW6bnVLH4hvaZgFKFIHp8OJK/yb2j1SZr+
         Ghgj+ZOjYcfQjO8da9GQW6E+oNrf/HqUH5dutMuClTjqCiN52n+Ziic+V9z/nZPht6kZ
         8Vgw==
X-Forwarded-Encrypted: i=1; AJvYcCW2V0EZ7HBTNAO/0xlVUYrSIrUI5Yx67rLRMKmD6L8sVGZJ9FrM2nfgdMfVSfR3Gz9xwZNjrTmMUIm0@vger.kernel.org
X-Gm-Message-State: AOJu0YyQiIH0T99JHJIaISr504ItI5vo6ZNoBGNrHUpygdq7DTFSTvCB
	6dMYorB2zBrHi/Tl9hTsVQemdb6aLUpnM6GXQqeOXLGVwq+JTtxL3Q4xLOy0Ud1je5k=
X-Gm-Gg: ASbGncsgq1Pe4AJDl6ksziwWQzKGJSk/aUl5zMy20mW7rc/gAdGt/91UEGR21ArHM2+
	5ydeaoa3iwhRN68U+gmL03t1AYnQg+zwBtcIc7jGESNs28VQMtppw6CyNq+PpkJ6tf9ljGtVcse
	Ox4sEHPjUjzzm605BRbNAJRejsmEJZS3eA1pnosPJWLWTDuZ83HEgm3DgIsXvJd+Mp8wLTVt7xY
	UjtQbmXo59lr6/A+Dql5o0VYA1AxPjQ2VXoZSLuz193vu6vgdNnaxN/HW0KAjXvr94WOSACNlV2
	O76Rd0UGuVk8PcjIis4JEeNE+Nhm4aQPeQZquCkUrG/YbaqOvGbVZ1ZgsuSIVDovLNWgc5VeEXs
	Ze8uT7eFVxavVQVNu2nj+41txFjX1wjNwo07HLSATGXKWnnKFGJIOm4flNQ+2v0h2elUzOEunGa
	4YL1E1GS7/sl7/+pEcAHuOE8l8sXsM
X-Google-Smtp-Source: AGHT+IEs0ZClHYQ32GXBT6VvX4hdE/vTZzW0dkqblsfwRDrg9bIgaJQ8u6BnX6Q+OdRAzRPJ5EziSQ==
X-Received: by 2002:a17:90b:4d0b:b0:33d:a0fd:257b with SMTP id 98e67ed59e1d1-3403a2fe511mr2861483a91.36.1761737243889;
        Wed, 29 Oct 2025 04:27:23 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:23 -0700 (PDT)
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
Subject: [RFC PATCH v2 04/10] riscv: Add fixmap indices for GHES IRQ and SSE contexts
Date: Wed, 29 Oct 2025 16:56:42 +0530
Message-ID: <20251029112649.3811657-5-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GHES error handling requires fixmap entries for IRQ notifications.
Add fixmap indices for IRQ, SSE Low and High priority notifications.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/fixmap.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 0a55099bb734..e874fd952286 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -38,6 +38,14 @@ enum fixed_addresses {
 	FIX_TEXT_POKE0,
 	FIX_EARLYCON_MEM_BASE,
 
+#ifdef CONFIG_ACPI_APEI_GHES
+	/* Used for GHES mapping from assorted contexts */
+	FIX_APEI_GHES_IRQ,
+#ifdef CONFIG_RISCV_SBI_SSE
+	FIX_APEI_GHES_SSE_LOW_PRIORITY,
+	FIX_APEI_GHES_SSE_HIGH_PRIORITY,
+#endif /* CONFIG_RISCV_SBI_SSE */
+#endif /* CONFIG_ACPI_APEI_GHES */
 	__end_of_permanent_fixed_addresses,
 	/*
 	 * Temporary boot-time mappings, used by early_ioremap(),
-- 
2.43.0


