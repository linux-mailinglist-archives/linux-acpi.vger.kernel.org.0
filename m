Return-Path: <linux-acpi+bounces-917-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F8B7D58DA
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 18:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E107C2818B3
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C783B293
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="auysF/6+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C227234CCA;
	Tue, 24 Oct 2023 15:18:41 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C652718;
	Tue, 24 Oct 2023 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CNWnC0tTNPuhROu5TZS+GHZycyp85uHcS0xNgApILVE=; b=auysF/6+X5CraAmh0uKYn72RQz
	MfQ+xLXff/KeM/31BhutwoZlcL72VsQbyxNYq3dpn94RmvR3gmzahgotSLculfToabojp6EEyZ2qn
	gXb3+IOXviSlZB5Ikl332rb1KTNxRoI5072LJ+ChkAjxkM27BbXg+AqqA/PxH+e2ygHzHJSJHw6SU
	vLfpoLPWMHOeYX4g2KpWnoemI9zro0jUoTZLXP6R2edTeTUsYq8Ze5avqgEzJbM5Ei4p0XiHDyeVz
	GHzWsDQ1wGF4QbSlov9XA7q6VRoK6bL26dLVpFHWC461tnoZhCn0U3vH5yjb9eMKKJF6sg9i97tGe
	V+h4AODw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53116 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qvJAt-0004UN-31;
	Tue, 24 Oct 2023 16:18:32 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qvJAv-00AqRY-CI; Tue, 24 Oct 2023 16:18:33 +0100
In-Reply-To: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To: linux-pm@vger.kernel.org,
	 loongarch@lists.linux.dev,
	 linux-acpi@vger.kernel.org,
	 linux-arch@vger.kernel.org,
	 linux-kernel@vger.kernel.org,
	 linux-arm-kernel@lists.infradead.org,
	 linux-riscv@lists.infradead.org,
	 kvmarm@lists.linux.dev,
	 x86@kernel.org,
	 linux-csky@vger.kernel.org,
	 linux-doc@vger.kernel.org,
	 linux-ia64@vger.kernel.org,
	 linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
	 Jean-Philippe Brucker <jean-philippe@linaro.org>,
	 jianyong.wu@arm.com,
	 justin.he@arm.com,
	 James Morse <james.morse@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH 28/39] ACPI: Warn when the present bit changes but the feature
 is not enabled
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJAv-00AqRY-CI@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 24 Oct 2023 16:18:33 +0100

From: James Morse <james.morse@arm.com>

ACPI firmware can trigger the events to add and remove CPUs, but the
OS may not support this.

Print an error message when this happens.

This gives early warning on arm64 systems that don't support
CONFIG_ACPI_HOTPLUG_PRESENT_CPU, as making CPUs not present has
side effects for other parts of the system.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v2:
 * Update commit message with suggestion from Gavin Shan
---
 drivers/acpi/acpi_processor.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 19fceb3ec4e2..b7a94c1348b0 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -189,8 +189,10 @@ static int acpi_processor_make_present(struct acpi_processor *pr)
 	acpi_status status;
 	int ret;
 
-	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
+	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU)) {
+		pr_err_once("Changing CPU present bit is not supported\n");
 		return -ENODEV;
+	}
 
 	if (invalid_phys_cpuid(pr->phys_id))
 		return -ENODEV;
@@ -462,8 +464,10 @@ static void acpi_processor_make_not_present(struct acpi_device *device)
 {
 	struct acpi_processor *pr;
 
-	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
+	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU)) {
+		pr_err_once("Changing CPU present bit is not supported");
 		return;
+	}
 
 	pr = acpi_driver_data(device);
 	if (pr->id >= nr_cpu_ids)
-- 
2.30.2


