Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA48D4AA4
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2019 01:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfJKXIJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 19:08:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45189 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbfJKXHh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 19:07:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so5412038pgj.12;
        Fri, 11 Oct 2019 16:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OqjVMmiDxfmWkTPNKFCbYpwJz27qwBGl/ZyazByuYTo=;
        b=JRnPoZdpObClmVOztYVeJ8IqwldxKRkV+F+19NBbFBwDUh9vtyM0+wFOw5veBv3cBF
         3f1y7wVNXynYYanRJOcZ3M+S0vgM/ZLvHZUppSPt/K+pIVi7p/n7L0v9XnyFMh69nw0Q
         Y6S0McDonX/IVWUPB6tFMWA21tUr2IgIZe9l899S7obyvtA0P6CXkVjeliDw0l2U1jCH
         wilmgPHRyMRBjGT0cX8y/1aVqROK6KEOY7aZqB2CikFjP+5PPPEhBaZ7nfg+OYPqszJJ
         Jz/su4Qc5u2czXdlMHZ6hswKD3r0a94HCtPL3qhy29kMGO/Hwc9DMJSET66+okMcL6WI
         f0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OqjVMmiDxfmWkTPNKFCbYpwJz27qwBGl/ZyazByuYTo=;
        b=guYVt1QNO9WXKNKfshJZu28TYnLWdIwtlhHuOAOV+RU/8WzjuU30vji/o2ibYJheTZ
         jbnMnQRQp4NGVJhwSc9hbVd4yUodpBap64eN4BxpjiD77LwGwOCtChSC1irWgaMVSoCf
         Eb3tvXfJReRwi55QzMLUDZDB5v273wxZtysR4k1u+3yR48zDGeCJZKUClww6tOltlHfU
         ANNNmerQ29FEqSRzULo+spfuXWQU/HnWjDBfS17p0frgxuCr60tlTPsnasoIAiYG5V2N
         CF8IkISrWb1E8mGtJIUs1JEMRmBYR5MnaJbbmtTg32PmFzN51r3Brq9Ckt6UuTCCtIHz
         Bc0Q==
X-Gm-Message-State: APjAAAU71VUCZnmc8JfeucT9tigrBUm/j4+aJRsI4g5WZ5X0fCf4io30
        IOqcXnLzAT2+qOsDPjgLvEqMld+R
X-Google-Smtp-Source: APXvYqx9kbyBMLwN3pCVvjb+MPuBzU7X2/QUuJO5QsTfWS4c6PHjKInZX81gE54gTsHZ8L2foEB6WA==
X-Received: by 2002:a62:e40d:: with SMTP id r13mr19071958pfh.135.1570835256206;
        Fri, 11 Oct 2019 16:07:36 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w2sm11529251pfn.57.2019.10.11.16.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 16:07:35 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 08/14] software node: unify PROPERTY_ENTRY_XXX macros
Date:   Fri, 11 Oct 2019 16:07:15 -0700
Message-Id: <20191011230721.206646-9-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
In-Reply-To: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

We can unify string properties initializer macros with integer
initializers.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/property.h | 64 +++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index ec8f84d564a8..238e1507925f 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -245,37 +245,33 @@ struct property_entry {
 };
 
 /*
- * Note: the below four initializers for the anonymous union are carefully
+ * Note: the below initializers for the anonymous union are carefully
  * crafted to avoid gcc-4.4.4's problems with initialization of anon unions
  * and structs.
  */
 
-#define __PROPERTY_ENTRY_ARRAY_LEN(_name_, _type_, _Type_, _val_, _len_)\
+#define __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_)				\
+	sizeof(((struct property_entry *)NULL)->value._elem_)
+
+#define __PROPERTY_ENTRY_ARRAY_LEN(_name_, _elem_, _Type_, _val_, _len_)\
 (struct property_entry) {						\
 	.name = _name_,							\
-	.length = (_len_) * sizeof(_type_),				\
+	.length = (_len_) * __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),	\
 	.is_array = true,						\
 	.type = DEV_PROP_##_Type_,					\
 	{ .pointer = _val_ },						\
 }
 
 #define PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, _len_)		\
-	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u8, U8, _val_, _len_)
+	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u8_data, U8, _val_, _len_)
 #define PROPERTY_ENTRY_U16_ARRAY_LEN(_name_, _val_, _len_)		\
-	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u16, U16, _val_, _len_)
+	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u16_data, U16, _val_, _len_)
 #define PROPERTY_ENTRY_U32_ARRAY_LEN(_name_, _val_, _len_)		\
-	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u32, U32, _val_, _len_)
+	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u32_data, U32, _val_, _len_)
 #define PROPERTY_ENTRY_U64_ARRAY_LEN(_name_, _val_, _len_)		\
-	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u64, U64, _val_, _len_)
-
+	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u64_data, U64, _val_, _len_)
 #define PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, _len_)		\
-(struct property_entry) {						\
-	.name = _name_,							\
-	.length = (_len_) * sizeof(const char *),			\
-	.is_array = true,						\
-	.type = DEV_PROP_STRING,					\
-	{ .pointer = _val_ },						\
-}
+	__PROPERTY_ENTRY_ARRAY_LEN(_name_, str, STRING, _val_, _len_)
 
 #define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)				\
 	PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
@@ -288,30 +284,24 @@ struct property_entry {
 #define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)			\
 	PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
 
-#define __PROPERTY_ENTRY_INTEGER(_name_, _type_, _Type_, _val_)	\
-(struct property_entry) {					\
-	.name = _name_,						\
-	.length = sizeof(_type_),				\
-	.type = DEV_PROP_##_Type_,				\
-	{ .value = { ._type_##_data = _val_ } },		\
+#define __PROPERTY_ENTRY_ELEMENT(_name_, _elem_, _Type_, _val_)		\
+(struct property_entry) {						\
+	.name = _name_,							\
+	.length = __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),		\
+	.type = DEV_PROP_##_Type_,					\
+	{ .value = { ._elem_ = _val_ } },				\
 }
 
-#define PROPERTY_ENTRY_U8(_name_, _val_)		\
-	__PROPERTY_ENTRY_INTEGER(_name_, u8, U8, _val_)
-#define PROPERTY_ENTRY_U16(_name_, _val_)		\
-	__PROPERTY_ENTRY_INTEGER(_name_, u16, U16, _val_)
-#define PROPERTY_ENTRY_U32(_name_, _val_)		\
-	__PROPERTY_ENTRY_INTEGER(_name_, u32, U32, _val_)
-#define PROPERTY_ENTRY_U64(_name_, _val_)		\
-	__PROPERTY_ENTRY_INTEGER(_name_, u64, U64, _val_)
-
-#define PROPERTY_ENTRY_STRING(_name_, _val_)		\
-(struct property_entry) {				\
-	.name = _name_,					\
-	.length = sizeof(const char *),			\
-	.type = DEV_PROP_STRING,			\
-	{ .value = { .str = _val_ } },			\
-}
+#define PROPERTY_ENTRY_U8(_name_, _val_)				\
+	__PROPERTY_ENTRY_ELEMENT(_name_, u8_data, U8, _val_)
+#define PROPERTY_ENTRY_U16(_name_, _val_)				\
+	__PROPERTY_ENTRY_ELEMENT(_name_, u16_data, U16, _val_)
+#define PROPERTY_ENTRY_U32(_name_, _val_)				\
+	__PROPERTY_ENTRY_ELEMENT(_name_, u32_data, U32, _val_)
+#define PROPERTY_ENTRY_U64(_name_, _val_)				\
+	__PROPERTY_ENTRY_ELEMENT(_name_, u64_data, U64, _val_)
+#define PROPERTY_ENTRY_STRING(_name_, _val_)				\
+	__PROPERTY_ENTRY_ELEMENT(_name_, str, STRING, _val_)
 
 #define PROPERTY_ENTRY_BOOL(_name_)		\
 (struct property_entry) {			\
-- 
2.23.0.700.g56cf767bdb-goog

