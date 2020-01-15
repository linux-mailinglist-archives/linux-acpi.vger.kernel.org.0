Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C64D13D0A6
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2020 00:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgAOX0m (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jan 2020 18:26:42 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:30816 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgAOX0m (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jan 2020 18:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1579130802; x=1610666802;
  h=date:from:to:subject:message-id:mime-version;
  bh=EmH9ZrC0td+WgzEilmoS02AeN+pe+PPCZem5cu228xc=;
  b=PL7SuMpkBO9Ue83oDuRCQBUS4kM4I6DFr1Fl33pM2/dFC6ApjYG/ql4q
   1NDBu/X8egMtg+2sXFHojq8AaKZ3zECgf9yibkYigiuEXgWdNPBh7G6u0
   LP7UZQuOpa6kPPfSOItpEuWunVwdPylHPmBRhJgMcRmKIxkHZv4FNbA5w
   0=;
IronPort-SDR: 6UBEafvcAbyy2TW/DwD5jdhfg/fTiPJx5sBU6Ks71NfBsl62rY+75PYUl1lABj4lSJzQMv8E5e
 fqgHTyHuyoRw==
X-IronPort-AV: E=Sophos;i="5.70,323,1574121600"; 
   d="scan'208";a="20354096"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 15 Jan 2020 23:26:30 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id BC62FA1C66;
        Wed, 15 Jan 2020 23:26:29 +0000 (UTC)
Received: from EX13D07UWB002.ant.amazon.com (10.43.161.131) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 15 Jan 2020 23:26:29 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D07UWB002.ant.amazon.com (10.43.161.131) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 15 Jan 2020 23:26:28 +0000
Received: from dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com
 (172.22.96.68) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 15 Jan 2020 23:26:28 +0000
Received: by dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com (Postfix, from userid 4335130)
        id 087CF40E7E; Wed, 15 Jan 2020 23:26:29 +0000 (UTC)
Date:   Wed, 15 Jan 2020 23:26:29 +0000
From:   Anchal Agarwal <anchalag@amazon.com>
To:     <robert.moore@intel.com>, <rafael.j.wysocki@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lenb@kernel.org>, <devel@acpica.org>, <erik.kaneda@intel.com>,
        <sblbir@amazon.com>, <fllinden@amazon.com>, <anchalag@amazon.com>
Subject: [RESEND PATCH] ACPICA: Enable sleep button on ACPI legacy wake
Message-ID: <20200115232629.GA9231@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
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
