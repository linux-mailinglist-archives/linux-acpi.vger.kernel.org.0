Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC576C7B47
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Mar 2023 10:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjCXJ0y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Mar 2023 05:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCXJ0w (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Mar 2023 05:26:52 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6985EDBE8
        for <linux-acpi@vger.kernel.org>; Fri, 24 Mar 2023 02:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ml+kmVPMubRY5uhlZ7rdPEbjmfqKV4xbSPDK0az76Dk=; b=sz83DAVoAM+qVzqAlluxVa0kET
        qLZq/PQymRj2x8jS3OwusybuzF+3R2Nf6sybGWJeFr0sSAuw1zxmBINB+hBDMWCxYCrheKtUhtUqH
        cIcajeIIVPSMt9yVjCatXqB7FeOfa3zzhR0BMLHtN+HDDd+U5tkSCI9SJNZRh59FthDyudWmtt4T+
        2xGYokP1/zfXqGN/MohHE5mI79rQUdh2S+YLzl3j4yunMpjL0YiKIU/jPwBqkvJnDmkwOwKOK6txR
        CDavurmse37HW23jkG8cOkp2Fsb9Oxo0CPuEdGUubvZY5CNb+mLtkacp6REhJ7j7rSvJxG8sNDTFk
        BJForzsg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55740 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1pfdhA-0006kQ-6S; Fri, 24 Mar 2023 09:26:48 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1pfdh9-00EQ8t-HB; Fri, 24 Mar 2023 09:26:47 +0000
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH] device property: constify fwnode_get_phy_mode()
 argument
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1pfdh9-00EQ8t-HB@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Fri, 24 Mar 2023 09:26:47 +0000
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

fwnode_get_phy_mode() does not modify the fwnode argument, merely
using it to obtain the phy-mode property value. Therefore, it can
be made const.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Patch generated against net-next tree as that was where it was used and
tested.

 drivers/base/property.c  | 2 +-
 include/linux/property.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 083a95791d3b..fcc0687f5529 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -895,7 +895,7 @@ EXPORT_SYMBOL_GPL(device_get_dma_attr);
  * 'phy-connection-type', and return its index in phy_modes table, or errno in
  * error case.
  */
-int fwnode_get_phy_mode(struct fwnode_handle *fwnode)
+int fwnode_get_phy_mode(const struct fwnode_handle *fwnode)
 {
 	const char *pm;
 	int err, i;
diff --git a/include/linux/property.h b/include/linux/property.h
index f7100e836eb4..d18c8cc17315 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -396,7 +396,7 @@ enum dev_dma_attr device_get_dma_attr(const struct device *dev);
 const void *device_get_match_data(const struct device *dev);
 
 int device_get_phy_mode(struct device *dev);
-int fwnode_get_phy_mode(struct fwnode_handle *fwnode);
+int fwnode_get_phy_mode(const struct fwnode_handle *fwnode);
 
 void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
 
-- 
2.30.2

