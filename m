Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21249D4AAB
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2019 01:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfJKXH2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 19:07:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34396 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfJKXH2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 19:07:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id b128so6943580pfa.1;
        Fri, 11 Oct 2019 16:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lT2gdQyjp1sZtsGK/c5q0z/d1jVgKn5OQ6k2qAgpVco=;
        b=ZD9vEh8g78CR+rwyuhgYTdu+267riPbETM2kgP4gMcGDVaPA8qYVxS3RZ88yNgnwfq
         jWxmnjiK0aK94aeVGTdoo6N5H1qWBEnLg7arpONYqKh1k0gts0mUHgdypxMplT3alSRH
         +8UohxmpNKU5RovPhzcCK1AabW6sQRFcC+nVsUgSoDWLQVmo+PmLQVd59tiSHOH81Z6e
         XWXBGG0bS/dY5QBRUYNV8udhmy6lGqciEBL4sTUO7mQkGKnwO3UlhcCBuj36cut/ZESZ
         WADo3RmqisGwoV3LxobG4D54rAVnBIhM7c6yERYz4WV6xa49zslacM7mn1BhG35V4Z/K
         0U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lT2gdQyjp1sZtsGK/c5q0z/d1jVgKn5OQ6k2qAgpVco=;
        b=ekQyMWaudQlK+48xt9eXguxV+BMtis4Kqza5BnmhySwRKBu+lfbbHsUDeCCdvpoZrq
         yT1ZqqMS+pTPEYkRk0XYBSY4ZQEPaMzdqT4NI9FAOe1hGYzwotrGux5gZ8IOV1ymKM+s
         jyTd9RZkt5q4BeT6JCKOLrCBs1sMv9+pf7vM5Km57IkKrHCpsTW10Mo7NUADhAChy7ag
         Q7eKTpZurVQS38UlCnQktW2pS2Xckc+NAN5B8+2ydmijM4RyMvpAUcIH7CqIrgGoJsmP
         JttRIFPC5R3ksDKlay2+h6J6gFERloiKYlXOlSLt6mY7eNd7WY0/POEPgIqbgFj7e0/V
         1LGw==
X-Gm-Message-State: APjAAAWmfjxvpPzoM0DedR66vrs2tyb92A2GRY2f/IVwpc1WtnNGU+QE
        zogWrD/nyH/9u9naFczpsc4=
X-Google-Smtp-Source: APXvYqwOuJaftQtLj0GEpLf419ArNk3YVlmp0/3HCXM+AfFiGEjrLjZ4Nk6STb3b7NnfUPdEv9oTwA==
X-Received: by 2002:a63:2d43:: with SMTP id t64mr19301047pgt.428.1570835247330;
        Fri, 11 Oct 2019 16:07:27 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w2sm11529251pfn.57.2019.10.11.16.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 16:07:26 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 02/14] software node: introduce PROPERTY_ENTRY_ARRAY_XXX_LEN()
Date:   Fri, 11 Oct 2019 16:07:09 -0700
Message-Id: <20191011230721.206646-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
In-Reply-To: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Sometimes we want to initialize property entry array from a regular
pointer, when we can't determine length automatically via ARRAY_SIZE.
Let's introduce PROPERTY_ENTRY_ARRAY_XXX_LEN macros that take explicit
"len" argument.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/property.h | 45 +++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 44c1704f7163..f89b930ca4b7 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -256,33 +256,44 @@ struct property_entry {
  * and structs.
  */
 
-#define PROPERTY_ENTRY_INTEGER_ARRAY(_name_, _type_, _Type_, _val_)	\
+#define PROPERTY_ENTRY_ARRAY_LEN(_name_, _type_, _Type_, _val_, _len_)	\
 (struct property_entry) {						\
 	.name = _name_,							\
-	.length = ARRAY_SIZE(_val_) * sizeof(_type_),			\
+	.length = (_len_) * sizeof(_type_),				\
 	.is_array = true,						\
 	.type = DEV_PROP_##_Type_,					\
 	{ .pointer = { ._type_##_data = _val_ } },			\
 }
 
-#define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)			\
-	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u8, U8, _val_)
-#define PROPERTY_ENTRY_U16_ARRAY(_name_, _val_)			\
-	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u16, U16, _val_)
-#define PROPERTY_ENTRY_U32_ARRAY(_name_, _val_)			\
-	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u32, U32, _val_)
-#define PROPERTY_ENTRY_U64_ARRAY(_name_, _val_)			\
-	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u64, U64, _val_)
+#define PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, _len_)		\
+	PROPERTY_ENTRY_ARRAY_LEN(_name_, u8, U8, _val_, _len_)
+#define PROPERTY_ENTRY_U16_ARRAY_LEN(_name_, _val_, _len_)		\
+	PROPERTY_ENTRY_ARRAY_LEN(_name_, u16, U16, _val_, _len_)
+#define PROPERTY_ENTRY_U32_ARRAY_LEN(_name_, _val_, _len_)		\
+	PROPERTY_ENTRY_ARRAY_LEN(_name_, u32, U32, _val_, _len_)
+#define PROPERTY_ENTRY_U64_ARRAY_LEN(_name_, _val_, _len_)		\
+	PROPERTY_ENTRY_ARRAY_LEN(_name_, u64, U64, _val_, _len_)
 
-#define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)		\
-(struct property_entry) {					\
-	.name = _name_,						\
-	.length = ARRAY_SIZE(_val_) * sizeof(const char *),	\
-	.is_array = true,					\
-	.type = DEV_PROP_STRING,				\
-	{ .pointer = { .str = _val_ } },			\
+#define PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, _len_)		\
+(struct property_entry) {						\
+	.name = _name_,							\
+	.length = (_len_) * sizeof(const char *),			\
+	.is_array = true,						\
+	.type = DEV_PROP_STRING,					\
+	{ .pointer = { .str = _val_ } },				\
 }
 
+#define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)				\
+	PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
+#define PROPERTY_ENTRY_U16_ARRAY(_name_, _val_)				\
+	PROPERTY_ENTRY_U16_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
+#define PROPERTY_ENTRY_U32_ARRAY(_name_, _val_)				\
+	PROPERTY_ENTRY_U32_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
+#define PROPERTY_ENTRY_U64_ARRAY(_name_, _val_)				\
+	PROPERTY_ENTRY_U64_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
+#define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)			\
+	PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
+
 #define PROPERTY_ENTRY_INTEGER(_name_, _type_, _Type_, _val_)	\
 (struct property_entry) {					\
 	.name = _name_,						\
-- 
2.23.0.700.g56cf767bdb-goog

