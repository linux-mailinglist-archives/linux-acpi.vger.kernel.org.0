Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFB45F3ECF
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 05:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbfKHEWd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Nov 2019 23:22:33 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41813 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfKHEWd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Nov 2019 23:22:33 -0500
Received: by mail-pl1-f195.google.com with SMTP id d29so3169317plj.8;
        Thu, 07 Nov 2019 20:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Jv10kn/aNQ9++wam+0EoW0JXkYl2qX0EGR6ktqlC6g=;
        b=sIPzoQ2bCbKnfLOBiMuSoTEaACB2MCiZ60AyCbh5gv+v5S+hf/bOzv58MzEWACIZFe
         /Dx4RW3CjwJu5M6pAQdkOkrBPoUhiSFrIH67jD39lWCcklN3nYn2e4lAZFjoyXkP8nXg
         ueXAx7ddtXog/gCt7z3z4ypkBNicflp4rDptQToHkTzhzzInEOgGTFUitUwPoAFdTiO6
         Cn2yveE+nxQGu1lveZ2Mg9GiNzxoNSLJgEZ4U0iGlAfIT3Qy/w2ahU6gBvf5hoX+tDT5
         cFO7t9XkZAoF3VXISf99ucEieF33GuXMrMsTsDHd9H0iXB9hU52FY0Wne8ce7ZyTq3h0
         HIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Jv10kn/aNQ9++wam+0EoW0JXkYl2qX0EGR6ktqlC6g=;
        b=F2Prgj6VFs+O7zMBZdqFbWhsGG9aFcfj9MILseR44g5zVPMUmBuUFHLChAJ39tqCOc
         oNcGAUDFlwHdd6nch7MM435YFKOOBJeic1v4l2J6Z2or8Vm8uzV4osnTlW4ORxkJZjq9
         O3HfBqoI9+hcPzz3/t3rCt12+94x8VFyZ9fxJ9ewvlnjRR1KKnZGnbXphLDa+UD0f213
         08zVUjS2fait8bmk4gQCa0YGrqrDSLh9gno8KZQnAqADxChDDzWxWlkKZT3djdikdaJi
         RP+3ENxrJUiDpgcvV9UFq9WlZ0UCfMGDe8KBW3GSsq2h78iyiefIiEslUZ9eNFZ93G/i
         NQiA==
X-Gm-Message-State: APjAAAVsU4MR44wHMFks8TKWVZlaQ/U6MoVGJprChFyhvkNt0pBj67In
        MZWkeqBMwgnxdJVUAJVwD3Q=
X-Google-Smtp-Source: APXvYqwcTkYQRHf2f1MHWxSWzrJQhuumQFKoxjWWlYrIp1z3eJKgYGG+R7qZTgI3hlMNV3iUaw9OAA==
X-Received: by 2002:a17:90a:e38c:: with SMTP id b12mr10444831pjz.136.1573186951558;
        Thu, 07 Nov 2019 20:22:31 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 71sm5004106pfx.107.2019.11.07.20.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 20:22:31 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v8 2/6] software node: allow embedding of small arrays into property_entry
Date:   Thu,  7 Nov 2019 20:22:21 -0800
Message-Id: <20191108042225.45391-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
References: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
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
 drivers/base/swnode.c    | 115 +++++++++++++++++++--------------------
 include/linux/property.h |  14 ++---
 2 files changed, 62 insertions(+), 67 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 18a30fb3cc588..3d422918a53d9 100644
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
@@ -484,6 +475,8 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	const struct software_node_reference *ref;
 	const struct property_entry *prop;
 	struct fwnode_handle *refnode;
+	u32 nargs_prop_val;
+	int error;
 	int i;
 
 	if (!swnode || !swnode->node->references)
@@ -501,11 +494,13 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 		return -ENOENT;
 
 	if (nargs_prop) {
-		prop = property_entry_get(swnode->node->properties, nargs_prop);
-		if (!prop)
-			return -EINVAL;
+		error = property_entry_read_int_array(swnode->node->properties,
+						      nargs_prop, sizeof(u32),
+						      &nargs_prop_val, 1);
+		if (error)
+			return error;
 
-		nargs = prop->value.u32_data;
+		nargs = nargs_prop_val;
 	}
 
 	if (nargs > NR_FWNODE_REFERENCE_ARGS)
diff --git a/include/linux/property.h b/include/linux/property.h
index dad0ad11b55e2..c592c286e3394 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -242,11 +242,11 @@ struct property_entry {
 	union {
 		const void *pointer;
 		union {
-			u8 u8_data;
-			u16 u16_data;
-			u32 u32_data;
-			u64 u64_data;
-			const char *str;
+			u8 u8_data[sizeof(u64) / sizeof(u8)];
+			u16 u16_data[sizeof(u64) / sizeof(u16)];
+			u32 u32_data[sizeof(u64) / sizeof(u32)];
+			u64 u64_data[sizeof(u64) / sizeof(u64)];
+			const char *str[sizeof(u64) / sizeof(char *)];
 		} value;
 	};
 };
@@ -258,7 +258,7 @@ struct property_entry {
  */
 
 #define __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_)				\
-	sizeof(((struct property_entry *)NULL)->value._elem_)
+	sizeof(((struct property_entry *)NULL)->value._elem_[0])
 
 #define __PROPERTY_ENTRY_ARRAY_LEN(_name_, _elem_, _Type_, _val_, _len_)\
 (struct property_entry) {						\
@@ -296,7 +296,7 @@ struct property_entry {
 	.length = __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),		\
 	.is_inline = true,						\
 	.type = DEV_PROP_##_Type_,					\
-	{ .value = { ._elem_ = _val_ } },				\
+	{ .value = { ._elem_[0] = _val_ } },				\
 }
 
 #define PROPERTY_ENTRY_U8(_name_, _val_)				\
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

