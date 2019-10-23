Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45424E23C5
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 22:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405235AbfJWUCp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Oct 2019 16:02:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38351 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733176AbfJWUCp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2019 16:02:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id w8so10618430plq.5;
        Wed, 23 Oct 2019 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gvRK+5ta158WSRKlg8UZ8EljQRMjRoa7C71YFmxtYTY=;
        b=GqnXmdlc839iWseVEk6Cne9M0s+dbcz+nMRzgB7ruYIhC8mjYNbk12mnznyGhO3B3j
         xUszYpy51kKteiKBIVUfnPNIa32ZTgwZvP07OhMulm9CPMLECyu7TgpTrxqAcmGeIorn
         kOLSsTOdZZiCspxvJUXTCgqBYAW77aBpAYLSqWfrlJGJHhbrJRj+0z1euShiSbFGT0CF
         nenR/qVX48TGmrd8O4bAOLsfhhja+kj2VvmlhnnVTr5ObVYsLOksQDUEOcRg91IDspdP
         +/h6HlkmJB6ulsWHUexjG6HBaQsKaoyJy7OvdZ1VR/AMah/hSwsvH0ALRD8m/opgSsO7
         uCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gvRK+5ta158WSRKlg8UZ8EljQRMjRoa7C71YFmxtYTY=;
        b=NxFl9QGqs11vEW5Kb+KLoXmpSWrDrhqlvCvfOtY+uhUjCkuJJknw1kgTMtVfaOBykL
         tWFSloflCxdq8IgaphbSW02arEoMWymzuX65fPv+EWfAAm4Ajvq2qKZ08QNEKidVcIKv
         +fwRdBQj/D+10+pJ4xQ03Xd7gbXpgORKHYM7ztd7eCPed1uyuAu+NLVN2icV2rK1Xx84
         K28m6n4A1SPKVQccHuPx60nmXJW86ZJ7g1NCxpZXZuWJIZDDKLsOBM9ij9ozqhHNp8pT
         vXp9AS6xKaS2RFmMe4KMg617160YgfQk/9VNSnzPX1uYDLsDuV7IcV2oB29c8U52OozT
         36hQ==
X-Gm-Message-State: APjAAAWg6ReRk9sim5FDD1W++PGhxGUMgCSi8070z0p3FtydR91pIciu
        z0tKJG6Hqn2i9V+KbLtc66OtiELd
X-Google-Smtp-Source: APXvYqyPR4okpEq8LkKZ051NG5ryaeethDnwUSSdGo1XCoLCVznCHtK+1/+evkQ4gyVgW/RWE3lZzQ==
X-Received: by 2002:a17:902:8d89:: with SMTP id v9mr284051plo.247.1571860962401;
        Wed, 23 Oct 2019 13:02:42 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 6sm10593598pfy.43.2019.10.23.13.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 13:02:41 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 02/15] software node: introduce PROPERTY_ENTRY_ARRAY_XXX_LEN()
Date:   Wed, 23 Oct 2019 13:02:20 -0700
Message-Id: <20191023200233.86616-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/property.h | 45 +++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 0a075fbde57e..fad2e83a207c 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -261,33 +261,44 @@ struct property_entry {
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
2.23.0.866.gb869b98d4c-goog

