Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8879E2DDC19
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 00:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbgLQXp2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 18:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732426AbgLQXpS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 18:45:18 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5101DC0611CA;
        Thu, 17 Dec 2020 15:44:05 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m5so218712wrx.9;
        Thu, 17 Dec 2020 15:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HAUVeFRGMPGgWvoUIsXf/Ln2ZywCD/ZCvvMD4gyiyPw=;
        b=iRdYYEJbUgqpwQ6789Qs5EnCQIgdSi6OxHIEn98Yw7+TRgBCFPq348rXB7361XD28I
         Vj6kjUp20tygynb2BSeBF3o32AbR/PkJ3kxr3ImO1BhrEMoE0VPZLYTX8iuSz2pgLrZt
         SnZYXF5NEdfPilw2VkIhULR70yzsLxkzaJGMb9om6wO8DHClc22WLUO9cOP71PPr8mTg
         23RkwWFyA/Zp5akQRkl074H9cm2h8cCinFTDn+VUnQ6xNsVT1K6JZzL8EZk03HpnksPl
         EujHkBWeSz92RmKFgw3+hRCYUhrIGyBksue0EyveIEsUslxrSZLSryDR8+ZAwTHAhwgI
         +ZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HAUVeFRGMPGgWvoUIsXf/Ln2ZywCD/ZCvvMD4gyiyPw=;
        b=Ar99MfJP5Cu6CNgJgzsLdLCDySgcF073TBm+yWwLUlJe6beJcWP9V5MsqFK0bDUZH0
         n1E2s1Vp6/K6GszaO+BaealqFqVvBCn2/YNBetYriCin7ud4gsUUJGTDwBTApgr6nMId
         caZf2eBWMqHgKEQJsE4lIAu20Wx+ojcfiYrz+F+wbUlpsgVH7rJyqlyreJDfvkcOBO90
         kInW2fWLHAQdwLJzxgtt6t37cGXJbqS9XPmDTWACzmkeSCxPOQQHT8MWK8Sa/MqnYaEL
         xeANKjYlWNU7/mHlrTd/9+P74FbP++cg5sOILAu3eIEaN7UoBXipSm7OOHg34oKJsKAC
         mYGQ==
X-Gm-Message-State: AOAM531HFmT9kk3vZv9QZuW3kqJkA6jl6AYJ4gF4ga0BjnGsJjQTmJW0
        68WR9TlgpBYXwvKAq7M/ochyCjQLR2yrTtYq
X-Google-Smtp-Source: ABdhPJzbp7Bd6bq61B3TPkoEHQkDOgyhtHhMLCgAUVlPnnabYOsofHDRP4oCXOI8EZxmggJ5uH2TUw==
X-Received: by 2002:a05:6000:101:: with SMTP id o1mr1206735wrx.211.1608248644128;
        Thu, 17 Dec 2020 15:44:04 -0800 (PST)
Received: from valhalla.home ([2.29.208.56])
        by smtp.gmail.com with ESMTPSA id o3sm1873575wrc.93.2020.12.17.15.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 15:44:03 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org,
        yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 09/12] ipu3-cio2: Rename ipu3-cio2.c
Date:   Thu, 17 Dec 2020 23:43:34 +0000
Message-Id: <20201217234337.1983732-10-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217234337.1983732-1-djrscally@gmail.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ipu3-cio2 driver needs extending with multiple files; rename the main
source file and specify the renamed file in Makefile to accommodate that.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v2:

	- None

 drivers/media/pci/intel/ipu3/Makefile                          | 2 ++
 drivers/media/pci/intel/ipu3/{ipu3-cio2.c => ipu3-cio2-main.c} | 0
 2 files changed, 2 insertions(+)
 rename drivers/media/pci/intel/ipu3/{ipu3-cio2.c => ipu3-cio2-main.c} (100%)

diff --git a/drivers/media/pci/intel/ipu3/Makefile b/drivers/media/pci/intel/ipu3/Makefile
index 98ddd5beafe0..429d516452e4 100644
--- a/drivers/media/pci/intel/ipu3/Makefile
+++ b/drivers/media/pci/intel/ipu3/Makefile
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_VIDEO_IPU3_CIO2) += ipu3-cio2.o
+
+ipu3-cio2-y += ipu3-cio2-main.o
diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
similarity index 100%
rename from drivers/media/pci/intel/ipu3/ipu3-cio2.c
rename to drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
-- 
2.25.1

