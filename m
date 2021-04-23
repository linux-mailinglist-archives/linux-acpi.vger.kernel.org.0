Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78C0369AC8
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 21:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243582AbhDWTNd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 15:13:33 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:38577 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243438AbhDWTNc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 15:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619205175; x=1650741175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jFuDhHYlk4Hbe7hxXEZVh5/8lcG8Pt1iwjMqBmOsjHo=;
  b=EreihZ3F704GpceiQ0iv/9JadYDYUR/JhU5nmaFtxxxlEkMQzU60sdT+
   W7U0KDjJyItQoQXA1h/SE+oGb4xGvqJcapLmT5+Y8VgiFt87xFi4baq1V
   0SNkLScP0KjkJu4DlFCgahCfo70fv3W00YzMo2Vh83JkubAonn9uFMUb4
   jU0Qm20SMns+cRenotTnNkWaTbIs8mcBhobQe4TbOQ2v/TWetNr5VFZuQ
   BmcSxZ11FaVN6YOxFR/DJjmBh6W+gY30HrBxtOeBoaYztIGhDnb3/0ctI
   FixIcDje7DDpxyoEXnE5398cjJ7pUIO+5g1X9kWjI1SY1axVVQvhQ4jXb
   g==;
IronPort-SDR: iswriVtSl3G3gGsMS8xI4euUYDVEiXMH63Y/UlX7oorC41kfc88e3tHpAcX2OzOPGD8yrdhwQf
 AgOJsG4SCp64VeZ0pZy+SDtnZfLAA3aJlfSWMONdBfBt6uD6b7eAQPFOGAhjpIhlMeI+QPlrLi
 AXjkenfK8RDewftHsZ4ChzC8ohe5/gJIOL+RkcCoJnqs09BYMNByFA9WktjuxSVUwxlah4JIBa
 MRmDra2t1zjatZUjQ2FvFlGWQipNP8fNajlUKgQEGj+U/0Gi0s0E/hVpB44fmFjdNzFhZAWkPY
 cPY=
X-IronPort-AV: E=Sophos;i="5.82,246,1613458800"; 
   d="scan'208";a="112001288"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2021 12:12:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 12:12:46 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 23 Apr 2021 12:12:39 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <nsaenz@kernel.org>,
        <maxime@cerno.tech>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <khilman@kernel.org>,
        <ulf.hansson@linaro.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>, <maz@kernel.org>,
        <tglx@linutronix.de>, <saravanak@google.com>,
        <geert@linux-m68k.org>, <nsaenzjulienne@suse.de>,
        <linux@roeck-us.net>, <guillaume.tucker@collabora.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <nicolas.ferre@microchip.com>,
        <claudiu.beznea@microchip.com>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <kernel-team@android.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] clk: Skip clk provider registration when np is NULL
Date:   Fri, 23 Apr 2021 22:12:36 +0300
Message-ID: <20210423191236.265996-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210423171335.262316-1-tudor.ambarus@microchip.com>
References: <20210423171335.262316-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

commit 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is added")
revealed that clk/bcm/clk-raspberrypi.c driver calls
devm_of_clk_add_hw_provider(), with a NULL dev->of_node, which resulted in a
NULL pointer dereference in of_clk_add_provider() when calling
fwnode_dev_initialized().

Returning 0 is reducing the if conditions in driver code and is being
consistent with the CONFIG_OF=n inline stub that returns 0 when CONFIG_OF
is disabled. The downside is that drivers will maybe register clkdev lookups
when they don't need to and waste some memory.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is added")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
This would be the second approach, where we don't return an error when
one calls devm_of_clk_add_hw_provider with a NULL of_node, but instead
we just return 0 and skip the logic in the core and the drivers.

 drivers/clk/clk.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index e2ec1b745243..5d10da3519ac 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4540,6 +4540,9 @@ int of_clk_add_provider(struct device_node *np,
 	struct of_clk_provider *cp;
 	int ret;
 
+	if (!np)
+		return 0;
+
 	cp = kzalloc(sizeof(*cp), GFP_KERNEL);
 	if (!cp)
 		return -ENOMEM;
@@ -4579,6 +4582,9 @@ int of_clk_add_hw_provider(struct device_node *np,
 	struct of_clk_provider *cp;
 	int ret;
 
+	if (!np)
+		return 0;
+
 	cp = kzalloc(sizeof(*cp), GFP_KERNEL);
 	if (!cp)
 		return -ENOMEM;
@@ -4676,6 +4682,9 @@ void of_clk_del_provider(struct device_node *np)
 {
 	struct of_clk_provider *cp;
 
+	if (!np)
+		return 0;
+
 	mutex_lock(&of_clk_mutex);
 	list_for_each_entry(cp, &of_clk_providers, link) {
 		if (cp->node == np) {
-- 
2.25.1

