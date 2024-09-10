Return-Path: <linux-acpi+bounces-8209-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96AC972E3F
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 11:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FB2287AFE
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 09:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B8318C32E;
	Tue, 10 Sep 2024 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="bVIQHamT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E531D18B482;
	Tue, 10 Sep 2024 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961238; cv=none; b=HdMpD69eGgjHH+PXFNIsTdlndoQZrmSv1yB2Vx9a4TyundMv+HBMqUSFR2BZGan7EvXwc/8we4bkq9ET1jC2oncFv8GFVQeO3D6EFKueNvv/sS2c68IMUqyUbGvSB1/uh9QWmjlYRD8qhOtUUZtV5QDPZI25B87yjhAYXJfH8zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961238; c=relaxed/simple;
	bh=E7wSL5gQgLffqO2jCLHckUqtAG4XwrFdBUVOfditeyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UCYrTgPqxpI2dKWgBJD2fhRcnOk/zHHmCrMyQ9GTsWUT36FEg8f46aztKmdWPyE00kr/rT33gt/SVwH9p398qXeSlG4eOoNvWm1v+QEUMeWJANpqvToGCbxdHVojsYN+HMgnxJiwR/FAaq9G7grGDenbQzV5FYzJzum9i99YaXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=bVIQHamT; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse.fritz.box (pd9e59da1.dip0.t-ipconnect.de [217.229.157.161])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 141B72FC0059;
	Tue, 10 Sep 2024 11:40:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1725961226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kQe2tNlswDFCiQdSTon5o0rjA2HtV6XUazdlbMxyLsc=;
	b=bVIQHamTP00jdNLe1nQ5fhJP/AWl4MjUUZtNxj/x5bU2xEUcFxHFo/BNeGdoK9OWjae0WY
	4VEPOco7CiVdXX8yHd4rC7NG+e8NruZSvp/LqZYFk2urugMI/qc/7JYmAHIXxPgZJ6ETJI
	lcOHqBxqeebOC5OMPSQ/zKIrHtjABes=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ACPI: resource: Add another DMI match for the TongFang GMxXGxx
Date: Tue, 10 Sep 2024 11:40:06 +0200
Message-Id: <20240910094008.1601230-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Internal documentation suggest that the TUXEDO Polaris 15 Gen5 AMD might
have GMxXGxX as the board name instead of GMxXGxx.

Adding both to be on the safe side.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
---
 drivers/acpi/resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 59423fe9d0f29..b50fc5c16f749 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -545,6 +545,12 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxXGxx"),
 		},
 	},
+	{
+		/* TongFang GMxXGxX/TUXEDO Polaris 15 Gen5 AMD */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxXGxX"),
+		},
+	},
 	{
 		/* TongFang GMxXGxx sold as Eluktronics Inc. RP-15 */
 		.matches = {
-- 
2.34.1


