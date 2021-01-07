Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1982ED0E2
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbhAGNbJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbhAGNaR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 08:30:17 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B62C0612FC;
        Thu,  7 Jan 2021 05:29:04 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c5so5633098wrp.6;
        Thu, 07 Jan 2021 05:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V6vQkmHN3rEByvF+1Dwoxbe+Td104EXLxBMpWJRgs3M=;
        b=GAT28sG0CqFj02Lq/lJA5nmhXJouikb/xqpXwlHSBNTMHlbKLh/B/cqkQ2+GoAev38
         1mbipa0mepAo6bV0PkdR+2HkY+2x+0BML4FR0dAlmsh9c7JcHpDOXreSDANzPegvY4mn
         9ZKjXi+FkX//EsRV1I3oLGdQ7otJAgwi7a/wBsbEwQ5oShDH9E9oDoAPokrtGUmmoobc
         9ez4npFh9UdPR4CmepxoO2qId8SLS7WgOnlSo3DWmvzt8CycYjCaiEA4Srn0p79IXUaP
         HgqD4BEE+FAfVWseKe9AWqtoRFZLteb48sUSmXfwhOmCAfdVZ18KQkQst0NI7ncu/EV/
         KH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V6vQkmHN3rEByvF+1Dwoxbe+Td104EXLxBMpWJRgs3M=;
        b=SloElMxfYRU7I+8si4LQQWJlSuxca9MSoMAG+3vIs5QzmYpUhnAIvwVFQDLsxZmPgc
         57lgTcrMz19uWH3qfarnnD1+QGktBsRlmmsz7CFpPpvj8y+V2QzAq/sqhv8YO4zIO37f
         bxYzrmib0D7kbsShDz5owzDGsNHvGDS2nF4RRNm00HHEnelgUsDSXMb352nCS/ciAams
         s//Tncn495iLKHdyL1anFBrcr/zab8L5X09Cn+YGpLUQ7gMX3Uh2T4e28+bDIIx3tC/A
         xiut04Et5uh++M1nuHNblE0oHUkgnO7afKjUxepBghgL6AdFKg3WR/e5i85f9au0jmSa
         sTGg==
X-Gm-Message-State: AOAM533G7G74YCjvB92AfHyM57XS6ohRZA+1fOCRL45mc0dXzzL6id/x
        XxgI84QQ7pGzBjAu9eVYu+T99LaKY7aXvETy
X-Google-Smtp-Source: ABdhPJxhs7L7BLf8T98Cge4AvjwO7uqxG8kfQotuyB4U2SJjiKuG6XogCTkoiMqZIqNpKRPRj8hZeA==
X-Received: by 2002:adf:ce82:: with SMTP id r2mr9064064wrn.181.1610026143303;
        Thu, 07 Jan 2021 05:29:03 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id o83sm7660125wme.21.2021.01.07.05.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 05:29:02 -0800 (PST)
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v5 07/15] device property: Define format macros for ports and endpoints
Date:   Thu,  7 Jan 2021 13:28:30 +0000
Message-Id: <20210107132838.396641-8-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107132838.396641-1-djrscally@gmail.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

OF, ACPI and software_nodes all implement graphs including nodes for ports
and endpoints. These are all intended to be named with a common schema,
as "port@n" and "endpoint@n" where n is an unsigned int representing the
index of the node. To ensure commonality across the subsystems, provide a
set of macros to define the format.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v5:

	- Changed commit subject

 include/linux/fwnode.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index fde4ad97564c..77414e431e89 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -50,6 +50,13 @@ struct fwnode_endpoint {
 	const struct fwnode_handle *local_fwnode;
 };
 
+/*
+ * ports and endpoints defined as software_nodes should all follow a common
+ * naming scheme; use these macros to ensure commonality.
+ */
+#define SWNODE_GRAPH_PORT_NAME_FMT		"port@%u"
+#define SWNODE_GRAPH_ENDPOINT_NAME_FMT		"endpoint@%u"
+
 #define NR_FWNODE_REFERENCE_ARGS	8
 
 /**
-- 
2.25.1

