Return-Path: <linux-acpi+bounces-15769-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72751B297D9
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 06:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1C93B8554
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 04:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C20B26462E;
	Mon, 18 Aug 2025 04:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZGDO9/1x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D416A25DD07
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 04:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490292; cv=none; b=MBOx2FI+iKuF9f4cbb7RUoXlb0LgRBh4E33mA3am/oLZwcCDnOLyHPPK4++P9EnpyqQbb4hhs908mdvHHPknttN4OpbqdZJZdx4FF67Zla8H5Vm+YU984getc3swUjs9q0a47b2emY05SAvMw5k2Kj7BElwkRidYXCvsWB7yLpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490292; c=relaxed/simple;
	bh=ImR5f5svFs9Iu1ENQYLyk4SSAAQExVQyx4TcN8PBowk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvziDKARcvAM1ITeDpyUjv9RXTsg6TuDepCG4TJoUNA0WCYAJxaD0M8kP2iGhl5crgyP2TRRWgXLDINJGB0yJX4/t1U8v+IcQXCA7wcqEb3JjP/aYBtu9mWfxVAPihE3oK1B74h2BC+ll3lAG7Z36T3ye0COJklo/NTkWqEmzJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZGDO9/1x; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-323267872f3so3077543a91.1
        for <linux-acpi@vger.kernel.org>; Sun, 17 Aug 2025 21:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490290; x=1756095090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IxaxQZbw+AC3BjTY55nvhFvXIFWhep3DUcNY2js2p4=;
        b=ZGDO9/1xh5tEcWlSzn2jJTDILqDiXA0J16cmqwpxmyoQTsQvvV07zGnI22+Va3veyV
         jxXM+fVSMmlpIOEQfLKXZd0jmLoA/ITqIu33G7dCPOcfPEJV7pbqsAosnil//cb2st4e
         B5P1LjR7JVwrUgZAw+JsiQ3gC52ZWx4krVZa9CAMy6kHYxKd1s/PH/c4GIKuGZA8lcDJ
         X5BvO8njBtnodLXkyzjHxhAmpXmrckQlGY2eJhV2ml7HuN+fh9z3di42vGyZdSeWzCzu
         0eufw5FH199mgqhS+tukCMNYBv2hg2pAigc1rpVz6hTStRO/cfhogoRXrKhy1eIfy7bE
         SSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490290; x=1756095090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IxaxQZbw+AC3BjTY55nvhFvXIFWhep3DUcNY2js2p4=;
        b=b340EBMSQ1YlqzmTK7mB1w6PUyutUksYq9ChqnojoRpjjyskPFCB1GiXTHgX9rjOYx
         7Ylij580x2yNLKbZZHG6PAR1Z5pUvACcqXnn3Fbgmp89MGjawbbAVZhCGBc8K/vdNY3f
         cVsF/4FZXhPHVvTfMB/kvNHC33AS238ObqxWUo1NyUsXDIRnfOJuyF6SzzIre8eIW0sz
         zBfNEOMphByaUQgwXqdPuZQErcX7tNGXA8Xfwum9uUJY1XZ+0Gqfu3vdMfylmxA7OpYH
         wecXdwt6EYsAfe6p0tOASDDJOQA1Okd8fgcA2ScLhyWmvrloRtRb25H60XjT6zVta0CV
         DreQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCmg7ajHYtM03IHx8blSnN30bAcN9t3GsN8dLfQKIJOB3CVrwZQuc3T/4p/qv9I1JhsnItPHt2QHm+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8qMEW+qD54lFmNgxp8AIJz3afw2812uAE8HTRqizdbvD1eVFg
	VYZC5hlV0AKnyx9gaIE2v1UimT5wUyL7jNm4XDe2V0ATOyADDhjkygGL/VStvwU6BXU=
X-Gm-Gg: ASbGncvVVUhFH7CuhLu2khUk5KGQh9sr4DoWd1td48Vp14Co3F200+yCax1oBYZ/csT
	HkQ64WcLqCEwt6tAPCh235+6dM7E0RM01taFnAuYNm24+8jNtOR5v03CcwPA2kbcSqJYKvBRNKQ
	R0LuL5TpSMrWuAGXnnhhZnsejCRnhJdA8PqYBuTFEZMcGn6bRSCleA7xeMQAHqQdzi0ScZGchwI
	nwIDB7hI4y2h+97bZsxVQGAnqXvBHDjk/EVINYcT169VJ/KK+kLZl+yJZJi0xXVzS4uE0MNMS19
	pAq58UbjdTV2Unz3RAXd3M4BxR7qWsTX9t4yDUevn1GfkrBDRFv5YuTQeMKYIm6yI5O6llJcY/c
	8DFs3HIbsoj1BKc/eNxhopNNBh2SFhdWwlWYI9VcxrHyaK/bfHjx9xQ==
X-Google-Smtp-Source: AGHT+IEx20S6ky6rtfFr5Vx3GDvYWyrNWSJeG+7fV/aDTWX+4stRqLTa11/6tvl8LFbqHB2Ddmk36g==
X-Received: by 2002:a17:90b:2dd0:b0:31e:f351:bfec with SMTP id 98e67ed59e1d1-32341e5e0a4mr17572577a91.0.1755490289973;
        Sun, 17 Aug 2025 21:11:29 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:11:29 -0700 (PDT)
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
Subject: [PATCH v10 10/24] clk: Add clock driver for the RISC-V RPMI clock service group
Date: Mon, 18 Aug 2025 09:39:06 +0530
Message-ID: <20250818040920.272664-11-apatel@ventanamicro.com>
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
 4 files changed, 641 insertions(+)
 create mode 100644 drivers/clk/clk-rpmi.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 4d56475f94fc..4d51fa589c1e 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -501,6 +501,14 @@ config COMMON_CLK_SP7021
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
index 18ed29cfdc11..b74a1767ca27 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_COMMON_CLK_PWM)		+= clk-pwm.o
 obj-$(CONFIG_CLK_QORIQ)			+= clk-qoriq.o
 obj-$(CONFIG_COMMON_CLK_RK808)		+= clk-rk808.o
 obj-$(CONFIG_COMMON_CLK_RP1)            += clk-rp1.o
+obj-$(CONFIG_COMMON_CLK_RPMI)		+= clk-rpmi.o
 obj-$(CONFIG_COMMON_CLK_HI655X)		+= clk-hi655x.o
 obj-$(CONFIG_COMMON_CLK_S2MPS11)	+= clk-s2mps11.o
 obj-$(CONFIG_COMMON_CLK_SCMI)           += clk-scmi.o
diff --git a/drivers/clk/clk-rpmi.c b/drivers/clk/clk-rpmi.c
new file mode 100644
index 000000000000..7a0a62456314
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
+#define rpmi_clkrate_u64(__hi, __lo)	(((u64)(__hi) << 32) | (u32)(__lo))
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
index c3a98fc12c0a..8176d33747fe 100644
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
-- 
2.43.0


