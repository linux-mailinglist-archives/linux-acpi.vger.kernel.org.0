Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C695140E96
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2020 17:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgAQQFG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Jan 2020 11:05:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbgAQQFG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Jan 2020 11:05:06 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D431020842;
        Fri, 17 Jan 2020 16:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579277105;
        bh=5lSOK5yogC8sv7K9RGzLvLKiw8y2/XaCPwmh5bPq2tE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KiIfEVI1g9Gu0OrDOkRaXNFG8y+maXE3WNxw+A0tDaXOOuvjMvavORVkVDx9sj5jn
         a1+RJE/qe8PHYhuFcqHj7ZYUfmvIwFLQvwaeOJV8868jOcztb5/XYkSx4Mu4jKiSjl
         AKS9Lr8IJjujZu699JqBSHhIO+fxp8cK6ghPDI/k=
Date:   Fri, 17 Jan 2020 10:05:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Subject: Re: [[RFC PATCH v1] 1/1] PCI: Add pci=nobbn to ignore ACPI _BBN
 method to override host bridge bus window
Message-ID: <20200117160502.GA92383@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB043839BFAE70C02DB13DEA4A80310@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[+cc Rafael, linux-acpi, start of thread at
https://lore.kernel.org/lkml/PSXP216MB0438F3D8C09957C6A45BC43D80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM/T/#u]

On Fri, Jan 17, 2020 at 03:00:11PM +0000, Nicholas Johnson wrote:
> On Thu, Jan 16, 2020 at 11:13:13PM +0100, Thomas Gleixner wrote:
> > Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au> writes:
> > 
> > > Add pci=nobbn kernel parameter.
> > >
> > > Override the host bridge bus resource to [bus 00-ff] when specified.
> > 
> > Fine, but you completely fail to explain why this is useful and why
> > someone would utilize this command line parameter.
>
> There are motherboards with single PCIe root complex which give 
> significantly less than [bus 00-ff] via CRS. I own one with [bus 00-7f] 
> and have seen some with significantly less.
> 
> A user who wants to use more busses than the motherboard advertises will 
> want to use this kernel parameter, for instance if they have a lot of 
> PCIe switches or Thunderbolt 3 devices.

I don't think this is a good idea.  "pci=nocrs" was mainly useful to
work around Linux defects in handling _CRS methods.  I don't think we
have comparable defects in our handling of _BBN.

In your example, the BIOS is telling us the bridge leads to [bus
00-7f].  We don't know what is at [bus 80-ff].  Maybe that range is
valid and usable, and maybe it's not.  It could be routed to a
different host bridge, it could contain devices the BIOS uses for its
own purposes, it could be completely invalid.

If we *did* decide this is a good idea, "nobbn" is a misleading name.
_BBN evaluates to a single bus number, not a range.  In your example,
BIOS is supplying _BBN=0 and _CRS that contains [bus 00-7f].  "nobbn"
suggests that'd we'd ignore _BBN.  But this patch actually ignores the
bus number range from _CRS, so it has nothing to do with _BBN.

> This is similar to how we have pci=nocrs to override motherboards with 
> issues. The bus resource is not overridden by pci=nocrs, even though it 
> will usually come from the same method. However, I believe it would be 
> unwise to change pci=nocrs to include bus resource, as detailed in my 
> original RFC.

For reference, I think this original RFC was
https://lore.kernel.org/r/PSXP216MB04385B2C1BB518E5219C30CE80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM

Bjorn
