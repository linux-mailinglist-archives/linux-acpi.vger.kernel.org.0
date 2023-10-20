Return-Path: <linux-acpi+bounces-824-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF45C7D1715
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 22:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C712B214BC
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 20:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5ED249FC
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 20:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LtdVRAzT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE01200C1
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 18:47:10 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8677D7;
	Fri, 20 Oct 2023 11:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p30D1Q3zE2qXAXYR3qzel/vvewRxpsqtgQHCmqUYVEc=; b=LtdVRAzT/5ZWoDw0QQ+xhklB9/
	890ErFfVXqWVySS3OHD9I/gJXfSDCp+LFYKEA06AQdIWecu1WiROyi+hxGDfFV/1Exv8Gt3xM4/Zp
	jrrxGUmPkdG5J+IZajAAnmyd74VJlPHVEd6cHT8P3HuEtGZFu4nHStDWYitjNYhSEtsZEfsaTRmW2
	AKBY6J/S0UG58H67P4/tHOxwhdmNloeKleBA3MmXYEClCEnkM9S/Vl6Ya8vvoa7doTjRHhEfQKzy9
	U2guXWrehQ2IB+qYklB2lYQl+pAwQlvbd1NpxiUJzLoUnup9N6znXpEammjKwPoK/XzTHp7WIHJpj
	8IuirCgg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59232 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qtuWU-0000mU-1u;
	Fri, 20 Oct 2023 19:47:02 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qtuWW-00AQ7P-0W; Fri, 20 Oct 2023 19:47:04 +0100
From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To: linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc: x86@kernel.org, James Morse <james.morse@arm.com>, Salil Mehta
	<salil.mehta@huawei.com>, Jonathan Cameron
	<Jonathan.Cameron@Huawei.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com,
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: Rename acpi_scan_device_not_present() to be about
 enumeration
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qtuWW-00AQ7P-0W@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 20 Oct 2023 19:47:04 +0100

From: James Morse <james.morse@arm.com>

acpi_scan_device_not_present() is called when a device in the
hierarchy is not available for enumeration. Historically enumeration
was only based on whether the device was present.

To add support for only enumerating devices that are both present
and enabled, this helper should be renamed. It was only ever about
enumeration, rename it acpi_scan_device_not_enumerated().

No change in behaviour is intended.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
This is another patch from James' aarch64 hotplug vcpu series.

I asked:
> Is this another patch which ought to be submitted without waiting
> for the rest of the series?
to which Jonathan Cameron replied:
> Looks like a valid standalone change to me.

So let's get this queued up.

 drivers/acpi/scan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ed01e19514ef..17ab875a7d4e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -289,10 +289,10 @@ static int acpi_scan_hot_remove(struct acpi_device *device)
 	return 0;
 }
 
-static int acpi_scan_device_not_present(struct acpi_device *adev)
+static int acpi_scan_device_not_enumerated(struct acpi_device *adev)
 {
 	if (!acpi_device_enumerated(adev)) {
-		dev_warn(&adev->dev, "Still not present\n");
+		dev_warn(&adev->dev, "Still not enumerated\n");
 		return -EALREADY;
 	}
 	acpi_bus_trim(adev);
@@ -327,7 +327,7 @@ static int acpi_scan_device_check(struct acpi_device *adev)
 			error = -ENODEV;
 		}
 	} else {
-		error = acpi_scan_device_not_present(adev);
+		error = acpi_scan_device_not_enumerated(adev);
 	}
 	return error;
 }
@@ -339,7 +339,7 @@ static int acpi_scan_bus_check(struct acpi_device *adev, void *not_used)
 
 	acpi_bus_get_status(adev);
 	if (!acpi_device_is_present(adev)) {
-		acpi_scan_device_not_present(adev);
+		acpi_scan_device_not_enumerated(adev);
 		return 0;
 	}
 	if (handler && handler->hotplug.scan_dependent)
-- 
2.30.2


