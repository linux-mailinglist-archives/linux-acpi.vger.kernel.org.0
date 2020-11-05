Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E4C2A7877
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Nov 2020 09:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgKEIA1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Nov 2020 03:00:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49599 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729862AbgKEIA1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Nov 2020 03:00:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604563226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Pluz2cEJCXCyvPbyI8FVIRYK1Xva1UsmaO+fzo7598=;
        b=BcM6hkOsG0q+QmCN01KF+hFD3cFp85Zb4VhvNFHnzbF01FN28C+sfacctEV00J9L5XciyW
        iYuf6a1WjtNMDlfWW0Hge9SijsIsgpBj2EJLO0OV0cFzMRexx+Dfq+/X2L1SsqRE9byftA
        /EIDkSohXf6Cg10dtMyZhcXCWGVdUDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-b3Pn88ewN6iRhKgkecumkw-1; Thu, 05 Nov 2020 03:00:22 -0500
X-MC-Unique: b3Pn88ewN6iRhKgkecumkw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E232780474C;
        Thu,  5 Nov 2020 08:00:20 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-113-73.ams2.redhat.com [10.36.113.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70F165D98F;
        Thu,  5 Nov 2020 08:00:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mark Gross <mgross@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [RFC 2/4] platform/x86: i2c-multi-instantiate: Set i2c_board_info.irq to -ENOENT when no IRQ is specified
Date:   Thu,  5 Nov 2020 09:00:12 +0100
Message-Id: <20201105080014.45410-3-hdegoede@redhat.com>
In-Reply-To: <20201105080014.45410-1-hdegoede@redhat.com>
References: <20201105080014.45410-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In some cases the i2c-driver may need access to the ACPI-fwnode as
that may contain ACPI-methods supplying e.g. orientation-matrix info
for accelerometers.

Setting i2c_board_info.fwnode to point to the ACPI-fwnode, while
leaving i2c_board_info.irq set to 0 (in the IRQ_RESOURCE_NONE case)
will cause the i2c-core to assign the first IRQ described in the ACPI
resources to the client, which we do not want.

Set i2c_board_info.irq to -ENOENT instead of 0 in the IRQ_RESOURCE_NONE
case, to avoid this issue.

This is a preparation patch for passing the fwnode to i2c_acpi_new_device.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/i2c-multi-instantiate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
index 6acc8457866e..cb4688bdd6b6 100644
--- a/drivers/platform/x86/i2c-multi-instantiate.c
+++ b/drivers/platform/x86/i2c-multi-instantiate.c
@@ -113,7 +113,7 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
 			board_info.irq = ret;
 			break;
 		default:
-			board_info.irq = 0;
+			board_info.irq = -ENOENT;
 			break;
 		}
 		multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
-- 
2.28.0

