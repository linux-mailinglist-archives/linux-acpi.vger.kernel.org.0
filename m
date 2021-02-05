Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F5E311882
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Feb 2021 03:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhBFCjX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Feb 2021 21:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhBFCe7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Feb 2021 21:34:59 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4C3C0698E6
        for <linux-acpi@vger.kernel.org>; Fri,  5 Feb 2021 14:26:54 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c12so8705604ybf.1
        for <linux-acpi@vger.kernel.org>; Fri, 05 Feb 2021 14:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=j8xLJ/gRsabqXmVqApH6UU1AJY7QICocc5XvPOoh2CA=;
        b=E5sFvJO7MoqTQ5HU1iZRDkvKf3YEJnMxgLBzB4Bdzzu+OwTihKotepF9+vecFbKNIx
         RMScWAE2zE8rfvaCnxQasMRx1b2r+VjvXf9v4q+HNHmXZS+zJmKBYlJ1jOnNKPkYLUUx
         +9C9RV4z0aszLyrKr2OQQUAT3XhAqGUElzBIGIsskZIGV69KYaqaW83ucTaO/doqcRq5
         aA1hFJJYjJVvodQlIzs4Yf6qBGi+RWhj71EWMUCnJT+YB8Jg9U54RCqfkCTP8s/4Q2lH
         nfjbItiLvc4Ce0s3du8UwLa5Sd+7cG0N/EYOX2N9Kz9ci0pHOQ3JMNDAeaGfizIIj8Tt
         OyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j8xLJ/gRsabqXmVqApH6UU1AJY7QICocc5XvPOoh2CA=;
        b=Nr4udsDSLRIyIPNXtU1uMChRwUVYbCbmesw+JS9G1kEkcV5GNVEKViFJg0XNDjJEsT
         yghiobMDyp4qAmkx/vBcWp7ZZ0PIthxBzvUXsIN5vZs6DkmR+0bNi3AMui6ZS/K3mrj3
         R6dt+cNRDVgYgSjtokXYBUtpwQHqi/2ehmDD6DI4GSOuGc4pdv/DGx6IaIO+lczvv6ZD
         xNZT22p3oQvaybHv0/nVHIFMf2L8yMTBX4dAgzGj1PQOAw4Udt1TSIXzBSd2YezJxIih
         waEpnFzjqTlOnv4OxiSWas47906GsEEb8UtGxeeAuJ68iEMnKA44nRVnQ4OEViOB9T6I
         9/3g==
X-Gm-Message-State: AOAM5311++5lk1pCH+QKqz3B7T+z1todn7ubb3kc7eJn9DVKOEd2kEE7
        lbmgbD7O4KrX7bHmFjCpCkSC3ee/LtjqVDs=
X-Google-Smtp-Source: ABdhPJwaxJzPZ4XSeGkT3P5EprKNXkjzOOR8qEj+Bd02rhMYgGuOOcL7rRwb/dvXftOqDNpM24CwbGcGHu5s6VY=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6d36:b798:55d7:f5c5])
 (user=saravanak job=sendgmr) by 2002:a25:d648:: with SMTP id
 n69mr8876885ybg.462.1612564014028; Fri, 05 Feb 2021 14:26:54 -0800 (PST)
Date:   Fri,  5 Feb 2021 14:26:38 -0800
In-Reply-To: <20210205222644.2357303-1-saravanak@google.com>
Message-Id: <20210205222644.2357303-3-saravanak@google.com>
Mime-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v4 2/8] of: property: Don't add links to absent suppliers
From:   Saravana Kannan <saravanak@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel-team@android.com
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
2.30.0.478.g8a0d178c01-goog

