Return-Path: <linux-acpi+bounces-1179-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABB37E02ED
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 13:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265591C20910
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 12:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8785117737
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="biXWhoSA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0801B14276
	for <linux-acpi@vger.kernel.org>; Fri,  3 Nov 2023 10:55:04 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BA4187;
	Fri,  3 Nov 2023 03:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Um8xrYpMdBObopBnzerBAfI2E5OpRpvtMoUTBQ8de/k=; b=biXWhoSA7RtRlMm4H8bTZkOGpu
	VCIAeKrLBRWO4+pK0QhXJWI99kBjB6fc/wAUsF/tAwtrKNXBevQKHGX626hnZ6X7y0f6FcbV5XYJK
	8dvM5fW0ABhIGGjEns7PCZis9nIpcj+ZBIDTxuFwX2cuBn0JMrYn3E1fGkb2/BgchWNW7OemtET7s
	DGWDDMxcFKs0nMB8nnLr5Dn5k5TClKxV/mR++dVwpp9vc5RxsMy2EFCNf6fbQyjQsdZY1+IKTNDDO
	mJcygAudTSh9qFVs4VZiErGDAKvXunOArZhc34Y+i8pL+CvmXRJfRcxNGsrP1+zuuMzxnoeRgR2wU
	ttfAoolA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43298)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qyrpH-0005SE-0p;
	Fri, 03 Nov 2023 10:54:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qyrpI-0008Kv-8X; Fri, 03 Nov 2023 10:54:56 +0000
Date: Fri, 3 Nov 2023 10:54:56 +0000
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
Subject: Re: [RFC PATCH v2 15/35] ACPI: processor: Add support for processors
 described as container packages
Message-ID: <ZUTRgNtpcVtcMFqJ@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-16-james.morse@arm.com>
 <50571c2f-aa3c-baeb-3add-cd59e0eddc02@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50571c2f-aa3c-baeb-3add-cd59e0eddc02@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Sep 18, 2023 at 03:02:53PM +1000, Gavin Shan wrote:
> 
> On 9/14/23 02:38, James Morse wrote:
> > ACPI has two ways of describing processors in the DSDT. Either as a device
> > object with HID ACPI0007, or as a type 'C' package inside a Processor
> > Container. The ACPI processor driver probes CPUs described as devices, but
> > not those described as packages.
> > 
> > Duplicate descriptions are not allowed, the ACPI processor driver already
> > parses the UID from both devices and containers. acpi_processor_get_info()
> > returns an error if the UID exists twice in the DSDT.
> > 
> > The missing probe for CPUs described as packages creates a problem for
> > moving the cpu_register() calls into the acpi_processor driver, as CPUs
> > described like this don't get registered, leading to errors from other
> > subsystems when they try to add new sysfs entries to the CPU node.
> > (e.g. topology_sysfs_init()'s use of topology_add_dev() via cpuhp)
> > 
> > To fix this, parse the processor container and call acpi_processor_add()
> > for each processor that is discovered like this. The processor container
> > handler is added with acpi_scan_add_handler(), so no detach call will
> > arrive.
> > 
> > Qemu TCG describes CPUs using packages in a processor container.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >   drivers/acpi/acpi_processor.c | 22 ++++++++++++++++++++++
> >   1 file changed, 22 insertions(+)
> > 
> 
> I don't understand the last sentence of the commit log. QEMU
> always have "ACPI0007" for the processor devices.

I think what James is referring to is the use of Processor Containers
(see
https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#processor-container-device)

which are defined using HID ACPI0010. This seems to be what
build_cpus_aml() is doing. It creates:

	\_SB.CPUS - processor container with ACPI0010

and then builds the processor devices underneath that object using
ACPI0007.

I think the use of "packages" there is wrong, it should be "processor
devices" - taking the terminology from the above specification link.
As far as I can see, QEMU does not (yet) use the option of embedding
child processor containers beneath a parent.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

