Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251CC386D9C
	for <lists+linux-acpi@lfdr.de>; Tue, 18 May 2021 01:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbhEQXXp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 May 2021 19:23:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231318AbhEQXXp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 May 2021 19:23:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AEC761285;
        Mon, 17 May 2021 23:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621293748;
        bh=EPBxny1NVj/4hJ03KGf6BRDXyG2HMfX26b5gVD5p4Ak=;
        h=Date:From:To:Cc:Subject:From;
        b=RZqtnAjWXB6D8uxmTNZFPHf/DF6al8mVzBBZ1w8ilO18QPJmEg+X8FuciOtJT4YDP
         aY2AuH5MHSvP/EQyKvEHiy3o/d837niQOfH/P/ChQDToKJFag9Ui2MqO1uQwSaIJdA
         Iof4/1i7RnMI2E9nwgfrJ9lv25VHZlS7t9Pj7c7cIh4FanMkoXGOuNq830s0KrYWrs
         pnsbP/nEGC6Nr2e1/YReMmDVD9ru0zIU4/uF1y6a2q1/e7zVA5w9cc+HZz2z6rxjnd
         3TKeuYKn1mY8mwn4ZGFl+xY4+3StA5zf9utKLRsXCDLrEAPzzC6gV1pwolU1py11AZ
         2N4Dz9/LeXlcw==
Date:   Mon, 17 May 2021 18:23:12 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] ACPI: Fix fall-through warning for Clang
Message-ID: <20210517232312.GA43474@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a
fallthrough warning by simply dropping the empty default case at
the bottom.

This contributes to the ongoing efforts to globally enable
-Wimplicit-fallthrough for Clang.

Link: https://github.com/KSPP/linux/issues/115
Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/lkml/CAJZ5v0hLYWKX__oZdcCY0D20pNqpw8SkiTPOCNOtpqe--QLp4Q@mail.gmail.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/acpi/sbshc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index 53c2862c4c75..5c021c3b81d9 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -231,7 +231,6 @@ static int smbus_alarm(void *context)
 		case ACPI_SBS_BATTERY:
 			acpi_os_execute(OSL_NOTIFY_HANDLER,
 					acpi_smbus_callback, hc);
-		default:;
 	}
 	mutex_unlock(&hc->lock);
 	return 0;
-- 
2.27.0

