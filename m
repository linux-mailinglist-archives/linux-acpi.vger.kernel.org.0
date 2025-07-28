Return-Path: <linux-acpi+bounces-15366-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F963B137BC
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 11:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78390189AB60
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 09:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012A6253B43;
	Mon, 28 Jul 2025 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="W0nlU9kE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C3253925
	for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695690; cv=none; b=Zm+2CiAjYes+bGRjlUEfe3S0hEaVuH+8AYM23HcleiKQgOzDpiEdEZ75VqZN7eoYW5EQwAoEcWawrwNP4eV5lcBqp/GWXhRj8EKJ/fcFvEdMi/bw4tr/Fy07pyK5v8bZHJ7DLAptoSPkxMZLkaWhs94ytFhwEpVdgn714OsH6H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695690; c=relaxed/simple;
	bh=twGbILBqHJSDdc9PqYErX7hC3c5EMu5fciFa6aeK+xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BH7CFxCiZuJhg7o4+Mgqj5y6fierakVVJ1BoAnrkARLK4CK2Q1VkXpMKF8ZMdueiyzJ+ESdjx7mJlf15kdnQX4RruAa874e83tAG1cOQWdEtWd93+WRPNTdqSzBHxBLqKLrpGbf8PTSFb/sEQWSY5p5SwDlKf9BlwuFwqy9u81s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=W0nlU9kE; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3137c2021a0so3469199a91.3
        for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 02:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753695689; x=1754300489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7NWz24690I24vfVTDuJoYnj8j4L+1x62uPEQcGO8p0=;
        b=W0nlU9kExNdz30CAJckD+ZqxyyEB3pIjYjiliKif6s9hyCHUXJR9wcoVt/DyqT2Fkm
         5khAX+wJr//wr2VvZ8FdnSR+ktWel/NXXDi801RNjVc7/l4wP4PSaTbPe1MeVtHm5CYf
         +4yL4NKJ75fsF7//ufgB5r9oi31sor8vn2qEn4xJYEx3d5GW6gCucYfCkDt/pZW+aSYL
         38cOzQO9zULC7YH5mU6spQKFNsyuZhgLRzL+bsmctaPsyWZSNe7kIwtJDknisRqBRQIp
         TAPMB6cxitX07NyS/zLltMEIMuDvP+rPeuUP3LvlxE3mTBopVUM7wKcxm6SlNJ1t73Wm
         v6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695689; x=1754300489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7NWz24690I24vfVTDuJoYnj8j4L+1x62uPEQcGO8p0=;
        b=c0Buixq2nKA+D4qkVDvoUdZcngTIDKuX/IvRNooRJ0pvfLAW91O5XFJNAnCUJfU4tX
         hspgHMD3L3O9Pir1bfRcz3TS113Uj5rMAPu+hRB1KAvnsUcSqxJrxD+3oU6aLrrmfXmD
         OFQfulZ207KkQTXTguL9pq0AoLgo8ypjGwiPXXsZGgSOCKpKuDPETmEzAXzHA0euPenp
         z7Yqv0pbHx/pw1RMFdgebFGRTz/egncwnM6Y3IvLhnjbLfpieKTgOM/E+2Zf/7fmT7Hf
         TFZxKZoFD1iuLZs6IQ+eLGvlpgdmPLGjHZEoNN62j64b6l3zE7F6k/cJBJySjFeJgZiS
         dshQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+VHe/uQmPPgwTDOpfOwrupRMpcYy4ow9QeiQzE1FQAyzvyW1ueu19NzkfVTqChwFkIy4vjSCSX+jM@vger.kernel.org
X-Gm-Message-State: AOJu0YzQAaLT9FcjUUNcQGp9D6KqsU0WOUjgNnoudI4BnlRlu2FXFnM1
	khoUhj60eFYtM6JuHn0nsyeyHMOKY4aUSV1fLK8b5daENtq0/czhse3F8zEKtffrDSA=
X-Gm-Gg: ASbGnctrRtO5URkL4krStDcqpPIARWqxboUc9VDQ6skFJvi2X5hOaESsJcc33uxjDh1
	LjMW7eYnjDIvAA7CFB10pNJnPlQvhmUr3n4Z9swBphMzc1neax4d+a0q0RP8lCZc4XtEyIhriiU
	KrDl/aihxJeFsqCTl3VU4JhGzYdU7bjsBIXPd7jsYlsZzscA+hGlnnPJiwAh4RHXc6Oe/qCNiAJ
	jAD0jEqcksV45wigYVfltmybLGsz0zclb9guXiF1NmD94YOZUB/DT/Ql3XtIHn7+zC2IHJvZOKn
	Xu+fhddC4n7WIK54MnEtV+h7OIeCtJwV5gcF3HmCtCx4alvNULwadA74NnK2bxvuG51NGMK6+2h
	aGhVibMOu926ZfrQkymq9IKNAyDUyJOjj36qS8afUiQuhJiacY9055TfEGbgm
X-Google-Smtp-Source: AGHT+IGHvXUp0klG2IZgTeZspvgsTkBclEVSkU6fmBMU5iF93kVQ+B6MpF1hlObdmg0SKveb59e7Hg==
X-Received: by 2002:a17:90b:1650:b0:313:20d2:c99b with SMTP id 98e67ed59e1d1-31e7787c856mr15209245a91.9.1753695688442;
        Mon, 28 Jul 2025 02:41:28 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([122.171.19.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fbf99sm5396230a91.1.2025.07.28.02.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:41:27 -0700 (PDT)
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
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v9 03/24] RISC-V: Add defines for the SBI message proxy extension
Date: Mon, 28 Jul 2025 15:10:11 +0530
Message-ID: <20250728094032.63545-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728094032.63545-1-apatel@ventanamicro.com>
References: <20250728094032.63545-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add defines for the new SBI message proxy extension which is part
of the SBI v3.0 specification.

Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Co-developed-by: Rahul Pathak <rpathak@ventanamicro.com>
Signed-off-by: Rahul Pathak <rpathak@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h | 63 ++++++++++++++++++++++++++++++++++++
 include/linux/wordpart.h     |  8 +++++
 2 files changed, 71 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 341e74238aa0..22f6e70cd32e 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/cpumask.h>
 #include <linux/jump_label.h>
+#include <linux/wordpart.h>
 
 #ifdef CONFIG_RISCV_SBI
 enum sbi_ext_id {
@@ -36,6 +37,7 @@ enum sbi_ext_id {
 	SBI_EXT_STA = 0x535441,
 	SBI_EXT_NACL = 0x4E41434C,
 	SBI_EXT_FWFT = 0x46574654,
+	SBI_EXT_MPXY = 0x4D505859,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -430,6 +432,67 @@ enum sbi_fwft_feature_t {
 
 #define SBI_FWFT_SET_FLAG_LOCK			BIT(0)
 
+enum sbi_ext_mpxy_fid {
+	SBI_EXT_MPXY_GET_SHMEM_SIZE,
+	SBI_EXT_MPXY_SET_SHMEM,
+	SBI_EXT_MPXY_GET_CHANNEL_IDS,
+	SBI_EXT_MPXY_READ_ATTRS,
+	SBI_EXT_MPXY_WRITE_ATTRS,
+	SBI_EXT_MPXY_SEND_MSG_WITH_RESP,
+	SBI_EXT_MPXY_SEND_MSG_WITHOUT_RESP,
+	SBI_EXT_MPXY_GET_NOTIFICATION_EVENTS,
+};
+
+enum sbi_mpxy_attribute_id {
+	/* Standard channel attributes managed by MPXY framework */
+	SBI_MPXY_ATTR_MSG_PROT_ID		= 0x00000000,
+	SBI_MPXY_ATTR_MSG_PROT_VER		= 0x00000001,
+	SBI_MPXY_ATTR_MSG_MAX_LEN		= 0x00000002,
+	SBI_MPXY_ATTR_MSG_SEND_TIMEOUT		= 0x00000003,
+	SBI_MPXY_ATTR_MSG_COMPLETION_TIMEOUT	= 0x00000004,
+	SBI_MPXY_ATTR_CHANNEL_CAPABILITY	= 0x00000005,
+	SBI_MPXY_ATTR_SSE_EVENT_ID		= 0x00000006,
+	SBI_MPXY_ATTR_MSI_CONTROL		= 0x00000007,
+	SBI_MPXY_ATTR_MSI_ADDR_LO		= 0x00000008,
+	SBI_MPXY_ATTR_MSI_ADDR_HI		= 0x00000009,
+	SBI_MPXY_ATTR_MSI_DATA			= 0x0000000A,
+	SBI_MPXY_ATTR_EVENTS_STATE_CONTROL	= 0x0000000B,
+	SBI_MPXY_ATTR_STD_ATTR_MAX_IDX,
+	/*
+	 * Message protocol specific attributes, managed by
+	 * the message protocol specification.
+	 */
+	SBI_MPXY_ATTR_MSGPROTO_ATTR_START	= 0x80000000,
+	SBI_MPXY_ATTR_MSGPROTO_ATTR_END		= 0xffffffff
+};
+
+/* Possible values of MSG_PROT_ID attribute as-per SBI v3.0 (or higher) */
+enum sbi_mpxy_msgproto_id {
+	SBI_MPXY_MSGPROTO_RPMI_ID = 0x0,
+};
+
+/* RPMI message protocol specific MPXY attributes */
+enum sbi_mpxy_rpmi_attribute_id {
+	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID = SBI_MPXY_ATTR_MSGPROTO_ATTR_START,
+	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION,
+	SBI_MPXY_RPMI_ATTR_IMPL_ID,
+	SBI_MPXY_RPMI_ATTR_IMPL_VERSION,
+	SBI_MPXY_RPMI_ATTR_MAX_ID
+};
+
+/* Encoding of MSG_PROT_VER attribute */
+#define SBI_MPXY_MSG_PROT_VER_MAJOR(__ver)	upper_16_bits(__ver)
+#define SBI_MPXY_MSG_PROT_VER_MINOR(__ver)	lower_16_bits(__ver)
+#define SBI_MPXY_MSG_PROT_MKVER(__maj, __min)	make_u32_from_two_u16(__maj, __min)
+
+/* Capabilities available through CHANNEL_CAPABILITY attribute */
+#define SBI_MPXY_CHAN_CAP_MSI			BIT(0)
+#define SBI_MPXY_CHAN_CAP_SSE			BIT(1)
+#define SBI_MPXY_CHAN_CAP_EVENTS_STATE		BIT(2)
+#define SBI_MPXY_CHAN_CAP_SEND_WITH_RESP	BIT(3)
+#define SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP	BIT(4)
+#define SBI_MPXY_CHAN_CAP_GET_NOTIFICATIONS	BIT(5)
+
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
diff --git a/include/linux/wordpart.h b/include/linux/wordpart.h
index 5a7b97bb7c95..ed8717730037 100644
--- a/include/linux/wordpart.h
+++ b/include/linux/wordpart.h
@@ -31,6 +31,14 @@
  */
 #define lower_16_bits(n) ((u16)((n) & 0xffff))
 
+/**
+ * make_u32_from_two_u16 - return u32 number by combining
+ * two u16 numbers.
+ * @hi: upper 16 bit number
+ * @lo: lower 16 bit number
+ */
+#define make_u32_from_two_u16(hi, lo)	(((u32)(hi) << 16) | (u32)(lo))
+
 /**
  * REPEAT_BYTE - repeat the value @x multiple times as an unsigned long value
  * @x: value to repeat
-- 
2.43.0


