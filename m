Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E607E23B8
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 22:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405576AbfJWUCy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Oct 2019 16:02:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35380 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405535AbfJWUCy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2019 16:02:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so13597660pfw.2;
        Wed, 23 Oct 2019 13:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UQeFLa+OhHK62m3xBGQg82d/4If30mhWIdkbN0WgMXc=;
        b=c58O1Hky20/Vp4ObNl4HQrvnTa7/CGgdXUdt/vPPB+1z4xGS1BpEYh5OEMxuxPZkL7
         jqF/lxHdIeUs4TfTh9f6qUCvTUO4rWQbaahp1iETznTye+z9TMAqb2Ls6qRSFoPZcw1a
         3EmG0/90kBjZBTtv3s9J5qjAAtA71ghSwyEYwQo9vq/mPNKPNYBiobTe5n5YNWet20tH
         YHjaQ8WcCWxvDe0BoM7CLw8QXL056TdV/F3MmEgrQeZHL9zjRreFyUdQaVhWrx2to9ul
         uRlCxQickn9ssgU7PQJnUG/iZesbQYeNbaLwsshcbNnxCikFL0izviY+CbMDadnpuQ32
         HLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQeFLa+OhHK62m3xBGQg82d/4If30mhWIdkbN0WgMXc=;
        b=XLirNvhT0crCM8ss7l7CqUAfyyJS1rTye/ZPkamyTl2vEdLi7pVVpxx51O46i4g6Sc
         v0lYvXKeOhOCQcgT2ggS8XcdiE+1jZndT+mXCANxHoJevYF1RoJ5l2dgDZfqdXNbzCov
         8m87Ints1q71QoERDMTnaWQkhF2EsvMaNRecqrWXT+c+jWJkRNIAp4LAOXod1FSrIaVy
         Jh50FekSJkynNFwDrcja8mySqmehExjpRGGz8GwBfBjhvUoRloh0AQLMtW6PPdD9whnD
         dcnjJIX59BmkOq9X7015oJChj7w03OBMxAsfmnOl43I0DY202gzqmo7LzA1mNmxnXM/R
         /vNw==
X-Gm-Message-State: APjAAAVZl9xFWLziwn/P6eT2r5c+OVe2Lpumpp0ua7sRKPMB6qnDMf6d
        GkkVQYDIp9IGtankmFvvQF7vME1i
X-Google-Smtp-Source: APXvYqz6Ta/ZqS0U53REors5qkSUEfg+NsYf0UzqBIFf8w6G0YEhfYt4QKnN+Qu3tus8bZ8r4a0mAw==
X-Received: by 2002:aa7:8583:: with SMTP id w3mr13408996pfn.182.1571860972829;
        Wed, 23 Oct 2019 13:02:52 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 6sm10593598pfy.43.2019.10.23.13.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 13:02:51 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 08/15] software node: unify PROPERTY_ENTRY_XXX macros
Date:   Wed, 23 Oct 2019 13:02:26 -0700
Message-Id: <20191023200233.86616-9-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
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
index 12eff7cbb395..48335288c2a9 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -250,37 +250,33 @@ struct property_entry {
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
@@ -293,30 +289,24 @@ struct property_entry {
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
2.23.0.866.gb869b98d4c-goog

