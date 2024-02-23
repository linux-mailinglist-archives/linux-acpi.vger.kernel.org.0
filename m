Return-Path: <linux-acpi+bounces-3921-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547948617CA
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Feb 2024 17:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E101C219D9
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Feb 2024 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26792126F26;
	Fri, 23 Feb 2024 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4NRD34p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48494128378
	for <linux-acpi@vger.kernel.org>; Fri, 23 Feb 2024 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705468; cv=none; b=TPeqFxhM01+CRpB+lUijOiUcM0lnr2PEuLuv9ctC1OIRsfU0qv60fV3rH6rcHxAwL+0jCKUyj6ClfeU67Q9sVPUZ3sfqyBmWCBC7abn2g0BJI1PsPiT+gBKWVabLmcVxYmK3KbPNGG34zH1w+D+G3iSISBDK3fUJnMJ4J6jM99M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705468; c=relaxed/simple;
	bh=WhB2DjD7ZAA+QIHvsDz3757MA4T80EiG7E0kSoHSwmE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lbdvq/gyCfg5QGUWJWuacxzyT6DmQOKmEJZazB4r6Ic16RyyR19ABS16tSlbfZ6fFmpy/LMfYVnWjY5sY9OqmvpWa2fcECggJs2fAASd7CrOEt+km+/qRn8iT1kMlpiZX5ZX8chtElQnSfJ4S0m6WpzpatkQhPySFBCjAHDJQa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4NRD34p; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412895f726dso3848215e9.3
        for <linux-acpi@vger.kernel.org>; Fri, 23 Feb 2024 08:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708705459; x=1709310259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8gDge0Q1djmOzhLYsn0ZYL2nTpzB6D67s40bSn2KrM0=;
        b=V4NRD34prkN79EMXgRTJlSm/2VsNC8SyErdEbWtXL8HE1YEhH/OxkHPYelXlTukfe6
         HvgCChGFwRTcvHZScmHZZffs5IZDQjHcBbmDfkjLcZKES8FXyPD6pFG4W9dVwQl7MZM1
         dxeF20SAG6bAvTFMkQ9QrwtZ8YWw8YAlTtH7u3MWbfb4OT4dOgjdxA+7imjlmMEptv34
         TZWql/ElxVb1A/l7iDg5XnPnhdkzV7nbMlimWyY6c6IO/KGDzYB2m1WmZRzcrwgVOMj9
         9TR/DTYS7tHM0lnLgDu1KDLauWwcfO+uKjLoOtDFIMne+m1Jv23c0VT1a5n7wJHQKBIb
         wKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708705459; x=1709310259;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gDge0Q1djmOzhLYsn0ZYL2nTpzB6D67s40bSn2KrM0=;
        b=nZ1zk3th2EEWXPCry1oJmfqQCNGQSDI25RiHcHTQdrpWgUkwQpxOPSQnvF6VEdiuVq
         rV/QEhwZBS0NZerT7DqAZAeMOCWj9HvQvRDNjEinsFx4I+i+mwCNDIa3WsqAjr9/2Mnc
         oEx1iaC7Up39kEZlJbCBj9p9gIVLG/w/pL7IRIHZWZeFcQuyU3p6Knbqg6ekBPs00Mpi
         wP1d3jhLlM2jGpR29hWwXyp+ZTcrUYV5iHETxTJG89Z5jx+OH+Wz0CR5hBqDcbfbOE4o
         swaZsWEyKgYBrqLaPF2aX1DtsX4FBE2meMU9/gvsqdEDE5aWKgu3VkNHTKrKLp0imiyk
         IPRA==
X-Gm-Message-State: AOJu0YxhAPKoWxEwYKYdn//9jWLGybGsCXwqNem/9l7Rd9pXiPVIfF/4
	Ps/oekIeNh4dw4S1vpSV/5lLOjk4GW1+HCNeNvzOkEY5t9phMqeTk4hrVYKOZdrNaz2QgV9PnsH
	7OWKASXfeqR01nTnv9j7cyH6/mOvFdcXR/Vs=
X-Google-Smtp-Source: AGHT+IHuwhbcpOyAqUfb1qTh90mf2LDJ2w6ALGlfe3uGn5jKb7jn1Fw8MqVCqEMd3Hmxuuj2WdsaaSZ2bwT01AbXs18=
X-Received: by 2002:a05:600c:520a:b0:412:985d:45a with SMTP id
 fb10-20020a05600c520a00b00412985d045amr183603wmb.13.1708705459072; Fri, 23
 Feb 2024 08:24:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Uldyk <m.kudinovv@gmail.com>
Date: Fri, 23 Feb 2024 19:24:08 +0300
Message-ID: <CAAa5hjU-QV8LQtiNW5uuh_z1Gvge_q36LzmLqj7FiK7tT6JsOg@mail.gmail.com>
Subject: [PATCH] ACPI: resource: Add MAIBENBEN X577 to irq1_edge_low_force_override
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A known issue on some Zen laptops, keyboard stopped working due to commit
9946e39fe8d0 fael@kernel.org("ACPI: resource: skip IRQ override on AMD
Zen platforms")
on kernel 5.19.10.

The ACPI IRQ override is required for this board due to buggy DSDT, thus
adding the board vendor and name to irq1_edge_low_force_override fixes
the issue.

Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platforms")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217394
Link: https://lore.kernel.org/linux-acpi/20231006123304.32686-1-hdegoede@redhat.com/
Tested-by: Maxim Trofimov <maxvereschagin@gmail.com>
Signed-off-by: Maxim Kudinov <m.kudinovv@gmail.com>
---
If you need more info (dmesg, dmidecode), then please let me know.

P.S. Sorry Rafael for sending it to you again, my email client was in
HTML mode, so
the email was rejected from the mailing list.
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index dacad1d846c0..f681fd66d32b 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -588,6 +588,13 @@ static const struct dmi_system_id
irq1_edge_low_force_override[] = {
                        DMI_MATCH(DMI_BOARD_NAME, "GM5RGEE0016COM"),
                },
        },
+       {
+               /* MAIBENBEN X577 */
+               .matches = {
+                       DMI_MATCH(DMI_SYS_VENDOR, "MAIBENBEN"),
+                       DMI_MATCH(DMI_BOARD_NAME, "X577"),
+               },
+       },
        { }
 };
--
2.43.2

