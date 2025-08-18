Return-Path: <linux-acpi+bounces-15782-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB9AB2980D
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 06:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31125E17EA
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 04:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD185269CF0;
	Mon, 18 Aug 2025 04:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JTV2ukB+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4276D26A0AD
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490396; cv=none; b=qwtrPc6AXwIWGH5QsBfMIej/bvYucIXdDf7P6FB6qrmAVIj5VV7nosaxiR7fatvRTFhOA0twNiF0n63SKyvT2MxthW/P55s7cZp+Jqpmpb6NC8ckHAgwkqcAEyod5VDXjlP1sEGS13A9h7pkIKfGw/UpJcw1ON+AnmPXKHnQNtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490396; c=relaxed/simple;
	bh=65T8ACHblxo2D9Y5oErp1bIX7U/Lm0LLwEyN5VeFGBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQWtaNeseFDTV3ssmg259CfK3pGLtjC9nLaX/ON/rdpRixr+nGl2dqQ16FbDSS9WMSJEFLjK3/93A5rEVYSsX96jKCKPIafQU2OBUeSgFGnws8RD6VzR3Zf10S+Zfm3F2p15uLWfqPYkxPdOpHBsDiUA4TSSU13EK0Q2c05Uq3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JTV2ukB+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24458242b33so33013255ad.3
        for <linux-acpi@vger.kernel.org>; Sun, 17 Aug 2025 21:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490394; x=1756095194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJN6/jwOx6PvAx5UtYwiYDtqnVqwfwWox4DCK7OERJ8=;
        b=JTV2ukB+HnMME23zz9zmZujFainKvLGXSITX3L4GsXOftxayOBovaEsna10U55yfd4
         A9f0LrY1jO94hpaK5f+Uo3Zo9ORurfxnasIxF0Od9YCa/zmRctmUZxJxZFelETEJLmWu
         oSLsw5SetXNpM3LPY/acclXBxvFBjuqvMOd7ZbdnSz7qQMm9ziI3QcxcUQFcEZ0cip4k
         LxiQ1yPWsqCNNkUMdu2z0ezFGSQezNsD1BldnLmav9rEuyXtE6JqxSytgDJKwoAOWDXF
         3lLf2gS3upMaPK1+gX0yu+Bt1rq1/tjRxxunuCG5WMme8vXQxKuAmWxzpMYSp+kz9jhT
         AQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490394; x=1756095194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJN6/jwOx6PvAx5UtYwiYDtqnVqwfwWox4DCK7OERJ8=;
        b=D14UG6X9v4F8xgvvunRQihnWroTMizjH80GT1VhdvF8bfeZ+lLOaP/CwHRrh+1W9dj
         zc9FM8YaW3JuJ+w23vHlqbY0KkEsaQMu44NSaeAzYp/2C30Um0JBvgCmZwfHCth0+LY6
         vtZ8IKGSyn3luGMNR0jxHbLrknTv3Kt8tbkN7kM2N2ARAFhtXRPOOP8y0MAIrvu/xFt8
         T89bozpPT2BSir0T9kc6ozOZXDsGIr01qzVpZ8XxIGwfRbVgSyVdkiEdc7paYAFegrp4
         aJ04bX23x22USDZuKtwHf4VStZS2H3ybDZSR8D69xZ10RNxGp/+pojGpmmnccaonpI9y
         Y0tA==
X-Forwarded-Encrypted: i=1; AJvYcCVsnGZLTU3n7hBuyOnaemD/H0T5/NwcJ7oEjksS/BEChqFTj7pgqyo1pO28/yMIBysaf/PJtllwOp3K@vger.kernel.org
X-Gm-Message-State: AOJu0YxSjEVRXTuMkFvQMyHZwCksNTgwxxWSPUGW8svxvwqgZ3rexnam
	gGZ0T0uTlIhMaOZRZe3ozbpB0myo8o0QFmxKQxQSvI3vhUV+maKtdaDvTC8i5lV/p3o=
X-Gm-Gg: ASbGncuODlKxKw0M4lTp5BzYl3+xBe+0m0yBHhemPuAf55rBxvMlnzbZCkW1oEJmUOS
	rQUXo6WAAD7as8czd8Vf+znoskAn6j8S6arM2npmdmsOmEKNwKon9VP9Avu7zM5eAeP8n6jfKB2
	RZ7ER/yTH5sRc71CR8PFgosAhpbQlZYcjJzdeIOZC6W8mjsZvOlDl8G0rHK358ED0f3Gupb/IYN
	N8KDXvyLWVPZADymkFPAATJkVZfLxnLmxFw4ubLJqbcEAqsQWakxAVNdHpIjYDZmPza/WF9SMdm
	ESw/CG/XFrYCrenKwq2QAtKb9mnPUJ7gtc9hzex9mhaoDIuOVYBsoTJHa0wzF0xTJoyz5uTVDWL
	O8JAHSGgLK9NDWy/xAvWdxdu4zZWQRt/mqukKFHz1SEnGajxsbVT87syLbJoVx91X
X-Google-Smtp-Source: AGHT+IGHAghuq2SQgJxlaChRoet/Tx7S9hCYmLUP2wntlwdg9I81uVIMsAQNgL7M5sl0qBnBN4yH/A==
X-Received: by 2002:a17:902:e948:b0:242:3855:c77a with SMTP id d9443c01a7336-2446d8c6388mr161787285ad.34.1755490394370;
        Sun, 17 Aug 2025 21:13:14 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:13:13 -0700 (PDT)
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
Subject: [PATCH v10 23/24] RISC-V: Enable GPIO keyboard and event device in RV64 defconfig
Date: Mon, 18 Aug 2025 09:39:19 +0530
Message-ID: <20250818040920.272664-24-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818040920.272664-1-apatel@ventanamicro.com>
References: <20250818040920.272664-1-apatel@ventanamicro.com>
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
index 7b5eed17611a..021baecb253a 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -139,6 +139,8 @@ CONFIG_MICREL_PHY=y
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


