Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6709FECA33
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2019 22:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfKAVX7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Nov 2019 17:23:59 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:43864 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKAVX7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Nov 2019 17:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1572643439; x=1604179439;
  h=from:date:subject:message-id:to:mime-version;
  bh=vhUx5QxMEAQeh+HzNpXJMwmNNTlBGt0/JdKKj8rOIZE=;
  b=SKOnNhbMF5ksc8FWu0Zjir/jHb3cFGfHeH9tG3BYjpmj36pwP3mkDPMy
   Y4Fhwa3C+wFv8OjmjWdkcJq1Dyo9eMOpg9AmOZsR2s9LIxav/tBFhKce2
   e7calufuXHX7dj5huMnKqEKydI+B95WJ+A9mFoXu+sFh5URGFa/Ioj/mv
   Q=;
IronPort-SDR: UzESgKsnFarRIW3zjfHPoeKzuIaSYFZ2GpH5iihz5Dq+Xvcf3JbCFC47hQxEgKCE+79gBxMa4P
 O5D7TP5OvI1A==
X-IronPort-AV: E=Sophos;i="5.68,257,1569283200"; 
   d="scan'208";a="3180091"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 01 Nov 2019 21:23:24 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 0F70BA1BC3;
        Fri,  1 Nov 2019 21:23:20 +0000 (UTC)
Received: from EX13D07UWA003.ant.amazon.com (10.43.160.35) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 1 Nov 2019 21:23:20 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D07UWA003.ant.amazon.com (10.43.160.35) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 1 Nov 2019 21:23:19 +0000
Received: from dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com
 (172.22.96.68) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Fri, 1 Nov 2019 21:23:19 +0000
Received: by dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com (Postfix, from userid 4335130)
        id 1FFC440EB1; Fri,  1 Nov 2019 21:23:19 +0000 (UTC)
From:   Anchal Agarwal <anchalag@amazon.com>
Date:   Mon, 29 Oct 2018 17:52:16 +0000
Subject: [PATCH] ACPICA: Enable sleep button on ACPI legacy wake
Message-ID: <20191101212319.1FFC440EB1@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
To:     undisclosed-recipients:;
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently we do not see sleep_enable bit set after guest resumes
from hibernation. Hibernation is triggered in guest on receiving
a sleep trigger from the hypervisor(S4 state). We see that power
button is enabled on wake up from S4 state however sleep button
isn't. This causes subsequent invocation of sleep state to fail
in the guest. Any environment  going through acpi_hw_legacy_wake()
won't have sleep button enabled.

Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
Reviewed-by: Balbir Singh <sblbir@amazon.com>
Reviewed-by: Frank van der Linden <fllinden@amazon.com>
---
 drivers/acpi/acpica/hwsleep.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index b62db8ec446f..a176c7802760 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -300,6 +300,17 @@ acpi_status acpi_hw_legacy_wake(u8 sleep_state)
 				    [ACPI_EVENT_POWER_BUTTON].
 				    status_register_id, ACPI_CLEAR_STATUS);
 
+	/* Enable sleep button */
+	(void)
+	      acpi_write_bit_register(acpi_gbl_fixed_event_info
+				      [ACPI_EVENT_SLEEP_BUTTON].
+				      enable_register_id, ACPI_ENABLE_EVENT);
+
+	(void)
+	      acpi_write_bit_register(acpi_gbl_fixed_event_info
+				      [ACPI_EVENT_SLEEP_BUTTON].
+				      status_register_id, ACPI_CLEAR_STATUS);
+
 	acpi_hw_execute_sleep_method(METHOD_PATHNAME__SST, ACPI_SST_WORKING);
 	return_ACPI_STATUS(status);
 }
-- 
2.15.3.AMZN

