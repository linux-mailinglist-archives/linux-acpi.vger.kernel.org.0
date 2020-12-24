Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542092E234F
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 02:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgLXBLO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Dec 2020 20:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbgLXBKq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Dec 2020 20:10:46 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8A3C0611CB;
        Wed, 23 Dec 2020 17:09:36 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v14so369590wml.1;
        Wed, 23 Dec 2020 17:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DC+NLOANmww3T3T6FI3ieRdm/85Fv6Eh0JyetCBXwV4=;
        b=cBItcV9jWQXipn3WCxoTbgTcHjQjNqJt8eMmHA45Op5N+YcPE0dsIvL1+E5DhU8FfA
         g04YM40AiUOGlAv5JNW1Ju/pxD1jB3xrwiZsvn19qgQa7ogFmiGzvqIKx31Ifv0pcIkd
         f3DN8EAYPhby3VKDyk8kBitGzvtgRC7MDqXyBbm8026TjZcDjO3WNeZ2gojNB7Zpzhc3
         GQSzLlJt2A7jyhWQj0UAkRw3J42kDqy9X3UcETAmYfId84s5kFdYGA5x+7tE689BqaHv
         QGgqBEh4k38I/qnYeS4EZqIRcg3BN3IH6/njfDiP6pgASiMmG9GebQXFkZxi49L9PL9q
         NXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DC+NLOANmww3T3T6FI3ieRdm/85Fv6Eh0JyetCBXwV4=;
        b=n8l6Q3E1GWE2X/nKdL41TqIe3PSKNTNngEYG7lStLWVChpyCG52c91BSus++hVvr2w
         3FDzO9j330vncCKMX7kMlAFDeRUYf9sHp6CvDIJ5aSENQ0CevZfCwK1GzwI2O4mWMj90
         GJ6m45pass2vNEiLUXupTh9/yOm2tiJ9CVdahzkAUjzJdud1y9eqiMo7YBNMZbc90e4G
         blvMKPSg/Uornrpu6ntjPhX387URoWmMFuzbtsQR+36rgCXeU0Zh/y2hrfSoW54lOTAo
         /c9HIFWT27TfeUl8UCB3WADtBSPSUqkhuE7eqm1j4Zbq5gherXgkF8juAuyEYUOZhw83
         Ef4A==
X-Gm-Message-State: AOAM531rPEycgNDgxykDXqaRnRqibNb11XP0NSdqdlGl1KB5sRvl8z9z
        pDTWhwS9ksdyIJIlhdzhnTgTGI8B+pCXH2rB
X-Google-Smtp-Source: ABdhPJwgEuI4ANZ1CSAJuas3ECnzDt7MDzM+aOw12nrks8JMkEUzdOdIHTuxBTCJ0na0XlL6Mzfukw==
X-Received: by 2002:a1c:6446:: with SMTP id y67mr1955521wmb.144.1608772175252;
        Wed, 23 Dec 2020 17:09:35 -0800 (PST)
Received: from valhalla.home ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id b200sm1598653wmb.10.2020.12.23.17.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 17:09:34 -0800 (PST)
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
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 10/14] ipu3-cio2: Rename ipu3-cio2.c
Date:   Thu, 24 Dec 2020 01:09:03 +0000
Message-Id: <20201224010907.263125-11-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201224010907.263125-1-djrscally@gmail.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
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
Changes in v3
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

