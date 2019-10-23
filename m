Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0E38E23C4
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 22:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404790AbfJWUDj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Oct 2019 16:03:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38565 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733176AbfJWUCs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2019 16:02:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3so12759935pgt.5;
        Wed, 23 Oct 2019 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3H54pMajw9vQAImO1zQUK9pcXc+MkHfH1n0XYG6X74=;
        b=HWzChNfmQ2anc5V0nyw5UhLaS86AenhkOOnkjnHMCUOQ8ZgjQdz2KeoZC1SeuliTgc
         9z3PO9ilE1TIlWVjviGlnCy/RywbMmphIDVwG4+sNS9lYCs4khxqD6ZnxN8xLzEVSgaJ
         CdbEaqCyhUFsyzDY/TnN9Hsih/DLPh06gm2qHb1Wmx/yjPoqZaX5PILpkbMAyDLVWKlA
         vdQEQKjlBju2ri2apFO36moIywuaxLp05/ny78ZU1cmGud0F1tDw1VeJ9Y7HKRjCEI6L
         JM+As0f9rhEqcpNWaW30LyYn5X3t9mwYizRAhz3bSewfIVrWImAujlTth0I5IXj7pDJa
         7meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3H54pMajw9vQAImO1zQUK9pcXc+MkHfH1n0XYG6X74=;
        b=gQt6yMqg/9Xc4QhA1Vb4pqYS4/C6PjLaLy8XvGw+VkeRRQAMR7ZpMe0qnOjYNTF3YB
         3C2ddfFquKFvIsat/EWxhyLNvutO7YrK2xauTH95KRL5t5M48Zh1nycoedmVoL+vWVk2
         gqJdZu7O7Zu2DGPzKIZ8D0w5Udw5frq8XSuE7IrV0YfwfK059xiL+Y1hnrGPixjLDMCH
         a9XLpEYO7LXVaiCfuXkS5J5+xEIBQo6bkWJsGvOg+n5txUM2N/Vj59j4hwP2oJPzRqed
         P9b02uYPn3zEY1a1frUZNINxsjyUGXSc4wWl2oMa7Zn5vDmFapy5XeM3pfBRi9puqQqS
         rKzw==
X-Gm-Message-State: APjAAAXqYfnQCyO52a5LlRce8OJAAmHi9lU4oFyhdgOgQs1yQ1BSc/Kd
        ld3iigtcxjO3X1qWkYTJl6k=
X-Google-Smtp-Source: APXvYqx2dQjzCEQV0a9JbYtyY0kDCslgGRmIpudMlu+R4NLpxGsBIq5EXVcukjcdBFhjDxCwVbX+Qg==
X-Received: by 2002:a63:ce0d:: with SMTP id y13mr6007108pgf.430.1571860966900;
        Wed, 23 Oct 2019 13:02:46 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 6sm10593598pfy.43.2019.10.23.13.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 13:02:45 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 05/15] software node: clean up property_copy_string_array()
Date:   Wed, 23 Oct 2019 13:02:23 -0700
Message-Id: <20191023200233.86616-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
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
index 12ca439bab30..f41692e0f63b 100644
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
2.23.0.866.gb869b98d4c-goog

