Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5CEDD4AA8
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2019 01:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfJKXHh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 19:07:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35294 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfJKXHg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 19:07:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id p30so6616394pgl.2;
        Fri, 11 Oct 2019 16:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oWfZp87EtAgwEM99H5cVmirzQT+GLNapRRUGkPZCCcQ=;
        b=maj1rsW1SHL/7fpICwUugPUkcrd25Ok67/NPn1kiG54zeH1pT3janfocb+bVme1dZ3
         1vM6Q7d9jS9abmDwG//vQeH2J97IHa10GK6Pk9k2u1fo0M068+fog5OoxcTpGrO7ZnpB
         nzev+K2NqRbTwNIb4cXZ2tZdQNY7JvVF/qrP5yypcAvR6iUJUy/8mm0/tH0OWKt9ttAP
         5r4AoDrNLBKhCYPMLhI0RiJVaRrV9UzY9M8XYzpAlQdTfOi0TgW3H9mXJkWgbj80V8eD
         NaE3nB+wBiZg1l/WHFZ2qSKYvsznVdoVLHWWFXZ+q1+AoxqKzElVm158ez2r4/WIcEAc
         xcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oWfZp87EtAgwEM99H5cVmirzQT+GLNapRRUGkPZCCcQ=;
        b=O3k8pcMR9VLMOJePohoT4jlrjiNj1jQ8So0cXJT2uNVhFeAM48ZfJBipAPiruuGdZA
         90U5wN4qAy2vAmAYhTC8nvKzxev84zE4BE8tiw7jxFI9yP8mbIXosZ3KaxXu3DFa+Be3
         Zd0+AyMMlnx+tdYyHEaRKr70s229x69c4vwET4MW04oAHFFKuPEMwogWDSVvgIy1NBam
         kg6HzY0uwEpuelYCQVJ4PQ24mlNebYnc2WNeaHt4qNhaEqkAJrYZc5+6bfkVACtlUlmp
         IpQaEiD4mWGao+8Q1hWDrflGakTjT5O8Cf/tXp1LtKsbUHFaNdVGhFIv5EEa1GKgBwmh
         br/Q==
X-Gm-Message-State: APjAAAV/ZtQjh6805CH3Tl+20xUzHP+/9BTmcWWI34vh96Dmyk18M386
        91+QV6INI/7mRBLrbMQ9sW0=
X-Google-Smtp-Source: APXvYqxGfnL+uQASCHlvc4dCdVgFvfqkoA2EKj5FnIYzlhIdRhmjWbbQ1tMJQhHm792CXqcQNmjZeg==
X-Received: by 2002:a63:4525:: with SMTP id s37mr17014276pga.148.1570835255009;
        Fri, 11 Oct 2019 16:07:35 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w2sm11529251pfn.57.2019.10.11.16.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 16:07:34 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 07/14] software node: remove property_entry_read_uNN_array functions
Date:   Fri, 11 Oct 2019 16:07:14 -0700
Message-Id: <20191011230721.206646-8-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
In-Reply-To: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is absolutely no reason to have them as we can handle it all nicely in
property_entry_read_int_array().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c | 85 +++++++------------------------------------
 1 file changed, 14 insertions(+), 71 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 26e56dd66436..b11cc4dbff08 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -131,66 +131,6 @@ static const void *property_entry_find(const struct property_entry *props,
 	return pointer;
 }
 
-static int property_entry_read_u8_array(const struct property_entry *props,
-					const char *propname,
-					u8 *values, size_t nval)
-{
-	const void *pointer;
-	size_t length = nval * sizeof(*values);
-
-	pointer = property_entry_find(props, propname, length);
-	if (IS_ERR(pointer))
-		return PTR_ERR(pointer);
-
-	memcpy(values, pointer, length);
-	return 0;
-}
-
-static int property_entry_read_u16_array(const struct property_entry *props,
-					 const char *propname,
-					 u16 *values, size_t nval)
-{
-	const void *pointer;
-	size_t length = nval * sizeof(*values);
-
-	pointer = property_entry_find(props, propname, length);
-	if (IS_ERR(pointer))
-		return PTR_ERR(pointer);
-
-	memcpy(values, pointer, length);
-	return 0;
-}
-
-static int property_entry_read_u32_array(const struct property_entry *props,
-					 const char *propname,
-					 u32 *values, size_t nval)
-{
-	const void *pointer;
-	size_t length = nval * sizeof(*values);
-
-	pointer = property_entry_find(props, propname, length);
-	if (IS_ERR(pointer))
-		return PTR_ERR(pointer);
-
-	memcpy(values, pointer, length);
-	return 0;
-}
-
-static int property_entry_read_u64_array(const struct property_entry *props,
-					 const char *propname,
-					 u64 *values, size_t nval)
-{
-	const void *pointer;
-	size_t length = nval * sizeof(*values);
-
-	pointer = property_entry_find(props, propname, length);
-	if (IS_ERR(pointer))
-		return PTR_ERR(pointer);
-
-	memcpy(values, pointer, length);
-	return 0;
-}
-
 static int
 property_entry_count_elems_of_size(const struct property_entry *props,
 				   const char *propname, size_t length)
@@ -209,21 +149,24 @@ static int property_entry_read_int_array(const struct property_entry *props,
 					 unsigned int elem_size, void *val,
 					 size_t nval)
 {
+	const void *pointer;
+	size_t length;
+
 	if (!val)
 		return property_entry_count_elems_of_size(props, name,
 							  elem_size);
-	switch (elem_size) {
-	case sizeof(u8):
-		return property_entry_read_u8_array(props, name, val, nval);
-	case sizeof(u16):
-		return property_entry_read_u16_array(props, name, val, nval);
-	case sizeof(u32):
-		return property_entry_read_u32_array(props, name, val, nval);
-	case sizeof(u64):
-		return property_entry_read_u64_array(props, name, val, nval);
-	}
 
-	return -ENXIO;
+	if (!is_power_of_2(elem_size) || elem_size > sizeof(u64))
+		return -ENXIO;
+
+	length = nval * elem_size;
+
+	pointer = property_entry_find(props, name, length);
+	if (IS_ERR(pointer))
+		return PTR_ERR(pointer);
+
+	memcpy(val, pointer, length);
+	return 0;
 }
 
 static int property_entry_read_string_array(const struct property_entry *props,
-- 
2.23.0.700.g56cf767bdb-goog

