Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F76F2E8EE2
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 00:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbhACXOU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 3 Jan 2021 18:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbhACXOU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jan 2021 18:14:20 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFB3C0617A2;
        Sun,  3 Jan 2021 15:13:09 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q75so17220952wme.2;
        Sun, 03 Jan 2021 15:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uCgaWXYct1zZj5+VJRp/wgRdsX3awmEzLkDpQnTAYRQ=;
        b=MOW6SXLBBtOntBNRc+8R3TMNFI2rDRB3iVZivyeY8ed76rvUe+EAUI90hws1MdzEnP
         iBmhYkuy1q3vk5Y22kah+7Z6j+SOBnkzepAYXLUvSdrEnrKQn0EwA9FXFro4cSarVl4E
         S0QzZsWQtRNMfIWFBXCnvzJDRN7Zi/wbZEQpJUiCT0dgGHLt1KAB2pc4HzbCWY6KiNrG
         2/imoa63U1yQxshjGzrfZIK0rgqGCaIEisXIt5q53/DSnHjkwMZKXY/bYjhYOSBLOcOx
         RUtTArqgUvKAA4mOzdM3i0ZfUhjdJxyYVBxcVPJkPcTJpLV+tvQ+jHJyq1kmarBg/Ttm
         63lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uCgaWXYct1zZj5+VJRp/wgRdsX3awmEzLkDpQnTAYRQ=;
        b=LcO/aSxRZesiCxYsL/QROgk39ECEM4QEnShhVudWqm8Q8e+ecRxYlCEqvkouUpsj+8
         5Z1zCqSaAixeWm9QdFsQT04qR5kzQuWgAHfPBuB1lxWAvkb2EiiAs/cmqnLY53HwdaLR
         nw7erpdtLfvlkTCJoBGcGmcp/X9s6SElaasuXUSt0btGPg4YKstIN+m18cICLJaiOWL2
         AcTFa6GtcJUT1kEG6UIYr9pClImqijWhN19lfQM1GIJhBxr2mNJehH/xb0gl7yAhddBU
         M0RcSBRp5Yhsc/78rI6UOrPNNTt2zGSiC7+DB790TSH5wJX1oStElUZrZx1l7/TR57Sf
         dxUw==
X-Gm-Message-State: AOAM531VF1gGUHVFmop8YAmCNz7fzL1b6Vbft8FFzkBXEQaJVn9dFyG4
        +556j6AegmuyghHY7amzKyK/Zr5ccF2c2fhC
X-Google-Smtp-Source: ABdhPJz4Zcze076CzshZwlY0nQWytYM149vLcUc3eCNq26WFkE6SOtEK/nzoL7YAhdZTIwBrarVIRA==
X-Received: by 2002:a1c:5459:: with SMTP id p25mr23449731wmi.19.1609715588425;
        Sun, 03 Jan 2021 15:13:08 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id h9sm32571018wme.11.2021.01.03.15.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 15:13:07 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        sergey.senozhatsky@gmail.com, mchehab@kernel.org
Cc:     lenb@kernel.org, yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v4 11/15] ipu3-cio2: Rename ipu3-cio2.c
Date:   Sun,  3 Jan 2021 23:12:31 +0000
Message-Id: <20210103231235.792999-12-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103231235.792999-1-djrscally@gmail.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
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
Changes in v4:

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

