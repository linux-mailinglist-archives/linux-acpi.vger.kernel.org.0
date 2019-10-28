Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5F95E7C18
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2019 23:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfJ1WAu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Oct 2019 18:00:50 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:50804 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390646AbfJ1WAr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Oct 2019 18:00:47 -0400
Received: by mail-pf1-f201.google.com with SMTP id y191so9673215pfg.17
        for <linux-acpi@vger.kernel.org>; Mon, 28 Oct 2019 15:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ukpi3nf6Ccj0NPps1DEia34Fh1Y1K6ULN6sRoVS7jm8=;
        b=bb0GM5MSoyGi8NIAFn3/DHCH0XRkiFMVmCUChuT7/6zrAVzgyDGF1auYVOJfhs7H/u
         S3HfpZziQ/hoFGtHmgHyvXzazBa9Cc5N56+oTe5Lscdb0DLcHLMFCCiaePTsB+44MMB6
         v6zrjCnxUzbwrqUWvmF2m+N7pAFfATDmAzkkU4lqZLEg+cQTgkkKC4fel6CXRZxiEbz3
         KssYpg4ZtqO2QAYwMeSPe4WIjHIBaUJXkGfrxA78Ij4kOUAYeVvue/tWc8UKceu+u4S+
         +TKgVT9pbpEA+kPuvaDXktiGBu2cLNAKUXwS+RCQt8TWnlJw2hA9OLRDI5H1h///ekhR
         cgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ukpi3nf6Ccj0NPps1DEia34Fh1Y1K6ULN6sRoVS7jm8=;
        b=ji8zFO0MXkK4yXy2Jn1mMvpWERJ3ifkwMWQX6IscVgiscxuaBosUkZuvr9jhPh4HOP
         ZGL7gzi+NyaGTgENDO5BGJKDqk5M7BC6OD6zEzDgQvKjpdfO3WbQZruaey6IFKdtswgy
         yQOzxDfpsurVrQedzs5AYthiCVt5jMMwqtxdHOsDIFtB56smbcyFJobQH0hwFny3X7Wy
         qM/G4enLfvr80gFV2KXkwfP6JWeS0kU3p6xrDZPUdqEi8PmW645PX+pLdHS/gqqX1glC
         NlC8AojMv3HLnKqs1cP/oFe0H2Chb2+PtvWzrUoPtOqU5hzCw0LzjEpWzKpCwowa+k+/
         m9Yw==
X-Gm-Message-State: APjAAAV92JOvVCW3F5to3devs/V5SPzpIwtcPh9wtgJAHqyUGdB8ZnBh
        oMYXl4o/j9at+agiUXehMmx9FDVgjXMPMTM=
X-Google-Smtp-Source: APXvYqwSzFW+0pdVmCL1Iwg9wofXL1u2TvqvPQ2942w6raECJ/0R34lyrQI5HBJOGEpOyS+HE2reeybrz/Jjv1k=
X-Received: by 2002:a65:6092:: with SMTP id t18mr23294242pgu.418.1572300046743;
 Mon, 28 Oct 2019 15:00:46 -0700 (PDT)
Date:   Mon, 28 Oct 2019 15:00:26 -0700
In-Reply-To: <20191028220027.251605-1-saravanak@google.com>
Message-Id: <20191028220027.251605-6-saravanak@google.com>
Mime-Version: 1.0
References: <20191028220027.251605-1-saravanak@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v1 5/5] of: property: Skip adding device links to suppliers
 that aren't devices
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some devices need to be initialized really early and can't wait for
driver core or drivers to be functional.  These devices are typically
initialized without creating a struct device for their device nodes.

If a supplier ends up being one of these devices, skip trying to add
device links to them.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index f16f85597ccc..21c9d251318a 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1038,6 +1038,7 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
 	struct device *sup_dev;
 	int ret = 0;
 	struct device_node *tmp_np = sup_np;
+	int is_populated;
 
 	of_node_get(sup_np);
 	/*
@@ -1062,9 +1063,10 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
 		return -EINVAL;
 	}
 	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
+	is_populated = of_node_check_flag(sup_np, OF_POPULATED);
 	of_node_put(sup_np);
 	if (!sup_dev)
-		return -EAGAIN;
+		return is_populated ? 0 : -EAGAIN;
 	if (!device_link_add(dev, sup_dev, dl_flags))
 		ret = -EAGAIN;
 	put_device(sup_dev);
-- 
2.24.0.rc0.303.g954a862665-goog

