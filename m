Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18D2CF3EDB
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 05:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfKHEWs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Nov 2019 23:22:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41819 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbfKHEWf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Nov 2019 23:22:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id d29so3169363plj.8;
        Thu, 07 Nov 2019 20:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+UAfSxO+xFzb8U0KaiRZauI96OA1CjCGgwrEB72JhoA=;
        b=lYu+kGGuNfcKv+qfcTC1XfqrLcTpPx70xltj+VISO1k3Xwa5ZHkjdEyxR00xcZsvT9
         jFxunziqLrqCU583dzEx5/+1kPgqqZoMKlrLoNozBEzPopc1cEK18EZdXJ2ASt4F0rb9
         Uj+TSZuVF6fGjWVqamrLSHHpHhkiMurEWT2TMUt8pCh4Zly5jN7bsupV+zFoy0phVEaU
         3oCVVdEql1VMbD8QIgu2WZZOXtZ2vemlP87EA/ONvg/WXTsQKkMhEyUUY4HqiC8kBToy
         UacV0Q8urG3QLg0wHESif8DeF20ca/Et47OQLp2quDonsPBWVTMmuab0ekqxpXDJmlrL
         7t8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+UAfSxO+xFzb8U0KaiRZauI96OA1CjCGgwrEB72JhoA=;
        b=Xm3tfyBaRpbuW20L98wu9mjLvVPrDEjQ+FJ/Y8nvVSfCW8Rz6h3QpaJDelJwwjbuCd
         +Rt5TRaXjEvE3y4pu8vKtyyVNZW1lg9ibARLW1uaLxlbs63uPrroysfTk04ctVbIAI7a
         +bods3dgtOc+1Fnhc+Gn1DwHYOp4pPxf5p7RROYT05/QU8JGIyqVOmWtUl0JtMN4kQ9t
         TkuQqGeaixqrmZmmCOPtoj1EniZIlsdBrWIgdkL0oYqIO2v8jAd987yOcxp+fT0FFCX0
         nTrwJUu5rateb+6o3fCcwOepcGmblpYtytCAG+sK6N6VGQuXp0S6pkWdkM94PjuFD/Dx
         4BZw==
X-Gm-Message-State: APjAAAWwBnzz9QDxKqQJE7U/xPhBQXL7NCagOXtym7+mpOF6qxrf4JED
        smy5egOgD7u4vsWwlUqN26k=
X-Google-Smtp-Source: APXvYqybZXJsa7klVx58NNroyaoC4gJPnr5iSNFgFwS0GAle6hHU8EzdaaUrGJw9RZle1jA47QXvQQ==
X-Received: by 2002:a17:90a:fa84:: with SMTP id cu4mr10410931pjb.65.1573186952905;
        Thu, 07 Nov 2019 20:22:32 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 71sm5004106pfx.107.2019.11.07.20.22.31
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
Subject: [PATCH v8 3/6] software node: implement reference properties
Date:   Thu,  7 Nov 2019 20:22:22 -0800
Message-Id: <20191108042225.45391-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
References: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It is possible to store references to software nodes in the same fashion as
other static properties, so that users do not need to define separate
structures:

static const struct software_node gpio_bank_b_node = {
	.name = "B",
};

static const struct property_entry simone_key_enter_props[] = {
	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
	PROPERTY_ENTRY_STRING("label", "enter"),
	PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
	{ }
};

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c    | 49 ++++++++++++++++++++++++++++------
 include/linux/property.h | 57 +++++++++++++++++++++++++++++-----------
 2 files changed, 82 insertions(+), 24 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 3d422918a53d9..604d7327bba79 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -246,6 +246,13 @@ static int property_entry_copy_data(struct property_entry *dst,
 	if (!src->is_inline && !src->length)
 		return -ENODATA;
 
+	/*
+	 * Reference properties are never stored inline as
+	 * they are too big.
+	 */
+	if (src->type == DEV_PROP_REF && src->is_inline)
+		return -EINVAL;
+
 	if (src->length <= sizeof(dst->value)) {
 		dst_ptr = &dst->value;
 		dst->is_inline = true;
@@ -473,23 +480,49 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 {
 	struct swnode *swnode = to_swnode(fwnode);
 	const struct software_node_reference *ref;
+	const struct software_node_ref_args *ref_array;
+	const struct software_node_ref_args *ref_args;
 	const struct property_entry *prop;
 	struct fwnode_handle *refnode;
 	u32 nargs_prop_val;
 	int error;
 	int i;
 
-	if (!swnode || !swnode->node->references)
+	if (!swnode)
 		return -ENOENT;
 
-	for (ref = swnode->node->references; ref->name; ref++)
-		if (!strcmp(ref->name, propname))
-			break;
+	prop = property_entry_get(swnode->node->properties, propname);
+	if (prop) {
+		if (prop->type != DEV_PROP_REF)
+			return -EINVAL;
 
-	if (!ref->name || index > (ref->nrefs - 1))
-		return -ENOENT;
+		/*
+		 * We expect that references are never stored inline, even
+		 * single ones, as they are too big.
+		 */
+		if (prop->is_inline)
+			return -EINVAL;
+
+		if (index * sizeof(*ref_args) >= prop->length)
+			return -ENOENT;
+
+		ref_array = prop->pointer;
+		ref_args = &ref_array[index];
+	} else {
+		if (!swnode->node->references)
+			return -ENOENT;
+
+		for (ref = swnode->node->references; ref->name; ref++)
+			if (!strcmp(ref->name, propname))
+				break;
+
+		if (!ref->name || index > (ref->nrefs - 1))
+			return -ENOENT;
+
+		ref_args = &ref->refs[index];
+	}
 
-	refnode = software_node_fwnode(ref->refs[index].node);
+	refnode = software_node_fwnode(ref_args->node);
 	if (!refnode)
 		return -ENOENT;
 
@@ -510,7 +543,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	args->nargs = nargs;
 
 	for (i = 0; i < nargs; i++)
-		args->args[i] = ref->refs[index].args[i];
+		args->args[i] = ref_args->args[i];
 
 	return 0;
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index c592c286e3394..19b9dcc322763 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -22,6 +22,7 @@ enum dev_prop_type {
 	DEV_PROP_U32,
 	DEV_PROP_U64,
 	DEV_PROP_STRING,
+	DEV_PROP_REF,
 };
 
 enum dev_dma_attr {
@@ -223,6 +224,20 @@ static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
 	return fwnode_property_read_u64_array(fwnode, propname, NULL, 0);
 }
 
+struct software_node;
+
+/**
+ * struct software_node_ref_args - Reference property with additional arguments
+ * @node: Reference to a software node
+ * @nargs: Number of elements in @args array
+ * @args: Integer arguments
+ */
+struct software_node_ref_args {
+	const struct software_node *node;
+	unsigned int nargs;
+	u64 args[NR_FWNODE_REFERENCE_ARGS];
+};
+
 /**
  * struct property_entry - "Built-in" device property representation.
  * @name: Name of the property.
@@ -260,14 +275,20 @@ struct property_entry {
 #define __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_)				\
 	sizeof(((struct property_entry *)NULL)->value._elem_[0])
 
-#define __PROPERTY_ENTRY_ARRAY_LEN(_name_, _elem_, _Type_, _val_, _len_)\
+#define __PROPERTY_ENTRY_ARRAY_ELSIZE_LEN(_name_, _elsize_, _Type_,	\
+					  _val_, _len_)			\
 (struct property_entry) {						\
 	.name = _name_,							\
-	.length = (_len_) * __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),	\
+	.length = (_len_) * (_elsize_),					\
 	.type = DEV_PROP_##_Type_,					\
 	{ .pointer = _val_ },						\
 }
 
+#define __PROPERTY_ENTRY_ARRAY_LEN(_name_, _elem_, _Type_, _val_, _len_)\
+	__PROPERTY_ENTRY_ARRAY_ELSIZE_LEN(_name_,			\
+				__PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),	\
+				_Type_, _val_, _len_)
+
 #define PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, _len_)		\
 	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u8_data, U8, _val_, _len_)
 #define PROPERTY_ENTRY_U16_ARRAY_LEN(_name_, _val_, _len_)		\
@@ -278,6 +299,10 @@ struct property_entry {
 	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u64_data, U64, _val_, _len_)
 #define PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, _len_)		\
 	__PROPERTY_ENTRY_ARRAY_LEN(_name_, str, STRING, _val_, _len_)
+#define PROPERTY_ENTRY_REF_ARRAY_LEN(_name_, _val_, _len_)		\
+	__PROPERTY_ENTRY_ARRAY_ELSIZE_LEN(_name_,			\
+				sizeof(struct software_node_ref_args),	\
+				REF, _val_, _len_)
 
 #define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)				\
 	PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
@@ -289,6 +314,8 @@ struct property_entry {
 	PROPERTY_ENTRY_U64_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
 #define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)			\
 	PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
+#define PROPERTY_ENTRY_REF_ARRAY(_name_, _val_)			\
+	PROPERTY_ENTRY_REF_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
 
 #define __PROPERTY_ENTRY_ELEMENT(_name_, _elem_, _Type_, _val_)		\
 (struct property_entry) {						\
@@ -316,6 +343,18 @@ struct property_entry {
 	.is_inline = true,			\
 }
 
+#define PROPERTY_ENTRY_REF(_name_, _ref_, ...)				\
+(struct property_entry) {						\
+	.name = _name_,							\
+	.length = sizeof(struct software_node_ref_args),		\
+	.type = DEV_PROP_REF,						\
+	{ .pointer = &(const struct software_node_ref_args) {		\
+		.node = _ref_,						\
+		.nargs = ARRAY_SIZE(((u64[]){ 0, ##__VA_ARGS__ })) - 1,	\
+		.args = { __VA_ARGS__ },				\
+	} },								\
+}
+
 struct property_entry *
 property_entries_dup(const struct property_entry *properties);
 
@@ -379,20 +418,6 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 /* -------------------------------------------------------------------------- */
 /* Software fwnode support - when HW description is incomplete or missing */
 
-struct software_node;
-
-/**
- * struct software_node_ref_args - Reference with additional arguments
- * @node: Reference to a software node
- * @nargs: Number of elements in @args array
- * @args: Integer arguments
- */
-struct software_node_ref_args {
-	const struct software_node *node;
-	unsigned int nargs;
-	u64 args[NR_FWNODE_REFERENCE_ARGS];
-};
-
 /**
  * struct software_node_reference - Named software node reference property
  * @name: Name of the property
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

