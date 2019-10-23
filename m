Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6200E23C2
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 22:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405325AbfJWUCs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Oct 2019 16:02:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40668 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405250AbfJWUCq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2019 16:02:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id 15so7411455pgt.7;
        Wed, 23 Oct 2019 13:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQpe2VSd833fMVSnCEuCtaneErs8UtbkJfg8Hab68oA=;
        b=kdaK28naNBUwj6a4ZZ/2PHgGkOWbyACEdEqBSql9+Gd5j/3lB0KrC4tlenrticjPP3
         ntktb+2yu2ei7VLvN0KaGGz1PlkSm8ipW4x2HUZDJK7TUGZ2TX8I8WSHH+X7eVhvbK9D
         Rx8HONM7PXFQ6DH0yFVAfQMZRvRABHyduJHbU9Y9kIfj/I+I/VM53SozVz9nICadbmcu
         GI5aoOoyjPSsgcoTrDgY1RamCx90Fl1xVoNezPlMpBdyCbsXUPGafVe300Gy8nM5Ens+
         KOhyc0HduO0V+sv3tYcjAaNV/+sQ+8fptPhSNDLcIcBIgw4cNT0gHKyS+fMDoxERmDIN
         e21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQpe2VSd833fMVSnCEuCtaneErs8UtbkJfg8Hab68oA=;
        b=eJQpffbNV1a59tzKhAQ2a1dHeAOKJcvUpaPEzOaImFcHUMsYQ/OsGskNpz5T7nZBUm
         q3RrsK39mmrqNg7QgB4OtG7WVGEmhqiF7RkX5uQf1kO6CUp7L8OOjimiqMZ4p2NtyfCp
         VOVaWNbGRFXoda7xjyrtKRTO+u70rZ1D7OJM1hU1jtGScYPcHGjBAPAkDzHVjyl1e1Yf
         E7LfQ7g10pY56E1I9wQ4LNimguJCNsSYTKClUsbkKIw9x8jN77FOyvPqhXTQVgd/iPJ8
         0UTqiigkbgnhUU2eShn77N7dZJtjcH622KUsuVAHyXjmePMgsJsDn8qwqLgo4KTmlqdy
         wtqA==
X-Gm-Message-State: APjAAAXWbrPocndWFtqgHSQjKHH4DwGGp3UufDwYb5ubBrEVEuMP1lsK
        ieDIjpqLYwuTorNcYMh3gIY=
X-Google-Smtp-Source: APXvYqxyRgz+W/NS2FHRZwiG5KqfvAyLK6GpAsMwYR990mOz0HPTghKwR31MlMVcd7C+xpFzf4mq0A==
X-Received: by 2002:a65:6781:: with SMTP id e1mr12243091pgr.173.1571860965210;
        Wed, 23 Oct 2019 13:02:45 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 6sm10593598pfy.43.2019.10.23.13.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 13:02:44 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 04/15] software node: mark internal macros with double underscores
Date:   Wed, 23 Oct 2019 13:02:22 -0700
Message-Id: <20191023200233.86616-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
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
index fad2e83a207c..d6019bacd848 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -261,7 +261,7 @@ struct property_entry {
  * and structs.
  */
 
-#define PROPERTY_ENTRY_ARRAY_LEN(_name_, _type_, _Type_, _val_, _len_)	\
+#define __PROPERTY_ENTRY_ARRAY_LEN(_name_, _type_, _Type_, _val_, _len_)\
 (struct property_entry) {						\
 	.name = _name_,							\
 	.length = (_len_) * sizeof(_type_),				\
@@ -271,13 +271,13 @@ struct property_entry {
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
@@ -299,7 +299,7 @@ struct property_entry {
 #define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)			\
 	PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
 
-#define PROPERTY_ENTRY_INTEGER(_name_, _type_, _Type_, _val_)	\
+#define __PROPERTY_ENTRY_INTEGER(_name_, _type_, _Type_, _val_)	\
 (struct property_entry) {					\
 	.name = _name_,						\
 	.length = sizeof(_type_),				\
@@ -308,13 +308,13 @@ struct property_entry {
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
2.23.0.866.gb869b98d4c-goog

