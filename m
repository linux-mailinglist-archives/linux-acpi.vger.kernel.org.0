Return-Path: <linux-acpi+bounces-6386-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32424907D39
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 22:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD4E1C24D50
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 20:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5656413A24A;
	Thu, 13 Jun 2024 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nPoMiCcq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120C76EEA;
	Thu, 13 Jun 2024 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309737; cv=none; b=tf72rvTUceCSVJRlYJdIUyHm8360dwh5qvdh0ERXt5ggHTdO/WcuM9isjrjSmYdvR+ojhc/+jVqVcwZow7JV+uR0Q6aiaLjQxeyZI8tZj5z4kgwaK/FI55asj4UHs5u2HNf8ifGE9NBbr2mI2LRkSTwrHHOAEcvz9Vr5NLNfNSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309737; c=relaxed/simple;
	bh=vmMyMiYI0any8cgjL2aDBnasIBju/dSVBLzlwFPmmdg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HcXBw9pSV48YHVkdwWcJE0skF6sC0VKutcpI/t5rr2/3VZ45gAee1tiDuEogxuGsvb4Aa4CA2QMUv5mIdvBCXjLJ2eoQOLtEMC7DCNDze/eDSyfcrtv7a3mx56thEpedNeN7KsxCgFB1w0bt2V7/9DEGSr7sF/5eneD5ZbzAohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nPoMiCcq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718309732;
	bh=vmMyMiYI0any8cgjL2aDBnasIBju/dSVBLzlwFPmmdg=;
	h=From:Subject:Date:To:Cc:From;
	b=nPoMiCcqQnsyeI+6pLB01PMEA1JHEpxfvfLut0VPEMu9GtWfyHdIBT3h+uqlBQFeh
	 gdEuemrrjKrX66WvenqVkkegdS7I1UdGkfbb6vJDNirEBtlJbdokz5dYCFD5izhgKg
	 S23LyU2tmBfOzsOzlW2kNmzhQ2Lelk5rcm9k1Slc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/5] ACPI: sysfs: manage sysfs attributes through device
 core
Date: Thu, 13 Jun 2024 22:15:31 +0200
Message-Id: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGNTa2YC/x3MQQqAIBBA0avErBswKaWuEi3ERptNiUNRSHdPW
 r7F/wWEMpPA1BTIdLHwsVd0bQN+c3sk5LUatNK9MmpE5xOjPBIEYz7OJOiDs4NZO2MHDbVLmQL
 f/3Ne3vcD1PmM9mMAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718309732; l=919;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=vmMyMiYI0any8cgjL2aDBnasIBju/dSVBLzlwFPmmdg=;
 b=HInnOP4sPKW1G05cM6nzIfFR8E+RCdXHeyJG06jL6LhHLIKdlmjMycEsFtUjZTheaqhK1gUcb
 l3xpp/52u1/DwkbinlBYELiThgrBIeE6AIBDjVJr+fTPJpgnMiflCZ4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Simplify the lifecycle of the sysfs attributes by letting the device
core manage them.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (5):
      ACPI: sysfs: convert utf-16 from _STR to utf-8 only once
      ACPI: sysfs: use device lifecycle for _STR result
      ACPI: sysfs: manage attributes as attribute_group
      ACPI: sysfs: manage sysfs attributes through device core
      ACPI: sysfs: remove return value of acpi_device_setup_files()

 drivers/acpi/device_sysfs.c | 229 +++++++++++++++++++++-----------------------
 drivers/acpi/internal.h     |   3 +-
 drivers/acpi/scan.c         |   6 +-
 include/acpi/acpi_bus.h     |   2 +-
 4 files changed, 114 insertions(+), 126 deletions(-)
---
base-commit: 7d91551085d3e7d5eb21c2481565b2be5288f11b
change-id: 20240609-acpi-sysfs-groups-cfa756d16752

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


