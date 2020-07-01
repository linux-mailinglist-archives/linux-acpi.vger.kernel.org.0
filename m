Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42D2210508
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Jul 2020 09:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgGAH3o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Jul 2020 03:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgGAH3o (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2020 03:29:44 -0400
Received: from hillosipuli.retiisi.org.uk (hillosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::81:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CB2C061755;
        Wed,  1 Jul 2020 00:29:44 -0700 (PDT)
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 7BFAD634C87;
        Wed,  1 Jul 2020 10:29:26 +0300 (EEST)
Authentication-Results: hillosipuli.retiisi.org.uk;
        dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fi0aXQP+";
        dkim-atps=neutral
Received: from sailus by valkosipuli.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1jqXBO-0000nn-Hl; Wed, 01 Jul 2020 10:29:26 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        hillosipuli.localdomain
X-Spam-Level: 
X-Spam-Status: No, hits=-2.5 required=7.0 tests=BAYES_00=-1.9,DKIM_SIGNED=0.1,
        DKIM_VALID=-0.1,DKIM_VALID_AU=-0.5,DKIM_VALID_EF=-0.1,SPF_FAIL=0.001,
        URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no version=3.4.2
X-Original-To: sakke+iki@retiisi.org.uk
Received: from javiela.iki.fi (javiela.iki.fi [185.185.170.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 6E168634C89
        for <sakke+iki@retiisi.org.uk>; Wed,  1 Jul 2020 09:21:45 +0300 (EEST)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by javiela.iki.fi (8.15.2/8.15.2) with ESMTPS id 0616LvcW000268
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <sakari.ailus@iki.fi>; Wed, 1 Jul 2020 09:21:59 +0300 (EEST)
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F118455B;
        Wed,  1 Jul 2020 08:21:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593584512;
        bh=/+m3Ksh55Q3cNYCFz7Xh4xcWcjcp+zge4slRCex/PDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fi0aXQP+EX4/FIhBmj2gx0bZQ9pClNeI7Coa7Qfjx5c/kpCB1TxVE1z/BdzrQEX8w
         XwAXoYfVbkEM0lo/EC0Uj0Rt3aqAcMC741AoEOXBzSfQIFPWjUAzTsepargsO+pwKI
         E/7n7odtylH0YQnoM4T0D+HCqKkynpZDWzcw2tFI=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v4 1/4] device property: Add a function to test is a fwnode is a graph endpoint
Date:   Wed,  1 Jul 2020 09:21:37 +0300
Message-Id: <20200701062140.12953-2-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701062140.12953-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20200701062140.12953-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Drivers may need to test if a fwnode is a graph endpoint. To avoid
hand-written solutions that wouldn't work for all fwnode types, add a
new fwnode_graph_is_endpoint() function for this purpose. We don't need
to wire it up to different backends for OF and ACPI for now, as the
implementation can simply be based on checkout the presence of a
remote-endpoint property.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 include/linux/property.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 10d03572f52e..9f805c442819 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -389,6 +389,11 @@ struct fwnode_handle *
 fwnode_graph_get_remote_node(const struct fwnode_handle *fwnode, u32 port,
 			     u32 endpoint);
 
+static inline bool fwnode_graph_is_endpoint(struct fwnode_handle *fwnode)
+{
+	return fwnode_property_present(fwnode, "remote-endpoint");
+}
+
 /*
  * Fwnode lookup flags
  *
-- 
Regards,

Laurent Pinchart

