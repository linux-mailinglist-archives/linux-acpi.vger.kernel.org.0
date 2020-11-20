Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2A72BB362
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Nov 2020 19:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbgKTSdb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Nov 2020 13:33:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730783AbgKTSd3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Nov 2020 13:33:29 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02D2024137;
        Fri, 20 Nov 2020 18:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897208;
        bh=Y/SW4fSb8hqvWLr6oWohkVuArtd8npF3Mc4PlKDMw3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RrsBf8O6VzydT9NVVgkN6IRwJiqT7/e+hIVczyIfmdsj4x03Qg2fc3T8VeoV8b2aI
         elwST2HMqrzzYGTthp61DK+O4KkMNhMdJz6Yvk9KjjRpXWtF+EK8A8/ks+Ffc+++TF
         g93/sFkcRF+Azfwl3H20voPgJ5D1CofXA6wDlHhE=
Date:   Fri, 20 Nov 2020 12:33:34 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 064/141] ACPI: Fix fall-through warnings for Clang
Message-ID: <1e081610a68043fe89ca5a2795963cbee6d5fc0f.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/acpi/sbshc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index 53c2862c4c75..0b3de0e63633 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -231,6 +231,7 @@ static int smbus_alarm(void *context)
 		case ACPI_SBS_BATTERY:
 			acpi_os_execute(OSL_NOTIFY_HANDLER,
 					acpi_smbus_callback, hc);
+			break;
 		default:;
 	}
 	mutex_unlock(&hc->lock);
-- 
2.27.0

