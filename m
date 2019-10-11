Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84609D4AAF
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2019 01:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfJKXIO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 19:08:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39198 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbfJKXHg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 19:07:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id v4so6927070pff.6;
        Fri, 11 Oct 2019 16:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=My6TZcxC7HEAgtz1q11BSr9nCjfXFfYRNGIk6rK3DR8=;
        b=KMxWNbzN6cc4mzi8RIjo4WOOYEC9N+ZWptP0f1TmXpWJkmKiwuVJ5+IxDPaJKQLV4W
         TIyHSYXL/ZOe1WSleVes5nyLcTUd8HKtw/SP5+gyj11b85yL/hfrO0ONZoR93HV39Ajh
         W7g1lxTC0TSPwuAtKU6E/v8nD000uVDVPYN6G2phE5pCY0tziFbSY2dZdh+79oBsMibF
         oTfOSui/snG+yR3tB+Z8I81k2DlTFGcRCNUS4GbgwgNc83mO0FSRou9BndrVw4mMoYmO
         /MfBP3gUij2s1vk+MfhtRCAD07VlHReb83ox0AsPHcT6oM9GB67ruRxlOfAxy+YmOK/4
         GWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=My6TZcxC7HEAgtz1q11BSr9nCjfXFfYRNGIk6rK3DR8=;
        b=Tb9+X35zHaBPhiFs1m9LS7QJF6mJhJLnnqB6LQOiUmbgatiOsIEfgYCBiwrDKk8unX
         ucc9Q0VxiJ0N8kMsjB95kmt2MD1oE+pvZp28ywP5fGToRpCGdSeJG3AZj9/156WjiI8e
         /rxFktbk+RghEMFmXWIiCL5qpOHbqNNkcVqaGKLZxZB4FG2DXRALbNdXSoSpyj/NeNZq
         vByy8KvnwODbEo3BoE2J0ENIU8DybB727mP1fIo6CPKl1IdNmxOPJjYTDTz8pIPJ9nPV
         P9/kqol+FbRIpQl9iLfHTIC115ikHKhPetGR9AIZWLh7fGaLBAu57jyPHX8WEgp97iy7
         rXaA==
X-Gm-Message-State: APjAAAVUjTLGmcv01pLzeP5S4+lMxMeaO9xoQ8t2ej4QtN8nAKmIm3R6
        Hnep9Nd0iKabP9xVr6eUzOfmtzOg
X-Google-Smtp-Source: APXvYqx0GB8ADH7HX/DLbxeuorogn2V/yCFho8ZLh2gZEm7CW65hDZlYRdCRM6YRc9SbKPISI+G2pA==
X-Received: by 2002:a65:400b:: with SMTP id f11mr19640569pgp.57.1570835254077;
        Fri, 11 Oct 2019 16:07:34 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w2sm11529251pfn.57.2019.10.11.16.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 16:07:32 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 06/14] software node: get rid of property_set_pointer()
Date:   Fri, 11 Oct 2019 16:07:13 -0700
Message-Id: <20191011230721.206646-7-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
In-Reply-To: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Instead of explicitly setting values of integer types when copying
property entries lets just copy entire value union when processing
non-array values.

For value arrays we no longer use union of pointers, but rather a single
void pointer, which allows us to remove property_set_pointer().

In property_get_pointer() we do not need to handle each data type
separately, we can simply return either the pointer or pointer to values
union.

We are not losing anything from removing typed pointer union because the
upper layers do their accesses through void pointers anyway, and we
trust the "type" of the property when interpret the data. We rely on
users of property entries on using PROPERTY_ENTRY_XXX() macros to
properly initialize entries instead of poking in the instances directly.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c    | 90 +++++++++-------------------------------
 include/linux/property.h | 12 ++----
 2 files changed, 22 insertions(+), 80 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 2f2248c9003c..26e56dd66436 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -103,71 +103,15 @@ property_entry_get(const struct property_entry *prop, const char *name)
 	return NULL;
 }
 
-static void
-property_set_pointer(struct property_entry *prop, const void *pointer)
-{
-	switch (prop->type) {
-	case DEV_PROP_U8:
-		if (prop->is_array)
-			prop->pointer.u8_data = pointer;
-		else
-			prop->value.u8_data = *((u8 *)pointer);
-		break;
-	case DEV_PROP_U16:
-		if (prop->is_array)
-			prop->pointer.u16_data = pointer;
-		else
-			prop->value.u16_data = *((u16 *)pointer);
-		break;
-	case DEV_PROP_U32:
-		if (prop->is_array)
-			prop->pointer.u32_data = pointer;
-		else
-			prop->value.u32_data = *((u32 *)pointer);
-		break;
-	case DEV_PROP_U64:
-		if (prop->is_array)
-			prop->pointer.u64_data = pointer;
-		else
-			prop->value.u64_data = *((u64 *)pointer);
-		break;
-	case DEV_PROP_STRING:
-		if (prop->is_array)
-			prop->pointer.str = pointer;
-		else
-			prop->value.str = pointer;
-		break;
-	default:
-		break;
-	}
-}
-
 static const void *property_get_pointer(const struct property_entry *prop)
 {
-	switch (prop->type) {
-	case DEV_PROP_U8:
-		if (prop->is_array)
-			return prop->pointer.u8_data;
-		return &prop->value.u8_data;
-	case DEV_PROP_U16:
-		if (prop->is_array)
-			return prop->pointer.u16_data;
-		return &prop->value.u16_data;
-	case DEV_PROP_U32:
-		if (prop->is_array)
-			return prop->pointer.u32_data;
-		return &prop->value.u32_data;
-	case DEV_PROP_U64:
-		if (prop->is_array)
-			return prop->pointer.u64_data;
-		return &prop->value.u64_data;
-	case DEV_PROP_STRING:
-		if (prop->is_array)
-			return prop->pointer.str;
-		return &prop->value.str;
-	default:
+	if (!prop->length)
 		return NULL;
-	}
+
+	if (prop->is_array)
+		return prop->pointer;
+
+	return &prop->value;
 }
 
 static const void *property_entry_find(const struct property_entry *props,
@@ -322,13 +266,15 @@ static int property_entry_read_string_array(const struct property_entry *props,
 static void property_entry_free_data(const struct property_entry *p)
 {
 	const void *pointer = property_get_pointer(p);
+	const char * const *src_str;
 	size_t i, nval;
 
 	if (p->is_array) {
-		if (p->type == DEV_PROP_STRING && p->pointer.str) {
+		if (p->type == DEV_PROP_STRING && p->pointer) {
+			src_str = p->pointer;
 			nval = p->length / sizeof(const char *);
 			for (i = 0; i < nval; i++)
-				kfree(p->pointer.str[i]);
+				kfree(src_str[i]);
 		}
 		kfree(pointer);
 	} else if (p->type == DEV_PROP_STRING) {
@@ -341,6 +287,7 @@ static const char * const *
 property_copy_string_array(const struct property_entry *src)
 {
 	const char **d;
+	const char * const *src_str = src->pointer;
 	size_t nval = src->length / sizeof(*d);
 	int i;
 
@@ -349,8 +296,8 @@ property_copy_string_array(const struct property_entry *src)
 		return NULL;
 
 	for (i = 0; i < nval; i++) {
-		d[i] = kstrdup(src->pointer.str[i], GFP_KERNEL);
-		if (!d[i] && src->pointer.str[i]) {
+		d[i] = kstrdup(src_str[i], GFP_KERNEL);
+		if (!d[i] && src_str[i]) {
 			while (--i >= 0)
 				kfree(d[i]);
 			kfree(d);
@@ -380,20 +327,21 @@ static int property_entry_copy_data(struct property_entry *dst,
 			if (!new)
 				return -ENOMEM;
 		}
+
+		dst->is_array = true;
+		dst->pointer = new;
 	} else if (src->type == DEV_PROP_STRING) {
 		new = kstrdup(src->value.str, GFP_KERNEL);
 		if (!new && src->value.str)
 			return -ENOMEM;
+
+		dst->value.str = new;
 	} else {
-		new = pointer;
+		dst->value = src->value;
 	}
 
 	dst->length = src->length;
-	dst->is_array = src->is_array;
 	dst->type = src->type;
-
-	property_set_pointer(dst, new);
-
 	dst->name = kstrdup(src->name, GFP_KERNEL);
 	if (!dst->name)
 		goto out_free_data;
diff --git a/include/linux/property.h b/include/linux/property.h
index 2c9d4d209296..ec8f84d564a8 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -233,13 +233,7 @@ struct property_entry {
 	bool is_array;
 	enum dev_prop_type type;
 	union {
-		union {
-			const u8 *u8_data;
-			const u16 *u16_data;
-			const u32 *u32_data;
-			const u64 *u64_data;
-			const char * const *str;
-		} pointer;
+		const void *pointer;
 		union {
 			u8 u8_data;
 			u16 u16_data;
@@ -262,7 +256,7 @@ struct property_entry {
 	.length = (_len_) * sizeof(_type_),				\
 	.is_array = true,						\
 	.type = DEV_PROP_##_Type_,					\
-	{ .pointer = { ._type_##_data = _val_ } },			\
+	{ .pointer = _val_ },						\
 }
 
 #define PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, _len_)		\
@@ -280,7 +274,7 @@ struct property_entry {
 	.length = (_len_) * sizeof(const char *),			\
 	.is_array = true,						\
 	.type = DEV_PROP_STRING,					\
-	{ .pointer = { .str = _val_ } },				\
+	{ .pointer = _val_ },						\
 }
 
 #define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)				\
-- 
2.23.0.700.g56cf767bdb-goog

