Return-Path: <linux-acpi+bounces-16187-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 703E6B3BE8F
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 16:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CE3188E18B
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 14:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD17A31AF25;
	Fri, 29 Aug 2025 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tehsvk-net.20230601.gappssmtp.com header.i=@tehsvk-net.20230601.gappssmtp.com header.b="dFNtocKr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5445829E110
	for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2025 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756479165; cv=none; b=hPRBvoK3sbUBE29+O/p+wBM2qqtkuuWZ5r9tELeAqJUAiJKUKSONuqPmkLttD3BRGPFRcUjE/+ck+uV6cTjMGyAiUoPqJ4VqvNkK6MZ3sF0s7Ucc9o6B19NOcWBzLX7ZIwFYbSAsNxodBdidsK4LzlZnqxM//Pa0YAkkvwehO/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756479165; c=relaxed/simple;
	bh=pbxV2Mavk1lMiJMhfJQeb8/mI1z3zntxdHr6u3BjEJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBl7Xh/IOjupSlRh/CL3WHPDTsXdHH1vfK5rUQh4FUnzBKu7bpxHVXRFCRAV1mzOn+qOrr/mkpfydg5Ms4lq+OH/BqILkMkxgpTi+GIPPDKj8S4AVyq4WmcNZ6qxonKsrf+JDVg79s30YO6d+0IlOrX0C0z/bvgGs0cRAbzi97E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tehsvk.net; spf=pass smtp.mailfrom=tehsvk.net; dkim=pass (2048-bit key) header.d=tehsvk-net.20230601.gappssmtp.com header.i=@tehsvk-net.20230601.gappssmtp.com header.b=dFNtocKr; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tehsvk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tehsvk.net
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-affc2eb83c5so4230166b.2
        for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2025 07:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tehsvk-net.20230601.gappssmtp.com; s=20230601; t=1756479161; x=1757083961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YAO3ZMwu5xYp39Ji5NepqL908pahfUuulyMV8nWLF2E=;
        b=dFNtocKrkD3b+LGnUGpnGZvrJTpss7N+lbXWOj1VqHekrlXyzQDKnGfUF4Vz5lJrkv
         vqw76HOol/9bHRkaQo5Z3WssRHDrm7OfS/sW77SELzbVYssvdm/yIV1u0V7NYVPebfLw
         a59ksIh7nUZ22AB7ObWu7gwJ19+jWuOxpbkmF37TG2FDKRHH2N5cLa2/FZ8PuYcBAgUV
         jEX4EMtADb2zykg4KJgIbpLv+oglX50et45vizX6q2PfFbL9A0qiWZ4RPle1Qbt/S/B/
         RIB9uVfO3kofmkJV5Y5WDzkyjCgBeSet9pdb5q6Y92Ol7IAUlGmcmpahYmcjYnhzacN+
         Ea7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756479161; x=1757083961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAO3ZMwu5xYp39Ji5NepqL908pahfUuulyMV8nWLF2E=;
        b=xJarqPCahaRzxMKEKF2OGE1Z7g8mWKQIM0bQc29RQMOPJmefttZ9FK8ZPRFmaw+qnG
         6w3tzQxPGW7DgRUt0L/Pvoa0wZrylnZAu8NsL52b+j7Tbw3VFj1oxVn1E/jbfng4MUGd
         7WyuHkz9dbZO4mMkqIfGIy6OIa3Kdm8IeF+LzYn/1iKI7e1OwKE+nCFburelFLCB4bmP
         OS0hSArl/N/M9bDNf+9xD8vhX1kXnQvvNmzKanmSHXeu89UAws2m3zg42OexhhCD2Af1
         wf8NbmtAQ5D+X1RoftYwupsoOnW4msLurkUeh2jl+evm6JFt3fhBXZ88WiM4r03N7H0d
         aN5Q==
X-Gm-Message-State: AOJu0Yw5gL1oMk7Arqy7scR3P5PZxhrljEfE/xORZBw3gDvpgtl6Ftfh
	Iw8zLLV6EV8lS9Hu6UJA+KoXu3P+hpZ9Y1VAxo1LvuN6NcuOgXAx6/OScNwLnMtnjzGQ+dEpWys
	TgiVllv1n3g==
X-Gm-Gg: ASbGnctPtYLvY6SuyPKPZ9XvTiLQ89PSDeIVBR9wulTk3emFHWOb1cX19zM4otbEX7n
	ymHaayuWeec8DBMUyWeL0xovrQsTyq1w/f5Bu6X7X2+W7RXuUJqvL4PpXltFuJAnyB+XfQMNX9i
	6axaGhkvh4XqulkyfnlACGOAcCoMXbRqgtAK70FVNVuDKHPxmCcI7pDRMOCCxzfzMZEoPzISm63
	RgYKMlrZcBvQXL+3sGSV9syGJawA+2iXsXSl+th9nweUvSz6Xch+wLs+ez6YHAH+vwfAuKmOtqO
	/iw4UtVJLjhMbAaC5gCHxxU/ksFGuVkhvcpaYYDax0iHwzuiosb2tcZvOaqOgGdJ8d+zljstvsW
	Z37r0gPodvLsfRdY/ULX9mLIBlREyOKu/xUkmBqEPX+j/Q12O9uVd2ko=
X-Google-Smtp-Source: AGHT+IGI4LwarnpKpqmefv3ZKJsmqOze2BLYKHXw9ym9VMS7r/n+3DilKdheD3uR9kM26iVbykZhtA==
X-Received: by 2002:a17:907:86a5:b0:afe:bbeb:1f56 with SMTP id a640c23a62f3a-afebbeb24ffmr1019354666b.36.1756479161358;
        Fri, 29 Aug 2025 07:52:41 -0700 (PDT)
Received: from nas-i.. (ip-213-124-217-71.ip.prioritytelecom.net. [213.124.217.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefca0a960sm212407766b.37.2025.08.29.07.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 07:52:40 -0700 (PDT)
From: Sam van Kampen <sam@tehsvk.net>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Sam van Kampen <sam@tehsvk.net>
Subject: [PATCH] ACPI: resource: Skip IRQ override on ASUS Vivobook Pro N6506CU
Date: Fri, 29 Aug 2025 14:52:22 +0000
Message-ID: <20250829145221.2294784-2-sam@tehsvk.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just like the other Vivobooks here, the N6506CU has its keyboard IRQ
described as ActiveLow in the DSDT, which the kernel overrides to
EdgeHigh, causing the internal keyboard not to work.

Add the N6506CU to the irq1_level_low_skip_override[] quirk table to fix
this.

Signed-off-by: Sam van Kampen <sam@tehsvk.net>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index b1ab192d7a08..ddedb6956a0d 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -510,6 +510,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "N6506M"),
 		},
 	},
+	{
+		/* Asus Vivobook Pro N6506CU* */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "N6506CU"),
+		},
+	},
 	{
 		/* LG Electronics 17U70P */
 		.matches = {
-- 
2.43.0


