Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F482F3ED0
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 05:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfKHEWe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Nov 2019 23:22:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37392 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbfKHEWd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Nov 2019 23:22:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id p24so3828516pfn.4;
        Thu, 07 Nov 2019 20:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rq+g8QX25r6FLU6mt3y3nVsMvxAZNZkHBwmo8ESYTGM=;
        b=NDw2cHmqwN04zwbW5gERef8wKT1c9P3lIYoOZrO07cDL1AhDow/Xu1wdBhqn1OVlxl
         KzdIMKK0kwbXxt/J4IF5arPd5Lwg5Bijkf7Fm2fG6GCzV5LsBy6Blbczc3wmjuLq+u+E
         GL39T6hDLTJpA2ikeKV3tUpWNAY7DxuCgFCztccB6Zo2oRTN4SuNgf1wvInuvepvq7mg
         nsdoAZkUPSHT7Gpp1lJHcmzthCu64azdohBwbPI5JnAlYNgiqGUekKbCRCjK6NgTOrEl
         dQgGzLtgYiK34sqlfq0gJzeddN4oTVoHXPTa3SR+kiC1VLvjRJuEFF/MU3SpFJyVaaSX
         VAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rq+g8QX25r6FLU6mt3y3nVsMvxAZNZkHBwmo8ESYTGM=;
        b=SOA0sEP9GbPb+56IXTUx5TemAImHSlwILhbWGpROyC60rkILH8HbfqwKawdcBLIl7a
         phX7UdOTHhyQ31hbbB7NQrJkCQIdEgsJje+k4Xr8CxAwksloXxFj3/kSsBL7uBdDYaO2
         R6L74OZar9sJ6WgM7Vq5LG9F3S/gTEjBiq+Ox/yY688wH9ZQPpcBWMadtKK9CkKZtFMz
         0SModUBPKIbtQ4yON6Wr8QWs7RncbdanQXUhPF1JaT4xWjyJFbmJ9CjnBrwVPoW+rO9i
         pKj2Y3pwqvd/9jeO4l05jB3bqxnjdIcErGH3rykQ7Km6HmuLDPb3u7OvGd/g3MDqRJmc
         0fkg==
X-Gm-Message-State: APjAAAW9qrfGlDD8AEWDNcKLT4zhX+PZ/QYmefl9KneD35CUdoIKYhoA
        2r/W1k/AHcTBNZclMXiYisg=
X-Google-Smtp-Source: APXvYqxqkebKeaZPHnG9p8kqvBG8olTBLJ9LTiH4tvx3nuls/eTgMX8QMjR0UUCYSVFxkcZTNHDkgw==
X-Received: by 2002:a63:5125:: with SMTP id f37mr8832705pgb.98.1573186950659;
        Thu, 07 Nov 2019 20:22:30 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 71sm5004106pfx.107.2019.11.07.20.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 20:22:30 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v8 1/6] software node: rename is_array to is_inline
Date:   Thu,  7 Nov 2019 20:22:20 -0800
Message-Id: <20191108042225.45391-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
References: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

We do not need a special flag to know if we are dealing with an array,
as we can get that data from ratio between element length and the data
size, however we do need a flag to know whether the data is stored
directly inside property_entry or separately.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c    | 12 +++++-------
 include/linux/property.h | 13 ++++++++-----
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index d8d0dc0ca5acf..18a30fb3cc588 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -108,10 +108,7 @@ static const void *property_get_pointer(const struct property_entry *prop)
 	if (!prop->length)
 		return NULL;
 
-	if (prop->is_array)
-		return prop->pointer;
-
-	return &prop->value;
+	return prop->is_inline ? &prop->value : prop->pointer;
 }
 
 static const void *property_entry_find(const struct property_entry *props,
@@ -205,7 +202,7 @@ static void property_entry_free_data(const struct property_entry *p)
 	const char * const *src_str;
 	size_t i, nval;
 
-	if (p->is_array) {
+	if (!p->is_inline) {
 		if (p->type == DEV_PROP_STRING && p->pointer) {
 			src_str = p->pointer;
 			nval = p->length / sizeof(const char *);
@@ -250,7 +247,7 @@ static int property_entry_copy_data(struct property_entry *dst,
 	const void *pointer = property_get_pointer(src);
 	const void *new;
 
-	if (src->is_array) {
+	if (!src->is_inline) {
 		if (!src->length)
 			return -ENODATA;
 
@@ -264,15 +261,16 @@ static int property_entry_copy_data(struct property_entry *dst,
 				return -ENOMEM;
 		}
 
-		dst->is_array = true;
 		dst->pointer = new;
 	} else if (src->type == DEV_PROP_STRING) {
 		new = kstrdup(src->value.str, GFP_KERNEL);
 		if (!new && src->value.str)
 			return -ENOMEM;
 
+		dst->is_inline = true;
 		dst->value.str = new;
 	} else {
+		dst->is_inline = true;
 		dst->value = src->value;
 	}
 
diff --git a/include/linux/property.h b/include/linux/property.h
index 48335288c2a96..dad0ad11b55e2 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -227,15 +227,17 @@ static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
  * struct property_entry - "Built-in" device property representation.
  * @name: Name of the property.
  * @length: Length of data making up the value.
- * @is_array: True when the property is an array.
+ * @is_inline: True when the property value is embedded in
+ *	&struct property_entry instance.
  * @type: Type of the data in unions.
- * @pointer: Pointer to the property (an array of items of the given type).
- * @value: Value of the property (when it is a single item of the given type).
+ * @pointer: Pointer to the property when it is stored separately from
+ *	the &struct property_entry instance.
+ * @value: Value of the property when it is stored inline.
  */
 struct property_entry {
 	const char *name;
 	size_t length;
-	bool is_array;
+	bool is_inline;
 	enum dev_prop_type type;
 	union {
 		const void *pointer;
@@ -262,7 +264,6 @@ struct property_entry {
 (struct property_entry) {						\
 	.name = _name_,							\
 	.length = (_len_) * __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),	\
-	.is_array = true,						\
 	.type = DEV_PROP_##_Type_,					\
 	{ .pointer = _val_ },						\
 }
@@ -293,6 +294,7 @@ struct property_entry {
 (struct property_entry) {						\
 	.name = _name_,							\
 	.length = __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),		\
+	.is_inline = true,						\
 	.type = DEV_PROP_##_Type_,					\
 	{ .value = { ._elem_ = _val_ } },				\
 }
@@ -311,6 +313,7 @@ struct property_entry {
 #define PROPERTY_ENTRY_BOOL(_name_)		\
 (struct property_entry) {			\
 	.name = _name_,				\
+	.is_inline = true,			\
 }
 
 struct property_entry *
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

