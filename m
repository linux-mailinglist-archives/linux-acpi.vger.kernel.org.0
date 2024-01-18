Return-Path: <linux-acpi+bounces-2930-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063F68312BC
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jan 2024 07:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890B31F22801
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jan 2024 06:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B179471;
	Thu, 18 Jan 2024 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="UojUzUzv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE85D11CA9
	for <linux-acpi@vger.kernel.org>; Thu, 18 Jan 2024 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705559399; cv=none; b=WV7dBp/fIhsHkZhYG+8uLFLT3XZY9noPWS92S8Ntt2djNCgHQ+GdiHWYv+MzUNttd3l9W2jkVSmvY6XfJnH+47QG34H4aOQWufUJJFqE0VqsPw4gk3vpUdv7v/v6FhiORcSEAlKT9CkWQBZcDpir33iGWq1lu17kC/ikf0meCXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705559399; c=relaxed/simple;
	bh=s0jCrtcsnupGkX8Rh/JQOe2YBiR/JeRC946luu2mtS8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=KkVzdE/lG1JLAQxxMqPwLTITJLeWzDY+OciHDZYE5HC9TzKeA2Iq9IeEOJIWLRYhD1GQoeKTyxE8J11daetS24KBPg6Gf1gYo+rIki3nZZ5PSuUcD0uv9yBMtQHuM80vEYGujlJe/7T/H+DGAAeHC8dt9UDzAcdFe9aXjKhqekM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=UojUzUzv; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3608e1d27ceso42620925ab.1
        for <linux-acpi@vger.kernel.org>; Wed, 17 Jan 2024 22:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705559397; x=1706164197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtA1yi7bJhENd0OSwZZPO3/DRQ+e8frz78vUteV9MTU=;
        b=UojUzUzv24vzKx8LoRVUqy+GH3tnYvLx6nxhIdmKNRHtZt5k827VZNiTDqRLpaUggM
         0c6zZAM07/9NpdX3ZN890z4INf7iHl1L2+cT1aHcY+BIEHVSQ7ICMWiwegTJEGFIs00s
         562W/JY0SrDUTEPg1Gy36ZSGZRql2w8T7FhIbey8GsECnhweTWcIlEJwvNhBJOfATpXT
         u2sxvhrltg2cne/Y5X/dK+nlYe51jneghQxDxAaSujLJwmQhnGTREj7DZz5IAzW5hTLh
         TpZHbUuYAT+Nwouicz2cQqv25vFDdUfS+sX5yIp39Cpna8XMnIZMJrEcjjmGwq7aNi0e
         Ctkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705559397; x=1706164197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtA1yi7bJhENd0OSwZZPO3/DRQ+e8frz78vUteV9MTU=;
        b=WT11/GQGkJNi19EVPvTFuk2KWKVLi7b+lXzP4hrsZO5EElwDceHJRY+Ju3iuLyfLOt
         9MXOjVcVfzL2ZOUYy1BkiIzdyp3iTvapW2qT1Q0UUWyCPSMqHskKKrVKgyADfekeqcF7
         xiG/BEi4/mt2dputQdBDXjoTm1kVEpB5jAmiqhllVRwB6njZJJzIzuVG7FE/94FZSETj
         AprNDm/XdJzKyHyudxyTFhPZ+Zq/9YpkUy1p5WVeaNUU0nuPM/fOawjLieo7kWMVM99o
         lsMfxGI9y4OJo0g05ACpKvxS7NAN657l/f9qiEiPOXLzmpazA0mGuXBWgDx7UjkAUmWz
         /NOw==
X-Gm-Message-State: AOJu0Yx7qxRM1fnNAJOkROd7q6PPPfvVNw1NafQMXEDPbYxkID0UWOYm
	6MzekzESkrr7sPyX0yl1hWHeAzQQSOAfxiGSgprapJLJPsubDTTAFkIyO8T0zPk=
X-Google-Smtp-Source: AGHT+IG5FtqixEBaNJDSNquSyctMTnCf+hskKjTKsUAyOqYtmHJhBUoYOvToNqCtx5vuaVjQy/gmAg==
X-Received: by 2002:a92:4a01:0:b0:361:993b:7f3 with SMTP id m1-20020a924a01000000b00361993b07f3mr523402ilf.11.1705559397011;
        Wed, 17 Jan 2024 22:29:57 -0800 (PST)
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id bn28-20020a056e02339c00b0035fec699584sm4663269ilb.13.2024.01.17.22.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 22:29:56 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v3 -next 3/3] ACPI: Enable ACPI_PROCESSOR for RISC-V
Date: Thu, 18 Jan 2024 11:59:30 +0530
Message-Id: <20240118062930.245937-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118062930.245937-1-sunilvl@ventanamicro.com>
References: <20240118062930.245937-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI processor driver is not currently enabled for RISC-V.
This is required to enable CPU related functionalities like
LPI and CPPC. Hence, enable ACPI_PROCESSOR for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f819e760ff19..9a920752171c 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -282,7 +282,7 @@ config ACPI_CPPC_LIB
 
 config ACPI_PROCESSOR
 	tristate "Processor"
-	depends on X86 || ARM64 || LOONGARCH
+	depends on X86 || ARM64 || LOONGARCH || RISCV
 	select ACPI_PROCESSOR_IDLE
 	select ACPI_CPU_FREQ_PSS if X86 || LOONGARCH
 	select THERMAL
-- 
2.34.1


