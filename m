Return-Path: <linux-acpi+bounces-6280-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4A39014CC
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Jun 2024 09:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6B11C210A4
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Jun 2024 07:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29451CAAE;
	Sun,  9 Jun 2024 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JcPfG9fL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23026199B0;
	Sun,  9 Jun 2024 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717918041; cv=none; b=kFOVAYfCaNeLtyJ4elufA7FNrHPo6GnbjooPEBl4lx9AQKMgH/UHsj//6HBHSIy6yko8o4J48bWSdgLIy0jdi4uOUKvZ11J3yAF6HEqOmQDLv0vNwXVMoShtSG384X9hWHvBXs5Q57a5wqnHaeeYDhV4zjNElQgX6XXAH9Osh9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717918041; c=relaxed/simple;
	bh=aoSODJ4LTnZo/dUXDqhr/JAwLyA+u5wjURLU6Jl0d1E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Am7cwit17BYj1q93E+DKw5TibIkCOTeCPa3BZmEnXLHitx0IEI+EBabeUP2f2DgvY5qYxtxpG7QSc89SW3mjdh2Bv5Mim+ibb5azC2VYwJNl61k5M735yxRLblRUAPmJRL3q7DDhQroGCBA/acXpVvSL8B0mPuHO9yvgF9Gka6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JcPfG9fL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717918035;
	bh=aoSODJ4LTnZo/dUXDqhr/JAwLyA+u5wjURLU6Jl0d1E=;
	h=From:Subject:Date:To:Cc:From;
	b=JcPfG9fLd4ra0+j308D3Ox1hlowhvNFm+NN1Kk+OgwxXzbkXva6YCoX3bT8CgURXP
	 Mbpp8HUUwBK69+7xiZySlX3+w3YA6tLTt5zNipxsqWe6OQOC84sfFyHTI6yPZ/KXwL
	 prBbqlgEa9jLKmnHvL9iENOOfUzcOjP6UuZMAMrc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/5] ACPI: (mostly) battery: various fixes
Date: Sun, 09 Jun 2024 09:27:11 +0200
Message-Id: <20240609-acpi-battery-cleanup-v1-0-344517bdca73@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE9ZZWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwNL3cTkgkzdpMSSktSiSt3knNTEvNICXbMkA4M0i6TERMOUNCWg1oK
 i1LTMCrCx0bG1tQDEf+t1ZgAAAA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717918035; l=712;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=aoSODJ4LTnZo/dUXDqhr/JAwLyA+u5wjURLU6Jl0d1E=;
 b=R6T8I+7jWMSA2L5/7bynBmIxF55gi5/2oMXSURMoEck7nLrOiS0jD/ishu8gjdasghB5GFIp1
 4/aWhdId78jAypHIjMy/KkvMSeMnR5pwIvyQcn8jHWwCVXPkSRgwB4O
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (5):
      ACPI: AC: constify powersupply properties
      ACPI: SBS: constify powersupply properties
      ACPI: battery: constify powersupply properties
      ACPI: battery: use sysfs_emit over sprintf
      ACPI: battery: create alarm sysfs attribute atomically

 drivers/acpi/ac.c      |  2 +-
 drivers/acpi/battery.c | 26 +++++++++++++++++---------
 drivers/acpi/sbs.c     |  6 +++---
 3 files changed, 21 insertions(+), 13 deletions(-)
---
base-commit: 771ed66105de9106a6f3e4311e06451881cdac5e
change-id: 20240609-acpi-battery-cleanup-6b00f8baa1df

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


