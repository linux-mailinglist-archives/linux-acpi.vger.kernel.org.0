Return-Path: <linux-acpi+bounces-14915-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7B4AF0A99
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 07:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E445189DE02
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 05:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E73723C518;
	Wed,  2 Jul 2025 05:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="j6qTJYgW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3803B2222BB
	for <linux-acpi@vger.kernel.org>; Wed,  2 Jul 2025 05:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433424; cv=none; b=WpedpY07lDjbC8/Hnep6R2RFsCZD3Fc4RBJ5kBuL75BH0ssA90b1E5QRCsGmGL5xuRc0raYIW4zc2exFjfalBg2CrbX6jpNaCqph5kPm7plcNKnA0yeVDdl85cyTkmvjUu/f0SDTnOWB2+3jNWH84FY5D9wtt+d5TMg2yJHuT9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433424; c=relaxed/simple;
	bh=do4xgD3FIKiBFCXHybdwqmJMFTQfLzd5+SYEVnCmQ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvxaTW8giAdHurmTfVs0xEK+PIpH0EcQ8Sbg0ROV7ddojcZYP3vAi+oE5a/OWn2R8U3G5dH3wat7xdwZi4uRDf2ZrSHDnPtBkCXMsDgYv7277Wk7mubRIstWf3lotLvYLE/I5eLRRwMJZ5hnBYgXBD6iu+wkNpaO6oGqCc0QvfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=j6qTJYgW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-236377f00a1so65066115ad.3
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 22:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751433420; x=1752038220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCKZPLGMv6q3Gia2CuwihlvGGifXlgSwREijf4CMFzo=;
        b=j6qTJYgWn7Bn4SY4oOXUfOx7Ll6iG61yqpCkufzYBsuXoBQjCSrnvR49A+Sxtkw6ld
         U1rJ4u11AOYlvn/kqE1UMy1H519B6+ZZowWg14NQiVAoHqipUewsMuKnHo2iguVkTKPZ
         hOdK1Dqn2sa3Bm7OBw1tidJ0EFqS5gE8W6svzOffBZKow9XGx4dRPQhJRJF7piCgmej6
         gz1u5bdkGuFCHmbJyQjQmV7uJ5uOd8uH4UQk4Tds4HJ0uGoLaKfMU8qg1ovwN3QpYDc3
         D+Pi9szeu2ibS3HsxpqMX5GFJnLo5BxpkARLGjFO2e92fELwMxyxpMV6Ki4JwVkzDZve
         NhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433420; x=1752038220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCKZPLGMv6q3Gia2CuwihlvGGifXlgSwREijf4CMFzo=;
        b=X8iy18unBx3MrQWeFW/m4tA9C1E0i0BfsxixqhKCYHq5qADzuuRGBvlTvP/ilPw4uA
         mjG+zUyj2VJ9JudmcQfKTVxtQzcGWN1cBOVuQwhDjF0Sb0UP7jv1mGXot8FuhCKNoMBe
         XWdzaNuapilhxDXL6rs2Y25zz+9PDtdrqqyOlWKs9QPwh+IrdIU8G6h5Dzhsoc+NYbYI
         1XYHaLHzQ2ttJ0NaiET8CxtRCg+BoXDFnYr2N9Y5Fn5DmjWIintAx8Tt0/49yM69OdfN
         Ce/sTBlQppjRv/Wr2uGoURJG4dwoh5MoJZae0w0oGvCR20C291E21pCzHPKGar3AeNGx
         GVVA==
X-Forwarded-Encrypted: i=1; AJvYcCWf78Kv/Hh3Cuxwyv3V/pPe8GQ22/kleV+2mgxaP8WIa3lU2koUci43gzFUasWg9i35c9zMRx/yVnBu@vger.kernel.org
X-Gm-Message-State: AOJu0YxmK3oOToGz6ck9Ue2VQu8eLiTQ0ozBLk9StxhQnNG/EuNS/XTX
	VwwCHaii8vmkdguCHEp8l9vPSh6UURzqskpUinl/n9DcLmKqNmJMJ8yU577MQP+8wZQ=
X-Gm-Gg: ASbGncu2gKRbQ/T7S/qSQKr0JuPq8JuWh0pprFt+z+QALdBsnhZFFnlb5SbD/60QYj2
	xKyRTBB0sO2Y7Si4xnwIDAoCXck9utdqy8tCOgz3JQ9ZJOYMckRL5rAckiIE6C5izMPKITXhJw4
	pAgJ+BR0KB6YMENbDLN/3bGhoVDpiNS5ALQa5KqBX5FsEQHgQ9hRsLr6OylT6ZAyhvYSwkm289v
	jCzgd26/brudyMe/leCRDNXcfrJqL8xEBLA2idudvmCz0e+brCraibhycN6q+h4jngpsg++GS/j
	D9J4bCRQvtzvkcRQF/Mdvh11DxDVWK2OLeqwp6veg2QjkJgt11sdhfbSjXzKQ2ZUWGfm0d2dwhL
	NJIA9aI+d9KD77Yl+
X-Google-Smtp-Source: AGHT+IHlJ+t9cxCWGd2RS36udv84be8wQSLtZiGp/SQb5nMAYqyEcYkpZ750MfgqwwlAexTx+Vl7eQ==
X-Received: by 2002:a17:903:1a27:b0:235:eb8d:7fff with SMTP id d9443c01a7336-23c6e58df66mr23872195ad.28.1751433420424;
        Tue, 01 Jul 2025 22:17:00 -0700 (PDT)
Received: from localhost.localdomain ([14.141.91.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c6fe31933sm4719595ad.220.2025.07.01.22.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:16:59 -0700 (PDT)
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
Subject: [PATCH v7 23/24] RISC-V: Enable GPIO keyboard and event device in RV64 defconfig
Date: Wed,  2 Jul 2025 10:43:44 +0530
Message-ID: <20250702051345.1460497-24-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702051345.1460497-1-apatel@ventanamicro.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
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


