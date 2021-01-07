Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C068B2ED0C3
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbhAGNaU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbhAGNaT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 08:30:19 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209FAC061282;
        Thu,  7 Jan 2021 05:29:10 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c124so5149435wma.5;
        Thu, 07 Jan 2021 05:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iUMxq9sm/N1IcgtSTNHft9W//qV2OwXPT/djjfo6B80=;
        b=NZC1gCGiJNPa4E4p4wziv2RxukmwdGPNYUnn6yA35t3Gs9qxLVA/8Ru+z40RDQZk+w
         hPkpnr3uDzEzoRm9K2/cff7ZRBZI2gw1dPebmesNm81DZJH0zUbvUtjS/8p3ONw625/N
         42tAFBhHREu/eP5RyGch+sb8W4vlGlgWztF+FkTCsEswbAdb/ZxPLBqo4VPvoNhHYICG
         AuaMSfut/eVK11z5TPjMVRqf+XikMjnof0NIxbsgE3vLg9IEiC7unruu/bfyrgOBcgA8
         rQCwhUs5Wice36aaEMQgBKXqoox7ifMfMkYcEdTyOz/o5CGrRFNJw1vR+e9H/R0Anq+I
         uiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iUMxq9sm/N1IcgtSTNHft9W//qV2OwXPT/djjfo6B80=;
        b=nxBWS+OojR4XJltaeMaYaBFBGyHDrDRBfJk+ZbxDA9tb0Pv674W+nCmtW0ZfB6GGdD
         0tHmU3oETpmitJsIkQEMWj+Akb5ywnopo2g5we9WkkK05gZYPFHNdEq/Q1M69cnqdxcw
         Wl6U1HbH6qFF6HH1lW/k4KhvNWdH0aCG9DR2Ww+J+cWYryIiYKq75OGN5QxEwRncB3d1
         AaNaRqxwStQRWe6W/SDKPvmu7yRdVl+QVOe76u12flbvKmOyMfChPatWc3uIfY86Bnb+
         R+YDF2SmrqEilt+SXepPkqQHnEYamlYR0PQfMxwqLw1atrvaAGcMH/CIjFkBuVUG/tf0
         c8/Q==
X-Gm-Message-State: AOAM5323qOBN55l2cUeQ99qkB6IE19LvSN65rBi4Xw+fpxKtoQ2QDVZD
        A0m364XTUDdXJ6aAMZ8HFdZWZx73Q0IeLD78
X-Google-Smtp-Source: ABdhPJy03paiRqbUzQYJ5PSzdk/e1RvBo+kKcumvn2amiBu/QxZBgMAuB6RU+F4Prb5UJhVb3H7JRQ==
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr8119112wmi.36.1610026148856;
        Thu, 07 Jan 2021 05:29:08 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id o83sm7660125wme.21.2021.01.07.05.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 05:29:08 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, mchehab@kernel.org,
        sergey.senozhatsky@gmail.com
Cc:     yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se,
        prabhakar.mahadev-lad.rj@bp.renesas.com, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v5 11/15] ipu3-cio2: Rename ipu3-cio2.c
Date:   Thu,  7 Jan 2021 13:28:34 +0000
Message-Id: <20210107132838.396641-12-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107132838.396641-1-djrscally@gmail.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
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
Changes in v5:

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

