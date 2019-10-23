Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24CF6E23C6
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 22:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405195AbfJWUCp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Oct 2019 16:02:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40666 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405185AbfJWUCp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2019 16:02:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id 15so7411414pgt.7;
        Wed, 23 Oct 2019 13:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qtC7CH3uCwc1qnA7SQUM9vPjiJGHmllhEByKdOb4NKs=;
        b=Bl1g34Mkp5wfx+KC9+klwhpKZk1kBhcM5NRp3FEFF07RQNZcVc4o24x1U11z10h6M6
         LCIeI2Dy1qVdyeYk7Ldx8r3o/qs/FDyIX3QfJUJZyD6lq6pPMhvkUrpaqPFqgaYiyrc3
         6AIibK6lfZYm/yIMhlv+VDOye62lgOM16ixQJY6NjpXW1cRbUnAW2sfmJmSkBRg0iuQU
         3TSJB9Avz/zvs2sutC7DOVkbaoMD3gD+J/KdR/CbqCL7putsPB1Epk4uelX31SWDQwYo
         5ackelqsjcnw8GQO5oqsP47ZlhuqjTzYI4ozItX8zAvf0I5EN94RSc+j0ee8WUme0gEd
         1FoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qtC7CH3uCwc1qnA7SQUM9vPjiJGHmllhEByKdOb4NKs=;
        b=F4DSrxN/ZVYhh0GomiSfJkljFcfjhyAd2MJ4VjdSz5wFsO+EPZk0MVLQoLGpz47yZu
         r716THGct8pGd2bG0O8jfxMENyOWArPyhyOSWNy8IcgvTs4hA3mCRkEhy5/88srm/70A
         YL53po063wjZKE2+y/MHH9OwrP3M2sh5YxkYAHTS+YFVbGdtsu49PR4edo6FjA9Fy8OB
         vBbCFUrfSNTK5i/vM/5d7WD4iS+23Vbuayy4CakiWxL51mBIUbdIzOtyP8X3tGN307q5
         aGxGFm9ZM9Un/y36WRTjORHbL+0tkMaNHpm9zLCa8BKfywdvmmGkQnu9CNd+cF8csQpL
         zwNw==
X-Gm-Message-State: APjAAAUaFh0LFXzXCGx7wMLD890FbHTYbJ45BLFRKJ5PCcAgK0LxbGQT
        BuiULh16sqMIwbHlK+t8lic=
X-Google-Smtp-Source: APXvYqxrtG+HMKhqIm6N7hCHG05q+xOQ8FHVy0CHWWfKPchAcaWeOKq4CAT1YBwjvkyfK5HeusGoGw==
X-Received: by 2002:a63:6949:: with SMTP id e70mr11937570pgc.226.1571860963943;
        Wed, 23 Oct 2019 13:02:43 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 6sm10593598pfy.43.2019.10.23.13.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 13:02:42 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 03/15] efi/apple-properties: use PROPERTY_ENTRY_U8_ARRAY_LEN
Date:   Wed, 23 Oct 2019 13:02:21 -0700
Message-Id: <20191023200233.86616-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Let's switch to using PROPERTY_ENTRY_U8_ARRAY_LEN() to initialize
property entries. Also, when dumping data, rely on local variables
instead of poking into the property entry structure directly.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/firmware/efi/apple-properties.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/efi/apple-properties.c b/drivers/firmware/efi/apple-properties.c
index 0e206c9e0d7a..5ccf39986a14 100644
--- a/drivers/firmware/efi/apple-properties.c
+++ b/drivers/firmware/efi/apple-properties.c
@@ -53,7 +53,8 @@ static void __init unmarshal_key_value_pairs(struct dev_header *dev_header,
 
 	for (i = 0; i < dev_header->prop_count; i++) {
 		int remaining = dev_header->len - (ptr - (void *)dev_header);
-		u32 key_len, val_len;
+		u32 key_len, val_len, entry_len;
+		const u8 *entry_data;
 		char *key;
 
 		if (sizeof(key_len) > remaining)
@@ -85,17 +86,14 @@ static void __init unmarshal_key_value_pairs(struct dev_header *dev_header,
 		ucs2_as_utf8(key, ptr + sizeof(key_len),
 			     key_len - sizeof(key_len));
 
-		entry[i].name = key;
-		entry[i].length = val_len - sizeof(val_len);
-		entry[i].is_array = !!entry[i].length;
-		entry[i].type = DEV_PROP_U8;
-		entry[i].pointer.u8_data = ptr + key_len + sizeof(val_len);
-
+		entry_data = ptr + key_len + sizeof(val_len);
+		entry_len = val_len - sizeof(val_len);
+		entry[i] = PROPERTY_ENTRY_U8_ARRAY_LEN(key, entry_data,
+						       entry_len);
 		if (dump_properties) {
-			dev_info(dev, "property: %s\n", entry[i].name);
+			dev_info(dev, "property: %s\n", key);
 			print_hex_dump(KERN_INFO, pr_fmt(), DUMP_PREFIX_OFFSET,
-				16, 1, entry[i].pointer.u8_data,
-				entry[i].length, true);
+				16, 1, entry_data, entry_len, true);
 		}
 
 		ptr += key_len + val_len;
-- 
2.23.0.866.gb869b98d4c-goog

