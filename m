Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C503825DE85
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 17:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgIDPu4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 11:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgIDPqe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2020 11:46:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FDDC061246
        for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2020 08:46:32 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so6472590wmh.4
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2020 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wTtZyQw48avsFdpHOI98/RhzmvMtVCVcNE1bMjyUXUY=;
        b=ZLU7hI+Wc7S/0ExzQYekPR5nYEvn3dMLSQ8I8NS3mnZfZUiBd2hetNf19N4pAZv1rI
         DeIhjhpv+zGnVF6vXYiT19iDuA70MNhfyPFxDNolyuYpQ+WQPep3iMglPTEWxBqZ8+oT
         vn7MeRdaCfJsMgVjjhpN3lDMPfwPzYCL0KCjFoh5eY59T/BCH1Bxn2ZR0G+C07XuE7fp
         PRgjTuH/qNg773hmdRgtGTinUP9YvmZ93r3YGgQuXB0ok8/p1MuKgYPGwYMySRAwo/Gc
         bEsLyowk16QRwX7LiDALkhMvoMzY75po+CjvBg0ASsdV5yorNWtDBjqCllhBUMyDBWxM
         XjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wTtZyQw48avsFdpHOI98/RhzmvMtVCVcNE1bMjyUXUY=;
        b=uJU9PlFS+RqGkREIYGejAS03DXk4c1bZ7uQKtvb+QyQSNs6RF/5NH1UaMACCHFSg71
         1ij2XUArAOTngVXgPHawctBxu3ms8ORshW9GeTx3zFIoQO5X7oWnRaqHLtgrMK6ztrBk
         OHgmOPAjWdR0SkgImSFO3oOAj0mmUeIj8+VZ0B9gIV9xad+dppEFZjT4hQDxvHEjekbg
         K1zovH++SAzSp/gkcT+4L/qkO511GXN7a36HNxRU/Up5AQSQCZYEu+Oh64pXqBVh22cI
         M/uK0tRacq5IoNbSX068fzGCr1yqCpvgSMCwCDJ0iQvbslchV5AmeerEr8t5RrE9xkht
         9xAA==
X-Gm-Message-State: AOAM530YNy9XEcYykDDBR775W648k9XFW3Ni+gnmomrCFaowQwY6R5/U
        cI0/hEJF4+JyLWnm6RlOnfVyGg==
X-Google-Smtp-Source: ABdhPJzK1kWNGIgBMdYGgwQSUscLv8S6S2shXWsDOTyjh9QvJLrxo7r/bW7tLuw/15SUb2KbDSDOUQ==
X-Received: by 2002:a05:600c:258:: with SMTP id 24mr8513082wmj.66.1599234391665;
        Fri, 04 Sep 2020 08:46:31 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:31 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 01/23] lib: cmdline: export next_arg()
Date:   Fri,  4 Sep 2020 17:45:25 +0200
Message-Id: <20200904154547.3836-2-brgl@bgdev.pl>
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

We want to use this helper in a module (gpio-mockup) for parsing user
input when creating dummy devices. Let's export it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 lib/cmdline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index fbb9981a04a4..e194f76d546e 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -247,3 +247,4 @@ char *next_arg(char *args, char **param, char **val)
 	/* Chew up trailing spaces. */
 	return skip_spaces(next);
 }
+EXPORT_SYMBOL(next_arg);
-- 
2.26.1

