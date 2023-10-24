Return-Path: <linux-acpi+bounces-911-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 172367D58BD
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 18:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476F21C20326
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB803A276
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KMVeJnaK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6546F31A89;
	Tue, 24 Oct 2023 15:18:15 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A537910E3;
	Tue, 24 Oct 2023 08:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=X5Z3Nkf5E4AARS+LHoFvElPsf0E44YGYiNzXX8jAQTI=; b=KMVeJnaKKwNEXhfQUmDrES4Snp
	XVvjqbxfqo6dLoYwamROVwhdcf+ZovVQJI7nDYDGQtcNIXjfIT8e7KsFeto4CPCANkXvu4t9K4Y+g
	8EGsTU5QpumHaaHipUSZyR13cFFVehwjO/0SFEc+a9oyQs8c2MGh5V3uwAXUPf7q0fXPquP3hLEJy
	Yzqs5yQ5uo1f5zI1l2MQZ9XL7/fXlSAGmRdqC0+pVYMp1Z9i9VoONTVYY/uld4OO+hy99c97jEcyL
	Hniy37vHKdoNG4BwZgaojb/AMgXRdKgZ2qQQjWXVjYQP8wKJN0AeDHybJXL9JPfGFMLw+qJ5Nr0tt
	HjcFxc7g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57434 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qvJAU-0004SZ-0c;
	Tue, 24 Oct 2023 16:18:06 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qvJAV-00AqR4-LS; Tue, 24 Oct 2023 16:18:07 +0100
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 23/39] drivers: base: Implement weak arch_unregister_cpu()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJAV-00AqR4-LS@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 24 Oct 2023 16:18:07 +0100

From: James Morse <james.morse@arm.com>

Add arch_unregister_cpu() to allow the ACPI machinery to call
unregister_cpu(). This is enough for arm64, riscv and loongarch, but
needs to be overridden by x86 and ia64 who need to do more work.

CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * Added CONFIG_HOTPLUG_CPU ifdeffery around unregister_cpu
Changes since RFC v2:
 * Move earlier in the series
---
 drivers/base/cpu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 6c70a004c198..2b9cb2667654 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -531,7 +531,14 @@ int __weak arch_register_cpu(int cpu)
 {
 	return register_cpu(&per_cpu(cpu_devices, cpu), cpu);
 }
-#endif
+
+#ifdef CONFIG_HOTPLUG_CPU
+void __weak arch_unregister_cpu(int num)
+{
+	unregister_cpu(&per_cpu(cpu_devices, num));
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+#endif /* CONFIG_GENERIC_CPU_DEVICES */
 
 static void __init cpu_dev_register_generic(void)
 {
-- 
2.30.2


