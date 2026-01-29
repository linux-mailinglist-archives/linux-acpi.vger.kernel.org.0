Return-Path: <linux-acpi+bounces-20769-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEdOCYF0e2mMEgIAu9opvQ
	(envelope-from <linux-acpi+bounces-20769-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 15:53:53 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83014B1300
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 15:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7038E3006B44
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 14:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BE132E13E;
	Thu, 29 Jan 2026 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ifn6J6AS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DAE32F745
	for <linux-acpi@vger.kernel.org>; Thu, 29 Jan 2026 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769698148; cv=none; b=R18tkywM1Q4LJ9X6PRCK/LXoLe1TGXVqH0aF/ZYC7k6FoVqe1xIBMixxVfhbdGAxGUht2InSNVlgySONWDoJ/IuPz9CAWKMZMrBf5JjDBzVQOx54ytBCYkQUs6b6c7EfSQlc4oL9kC+aL6ZPEYjc731ftM/Lgs2Y6dBAt3BUY2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769698148; c=relaxed/simple;
	bh=cP32tCNjHGj/aGvL4Iw1VUAeBgaVX64sqaUnyjoblbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h5TgNH1Ts4YD6bjAaoPVIgAZPNNUY7v89MP2MbX6UkDt2nb2NRSRarc533aqO38R43KbEpzO2bmcFLm58QoFxT8D5Xfs//Q2uFvQ5mumonjU2WbJHScVrRBdrLrN1Z38Ov2yotEDj4+LK7yLo5eEQgNvLjqlJLiDUvv0Bc23VcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ifn6J6AS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbc305914so1029943f8f.0
        for <linux-acpi@vger.kernel.org>; Thu, 29 Jan 2026 06:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769698145; x=1770302945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ozgT2vT2HInFgY1UG9N9CTs/5kcp1bFi2ddtV+gqCHg=;
        b=Ifn6J6ASy/asxOIcP55+BTdkKaJ0+ZCd5sVwfy+fY4ZndnS20L6lhnchF584ro/IKw
         m6yv1w6vhv6x4H3lXWeIDmgZ5Eypt6Hh2yjApPjQgcoM9FTwFvLR+CKvF6Hg8FE/EqTN
         Tx9N72xDCcBoHABUb2xrabcxThFC1g1zYzvD34+1PoTHZatbCCSZX2Pxm+CNaxj4QjTT
         EweI8B5qNeyVmK738+REU0oRPi1QnIuVZmK0NMXW6tvzf9bc54S6at0hRALy5EbfHQoE
         1DqBmjew8pZUlYj6iTwuCqnXN7yEhWODGhXL+wJE01OM6X5JsVtVi1wzRXfkdODunxyD
         ZD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769698145; x=1770302945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozgT2vT2HInFgY1UG9N9CTs/5kcp1bFi2ddtV+gqCHg=;
        b=tkBbBHS54A0hUA8Jfnr8ObLgxBpHOFYUQggM8LomP+zbqPT+NPXMr8aAKjFTPwX5ZO
         ZrFEFDNId5lZ0Z6vYpI5+h+amoPZf/otK54rxkLsjdKpE8WSKpIGXGjIRbQX18sHgXFc
         GAouV6gxtVWt7zTlca8skeBAYpP6PGu4H1uq55H06vMXHmhEZu3WY1t84Od7DmbmtSEZ
         ubahGiRDFHD2YeK0mXjVNlMYoUcJ6xcN0tcw5c7g92WGSkpX+homBaQ5XxfBbjmFdSGl
         uyoVC5u41cldILhdhE+pybimc7wuNEqAF/DoHc2ZakQYivrBdAwpq3T292AAu1azLoV3
         CGew==
X-Forwarded-Encrypted: i=1; AJvYcCXJe7BzPZXF/g4X3/kr7A00yru3dJBfh2IVUb198Alz+G6iJIG0fQSBubFtTwwftMi7s5JmsO3yd/aP@vger.kernel.org
X-Gm-Message-State: AOJu0YxaKPNL9ItXyIiAq6b6bsYLfI4oz6SASFqfX9QlYlNBwD0riIMy
	c2kKP+5JnsT/JHP39qi9177LDqYvJuto6Ed0OxHvxsJMY5k34yl7b29dK/YpNbOw
X-Gm-Gg: AZuq6aKNGPM9JTjHQRApHLaCidqdwMaK0umfLQ525EsVAZeGqCDIT5zSviwVSG6yzO5
	WulcePjyECoDBOxA9RwGkoV4wHCLGxnPk5zgxYxbxDNDQblwRcdYpyP8Uh+Gnp3pyw5nCVBhS0N
	2WFIEMsbyPKTl7VePlJyDiAF0aqwvJkPKzKMFaHBFCVM5JyAJUgjzBnF2VEMqVmIZqKfY/5aaeH
	BURfv2n3SzXVegEiuyR3x4n5dX6+E3ORuYVLvrn6WTdI/1+NwEpIDIGzjL0T1gBJByipVXU83gc
	WdaiF3AjGPvxk5Cdg+KKAIeKWiAjvFQqjlQDCGRMGv/77WYFmDK6ivJyB1jq3yNejHSn06MBZd7
	6vC4yXrYJ0/hNbRPdSCH1LsWzfRACECnV+UVvUlkhUQk3hHXxxmK6RPR7tOmPV0GbrIm7GqsyiA
	mIzxZouqJag2Pm4+0xdigRpBDX
X-Received: by 2002:a5d:5d03:0:b0:432:5b81:483 with SMTP id ffacd0b85a97d-435dd07d271mr13381832f8f.24.1769698145246;
        Thu, 29 Jan 2026 06:49:05 -0800 (PST)
Received: from NBLK-WAX9X.. ([88.228.69.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cfd4sm14373572f8f.25.2026.01.29.06.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 06:49:04 -0800 (PST)
From: =?UTF-8?q?Ata=20=C4=B0lhan=20K=C3=B6kt=C3=BCrk?= <atailhan2006@gmail.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ata=20=C4=B0lhan=20K=C3=B6kt=C3=BCrk?= <atailhan2006@gmail.com>
Subject: [PATCH] ACPI: battery: fix incorrect charging status when current is zero
Date: Thu, 29 Jan 2026 17:48:56 +0300
Message-ID: <20260129144856.43058-1-atailhan2006@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.49 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20769-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[atailhan2006@gmail.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83014B1300
X-Rspamd-Action: no action

On some laptops, such as the Huawei Matebook series
the Embedded Controller continues to report "Charging"
status even when the charge threshold is
reached and no current is being drawn.

This incorrect reporting prevents the
system from switching to battery
power profiles, leading to significantly
higher power consumption (e.g., 18W
instead of 7W during browsing) and
broken battery remaining time estimation.

Validate the "Charging" state
by checking if rate_now is zero. If the
hardware reports charging but the current is zero,
report "Not Charging" to user space.

Signed-off-by: Ata İlhan Köktürk <atailhan2006@gmail.com>
---
 drivers/acpi/battery.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 34181fa52..b4ba8085f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -211,7 +211,13 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		if (battery->state & ACPI_BATTERY_STATE_DISCHARGING)
 			val->intval = acpi_battery_handle_discharging(battery);
 		else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
-			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+			/* Check if we can fetch ACPI current info */
+			if (battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
+				battery->rate_now == 0)
+				/* On charge but no current (0W/0mA) */
+				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			else
+				val->intval = POWER_SUPPLY_STATUS_CHARGING;
 		else if (battery->state & ACPI_BATTERY_STATE_CHARGE_LIMITING)
 			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		else if (acpi_battery_is_charged(battery))
-- 
2.43.0


