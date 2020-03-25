Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED6A1924F5
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Mar 2020 11:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgCYKDL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Mar 2020 06:03:11 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38575 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgCYKDL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Mar 2020 06:03:11 -0400
Received: by mail-oi1-f195.google.com with SMTP id w2so1549727oic.5;
        Wed, 25 Mar 2020 03:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RbxsF3iTBYd8Alr5a+AtfnDNHQ5nhFVuguNGxWvurh0=;
        b=AAPa5MwXmDQSu4zA9dPlBPcV5CEKHNNruTSqcBA41tVpwg+YUmFEj+1IUzIfsTu6P+
         sZ90j5lLoX90U68YrWvXMwe7LS5IjnZac4hTITfdjUcUyv/M+FjCssQkdCemvrztVo89
         IZ0voE+t1ViCVH71uZNaZJ5YFtxPZSMcqMlyAPj2802MTEeuUMS0X5rb9S0ipohTz8wa
         rSvAISnD6VmdzuCL8X8loynmDDiQL7P0hemUVGAGnwkodhEE1LWtUcpOCcTzpCXKHm+6
         eYRAdAdrwJPYZQqV5Qj8TYbilpoN9sBFqQSr/fvv7GO0dAoZAFfpt6iuC4WIJ1+cQr04
         hivw==
X-Gm-Message-State: ANhLgQ0kCii8TSmT5tPqJKe15zHeWq8WyLyD9MHAHft6v3nVzOVkNtKN
        EFTbUSTO3uMjAwSGMPbFeHCGqN5lp45ZYDFbFpI=
X-Google-Smtp-Source: ADFU+vtK7XJIlmRTJBKFQ3UQeLQAPRvyeRH/mRzKTpmVW/rXoTpLQXCBWXpdUAN8zvQ1FBWw76QivKVZ5CBpzMoO6GI=
X-Received: by 2002:aca:f07:: with SMTP id 7mr207477oip.68.1585130590326; Wed,
 25 Mar 2020 03:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Mar 2020 11:02:58 +0100
Message-ID: <CAJZ5v0jqKu2AFEoCPa7h-UQqzprkB1pcs9hKzu2BdQB6kRB3vQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Manual definition of Soft Reserved memory devices
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Borislav Petkov <bp@alien8.de>,
        Wei Yang <richardw.yang@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeff Moyer <jmoyer@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Mar 22, 2020 at 5:28 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Changes since v1 [1]:
> - Kill the ifdef'ery in arch/x86/mm/numa.c (Rafael)
>
> - Add a dummy phys_to_target_node() for ARM64 (0day-robot)
>
> - Initialize ->child and ->sibling to NULL in the resource returned by
>   find_next_iomem_res() (Inspired by Tom's feedback even though it does
>   not set them like he suggested)
>
> - Collect Ard's Ack
>
> [1]: http://lore.kernel.org/r/158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com
>
> ---
>
> My primary motivation is making the dax_kmem facility useful to
> shipping platforms that have performance differentiated memory, but
> may not have EFI-defined soft-reservations / HMAT (or
> non-EFI-ACPI-platform equivalent). I'm anticipating HMAT enabled
> platforms where the platform firmware policy for what is
> soft-reserved, or not, is not the policy the system owner would pick.
> I'd also highlight Joao's work [2] (see the TODO section) as an
> indication of the demand for custom carving memory resources and
> applying the device-dax memory management interface.
>
> Given the current dearth of systems that supply an ACPI HMAT table, and
> the utility of being able to manually define device-dax "hmem" instances
> via the efi_fake_mem= option, relax the requirements for creating these
> devices. Specifically, add an option (numa=nohmat) to optionally disable
> consideration of the HMAT and update efi_fake_mem= to behave like
> memmap=nn!ss in terms of delimiting device boundaries.
>
> [2]: https://lore.kernel.org/lkml/20200110190313.17144-1-joao.m.martins@oracle.com/
>
> With Ard's and Rafael's ack I'd feel ok taking this through the nvdimm
> tree, please holler if anything still needs some fixups.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the whole series.

Thanks!
