Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4FC2A3B3A
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Nov 2020 04:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgKCD4e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Nov 2020 22:56:34 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3263 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgKCD4e (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Nov 2020 22:56:34 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa0d4f40001>; Mon, 02 Nov 2020 19:56:36 -0800
Received: from nvdebian.localnet (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Nov
 2020 03:56:22 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Vikram Sethi <vsethi@nvidia.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>,
        Jeff Smith <JSMITH@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: Re: Onlining CXL Type2 device coherent memory
Date:   Tue, 3 Nov 2020 14:56:20 +1100
Message-ID: <6645807.zUfqAqQW0h@nvdebian>
In-Reply-To: <BL0PR12MB2532F7D105A1DC2E41B13DF2BD100@BL0PR12MB2532.namprd12.prod.outlook.com>
References: <BL0PR12MB25321C8689BAFDF8678E5C69BD170@BL0PR12MB2532.namprd12.prod.outlook.com> <CAPcyv4jvndnm986vjQLHOw=q0+rN8JDuJd4z-Bv3Wz06Wz4gug@mail.gmail.com> <BL0PR12MB2532F7D105A1DC2E41B13DF2BD100@BL0PR12MB2532.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604375796; bh=OTgDZIJKUAwFv/o/43m23Omi0oMh92bGj2BwjaK1VMg=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Transfer-Encoding:Content-Type:
         X-Originating-IP:X-ClientProxiedBy;
        b=mhDbKBRzCPjj3TI4rqSRrlHzuHdguUlyTlcCR4Q1DAsspbs90rPjxTmhfJFaB3E6/
         SMQLjxwdgVqO/St6VTrnvuPtT0s972Md3TXkAdKyKLzWBF0wWxOoQNpDZ85eGAGYOr
         Dp+M2sKxATR/MkZdxknCLdZ+CP2EfVoI/OJgYEsj4uSnwB/K/vXVcSB22f9O+Xpyp3
         cbijtVjQF5PzUq4G57vgYBpco3g54QdjyRrX2VkyNlnfiq+bSSl0zXIZHLwY/68wAZ
         1FPLPnXxEjvfTo2veQRM8sFTUn3cLlc1XrIelGzKB/2v+PTMSC8yYSs5r4X6b5WRaT
         sskP8tvTmAvyA==
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, 3 November 2020 6:25:23 AM AEDT Vikram Sethi wrote:
> > > > be sufficient, but depending if driver had done the add_memory in=20
probe,
> > > > it perhaps would be onerous to have to remove_memory as well before=
=20
reset,
> > > > and then add it back after reset. I realize you=E2=80=99re saying s=
uch a=20
procedure
> > > > would be abusing hotplug framework, and we could perhaps require th=
at
> > memory
> > > > be removed prior to reset, but not clear to me that it *must* be=20
removed for
> > > > correctness.

I'm not sure exactly what you meant by "unavailable", but on some platforms=
=20
(eg. PowerPC) it must be removed for correctness if hardware access to the=
=20
memory is going away for any period of time. remove_memory() is what makes =
it=20
safe to physically remove the memory as it triggers things like cache=20
flushing. Without this PPC would see memory failure machine checks if it ev=
er=20
tried to writeback any dirty cache lines to the now inaccessible memory.

> > > > Another usecase of offlining without removing HDM could be around
> > > > Virtualization/passing entire device with its memory to a VM. If=20
device was
> > > > being used in the host kernel, and is then unbound, and bound to vf=
io-
pci
> > > > (vfio-cxl?), would we expect vfio-pci to add_memory_driver_managed?
> > >
> > > At least for passing through memory to VMs (via KVM), you don't actua=
lly
> > > need struct pages / memory exposed to the buddy via
> > > add_memory_driver_managed(). Actually, doing that sounds like the wro=
ng
> > > approach.
> > >
> > > E.g., you would "allocate" the memory via devdax/dax_hmat and directly
> > > map the resulting device into guest address space. At least that's wh=
at
> > > some people are doing with
>=20
> How does memory_failure forwarding to guest work in that case?
> IIUC it doesn't without a struct page in the host.=20
> For normal memory, when VM consumes poison, host kernel signals
> Userspace with SIGBUS and si-code that says Action Required, which=20
> QEMU injects to the guest.
> IBM had done something like you suggest with coherent GPU memory and IIUC
> memory_failure forwarding to guest VM does not work there.
>=20
> kernel https://lkml.org/lkml/2018/12/20/103=20
> QEMU: https://patchwork.kernel.org/patch/10831455/

The above patches simply allow the coherent GPU physical memory ranges to g=
et=20
mapped into a guest VM in a similar way to an MMIO range (ie. without a str=
uct=20
page in the host). So you are correct in that they do not deal with forward=
ing=20
failures to a guest VM.

Any GPU memory failure on PPC would currently get sent to the host in the s=
ame=20
way as a normal system memory failure (ie. machine check). So in theory=20
notification to a guest would work the same as a normal system memory failu=
re.=20
I say in theory because when I last looked at this some time back a guest=20
kernel on PPC is not notified of memory errors.

 - Alistair

> I would think we *do want* memory errors to be sent to a VM.=20
>
> >=20
> > ...and Joao is working to see if the host kernel can skip allocating
> > 'struct page' or do it on demand if the guest ever requests host
> > kernel services on its memory. Typically it does not so host 'struct
> > page' space for devdax memory ranges goes wasted.
> Is memory_failure forwarded to and handled by guest?
>=20




