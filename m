Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10F4BD4AAE
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2019 01:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfJKXHc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 19:07:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32813 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfJKXHb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 19:07:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id i76so6619871pgc.0;
        Fri, 11 Oct 2019 16:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RnKvYYIsaWzXDiXUGcpFyytv3QO7fUH3tnXfDULVuBw=;
        b=W4AAfAQn/IONg/xV4fI08ZaOEFyRF3bJEtfRXmzLbdEgHEazSpcurduTRhObKpnaQ5
         nKUGu/bDuwS6Di8uvVtDjwCAJpFKPDcZSWlo5wwQFKTT5RcN4nOfTAzufh94RwhenE6w
         1TrnExvm7DizeqA18j/vGyg7WaL0/3XmKuVULwHJ+C8WhuPHLaz5BJY3axZrBbmI93Sf
         jugPKOFF1eeUNTvjFRP7gkDXDjt6d8jhtm6VKW7TKXAUbcJnBESdzkEUwVqPLsbk4eYo
         LS2DVCWvMNjYnv9QuEfwUktBvuYG10oym1nOgz1CDlvdn2CEb79iDn3Dg94km5C35F2m
         mgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RnKvYYIsaWzXDiXUGcpFyytv3QO7fUH3tnXfDULVuBw=;
        b=QM7y+Qawc3/1WfVVsJ+80rB3aHs9LsOfO4MtpxLIMDf9nhDIEF7rWLhdklAGBrb2aL
         S3E/rI9ciy+ma2UWMhCUnvU1Lzls3ylS9rD7598ZmQ2be/qOjSc48lyI562csdp8sj8w
         l5HjPGf7tRK+aqrGbJWA/okqcbFhp+sEohD+82s405QG1rVPLAQlFtDXFZYGu26CTLVZ
         Bcezo9k+MC2k+wWYy/DyZLz677xp2LE3y2pDsKaUWf6K73ujkJ0DEap713NzrXthyOgC
         dkf2CZ/gSXoAAwLaMkLnKREYbP4yd8/SBPXIGixd8frXhiXnmb7y98rFKp/qOAP7y9Qz
         LuhQ==
X-Gm-Message-State: APjAAAUSFErHei+JsjP4w223R8DniREE6jvc4iZrD+ScvCSThYh8ZZJo
        KtXpliNhfqfhUSJOCHgtH1UNvd9n
X-Google-Smtp-Source: APXvYqzvCMJ0Ij7Od1pT0+Xdf7FUEY5b5xcIKSO/ARlH0HY6u8tKlSXnvpPSFi6F3BLrDETbqjSY1g==
X-Received: by 2002:a63:a054:: with SMTP id u20mr7118066pgn.313.1570835250144;
        Fri, 11 Oct 2019 16:07:30 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w2sm11529251pfn.57.2019.10.11.16.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 16:07:29 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 04/14] software node: mark internal macros with double underscores
Date:   Fri, 11 Oct 2019 16:07:11 -0700
Message-Id: <20191011230721.206646-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
In-Reply-To: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Let's mark PROPERTY_ENTRY_* macros that are internal with double leading
underscores so users are not tempted to use them.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/property.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index f89b930ca4b7..2c9d4d209296 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -256,7 +256,7 @@ struct property_entry {
  * and structs.
  */
 
-#define PROPERTY_ENTRY_ARRAY_LEN(_name_, _type_, _Type_, _val_, _len_)	\
+#define __PROPERTY_ENTRY_ARRAY_LEN(_name_, _type_, _Type_, _val_, _len_)\
 (struct property_entry) {						\
 	.name = _name_,							\
 	.length = (_len_) * sizeof(_type_),				\
@@ -266,13 +266,13 @@ struct property_entry {
 }
 
 #define PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, _len_)		\
-	PROPERTY_ENTRY_ARRAY_LEN(_name_, u8, U8, _val_, _len_)
+	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u8, U8, _val_, _len_)
 #define PROPERTY_ENTRY_U16_ARRAY_LEN(_name_, _val_, _len_)		\
-	PROPERTY_ENTRY_ARRAY_LEN(_name_, u16, U16, _val_, _len_)
+	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u16, U16, _val_, _len_)
 #define PROPERTY_ENTRY_U32_ARRAY_LEN(_name_, _val_, _len_)		\
-	PROPERTY_ENTRY_ARRAY_LEN(_name_, u32, U32, _val_, _len_)
+	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u32, U32, _val_, _len_)
 #define PROPERTY_ENTRY_U64_ARRAY_LEN(_name_, _val_, _len_)		\
-	PROPERTY_ENTRY_ARRAY_LEN(_name_, u64, U64, _val_, _len_)
+	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u64, U64, _val_, _len_)
 
 #define PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, _len_)		\
 (struct property_entry) {						\
@@ -294,7 +294,7 @@ struct property_entry {
 #define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)			\
 	PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
 
-#define PROPERTY_ENTRY_INTEGER(_name_, _type_, _Type_, _val_)	\
+#define __PROPERTY_ENTRY_INTEGER(_name_, _type_, _Type_, _val_)	\
 (struct property_entry) {					\
 	.name = _name_,						\
 	.length = sizeof(_type_),				\
@@ -303,13 +303,13 @@ struct property_entry {
 }
 
 #define PROPERTY_ENTRY_U8(_name_, _val_)		\
-	PROPERTY_ENTRY_INTEGER(_name_, u8, U8, _val_)
+	__PROPERTY_ENTRY_INTEGER(_name_, u8, U8, _val_)
 #define PROPERTY_ENTRY_U16(_name_, _val_)		\
-	PROPERTY_ENTRY_INTEGER(_name_, u16, U16, _val_)
+	__PROPERTY_ENTRY_INTEGER(_name_, u16, U16, _val_)
 #define PROPERTY_ENTRY_U32(_name_, _val_)		\
-	PROPERTY_ENTRY_INTEGER(_name_, u32, U32, _val_)
+	__PROPERTY_ENTRY_INTEGER(_name_, u32, U32, _val_)
 #define PROPERTY_ENTRY_U64(_name_, _val_)		\
-	PROPERTY_ENTRY_INTEGER(_name_, u64, U64, _val_)
+	__PROPERTY_ENTRY_INTEGER(_name_, u64, U64, _val_)
 
 #define PROPERTY_ENTRY_STRING(_name_, _val_)		\
 (struct property_entry) {				\
-- 
2.23.0.700.g56cf767bdb-goog

