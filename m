Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD66331003C
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 23:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhBDWk6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Feb 2021 17:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhBDWks (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Feb 2021 17:40:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D51C061225
        for <linux-acpi@vger.kernel.org>; Thu,  4 Feb 2021 14:39:36 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h192so4717880ybg.23
        for <linux-acpi@vger.kernel.org>; Thu, 04 Feb 2021 14:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0dbkPCei0EVZxiD/xgF8DsX5xGgDmOcId+wNtSYzaY4=;
        b=Fpa96Kq7NFETtqxrJ7hdmqTO6wZkjuxubgRR7/8v7tw0ssWWJXO00+GHBbsCaytH3N
         di/IFDwL3tNHRnlG+ZRfBlrH/Flao5qRyDIv7m8Zj5pbFF7izx3uOMZh6brCNdUyxG4T
         WnRJHR2OwpYnXpY6R/IOM+bgZ29PwcYgwfmAHxBELprTBayUssCjsKTLmN8VT2SLIND6
         FI8XNLLkV5yv3Nq7w6ulX6KqbE0We/Mv6DXgOLku0BkZjGcpGa7tVpZaKBFLzk9NHvcT
         KZC4xDAvCPuBWU3oQqZ9booDuDNuPpJ1SXQWP14XOjQ9f2ctM7X/tifJESiMPNuzcGWs
         NjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0dbkPCei0EVZxiD/xgF8DsX5xGgDmOcId+wNtSYzaY4=;
        b=d46eBUjAs9qRudqBamuFKy7+RBFayBHrx/uEki0XrUj2LrLdwtzwoKqY3cbaBaunaT
         7VQEiE8MMbdFYxAbfEDpKAr96L9gQep40sWTrH1a0WVldA2MCmEenw/AI//tHOdOWUSs
         QvLuScf5jPVOmppRg0ddcmKqV3h1Tz7hkxEDXZgPiwzG3vkpGgp8wWUqu6d8nHujKJWn
         bKwGmJjiiC/fOEkCgnT2+yvYGTZkGd+MN/vE6cAwf+obAyGbi+ndsduix9kbCMCzaIlh
         x2cMNz1ILL0JO4lifjFoBMSzqq8ly+PZcEjKs6ig0mUGkfe49KhB5VIoHmFedj2CzqO1
         tQQQ==
X-Gm-Message-State: AOAM533fLbKDR3kY8Xn42xP9aTTuWf08mJDDlU+Jm+zQqfj9QodXdcPb
        RNMrrn0yVm8h7rB8u/U7js5YPbJSA9J3Coc=
X-Google-Smtp-Source: ABdhPJzFSX+PON0ie+o6EiaxXNdvovbgxp9M0i+ykscDv1cefCl6vtAT+nFkuA4cAkgfz5AnpSUCldUZ6G7XQok=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:8475:2f1d:e8b4:f65a])
 (user=saravanak job=sendgmr) by 2002:a25:83d0:: with SMTP id
 v16mr2494628ybm.40.1612478375921; Thu, 04 Feb 2021 14:39:35 -0800 (PST)
Date:   Thu,  4 Feb 2021 14:39:21 -0800
In-Reply-To: <20210204223921.1693487-1-saravanak@google.com>
Message-Id: <20210204223921.1693487-5-saravanak@google.com>
Mime-Version: 1.0
References: <20210204223921.1693487-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 4/4] of: property: Add fw_devlink support for optional properties
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Martin Kaiser <martin@kaiser.cx>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Not all DT bindings are mandatory bindings. Add support for optional DT
bindings and mark iommus, iommu-map, dmas as optional DT bindings.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 53d163c8d39b..962109082df1 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1235,6 +1235,7 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
 struct supplier_bindings {
 	struct device_node *(*parse_prop)(struct device_node *np,
 					  const char *prop_name, int index);
+	bool optional;
 };
 
 DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
@@ -1308,12 +1309,12 @@ static struct device_node *parse_interrupts(struct device_node *np,
 static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_clocks, },
 	{ .parse_prop = parse_interconnects, },
-	{ .parse_prop = parse_iommus, },
-	{ .parse_prop = parse_iommu_maps, },
+	{ .parse_prop = parse_iommus, .optional = true, },
+	{ .parse_prop = parse_iommu_maps, .optional = true, },
 	{ .parse_prop = parse_mboxes, },
 	{ .parse_prop = parse_io_channels, },
 	{ .parse_prop = parse_interrupt_parent, },
-	{ .parse_prop = parse_dmas, },
+	{ .parse_prop = parse_dmas, .optional = true, },
 	{ .parse_prop = parse_power_domains, },
 	{ .parse_prop = parse_hwlocks, },
 	{ .parse_prop = parse_extcon, },
@@ -1368,6 +1369,11 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
 
 	/* Do not stop at first failed link, link all available suppliers. */
 	while (!matched && s->parse_prop) {
+		if (s->optional && !fw_devlink_is_strict()) {
+			s++;
+			continue;
+		}
+
 		while ((phandle = s->parse_prop(con_np, prop_name, i))) {
 			matched = true;
 			i++;
-- 
2.30.0.365.g02bc693789-goog

