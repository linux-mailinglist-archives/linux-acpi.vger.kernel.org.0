Return-Path: <linux-acpi+bounces-1182-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B594C7E04BC
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 15:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F8A281DDF
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 14:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E01A58D
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC84168CC
	for <linux-acpi@vger.kernel.org>; Fri,  3 Nov 2023 12:52:37 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E23FCE;
	Fri,  3 Nov 2023 05:52:32 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SMLGZ168Hz6K982;
	Fri,  3 Nov 2023 20:51:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 3 Nov
 2023 12:52:29 +0000
Date: Fri, 3 Nov 2023 12:52:28 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: James Morse <james.morse@arm.com>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	<jianyong.wu@arm.com>, <justin.he@arm.com>
Subject: Re: [RFC PATCH v2 15/35] ACPI: processor: Add support for
 processors described as container packages
Message-ID: <20231103125228.00005c94@Huawei.com>
In-Reply-To: <ZUTOwuZVLvzptuuP@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
	<20230913163823.7880-16-james.morse@arm.com>
	<20230914145353.000072e2@Huawei.com>
	<ZUTOwuZVLvzptuuP@shell.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

On Fri, 3 Nov 2023 10:43:14 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Thu, Sep 14, 2023 at 02:53:53PM +0100, Jonathan Cameron wrote:
> > On Wed, 13 Sep 2023 16:38:03 +0000
> > James Morse <james.morse@arm.com> wrote:
> >   
> > > ACPI has two ways of describing processors in the DSDT. Either as a device
> > > object with HID ACPI0007, or as a type 'C' package inside a Processor
> > > Container. The ACPI processor driver probes CPUs described as devices, but
> > > not those described as packages.
> > >   
> > 
> > Specification reference needed...
> > 
> > Terminology wise, I'd just refer to Processor() objects as I think they
> > are named objects rather than data terms like a package (Which include
> > a PkgLength etc)  
> 
> I'm not sure what kind of reference you want for the above. Looking in
> ACPI 6.5, I've found in 5.2.12:
> 
> "Starting with ACPI Specification 6.3, the use of the Processor() object
> was deprecated. Only legacy systems should continue with this usage. On
> the Itanium architecture only, a _UID is provided for the Processor()
> that is a string object. This usage of _UID is also deprecated since it
> can preclude an OSPM from being able to match a processor to a
> non-enumerable device, such as those defined in the MADT. From ACPI
> Specification 6.3 onward, all processor objects for all architectures
> except Itanium must now use Device() objects with an _HID of ACPI0007,
> and use only integer _UID values."
> 
> Also, there is:
> 
> https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#declaring-processors

That pair of refs, just as 'where to look if you care' cross references, seem
to cover it as well as possible.

> 
> Unfortunately, using the search facility on that site to try and find
> Processor() doesn't work - it appears to strip the "()" characters from
> the search (which is completely dumb, why do search facilities do that?)

Yeah. Not great.

> 
> > > The missing probe for CPUs described as packages creates a problem for
> > > moving the cpu_register() calls into the acpi_processor driver, as CPUs
> > > described like this don't get registered, leading to errors from other
> > > subsystems when they try to add new sysfs entries to the CPU node.
> > > (e.g. topology_sysfs_init()'s use of topology_add_dev() via cpuhp)
> > > 
> > > To fix this, parse the processor container and call acpi_processor_add()
> > > for each processor that is discovered like this. The processor container
> > > handler is added with acpi_scan_add_handler(), so no detach call will
> > > arrive.
> > > 
> > > Qemu TCG describes CPUs using packages in a processor container.  
> > 
> > processor terms in a processor container.   
> 
> Are you wanting this to be:
> 
> "Qemu TCG describes CPUs using processor terms in a processor
> container."
> 
> ? Searching the ACPI spec for "processor terms" (with or without quotes)
> only brings up results for "terms" - yet another reason to hate site-
> provided search facilities, I don't know why sites bother. :(
Yup. I just use the PDFs partly for that reason.

Not possible to find in 6.5 because as it's deprecated they removed the information..
Look at ACPI 6.3 and there is 19.6.108 Processor (Declare Processor)
deep in the ASL operator reference

Wording wise I'm not sure exactly what they should be other than they
aren't packages (if my rough ASL understanding is right).
Different byte encoding.

Jonathan



> 


