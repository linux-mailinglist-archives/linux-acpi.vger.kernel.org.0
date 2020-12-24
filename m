Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EE72E234C
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 02:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgLXBLO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Dec 2020 20:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbgLXBKq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Dec 2020 20:10:46 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E0CC0611CA;
        Wed, 23 Dec 2020 17:09:35 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 3so382565wmg.4;
        Wed, 23 Dec 2020 17:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PwIQaMJOLA001P6qObxea6AJHq4n8kIYBNI8gcn2cvU=;
        b=FuNkmjn7d4r1YDLl3/m27mUqzQncaa3h6RCCvS+sZHOXsknYE/LQs6TAGHPwJSktes
         YnXKIET2c7zoyvAmx+oXOGIm9hQx3xsn1a2496q3uBVvMJfpmlGWpmezc8yuvXLjDPNt
         Abgqhx2izsw/j7EmZ+vUdI8xBkxvMT8mAlCMa6OFxJGbgBt3eewEafczEe20GBgC5Jxj
         tIg+aN8VT4U7p+lGN+XOwIHmyiQsVe1JZ/Ex5USYP2LEYO2KJDkA6VUN6faGDV1QLv+g
         W9/mSrmx/1/MmxGJuN+LQiU38BTMiKla9cpdD5xY9az+ltUjf99JiFd0nBC5rMQf9PI2
         B8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PwIQaMJOLA001P6qObxea6AJHq4n8kIYBNI8gcn2cvU=;
        b=BG5OeRDp/7cnMol7i6ZkcJG32RrzVJ+ED1pXsowcRhy4JwV0oVmxkjA1vFSvBVW1LV
         O7lFlGOFObbNYKiCkxxiMie89z+uIdkJwI0oqvBPlijhLdzH7K2UNEOYjFreedXWIVtl
         0lYqxhEFAQb0R5vyvVjEHezyrZM0XnG3Bs/6B8uOI/OOjPmClYFR1P9RyCPpnXHaDl/c
         1ZpRS5aYJ4DH9T50iag5/Kmj11F66qWKZ04gAVD63gYnRAb0m/E0PvXe/Yh81twS1bNv
         pcXqtZQOc/Tr6nLZ0ujVcPqS3bvOgvR2vlLArD0PjUae+bZ03q2o23VVgRnkvooILuf4
         BJnQ==
X-Gm-Message-State: AOAM530ImjRJqG31DUD2tTfQZw9WdAD0OTKJRAN9oQxV+tovJRPu++mm
        aBiWVXMwBqtHCn/bS+WMZDBK6trmbUKxBbX3
X-Google-Smtp-Source: ABdhPJzaIrpRh01UiRQUT6dp0mishBeJ8etlV8Nvugslpr9fM77N7J0miuhJGMqmJeS7zlpzvdnHsw==
X-Received: by 2002:a1c:e90b:: with SMTP id q11mr2001043wmc.102.1608772173860;
        Wed, 23 Dec 2020 17:09:33 -0800 (PST)
Received: from valhalla.home ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id b200sm1598653wmb.10.2020.12.23.17.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 17:09:33 -0800 (PST)
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
Subject: [PATCH v3 09/14] ipu3-cio2: Add T: entry to MAINTAINERS
Date:   Thu, 24 Dec 2020 01:09:02 +0000
Message-Id: <20201224010907.263125-10-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201224010907.263125-1-djrscally@gmail.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
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
Changes in v3
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

