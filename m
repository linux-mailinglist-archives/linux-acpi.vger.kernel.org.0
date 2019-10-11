Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D936BD4AA6
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2019 01:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfJKXHd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 19:07:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39828 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbfJKXHd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 19:07:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17so5114066plp.6;
        Fri, 11 Oct 2019 16:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YCedBuQFpwmyDfQI6sD+E2lALu5XRSGZTBcPHifNSjo=;
        b=Eo8QuNDSRErj1fkPFFHRRByLpevbKrPFuVOYzhXDMX5ggCV+KO430KQODe+4jo5em2
         Uxf5cawMvb1jnAP1ECoi+ExeHfD3g+1YlwJbl8UZC5U4e0Hxu4tb9w4KxTwJvwD+ogWD
         qp2U+riefnvWNyHCgTYih9rRLBkd6mTb9znu2YTPYs0TV7kmohMa4pR3QnAEHwFbx/Gz
         aPz3UDSxV78hvwXH8rw/THElQ6kSyiv4iYBWeSHtevlTo3p6CiqIkOHZcsUxBKRjSD2m
         sGwsISyq3VEQ5TN6tBZn8hjxqqE7RSrZqxwprk8ThlzmBOeKC5jS54iBxLYujUcNuCWe
         6SRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YCedBuQFpwmyDfQI6sD+E2lALu5XRSGZTBcPHifNSjo=;
        b=Neh7nVhdSz/6hAfR6juIAAIFV4s1jVaTkNf5aB6X/blXm6rgu7Cg2cZlxlbZaleqKV
         3Syz56myXUO7ujk58pVZdfYw2IUw77qTMDvqZVuQ4TppYA4P90AioEDcqDRZh1O8Kfuy
         XYkofElDY6L6H53bu/lgarVTx+8/aLPaaIP5DVgTxfQIer7RwEfF2XfUCf7ghzkk5AiT
         +ReuXHFp/Lu4c35BBDl/3sOdZpS+GachaG4SoZlHowMvAqHpCPz0M46CX0e5SCuqfG7A
         FqDbHEpY98H44WszEyhbIAEHrLncFgr1kMhpsi4U7Z1Lu4e7Iw97MemVs3gtePe8DLkg
         ia7A==
X-Gm-Message-State: APjAAAU1TsGl0XqYrVv5GNOC67m/ZVOeGbwoOvMwu0gXlGP6QItXowry
        TUfZ5bKP+eF+iR7p7e4S5o0=
X-Google-Smtp-Source: APXvYqyhNyzlkmmr4MdraRLNF6qI3ydH/9oHqlY3spU3yF1i+RDYZDiEU9vcmm8cDSb7XGitxqDvKg==
X-Received: by 2002:a17:902:ac8a:: with SMTP id h10mr17051503plr.180.1570835252032;
        Fri, 11 Oct 2019 16:07:32 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w2sm11529251pfn.57.2019.10.11.16.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 16:07:30 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 05/14] software node: clean up property_copy_string_array()
Date:   Fri, 11 Oct 2019 16:07:12 -0700
Message-Id: <20191011230721.206646-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
In-Reply-To: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Because property_copy_string_array() stores the newly allocated pointer in the
destination property, we have an awkward code in property_entry_copy_data()
where we fetch the new pointer from dst.

Let's change property_copy_string_array() to return pointer and rely on the
common path in property_entry_copy_data() to store it in destination structure.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index a1f3f0994f9f..2f2248c9003c 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -337,8 +337,8 @@ static void property_entry_free_data(const struct property_entry *p)
 	kfree(p->name);
 }
 
-static int property_copy_string_array(struct property_entry *dst,
-				      const struct property_entry *src)
+static const char * const *
+property_copy_string_array(const struct property_entry *src)
 {
 	const char **d;
 	size_t nval = src->length / sizeof(*d);
@@ -346,7 +346,7 @@ static int property_copy_string_array(struct property_entry *dst,
 
 	d = kcalloc(nval, sizeof(*d), GFP_KERNEL);
 	if (!d)
-		return -ENOMEM;
+		return NULL;
 
 	for (i = 0; i < nval; i++) {
 		d[i] = kstrdup(src->pointer.str[i], GFP_KERNEL);
@@ -354,12 +354,11 @@ static int property_copy_string_array(struct property_entry *dst,
 			while (--i >= 0)
 				kfree(d[i]);
 			kfree(d);
-			return -ENOMEM;
+			return NULL;
 		}
 	}
 
-	dst->pointer.str = d;
-	return 0;
+	return d;
 }
 
 static int property_entry_copy_data(struct property_entry *dst,
@@ -367,17 +366,15 @@ static int property_entry_copy_data(struct property_entry *dst,
 {
 	const void *pointer = property_get_pointer(src);
 	const void *new;
-	int error;
 
 	if (src->is_array) {
 		if (!src->length)
 			return -ENODATA;
 
 		if (src->type == DEV_PROP_STRING) {
-			error = property_copy_string_array(dst, src);
-			if (error)
-				return error;
-			new = dst->pointer.str;
+			new = property_copy_string_array(src);
+			if (!new)
+				return -ENOMEM;
 		} else {
 			new = kmemdup(pointer, src->length, GFP_KERNEL);
 			if (!new)
-- 
2.23.0.700.g56cf767bdb-goog

