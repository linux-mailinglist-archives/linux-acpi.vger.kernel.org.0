Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22E62E23BC
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 22:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406276AbfJWUDb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Oct 2019 16:03:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40107 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405556AbfJWUCy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2019 16:02:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so13590165pfb.7;
        Wed, 23 Oct 2019 13:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U7yrLgCm1sWsKsLg4PFcTaFGPRuqfSdp4yJRNe14wag=;
        b=HWZAI6oUd4zj5C+itjIgtiekMAiuAHD1aH14ZRblUi0kgK8bfcauhA0kZFvigeINED
         o+DET2XYKe39buC3Cm8XwojwxPZUtrWMJlnoiutYxE1FHFfGcgJrw73fLW3iCpf1KHnc
         Kk5Vpkp5NSowVcuJ+wKorVBX7tSU3vf0UgnbVgX0Blc5wlmprlBEhmgVU8dbuIVhB/bN
         oXel/TsuRPrnjrHOeQblhSvrGqELeZ9IqsKSjCWLbScuAGJs1KKu67/LgKQRAqDGYyJF
         yrxafOTOPvCiylFwBfgRibm6ylv7qCOCSnEDlPjcAt4xEREPDCC6xW790hFn/bshZ8Il
         WSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U7yrLgCm1sWsKsLg4PFcTaFGPRuqfSdp4yJRNe14wag=;
        b=TKoyidKF/bCwwZGsd2cCTSIyFY0vNBR2nurea9qZ6n7HavUBheMNs5GdRlsez2l0VX
         sA3okagmEHxKJWK2SXSp7gSIF4vZBv59xrP5p6Gnfuo8b7sZBJUM/n+PIS1Vq0IoMFvz
         k1E44dtZH5xQW+7CmeMmgmFkiaRCctg1zuM2UppMVxvAuQ4uleaAJgIk7qTRYGee8agB
         Fn62NgEcnFRnARmWF0fv6S8RHUNhB3ysGO6UWri3Mg0mi/DvzCxZRkOOw7RaySY6CaFL
         mf2z/yF/u737YbHA+nOs4ThpNzrjuweeCR/l4Co+jRHjdFxdrMG6cd7DXW7KXQtc94+J
         yKkA==
X-Gm-Message-State: APjAAAVmsOc9K1iBYaKzBdjT0jOAhd3yzxfuLBKchjs8L7oXLxyfnQ28
        CpfcTqaG+M2xm1TbjJXjKtM=
X-Google-Smtp-Source: APXvYqxl0S3jmfDiv5LaLLsAIuswlGWVayQhvZbkI3bhz/FCaod8i35vRC9p0hMMKqFMk2b91qtXyg==
X-Received: by 2002:aa7:87ce:: with SMTP id i14mr12485376pfo.78.1571860973889;
        Wed, 23 Oct 2019 13:02:53 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 6sm10593598pfy.43.2019.10.23.13.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 13:02:53 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 09/15] software node: simplify property_entry_read_string_array()
Date:   Wed, 23 Oct 2019 13:02:27 -0700
Message-Id: <20191023200233.86616-10-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is no need to treat string arrays and single strings separately, we can go
exclusively by the element length in relation to data type size.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index f59dfd01725f..d8d0dc0ca5ac 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -173,28 +173,21 @@ static int property_entry_read_string_array(const struct property_entry *props,
 					    const char *propname,
 					    const char **strings, size_t nval)
 {
-	const struct property_entry *prop;
 	const void *pointer;
-	size_t array_len, length;
+	size_t length;
+	int array_len;
 
 	/* Find out the array length. */
-	prop = property_entry_get(props, propname);
-	if (!prop)
-		return -EINVAL;
-
-	if (prop->is_array)
-		/* Find the length of an array. */
-		array_len = property_entry_count_elems_of_size(props, propname,
-							  sizeof(const char *));
-	else
-		/* The array length for a non-array string property is 1. */
-		array_len = 1;
+	array_len = property_entry_count_elems_of_size(props, propname,
+						       sizeof(const char *));
+	if (array_len < 0)
+		return array_len;
 
 	/* Return how many there are if strings is NULL. */
 	if (!strings)
 		return array_len;
 
-	array_len = min(nval, array_len);
+	array_len = min_t(size_t, nval, array_len);
 	length = array_len * sizeof(*strings);
 
 	pointer = property_entry_find(props, propname, length);
-- 
2.23.0.866.gb869b98d4c-goog

