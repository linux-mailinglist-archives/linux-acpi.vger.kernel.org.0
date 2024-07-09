Return-Path: <linux-acpi+bounces-6831-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A42D92C4B3
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2024 22:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54CCB21E02
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2024 20:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D9E189F57;
	Tue,  9 Jul 2024 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="B5pXDWIx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2C914F9C5;
	Tue,  9 Jul 2024 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557505; cv=none; b=lWj1u2QnhRYbW4pKffEWlQGazAysjuWKtLW1yhVRGz+1MuY1GTc3VZns+pFjsfvWZB4McZl7yYtvM7EnIh9YFjKGanldqUl1U3M4G3EIXiMGXM67OV11EunWIuw5BmgWnX0ofc+H998C0jYTVYKQPglCt/o9nE9zfjlapZ+ney8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557505; c=relaxed/simple;
	bh=g9CAzBCrhH0KyzUhTyFmcpsSKbBxqlMkXvbzM7Nks+I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j8FXlwU8ybvDZGSPWoJAnrfy7kUD9ckIGB0boAnmgma9j0Usauvyva62le5xQgRNH8AchAEJGp0gjqWY46Kd/yYs0gexs4OZt/jXHorlCPVErCfl1wGhM0+1ep7+65DE6jCEaQPaptv7GN7y2PgJ+iEGcY/sx3j57rqBRoFAUSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=B5pXDWIx; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1720557499;
	bh=g9CAzBCrhH0KyzUhTyFmcpsSKbBxqlMkXvbzM7Nks+I=;
	h=From:Subject:Date:To:Cc:From;
	b=B5pXDWIxAztaemjI7X/kMrPneIFHWXiYTEqPmahTrFulSplW1LVt1mVdr9tq2wKGy
	 V1jgERaNVItNGg20/f06PRSxAw69iAmUCVANke+LXEJsncdN4aPzj6/OJloXX+xoRW
	 9mfBJWgtsahHsqy2zSMC1Ib39S59vlikVY7mJ2dc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/5] ACPI: sysfs: manage sysfs attributes through device
 core
Date: Tue, 09 Jul 2024 22:37:23 +0200
Message-Id: <20240709-acpi-sysfs-groups-v2-0-058ab0667fa8@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIOfjWYC/22NQQ6CMBBFr0Jm7Zi22hJdcQ/DopaBzgZIB1BCu
 LuVuHT5XvLf30AoMQnciw0SLSw89BnMqYAQfd8RcpMZjDJX5dQNfRgZZZVWsEvDPAqG1pfWNdq
 V1kDejYlafh/NR505skxDWo+LRX/tr6Yvf2qLRoXOWVINPZU1vnoRi0iIczz3NEG97/sHZh8HY
 7cAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Lance Ortiz <lance.ortiz@hp.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720557498; l=1194;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=g9CAzBCrhH0KyzUhTyFmcpsSKbBxqlMkXvbzM7Nks+I=;
 b=DMAXXcEu/RfLHrcim8ExpwLv0EvE6GmgQ0UoJannbHTutXx8KlBvZIFQpx7mcHINBuo+CSAmJ
 LAVzyxSNfvzBE2dgogYWGGhn3BAyMejMiIy7/qH4vuwZWECHnsSJkfO
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Simplify the lifecycle of the sysfs attributes by letting the device
core manage them.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Add fix to validate buffer type validation (patch 1)
- Drop usage of devm-APIs as these are unusable for unbound devices
- Evaluate _STR on each sysfs access
- Link to v1: https://lore.kernel.org/r/20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net

---
Thomas Weißschuh (5):
      ACPI: sysfs: validate return type of _STR method
      ACPI: sysfs: evaluate _STR on each sysfs access
      ACPI: sysfs: manage attributes as attribute_group
      ACPI: sysfs: manage sysfs attributes through device core
      ACPI: sysfs: remove return value of acpi_device_setup_files()

 drivers/acpi/device_sysfs.c | 196 +++++++++++++++++++-------------------------
 drivers/acpi/internal.h     |   3 +-
 drivers/acpi/scan.c         |   6 +-
 include/acpi/acpi_bus.h     |   1 -
 4 files changed, 89 insertions(+), 117 deletions(-)
---
base-commit: 34afb82a3c67f869267a26f593b6f8fc6bf35905
change-id: 20240609-acpi-sysfs-groups-cfa756d16752

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


