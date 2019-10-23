Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60394E23A0
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 22:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405360AbfJWUCu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Oct 2019 16:02:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43104 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405250AbfJWUCt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2019 16:02:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id a2so13588323pfo.10;
        Wed, 23 Oct 2019 13:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E4mNM5mJotUAYNSU0vj/fSOZ8Nl4ZQb67KQvwfFGcWE=;
        b=P1AL0t955F72dVC4EwQ1KiaFVlEcyiWIVUZBww0avHwp33oIkg+6qPwSjxctlbGhBv
         yIWM+uJDOHOBD4Bm4CMAVAd5BQc0Ez4BxeIix3fz33Ft6J0JhVtNCMEP9/u0xvBlHT8z
         FHahhb6a53He4PfK07Xn+Wv108gvLJxwEIv2HNTWMloRnCjUlBBmPoz0kDQHbfVScKju
         3xtHm4UDZczdvkAgqpR7A+qlBJLNRXUqFby+6x1zRXtgJt7F0yCSspO2ePt3ZVnnSNtT
         ot0y9/6gVOIVNjBwKjNqkwMU5g1F1QNJgsx4rvgRed4Yajvysy3DieMKkt19f8uVggU/
         Um2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E4mNM5mJotUAYNSU0vj/fSOZ8Nl4ZQb67KQvwfFGcWE=;
        b=dXsQW7oSG34cdBa3WIxAopeJqUMZilOW5TH3m28PEBtjUfTSVhcG713tTic0aSOsAA
         0lEqzN8oxwDPZCXr0Dqd5qwKOn+NEdTdJLqRa17BHqZ5Bt57/A1EQFfRkHrBBABOWEvY
         dzzhSoHX2ASX2CceF6sRPB6zEjscLRRCLjOOZRJ9ELRNfO8ZUZJdJQJiwh5okVUUy4vX
         Nl2rybskSQj7ZsKn2kLUMRRmq4uHYZLYnEm0PCQv+IcI5Ji29oiux1la3Qn++0mF9Y8+
         f17G/G3Nml5GzmSjp/Pr4htv5s+xGRxPhbif/wRfGtL6BwO5+bQ7CDwmmLfFTS9ByhOf
         y+zw==
X-Gm-Message-State: APjAAAX2pqoelkMMRicJq70tDXoiJT2G7RKCk32XA8OBNe42VKTwafjL
        FA7MfywzXorwwrox1b49XMY=
X-Google-Smtp-Source: APXvYqyv+UPOoeAht2DDHkoFPH8pdqS9e6HXJKMnt/5rtCif10V7PSNTCWCKfxQg9Gy+RbuZFeUY9A==
X-Received: by 2002:a63:330f:: with SMTP id z15mr11921768pgz.231.1571860968415;
        Wed, 23 Oct 2019 13:02:48 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 6sm10593598pfy.43.2019.10.23.13.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 13:02:47 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 06/15] software node: get rid of property_set_pointer()
Date:   Wed, 23 Oct 2019 13:02:24 -0700
Message-Id: <20191023200233.86616-7-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
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
index f41692e0f63b..fd667a73a201 100644
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
index d6019bacd848..12eff7cbb395 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -238,13 +238,7 @@ struct property_entry {
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
@@ -267,7 +261,7 @@ struct property_entry {
 	.length = (_len_) * sizeof(_type_),				\
 	.is_array = true,						\
 	.type = DEV_PROP_##_Type_,					\
-	{ .pointer = { ._type_##_data = _val_ } },			\
+	{ .pointer = _val_ },						\
 }
 
 #define PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, _len_)		\
@@ -285,7 +279,7 @@ struct property_entry {
 	.length = (_len_) * sizeof(const char *),			\
 	.is_array = true,						\
 	.type = DEV_PROP_STRING,					\
-	{ .pointer = { .str = _val_ } },				\
+	{ .pointer = _val_ },						\
 }
 
 #define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)				\
-- 
2.23.0.866.gb869b98d4c-goog

