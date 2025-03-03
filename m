Return-Path: <linux-acpi+bounces-11703-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF0BA4BCFA
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 11:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9D73B19FE
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 10:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84991F4601;
	Mon,  3 Mar 2025 10:53:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874B91F37C3;
	Mon,  3 Mar 2025 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999210; cv=none; b=Gd6M8mEkMe78rr51JFmg0YLP773KvBhDnErhsW5tM5FFA3XAVjur2r2cqZBalzx/T3hIXEFhMLgACGxFuUIC34Byln7IV+m7z7myRvPGYui8tupXN7Ta536SzFqvCakdcqlgiKUaVVZZn1xAts+o22vaa/FAeW+b1ZeMHch9LJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999210; c=relaxed/simple;
	bh=ya1Jrm60aOw5PBdsWiepbv15t4GIYWfri5Jp+tE1yVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UJtAlIcXgCqayj4jWi1zlplWKwcMsVd5bwlyONajEg5Vz87BaL8GMg3CC+GjziX0dfKHslMVKI7y7iMyQadZuISPe1qdl/woPLrXDRvFXqbDQr4s6h9SutSiC9fqmkt9X30BKpULK0vOX10srv4VUGa5DkYW+cXwGBMa4Ra5RW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC83B1FCD;
	Mon,  3 Mar 2025 02:53:41 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CB103F673;
	Mon,  3 Mar 2025 02:53:26 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 03 Mar 2025 10:51:37 +0000
Subject: [PATCH 02/14] mailbox: pcc: Always clear the platform ack
 interrupt first
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-pcc_fixes_updates-v1-2-3b44f3d134b1@arm.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3887; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=ya1Jrm60aOw5PBdsWiepbv15t4GIYWfri5Jp+tE1yVE=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBnxYohPuaxjsJrjuOasFqvT0SAC+ARa0woaE+BG
 a4mOM2fsSyJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ8WKIQAKCRAAQbq8MX7i
 mNaJD/wJbb2JBJ0hwZzY9nejOrjiXz2YuNZ/CKbx5JlK20WUwgaNVKxawpc90uGXtkIDfBdiXRB
 MzALhafutliezmH+l+OATG6g4HCCKGK1nUXWFkE6jOYTTLiwDDL8nOcB4iDXk48DFavpm/LbcPP
 rL5xw7wIQ+2XqNC5RKr0sj2kcwMn3gCS8CsI1lYXFUpFUxJkRXDNqv1VBjemyPSWGjFqfnx30od
 Iiob+ui1z2pLfUtES9Kbs1mOBw1oe0Xf6RK250RT9XIeBi+H53N7QzSOuUpuPa7NxCanThdrphC
 TsTC/V73nbhRkY/2Q15xo4462fj56BnsLOexbpP0uDafX2rM3hIBb6hUShWNC3e9yGmV0JTiDQT
 K4lRI6J8yaXUAfiiE+BW97I7plht5loUhzNan/3ie2jkQOwsbDLgmApCtBWEatLoZhd9pmPwC48
 zwyWFQRsCvmRkSnNgDeWGA6kmte1EFWO3NysGkDUN8zevUt0ws6dqfg5Mg7FGV05hhowetZhIn0
 ZMc+Ika9t0Tbr4inLFL6XmLTwZvniQT1kQYeCUFZYzweqnzO4ROpeRcPD4wDMzL27Y+XgbT0++o
 P+xW5V4o7Uic1P0TW/oQgLAmU3qjGHkuIUCV4y0DlscLzYD9jV8qAr2aOCU59KP1UWX0WNYOSj7
 OGl3VUotqBe51sw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The PCC mailbox interrupt handler (pcc_mbox_irq()) currently checks
for command completion flags and any error status before clearing the
interrupt.

The below sequence highlights an issue in the handling of PCC mailbox
interrupts, specifically when dealing with doorbell notifications and
acknowledgment between the OSPM and the platform where type3 and type4
channels are sharing the interrupt.

        Platform Firmware              OSPM/Linux PCC driver
------------------------------------------------------------------------
                                     build message in shmem
                                     ring type3 channel doorbell
receives the doorbell interrupt
  process the message from OSPM
  build response for the message
ring the platform ack interrupt to OSPM
				--->
build notification in type4 channel
                                     start processing in pcc_mbox_irq()
                                      enter pcc handler for type4 chan
                                         command complete cleared
			        	 read the notification
                                <---     clear platform ack irq
  		* no effect from above as platform ack irq *
		* not yet triggered on this channel *
ring the platform ack irq on type4 channel
				--->
                                      leave pcc handler for type4 chan
                                      enter pcc handler for type3 chan
                                         command complete set
					 read the response
                                <---     clear platform ack irq
                                      leave pcc handler for type3 chan
                                     leave pcc_mbox_irq() handler
                                     start processing in pcc_mbox_irq()
                                      enter pcc handler for type4 chan
                                      leave pcc handler for type4 chan
                                      enter pcc handler for type3 chan
                                      leave pcc handler for type3 chan
                                     leave pcc_mbox_irq() handler

The key issue occurs when OSPM tries to acknowledge platform ack
interrupt for a notification which is ready to be read and processed
but the interrupt itself is not yet triggered by the platform.

This ineffective acknowledgment leads to an issue later in time where
the interrupt remains pending as we exit the interrupt handler without
clearing the platform ack interrupt as there is no pending response or
notification. The interrupt acknowledgment order is incorrect.

To resolve this issue, the platform acknowledgment interrupt should
always be cleared before processing the interrupt for any notifications
or response.

Reported-by: Robbie King <robbiek@xsightlabs.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index f2e4087281c70eeb5b9b33371596613a371dff4f..4c582fa2b8bf4c9a9368dba8220f567555dba963 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -313,6 +313,10 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	int ret;
 
 	pchan = chan->con_priv;
+
+	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
+		return IRQ_NONE;
+
 	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
 	    !pchan->chan_in_use)
 		return IRQ_NONE;
@@ -330,9 +334,6 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 		return IRQ_NONE;
 	}
 
-	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
-		return IRQ_NONE;
-
 	/*
 	 * Clear this flag immediately after updating interrupt ack register
 	 * to avoid possible race in updatation of the flag from

-- 
2.34.1


