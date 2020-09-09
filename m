Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA79262B08
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Sep 2020 10:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgIIIzW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Sep 2020 04:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIIIyf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Sep 2020 04:54:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A35C061757
        for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2020 01:54:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k15so2007150wrn.10
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2020 01:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yjs3H1T57/OsvxujNGQGLBWexjTmuttV9nlq5vhVwiw=;
        b=1hogus410UbSTewZULq8XN8hOyyBaL3K5B6EOLPEBYnY2sGYGPLbPW3ExsJq4pq4+H
         GICD3jVw0enYx6Gprar6A5TRJmmt56br+sRooWOV1CwuhcTx+bsn//Px3L+pkoJCOh+m
         fYwbhRd6W8qaWAXI2rTd6jScVykNjvgR7bNmSjXEZ7TDiBxHT09dlxpG5Ezja1cg/s8A
         FOAyOQuANxMt5ChTXpvKigtNMY0VAmWUmnKt7iiXAycAGWMUovJrodozixh0MtVmJxen
         gXRZ4DATBIzKNBdBoi/e96MQ3hAxtrVB9feV6GsGHB4jQ8BKl5oVyhuQNjPFJ0zTIu28
         J8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yjs3H1T57/OsvxujNGQGLBWexjTmuttV9nlq5vhVwiw=;
        b=uWf9Pv9Y9mi1lI1uXl1yVFFmQC/bibtAZGI37S0nVNJjdV7ghG9cNNwhSk8pig2bGY
         bDYSQPVjba7MYPc7nuJ7w7dgGHweReEM4nD08TTIPcABX0jvnDwKBDbLND8Ia+9mYLmI
         QZgvsW7c8Fi6ws4mVRHoeyecHkNalDa2F8/It3qmR4NRQBGdaujy40nNFQ5nPwSZshH8
         RXUwS08b1KTzptiBaVyiNZ7sBOOogpMHlmiPzoySyURqjs3HeAYrM8ZrwLKA/7THdS4U
         rnz3/M5PGleq0JLWpmVB0iT4CrlQjxWgYST+FZWcNqhKSFSkZgawr7BChBuKLVvWZ8MB
         fyxw==
X-Gm-Message-State: AOAM533s8hrM7GAHXmGhyNhwMaCWOZfAwz8iNAvoVFdfkFg8QztZvqDZ
        5CE2y96BH0DiqOcuD1dUEXylfQ==
X-Google-Smtp-Source: ABdhPJyfX1lAkYRdf3f086UINT2xngPSrOgIgkfFzYyUgZA0LaGJG7CLOAi3E9XKsLi6Ob8wB4E1zg==
X-Received: by 2002:a5d:46cd:: with SMTP id g13mr2988799wrs.153.1599641673479;
        Wed, 09 Sep 2020 01:54:33 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-657-1-17-60.w109-210.abo.wanadoo.fr. [109.210.64.60])
        by smtp.gmail.com with ESMTPSA id n17sm3418812wrw.0.2020.09.09.01.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 01:54:32 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/3] device: property: add helpers to count items in string arrays
Date:   Wed,  9 Sep 2020 10:54:24 +0200
Message-Id: <20200909085426.19862-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200909085426.19862-1-brgl@bgdev.pl>
References: <20200909085426.19862-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Instead of doing the following:

    count = device_property_read_string_array(dev, propname, NULL, 0);

Let's provide inline helpers with hardcoded arguments for counting
strings in property arrays.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/property.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 9f805c442819..75c178055bc9 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -170,6 +170,12 @@ static inline int device_property_count_u64(struct device *dev, const char *prop
 	return device_property_read_u64_array(dev, propname, NULL, 0);
 }
 
+static inline int device_property_string_array_count(struct device *dev,
+						     const char *propname)
+{
+	return device_property_read_string_array(dev, propname, NULL, 0);
+}
+
 static inline bool fwnode_property_read_bool(const struct fwnode_handle *fwnode,
 					     const char *propname)
 {
@@ -224,6 +230,13 @@ static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
 	return fwnode_property_read_u64_array(fwnode, propname, NULL, 0);
 }
 
+static inline int
+fwnode_property_string_array_count(const struct fwnode_handle *fwnode,
+				   const char *propname)
+{
+	return fwnode_property_read_string_array(fwnode, propname, NULL, 0);
+}
+
 struct software_node;
 
 /**
-- 
2.26.1

