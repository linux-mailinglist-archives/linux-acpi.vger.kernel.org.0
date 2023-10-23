Return-Path: <linux-acpi+bounces-852-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7DB7D410E
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 22:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F8A28136B
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 20:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D81923749
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gtirJysC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7A41C295
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 18:58:48 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C09BA;
	Mon, 23 Oct 2023 11:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7A0pd5ea/mWj9XmmTvRG6wtE18VpprIFdxTUBKRhNM0=; b=gtirJysCoPrK4qOy7mI9wMUvVz
	P33fMEnvCKyA74eRCvoEqjBQtXgT+ZfZaYwQdCj+oxzxDcBug/ZRYPHaMwfrVDsRg+SeYQ4ERiw3e
	maPZCTvvgkS2b147zcO7rUOaomZAQ0kPL5PTN6DNCaANEnB1lTAFW0ykLuziDuf+Dy8K+AE8O2k19
	PvdUnlkuD7/LMRkrQnfpX5g/p4kiD3Mj609pBiwd4YrNm3Zrc0ezR23xIBfNb1xScxybdK96le6aG
	0NeJcWgxNT5jq7CPNUlJH/PqpwF9p1KbFSX+6WabCSjxQo+VlGAEyfwtwC06L6xyK1qMiXK41UoIG
	5ILYltUQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45546)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qv08O-0003OY-1Z;
	Mon, 23 Oct 2023 19:58:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qv08N-00052v-CV; Mon, 23 Oct 2023 19:58:39 +0100
Date: Mon, 23 Oct 2023 19:58:39 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com
Subject: Re: [RFC PATCH v2 29/35] irqchip/gic-v3: Don't return errors from
 gic_acpi_match_gicc()
Message-ID: <ZTbCX0n2SrhUBESf@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-30-james.morse@arm.com>
 <20230914160223.0000782f@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914160223.0000782f@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 14, 2023 at 04:02:23PM +0100, Jonathan Cameron wrote:
> On Wed, 13 Sep 2023 16:38:17 +0000
> James Morse <james.morse@arm.com> wrote:
> 
> > gic_acpi_match_gicc() is only called via gic_acpi_count_gicr_regions().
> > It should only count the number of enabled redistributors, but it
> > also tries to sanity check the GICC entry, currently returning an
> > error if the Enabled bit is set, but the gicr_base_address is zero.
> > 
> > Adding support for the online-capable bit to the sanity check
> > complicates it, for no benefit. The existing check implicitly
> > depends on gic_acpi_count_gicr_regions() previous failing to find
> > any GICR regions (as it is valid to have gicr_base_address of zero if
> > the redistributors are described via a GICR entry).
> > 
> > Instead of complicating the check, remove it. Failures that happen
> > at this point cause the irqchip not to register, meaning no irqs
> > can be requested. The kernel grinds to a panic() pretty quickly.
> > 
> > Without the check, MADT tables that exhibit this problem are still
> > caught by gic_populate_rdist(), which helpfully also prints what
> > went wrong:
> > | CPU4: mpidr 100 has no re-distributor!
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >  drivers/irqchip/irq-gic-v3.c | 18 ++++++------------
> >  1 file changed, 6 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index 72d3cdebdad1..0f54811262eb 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -2415,21 +2415,15 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
> >  
> >  	/*
> >  	 * If GICC is enabled and has valid gicr base address, then it means
> > -	 * GICR base is presented via GICC
> > +	 * GICR base is presented via GICC. The redistributor is only known to
> > +	 * be accessible if the GICC is marked as enabled. If this bit is not
> > +	 * set, we'd need to add the redistributor at runtime, which isn't
> > +	 * supported.
> >  	 */
> > -	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address) {
> > +	if (gicc->flags & ACPI_MADT_ENABLED && gicc->gicr_base_address)
> 
> Going in circles...

It does seem that way. Are you suggesting something should change here?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

