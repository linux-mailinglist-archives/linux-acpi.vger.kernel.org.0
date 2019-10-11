Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 320F0D4AAC
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Oct 2019 01:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfJKXHa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 19:07:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36712 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfJKXHa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 19:07:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id j11so5124475plk.3;
        Fri, 11 Oct 2019 16:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ZYLBJ+D5Yj2TyAfqtVnlRP+o58MbtxtSvNW0pAxio0=;
        b=hTrk6+YGPAqylfdKEerSa+ZRY2Ne82nAftfgJuTKOWk4GqVp2Liuc2dkH8aOxVFh0U
         RrZjQS7NGkyHIN5tcWkk6P3X8632ZKCveKPMYnCQZP0chhfoi/4wz3Q/uhkNeuujm8Ry
         ocg4aqwgAyGRnBuuvC3RVkJPKzWUT72F50fe1BaExwU0esuOHWovReSYGyHQ063Xgu0B
         8vZ5ANJn+fJhO9Rb1BjirE5kkJK7gT1AL91L2H1tvRdOIrzxpJrep69VuQYKEl+hbY4I
         ZzIHbvvZo+iSmdkNsXpBEkUVX+zV35fiuRQX7nMbNW3D4SJxrWsW+P55EPikqc/+kiEw
         EoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ZYLBJ+D5Yj2TyAfqtVnlRP+o58MbtxtSvNW0pAxio0=;
        b=BFWG1FaouTayV5xSImzrvJd0uRwnZz/nqIJnjDczmc2lDlYBOYYTkUSp1SfdbCHdXS
         FWWclACSbnLMGMghkSIwo5R1y9vwN3i2d6YelGB8frqtbb8QE81RAWj5WZftYWndBiIK
         8eEJRFcK+Opl6xE/osoKH5ZiMsOJS20SVEXk9i/diisgSfnwmYyo7cNG/qmXVuDPuP5+
         fOAcFyZo0jf46ZW3zTUjrxHf8SQ3Qpuw1WZlv0cWKDlUi288tLywwQEi6nfazAPWL43f
         Q2SFCkAgz47WsDwPZX22gr2MyyFGdlL7UFDoo6PBvaq++hLpRF4oKFTunNUA2VfzOM4v
         tbXw==
X-Gm-Message-State: APjAAAUMJ6iQs1y3FtpbUkPe9UP4+IzqZiaU1g6GU4mFD3bgFuwB8nyC
        95wK9q+ZDgOoKz0KMleVHRo=
X-Google-Smtp-Source: APXvYqz0sE40S0sxerzvSuQRl1sFjwso291GXoC7W9EDm1ObN7O14wMQ/eBUQ0R6R3REAPzD5qjVsg==
X-Received: by 2002:a17:902:76c4:: with SMTP id j4mr15570685plt.9.1570835249225;
        Fri, 11 Oct 2019 16:07:29 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w2sm11529251pfn.57.2019.10.11.16.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 16:07:27 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 03/14] efi/apple-properties: use PROPERTY_ENTRY_U8_ARRAY_LEN
Date:   Fri, 11 Oct 2019 16:07:10 -0700
Message-Id: <20191011230721.206646-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
In-Reply-To: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Let's switch to using PROPERTY_ENTRY_U8_ARRAY_LEN() to initialize
property entries. Also, when dumping data, rely on local variables
instead of poking into the property entry structure directly.

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
2.23.0.700.g56cf767bdb-goog

