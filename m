Return-Path: <linux-acpi+bounces-6147-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E268D8B11
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2024 22:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD63F1F2100A
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2024 20:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3900F13959B;
	Mon,  3 Jun 2024 20:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZkj8qUa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED9FB651
	for <linux-acpi@vger.kernel.org>; Mon,  3 Jun 2024 20:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717447863; cv=none; b=i6h00UgGvN/IZkbW6bDUQO/7OrzaqCUYTg3ecbQYs6DeKYA3K5fTLJa/rp6tTBeP88C5cUv+X51HH2qKWpfWuNuK3cAQ5hzpfCEHJvuf515xlW3Oeg8VfZcXDr6U1TJy7k6eJsX8hmg8MoNueOs2Xa2b/zCtx2ZfEYAYdkvATac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717447863; c=relaxed/simple;
	bh=unDaOeY2f1Ime1NC/i6r4nmlvC92sp9KHWcJMQqUEWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FHzGnutzgVfwg5Hm3SEjSpMUeT/UwMbBM2KnUVM/s12Q5POACr+sOenTz0D9ixZBaISBCFwLvbTcK7yKkOO0GeUV7LzIvDLu8zIUgJGaNzQQEhM/bkBTbb+prB888uJv9Q0ii/MrBs4o7+4r9rzbCbRq50bxzazlBTDtG69vdu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZkj8qUa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717447860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vzmMB6XxXPRXSfazlmTWuRuS8YfP5O1rWg9B1xuk3S0=;
	b=LZkj8qUaP4vQVaNt25eJy+du5HNOnHtm9+3q14c5PsOgfghUkc/VvXevbRlE+ZtUNaHAX6
	fKBUHXPV7Xq7SvTFwmVjnOP6nUw/WiU8D0nouscv3av9vLlWiHsmA+HvJ+KRop/2yYBA+A
	4JLsucl8Z0/eNLRrwgBf5oO7Rma/Eh0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-LGq5ZXZJPCe3-Z0hkAw-HA-1; Mon,
 03 Jun 2024 16:50:56 -0400
X-MC-Unique: LGq5ZXZJPCe3-Z0hkAw-HA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D44651913F5A;
	Mon,  3 Jun 2024 20:50:54 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.102])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F5081956087;
	Mon,  3 Jun 2024 20:50:51 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Wentong Wu <wentong.wu@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org,
	Kate Hsuan <hpa@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mei: vsc: Fix wrong invocation of ACPI SID method
Date: Mon,  3 Jun 2024 22:50:50 +0200
Message-ID: <20240603205050.505389-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

When using an initializer for a union only one of the union members
must be initialized. The initializer for the acpi_object union variable
passed as argument to the SID ACPI method was initializing both
the type and the integer members of the union.

Unfortunately rather then complaining about this gcc simply ignores
the first initializer and only used the second integer.value = 1
initializer. Leaving type set to 0 which leads to the argument being
skipped by acpi acpi_ns_evaluate() resulting in:

ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments -
Caller passed 0, method requires 1 (20240322/nsarguments-232)

Fix this by initializing only the integer struct part of the union
and initializing both members of the integer struct.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Even though this is a one-liner, figuring out what was actually going
wrong here took quite a while.
---
 drivers/misc/mei/vsc-fw-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/vsc-fw-loader.c b/drivers/misc/mei/vsc-fw-loader.c
index ffa4ccd96a10..596a9d695dfc 100644
--- a/drivers/misc/mei/vsc-fw-loader.c
+++ b/drivers/misc/mei/vsc-fw-loader.c
@@ -252,7 +252,7 @@ static int vsc_get_sensor_name(struct vsc_fw_loader *fw_loader,
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER };
 	union acpi_object obj = {
-		.type = ACPI_TYPE_INTEGER,
+		.integer.type = ACPI_TYPE_INTEGER,
 		.integer.value = 1,
 	};
 	struct acpi_object_list arg_list = {
-- 
2.45.1


