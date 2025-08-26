Return-Path: <linux-acpi+bounces-16063-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B45B3520E
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Aug 2025 05:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BBE165BE2
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Aug 2025 03:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B882C325B;
	Tue, 26 Aug 2025 03:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="tKFXWwIE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D947C163;
	Tue, 26 Aug 2025 03:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756177673; cv=none; b=nWb9I/bztjEKL95OjVI9GtLuymSVQcMfrmw0cGvZaRHC7jgd9VeRVB17A0s/SwzHqsHDZhYItsdeEeLbh35gA0cui5SKcfcydwdSEYto0Zr+m5AASnrDX20GIgbO0D9dT7SXKMT9BrWRrtgDMVQPNeFYPkrtlGPFox4Ilfabzak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756177673; c=relaxed/simple;
	bh=gkF7h4EW9M+ZZCmq95GdTkH2Hh4i5+Q4z9JSUPWvlJU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=DfBml++qY91IPXTsbOtPcMK6TwsoZehLsNkuOl5l0UljE8DF5Fz7+dwA/OC8NIBXXrFZD+PJ2hQV5Fz9fbLY1C7UAAyX/OUee/6UjAsweUqoQuljtq50hy9wYRP/gac3lb3s9gR73f5B2QrRtUtwHS+ibRcunQ6sWBk9ydtVRjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=tKFXWwIE; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756177355;
	bh=L6vibiH8O0qLbC6fD+xvRz4j6mizRgH8G8UJ1+HY44E=;
	h=From:To:Cc:Subject:Date;
	b=tKFXWwIE7Tg6w89vHE8cjQgBTGgeQK3cTXGmc2mHj6Fx8wUNncOKZTQHJPXU3mO2r
	 jr2ImbiSbyikW4gnXzC2CimCULSTxfYsUe7S98TPHCpaZ2fXDv22FJekXqkvdHRVos
	 SU9Pu/X+agUam4Xxbu2Dq7+yYJdGlQmPoHcFvdJQ=
Received: from dcitdc.dci.com ([61.220.30.51])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id A1BACAF; Tue, 26 Aug 2025 11:02:33 +0800
X-QQ-mid: xmsmtpt1756177353t0r09wndo
Message-ID: <tencent_0FBB187910C3E168E5C9468DDF6764C94308@qq.com>
X-QQ-XMAILINFO: MqswyhUqVe0CGAD9S6uNOrfJhZmCZ2RVEiu14klpymAMSbyt9d1Qr8CPsKiJLX
	 kFZ/13IevebNP1cRPfy6HheOFLjysSy1z+XKWGhDPxOcvzALH07aZp67mwuvAaZ/5GcyWf2aZdwB
	 Prny5md4HsveW59oNstduLYhPxMPBzoB7ilnbhRPpgnMRr/uQP4kIZQCEKIG3MEzZzeUqEJUcuuB
	 nQgtbnzgx9uYC5bJmG0yw5S8dEvtHxdkKUIJigkcjR+RHUFV6/FPCYOnONyq8GDc9NGbmo5CO2Yb
	 /7i6T97N50dbV1/MElWacbwcBXOoPn7BCnAxJczNyPT+6x3W46uRRogr2vcigwipPzOvxAuhu+mq
	 n/WfgZ7Rl0XrROgriYA3j+pbBXMHxsZ3wuo1hna9J9qBXFUHJPVa/OLH8M84Ljtm245A7dB3Np1/
	 56vfgw60t5G4nZnXNcpMz23XZtKYv2Mm1GfMQN/B/UziM3o1XcBy4tdO5cX3wmr6XSt2bpMNzxV2
	 iwa5MDxQXM6wENWFVrfN8yvK6Dopu3WNiaBgFShbBN66nLlE8jZ+JF06P6QRgvDQanEL1Q9tu69Z
	 KPSXeNuTEuqGrxoIVplLAJMdKdMoq8pHLmG41tKChLV1fvHjp5VnJcRUnuDK6ACs/YTWZPq0d8bR
	 03JcmYEvLSM0euFBpDBnjFw11TclZQMz5lLls5qHkj8C+C0YQCad8Nw8G9pFPa3+NpGiZJZYC90v
	 kyqZQ0tvDnf7dnSgV2Vu2jQuifT8ZX/AVLNkWcJzrItHDz/WnY9JKVeu7FuJ6zR/kPF4xoSJowU2
	 FRYmSiL8hIOEsBGaT4Aza6Wj3MoC5h+HEWN5LbLzJ3Rz7EYlVxjgnTUZNjk1rSzdVNVMfIVQWtds
	 QB27jOsOjkKyV5roHa/oPTxu3y94kl6kros/JRskcupSddQ4gVA4RZYBR6p2f4a/RBk/wsCDxj3O
	 XGXCuMu0zYveJPYi4nbTV7OF7osIzEMbcIcWZTvUND8Z9Gw3oPx8SZC/79fHx2rM4guGV2FU0=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: "Shang song (Lenovo)" <shangsong2@foxmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shangsong2@lenovo.com,
	"Shang song (Lenovo)" <shangsong2@foxmail.com>
Subject: [PATCH v2 1/1] ACPI: PRM: Optimize the judgment logic for the PRM handler_address
Date: Mon, 25 Aug 2025 23:02:29 -0400
X-OQ-MSGID: <20250826030229.834901-1-shangsong2@foxmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the handler_address or mapped VA is NULL, the related buffer
address and VA can be ignored.

Signed-off-by: Shang song (Lenovo) <shangsong2@foxmail.com>

Changes in v2: Demote pr_err to pr_info for incorrect handler_address.
---
 drivers/acpi/prmt.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index be033bbb126a..6792d4385eee 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -150,15 +150,28 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 		th = &tm->handlers[cur_handler];
 
 		guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
+
+		/*
+		 * Print an error message if handler_address is NULL, the parse of VA also
+		 * can be skipped.
+		 */
+		if (unlikely(!handler_info->handler_address)) {
+			pr_info("Skipping handler with NULL address for GUID: %pUL",
+					(guid_t *)handler_info->handler_guid);
+			continue;
+		}
+
 		th->handler_addr =
 			(void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
 		/*
-		 * Print a warning message if handler_addr is zero which is not expected to
-		 * ever happen.
+		 * Print a warning message and skip the parse of VA if handler_addr is zero
+		 * which is not expected to ever happen.
 		 */
-		if (unlikely(!th->handler_addr))
+		if (unlikely(!th->handler_addr)) {
 			pr_warn("Failed to find VA of handler for GUID: %pUL, PA: 0x%llx",
 				&th->guid, handler_info->handler_address);
+			continue;
+		}
 
 		th->static_data_buffer_addr =
 			efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address);
-- 
2.43.7


