Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0EF2E8EE0
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 00:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbhACXOT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 3 Jan 2021 18:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbhACXOS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jan 2021 18:14:18 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F620C0617A1;
        Sun,  3 Jan 2021 15:13:08 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c133so16486379wme.4;
        Sun, 03 Jan 2021 15:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R0GAqmMhWCpJ1h+yyfP0dUQgaIKJOiN6SmCAxCwFEKI=;
        b=nGIufHNC+J2K6NafexTPvNG7L2Mfidg/YDxQoTHoZ4HFOYtOXTmFjP2mJBTdRwpChk
         G1DWlVC7d9qd4QUGocCfiX6Vu3XEW1xzGodLAQ5nGxtwq+wPLN2dc0UAQcsju+OoPuyM
         qvjip6TG+arkB144KvaP1PbL0RDA7ELcAB1/VmgQcgaR6pN0O3Aa+rWWGMNQNRIQnTVl
         GBKJdbSrp7YxEwdG9WWoAB7fU+vUSTSL48nEmhrX4hzASXCjBCwhMLOCdGqaG75wWuAz
         lI6GTGmLIhp0QhN8ru8JSr73VjLsEwD7EEKr+WrXUkE4P9E9NmWZymiCjD6NhQaZkIpi
         TPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R0GAqmMhWCpJ1h+yyfP0dUQgaIKJOiN6SmCAxCwFEKI=;
        b=rldXdMgVXMHWupN0QetEV/im4KV6b0ggozeLdy0BxftZPjAA0ui1qxAcx4Y4Sv6W68
         Th32/t5r+d4CkOc48rg9t6lJ0KmdITJGq2ZhZFChtCZEL+ImwPCVSiC/0jdBOxepFLxz
         W7qqWShGDrHfibmX5bSLeOCcKxdrmFdmn1Z508deF/GcMoeIOAFDN1CaYrlh6gIwVuJw
         481t7SOUcyDbvrWYTqkcCf+Ni0CvQYVbf276G46ojUs7vFkxsjZIwilyyDkQodtGSMjg
         aIUpQ23uU+KsQXUsPGs9PwxK5E2Kv2bVoCgRoVbmuPqc4HgYD9ZBTJr58rB/UZfAhORc
         Dakg==
X-Gm-Message-State: AOAM530N5CfbAqC4p1XflG/zScZceumtR44h2znvDvWqfeq6czJToUOp
        CoFn+mEAvnQvJzMXqVuwhiKZ3UszdmbY8fra
X-Google-Smtp-Source: ABdhPJy9XdA7GbO81Nb7fgLNPrp6CJ5xQunVhwOh5UmO5Abry4Qw4SYT0hnooPHj34IqfJPdktiDvw==
X-Received: by 2002:a1c:4384:: with SMTP id q126mr24898530wma.84.1609715587155;
        Sun, 03 Jan 2021 15:13:07 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id h9sm32571018wme.11.2021.01.03.15.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 15:13:06 -0800 (PST)
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
Subject: [PATCH v4 10/15] ipu3-cio2: Add T: entry to MAINTAINERS
Date:   Sun,  3 Jan 2021 23:12:30 +0000
Message-Id: <20210103231235.792999-11-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103231235.792999-1-djrscally@gmail.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
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
Changes in v4:

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

