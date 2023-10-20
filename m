Return-Path: <linux-acpi+bounces-810-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B357C7D141C
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF5D280ECF
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265591EA85
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rVOXFIRD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023E71E506
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 16:01:35 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1424B1A8;
	Fri, 20 Oct 2023 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kAvahHHmbmQJg7XXWX7xCp+JsudsIUFw/91YYiCGvlM=; b=rVOXFIRD/drr2GjPguWLWzMDAp
	VqxWnBsV16VBWYihs86BNVO+T7B1JRk0LuDq5k1AwFkBeKZfTGiSPSvDIlnKn+d+tayywS+N0aK3+
	Z92FQDj9K92vc5wOkAZuKuKDe4IVAtJVBYILQRSFfjVDVlyQB45harUe/20Nvy/q3q7OSpI1aRkyW
	aQz/NyaaRRP4uwN1yGv70t+N/3cMSBYZeymJzVwJ+IE1ddu0xYUO0srijRdPkOJeftGhkAq6Ae1Df
	nC0tNPMF8VjvumpEoCcuai01FUNot72556qR0hgt0JMKMqrT525N7jB+/fhzBaHY7xv55je4raUqe
	3IqqSIOg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38038)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qtrwH-0000d4-1s;
	Fri, 20 Oct 2023 17:01:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qtrwI-0001fQ-Iw; Fri, 20 Oct 2023 17:01:30 +0100
Date: Fri, 20 Oct 2023 17:01:30 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com
Subject: Re: [RFC PATCH v2 13/35] ACPI: Rename acpi_scan_device_not_present()
 to be about enumeration
Message-ID: <ZTKkWozjprMYLjay@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-14-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913163823.7880-14-james.morse@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 13, 2023 at 04:38:01PM +0000, James Morse wrote:
> acpi_scan_device_not_present() is called when a device in the
> hierarchy is not available for enumeration. Historically enumeration
> was only based on whether the device was present.
> 
> To add support for only enumerating devices that are both present
> and enabled, this helper should be renamed. It was only ever about
> enumeration, rename it acpi_scan_device_not_enumerated().
> 
> No change in behaviour is intended.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Is this another patch which ought to be submitted without waiting
for the rest of the series?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

