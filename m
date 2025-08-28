Return-Path: <linux-acpi+bounces-16135-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A269B39AEE
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 13:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EEC560747
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 11:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555C030E0C5;
	Thu, 28 Aug 2025 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJVbwR9E"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AC430DD11;
	Thu, 28 Aug 2025 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378999; cv=none; b=uzlujb5HQ5FUxESW5Jm3IQEW6Ofl4sOOuvw4pZdNZeCe57i20PsCTjuwOMuVq9GEdpy19EyoFipqe5N51/MrKk5z5doWzXh1Nkc2dtnQuLPrvRszk40MudHmswZIkZ5v0T1mC3O76Z4EQzFQaJpCG7MzfbY+6HkjsOqS8LyISYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378999; c=relaxed/simple;
	bh=pjzAij7OpPaAmTNVqtQzbQpcumXq8d1CkhrUy4uidvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QkaYCquSMIW6/Y0YJbJuaLcNZjUeeZHNbm9CykDJBmsyTDktCfY65U9CqwQn/jnY7UHFUKdyvMoTnNvH3u92uc2kHNvlLCQYymcvNDrTmWo876lRe3/xbkN4gAJ6zmwVBsqpfpaie96+RMceTBnnc5Bf9HzZ9J+/qW8nNYagoso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJVbwR9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FD0C4CEF6;
	Thu, 28 Aug 2025 11:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756378998;
	bh=pjzAij7OpPaAmTNVqtQzbQpcumXq8d1CkhrUy4uidvo=;
	h=From:To:Cc:Subject:Date:From;
	b=iJVbwR9Ey1vPlkNXduKN6HwFO8hqpA39J8h7gOCQX34bfvbjY1IXJU3fzrOxt5ziw
	 QQ2pIEY3VzMcpcUtH6YoQMqRNIz+83+sWXN4L1tUjuj8YOwUMsC0TUJEOaJtrZEKaB
	 atOtmQ59xeHFS5OCJdfaB/PGydTHHdLZXQv/nvxnh4xKiYhwVtllS1rCKjWoggX/SW
	 no2IbAY6HdTfRhaeOizQS+hW2r7UYD/J6akhL6buCNrxtl51EcfntjWy3COHgmE3/2
	 Q7sWAQxDB1JYRrW77fzV8uCy3b3vgXz5r1XOx9SOSd0cYj5AKc9V4ZRiH8DyHS+wm8
	 SlEbbF4CHV2+Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1] ACPI: fan: Fold two simple functions into their only caller
Date: Thu, 28 Aug 2025 13:03:13 +0200
Message-ID: <3386797.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Both acpi_fan_has_fst() and acpi_fan_is_acpi4() are called from one
place only, so fold them both into there caller which yields slightly
leaner code that is somewhat easier to follow.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/fan_core.c |   18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -203,18 +203,6 @@
  * --------------------------------------------------------------------------
 */
 
-static bool acpi_fan_has_fst(struct acpi_device *device)
-{
-	return acpi_has_method(device->handle, "_FST");
-}
-
-static bool acpi_fan_is_acpi4(struct acpi_device *device)
-{
-	return acpi_has_method(device->handle, "_FIF") &&
-	       acpi_has_method(device->handle, "_FPS") &&
-	       acpi_has_method(device->handle, "_FSL");
-}
-
 static int acpi_fan_get_fif(struct acpi_device *device)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -331,9 +319,11 @@
 	device->driver_data = fan;
 	platform_set_drvdata(pdev, fan);
 
-	if (acpi_fan_has_fst(device)) {
+	if (acpi_has_method(device->handle, "_FST")) {
 		fan->has_fst = true;
-		fan->acpi4 = acpi_fan_is_acpi4(device);
+		fan->acpi4 = acpi_has_method(device->handle, "_FIF") &&
+				acpi_has_method(device->handle, "_FPS") &&
+				acpi_has_method(device->handle, "_FSL");
 	}
 
 	if (fan->acpi4) {




