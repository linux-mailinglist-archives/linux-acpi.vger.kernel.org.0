Return-Path: <linux-acpi+bounces-15064-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B07AFC737
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 11:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035A35605F0
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 09:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE87256C8D;
	Tue,  8 Jul 2025 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="hV4XSOhk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED491EE03D;
	Tue,  8 Jul 2025 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967601; cv=none; b=cHrevwzKkEQx2/kXTwZ3/83PD5EGhp64yyLUo0w6nsNDzVMLo8U/jwmpj0ZehGC+0kKWRmXwRD8XDV5r7Gma0AoWFdnp3nD3fYu/0NRNJO/oOtFO7mzgNukNHiMkKN/wsYGX+T9YR+0GtIsmgUe7OFarIb78XgLTrVum2kQfWgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967601; c=relaxed/simple;
	bh=u7PNFRRuvaAuZJ0NtolVdmZY+LpdxtuLVkks7HD2h0k=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=M4UhkP3/yHQCYXECxCeHRzTN5GLb0OEj/BYbqi+yR536YgBuLwd6PK3ZaBKYOKZyEG7gzKdSqmQuMhlc+rLajczhW7+cJoUdBvI0tWdpcZ9JXHNUn9zJvZzOc1eVryA4pczpm2NPJax64f55TbYZkM+HzMUscxD27YaA36RFsMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=hV4XSOhk; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1751967591;
	bh=80RfFNsolAspBs0pCfqwxJdnYiu//WE8+0E2G617K/I=;
	h=From:To:Cc:Subject:Date;
	b=hV4XSOhkH9uYYRCC4tOU+U/Y7phtWqiGlW5lBNvHg1hOTrzOeEN2HH80IjIk2IR7t
	 OVE7r9cUKz/jNcm6cqFDWhzdsmVZ4zErhqbZu8HL7QaefPa23QZYtBELU8D6IrHzkn
	 g0pseIiUdjLCX+ZDzrcZXaHkYJwig1p77+XFEaMs=
Received: from dcitdc.dci.com ([61.220.30.51])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 9F21FEAB; Tue, 08 Jul 2025 17:39:50 +0800
X-QQ-mid: xmsmtpt1751967590txjr0nf9x
Message-ID: <tencent_3A33B864BD5DC73CBBE10CB481E4C546E107@qq.com>
X-QQ-XMAILINFO: MfXGqYrvPcUt3f//s55822JJOeXXUQkju/CQDVxpskk/1IwoAX0cTVjS8uOlGC
	 bYgz/LOxJxSo4Y4Welot8fhXzvOT6jr7yKsrj/0JypFLpTmCvFtW9kqjlCkaEZH6rBSD/niXOOn1
	 KPes1H9D382soorggQ07nGXuZJ65m9ih5aAOHoSnB0K8DqMVHhrMldt5m1oTRFJdPqF0DewDZSMO
	 3Hfizprq8btxi31zeoGv1dVmo+kp+ek1R5SUDWUwxJVBo27Pjihrcq4EHUyKa+C+nH9WqeT+IeUf
	 Hy44FZNduGClGX9gKlRzeI98L8Yw3wH1nj7Oxds9UIsb5mwMUF/tYuBt5WTSeZ5pIroyVn/dgPMK
	 UKvCS9T0V/78hgYDTrgTwogAX4kQvRi4dg6j22mdwMECdic74yINl8YJ5VqwQ7W7HarcVOY3Xg2t
	 SRJMoyvX1+5gS+WeMg09qZ/B4d93YqJDzKq7RL16K/moDBr4MhFpaiXPtM4do55LpTTYS3m6lKiO
	 4E/UPA6OO92+NCX4LFo8bdlITJ1/U6wzrhU7SEyNFrNCNWu3ykwjTT/BltLZxZohCIVbOR7VlJsT
	 dw4+XCNceFUJxbyiTU3Ic3s6n4n1W7E+btnAFg4Bh0QoRk06pyAd1A8X3Dhlmf45PpYfIFrrysRU
	 c8zDbRyc6vrxMbXrF0dSfWvpzaZ77AXJcs2ELxrSyyxCRPAe2LCWweg9ZuOBdAx0O0iWnR2zX4O7
	 /6wJGaSm/YfbtftzVzJiS9QupbDC40WA77+vpA9SRnfD0V/5w7J2QTBdyjHa9DSnmYJhaTBlk4lP
	 OeyN8bBtm9lJK8sJx9/fQABBY9OpbuQsqontcTq08sgFyuNZFWPCIDPCecca4iOHBxZEcb5xixfj
	 idFVVAY6h/7g38PlbXHHi0xSCLt4/JmKmR8g/6iOBJM7KthozAFw/zHQE30mu7Af+lpBZkPZfBE1
	 aOhZp9veF5t2piIyFx3u1V4RnVV8jRcwRa+jfhOBvWO9y+iPumleEJ8UStyecbaqYlQ0XDGUWSud
	 ecCIdARg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: shangsong <shangsong2@foxmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shang song <shangsong2@lenovo.com>
Subject: [PATCH 1/1] ACPI: PRM: Update address check for NULL handler
Date: Tue,  8 Jul 2025 05:39:21 -0400
X-OQ-MSGID: <20250708093921.2630431-1-shangsong2@foxmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shang song <shangsong2@lenovo.com>

According to section "4.1.2 PRM Handler Information Structure" in the
Platform Runtime Mechanism specification, the static data buffer and ACPI
parameter buffer may be NULL if not required. Therefore, when either
buffer is NULL, adding a check can prevent invalid virtual address
conversion attempts.

Without this patch, the following dmesg log could be misleading or
confusing to users:

  kernel: Failed to find VA for GUID: 7626C6AE-F973-429C-A91C-107D7BE298B0, PA: 0x0

Signed-off-by: Shang song <shangsong2@lenovo.com>
---
 drivers/acpi/prmt.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index e549914a636c..a97f0f3a6590 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -155,11 +155,21 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 		th->handler_addr =
 			(void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);

-		th->static_data_buffer_addr =
-			efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address);
+		/*
+		 * Per section "4.1.2 PRM Handler Information Structure" in
+		 * spec "Platform Runtime Mechanism", the static data buffer
+		 * and acpi parameter buffer may be NULL if they are not
+		 * needed.
+		 */
+		if (handler_info->static_data_buffer_address) {
+			th->static_data_buffer_addr =
+				efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address);
+		}

-		th->acpi_param_buffer_addr =
-			efi_pa_va_lookup(&th->guid, handler_info->acpi_param_buffer_address);
+		if (handler_info->acpi_param_buffer_address) {
+			th->acpi_param_buffer_addr =
+				efi_pa_va_lookup(&th->guid, handler_info->acpi_param_buffer_address);
+		}

 	} while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));

--
2.43.5


