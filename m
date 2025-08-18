Return-Path: <linux-acpi+bounces-15764-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BACB297BD
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 06:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0644E50DD
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 04:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45185262FE2;
	Mon, 18 Aug 2025 04:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="EAR7uB4B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9939925DAFF
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 04:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490250; cv=none; b=WFQXp0hjWnMw9ly5cq86+uOkmFGmLZ0SG2LulCuqwzp8IXwrESvdMuo06FG7PnMa1NJ3Ew3P9+aWz1Q9BN8d91BbdBiqWWKQ5Jimk/MWyUo4LaLQaboQqMmf5IqtCnYNtLGpz+d+GsqRXy2v6WCgTyf/DDtgZGpQKtIj63Enyys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490250; c=relaxed/simple;
	bh=2D2pCQzookgwdAAtHFuVK0XP30EwZIqIZ0Ic1dDvTa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O98rdxaU9QWWmaHvSmzSE2y57djwRzQvBO0OmIfDFzep0jYbDdpP9lRz/pbikzwOyMUDiZ/Nr1hTnhu0vPMVoSTB2Vm9/SNhnh4lNki+VbOzkzK/h1wjosd58DYCMUSVlG2Y4MBiymmAugB7UMOPhV/8p1OQodRJp0/Guz4N2vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=EAR7uB4B; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32326e71c31so3274994a91.3
        for <linux-acpi@vger.kernel.org>; Sun, 17 Aug 2025 21:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490248; x=1756095048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIg/1GBTKsBFC54o9wzP/NH34EZtppmVu7UpxaXegaQ=;
        b=EAR7uB4B0uhBaptLQBBOYmlsjgoXfIWMehzY94FnA7VY6KzZAKjq67Rm+fzsxrN4S1
         AN6L9uQOW3pIB2vVs/O5kdcqxHDqt/MTPXfqYAC7VTVczi1gk65t5WpYjJWLIxRrGOAR
         3xJxJJhwv8CGHloHO7VKWN3BCsc5I68vX1qYdGVwAOFS8xy9HX+2UA4MktM9ysX4lD9M
         2139uLSXSjAgc5RscTgvhyak9rV1GOv+dxt88LC57q0G8xmtW79k1R2o5LDHGwLfGIwc
         YSGxKO4hEg13Arv/TB+cK+PHiXsGlBcJZDBy+M0+aD4leFhb0pVJkxqiJVnrhKOyqghT
         hYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490248; x=1756095048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIg/1GBTKsBFC54o9wzP/NH34EZtppmVu7UpxaXegaQ=;
        b=giVOl3+/4G52lWPFqOn4bFLnDmzvtZ8K07dNdcTAhJIMkjHqjFd+h6OIDXJ1FM2LY0
         9k3Ip4o5A20WmO7rPoE7Gx+tkoepaHs617p5n8i4S2dxWV5kNPf7gKxZoP/OPHzVooj0
         jK2MgwlxJOc0Qp6NW23NAiSWgb0H3k3yXrrONLVXkF9qqfVoZhZNWouGF/+0467l45it
         fr9kRe68RPj3UXx8clUT8uUYOgYgLZeQpKOH9Saa/XMA3wDF8Nooh5LaaTtKo6BbPNA0
         c57GrpNX8dcD7vXIFxitSYwdpWbHp6FNyVV4X54IzOd37lW0iPy17LCj1252e1XxNEMz
         MhKw==
X-Forwarded-Encrypted: i=1; AJvYcCWDTwifkepBw1qCx89qx7aGU9ISkVa0ch/sX0qkNq1mtX4knm0H02Sm8LpoMKqF6g7bQPexSE4BXYHv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+eo0R9txecfu8p7HVYFpYDwFwmIcz5w/ZJUZ/DWuzFSGAILs4
	iJaxEcCfzAN2yQf2goiCKLIf2wkg+wby2voXN/+EIHO7paud/02T8Lwg66MumRyOzU8=
X-Gm-Gg: ASbGnctgIE85/R34sz/4y5GOz6dMUFycIQHfHWAmqOn9K5XPCmJwUU7X8u8d5aMjdcD
	UZ9YSaHJnmxYArb6dderkhmc4CbgN1LHH2Kh1pvixFDqrdqpZEhJ1WHsrIRD+LuYL6sNo2MD+X8
	RkzAxg1wLBHCfgxQ1lJDYkzeJo2ggskTYfpDJC3/H156NcOxyuoff2fH4YTxi+0GlY4OxPlmT2/
	vTznCzGarbMuS2TqkSTXr9y98BOK+vwGvpNudf/LPYCZjSl/ps5ezG7ZSprb8ZN37USSIapmlzT
	ryaAiQQu1SNbiluE24TbJlegfBYRRW5QvB2ZkNaWt0Iaa/X+/AYhIS1GEEzl8JR+85/hWQtnews
	7Bg99pCBdiiCL9H8PWF/dLvw9cRsp55hsxyaoP/La8PGUHtM0h/z7vgGvZxi5HAa7
X-Google-Smtp-Source: AGHT+IHJ3B7/FGCREPXx9KMsbgx8NNPqJm1e+gxc7+HhFbA/BztdLkupGr7S+vIlvSPnuVpfBIXkZw==
X-Received: by 2002:a17:90b:1d05:b0:321:38e0:d591 with SMTP id 98e67ed59e1d1-3234dc3b068mr11877319a91.17.1755490247738;
        Sun, 17 Aug 2025 21:10:47 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:10:47 -0700 (PDT)
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
Subject: [PATCH v10 05/24] mailbox: Allow controller specific mapping using fwnode
Date: Mon, 18 Aug 2025 09:39:01 +0530
Message-ID: <20250818040920.272664-6-apatel@ventanamicro.com>
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

Introduce optional fw_node() callback which allows a mailbox controller
driver to provide controller specific mapping using fwnode.

The Linux OF framework already implements fwnode operations for the
Linux DD framework so the fw_xlate() callback works fine with device
tree as well.

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/mailbox/mailbox.c          | 65 ++++++++++++++++++------------
 include/linux/mailbox_controller.h |  3 ++
 2 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 5cd8ae222073..2acc6ec229a4 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/spinlock.h>
 
 #include "mailbox.h"
@@ -383,34 +384,56 @@ EXPORT_SYMBOL_GPL(mbox_bind_client);
  */
 struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 {
-	struct device *dev = cl->dev;
+	struct fwnode_reference_args fwspec;
+	struct fwnode_handle *fwnode;
 	struct mbox_controller *mbox;
 	struct of_phandle_args spec;
 	struct mbox_chan *chan;
+	struct device *dev;
+	unsigned int i;
 	int ret;
 
-	if (!dev || !dev->of_node) {
-		pr_debug("%s: No owner device node\n", __func__);
+	dev = cl->dev;
+	if (!dev) {
+		pr_debug("No owner device\n");
 		return ERR_PTR(-ENODEV);
 	}
 
-	ret = of_parse_phandle_with_args(dev->of_node, "mboxes", "#mbox-cells",
-					 index, &spec);
+	fwnode = dev_fwnode(dev);
+	if (!fwnode) {
+		dev_dbg(dev, "No owner fwnode\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	ret = fwnode_property_get_reference_args(fwnode, "mboxes", "#mbox-cells",
+						 0, index, &fwspec);
 	if (ret) {
-		dev_err(dev, "%s: can't parse \"mboxes\" property\n", __func__);
+		dev_err(dev, "%s: can't parse \"%s\" property\n", __func__, "mboxes");
 		return ERR_PTR(ret);
 	}
 
+	spec.np = to_of_node(fwspec.fwnode);
+	spec.args_count = fwspec.nargs;
+	for (i = 0; i < spec.args_count; i++)
+		spec.args[i] = fwspec.args[i];
+
 	scoped_guard(mutex, &con_mutex) {
 		chan = ERR_PTR(-EPROBE_DEFER);
-		list_for_each_entry(mbox, &mbox_cons, node)
-			if (mbox->dev->of_node == spec.np) {
-				chan = mbox->of_xlate(mbox, &spec);
-				if (!IS_ERR(chan))
-					break;
+		list_for_each_entry(mbox, &mbox_cons, node) {
+			if (device_match_fwnode(mbox->dev, fwspec.fwnode)) {
+				if (mbox->fw_xlate) {
+					chan = mbox->fw_xlate(mbox, &fwspec);
+					if (!IS_ERR(chan))
+						break;
+				} else if (mbox->of_xlate) {
+					chan = mbox->of_xlate(mbox, &spec);
+					if (!IS_ERR(chan))
+						break;
+				}
 			}
+		}
 
-		of_node_put(spec.np);
+		fwnode_handle_put(fwspec.fwnode);
 
 		if (IS_ERR(chan))
 			return chan;
@@ -427,15 +450,8 @@ EXPORT_SYMBOL_GPL(mbox_request_channel);
 struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
 					      const char *name)
 {
-	struct device_node *np = cl->dev->of_node;
-	int index;
-
-	if (!np) {
-		dev_err(cl->dev, "%s() currently only supports DT\n", __func__);
-		return ERR_PTR(-EINVAL);
-	}
+	int index = device_property_match_string(cl->dev, "mbox-names", name);
 
-	index = of_property_match_string(np, "mbox-names", name);
 	if (index < 0) {
 		dev_err(cl->dev, "%s() could not locate channel named \"%s\"\n",
 			__func__, name);
@@ -470,9 +486,8 @@ void mbox_free_channel(struct mbox_chan *chan)
 }
 EXPORT_SYMBOL_GPL(mbox_free_channel);
 
-static struct mbox_chan *
-of_mbox_index_xlate(struct mbox_controller *mbox,
-		    const struct of_phandle_args *sp)
+static struct mbox_chan *fw_mbox_index_xlate(struct mbox_controller *mbox,
+					     const struct fwnode_reference_args *sp)
 {
 	int ind = sp->args[0];
 
@@ -523,8 +538,8 @@ int mbox_controller_register(struct mbox_controller *mbox)
 		spin_lock_init(&chan->lock);
 	}
 
-	if (!mbox->of_xlate)
-		mbox->of_xlate = of_mbox_index_xlate;
+	if (!mbox->fw_xlate && !mbox->of_xlate)
+		mbox->fw_xlate = fw_mbox_index_xlate;
 
 	scoped_guard(mutex, &con_mutex)
 		list_add_tail(&mbox->node, &mbox_cons);
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index ad01c4082358..80a427c7ca29 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -66,6 +66,7 @@ struct mbox_chan_ops {
  *			no interrupt rises. Ignored if 'txdone_irq' is set.
  * @txpoll_period:	If 'txdone_poll' is in effect, the API polls for
  *			last TX's status after these many millisecs
+ * @fw_xlate:		Controller driver specific mapping of channel via fwnode
  * @of_xlate:		Controller driver specific mapping of channel via DT
  * @poll_hrt:		API private. hrtimer used to poll for TXDONE on all
  *			channels.
@@ -79,6 +80,8 @@ struct mbox_controller {
 	bool txdone_irq;
 	bool txdone_poll;
 	unsigned txpoll_period;
+	struct mbox_chan *(*fw_xlate)(struct mbox_controller *mbox,
+				      const struct fwnode_reference_args *sp);
 	struct mbox_chan *(*of_xlate)(struct mbox_controller *mbox,
 				      const struct of_phandle_args *sp);
 	/* Internal to API */
-- 
2.43.0


