Return-Path: <linux-acpi+bounces-880-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B347D4FE4
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 14:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A0BB209F8
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 12:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199F7273CB
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZVtRI3i8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE9023A7
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 11:29:10 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6FD128;
	Tue, 24 Oct 2023 04:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p9Xk6+oVu2eZSCHniKsbVUw777g3shFxugtPS4C2Azc=; b=ZVtRI3i8atfSABmwqYOam92raQ
	sGbWV0A3UKiGLSAkdhisvJ/Q3AW4A8vqe+K9zP0mN5nimUsw9Q/zg1bAMTEvwX3VL9oPE208SBLW5
	CdkR3e9MhuDKI0nOCcqkMgGfjmaH0CjVXYUptjRbTY24/ebqcC69b3MRM7jiKvWj/Z8icCFy6dtK+
	hmRSLuuC/iJ9jau8xMEmZGgM8xSCFtfxZxyNWuwijdN5Pmzom9RlONQ+ddjwAj+YxHH8f4rP9LN8b
	jx5jcWOGsmFNUeFBI7LlmTTt5LkAl3+llaabm8ykn15h2Okzsikzg1rvRM/CnB5RupJcx2+whac05
	/7r1Emsw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47178)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qvFal-00045E-1p;
	Tue, 24 Oct 2023 12:28:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qvFaj-0005rQ-FG; Tue, 24 Oct 2023 12:28:57 +0100
Date: Tue, 24 Oct 2023 12:28:57 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Miguel Luis <miguel.luis@oracle.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>,
	James Morse <james.morse@arm.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	"jianyong.wu@arm.com" <jianyong.wu@arm.com>,
	"justin.he@arm.com" <justin.he@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Rename acpi_scan_device_not_present() to be about
 enumeration
Message-ID: <ZTeqeRRbJgEdbMV3@shell.armlinux.org.uk>
References: <E1qtuWW-00AQ7P-0W@rmk-PC.armlinux.org.uk>
 <5589E5A5-9F97-416A-9C48-9828B0BE58CD@oracle.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5589E5A5-9F97-416A-9C48-9828B0BE58CD@oracle.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 24, 2023 at 10:15:07AM +0000, Miguel Luis wrote:
> Hi Russell,
> 
> > On 20 Oct 2023, at 18:47, Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > 
> > From: James Morse <james.morse@arm.com>
> > 
> > acpi_scan_device_not_present() is called when a device in the
> > hierarchy is not available for enumeration. Historically enumeration
> > was only based on whether the device was present.
> > 
> > To add support for only enumerating devices that are both present
> > and enabled, this helper should be renamed. It was only ever about
> > enumeration, rename it acpi_scan_device_not_enumerated().
> > 
> > No change in behaviour is intended.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Fixes: 443fc8202272 ("ACPI / hotplug: Rework generic code to handle suprise removals”) ?

I'm not sure a patch that is merely renaming a function should ever
have a Fixes tag, since it's just a naming issue, it doesn't fix a
bug, change functionality or anything like that.

I would suggest that there would need to be good reason why such a
patch should be backported to stable kernels - for example, something
else that does fix a user visible bug requires this change.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

