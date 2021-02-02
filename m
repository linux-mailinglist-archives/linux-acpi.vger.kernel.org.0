Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C2A30B68F
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 05:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhBBEfX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 23:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbhBBEfN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 23:35:13 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F558C061794
        for <linux-acpi@vger.kernel.org>; Mon,  1 Feb 2021 20:33:57 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id l3so12847469qvz.12
        for <linux-acpi@vger.kernel.org>; Mon, 01 Feb 2021 20:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fMDPsdN1ZsR+zEXg9vJD+kFHk1s81WX1B2VgmiFlBCo=;
        b=kBhq9REpBAd7ecLk9Jawox2iOV27IIaou7U+h8FdHl3tKJ+8OuOiVWL1TLPn1sAJob
         S3kipKVYJOreVXp1C0tRwvAEnm9KrukjocZmEP/6E6pPai7bCWO9+TBZ2bq+btf9ARsy
         T8iL+08BAW57yk9Ncn0OzLEiJb5aiBZ3LW/ZJLDNvbfHvnNTcClJGvvHM4edcXnK7OuA
         6Ch1aQr/L0VITbwW4JDKzpmLnyIsf5suQwqf3+tpYu6NbWycYFxRDzYq+MEQwWpyrLVH
         puxdl0wHwS2bTF37MLGEsfqcL6UeCikXYxciMVwOBMhaah4DLi5KahLpsKNPrqpYt7dx
         KKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fMDPsdN1ZsR+zEXg9vJD+kFHk1s81WX1B2VgmiFlBCo=;
        b=NwNs68lt8N1q6/EKjm3XuCODhKZnavfy4oG9u8CQx3o3oiXbys18qrk6ek6qpkYxhS
         CtKAa8bklfdOi5UiHPZMY3/vVHz7Y2Mb1r4zwkTsot/XvLW9HAZvvSvrtjUyFRfC6uOG
         MbiwENpsMS7oK/Mu2ZGi9JcYitjUQvdX2ehbjG8htrxWfxSrVdb58dIaJk8yJ8vsOdaZ
         p0hYHMfidXMmTuI6eOKff6m1ylmq5bm9bI0bjUDx4yv+nfHwI3q8aHiF1XC4bP98YVUS
         gOngR2YPBbUVyvkCsKH3Qc37Ujs3QYcvhyLplpxmnB6gptBLQzVo+az/8yh9J17Phe6d
         TeHw==
X-Gm-Message-State: AOAM533y5adLHQojol/80o8WmzgQlmDeIFVvluhqMNaoSpGKl3ocP8ms
        ZJnEJdKe9RDLbfla49VMHkh4SmQkcliu4BM=
X-Google-Smtp-Source: ABdhPJzHvEj75X5szruTCWmF8w/9HppeFOuSREVIs5ZrGRAhyKWYecJZfOX15QkY03woWIHTXVPcIfb8EubTbAs=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a0c:e0ce:: with SMTP id
 x14mr18341659qvk.48.1612240436319; Mon, 01 Feb 2021 20:33:56 -0800 (PST)
Date:   Mon,  1 Feb 2021 20:33:44 -0800
In-Reply-To: <20210202043345.3778765-1-saravanak@google.com>
Message-Id: <20210202043345.3778765-4-saravanak@google.com>
Mime-Version: 1.0
References: <20210202043345.3778765-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 3/3] of: property: Don't add links to absent suppliers
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If driver core marks a firmware node as not a device, don't add fwnode
links where it's a supplier.

Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 6287c6d60bb7..53d163c8d39b 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1103,7 +1103,9 @@ static int of_link_to_phandle(struct device_node *con_np,
 	 * created for them.
 	 */
 	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
-	if (!sup_dev && of_node_check_flag(sup_np, OF_POPULATED)) {
+	if (!sup_dev &&
+	    (of_node_check_flag(sup_np, OF_POPULATED) ||
+	     sup_np->fwnode.flags & FWNODE_FLAG_NOT_DEVICE)) {
 		pr_debug("Not linking %pOFP to %pOFP - No struct device\n",
 			 con_np, sup_np);
 		of_node_put(sup_np);
-- 
2.30.0.365.g02bc693789-goog

