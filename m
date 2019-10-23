Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 744E3E23A6
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 22:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406009AbfJWUC6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Oct 2019 16:02:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45234 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405850AbfJWUC5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2019 16:02:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so12748651pgj.12;
        Wed, 23 Oct 2019 13:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQgyOpGt3MaTSbe6tncV8dGOluLEtJp/sHkAMV4YRJY=;
        b=HKc9L4ffnssmH3G9D7DjyMtDJjPhf+oL/nSPTdFjEJuud45SGoIvbgU4KAlBmoOEPF
         KOsK+1zYh6idBgqQjns4mx/5xyApMFTUGW/L/JJs2AoxBFifbpjHMPFgIfGA1zI/ih78
         8tDGYzvLslIUa7anaTHfRyZ2jGH8hi5Tz9nC65nC8IClnpNp+fl3l1NdyR9CfI3uvgA0
         duVKJ9PbTvax1muGaFhtMMuVLgZORmwPruqMZQsmxN9j+8ZW91KkS9L4S2bSl9EnsVWK
         QpBQYwgJferHPSs6cwoUWm8Ig++uOHVkpsv6Ijis73Liwgsg16ZnsTx0OvWkhxKGoBDr
         HA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQgyOpGt3MaTSbe6tncV8dGOluLEtJp/sHkAMV4YRJY=;
        b=VsjhSBt33mnA9iiB1Uk5y5j0igOKSeuOJtPPhNvyJq+Aa7GzdQMSlUiD3T33G5qapC
         eOxnlx6YvhBYUchlsQW/wX5ASjRRKxNm361a9rwK+GcMLM0UbSl8vXwFSFFVphfqQP9U
         cgkX16ut1FlGd2R1yfu8R0ItB4q6Ly2S0CmboR/YiSYrJ9IcbdyWFakrhoB+jpoUh0x9
         s4zc/q1AFrGnmVcx3y1l2DH3143ljkGo8m/mbUy+nzS3OH2NEzDYHAoAap+dL9NE7XFS
         fcg9I5PmdV66KE7CABQTzzXhrThuNJzzh3WUqc5KKerg5G2WFaz5CXX3LLKJEN7u3GDG
         MSww==
X-Gm-Message-State: APjAAAWmXIgDqeJ/lbkpyywVrWJArvkf82LYCLPncK5JtSru9cPUA8ZK
        JOJUByGnl6kZ8r9qzFJjVUU=
X-Google-Smtp-Source: APXvYqz391+F4Nnax+RkCJTW/0x+14p9uHQXk2XZRhM4be7avOUZVzrSyOV5xpa1tmtTGYeqzdLu8A==
X-Received: by 2002:a62:6842:: with SMTP id d63mr12729066pfc.166.1571860975701;
        Wed, 23 Oct 2019 13:02:55 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 6sm10593598pfy.43.2019.10.23.13.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 13:02:54 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 10/15] software node: rename is_array to is_inline
Date:   Wed, 23 Oct 2019 13:02:28 -0700
Message-Id: <20191023200233.86616-11-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
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
index d8d0dc0ca5ac..18a30fb3cc58 100644
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
index 48335288c2a9..dad0ad11b55e 100644
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
2.23.0.866.gb869b98d4c-goog

