Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B64B3E3184
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Aug 2021 00:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245447AbhHFWJe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Aug 2021 18:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245444AbhHFWJe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Aug 2021 18:09:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1235C0613CF;
        Fri,  6 Aug 2021 15:09:17 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h14so12769403wrx.10;
        Fri, 06 Aug 2021 15:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HbdHuUgm9R0O8iD622sN5nUz4CxbxanIEic5v8NNLJE=;
        b=SuLT8uBTDrpu9O8cTw8EoHnTAMCFyuGzPjEAfgUBnzfLjrNHMfi5GCnTWT4pDq7KbX
         K73XknSxcL2b0lQhgySS5mPF9dT3GpYo8pvVNrY2hTtjWEXsF6x3mXed+xySyc7SzwG3
         N+zyrsTxJ25lgW8VWX4ojjtQ7aMVayF+QDE0q+AQN+pn4Jf2zQqqfOzbzSewcVbv6gSu
         jqxrKXvRMeP24IaasGaqXj+3t0Ls1d8K5CncgStW44WsLxUB87Pt3BQCtar80b3hvL2s
         wLr7kHSrNg/3K6SUcmKDaryD6bG7s4kk5nuIMKHgRvzW34fyUBBDBPPzXE6z/3pUE7yh
         BPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HbdHuUgm9R0O8iD622sN5nUz4CxbxanIEic5v8NNLJE=;
        b=nIve0DiIjfZkHDvvXpSMBfpkEMyImM1Q7d4EAQh2zD4T7MJq1lNP0KCuShLRdZ4bhQ
         qYilMYatxnqtwmzneCqH4RTzUjz5bMM9DS3mHHLX2QkuHjWU4QTI2qBSYIY0yWaJ2UNZ
         AcbJcm8XAM+BqlxLbpKyFnjr5hvo61C17x3QVecSyqlD1pwxe9LBtfSNhdZ6QRC+2mk5
         TSaQGXIEqVqDdklKVycqa2BHE4m/wTRz3AaIexHTTR9pHfYmJqAwv+GEv8NmMqhc7zi9
         tnGQ8s2Q3wPg5VfIB57IGid58mKzHjpuet0lT52+wv8OYPXlsprPZusiUCIzLfmhzmNF
         avew==
X-Gm-Message-State: AOAM533s/BSrIBdxS3Vyco6g1tg+j6vdbQIJQfVck/n+7KFDzrSlmYCd
        8zF38Ok+lKZM/Ue1xGLdM8Y2TfNL0HE=
X-Google-Smtp-Source: ABdhPJxsjnEToAvjIfzMFnIo0vfMKI+o6oeBOX0DBjBZbRWHUVjqUhqntfB/c/EGvqh1q089GWkc8g==
X-Received: by 2002:adf:cd02:: with SMTP id w2mr13222132wrm.68.1628287756350;
        Fri, 06 Aug 2021 15:09:16 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id y21sm12764204wma.38.2021.08.06.15.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 15:09:15 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH RESEND v3 2/2] Revert "media: device property: Call fwnode_graph_get_endpoint_by_id() for fwnode->secondary"
Date:   Fri,  6 Aug 2021 23:09:06 +0100
Message-Id: <20210806220906.326758-3-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806220906.326758-1-djrscally@gmail.com>
References: <20210806220906.326758-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This reverts commit acd418bfcfc415cf5e6414b6d1c6acfec850f290. Checking for
endpoints against fwnode->secondary in fwnode_graph_get_next_endpoint() is
a better way to do this since that function is also used in a bunch of
other places, for instance sensor drivers checking that they do have an
endpoint connected during probe.

This reversion depends on the previous patch in this series, "device property:
Check fwnode->secondary in fwnode_graph_get_next_endpoint()".

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---

Changes in v3:

	- specified that this patch depends on 1/2 (Greg)

 drivers/base/property.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index fb0e852dad5f..c6bb3d453c57 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1234,14 +1234,7 @@ fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
 		best_ep_id = fwnode_ep.id;
 	}
 
-	if (best_ep)
-		return best_ep;
-
-	if (fwnode && !IS_ERR_OR_NULL(fwnode->secondary))
-		return fwnode_graph_get_endpoint_by_id(fwnode->secondary, port,
-						       endpoint, flags);
-
-	return NULL;
+	return best_ep;
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_endpoint_by_id);
 
-- 
2.25.1

