Return-Path: <linux-acpi+bounces-14897-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 318CEAF0A4C
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 07:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB75A7AB2A3
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 05:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD5720408A;
	Wed,  2 Jul 2025 05:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Dq0XblWg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D571F78F2
	for <linux-acpi@vger.kernel.org>; Wed,  2 Jul 2025 05:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433286; cv=none; b=WEkL29Hh5c4OiwuRPCdabO7PJGYXTCQosql01NmHp123THhdABDreLKScW8vSacw7DgGGgsXqux6n9Qw43wgPqHO9p4+fbkoxPSHWc47HPd3zIgpdKkbG5WaBhv8YxGCY+BPcO7BoCd386Z9/j9S6vsbquQ8u6rwNWOXNsN6AcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433286; c=relaxed/simple;
	bh=eP0nLjelGbOd1owGOdUwIHJWAQpQfBfflyMTXkP8FKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ky9VdJxyyI8Ju+LyJddI3xGG/PpMOGdg0bTyOj8g0yWYdjjBC+kBGuw9lDjWQppOeNKOWbkhAvI9bnhq9ooiSvnOcP26n+Z9LgO6DlvYGGuLbjKPSqB3RgjfX1MsQfW2S/zRSljcztvtOSqcP8c2fN2ahhvz6R1755RYbnRXRlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Dq0XblWg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-237311f5a54so36409785ad.2
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 22:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751433284; x=1752038084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP6ThGaZGs8MyIgO+nprUM8QR3vfVMjtp+0dcAYkEZA=;
        b=Dq0XblWgS/84zlSmjzNjs7zph1Am4Wd0xmREaSF4C7/keZPjL69r/SMTTPbk29Qrum
         i1qPoC6gT/Lf3t8X0grrZVdRh5S0oCPRPFghJA4fSm7NQqfSsZf3DgEd+nDzio11vuZ8
         3PHydDHH6ab9m5rX0oPOAgZqnC0XBz3AWUiDcCdGh7p9AWnNg9Seu1wmxkUqv7M9iCwz
         q/Iok2gVgk7k2xW2eOR1flcGBVxS8hMLppyFx7Nak4BcDO0wG7jahuzxe9nIIBVS0nI5
         /MhPLwxFBjsWi5OV4OoTZ7dE9PuFzK4J1i/Na85D2ppNdvSTLF0t1wR8dYwhuVXw9834
         R6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433284; x=1752038084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oP6ThGaZGs8MyIgO+nprUM8QR3vfVMjtp+0dcAYkEZA=;
        b=PNQKTCJBNo1UB7YkGirdzKAErxkl+7aPlCZDtynsE84XayYlUUFWEo4mlGoLEvV29V
         gqYRhpKctqhVdonZ+hU6VBOYOdCV3w/STpXAjM85Krh0gUbzfsDfHm0/QE61oO/wk82U
         cIImBWh3rM7sILWWUkwjgMhdlQSvN4kKg89DRKgXG8ElScGRuunDLvgts1Id2JQy5FxM
         RabaGvWAqlWhM+QEVmcOqcJzpBih+ETHeAauSV/Zl4aiK8JgIGnnz6JIc+zwotN6OW7C
         hpqm9vPSYvkB8w4AT5UQn7ecDxWZWx39iFdu2jGIOULcr8WvVMVaI0UCz3D38VD88SS0
         xIOA==
X-Forwarded-Encrypted: i=1; AJvYcCWAQ4cS3i087AHi1bRmgfMN4UA5pmwnLbKktTKfSKYwe6EQCYgKSZ2nCQ5E68vvJwnPrhZLDfxNbxI1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9FoQqGXIINTcj1kXtXpLp+9+x2fnQUX2/4duoeq2fR6H2RNBK
	loBmtmn1HF7lALDat6M3OUkhAaX2ovCGv7rF+flu32ZgHTIK1Rbtw9BUqzrGaGfqx8s=
X-Gm-Gg: ASbGncvPvJb8bFdRj+exAVn62JeZ6C0SkuEKODF6Scs0QQqtdCP6eS8dKShNojn3dL7
	y2O0M5bKQ/fO+vIK6Q/Yz3NakN0CFGEeu9r3JJ4tvr9/nJfFu6CvjElgMrFJtL55tldZTfY3amF
	c1wKRYe6ASfY1UkPywE3trbmNo2pbXf0kICieTuVlhu89t8NCyHUOOrbIQqvU4CfNxGC/VHLI3N
	YFd1tO5Eg1y7bJoeULC6hXY7xInqegBPNI7PtfsIgNuTqIX8cZTlgrV3d4vl4sdpxFb1+mLDLRG
	3qJj0n4RHzKu6PokKf1kCLLK27Uni+IEKhtMKh8TyetIZdLGW6rAjvVLyL26vY0l11pxgUAAaWn
	lNKQ5GDbLXVzfR4JT
X-Google-Smtp-Source: AGHT+IHW6+yjygzJaRYVJbk398vw/ZCnNjzG8uYmd5NcS+WaiG0hLE/XIX5nmwnliNsaVR742l1nrQ==
X-Received: by 2002:a17:903:1a2e:b0:232:59b:58fe with SMTP id d9443c01a7336-23c6e4d6e93mr19975825ad.1.1751433284391;
        Tue, 01 Jul 2025 22:14:44 -0700 (PDT)
Received: from localhost.localdomain ([14.141.91.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c6fe31933sm4719595ad.220.2025.07.01.22.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:14:43 -0700 (PDT)
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
Subject: [PATCH v7 05/24] mailbox: Allow controller specific mapping using fwnode
Date: Wed,  2 Jul 2025 10:43:26 +0530
Message-ID: <20250702051345.1460497-6-apatel@ventanamicro.com>
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

Introduce optional fw_node() callback which allows a mailbox controller
driver to provide controller specific mapping using fwnode.

The Linux OF framework already implements fwnode operations for the
Linux DD framework so the fw_xlate() callback works fine with device
tree as well.

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


