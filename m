Return-Path: <linux-acpi+bounces-15013-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BFFAF88D4
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 09:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CDB5875E1
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 07:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AF127A90A;
	Fri,  4 Jul 2025 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IWf5huiw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0777D274B56
	for <linux-acpi@vger.kernel.org>; Fri,  4 Jul 2025 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612921; cv=none; b=EnAopTDiPcRGjnuKsv6PjHeLfkNey4oR31gXluOAX616SNu5vCqcOUuJbRjBz44uymWCwynq2QCu11dOXmCmWR3gIZSNiMmNjqTPnMebJ6pCA6yyUZancphwkHgKirU4dUEP2shMtZPS7+OBU9EL/fg9dIZvmZ30vYOj9ixUKq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612921; c=relaxed/simple;
	bh=do4xgD3FIKiBFCXHybdwqmJMFTQfLzd5+SYEVnCmQ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfYrpe+i62fXN1I5bWHaKv5L7YCBFPLM2mIxkk2Ez/xErDMN94I5Y/rs0vaGusAE0iPxzxJZyUEUYT/vEgM1z5Hv54/D6NpqLL7jlxgwOPd3m5TTEPpcu1oWd6VIFKGa8XWkyIlDzSiascX9SBSBpB8KONGoqC1P0sx0eTQ2h1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IWf5huiw; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b350704f506so548275a12.0
        for <linux-acpi@vger.kernel.org>; Fri, 04 Jul 2025 00:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751612919; x=1752217719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCKZPLGMv6q3Gia2CuwihlvGGifXlgSwREijf4CMFzo=;
        b=IWf5huiwWzkoa8wsImGVBJV/Wr0ARIJuaNOjJAFtqi528ROAWGlfuXjbz7OsP1YDnV
         22aFTskteYo6bXRti8lFDxdrGjqG8BWUOWaKQkqnTRrhNiii+1AeZWvJBOGYtCnHRZGC
         Vk7Z2aY8tQkWLfiDvngHNLf95BEkCtsnUciVxDh9nURto131g9qgE34kT9r0xvIT+gnf
         Mj6NfuXDRC+17IzBizdezLUFRi29emLbCjt3SG23wAvTeKo3Q/A5wQDgeNv4Ub4EiwHM
         LvFN1+PoNyfNekhMWXTWKqB6Op4LAKRw8MfseDvqZeuKgZXGh8bYggvbXYEcUh3TAEbY
         smmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751612919; x=1752217719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCKZPLGMv6q3Gia2CuwihlvGGifXlgSwREijf4CMFzo=;
        b=kTXESgHBfoYojL8A3nVz0FyyvrYytdllBBLdcJOcnvrAGmKk5OWq5Kusa2krurfOmY
         olVjraXh03Dt3yWmG4wHfUn5OWw4JjhGqcArxx8VZulL6WRWBEvEUZAyexthCobtQfMT
         duXnx8pQ+/4/qySdZJNQGTMf24RzzhAkOMfqMc/pxZyi43nWHo29W1Lh/8HL/3rszZWv
         AZ+1w4elVT7i/4PQVJGV/YcNSZqhnlwXup/VY+/0EKzAV6hY2zfNsDX9WXJHqmYM02G1
         wm5wk+cOojtkkrft3pUC2VmcJKxAzIqVrq3X4L6HasOWApr/AQelkrLO2Y80WwDS+3VF
         6oLg==
X-Forwarded-Encrypted: i=1; AJvYcCXvP+dEY78A79+kOWzarfpDoWEYepaIOHtvWO5EdGK3hb6KtDuVlVIQeNEA4/eJDGDeyDDBlWoCTCMU@vger.kernel.org
X-Gm-Message-State: AOJu0YyDafmn/4B8ipMH2Vh+6bNucxnLBLrasiBEm4pSHUOCc8wetczN
	kdkcCJdkdvCr0pkhUHhj22shxB7tLCoZ3zYzBAB00JT4v7nRLpXGufQsDbCaFc1eBUM=
X-Gm-Gg: ASbGncslsfkssyZ43ozySG9JXXkKLmWVYNWtcw0/Y36tudBOTnjIg9JYZSlsgc/Nd/b
	f8Vr/HUVR8VHWn0y1Qg48akZRT9HkHczafiy4bXqAz3ILneMndLtitWsEAWoKtRdQh/u0fagDzK
	NKyo4UgX2QhwWig/arnQCrwDt5gVmNBG9jQzoZQUwnv6Z15PuaDY79LG+k4bolioMJ4SvWpRQVt
	zgNMhymATRKu7A6cGGvPwzToAlOsBABkUYZFbeK3QsLGeOmUXiuliKCb1v3iuVV4PqCyFKvXCOw
	ZJlc3/G5XpLBwhF6JE9vjAl3ufN96RCblacRfSmAbtqLsgvgkHo6u7WdnfVBn/qitpEAA1poWad
	6/j7sLx6ZzLl3A28Ivy2GydnNKQ==
X-Google-Smtp-Source: AGHT+IFZBNddecKSRV25p51oDjtdR2ftq1DYNinGTFvu7tPEIDtFUw6AiYcQq2JjuNxEVU+rdRoXSg==
X-Received: by 2002:a17:90b:3a05:b0:311:b5ac:6f7d with SMTP id 98e67ed59e1d1-31aab854e04mr2651722a91.6.1751612919264;
        Fri, 04 Jul 2025 00:08:39 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae59a93sm1358697a91.12.2025.07.04.00.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 00:08:38 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v8 23/24] RISC-V: Enable GPIO keyboard and event device in RV64 defconfig
Date: Fri,  4 Jul 2025 12:33:55 +0530
Message-ID: <20250704070356.1683992-24-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704070356.1683992-1-apatel@ventanamicro.com>
References: <20250704070356.1683992-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPIO keyboard and event device can be used to receive graceful
shutdown or reboot input keys so let us enable it by default for
RV64 (just like ARM64).

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index fe8bd8afb418..bd5f97e1d1a0 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -138,6 +138,8 @@ CONFIG_MICREL_PHY=y
 CONFIG_MICROSEMI_PHY=y
 CONFIG_MOTORCOMM_PHY=y
 CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_EVDEV=y
+CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_SUN4I_LRADC=m
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-- 
2.43.0


