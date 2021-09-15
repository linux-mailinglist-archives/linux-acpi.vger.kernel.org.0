Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC63240C16A
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Sep 2021 10:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbhIOINb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Sep 2021 04:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbhIOINO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Sep 2021 04:13:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746DAC061786
        for <linux-acpi@vger.kernel.org>; Wed, 15 Sep 2021 01:11:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a23-20020a25ae17000000b005ad73346312so2545568ybj.18
        for <linux-acpi@vger.kernel.org>; Wed, 15 Sep 2021 01:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SwVyaP/Ht2PwaBMDQzWc9eJHDBQpCz2nALAmbECEhpQ=;
        b=QUGoVBusTu4hW55kbQfAHy0Gpz3kYuimJYcUOODn8J0I/7DZkCM14Y/XV93nl4aYCP
         +ezA6KRcvEAcmEmCHGF5DK4VQuHzoqloHRAExFyo7XQX8VWVQZZuMgxbs6GCErGm2xMo
         3WhdO6zOo0cDPPeM9+uOMVq6rJzF5I1bMsuh9A+hQ9dQKjLGrEjVGGh3qZ4jo2NavqpK
         fEWQGL9qQYSigSa3YT6nkRZJis7DRUE0zbaV3jtu3YQv4UgL/fPifi3K+lWZrkLDAE9V
         0VrtY5L3be1fgKiq/HYPxZl3N1zuyBS1+avTDv8T5P89lhU3OE4fk6lyCuhow3EQ4a24
         yK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SwVyaP/Ht2PwaBMDQzWc9eJHDBQpCz2nALAmbECEhpQ=;
        b=Gl4qBFXRhtqaKBYotqPv3NGB7BtDCoyK8MgkfiAnCTaQB/jUTYGS3PBmQWn0fsv8Wu
         Di5msGqBXoZ51Od+N/9A8mSmSOj2Lrq49rfgWbnt0QR8STk3HQlOMMH0ESvNUGF/Qtmj
         7FsGKHLK63TD1BReyVKiL6azQcLzEOJyRP6IwKfs8ScUNSf9x3y/dg/SRGzFtuFgr2Fg
         yw6mC05V61Kt6ya2coaHdG6VcLTsXSPfDIj9DDWc4kpim5jm1A7vVQIfJ7LTo8PtlsbT
         KFKJtOR8wPoCTN4seTONM6iHmABxhd8WFjvo+v1i2PBSksROukHQz2HDHXmCj4no17VR
         Zixw==
X-Gm-Message-State: AOAM533W1Z9nUVW7aqDOlU/HMoiOl8a8FF1ArW6amqaUVltp4ZhdIMat
        v3ttPdW99DVoES+/aNhAQ3ZUsZw+PompAto=
X-Google-Smtp-Source: ABdhPJzEE5Yr1jFgjYuau+gaFxStrLfBehac0EkhE77LIzIh9w6hvW01QzSMoNh14iJf8H76Z5XogrY3/gaGBTI=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:16d1:ab0e:fc4a:b9b1])
 (user=saravanak job=sendgmr) by 2002:a25:6d83:: with SMTP id
 i125mr4550266ybc.298.1631693508682; Wed, 15 Sep 2021 01:11:48 -0700 (PDT)
Date:   Wed, 15 Sep 2021 01:11:34 -0700
In-Reply-To: <20210915081139.480263-1-saravanak@google.com>
Message-Id: <20210915081139.480263-3-saravanak@google.com>
Mime-Version: 1.0
References: <20210915081139.480263-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2 2/6] driver core: Set deferred probe reason when deferred
 by driver core
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When the driver core defers the probe of a device, set the deferred
probe reason so that it's easier to debug. The deferred probe reason is
available in debugfs under devices_deferred.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 316df6027093..ca6c61a2e2e9 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -975,6 +975,7 @@ int device_links_check_suppliers(struct device *dev)
 {
 	struct device_link *link;
 	int ret = 0;
+	struct fwnode_handle *sup_fw;
 
 	/*
 	 * Device waiting for supplier to become available is not allowed to
@@ -983,10 +984,11 @@ int device_links_check_suppliers(struct device *dev)
 	mutex_lock(&fwnode_link_lock);
 	if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
 	    !fw_devlink_is_permissive()) {
-		dev_dbg(dev, "probe deferral - wait for supplier %pfwP\n",
-			list_first_entry(&dev->fwnode->suppliers,
-			struct fwnode_link,
-			c_hook)->supplier);
+		sup_fw = list_first_entry(&dev->fwnode->suppliers,
+					  struct fwnode_link,
+					  c_hook)->supplier;
+		dev_err_probe(dev, -EPROBE_DEFER, "wait for supplier %pfwP\n",
+			      sup_fw);
 		mutex_unlock(&fwnode_link_lock);
 		return -EPROBE_DEFER;
 	}
@@ -1001,8 +1003,9 @@ int device_links_check_suppliers(struct device *dev)
 		if (link->status != DL_STATE_AVAILABLE &&
 		    !(link->flags & DL_FLAG_SYNC_STATE_ONLY)) {
 			device_links_missing_supplier(dev);
-			dev_dbg(dev, "probe deferral - supplier %s not ready\n",
-				dev_name(link->supplier));
+			dev_err_probe(dev, -EPROBE_DEFER,
+				      "supplier %s not ready\n",
+				      dev_name(link->supplier));
 			ret = -EPROBE_DEFER;
 			break;
 		}
-- 
2.33.0.309.g3052b89438-goog

