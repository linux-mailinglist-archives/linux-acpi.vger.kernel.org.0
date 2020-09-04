Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C0C25DE55
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 17:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgIDPtR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 11:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgIDPq7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2020 11:46:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F7EC0619C4
        for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2020 08:46:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so7155363wrn.13
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2020 08:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/FOPTskD02+rqmTy1Q+lvepWRalQafDGjAwi3K9HfYU=;
        b=DWSFeeLRu39HrwTsgIJnFObS4Eo0vIUxkcPBLAQ8iMkew4JxxJi2HeGJEwHFlAzsSC
         V4nymy+PcpCDVaRs1xvaygnoO+ldD8YU2XK9eLt5FRlZOI3wYRcprZQ7u0nHSojZmi94
         J6tKrqYyKczLhXpI/uxNrYUoFv129bNqR7YAXvmIq+RP/NU7cK0nUX6Fgw98DTzmsGkN
         OUBuerym7ms3eO6VilqR+cBH+FVtnJZ3cGCpmkzMc3e+F/SDdlMcOPxZi7D0wzC1gYPs
         CrL5Mb1Bqwd4ozdqBulR2kAIQQ2V2cv5mN44+Kac1+HItigj9IaT5KWXHVJcsq/QfAOI
         pTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/FOPTskD02+rqmTy1Q+lvepWRalQafDGjAwi3K9HfYU=;
        b=XWKEsR1EwwvWL9h7i2/6iSvU0o43xS3VRMBsEdZD367Df3Qrbg7KtPayd/GEuvxSGv
         3cof+fEDKPiOe1R4Lo8RCXAlsgEeA7nklLf3If6dDE/jFJGdIERCgRzYOxfZtqpmmd4b
         CQbXAOiRmg2NXV6vQBfL3fT7LmjSNH4SQIca29XcMVOtm22TdaxdolEP+1ZRSe5QLHLJ
         FT0KF8vFa6Ofx3zftt/b5iPdobldVA1cZDCPcaDRX+xIW0pBjsjz/D7KOZx9pDT5dSJg
         5rIqwzL/qnu2lz+XuFJb7XOOf/vNfgqOLkhxCdeNcoqLt4cwsMx2BlcmY/slvBKDMJuS
         8kfw==
X-Gm-Message-State: AOAM533ocsCfb2VjhV8/pK76EDo/A+0zy0m1XpwCQXE7gg4KVEEuSbvB
        0z8hctBT6oDT/rWlZS/EuFCPmg==
X-Google-Smtp-Source: ABdhPJw/DYVsfbaGxg5IdpYA3yk8QnzF9jmg3mpJzGx7H7H6XBFu4ZqlmzQ4gBrGlTt8uzkbc4SHKQ==
X-Received: by 2002:a5d:61c2:: with SMTP id q2mr8972511wrv.25.1599234405459;
        Fri, 04 Sep 2020 08:46:45 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:45 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 12/23] gpio: mockup: define a constant for chip label size
Date:   Fri,  4 Sep 2020 17:45:36 +0200
Message-Id: <20200904154547.3836-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904154547.3836-1-brgl@bgdev.pl>
References: <20200904154547.3836-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We'll be using this value in many places in this driver soon so define
a constant to avoid using magic values.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 801fba6496a4..e8a19a28ed13 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -32,6 +32,7 @@
 #define GPIO_MOCKUP_MAX_RANGES	(10 * 2)
 /* Maximum of three properties + the sentinel. */
 #define GPIO_MOCKUP_MAX_PROP	4
+#define GPIO_MOCKUP_LABEL_SIZE	32
 
 /*
  * struct gpio_pin_status - structure describing a GPIO status
-- 
2.26.1

