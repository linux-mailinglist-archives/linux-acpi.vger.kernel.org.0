Return-Path: <linux-acpi+bounces-15373-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC217B137E5
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 11:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D112E1660F1
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 09:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97795253950;
	Mon, 28 Jul 2025 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dOSdQc7v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33049256C83
	for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695760; cv=none; b=THDlfBhucXcK4itirttm7XjcvLPmHZAjtdxYvyqlIbHx38tBjy5bTI0cvK0BSnwTsN6VYnsLIyOpqUsVDe6Cadf07V8c7JB1SLtcWJb33ZwXPB97C3RCN9TicnVBtHcjKDuHmWWUg8u1dvcDo8a4qG/LTAecKfuFZj3cvyrLRi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695760; c=relaxed/simple;
	bh=i0PGvdhuE2nHsD+krau0W4ru7W3ZJfTxT9voJsgnoCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZfGCbL0y2tF3MgM2fJk7YVxe3/MeRlW3zMCQzHRbOHGKdAzqm2IXqA7RaR2B/vkFIdP/6J5KoYf9ko8mnzOFZmMSsKCUOGUbElQDKdN4zfM7sYoQK3PGqXkgLhhCQ2Vm81GXyG7zkaXAyMjKEGB4lcONznXsZk81dzeONgPp88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dOSdQc7v; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b31e0ead80eso3411395a12.0
        for <linux-acpi@vger.kernel.org>; Mon, 28 Jul 2025 02:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753695756; x=1754300556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeRqw6SpXyEObtdm8/TZ6kNQ6UGW0gJxioxX7Cee1b0=;
        b=dOSdQc7vYqCG9q39ACYtQEoFYWwyx2pEnFa22WAlDbAnu30fvbirzRQUa91cd4lzDi
         0ZGBOIqFBhHcY4ctmdL+FDMdY2TzINd4ztKKaIXJqM3p69e03Ow3R4EFEA7OZO9ZK6Uq
         J7MvR32dylrWpvBMSHoBsMscypYPHNOGR/UGLfMnyIfzQ2NijLWu4nZzjAC3IEvYQuCF
         pva1RWaS75aqiyueKWqWFYLZOxe9SIpG5QsKa8r/ChhroO9L4lbw0pK1I4Y4siS4LKDx
         jHNyrzN7OkuI7G7t5mX8DHbjNBz75GtgRc9rqEsYzF6RW6JSseaMIBQjH2tmCba9YDj7
         2Efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695756; x=1754300556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeRqw6SpXyEObtdm8/TZ6kNQ6UGW0gJxioxX7Cee1b0=;
        b=pw8QgF6C8veUnsycTDaLeBL+RxYmrcKZ1dWjLwmkg//69gf5uj9ijiRZgekS+bihdg
         9R9OKsTFHZNJfs2D/9L+VvSXh6DOKDX5NEDvkfqiTYzNshGVhvdoiwY23gevVxxGlOSR
         WCunD//clJore8lo22pCT3LVHpM2BULVhN08csFRLxQ3sBm3fQPObVsb9nWORRdRTPzo
         07S8bmiQmMEZd6HMd7xQf03SwOyBzGkfQdFYzMGSn4tqqPtX6kS6mFNFb/GkeuHADzn9
         El3BKDv6WOsCWSxZWMjh4aXC+rGOmUBk8il5BH0Z3hrPobXArn5BZKBySzv7Sjs2oGc9
         UgxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3lxK57xM+6PtKCXiClszXM8Cm1HpZXLBXDHYsHAgdnSjyBhrRvhf4YlJk3ZlFEVObbWbAsonhv1Nw@vger.kernel.org
X-Gm-Message-State: AOJu0YxpXDN2xl/eanLIrusIi/sh3PK6Vt8XmW1mtmDUwsq0I00XCpuG
	iKNzEOB/O6zUeYfOSAuJtFsnfYC5mt9506ZK+bDZXqw7FJgk5SYV2A57CPq3cdlaVFQ=
X-Gm-Gg: ASbGnct99Hij4qFxQIbqt/GchPSavbHb8edV4mry5y0q6qg9x/tr3WoIRT0NtpgLKeG
	SSQEW3sx6LYjS9rowZbp3rIoRd9kMaeWk+6KJNmxFd0ACg1FqTU8aknQ8m7q/9zM/X51qLOFc3H
	0uhm32xDzqIwVQNUsBwQOWTUI1IfWt8ZhUIbPaY/trP5mhIOsZmGbWPpnoxK9MGp55mYPkrMRqi
	JrB7q/qsmudR9svFoZE/dqhcZtwmWz4ur6IIu/GLAToPCp4IDY0Q3sVpN85xY9Evkrr8IrI+r61
	rYlJl04yqqwqZGMPxVaByfzz+ZU9axedYH9z6bvypAUn1oJgY1HYwTMagiWZC1fLky8ZOB8tzpY
	nxmHSoGt4yQxwwGn/REGIaODO3WBs5N6f0fm3UWLVsHctE2dVR8FZ/M6JdOlF
X-Google-Smtp-Source: AGHT+IHZhUbzVWjTFYDd42/EHM80l6sYUh1xvx4TzR7DR8KkEy/xkYkMa0IQ56nsrY8KEFb86hrYFg==
X-Received: by 2002:a17:90b:4d8b:b0:315:aa28:9501 with SMTP id 98e67ed59e1d1-31e77a127cdmr16437415a91.24.1753695756033;
        Mon, 28 Jul 2025 02:42:36 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([122.171.19.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fbf99sm5396230a91.1.2025.07.28.02.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:42:35 -0700 (PDT)
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
Subject: [PATCH v9 10/24] clk: Add clock driver for the RISC-V RPMI clock service group
Date: Mon, 28 Jul 2025 15:10:18 +0530
Message-ID: <20250728094032.63545-11-apatel@ventanamicro.com>
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

From: Rahul Pathak <rpathak@ventanamicro.com>

The RPMI specification defines a clock service group which can be
accessed via SBI MPXY extension or dedicated S-mode RPMI transport.

Add mailbox client based clock driver for the RISC-V RPMI clock
service group.

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Co-developed-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Rahul Pathak <rpathak@ventanamicro.com>
---
 drivers/clk/Kconfig                        |   8 +
 drivers/clk/Makefile                       |   1 +
 drivers/clk/clk-rpmi.c                     | 616 +++++++++++++++++++++
 include/linux/mailbox/riscv-rpmi-message.h |  16 +
 include/linux/wordpart.h                   |   8 +
 5 files changed, 649 insertions(+)
 create mode 100644 drivers/clk/clk-rpmi.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 19c1ed280fd7..2e385b146f8b 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -493,6 +493,14 @@ config COMMON_CLK_SP7021
 	  Not all features of the PLL are currently supported
 	  by the driver.
 
+config COMMON_CLK_RPMI
+	tristate "Clock driver based on RISC-V RPMI"
+	depends on MAILBOX
+	default RISCV
+	help
+	  Support for clocks based on the clock service group defined by
+	  the RISC-V platform management interface (RPMI) specification.
+
 source "drivers/clk/actions/Kconfig"
 source "drivers/clk/analogbits/Kconfig"
 source "drivers/clk/baikal-t1/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 42867cd37c33..48866e429a40 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_CLK_LS1028A_PLLDIG)	+= clk-plldig.o
 obj-$(CONFIG_COMMON_CLK_PWM)		+= clk-pwm.o
 obj-$(CONFIG_CLK_QORIQ)			+= clk-qoriq.o
 obj-$(CONFIG_COMMON_CLK_RK808)		+= clk-rk808.o
+obj-$(CONFIG_COMMON_CLK_RPMI)		+= clk-rpmi.o
 obj-$(CONFIG_COMMON_CLK_HI655X)		+= clk-hi655x.o
 obj-$(CONFIG_COMMON_CLK_S2MPS11)	+= clk-s2mps11.o
 obj-$(CONFIG_COMMON_CLK_SCMI)           += clk-scmi.o
diff --git a/drivers/clk/clk-rpmi.c b/drivers/clk/clk-rpmi.c
new file mode 100644
index 000000000000..e0a371586695
--- /dev/null
+++ b/drivers/clk/clk-rpmi.c
@@ -0,0 +1,616 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V MPXY Based Clock Driver
+ *
+ * Copyright (C) 2025 Ventana Micro Systems Ltd.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/mailbox_client.h>
+#include <linux/mailbox/riscv-rpmi-message.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/wordpart.h>
+
+#define RPMI_CLK_DISCRETE_MAX_NUM_RATES		16
+#define RPMI_CLK_NAME_LEN			16
+
+#define to_rpmi_clk(clk)	container_of(clk, struct rpmi_clk, hw)
+
+#define rpmi_clkrate_u64(hi, lo)	make_u64_from_two_u32(hi, lo)
+
+enum rpmi_clk_config {
+	RPMI_CLK_DISABLE = 0,
+	RPMI_CLK_ENABLE = 1,
+	RPMI_CLK_CONFIG_MAX_IDX
+};
+
+enum rpmi_clk_type {
+	RPMI_CLK_DISCRETE = 0,
+	RPMI_CLK_LINEAR = 1,
+	RPMI_CLK_TYPE_MAX_IDX
+};
+
+struct rpmi_clk_context {
+	struct device *dev;
+	struct mbox_chan *chan;
+	struct mbox_client client;
+	u32 max_msg_data_size;
+};
+
+/*
+ * rpmi_clk_rates represents the rates format
+ * as specified by the RPMI specification.
+ * No other data format (e.g., struct linear_range)
+ * is required to avoid to and from conversion.
+ */
+union rpmi_clk_rates {
+	u64 discrete[RPMI_CLK_DISCRETE_MAX_NUM_RATES];
+	struct {
+		u64 min;
+		u64 max;
+		u64 step;
+	} linear;
+};
+
+struct rpmi_clk {
+	struct rpmi_clk_context *context;
+	u32 id;
+	u32 num_rates;
+	u32 transition_latency;
+	enum rpmi_clk_type type;
+	union rpmi_clk_rates *rates;
+	char name[RPMI_CLK_NAME_LEN];
+	struct clk_hw hw;
+};
+
+struct rpmi_clk_rate_discrete {
+	__le32 lo;
+	__le32 hi;
+};
+
+struct rpmi_clk_rate_linear {
+	__le32 min_lo;
+	__le32 min_hi;
+	__le32 max_lo;
+	__le32 max_hi;
+	__le32 step_lo;
+	__le32 step_hi;
+};
+
+struct rpmi_get_num_clocks_rx {
+	__le32 status;
+	__le32 num_clocks;
+};
+
+struct rpmi_get_attrs_tx {
+	__le32 clkid;
+};
+
+struct rpmi_get_attrs_rx {
+	__le32 status;
+	__le32 flags;
+	__le32 num_rates;
+	__le32 transition_latency;
+	char name[RPMI_CLK_NAME_LEN];
+};
+
+struct rpmi_get_supp_rates_tx {
+	__le32 clkid;
+	__le32 clk_rate_idx;
+};
+
+struct rpmi_get_supp_rates_rx {
+	__le32 status;
+	__le32 flags;
+	__le32 remaining;
+	__le32 returned;
+	__le32 rates[];
+};
+
+struct rpmi_get_rate_tx {
+	__le32 clkid;
+};
+
+struct rpmi_get_rate_rx {
+	__le32 status;
+	__le32 lo;
+	__le32 hi;
+};
+
+struct rpmi_set_rate_tx {
+	__le32 clkid;
+	__le32 flags;
+	__le32 lo;
+	__le32 hi;
+};
+
+struct rpmi_set_rate_rx {
+	__le32 status;
+};
+
+struct rpmi_set_config_tx {
+	__le32 clkid;
+	__le32 config;
+};
+
+struct rpmi_set_config_rx {
+	__le32 status;
+};
+
+static u32 rpmi_clk_get_num_clocks(struct rpmi_clk_context *context)
+{
+	struct rpmi_get_num_clocks_rx rx, *resp;
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_GET_NUM_CLOCKS,
+					  NULL, 0, &rx, sizeof(rx));
+
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return 0;
+
+	resp = rpmi_mbox_get_msg_response(&msg);
+	if (!resp || resp->status)
+		return 0;
+
+	return le32_to_cpu(resp->num_clocks);
+}
+
+static int rpmi_clk_get_attrs(u32 clkid, struct rpmi_clk *rpmi_clk)
+{
+	struct rpmi_clk_context *context = rpmi_clk->context;
+	struct rpmi_mbox_message msg;
+	struct rpmi_get_attrs_tx tx;
+	struct rpmi_get_attrs_rx rx, *resp;
+	u8 format;
+	int ret;
+
+	tx.clkid = cpu_to_le32(clkid);
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_GET_ATTRIBUTES,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return ret;
+
+	resp = rpmi_mbox_get_msg_response(&msg);
+	if (!resp)
+		return -EINVAL;
+	if (resp->status)
+		return rpmi_to_linux_error(le32_to_cpu(resp->status));
+
+	rpmi_clk->id = clkid;
+	rpmi_clk->num_rates = le32_to_cpu(resp->num_rates);
+	rpmi_clk->transition_latency = le32_to_cpu(resp->transition_latency);
+	strscpy(rpmi_clk->name, resp->name, RPMI_CLK_NAME_LEN);
+
+	format = le32_to_cpu(resp->flags) & 3U;
+	if (format >= RPMI_CLK_TYPE_MAX_IDX)
+		return -EINVAL;
+
+	rpmi_clk->type = format;
+
+	return 0;
+}
+
+static int rpmi_clk_get_supported_rates(u32 clkid, struct rpmi_clk *rpmi_clk)
+{
+	struct rpmi_clk_context *context = rpmi_clk->context;
+	struct rpmi_clk_rate_discrete *rate_discrete;
+	struct rpmi_clk_rate_linear *rate_linear;
+	struct rpmi_get_supp_rates_tx tx;
+	struct rpmi_get_supp_rates_rx *resp;
+	struct rpmi_mbox_message msg;
+	size_t clk_rate_idx;
+	int ret, rateidx, j;
+
+	tx.clkid = cpu_to_le32(clkid);
+	tx.clk_rate_idx = 0;
+
+	/*
+	 * Make sure we allocate rx buffer sufficient to be accommodate all
+	 * the rates sent in one RPMI message.
+	 */
+	struct rpmi_get_supp_rates_rx *rx __free(kfree) =
+					kzalloc(context->max_msg_data_size, GFP_KERNEL);
+	if (!rx)
+		return -ENOMEM;
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_GET_SUPPORTED_RATES,
+					  &tx, sizeof(tx), rx, context->max_msg_data_size);
+
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return ret;
+
+	resp = rpmi_mbox_get_msg_response(&msg);
+	if (!resp)
+		return -EINVAL;
+	if (resp->status)
+		return rpmi_to_linux_error(le32_to_cpu(resp->status));
+	if (!le32_to_cpu(resp->returned))
+		return -EINVAL;
+
+	if (rpmi_clk->type == RPMI_CLK_DISCRETE) {
+		rate_discrete = (struct rpmi_clk_rate_discrete *)resp->rates;
+
+		for (rateidx = 0; rateidx < le32_to_cpu(resp->returned); rateidx++) {
+			rpmi_clk->rates->discrete[rateidx] =
+				rpmi_clkrate_u64(le32_to_cpu(rate_discrete[rateidx].hi),
+						 le32_to_cpu(rate_discrete[rateidx].lo));
+		}
+
+		/*
+		 * Keep sending the request message until all
+		 * the rates are received.
+		 */
+		clk_rate_idx = 0;
+		while (le32_to_cpu(resp->remaining)) {
+			clk_rate_idx += le32_to_cpu(resp->returned);
+			tx.clk_rate_idx = cpu_to_le32(clk_rate_idx);
+
+			rpmi_mbox_init_send_with_response(&msg,
+							  RPMI_CLK_SRV_GET_SUPPORTED_RATES,
+							  &tx, sizeof(tx),
+							  rx, context->max_msg_data_size);
+
+			ret = rpmi_mbox_send_message(context->chan, &msg);
+			if (ret)
+				return ret;
+
+			resp = rpmi_mbox_get_msg_response(&msg);
+			if (!resp)
+				return -EINVAL;
+			if (resp->status)
+				return rpmi_to_linux_error(le32_to_cpu(resp->status));
+			if (!le32_to_cpu(resp->returned))
+				return -EINVAL;
+
+			for (j = 0; j < le32_to_cpu(resp->returned); j++) {
+				if (rateidx >= clk_rate_idx + le32_to_cpu(resp->returned))
+					break;
+				rpmi_clk->rates->discrete[rateidx++] =
+					rpmi_clkrate_u64(le32_to_cpu(rate_discrete[j].hi),
+							 le32_to_cpu(rate_discrete[j].lo));
+			}
+		}
+	} else if (rpmi_clk->type == RPMI_CLK_LINEAR) {
+		rate_linear = (struct rpmi_clk_rate_linear *)resp->rates;
+
+		rpmi_clk->rates->linear.min = rpmi_clkrate_u64(le32_to_cpu(rate_linear->min_hi),
+							       le32_to_cpu(rate_linear->min_lo));
+		rpmi_clk->rates->linear.max = rpmi_clkrate_u64(le32_to_cpu(rate_linear->max_hi),
+							       le32_to_cpu(rate_linear->max_lo));
+		rpmi_clk->rates->linear.step = rpmi_clkrate_u64(le32_to_cpu(rate_linear->step_hi),
+								le32_to_cpu(rate_linear->step_lo));
+	}
+
+	return 0;
+}
+
+static unsigned long rpmi_clk_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct rpmi_clk *rpmi_clk = to_rpmi_clk(hw);
+	struct rpmi_clk_context *context = rpmi_clk->context;
+	struct rpmi_mbox_message msg;
+	struct rpmi_get_rate_tx tx;
+	struct rpmi_get_rate_rx rx, *resp;
+	int ret;
+
+	tx.clkid = cpu_to_le32(rpmi_clk->id);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_GET_RATE,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return ret;
+
+	resp = rpmi_mbox_get_msg_response(&msg);
+	if (!resp)
+		return -EINVAL;
+	if (resp->status)
+		return rpmi_to_linux_error(le32_to_cpu(resp->status));
+
+	return rpmi_clkrate_u64(le32_to_cpu(resp->hi), le32_to_cpu(resp->lo));
+}
+
+static int rpmi_clk_determine_rate(struct clk_hw *hw,
+				   struct clk_rate_request *req)
+{
+	struct rpmi_clk *rpmi_clk = to_rpmi_clk(hw);
+	u64 fmin, fmax, ftmp;
+
+	/*
+	 * Keep the requested rate if the clock format
+	 * is of discrete type. Let the platform which
+	 * is actually controlling the clock handle that.
+	 */
+	if (rpmi_clk->type == RPMI_CLK_DISCRETE)
+		return 0;
+
+	fmin = rpmi_clk->rates->linear.min;
+	fmax = rpmi_clk->rates->linear.max;
+
+	if (req->rate <= fmin) {
+		req->rate = fmin;
+		return 0;
+	} else if (req->rate >= fmax) {
+		req->rate = fmax;
+		return 0;
+	}
+
+	ftmp = req->rate - fmin;
+	ftmp += rpmi_clk->rates->linear.step - 1;
+	do_div(ftmp, rpmi_clk->rates->linear.step);
+
+	req->rate = ftmp * rpmi_clk->rates->linear.step + fmin;
+
+	return 0;
+}
+
+static int rpmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long parent_rate)
+{
+	struct rpmi_clk *rpmi_clk = to_rpmi_clk(hw);
+	struct rpmi_clk_context *context = rpmi_clk->context;
+	struct rpmi_mbox_message msg;
+	struct rpmi_set_rate_tx tx;
+	struct rpmi_set_rate_rx rx, *resp;
+	int ret;
+
+	tx.clkid = cpu_to_le32(rpmi_clk->id);
+	tx.lo = cpu_to_le32(lower_32_bits(rate));
+	tx.hi = cpu_to_le32(upper_32_bits(rate));
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_SET_RATE,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return ret;
+
+	resp = rpmi_mbox_get_msg_response(&msg);
+	if (!resp)
+		return -EINVAL;
+	if (resp->status)
+		return rpmi_to_linux_error(le32_to_cpu(resp->status));
+
+	return 0;
+}
+
+static int rpmi_clk_enable(struct clk_hw *hw)
+{
+	struct rpmi_clk *rpmi_clk = to_rpmi_clk(hw);
+	struct rpmi_clk_context *context = rpmi_clk->context;
+	struct rpmi_mbox_message msg;
+	struct rpmi_set_config_tx tx;
+	struct rpmi_set_config_rx rx, *resp;
+	int ret;
+
+	tx.config = cpu_to_le32(RPMI_CLK_ENABLE);
+	tx.clkid = cpu_to_le32(rpmi_clk->id);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_SET_CONFIG,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return ret;
+
+	resp = rpmi_mbox_get_msg_response(&msg);
+	if (!resp)
+		return -EINVAL;
+	if (resp->status)
+		return rpmi_to_linux_error(le32_to_cpu(resp->status));
+
+	return 0;
+}
+
+static void rpmi_clk_disable(struct clk_hw *hw)
+{
+	struct rpmi_clk *rpmi_clk = to_rpmi_clk(hw);
+	struct rpmi_clk_context *context = rpmi_clk->context;
+	struct rpmi_mbox_message msg;
+	struct rpmi_set_config_tx tx;
+	struct rpmi_set_config_rx rx;
+
+	tx.config = cpu_to_le32(RPMI_CLK_DISABLE);
+	tx.clkid = cpu_to_le32(rpmi_clk->id);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_CLK_SRV_SET_CONFIG,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+
+	rpmi_mbox_send_message(context->chan, &msg);
+}
+
+static const struct clk_ops rpmi_clk_ops = {
+	.recalc_rate = rpmi_clk_recalc_rate,
+	.determine_rate = rpmi_clk_determine_rate,
+	.set_rate = rpmi_clk_set_rate,
+	.prepare = rpmi_clk_enable,
+	.unprepare = rpmi_clk_disable,
+};
+
+static struct clk_hw *rpmi_clk_enumerate(struct rpmi_clk_context *context, u32 clkid)
+{
+	struct device *dev = context->dev;
+	unsigned long min_rate, max_rate;
+	union rpmi_clk_rates *rates;
+	struct rpmi_clk *rpmi_clk;
+	struct clk_init_data init = {};
+	struct clk_hw *clk_hw;
+	int ret;
+
+	rates = devm_kzalloc(dev, sizeof(*rates), GFP_KERNEL);
+	if (!rates)
+		return ERR_PTR(-ENOMEM);
+
+	rpmi_clk = devm_kzalloc(dev, sizeof(*rpmi_clk), GFP_KERNEL);
+	if (!rpmi_clk)
+		return ERR_PTR(-ENOMEM);
+
+	rpmi_clk->context = context;
+	rpmi_clk->rates = rates;
+
+	ret = rpmi_clk_get_attrs(clkid, rpmi_clk);
+	if (ret)
+		return dev_err_ptr_probe(dev, ret,
+					 "Failed to get clk-%u attributes\n",
+					 clkid);
+
+	ret = rpmi_clk_get_supported_rates(clkid, rpmi_clk);
+	if (ret)
+		return dev_err_ptr_probe(dev, ret,
+					 "Get supported rates failed for clk-%u\n",
+					 clkid);
+
+	init.flags = CLK_GET_RATE_NOCACHE;
+	init.num_parents = 0;
+	init.ops = &rpmi_clk_ops;
+	init.name = rpmi_clk->name;
+	clk_hw = &rpmi_clk->hw;
+	clk_hw->init = &init;
+
+	ret = devm_clk_hw_register(dev, clk_hw);
+	if (ret)
+		return dev_err_ptr_probe(dev, ret,
+					 "Unable to register clk-%u\n",
+					 clkid);
+
+	if (rpmi_clk->type == RPMI_CLK_DISCRETE) {
+		min_rate = rpmi_clk->rates->discrete[0];
+		max_rate = rpmi_clk->rates->discrete[rpmi_clk->num_rates -  1];
+	} else {
+		min_rate = rpmi_clk->rates->linear.min;
+		max_rate = rpmi_clk->rates->linear.max;
+	}
+
+	clk_hw_set_rate_range(clk_hw, min_rate, max_rate);
+
+	return clk_hw;
+}
+
+static void rpmi_clk_mbox_chan_release(void *data)
+{
+	struct mbox_chan *chan = data;
+
+	mbox_free_channel(chan);
+}
+
+static int rpmi_clk_probe(struct platform_device *pdev)
+{
+	int ret;
+	unsigned int num_clocks, i;
+	struct clk_hw_onecell_data *clk_data;
+	struct rpmi_clk_context *context;
+	struct rpmi_mbox_message msg;
+	struct clk_hw *hw_ptr;
+	struct device *dev = &pdev->dev;
+
+	context = devm_kzalloc(dev, sizeof(*context), GFP_KERNEL);
+	if (!context)
+		return -ENOMEM;
+	context->dev = dev;
+	platform_set_drvdata(pdev, context);
+
+	context->client.dev		= context->dev;
+	context->client.rx_callback	= NULL;
+	context->client.tx_block	= false;
+	context->client.knows_txdone	= true;
+	context->client.tx_tout		= 0;
+
+	context->chan = mbox_request_channel(&context->client, 0);
+	if (IS_ERR(context->chan))
+		return PTR_ERR(context->chan);
+
+	ret = devm_add_action_or_reset(dev, rpmi_clk_mbox_chan_release, context->chan);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add rpmi mbox channel cleanup\n");
+
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SPEC_VERSION);
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get spec version\n");
+	if (msg.attr.value < RPMI_MKVER(1, 0)) {
+		return dev_err_probe(dev, -EINVAL,
+				     "msg protocol version mismatch, expected 0x%x, found 0x%x\n",
+				     RPMI_MKVER(1, 0), msg.attr.value);
+	}
+
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SERVICEGROUP_ID);
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get service group ID\n");
+	if (msg.attr.value != RPMI_SRVGRP_CLOCK) {
+		return dev_err_probe(dev, -EINVAL,
+				     "service group match failed, expected 0x%x, found 0x%x\n",
+				     RPMI_SRVGRP_CLOCK, msg.attr.value);
+	}
+
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SERVICEGROUP_VERSION);
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get service group version\n");
+	if (msg.attr.value < RPMI_MKVER(1, 0)) {
+		return dev_err_probe(dev, -EINVAL,
+				     "service group version failed, expected 0x%x, found 0x%x\n",
+				     RPMI_MKVER(1, 0), msg.attr.value);
+	}
+
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_MAX_MSG_DATA_SIZE);
+	ret = rpmi_mbox_send_message(context->chan, &msg);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get max message data size\n");
+
+	context->max_msg_data_size = msg.attr.value;
+	num_clocks = rpmi_clk_get_num_clocks(context);
+	if (!num_clocks)
+		return dev_err_probe(dev, -ENODEV, "No clocks found\n");
+
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, num_clocks),
+				GFP_KERNEL);
+	if (!clk_data)
+		return dev_err_probe(dev, -ENOMEM, "No memory for clock data\n");
+	clk_data->num = num_clocks;
+
+	for (i = 0; i < clk_data->num; i++) {
+		hw_ptr = rpmi_clk_enumerate(context, i);
+		if (IS_ERR(hw_ptr)) {
+			return dev_err_probe(dev, PTR_ERR(hw_ptr),
+					     "Failed to register clk-%d\n", i);
+		}
+		clk_data->hws[i] = hw_ptr;
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register clock HW provider\n");
+
+	return 0;
+}
+
+static const struct of_device_id rpmi_clk_of_match[] = {
+	{ .compatible = "riscv,rpmi-clock" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rpmi_clk_of_match);
+
+static struct platform_driver rpmi_clk_driver = {
+	.driver = {
+		.name = "riscv-rpmi-clock",
+		.of_match_table = rpmi_clk_of_match,
+	},
+	.probe = rpmi_clk_probe,
+};
+module_platform_driver(rpmi_clk_driver);
+
+MODULE_AUTHOR("Rahul Pathak <rpathak@ventanamicro.com>");
+MODULE_DESCRIPTION("Clock Driver based on RPMI message protocol");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mailbox/riscv-rpmi-message.h b/include/linux/mailbox/riscv-rpmi-message.h
index 3f4c73529aa5..c90918dca367 100644
--- a/include/linux/mailbox/riscv-rpmi-message.h
+++ b/include/linux/mailbox/riscv-rpmi-message.h
@@ -90,6 +90,22 @@ static inline int rpmi_to_linux_error(int rpmi_error)
 	}
 }
 
+/* RPMI service group IDs */
+#define RPMI_SRVGRP_CLOCK		0x00008
+
+/* RPMI clock service IDs */
+enum rpmi_clock_service_id {
+	RPMI_CLK_SRV_ENABLE_NOTIFICATION = 0x01,
+	RPMI_CLK_SRV_GET_NUM_CLOCKS = 0x02,
+	RPMI_CLK_SRV_GET_ATTRIBUTES = 0x03,
+	RPMI_CLK_SRV_GET_SUPPORTED_RATES = 0x04,
+	RPMI_CLK_SRV_SET_CONFIG = 0x05,
+	RPMI_CLK_SRV_GET_CONFIG = 0x06,
+	RPMI_CLK_SRV_SET_RATE = 0x07,
+	RPMI_CLK_SRV_GET_RATE = 0x08,
+	RPMI_CLK_SRV_ID_MAX_COUNT
+};
+
 /* RPMI Linux mailbox attribute IDs */
 enum rpmi_mbox_attribute_id {
 	RPMI_MBOX_ATTR_SPEC_VERSION,
diff --git a/include/linux/wordpart.h b/include/linux/wordpart.h
index ed8717730037..5cad9c244bf2 100644
--- a/include/linux/wordpart.h
+++ b/include/linux/wordpart.h
@@ -39,6 +39,14 @@
  */
 #define make_u32_from_two_u16(hi, lo)	(((u32)(hi) << 16) | (u32)(lo))
 
+/**
+ * make_u64_from_two_u32 - return u64 number by combining
+ * two u32 numbers.
+ * @hi: upper 32 bit number
+ * @lo: lower 32 bit number
+ */
+#define make_u64_from_two_u32(hi, lo)	(((u64)(hi) << 32) | (u32)(lo))
+
 /**
  * REPEAT_BYTE - repeat the value @x multiple times as an unsigned long value
  * @x: value to repeat
-- 
2.43.0


