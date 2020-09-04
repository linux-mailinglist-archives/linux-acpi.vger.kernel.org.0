Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD7525DE60
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 17:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgIDPtg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 11:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgIDPqz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2020 11:46:55 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95295C0619C0
        for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2020 08:46:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id s13so6473072wmh.4
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2020 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+YZpX0q+mO37+kQBR4DVC/6zJd6Q2vMMFs8yeO9lM6k=;
        b=DHwiLfdYkiuvwGGyuQJVAWH5TI6urmfg9xYzHsNJZRaq+W2VOEzGuDZHADH8b43f72
         IdWm7NgZqeHyUMOex7xd1L+sKPbyTQU6bkDGKC+laJrmoA7AkcOWL7irwhKLtGgT8Sqf
         F8QMnwZ2j3f3Ev1NBQFKglsSE0ukhsx0DeGQmvPfA7s4XdmrdEBZCJLsDuZdy2py60av
         7ddrLxRGhrc5nQk/J7X0Rd3701tAIqugtMXJWgIrCfExr2MwqBB6KT7fKNh50zVYZgFr
         KhutLsEsf7K3xZSOrPpo6OUVFbEEAZGhgmuf6GDrIPY3Qah5PrJ+GtBed+JpjV2iCFmm
         akIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+YZpX0q+mO37+kQBR4DVC/6zJd6Q2vMMFs8yeO9lM6k=;
        b=T8id/yvYT6A5HDyKi+TS6aC4V7WfApnGYUh7aDdOZCoOnHy5hBh3QAVVAap6IK8Qxu
         xhE4lUlynxLuxz/IMMgyWk+M1rtCy9MTn6EJcCl8GBr9CB+brN4OOLcido/39vMzE/A7
         sMB7wjpPo/pf+AYbS/0O1TjAQw+FQHlCyPFc0reiO6iIdgsVJhSHsn/k62LcaP+VqJ1G
         q9W20pl1vhVoBrVqepVSugL5V7ZYxHWLURJa/70kWQBA/DybX56RVrm+JQNwXeMMZXz8
         bwFU2HdTXPpK8lpF32M14QQLv506w0b6i2Jyhahl3bxobrbh44ga7xWIrdkB/gfc9aGH
         j9mw==
X-Gm-Message-State: AOAM533XlH421ena65YTY4AEYOam8PLvvqf24HEg7hLYrUtGYzo5cikZ
        QWDofWJmG6iDZMO21f659vwDfw==
X-Google-Smtp-Source: ABdhPJxcZNGnXPvX9i5H6bEC8G5YKnDdSyG1Hc0LLO25M6dxNysSMjIVg6JhStAhJl/uVlArUPCUtg==
X-Received: by 2002:a1c:f018:: with SMTP id a24mr7818256wmb.7.1599234403325;
        Fri, 04 Sep 2020 08:46:43 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:42 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 10/23] gpio: mockup: fix resource leak in error path
Date:   Fri,  4 Sep 2020 17:45:34 +0200
Message-Id: <20200904154547.3836-11-brgl@bgdev.pl>
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

If the module init function fails after creating the debugs directory,
it's never removed. Add proper cleanup calls to avoid this resource
leak.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 78c97f7b6893..19c092f814fd 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -550,6 +550,7 @@ static int __init gpio_mockup_init(void)
 	err = platform_driver_register(&gpio_mockup_driver);
 	if (err) {
 		pr_err("error registering platform driver\n");
+		debugfs_remove_recursive(gpio_mockup_dbg_dir);
 		return err;
 	}
 
@@ -580,6 +581,7 @@ static int __init gpio_mockup_init(void)
 			pr_err("error registering device");
 			platform_driver_unregister(&gpio_mockup_driver);
 			gpio_mockup_unregister_pdevs();
+			debugfs_remove_recursive(gpio_mockup_dbg_dir);
 			return PTR_ERR(pdev);
 		}
 
-- 
2.26.1

