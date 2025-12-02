Return-Path: <linux-acpi+bounces-19378-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8764C9B09C
	for <lists+linux-acpi@lfdr.de>; Tue, 02 Dec 2025 11:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1A83A467A
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Dec 2025 10:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6464830C371;
	Tue,  2 Dec 2025 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipearl.com header.i=@sipearl.com header.b="lw2oEANf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout.sipearl.com (smtpout.sipearl.com [178.170.11.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2152F617C;
	Tue,  2 Dec 2025 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.170.11.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670399; cv=none; b=Gg6T+FwdGvaWlrVKqNQON/EQez7EMN0zYMrP+/e3xnujodH7mD5GXioDnTalORLmKu8K1aId68T2cJOKd/1/XPF8HpHDoWRyRSUSSvm3S4D9vJ5ye+JuKZC02hE5XYLaFTCB1+sSnpA6wDEyIGFIR7as9Ctj1sivgov00IgM5Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670399; c=relaxed/simple;
	bh=9nkH54PAXzYHl0h9y3ugydi7vZyKYWS+PMfq77NKzaw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5dVoLGV48Me8s/sF/Z5pVetcS8hdgOtSXXOIUZIfeg7SCqQSPc5HywR1jg0qvW7d9SkKfaYG2bbNvyafo7LRceUYPSYsxRPJoSTDm8iWE9S6YJJh5BZBhmyawlJxWhYlj7K0GlmaHdM5I/T+ZlzlVEf9dLHsfy0MgndnbMpeqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipearl.com; spf=pass smtp.mailfrom=sipearl.com; dkim=pass (2048-bit key) header.d=sipearl.com header.i=@sipearl.com header.b=lw2oEANf; arc=none smtp.client-ip=178.170.11.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipearl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipearl.com
Received: from smtpout.sipearl.com ([172.31.29.1])
	by smtpin.sipearl.com  with ESMTPS id 5B2ACsfS007514-5B2ACsfU007514
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Dec 2025 11:12:54 +0100
Received: from dc2pvlnosz001.pub.int.sipearl.com (172.31.65.18) by
 dc2pvwexcz001.sipearl.corp (172.31.29.1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Tue, 2 Dec 2025 11:12:49 +0100
From: Andrea Tomassetti <andrea.tomassetti@sipearl.com>
To: <sudeep.holla@arm.com>
CC: <andrea.tomassetti@sipearl.com>, <jassisinghbrar@gmail.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lkp@intel.com>,
	<oe-kbuild-all@lists.linux.dev>, <olivier.dautricourt@sipearl.com>,
	<olivierdautricourt@gmail.com>, <rafael@kernel.org>,
	<thibault.cantori@sipearl.com>
Subject: [PATCH v3 2/2] mailbox: pcc: add peek_data handler
Date: Tue, 2 Dec 2025 11:12:15 +0100
Message-ID: <20251202101215.2240024-2-andrea.tomassetti@sipearl.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251127-lovely-real-wrasse-b1fbcd@sudeepholla>
References: <20251127-lovely-real-wrasse-b1fbcd@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dc2pvwexcz001.sipearl.corp (172.31.29.1) To
 dc2pvwexcz001.sipearl.corp (172.31.29.1)
X-FEAS-Client-IP: 172.31.29.1
X-FE-Policy-ID: 2:2:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=sipearl.com; s=sipearl2024; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=8znZMcO+NATS6ahvvZhHgXD6UI5V0auQ7qYQlyQDCjY=;
 b=lw2oEANfvcPu2LagtjfG3LUZWYGzIY/9Ug2SHJZgf3f3588gnmDDQtu5x1tBukt8Z7DRy/JTL2Q/
	7wccEbifN4UgYw8L7K7O3/RKBWxjc8EtOcduciOVeblPC4InsCAjw5Og2thKbB9f0gQr5YpzfwhJ
	mNzZivKOJj5CAsyuTAXbZIUb+wqnZ5VZ4d4iXxJ4WfFtDErPtj/VFKHkUhlSwKmT8FzlhszbP6Yk
	MgXhXsSGqKUAQ3z2wGYQ9zFfkpl8hjwcwGHUpAk0HEKI2eJzkjmQRkf5Oks3uUaHtnZi/OHPwkuV
	2NjxCFATYU5YScqKqgLEo/GIx3oME5NOfVMprw==

peek_data is mapped to pcc_mbox_error_check_and_clear, so that it
returns true if no error occurred while the platform processed last
message, and therefore clients can fetch response data provided by the
platform.

Tested-by: Thibault Cantori <thibault.cantori@sipearl.com>
Co-developed-by: Olivier Dautricourt <olivier.dautricourt@sipearl.com>
Signed-off-by: Olivier Dautricourt <olivier.dautricourt@sipearl.com>
Signed-off-by: Andrea Tomassetti <andrea.tomassetti@sipearl.com>
---
 drivers/mailbox/pcc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 418007020439..ccd50b33409b 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -502,11 +502,17 @@ static void pcc_shutdown(struct mbox_chan *chan)
 		devm_free_irq(chan->mbox->dev, pchan->plat_irq, chan);
 }
 
+static bool pcc_peek_data(struct mbox_chan *chan)
+{
+	return pcc_mbox_error_check_and_clear(chan->con_priv) == 0;
+}
+
 static const struct mbox_chan_ops pcc_chan_ops = {
 	.send_data = pcc_send_data,
 	.startup = pcc_startup,
 	.shutdown = pcc_shutdown,
 	.last_tx_done = pcc_last_tx_done,
+	.peek_data = pcc_peek_data,
 };
 
 /**
-- 
2.51.2


