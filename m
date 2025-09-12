Return-Path: <linux-acpi+bounces-16792-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 456C8B5590B
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 00:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5793A3DDD
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 22:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDBF26C3BC;
	Fri, 12 Sep 2025 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5mKPOrd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C7424A046;
	Fri, 12 Sep 2025 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715544; cv=none; b=k2QH3v4E0HnBAN2mux07r7QC+8YxJN9PFHL5xF3ZZ8o4c1sktShkq7ySkwJPhcunqss/bXfCGE8xa/ZkU4ouN7rGwDoGR96ZZZkQ4A3RtpULBeXOlzyeB7d51sFKSKbwdANZEo5tqBtBwodPeUC6/Bbqh02oiPam8gpnq8WVNC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715544; c=relaxed/simple;
	bh=RbPveMq+wUujHCh2U8cE2C1bMP4tSmoOr+Umu0UNfzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kysSSbmSy3tYA2ohhB6UZIcFYCz5tq1XlAohZdeX8eBhNk2U48vNfUUQZHUp6Yy/dDnoDjS6QFrJ7htrusoviPJEgKhG2yj10OYvCY0lj5ORnvl8sly68mwN7fhhmF0tEeJRo1yv7+29kn/dQGiKW3cNAJmrYWFRtoyqdAp4Ank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5mKPOrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D98C4CEF1;
	Fri, 12 Sep 2025 22:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757715543;
	bh=RbPveMq+wUujHCh2U8cE2C1bMP4tSmoOr+Umu0UNfzg=;
	h=From:To:Cc:Subject:Date:From;
	b=O5mKPOrdXEOjALlLBJVr1vGQJXJcItEeixGlI+9dJg5I5QMN4C3sf5rHXczNa9wut
	 sZ/cezKIxekFgigOl8KyZ7KrkrqSJI3v3RehxpcjGqxRkJMPKB4CLWIu3Py+FGtqmp
	 tjFg/n9Orbh0F309UZHzWj0hnQaI7zYQKMO16o7iDf08PaugvitDBfBtWzp9TgnUvs
	 DbzS67V41iaiCsb+f0Uow0younCcOwgJyGG62eGHul9mNQ4ji6kXGx05VNgIYJ+i5r
	 g+/Z2i9QXmuuZYDLlLnifn48G8ft/7glnyxC2ooYXbsdwMyT9Ko/mqTtGaScbQDyUN
	 2MLFazUJ2BRxw==
From: Hans de Goede <hansg@kernel.org>
To: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [6.17 REGRESSION FIX] gpiolib: acpi: Fix using random stack memory during GPIO lookups
Date: Sat, 13 Sep 2025 00:18:59 +0200
Message-ID: <20250912221859.368173-1-hansg@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before commit 8b4f52ef7a41 ("gpiolib: acpi: Deduplicate some code in
__acpi_find_gpio()") and the follow-up fix commit 7c010d463372 ("gpiolib:
acpi: Make sure we fill struct acpi_gpio_info"). The struct acpi_gpio_info
used during lookups was part of struct acpi_gpio_lookup which gets
memset() to 0 before use.

And then after a successful lookup, acpi_gpio_resource_lookup() would
copy the content of the zeroed acpi_gpio_lookup.info to the on
stack struct acpi_gpio_info in __acpi_find_gpio(), overwriting any
uninitialized memory contents there.

But now instead a pointer to the on stack struct acpi_gpio_info in
__acpi_find_gpio() is passed around, but that struct is never
initialized.

This passing around of the uninitialized struct breaks index based
lookups of GpioInt GPIOs because info->quirks now contains some random
on stack data which may contain ACPI_GPIO_QUIRK_ONLY_GPIOIO.

Initialize the on stack struct acpi_gpio_info to 0 to fix this.

Fixes: 8b4f52ef7a41 ("gpiolib: acpi: Deduplicate some code in __acpi_find_gpio()")
Fixes: 7c010d463372 ("gpiolib: acpi: Make sure we fill struct acpi_gpio_info")
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/gpio/gpiolib-acpi-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 12b24a717e43..1cc5d0702ee1 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -942,7 +942,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 {
 	struct acpi_device *adev = to_acpi_device_node(fwnode);
 	bool can_fallback = acpi_can_fallback_to_crs(adev, con_id);
-	struct acpi_gpio_info info;
+	struct acpi_gpio_info info = { };
 	struct gpio_desc *desc;
 
 	desc = __acpi_find_gpio(fwnode, con_id, idx, can_fallback, &info);
-- 
2.51.0


