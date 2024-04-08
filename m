Return-Path: <linux-acpi+bounces-4745-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD6E89BD5C
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 12:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD04028311C
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 10:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD94D5B043;
	Mon,  8 Apr 2024 10:36:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4255757882;
	Mon,  8 Apr 2024 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572582; cv=none; b=LePIm4C1ynZUCWRsCRanf4dvbFDt0pz4qROz3E9dYnekFyjJ/0sR2u4ZkcON5FjbotzQyqjBi0+R1s4CnHDvI0mTungUXcW8m23/jObWyYrFkfD69n+MG+SGVJ86jaiRSneIwAkC+fzjR06VfQ5d5z0oJuqC1mZkHrLFVKEp/GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572582; c=relaxed/simple;
	bh=id3ziCv7HQCiTfz3Tt8HJ4wwfunOc/K0kkovqOGZoGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f663MwUM1eNCu73GPZEaDAENe3265F7Z7QmFETReA7IvFYXEC2nLEC1XX0jxUiJ5CHjvM7jpXaCVip1aU4NnuiY4Ihl6mawYXi5Y4gLavBSl7cmaxh4Hu1DdKQi9ILmYcKpqkeRjmKJPiel+shgj1t+PUXNXhXoXF4dL82cmD6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 3FAD52F20241; Mon,  8 Apr 2024 10:26:50 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 1B5482F20242;
	Mon,  8 Apr 2024 10:26:43 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	kovalev@altlinux.org
Subject: [PATCH 6.8.y 3/3] ACPI: resource: Use IRQ override on Maibenben X565
Date: Mon,  8 Apr 2024 13:26:38 +0300
Message-Id: <20240408102638.197110-4-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240408102638.197110-1-kovalev@altlinux.org>
References: <20240408102638.197110-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Kalinichev <kalinichev.so.0@gmail.com>

commit 00efe7fcf9ceeff0808bca9460afb49e7ada6068 upstream.

Use ACPI IRQ override on Maibenben X565 laptop to make the internal
keyboard work.

Add a new entry to the irq1_edge_low_force_override structure, similar
to the existing ones.

Signed-off-by: Sergey Kalinichev <kalinichev.so.0@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 4fae9af32..59423fe9d 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -623,6 +623,13 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "X577"),
 		},
 	},
+	{
+		/* Maibenben X565 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MAIBENBEN"),
+			DMI_MATCH(DMI_BOARD_NAME, "X565"),
+		},
+	},
 	{ }
 };
 
-- 
2.33.8


