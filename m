Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C666E2ED0B5
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbhAGN3k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbhAGN3j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 08:29:39 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3985C0612F8;
        Thu,  7 Jan 2021 05:28:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 3so5538674wmg.4;
        Thu, 07 Jan 2021 05:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G24Pi0ScEmKZDb/xS2Mk3tHlxD/Jgk8zfDkBIWHujyQ=;
        b=S9FCeZYqi0VBupX4SYqXfJrfUogTMMSNcCmUOl7Oyhd8QFGjyQ4Lmj12Ro5YAzgDT5
         I5PK+AiYQ/fYj1aysd6798idxChZ5jb1yqGvQszWenRseDLWf8d3LKJjC2xepqGVyL2W
         VgiJ7uSmhfPUVotEh+nuPnJDq/8ig4fqG6XdrKVT+LXDE/9fLZebg5Ovq7SpbeOqUXOM
         X/rhnWox0HsHSa73xIlVm8Lcl5zZEl8eJHPKbw4+zZZazwk7YfAYkMoSJOI/9sAIzLpV
         L06353xTfiHUnvnmPeRK/C3lTlrvbSJEOsI/jrO2MheWL36tS/k5o1DHTKo/sYmPwKd0
         cwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G24Pi0ScEmKZDb/xS2Mk3tHlxD/Jgk8zfDkBIWHujyQ=;
        b=g/v22sDIpuNYvo1oKoon03K3RNqJNJODH+p2twHlkBpx1I/+NTarCRuFD6wgWLzIcZ
         jAMHJxHhEhvxha+jYTuU9jEsJxPP05KEFFPiodSSClAntyqd+hWWeI6KeuSPgcLIAWvI
         JuGokgjTZc5KVvZUqu1pHbKAguLU1aUqdPpdIcd9jhiUC5GB1CvqzEiUremaENm0Ys3U
         bVyWsMR2Z5AfS9FE19GjSC0C7Erz83EfHoI8WX7KR+NVkO+s843fPv6PDXs5OoYYXNLp
         d/gft4xAEMOywdKkVQy8KFDZyH3hv6XxFlna/TErNgO5dPK63LF2SJIoBJKdZazorZrl
         kSFw==
X-Gm-Message-State: AOAM5308CWQYM/eWsX488fw2exFpyZk2ce6iG9BL0gd1Vvt37vyz4oLF
        vNg1S0tHZgY5jgVQbGZB8yv8uKprrpMgD4fT
X-Google-Smtp-Source: ABdhPJzfInxM4R11yfnZS69DD0jx4S1jjJkh6E1AGbjUju6pbeBrdLeWnSnM5AJA1LEgADyBAo+/Vg==
X-Received: by 2002:a1c:e309:: with SMTP id a9mr8186820wmh.172.1610026137722;
        Thu, 07 Jan 2021 05:28:57 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id o83sm7660125wme.21.2021.01.07.05.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 05:28:57 -0800 (PST)
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
Subject: [PATCH v5 03/15] device property: Return true in fwnode_device_is_available for NULL ops
Date:   Thu,  7 Jan 2021 13:28:26 +0000
Message-Id: <20210107132838.396641-4-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107132838.396641-1-djrscally@gmail.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some types of fwnode_handle do not implement the device_is_available()
check, such as those created by software_nodes. There isn't really a
meaningful way to check for the availability of a device that doesn't
actually exist, so if the check isn't implemented just assume that the
"device" is present.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v5:

	- Changed the commit subject

 drivers/base/property.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 35b95c6ac0c6..0bf5260f14c6 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -837,9 +837,15 @@ EXPORT_SYMBOL_GPL(fwnode_handle_put);
 /**
  * fwnode_device_is_available - check if a device is available for use
  * @fwnode: Pointer to the fwnode of the device.
+ *
+ * For fwnode node types that don't implement the .device_is_available()
+ * operation, this function returns true.
  */
 bool fwnode_device_is_available(const struct fwnode_handle *fwnode)
 {
+	if (!fwnode_has_op(fwnode, device_is_available))
+		return true;
+
 	return fwnode_call_bool_op(fwnode, device_is_available);
 }
 EXPORT_SYMBOL_GPL(fwnode_device_is_available);
-- 
2.25.1

