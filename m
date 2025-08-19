Return-Path: <linux-acpi+bounces-15819-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EB8B2B6F5
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 04:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BFC1B65BE0
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 02:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47852877F2;
	Tue, 19 Aug 2025 02:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="JFr1pyk0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7BC287255;
	Tue, 19 Aug 2025 02:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755570527; cv=none; b=B3QPUZuijtLzHwDN/WjSRKJr/0hGY6zztljyv4c10Au3mL5S5VqnmI6hYayrCq2yFwmS9sbaOLvcKkDkuiug+0cLSFjWKvUO3jypotJkfOxA9X0UG5vi84DsoFhox9d5Sp1guYve80wx8GNNwytjEsADsQcWcQwdp5xU00DWVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755570527; c=relaxed/simple;
	bh=V0hYaE+qOOX1SupyN/Jo9sTCtbPMsO6FAy5xOjj4x4E=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=nIscx9LKFloUExD9pgwuVVQVeLeid9ekbETtT8o9fzu18HOgwDZazfyN5AM1uaN7PdSMXsiaGZEHQ2Zj+j1sMX6tPnI8tJYwxVyjQ2hy98zqKDAO/tbpRUfW9sBMlSeBgb344TRs8SePJcHGJknhlEZSWh490tLTRMbgb5h7/20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=JFr1pyk0; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1755570211;
	bh=I9jwF3U/3TF0HHqF00LD8/+hy3W7jKP3LjzMxS9zQLU=;
	h=From:To:Cc:Subject:Date;
	b=JFr1pyk0JXSPqfkRiKycFT5HKiBdncMX56P/wI8/dA/rSTOU9ueV9RyL2ZYFbTVY2
	 mbLia4shydj7BTGN+t3Lz9Cjkp3Q2ALyG4FPOjceIH0LCsypJy9TQbR0Vugc4kQ5GE
	 eYZbSy+PpRer5rltRajcOJWzI0au0AkERqSbHvY8=
Received: from dcitdc.dci.com ([61.220.30.51])
	by newxmesmtplogicsvrszc13-1.qq.com (NewEsmtp) with SMTP
	id 5DD2F6BE; Tue, 19 Aug 2025 10:23:29 +0800
X-QQ-mid: xmsmtpt1755570209tcp0yk6h0
Message-ID: <tencent_FEF72BEF631815ED2479A6D1E32C34797B05@qq.com>
X-QQ-XMAILINFO: MeukCuWaRbQldVUouuoB3Bo6oRjab2DIaPusipPOyV3Z2603xHQkMdZ7dVGKgN
	 gCoTuhEq1jY2N6OhQvNCOLKlLTsBL9sV0HhxPs5tIQcJ5U20KNx1GfWPLJSFNaB5p9ac5XYO2XQS
	 azJ4rxb2xrHB3TEyK53lYeE4Qu43godMg9RKQ2/uk9lgY4GcT1QtWNRI54cbUQ5Iuosx7niwu3hQ
	 1/n9x/JsVZQy2DAFXzwyeR2cwtvV0qxNAMcRTvin2nP41GPikp3PaEYHs4RAE3AuveSu/YwzUfqd
	 hd1H4JNOobxPMOaun5AnlIrP4bQFO6tT9oVL72mpjxJVIEz3xsJXda3CGmqmdh+AGaVP773RR5mm
	 59wtOz/fq3L3nRG+2UNcDG39wMh+HWEWiLtPYB/ICcyzfY3m9zuWf6jOFwaWoCFeKHHIS4mKddww
	 l6WhxzQBI2Y6f1MtkT8Tt+Nq2QlosfzG6/4YuUgcDCvMrtF9VvzAsSovU65sSkTcDn5AO/4n+K25
	 Ne6EtlXGDz/HJgt0Ji4hTx9B8QFtK2S/bsZ1uDfbrEEaQzfa+WNW0bbQ1cW6adSSXujLI8HFZSTf
	 aRLJIPwFq/H9R6fSwIVtNrO9PLW1ah29rh5fe3a4PYsH3bEJj3GvRn3ZZznFhUK33keQEtkseAbc
	 1FY1lD7vrb0s75REbWVvQM3Wsp3KwWLG9Ks7ICmFeFWCpDFh8XJYLaxNtz7RcwXbBoT95/Ly7AQm
	 0kqtcR80L5uKsGTkNgpgXwzNfFB3oDo3exFbw69oMa+tLheY5Unmed60W0oJzhFI+x01Mb8WrxSI
	 /YDo8djaTbH+UBWQfuMu9a77Tul2Q783zCJoEqDMheQ98rMnX4Shu3cWcWYhLDhnZoj1NshXCc1t
	 1nlHi9uHIz+ysiI+EOgTPU+0auhCqs9TR9Dv73/S2YotuoJrrLSKiMDZUjPse9hccmjWw4GW6K35
	 z/QWHNXmg4pyUXoros4SnpQL+VgQ9l
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: shangsong <shangsong2@foxmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shangsong2@lenovo.com
Subject: [PATCH] ACPI: PRM: Optimize the judgment logic for the PRM handler_address
Date: Mon, 18 Aug 2025 22:23:23 -0400
X-OQ-MSGID: <20250819022323.2645114-1-shangsong2@foxmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shang song (Lenovo) <shangsong2@lenovo.com>

If the handler_address or mapped VA is NULL, the related buffer
address and VA can be ignored.

Signed-off-by: Shang song <shangsong2@lenovo.com>
---
 drivers/acpi/prmt.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index be033bbb126a..3a501fcd78df 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -150,15 +150,28 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 		th = &tm->handlers[cur_handler];
 
 		guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
+
+		/*
+		 * Print a error message if handler_address is NULL, the parse of VA also
+		 * can be skipped.
+		 */
+		if (unlikely(!handler_info->handler_address)) {
+			pr_err("Skipping handler with NULL address for GUID: %pUL",
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


