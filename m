Return-Path: <linux-acpi+bounces-6460-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B25090B153
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 16:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F2F1F254FD
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2851E1B47C9;
	Mon, 17 Jun 2024 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOnxBGEh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FD81B47C3;
	Mon, 17 Jun 2024 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630863; cv=none; b=WYdRirPTof5N89llre1Kfmbh6AuaoqloI0hyXSgWhQ/uZJNjBd5DON6HDHJpTZSjvLg6kaM4pod5Rq3LOVP+0rAaCrA8zgUhPlgCqPFsOCJTtpftQIRnc+UJbGz5EVJnElxgVTgr8RbLzDdbXFR7+ICIhGkzOPKAnPE/QDaZgyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630863; c=relaxed/simple;
	bh=AH6BarYo+R0ZVI8y1E1ZnzrrDCD/Azq/NaY4lEndFgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FK8fw0MPDTjaYIsjMeOMYYJMg70KDhiFrB66IKI9U41FdvQ088MNfwHPh71vH7bfBBXpYBcXmS5OH31Bga/+3G5ABzSK374tT0myKQZcUs07bL9XI022dtLLOZ2qZT7AobSImlLbwvKH8Q9sjQWFeFwfTfFDHpgrvs06QO6BnZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOnxBGEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D7FC2BD10;
	Mon, 17 Jun 2024 13:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630862;
	bh=AH6BarYo+R0ZVI8y1E1ZnzrrDCD/Azq/NaY4lEndFgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kOnxBGEhMwAqwJKAikmHutIlOX0IzwY4fG0Wt8dpBlk+4MSqw4ATUJOIGsmBOYFPL
	 FMWPxd5+L4cTycEvWKdnja98HmCZ3rgne0mRzPZP0fHh/FKJClUAGMcO9PrZVVhlu7
	 nl18zNNt1t8YJg+2j8StnKPR8nEkOj50qaAQTT25rtK4zPZyeA/ChUOoTA27cE5Xu0
	 k7Y8GdKNxt7j2rZeXvMZOeJx2IZEi5rr0FXf6BQ/ocsNPA52J1rSCqVvf3bYR7gMxk
	 iUCkc8Ze/ATJiGxWuf6B0SuwuLECrFrOSMKOugZXP15f+HEYB4OjSVBPbrHg7M2OPf
	 V2dRYjLUGsXxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/9] ACPI: EC: Abort address space access upon error
Date: Mon, 17 Jun 2024 09:27:29 -0400
Message-ID: <20240617132739.2590390-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132739.2590390-1-sashal@kernel.org>
References: <20240617132739.2590390-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.278
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit f6f172dc6a6d7775b2df6adfd1350700e9a847ec ]

When a multi-byte address space access is requested, acpi_ec_read()/
acpi_ec_write() is being called multiple times.

Abort such operations if a single call to acpi_ec_read() /
acpi_ec_write() fails, as the data read from / written to the EC
might be incomplete.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index c7baccd47b89f..43a8941b6743d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1310,10 +1310,13 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_enable(ec);
 
-	for (i = 0; i < bytes; ++i, ++address, ++value)
+	for (i = 0; i < bytes; ++i, ++address, ++value) {
 		result = (function == ACPI_READ) ?
 			acpi_ec_read(ec, address, value) :
 			acpi_ec_write(ec, address, *value);
+		if (result < 0)
+			break;
+	}
 
 	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_disable(ec);
-- 
2.43.0


