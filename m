Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D16B2DDC14
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 00:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbgLQXpS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 18:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732406AbgLQXpP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 18:45:15 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156C5C0611C5;
        Thu, 17 Dec 2020 15:44:04 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id 91so229318wrj.7;
        Thu, 17 Dec 2020 15:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=riJVgL/vim4VKJ7ma+YNngc2fLrOooVQootWQpOsbu0=;
        b=PyYgXTgQAX8OhUliV1GLGVyJK3dV76O67chicHnX70h0b+MTbEVsTZwioRjocZAIF6
         C5Azus/xjyd//3lFTTK4B1T6IyfBgSKVhfMcZ9QMPnsvEFIruYZy2Sp712dszlqwhNKU
         ncN2TaIXXgdLU1i3fecOc9/hqznOa12jJbB9IRA9TGkdVFwgfzaibE5NHVxh8YyvQEEa
         Wn7reJAO85dUVMOQI8S7SAH/XEAHDdGOYTu2dzeZILHuMBXUUfhe9QqwWZF/+uduO09i
         +fH2+0rqDwBE/i9hDyZET7UAKe4YQCXKuW1Cybx6Mor6zNaV6O16+LHOPbHPhKq2FN10
         +tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=riJVgL/vim4VKJ7ma+YNngc2fLrOooVQootWQpOsbu0=;
        b=LtfYMcCOZEqJOr58fkoUiHg4cCwLC86P8JuHTuNpagecX/gBfevJgidhwXV4dqEoxt
         DvZPOpv4tAcZwJzkemG6OsPhoOJbXUD2/TASWb69GthTLQTr4r9bKEsI56bqVXBf8kz1
         2NZpEkhsfAml381XSitYnsgMjMw89iFDdp0r6xQ2t9ixFNEv6A64eXzH3v/PL+NcS+zv
         SrrDCCdiIJt2IzqUoPUOkBB/YX1jwtR3h4mmgo+Oi9hJQeyp6jJoeGYe4l09Hk1fdMVA
         qzv5ZLlEg/VGgoKWVUd7Yg+H49uCD6TJiCocEOu5VkjhaiIH6k0t3VxrZRj3OLZ+Blkc
         MTCg==
X-Gm-Message-State: AOAM533QMx4cFWihO8rYL7FKucBNEHlo4r7ruyZKEKJCbV21kDB8e/4A
        q3Y5SsOE78r15HIFN9lPzqIayaVyq3LxzHOz
X-Google-Smtp-Source: ABdhPJw1gsGoW8ANqps3uaXvZo3BgqwOBaKw48l5oJmW7aKdtqU5eCksb39kLZGmOV8Ax57c3BS5rQ==
X-Received: by 2002:adf:dc08:: with SMTP id t8mr1210069wri.195.1608248642876;
        Thu, 17 Dec 2020 15:44:02 -0800 (PST)
Received: from valhalla.home ([2.29.208.56])
        by smtp.gmail.com with ESMTPSA id o3sm1873575wrc.93.2020.12.17.15.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 15:44:02 -0800 (PST)
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
Subject: [PATCH v2 08/12] ipu3-cio2: Add T: entry to MAINTAINERS
Date:   Thu, 17 Dec 2020 23:43:33 +0000
Message-Id: <20201217234337.1983732-9-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217234337.1983732-1-djrscally@gmail.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Development for the ipu3-cio2 driver is taking place in media_tree, but
there's no T: entry in MAINTAINERS to denote that - rectify that oversight

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v2:

	- None

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 80881fb36404..16b544624577 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8946,6 +8946,7 @@ M:	Bingbu Cao <bingbu.cao@intel.com>
 R:	Tianshu Qiu <tian.shu.qiu@intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
+T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/userspace-api/media/v4l/pixfmt-srggb10-ipu3.rst
 F:	drivers/media/pci/intel/ipu3/
 
-- 
2.25.1

