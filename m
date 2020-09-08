Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42205261FC7
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Sep 2020 22:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbgIHUGh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Sep 2020 16:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730348AbgIHPVk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Sep 2020 11:21:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDBFC0612F5
        for <linux-acpi@vger.kernel.org>; Tue,  8 Sep 2020 05:58:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e17so17212581wme.0
        for <linux-acpi@vger.kernel.org>; Tue, 08 Sep 2020 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nLn7MBojIPZBX1Cc0fte6bJy2zYPGF+0OvSOSKZTZQk=;
        b=yJoNljIa9qlqXWuxKL1etUoPBbX1rvf2LnGB7dKBJ9r9JaiDrabh6nGL1BJ3LsQvqH
         30ELXTFAi7IW9qjR3oYAyzwHxFMURLTJuY/bsyInF9Ja3sIV9hQ98k2ul+IyUVYV9AcB
         hriqDEUIZxfsCVQXzh8HYZENCU+u3nykO1L232HxS6MQVmeG4jnL6BsnJNuW95FEI9+W
         VnNzWEwTQSp82wWUt+DvVzP0H9mCix905ZS7D4JffHFa0McetsJrX2l4WnM5ty4GFFgR
         tzhL8qo+FMnFFqBOCK8nJieJK7CyM2FzaO96jnHFpKPdNS28pxgac4yq8+FlXv4mY9lG
         NvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nLn7MBojIPZBX1Cc0fte6bJy2zYPGF+0OvSOSKZTZQk=;
        b=sAW9/xGXGQMwwtpiew5cb8xuQkJGtbXhNYMUp407rh2TIDBHOLnKuFeClALgcJEfTY
         dR+5ExQgvPTTvRLHVwYLkDTfMCfPq7ZmXuR4PhT17wluIwpQ1am9Fx9D+CmFV5Ee396/
         rknnTDXsytUAhqCem9/U+K/mUeFo5NIS4O3upgV9fW+hQPT3hw3abN1fruWcQjIwbEgq
         Gm4n/clUN2+ZBi7g0gOYDOxinc5v5Gy9ethRWq2NDUdULJJ9H/6W8AXkzX+vfiGgrLex
         aksiV9OJiITqrA8jXU98NlkCdtHYAbVAYfxDVLJGgeZxYHFDsJgiudT+uVhPWxLvObnh
         V28w==
X-Gm-Message-State: AOAM531hGolWuJ9WbAO4iqCTwV7TFWE8dTPIlw9sRiqfMZJ/BCldggBm
        8WalYEvc1mLDcaV6lGt4DvdFRg==
X-Google-Smtp-Source: ABdhPJw2UX4DwJ8uomQdKlEKGp4dWXgNPdYavMGcv8xNO/e3jRahH6Mfzl+E80OqSzYNL6Ct55Zkqw==
X-Received: by 2002:a1c:7d0c:: with SMTP id y12mr4360474wmc.103.1599569906573;
        Tue, 08 Sep 2020 05:58:26 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id y207sm34817875wmc.17.2020.09.08.05.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 05:58:26 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/3] device: property: add helpers to count items in string arrays
Date:   Tue,  8 Sep 2020 14:58:11 +0200
Message-Id: <20200908125813.8809-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200908125813.8809-1-brgl@bgdev.pl>
References: <20200908125813.8809-1-brgl@bgdev.pl>
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
index 9f805c442819..1fa5e250a8ea 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -170,6 +170,12 @@ static inline int device_property_count_u64(struct device *dev, const char *prop
 	return device_property_read_u64_array(dev, propname, NULL, 0);
 }
 
+static inline int device_property_count_strings(struct device *dev,
+						const char *propname)
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
+fwnode_property_count_strings(const struct fwnode_handle *fwnode,
+			      const char *propname)
+{
+	return fwnode_property_read_string_array(fwnode, propname, NULL, 0);
+}
+
 struct software_node;
 
 /**
-- 
2.26.1

