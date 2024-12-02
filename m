Return-Path: <linux-acpi+bounces-9890-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A68B9E0BB6
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 20:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FFBD165175
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 19:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1001DF24A;
	Mon,  2 Dec 2024 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="SL9NqyaD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A502E1DED4E;
	Mon,  2 Dec 2024 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166253; cv=none; b=vCuFxHO42jaQ+IgfdqJRRoQB+Np5Q+KvU0vRmfYqu1/+31Zp/3YPEkFJvWKMEIUFhlLLxjqCfv+6J2ZeGZub3XPJZ3lLjDhKH6dNPwjczfvkHAc/Fq/zvh6qJ7erSzpyFXEIWbgagfzIjadc9DgYj8HGOP9mIHvtapFQ0LKvCow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166253; c=relaxed/simple;
	bh=gJ1ibdZq5DLD6ML91YfAivFjEZvpbtq1ja6dZ3n4Wf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R0XIxHCHBVVvwEEXQI9Sdo1c+xuEVEUx4QVrUy6bdgl+FIxtnKVRxMWgqYLwjozdnKzp5yp6+SRG8+nK47a7H7KIMRHrrLAxMEhTI5sXZyudJ0LydPB8vPQxbnA6JyTO8PLaRtURTRb38VUSmYDNYx2NAbSoJmz9ZiFwRjStqxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=SL9NqyaD; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733166250;
	bh=gJ1ibdZq5DLD6ML91YfAivFjEZvpbtq1ja6dZ3n4Wf8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SL9NqyaDt3u38FIX6iK+hmjPn/aA3LS3sfoEua5p+BMLYZtRlkSFmXm4RNDAt0xXJ
	 zmps5aLd3AH2O0QENgh74CKVVV0ZHKe6JxnySj13lOtfVVjRv1W+8f9WVN0UCRjm/p
	 Gn3Ay32JSn0DRgTLn63j+aCmR1q+O9akz+QX9cPA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Dec 2024 20:04:11 +0100
Subject: [PATCH 3/3] ACPI: sysfs: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241202-sysfs-const-bin_attr-acpi-v1-3-78f3b38d350d@weissschuh.net>
References: <20241202-sysfs-const-bin_attr-acpi-v1-0-78f3b38d350d@weissschuh.net>
In-Reply-To: <20241202-sysfs-const-bin_attr-acpi-v1-0-78f3b38d350d@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733166249; l=1940;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=gJ1ibdZq5DLD6ML91YfAivFjEZvpbtq1ja6dZ3n4Wf8=;
 b=Wx1C36bm9gP6DQ0RuCsGUwhtDnmDmTnluUEd43JfMdC3WB9zO5zBu/zJ/qmu/0n5jl55NTbYZ
 a59gQA39p/YAgCoEBUPL7OqNLB8iEFxkqb6+0W4iKamA+zFmsvNYmjB
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 687524b5008592c58c021f9c7981b76eaa58038f..a48ebbf768f91ab354cd276f1b4dda2c063ef9b5 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -319,7 +319,7 @@ struct acpi_data_attr {
 };
 
 static ssize_t acpi_table_show(struct file *filp, struct kobject *kobj,
-			       struct bin_attribute *bin_attr, char *buf,
+			       const struct bin_attribute *bin_attr, char *buf,
 			       loff_t offset, size_t count)
 {
 	struct acpi_table_attr *table_attr =
@@ -372,7 +372,7 @@ static int acpi_table_attr_init(struct kobject *tables_obj,
 	}
 
 	table_attr->attr.size = table_header->length;
-	table_attr->attr.read = acpi_table_show;
+	table_attr->attr.read_new = acpi_table_show;
 	table_attr->attr.attr.name = table_attr->filename;
 	table_attr->attr.attr.mode = 0400;
 
@@ -412,7 +412,7 @@ acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context)
 }
 
 static ssize_t acpi_data_show(struct file *filp, struct kobject *kobj,
-			      struct bin_attribute *bin_attr, char *buf,
+			      const struct bin_attribute *bin_attr, char *buf,
 			      loff_t offset, size_t count)
 {
 	struct acpi_data_attr *data_attr;
@@ -495,7 +495,7 @@ static int acpi_table_data_init(struct acpi_table_header *th)
 			if (!data_attr)
 				return -ENOMEM;
 			sysfs_attr_init(&data_attr->attr.attr);
-			data_attr->attr.read = acpi_data_show;
+			data_attr->attr.read_new = acpi_data_show;
 			data_attr->attr.attr.mode = 0400;
 			return acpi_data_objs[i].fn(th, data_attr);
 		}

-- 
2.47.1


