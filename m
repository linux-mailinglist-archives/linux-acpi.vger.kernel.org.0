Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF6B17A846
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2020 15:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgCEO4H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Mar 2020 09:56:07 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43251 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgCEO4H (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Mar 2020 09:56:07 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1j9ruu-0003O3-5k; Thu, 05 Mar 2020 15:56:04 +0100
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1j9rut-0001Cx-Mk; Thu, 05 Mar 2020 15:56:03 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     rjw@rjwysocki.net, lenb@kernel.org, sakari.ailus@linux.intel.com
Cc:     kernel@pengutronix.de, linux-acpi@vger.kernel.org
Subject: [PATCH] Documentation: ACPI: fix port numbering example
Date:   Thu,  5 Mar 2020 15:56:01 +0100
Message-Id: <20200305145601.3467-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If I understood it right the ports should be numbered using the "port"
property and not the "reg" property. I stumbled over it during
extending the v4l2_fwnode_parse_link() helper which also use the "port"
property.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Hi,

I don't know if this is right since I'm not a ACPI guy *sorry*
Anyway reading the doc description and the v4l2_fwnode_parse_link() code
give me a 2/3 chance.

Regards,
  Marco

 Documentation/firmware-guide/acpi/dsd/graph.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/firmware-guide/acpi/dsd/graph.rst b/Documentation/firmware-guide/acpi/dsd/graph.rst
index 1a6ce7afba5e..dcf0102aeb29 100644
--- a/Documentation/firmware-guide/acpi/dsd/graph.rst
+++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
@@ -97,7 +97,7 @@ A simple example of this is show below::
 	    Name (PRT0, Package() {
 		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
 		Package () {
-		    Package () { "reg", 0 },
+		    Package () { "port", 0 },
 		},
 		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
 		Package () {
-- 
2.20.1

