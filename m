Return-Path: <linux-acpi+bounces-838-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DD07D3017
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 12:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2B71C208F0
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 10:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE36214A90
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YBhUuWgp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02ECF50E
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 08:45:03 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A245CAF;
	Mon, 23 Oct 2023 01:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Apd3KeJ8uuP3OQFLQ5TzxVCBAuh86rEsBBY3n1LtHcM=; b=YBhUuWgpNULl2044fpGJ/4RiyU
	W2ygtuqlY99XtPXYBTEzLjRfuXprkm+9j4t032PBXwks89r8Z2UW0gWBXD81t1AKXGEa23oSnZ2Ac
	fy44mvrrt1gfHfc8UFjdtlb9+ta7o1rlQhgpBZVvUPoOSNxT+NFC3RVWyzyv7RLOEghIH25YZQe1W
	ZNdTbpo5oGx/qPAhtLcliiECxKCJOFs9jPB6FQBDw4kMfy3eoHHpTjQphSdbcucZfc6ejZ+hPA3LL
	2CCikNXWTwCOrL4Sya5hdrgRD431/EbkJNy4a0c3U2bWPdaEaPH/7yQ+Jo+qll7sVFEAFfRwiYYq+
	lQ0ZeaKg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37836)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1quqYO-0002gI-2k;
	Mon, 23 Oct 2023 09:44:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1quqYN-0004g0-0h; Mon, 23 Oct 2023 09:44:51 +0100
Date: Mon, 23 Oct 2023 09:44:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Gavin Shan <gshan@redhat.com>
Cc: James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com
Subject: Re: [RFC PATCH v2 24/35] drivers: base: Implement weak
 arch_unregister_cpu()
Message-ID: <ZTYygtKt4w9C0Oxw@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-25-james.morse@arm.com>
 <8be3a9dc-8f59-9ef9-3662-95814e177125@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8be3a9dc-8f59-9ef9-3662-95814e177125@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 19, 2023 at 10:59:23AM +1000, Gavin Shan wrote:
> On 9/14/23 02:38, James Morse wrote:
> > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > index 677f963e02ce..c709747c4a18 100644
> > --- a/drivers/base/cpu.c
> > +++ b/drivers/base/cpu.c
> > @@ -531,7 +531,14 @@ int __weak arch_register_cpu(int cpu)
> >   {
> >   	return register_cpu(&per_cpu(cpu_devices, cpu), cpu);
> >   }
> > -#endif
> > +
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +void __weak arch_unregister_cpu(int num)
> > +{
> > +	unregister_cpu(&per_cpu(cpu_devices, num));
> > +}
> > +#endif /* CONFIG_HOTPLUG_CPU */
> > +#endif /* CONFIG_GENERIC_CPU_DEVICES */
> 
> It seems conflicting with its declaration in include/linux/cpu.h.

How so? The declaration is:

extern void arch_unregister_cpu(int cpu);

So:

void __weak arch_unregister_cpu(int num)

is compatible.

> Besides, the function is still needed by
> drivers/acpi/acpi_processor.c::acpi_processor_make_not_present()
> even both CONFIG_HOTPLUG_CPU and CONFIG_GENERIC_CPU_DEVICES are disabled?

Yes, I agree - it needs to be present when ACPI is built, so I'm
thinking the right solution is to move it out from under at least
CONFIG_HOTPLUG_CPU.

It can't be moved out from under CONFIG_GENERIC_CPU_DEVICES because
then we end up referencing the per-cpu variable cpu_devices which only
exists when CONFIG_GENERIC_CPU_DEVICES is enabled. Is that a problem
though, because in the case of !CONFIG_GENERIC_CPU_DEVICES, aren't
architectures required to provide both arch_.*register_cpu() functions?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

