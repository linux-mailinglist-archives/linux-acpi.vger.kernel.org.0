Return-Path: <linux-acpi+bounces-21050-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +YANKsDCm2k46AMAu9opvQ
	(envelope-from <linux-acpi+bounces-21050-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 04:00:16 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 176D61717DB
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 04:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EA503009B19
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 03:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FBD86329;
	Mon, 23 Feb 2026 03:00:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD1A3195EF
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771815613; cv=none; b=tV1X4iEJBLJ/RbBYKlQl4EMJzoCGo9fYPYvjATxj/qu9Jx3U9luYE9Szl9CBi1QnsqTDvigHaiApnYLSOicCtp8tGMD7gByNa5i6jsckgGrxoVnxp/qstFLyX3J/MNNto/DnPsp9em+dm0OsN/qP/P6uQQlXs45UujJqQLfiW7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771815613; c=relaxed/simple;
	bh=TcPNtRb5A1yeA4Zt9SmEvC6AzD9oGYQCKWzbcU6iGfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b9WYG5SzFAs3FsECddn//WEI2nkuCjNxPnLRx3tDaEsJrxsnbjGGyyzC1IOhDy/+Mdwvjzi+eKDY/egkSIVe64X+kfCqM7xZC6zoXw/HJTVd1Z7U2Pv8xomY6frCRM+c6PtM8cWRd9215tcCujKE1llLO7kV/BWKn7V7GXoUljE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schn.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schn.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5fc66c49d03so2003602137.0
        for <linux-acpi@vger.kernel.org>; Sun, 22 Feb 2026 19:00:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771815611; x=1772420411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWMw43NcxNljR5M74M/NPTGXoUVL43oQx/hWfbaifB4=;
        b=LPhTItwmgyzznvR69HMmRc8CYGz+YW4EZrlqr5LgoKAWPq9SEg7amJSme02vBJY/wQ
         ixd+2oxiKZJyuRvXXKiY/+rlDgW6wP0NqS7s+gvsjNri4tsvEC2ESRyRYht/RodCMKvB
         jIDie4+qPD9nBj+Pw47ZDLJHlFIWbzeXJOPS0vTGjgSPmWCDA/vsW+Nlh6P91/4+IXzb
         YfaGgArfgHtmjaYtRBs1Pd363UEW8eQibaUmql8yZILaRMA0AMgCYhbSzsNzZlaNjEOF
         jqpnHl9XQa+wTyzgXGEWgmf3YOBZQr98rwwrRG5X0zBYrjjo7uCiu9wqRaUmOZfBltKV
         7qQg==
X-Forwarded-Encrypted: i=1; AJvYcCUbFGP0iSvuPK91gNn5fV14H8mdDQ92+11WKEoasujtEm0x3WG0Xp9Gk5KLZFCg3wMN7/o5Dc0+yOYV@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLaJ7uC4aL19DbwbtMPf0jXkjP2EXYOxp7CB4RLOuUNBiQGe1
	6G8hl3l/V4+hwlBMKVfgpnreW408zeLMheRK0rHMRPzXqd1FkZIVIFl5
X-Gm-Gg: AZuq6aLiZDi662rBBz4cgC0yO+CT0dO0dgD7KV0Vup6tatRLu8bw1LOvPr+UL2y9e5Y
	u5cs2X/mkQs7xC8S+xtamAvrkgIpGihny8Id9YDuX+kM/470VhsQh0rR/equC39iHFP+IoggjN6
	th8YpHwchk9yjDq1JyG9LdQPYfFSZKKEXb0KhZl22TLJv1MWcnEqa4weaNJY0mculna2P1jxkP5
	HqgU0TCT0p73FxAEYqMJC21Q402ApthhhJblrt4agAuH/TildQzxjup7V4y+YFxVOl9HPUu3WzC
	OsvWkWm5NViIEbMq/eJuIaVcJb6GbrD7TJdgkCXuTDmH935uVqX9mesbyZC8em5Scg3blYc0FBJ
	okonNYdT+VdurkMpkKqw1bQ2DUN47Y7OrPPR0V5WDKiTGfBMExqv9nks2Y7lN6b4sWybi9WnTc8
	JwSZcgBWjyh/QHSaNiHQtZLfbIE+bwgR31lnzp3OQBRW2n67OhIrV6KP/JZr+B98zH
X-Received: by 2002:a05:6102:a4f:b0:5f5:256d:c0cd with SMTP id ada2fe7eead31-5feb31340a8mr3713768137.34.1771815611483;
        Sun, 22 Feb 2026 19:00:11 -0800 (PST)
Received: from desktop-sofia ([2804:14d:ba4e:824c:1d87:d278:461d:1a0e])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5feb61fde14sm6534388137.3.2026.02.22.19.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:00:11 -0800 (PST)
From: Sofia Schneider <sofia@schn.dev>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	Sofia Schneider <sofia@schn.dev>
Subject: [PATCH] ACPI: OSI: Add DMI quirk for Acer Aspire One D255
Date: Sun, 22 Feb 2026 23:52:40 -0300
Message-ID: <20260223025240.518509-1-sofia@schn.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21050-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[schn.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FROM_NEQ_ENVFROM(0.00)[sofia@schn.dev,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,schn.dev:mid,schn.dev:email]
X-Rspamd-Queue-Id: 176D61717DB
X-Rspamd-Action: no action

The screen backlight turns off during boot (specifically during udev device
initialization) when returning true for _OSI("Windows 2009").

Analyzing the device's DSDT reveals that the firmware takes a different
code path when Windows 7 is reported, which leads to the backlight shutoff.
Add a DMI quirk to invoke dmi_disable_osi_win7 for this model.

Signed-off-by: Sofia Schneider <sofia@schn.dev>
---
 drivers/acpi/osi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index f2c943b934be..9470f1830ff5 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -389,6 +389,19 @@ static const struct dmi_system_id acpi_osi_dmi_table[] __initconst = {
 		},
 	},
 
+	/*
+	 * The screen backlight turns off during udev device creation
+	 * when returning true for _OSI("Windows 2009")
+	 */
+	{
+	.callback = dmi_disable_osi_win7,
+	.ident = "Acer Aspire One D255",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "AOD255"),
+		},
+	},
+
 	/*
 	 * The wireless hotkey does not work on those machines when
 	 * returning true for _OSI("Windows 2012")
-- 
2.53.0


