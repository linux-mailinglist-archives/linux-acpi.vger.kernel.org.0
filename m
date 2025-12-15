Return-Path: <linux-acpi+bounces-19577-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9678CBE716
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 15:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43F66302A744
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 14:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA66334C29;
	Mon, 15 Dec 2025 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJy3+6pE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EF1334C27;
	Mon, 15 Dec 2025 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807449; cv=none; b=RwdFlljMAXr1YpI2m15o2VTHIt8iIF7zxpK8u34eSpN8JY1muNOiL+2V4W/djIWd5svQ7z36xM903PDyIKiTKODIbiMDMhIHfapH7CagWJr2IRb1cEkQp4pxgqjOjLmzY1CGf2M85UbRbCR0bs1/DMn3j69/bJ1+vIWaWGRswsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807449; c=relaxed/simple;
	bh=bcqGWaGmZ5OS5fkW7+f1DKMNmvyqnmjlXCbg+TrqnIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rt3hpxDvJ0VXIQ0ZhZFSoiZE0uRegMdG3vP3cf8Q7bUUIKj0oi7rSRS2X7ax99bzlfiDjDHtU6eV686rnQpJjtonD+yz6iDJEMDQDf7kdOeQ+V2qr33Ff6xUjPJjIhnr/Lmap7XScsvVqFtYSZSw8r4PmI/iekA90HmB3HLdRtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJy3+6pE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9488C4CEF5;
	Mon, 15 Dec 2025 14:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807448;
	bh=bcqGWaGmZ5OS5fkW7+f1DKMNmvyqnmjlXCbg+TrqnIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJy3+6pEWBAvdjopzurM+VBv2JG+WK+hJubEt2mawZpoSm2REky/1L3A0o01/tMTa
	 9ZKpRIK5Kk92xc6mZPnFU14d72gNz4u4+y3V3Xvm2NfXFd9uu/xajxeifZDUFk9Pay
	 kY99xsInMnv9q2jgHVo7/2XgELdF3Ae5zsuv6Ezh36ZPXqdI5qAj+qDZp+9vnCAhJU
	 1nO+FWoH79t1FBv1KuSoeTTnOuA1Q3g/CtOUcsW2PX7IcmRPrVYaiyNyqOG8EIvOK1
	 Uyoyy7pyrLay99jWeikpS60SmY4+4iznC05H5Rrv/9yXj0EzItV0hRWEaxrHg8DtiP
	 nP/uqsa6brBQw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v2 09/10] ACPI: battery: Reduce code duplication related to cleanup
Date: Mon, 15 Dec 2025 15:02:37 +0100
Message-ID: <1866517.TLkxdtWsSY@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2685338.Lt9SDvczpP@rafael.j.wysocki>
References: <2685338.Lt9SDvczpP@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that sysfs_battery_cleanup() calls sysfs_remove_battery() under
battery->update_lock which is also done in acpi_battery_remove(), so
adjust the latter to use it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/acpi/battery.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1279,9 +1279,7 @@ static void acpi_battery_remove(struct a
 	device_init_wakeup(&device->dev, 0);
 	unregister_pm_notifier(&battery->pm_nb);
 
-	guard(mutex)(&battery->update_lock);
-
-	sysfs_remove_battery(battery);
+	sysfs_battery_cleanup(battery);
 }
 
 /* this is needed to learn about changes made in suspended state */




