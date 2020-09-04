Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9697925DE6E
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 17:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgIDPuB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 11:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgIDPqr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2020 11:46:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1670C06123D
        for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2020 08:46:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c15so7166770wrs.11
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2020 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=21luy6X7MDo33702JiSjX8+ptN78cMUdDvCAknmXlNw=;
        b=ZEDEcIxOclm9rkbYpejxrNIf2E5BaNtltbEx7kL2MmvTjXkaO6NcxogFQaPWUTVU90
         RQCLCwd/0LeBvBHib8CSLZ6t0N3QMb9pIjEGew+/3FUx7nmAv9U1jw1QGsifrgj7RZz/
         BvxCb7fT6vR8yVfjeZ1cK4bgxVds+FqqAq0SqwC1YeYbevfwSlBCI23wJCoMB61VVWI+
         OMMY4pKIa6QlNrAheHEoiU+ozpVA1RJj07hzk4oeA+31wZzEmN0aoQgAip9RFc0XjC7l
         wZbRPvzHN5/YFjUV8Y9Q9UX0mrRaDx5MfQwrYwVOKbAIytZjQyAsHR3o/g0JEjUNHJNG
         x79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21luy6X7MDo33702JiSjX8+ptN78cMUdDvCAknmXlNw=;
        b=mmULIyyugcIWqprFVqyzKCwZEiaPLpLb+JTENA3johrIAvxnieeOPYzVSLDwygAr1b
         Idp46g294pCj3N4gvFkk9QIp8bp3FM3YQ/fvCAtUG2aVB33OJP8j+59DkynfDuSN8017
         05az0uotEAVMa2SQqfFsnBY1dTv22txr4Lg97tS3bdQmt46EPOwNTO79dusdlPEJRpTs
         SnrjWcYzG1NljnEbTuJ09Xq5OIzLsTwMfQc8uau9LvvA1pt7rFgB4DelkvtXlkqG2+rx
         IV7zlz+vexlaKjf0YNbrix4lYl5baSYI8K3YcjsS6X04l4iS/3FuZeKohJIvoD3/DjTn
         7/lQ==
X-Gm-Message-State: AOAM530umksko2v1chTUc37zHDd+lc2Ol2G3spCxScl6RwMqEOIZs+2h
        diQkhs75nM74VKy4EOIKQtPoKg==
X-Google-Smtp-Source: ABdhPJwCyK6EASQNgZuAXwqjHkJs+DAdmBTT0auSRhh6ETOzmG9L8g4BM5hkjVixy9irlGFHNaRE7A==
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr8773344wrn.394.1599234399347;
        Fri, 04 Sep 2020 08:46:39 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:38 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 07/23] gpio: mockup: drop unneeded includes
Date:   Fri,  4 Sep 2020 17:45:31 +0200
Message-Id: <20200904154547.3836-8-brgl@bgdev.pl>
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

This module doesn't need gpio/consumer.h - it's a provider. It also
doesn't use any symbols from init.h so let's remove both includes.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index bc345185db26..349782cdb4d7 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -8,9 +8,7 @@
  */
 
 #include <linux/debugfs.h>
-#include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
-- 
2.26.1

