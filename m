Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35B29D4A91
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2019 01:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfJKXHk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 19:07:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36814 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfJKXHi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 19:07:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so6929604pfr.3;
        Fri, 11 Oct 2019 16:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DkKt0dZ5kBaLP0Kzj2iDpOxmN4C6Vh8shX9VPkLgJ6k=;
        b=mK1PFvgx/69qpMXtnnM4f9aVXF4Y6Fvq9yOz+bFJFqyFCmU42kW3j/sHXrr3PnTTzM
         ATohWl0jQa76jlU0Q1pMEV7OjiUI8Qy1oWfghnF/nhJcAML7l+YqVt5wLkXhhmjRwdIP
         Iz+c9BjmJDpg8pKVXJKkioaIxaQMGirG7OP6xQ47HuLLMocew9T5mSa9xvDJj9Vt4zir
         CCnjLAhv2Vua2mFcYcwYi8vlkCbM87X0sYoTkUR6i0Msaai4xchoutGQMI7jki38Gv33
         JmVtWMX1AksF98RcJZvXsae/A2Pt7QL8zpH+fEmLjL2sGrgIMVl5Zrxa+z2peLkZ/I0X
         +KnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DkKt0dZ5kBaLP0Kzj2iDpOxmN4C6Vh8shX9VPkLgJ6k=;
        b=KzXFR/gZEfjXQZqDQTy6lAeLLff9MgqfE6UGDoQSA0n+CuqQXaxwbjHOXV4CRUcEDU
         CahKo90bzoTGWzWdg/aSOo/ZX4sKeqgbZ0k2WGRXd/V1bXKeblCA0M8nK+s75BVpmYLJ
         yz4eLRGszv2EsVBXJiu8ECjLA9kyL9G7g/QpwP0Ooy4OIwaDVm95cINDB10vylhLNAjS
         PuMiDFYtTHS89/NPevwxC8vS8UYS9R2bv8NeA62QHDsDB0aOg/uDSZcnhYuKLcW1gMWx
         +05TdCAzfatOQ/p8W9op8tMH5BYM91Lx1sqFOzUXm3h0bbP0gANWwW9fHKkjQnor/R4Z
         8yIg==
X-Gm-Message-State: APjAAAUiVKXTSgPBNRpwtNMiw3oD/A1PqbJVruCf/AZ0Gucn55mCWJ64
        rOm28SROLbhadPlxztcYMJo=
X-Google-Smtp-Source: APXvYqymiqKMWp7iQNxQk+RDLhJlTpoi3VXlJITJ2GbhXG3GcU7UQAEzpFfMGBMxEm6yOOayi4uXKw==
X-Received: by 2002:aa7:956a:: with SMTP id x10mr19140391pfq.114.1570835257317;
        Fri, 11 Oct 2019 16:07:37 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w2sm11529251pfn.57.2019.10.11.16.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 16:07:36 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 09/14] software node: simplify property_entry_read_string_array()
Date:   Fri, 11 Oct 2019 16:07:16 -0700
Message-Id: <20191011230721.206646-10-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
In-Reply-To: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is no need to treat string arrays and single strings separately, we can go
exclusively by the element length in relation to data type size.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index b11cc4dbff08..8826c9040c80 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -173,28 +173,21 @@ static int property_entry_read_string_array(const struct property_entry *props,
 					    const char *propname,
 					    const char **strings, size_t nval)
 {
-	const struct property_entry *prop;
 	const void *pointer;
-	size_t array_len, length;
+	size_t length;
+	int array_len;
 
 	/* Find out the array length. */
-	prop = property_entry_get(props, propname);
-	if (!prop)
-		return -EINVAL;
-
-	if (prop->is_array)
-		/* Find the length of an array. */
-		array_len = property_entry_count_elems_of_size(props, propname,
-							  sizeof(const char *));
-	else
-		/* The array length for a non-array string property is 1. */
-		array_len = 1;
+	array_len = property_entry_count_elems_of_size(props, propname,
+						       sizeof(const char *));
+	if (array_len < 0)
+		return array_len;
 
 	/* Return how many there are if strings is NULL. */
 	if (!strings)
 		return array_len;
 
-	array_len = min(nval, array_len);
+	array_len = min_t(size_t, nval, array_len);
 	length = array_len * sizeof(*strings);
 
 	pointer = property_entry_find(props, propname, length);
-- 
2.23.0.700.g56cf767bdb-goog

