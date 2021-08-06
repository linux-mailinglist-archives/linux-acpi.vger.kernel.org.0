Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F9B3E3182
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Aug 2021 00:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245442AbhHFWJd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Aug 2021 18:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239019AbhHFWJd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Aug 2021 18:09:33 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B03C0613CF;
        Fri,  6 Aug 2021 15:09:16 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n12so2749756wrr.2;
        Fri, 06 Aug 2021 15:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U+w3lXB2hzuJmWQKE0Bh8lOKq0x+eCrRICMF6HvQuy4=;
        b=AR6iq6SyCBxDMmTf+J80VgzIcoH0rrkrZrWDtEr7oMQXuIJ+Ofl109DG6vdde4pZEC
         /TD/npyfQ7J3ZERLxohOb8q5Ly8MCDRxCdNJWsPF6MSIzFzzapd9p2RBONjU1IT6e7kR
         bqLAjo3avCxF8W4b9xbvyMVzzaeTgKh+tJxFms5V01VT2cxe9/PKy/0M00fCI4Basdu6
         q2wGJRCK90/hD26EynCqkn7Rx58INpWuGKn8PomMpGbPBaq0+TCP9sAivsgvsBZvfaHC
         CCviICmAkVm6hZPdFIhNcNVNa+KV2aADpdE/5TIp5x3sw3lBicKj4c7B3LxfyscvRpWv
         q26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U+w3lXB2hzuJmWQKE0Bh8lOKq0x+eCrRICMF6HvQuy4=;
        b=Ke/cQ8UcC6b/Rlkhg703lHf3fU15q+CXR6Efr6N/VVy5NSuMwZLie9cggnJLnq4EVE
         z1+zTyEb/rB0kqKbdXG7NLhdB+3vmy3o5/doKD4pzYKImfNUQ5kBgWP1tCrYf6WOpjAQ
         IoJHqCFS1FE4FxmEpfYOMwKzuOlakLy4MV0ZqQrOp4OXOY+JW92V1usFpxSWnTCcxnKZ
         27XxCuJA5zUsVWlxpBsY5EkAuGRSDPTX5rqZeZG0m/crd+VvBhQqTU9/LG0zZArPGZAQ
         EM00utaVMHCItGjMjs/HJ113hTZWsbhkMQ3QU21pja24UkJmtyB2X2Bcu7QPgpXrNIXn
         yP4A==
X-Gm-Message-State: AOAM53193YPb/81pdWUUsag6KslgpE8MyGevAA2JNq/PcAO17hjpF6+V
        bJtR2bpxmYGghmpJujEhJpalO31rbJ8=
X-Google-Smtp-Source: ABdhPJxyx0BoPYh+lrQIkpxrxXJ5e5fxiZ7vYYRbODsw8aRIDt5NVYrNLxxp9KeY7eEC/HyqIHBJ6g==
X-Received: by 2002:adf:e60c:: with SMTP id p12mr13009984wrm.285.1628287755514;
        Fri, 06 Aug 2021 15:09:15 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id y21sm12764204wma.38.2021.08.06.15.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 15:09:15 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH RESEND v3 1/2] device property: Check fwnode->secondary in fwnode_graph_get_next_endpoint()
Date:   Fri,  6 Aug 2021 23:09:05 +0100
Message-Id: <20210806220906.326758-2-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806220906.326758-1-djrscally@gmail.com>
References: <20210806220906.326758-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Sensor drivers often check for an endpoint to make sure that they're
connected to a consuming device like a CIO2 during .probe(). Some of
those endpoints might be in the form of software_nodes assigned as
a secondary to the device's fwnode_handle. Account for this possibility
in fwnode_graph_get_next_endpoint() to avoid having to do it in the
sensor drivers themselves.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
 drivers/base/property.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 1421e9548857..fb0e852dad5f 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1036,7 +1036,26 @@ struct fwnode_handle *
 fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
 			       struct fwnode_handle *prev)
 {
-	return fwnode_call_ptr_op(fwnode, graph_get_next_endpoint, prev);
+	const struct fwnode_handle *parent;
+	struct fwnode_handle *ep;
+
+	/*
+	 * If this function is in a loop and the previous iteration returned
+	 * an endpoint from fwnode->secondary, then we need to use the secondary
+	 * as parent rather than @fwnode.
+	 */
+	if (prev)
+		parent = fwnode_graph_get_port_parent(prev);
+	else
+		parent = fwnode;
+
+	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
+
+	if (IS_ERR_OR_NULL(ep) &&
+	    !IS_ERR_OR_NULL(parent) && !IS_ERR_OR_NULL(parent->secondary))
+		ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);
+
+	return ep;
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
 
-- 
2.25.1

