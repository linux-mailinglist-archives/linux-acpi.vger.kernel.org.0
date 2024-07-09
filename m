Return-Path: <linux-acpi+bounces-6828-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F67F92C4AB
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2024 22:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4C2284036
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2024 20:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AD2185625;
	Tue,  9 Jul 2024 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dG40KnSp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8268518002F;
	Tue,  9 Jul 2024 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557504; cv=none; b=HAXWhwzXQHdu1h+uIzSp5yUTlsvm88wh4G5Hg1h+IIweUK7DETzhmOSHS+XQdubXjoHujrQXPWkP1uuwqXyDbWvqKPe8Vq38FHCPK1dERiVORQig+rLdJirm1VuVihBqZZ6rH3J44CQOQ7oZrC9CnZyf6hWLemgnRRbBrnUlmi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557504; c=relaxed/simple;
	bh=4LOKIwPkfG4qv/qDrlGxW3TsoLB+emhFXbvx4Ix4Zk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rNDevLZDTxyCVlMBRc+WVet9mDFIz7dWoXC8Fs2qdFG7NyYi5PSmUZFbwFVKAVq21PIfuzIRiu6Lm/jLc4oguPniHFUpgt6J+P0i2ym/DNgCBUj+KsGlhrE0mGICBSE7kyUx62ANs57f5YYoi2hZvyYlUOHQshPzJXdIbiM+d3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dG40KnSp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1720557499;
	bh=4LOKIwPkfG4qv/qDrlGxW3TsoLB+emhFXbvx4Ix4Zk0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dG40KnSpTErTVkKTdq6BRp9NadeBRzRCaWTosI7Tk4miaSgMU5DWQ3YDJ8flzqxSq
	 pecskGFgWhodamgFdTf/PyATSfiuvRtjLyFek+lNzebuporQFrIS394sOKiD5BLjHq
	 TFUj94mQn0Gy57ANFUBOofRKbY+sLaToTC3pffeE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 09 Jul 2024 22:37:24 +0200
Subject: [PATCH v2 1/5] ACPI: sysfs: validate return type of _STR method
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240709-acpi-sysfs-groups-v2-1-058ab0667fa8@weissschuh.net>
References: <20240709-acpi-sysfs-groups-v2-0-058ab0667fa8@weissschuh.net>
In-Reply-To: <20240709-acpi-sysfs-groups-v2-0-058ab0667fa8@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Lance Ortiz <lance.ortiz@hp.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720557498; l=1077;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4LOKIwPkfG4qv/qDrlGxW3TsoLB+emhFXbvx4Ix4Zk0=;
 b=LEZeIImkrMhJWNTWnePl193SC5ykHqSmHMH0lFF8V6YtbXAs2SlU4XQBY/in1QpVwIYrpSUF/
 OYbf6q9I5wgDzFFsRO4cyIZQSRalkUg/SuoRcoHipm/3rernkKkInU9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Only buffer objects are valid return values of _STR.
If something else is returned description_show() will access invalid
memory.

Fixes: d1efe3c324ea ("ACPI: Add new sysfs interface to export device description")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/device_sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 23373faa35ec..95a19e3569c8 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -540,8 +540,9 @@ int acpi_device_setup_files(struct acpi_device *dev)
 	 * If device has _STR, 'description' file is created
 	 */
 	if (acpi_has_method(dev->handle, "_STR")) {
-		status = acpi_evaluate_object(dev->handle, "_STR",
-					NULL, &buffer);
+		status = acpi_evaluate_object_typed(dev->handle, "_STR",
+						    NULL, &buffer,
+						    ACPI_TYPE_BUFFER);
 		if (ACPI_FAILURE(status))
 			buffer.pointer = NULL;
 		dev->pnp.str_obj = buffer.pointer;

-- 
2.45.2


