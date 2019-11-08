Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB259F3CB9
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 01:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfKHASL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Nov 2019 19:18:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39770 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfKHASL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Nov 2019 19:18:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id x28so3541153pfo.6;
        Thu, 07 Nov 2019 16:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KQSCppdZaKCRrnJqn7kJzSzcY0nHtGju8OtAz0SIovA=;
        b=pjFjJMQ+qNMOCJVldxq87LOmFidO/tSLNgf/ePtdxgi4L+3gsJ3tb+tQD64RGk26f1
         QfvbY9QaMLC8s0ujhhzbev0PLsWsy5lch0E5NFzUwaB4QlvE9EAUGVULXljxQPAY33+r
         U5tHexKXcN6V52YSfgwWh/ijrB/etmP2WO4WyZM9MGUF75F618Af2Kdl/SzsnDZiphLs
         fFQTCuV377swm8MQNrVOcllM0+F1mr/2eZ7IV0lQZLXwNU632eH0R7Wk0+3bXFpG+jfp
         uql2LFoenJJPHp740+YUwsxvAj7ftf+8S7VQsi5/Obj9rWhLj2pvu6rae64OiWsXw1na
         SQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KQSCppdZaKCRrnJqn7kJzSzcY0nHtGju8OtAz0SIovA=;
        b=lU4mKcmsiDxnyKeAtdGAWWCxj39yxXWZGlCouFNVAy0ITL33gASj5iaY0DOmMN/CES
         +IyK3sYMVmSD/YY7FkOwtd3hF2WWS+hemSTf5gf3n2GXpcfPuYbX0syxl0qfi219lt+4
         LfJfaFdMykSECYKanH6hbQbkqB5dJ5PGHfYwvA2TQebB3LQfzq5AzJKa5S8w6PZCkRxa
         zAq5jCj1dIa89V8GCfRTtxHVxQIe7nsaAfUDW27dFZgheczhczgjSR+tpEjTHgP5E4re
         5Ly34UcqIDYb+WF0FsMYObLrDJYed4EQrMKC/pBYG/hj84FtJ8xqQEN+Zy0c0fEnxtao
         KhNg==
X-Gm-Message-State: APjAAAVmdMc1YY+D2n7NuhcHaMVz72uqDm3+o91VFnCf6p0D4z2Kj9n9
        G0Urqes1CLGe3CUr0Tm2YmjEZ03Z
X-Google-Smtp-Source: APXvYqww7UWD1XvSGI+l923OYpGIlLyerxrVPFz4rvM0XiFEuatrD9j615om+j0LKqKO4JscS6wFwg==
X-Received: by 2002:a62:1d8e:: with SMTP id d136mr8067619pfd.49.1573172290016;
        Thu, 07 Nov 2019 16:18:10 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id m68sm3688764pfb.122.2019.11.07.16.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 16:18:09 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v7 2/6] software node: allow embedding of small arrays into property_entry
Date:   Thu,  7 Nov 2019 16:17:59 -0800
Message-Id: <20191108001803.191541-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191108001803.191541-1-dmitry.torokhov@gmail.com>
References: <20191108001803.191541-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

We should not conflate whether a property data is an array or a single
value with where it is stored (embedded into property_entry structure or
out-of-line). All single-value properties are in effect 1-element
arrays, and we can figure the amount of data stored in a property by
examining its length and the data type. And arrays can be as easily
stored in property entry instances as single values are, provided that
we have enough space (we have up to 8 bytes). We can embed:

- up to 8 bytes from U8 arrays
- up to 4 words
- up to 2 double words
- one U64 value
- one (on 64 bit architectures) or 2 (on 32 bit) strings.

This change also has an effect of switching properties with small amount
of data to embed it instead of keeping it separate when copying such
properties.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c | 103 +++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 56 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 18a30fb3cc588..ce7f202b2455e 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -198,93 +198,84 @@ static int property_entry_read_string_array(const struct property_entry *props,
 
 static void property_entry_free_data(const struct property_entry *p)
 {
-	const void *pointer = property_get_pointer(p);
 	const char * const *src_str;
 	size_t i, nval;
 
-	if (!p->is_inline) {
-		if (p->type == DEV_PROP_STRING && p->pointer) {
-			src_str = p->pointer;
-			nval = p->length / sizeof(const char *);
-			for (i = 0; i < nval; i++)
-				kfree(src_str[i]);
-		}
-		kfree(pointer);
-	} else if (p->type == DEV_PROP_STRING) {
-		kfree(p->value.str);
+	if (p->type == DEV_PROP_STRING) {
+		src_str = property_get_pointer(p);
+		nval = p->length / sizeof(*src_str);
+		for (i = 0; i < nval; i++)
+			kfree(src_str[i]);
 	}
+
+	if (!p->is_inline)
+		kfree(p->pointer);
+
 	kfree(p->name);
 }
 
-static const char * const *
-property_copy_string_array(const struct property_entry *src)
+static bool property_copy_string_array(const char **dst_ptr,
+				       const char * const *src_ptr,
+				       size_t nval)
 {
-	const char **d;
-	const char * const *src_str = src->pointer;
-	size_t nval = src->length / sizeof(*d);
 	int i;
 
-	d = kcalloc(nval, sizeof(*d), GFP_KERNEL);
-	if (!d)
-		return NULL;
-
 	for (i = 0; i < nval; i++) {
-		d[i] = kstrdup(src_str[i], GFP_KERNEL);
-		if (!d[i] && src_str[i]) {
+		dst_ptr[i] = kstrdup(src_ptr[i], GFP_KERNEL);
+		if (!dst_ptr[i] && src_ptr[i]) {
 			while (--i >= 0)
-				kfree(d[i]);
-			kfree(d);
-			return NULL;
+				kfree(dst_ptr[i]);
+			return false;
 		}
 	}
 
-	return d;
+	return true;
 }
 
 static int property_entry_copy_data(struct property_entry *dst,
 				    const struct property_entry *src)
 {
 	const void *pointer = property_get_pointer(src);
-	const void *new;
-
-	if (!src->is_inline) {
-		if (!src->length)
-			return -ENODATA;
-
-		if (src->type == DEV_PROP_STRING) {
-			new = property_copy_string_array(src);
-			if (!new)
-				return -ENOMEM;
-		} else {
-			new = kmemdup(pointer, src->length, GFP_KERNEL);
-			if (!new)
-				return -ENOMEM;
-		}
-
-		dst->pointer = new;
-	} else if (src->type == DEV_PROP_STRING) {
-		new = kstrdup(src->value.str, GFP_KERNEL);
-		if (!new && src->value.str)
+	void *dst_ptr;
+	size_t nval;
+
+	/*
+	 * Properties with no data should not be marked as stored
+	 * out of line.
+	 */
+	if (!src->is_inline && !src->length)
+		return -ENODATA;
+
+	if (src->length <= sizeof(dst->value)) {
+		dst_ptr = &dst->value;
+		dst->is_inline = true;
+	} else {
+		dst_ptr = kmalloc(src->length, GFP_KERNEL);
+		if (!dst_ptr)
 			return -ENOMEM;
+		dst->pointer = dst_ptr;
+	}
 
-		dst->is_inline = true;
-		dst->value.str = new;
+	if (src->type == DEV_PROP_STRING) {
+		nval = src->length / sizeof(const char *);
+		if (!property_copy_string_array(dst_ptr, pointer, nval)) {
+			if (!dst->is_inline)
+				kfree(dst->pointer);
+			return -ENOMEM;
+		}
 	} else {
-		dst->is_inline = true;
-		dst->value = src->value;
+		memcpy(dst_ptr, pointer, src->length);
 	}
 
 	dst->length = src->length;
 	dst->type = src->type;
 	dst->name = kstrdup(src->name, GFP_KERNEL);
-	if (!dst->name)
-		goto out_free_data;
+	if (!dst->name) {
+		property_entry_free_data(dst);
+		return -ENOMEM;
+	}
 
 	return 0;
-
-out_free_data:
-	property_entry_free_data(dst);
-	return -ENOMEM;
 }
 
 /**
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

