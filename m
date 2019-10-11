Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 932EAD4AA2
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2019 01:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfJKXIF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 19:08:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42900 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbfJKXHj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 19:07:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so5107633pls.9;
        Fri, 11 Oct 2019 16:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VGAj9DcBs/80t0ryWN2g8AdvdOVG4qMHTqh7+k7I0Nc=;
        b=kcKWitMKklpsR5GYUZZJLuxueL0+AqvaRJGItrcqTG28pm3SZ+VUFlrmpfC5wy/sOm
         MwhiBZuGBxU66uzlaa/JjOJZmyAglVA4QnflG2dOABWMLn14rHmK7Sxi04NAwhAz/DNb
         TquinmOR94OnKAk/9oQDS5GslOMQRrrHduJr1r4OqdH5VIbVTTtXJotlL0VrNI2WQThy
         hBVblj0p2LQvDTXPktrXBSmCBVEoCshGhmj+JwJ+zgqYmujE99qx0RaBATuJq1Mkh9+8
         prGHctDMy3pbvfeRppCidSyZmI7PwDxRwwo85VRt/iKqRsNpPQQ/7gRseFfZH9Mzpg5n
         pJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VGAj9DcBs/80t0ryWN2g8AdvdOVG4qMHTqh7+k7I0Nc=;
        b=aIaQAIi6wA5NnF2NyRR5EumB8YWAb4N2Ugako2LlkQa/mByC25/YdGCi03h+Je3gdv
         Ys+mlMO/McUuxc9URGAA0826Q7Ndf3F+h/cPiBpFVVFDZje13XW2+QmS5Ii+jEh3vWV3
         v7wFEsyTrHA8HujwpMkAfvD1ql9i3JmOJDmlxpO2QI1Keo9nBbjivSYi6Q2yFYwi9fv1
         RE1dUKKP3/Xb8vj0hmB6ErUWm43ZeNgp2xYAFH0rblSfnP82+owxpvocVoRN96EP9XuI
         9USrkK/lXT1Q6Ggzu1E3ScxngIp2ZmncIQOPIdcwz/A3cvjbfeZyp3x2TXPEatZiisDF
         8lZw==
X-Gm-Message-State: APjAAAWG9TD0Y3PgmteLifVvMIz9Dt+ElckXpDO2pzWgLn6MQcX+JBKB
        bNeZcVSq8q6B3griurgoW7Q=
X-Google-Smtp-Source: APXvYqwIKN74iRAFyhP89X4np83xFqjTvkIRJA+7KVwZOvEJkiwZtjkJU+1aWFpO5DLnu2VhiJ+icw==
X-Received: by 2002:a17:902:8487:: with SMTP id c7mr17386776plo.20.1570835258560;
        Fri, 11 Oct 2019 16:07:38 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w2sm11529251pfn.57.2019.10.11.16.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 16:07:37 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 10/14] software node: rename is_array to is_inline
Date:   Fri, 11 Oct 2019 16:07:17 -0700
Message-Id: <20191011230721.206646-11-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
In-Reply-To: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
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
 drivers/base/swnode.c    |  9 +++++----
 include/linux/property.h | 12 +++++++-----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 8826c9040c80..ae4b24ee2a54 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -108,7 +108,7 @@ static const void *property_get_pointer(const struct property_entry *prop)
 	if (!prop->length)
 		return NULL;
 
-	if (prop->is_array)
+	if (!prop->is_inline)
 		return prop->pointer;
 
 	return &prop->value;
@@ -205,7 +205,7 @@ static void property_entry_free_data(const struct property_entry *p)
 	const char * const *src_str;
 	size_t i, nval;
 
-	if (p->is_array) {
+	if (!p->is_inline) {
 		if (p->type == DEV_PROP_STRING && p->pointer) {
 			src_str = p->pointer;
 			nval = p->length / sizeof(const char *);
@@ -250,7 +250,7 @@ static int property_entry_copy_data(struct property_entry *dst,
 	const void *pointer = property_get_pointer(src);
 	const void *new;
 
-	if (src->is_array) {
+	if (!src->is_inline) {
 		if (!src->length)
 			return -ENODATA;
 
@@ -264,15 +264,16 @@ static int property_entry_copy_data(struct property_entry *dst,
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
index 238e1507925f..ac7823d58cfe 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -222,15 +222,17 @@ static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
  * struct property_entry - "Built-in" device property representation.
  * @name: Name of the property.
  * @length: Length of data making up the value.
- * @is_array: True when the property is an array.
+ * @is_inline: True when the property value is stored directly in
+ *     &struct property_entry instance.
  * @type: Type of the data in unions.
- * @pointer: Pointer to the property (an array of items of the given type).
- * @value: Value of the property (when it is a single item of the given type).
+ * @pointer: Pointer to the property when it is stored separately from
+ *     the &struct property_entry instance.
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
@@ -257,7 +259,6 @@ struct property_entry {
 (struct property_entry) {						\
 	.name = _name_,							\
 	.length = (_len_) * __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),	\
-	.is_array = true,						\
 	.type = DEV_PROP_##_Type_,					\
 	{ .pointer = _val_ },						\
 }
@@ -288,6 +289,7 @@ struct property_entry {
 (struct property_entry) {						\
 	.name = _name_,							\
 	.length = __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),		\
+	.is_inline = true,						\
 	.type = DEV_PROP_##_Type_,					\
 	{ .value = { ._elem_ = _val_ } },				\
 }
-- 
2.23.0.700.g56cf767bdb-goog

