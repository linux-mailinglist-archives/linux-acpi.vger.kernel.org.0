Return-Path: <linux-acpi+bounces-13111-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F80AA9367B
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Apr 2025 13:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F40416992D
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Apr 2025 11:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63132275840;
	Fri, 18 Apr 2025 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="ysCg+gDi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E822749E7;
	Fri, 18 Apr 2025 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744975387; cv=none; b=L9VzZpTg1msrEeS1K+R4clwe6z+E+ZRd/77bTqrH35eRapnyNSGrYUkKavGy+oIU7/yT/TMlUXp4rOKK9L/6GIX/f8IpfbyjPXk5kas9eXJ3xB26nCsbWzJY/deOHfDIrVylna+GdJ3y6akxORZFRcJ7aDAkba4uffNvRVbOAKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744975387; c=relaxed/simple;
	bh=XugppIIAJO9PkEAXCDE1zf/7oX/SgdA4rqZh/Cbb2oE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rj4ix7iSbEi8IuG1L0eoZDLAXtevkNTFPT2IfjC8n0ZB2Mqzpddjp1ixe1OIyhIgJD6sxwSDCG6mZIECnL354oBjL1dWrwHwkIZ/SrDQF43PkVz5SNKYwtznCv7lzBTTg4IoQNXniS95ZPMRK9UKPksNDqD8KUpe5PVft9gbCSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=ysCg+gDi; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.155])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 5022E20076;
	Fri, 18 Apr 2025 11:22:57 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay4.mymailcheap.com (Postfix) with ESMTPS id 470FD2012A;
	Fri, 18 Apr 2025 11:22:49 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id BB8BB400F2;
	Fri, 18 Apr 2025 11:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1744975366; bh=XugppIIAJO9PkEAXCDE1zf/7oX/SgdA4rqZh/Cbb2oE=;
	h=From:To:Cc:Subject:Date:From;
	b=ysCg+gDi0HY22e+jhMxa5iReSpbDDeR/QPiEz3mmOctnS67uNcSf6IohFYCM8uvBr
	 LfBF0YaBVEsTxaL0G4Vz41pSy/S15+sp3J4jOtjIV2bCtyb3me6xuyLL97Eckw3HGl
	 it50ZczlJLCDXoD/Bnud391KyjyFjaHTU9uSJ/D0=
Received: from hrh-ofice.wok.cipunited.com (unknown [60.247.127.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id CD13C406FC;
	Fri, 18 Apr 2025 11:22:41 +0000 (UTC)
From: Runhua He <hua@aosc.io>
To: linux-kernel@vger.kernel.org
Cc: Kexy Biscuit <kexybiscuit@aosc.io>,
	Runhua He <hua@aosc.io>,
	Mingcong Bai <jeffbai@aosc.io>,
	Yemu Lu <prcups@krgm.moe>,
	Xinhui Yang <cyan@cyano.uk>,
	Rong Zhang <i@rong.moe>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [RFC PATCH] ACPI: EC: Set ec_no_wakeup for MECHREVO Wujie 14XA (GX4HRXL)
Date: Fri, 18 Apr 2025 19:22:27 +0800
Message-ID: <20250418112229.93075-1-hua@aosc.io>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BB8BB400F2
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [1.40 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[jeffbai.aosc.io:server fail,hua.aosc.io:server fail,cyan.cyano.uk:server fail,i.rong.moe:server fail,prcups.krgm.moe:server fail];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action

MECHREVO Wujie 14XA (GX4HRXL) wakes up immediately after s2idle entry.
This happens regardless of whether the laptop is plugged into AC power, or
whether any peripheral is plugged into the laptop.

Using `amd_s2idle.py --debug-ec', we found that the laptop has a wakeup
event triggered by IRQ 1 (PS/2 Controller) and IRQ 9 (ACPI SCI), and was
eventually woken up by IRQ 9. Taking a look at `dmesg', we found that the
EC was quite chatty after s2idle entry:

[ 1842.317151] PM: suspend-to-idle
[ 1842.317178] ACPI: EC: ACPI EC GPE status set
[ 1842.317184] ACPI: EC: IRQ (5)
[ 1842.317190] ACPI: EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
[ 1842.317196] ACPI: EC: Polling enabled
[ 1842.317198] ACPI: EC: Command(QR_EC) submitted/blocked
[ 1842.317202] ACPI: EC: ACPI EC GPE dispatched
[ 1842.317248] ACPI: EC: Event started
[ 1842.317259] ACPI: EC: 2: Increase command
[ 1842.317264] ACPI: EC: Command(QR_EC) started
[ 1842.317271] ACPI: EC: TASK (14)
[ 1842.317288] ACPI: EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
[ 1842.317294] ACPI: EC: EC_SC(W) = 0x84
[ 1842.317303] ACPI: EC: TASK (14)
[ 1842.317324] ACPI: EC: EC_SC(R) = 0x2a SCI_EVT=1 BURST=0 CMD=1 IBF=1 OBF=0
[ 1842.317329] ACPI: EC: TASK (14)
[ 1842.317336] ACPI: EC: EC_SC(R) = 0x2a SCI_EVT=1 BURST=0 CMD=1 IBF=1 OBF=0

[...]

[ 1842.317399] ACPI: EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
[ 1842.317405] ACPI: EC: TASK (14)
[ 1842.317412] ACPI: EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
[ 1842.317418] ACPI: EC: TASK (14)
[ 1842.317425] ACPI: EC: EC_SC(R) = 0x29 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=1
[ 1842.317432] ACPI: EC: EC_DATA(R) = 0x7b
[ 1842.317436] ACPI: EC: Command(QR_EC) unblocked
[ 1842.317445] ACPI: EC: Polling quirk
[ 1842.317448] ACPI: EC: TASK (14)
[ 1842.317455] ACPI: EC: EC_SC(R) = 0x28 SCI_EVT=1 BURST=0 CMD=1 IBF=0 OBF=0
[ 1842.317463] ACPI: EC: Polling enabled
[ 1842.317466] ACPI: EC: Command(QR_EC) submitted/blocked
[ 1842.317469] ACPI: EC: Polling disabled
[ 1842.317472] ACPI: EC: Command(QR_EC) completed by hardware
[ 1842.317476] ACPI: EC: Command(QR_EC) stopped
[ 1842.317480] ACPI: EC: 1: Decrease command
[ 1842.317484] ACPI: EC: Query(0x7b) scheduled
[ 1842.317495] ACPI: EC: 2: Increase command
[ 1842.317499] ACPI: EC: Command(QR_EC) started
[ 1842.317504] ACPI: EC: TASK (14)
[ 1842.317516] ACPI: EC: EC_SC(R) = 0x08 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=0
[ 1842.317521] ACPI: EC: EC_SC(W) = 0x84
[ 1842.317529] ACPI: EC: TASK (14)
[ 1842.317537] ACPI: EC: EC_SC(R) = 0x0a SCI_EVT=0 BURST=0 CMD=1 IBF=1 OBF=0
[ 1842.317543] ACPI: EC: TASK (14)
[ 1842.317550] ACPI: EC: EC_SC(R) = 0x0a SCI_EVT=0 BURST=0 CMD=1 IBF=1 OBF=0
[ 1842.317555] ACPI: EC: TASK (14)

[...]

[ 1842.317638] ACPI: EC: EC_SC(R) = 0x08 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=0
[ 1842.317643] ACPI: EC: TASK (14)
[ 1842.317650] ACPI: EC: EC_SC(R) = 0x08 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=0
[ 1842.317656] ACPI: EC: TASK (14)
[ 1842.317663] ACPI: EC: EC_SC(R) = 0x09 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=1
[ 1842.317670] ACPI: EC: EC_DATA(R) = 0x00
[ 1842.317674] ACPI: EC: Command(QR_EC) unblocked
[ 1842.317682] ACPI: EC: Polling quirk
[ 1842.317685] ACPI: EC: TASK (14)
[ 1842.317692] ACPI: EC: EC_SC(R) = 0x08 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=0
[ 1842.317697] ACPI: EC: Polling disabled
[ 1842.317700] ACPI: EC: Command(QR_EC) completed by hardware
[ 1842.317704] ACPI: EC: Command(QR_EC) stopped
[ 1842.317707] ACPI: EC: 1: Decrease command
[ 1842.317711] ACPI: EC: Event stopped
[ 1842.317723] ACPI: EC: Query(0x7b) started
[ 1842.318142] ACPI: EC: Query(0x7b) stopped
[ 1842.318150] ACPI: EC: ACPI EC work flushed
[ 1842.318158] ACPI: PM: Rearming ACPI SCI for wakeup
[ 1842.318169] amd_pmc: SMU idlemask s0i3: 0x1ffb3ebd
[ 1842.318193] PM: Triggering wakeup from IRQ 9
[ 1842.318244] ACPI: EC: ACPI EC GPE status set
[ 1842.318249] ACPI: EC: IRQ (5)
[ 1842.318254] ACPI: EC: EC_SC(R) = 0x08 SCI_EVT=0 BURST=0 CMD=1 IBF=0 OBF=0
[ 1842.318263] ACPI: PM: Rearming ACPI SCI for wakeup

I'm not quite sure what the EC was during this time. As
`acpi.ec_no_wakeup=1' works around this issue, I believe that the EC had
for some reason caused the system to wake up.

Browsing the source code, I found that in `drivers/acpi/ec.c',
`struct dmi_system_id acpi_ec_no_wakeup[]' records a few machines with
incorrect suspend behaviors caused by EC wakeup.

As this struct corresponds to a series of machines that needs
`acpi.ec_no_wakeup' enabled by default, add GX4HRXL to this struct. Note
that I have only matched the motherboard model, as MECHREVO is a "white
label" manufacturer using commonly used chassis and motherboards - GX4HRXL
may be found in a variety of laptops sold under different brands and model
names.

Since the reason behind this EC wakeup is not yet clear to me, I'm sending
this patch in hope of getting more comments and guidance on how to further
debug this issue.

Suggested-by: Mingcong Bai <jeffbai@aosc.io>
Link: https://zhuanlan.zhihu.com/p/730538041
Tested-by: Yemu Lu <prcups@krgm.moe>
Co-developed-by: Xinhui Yang <cyan@cyano.uk>
Signed-off-by: Xinhui Yang <cyan@cyano.uk>
Co-developed-by: Rong Zhang <i@rong.moe>
Signed-off-by: Rong Zhang <i@rong.moe>
Signed-off-by: Runhua He <hua@aosc.io>
---
 drivers/acpi/ec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 3c5f34892..19f1d36a5 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2329,6 +2329,12 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
 		}
 	},
+	{
+		/* MECHREVO Wujie 14 Series (GX4HRXL) */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GX4HRXL"),
+		}
+	},
 	{ },
 };
 
-- 
2.49.0


