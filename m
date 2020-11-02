Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FAE2A3481
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Nov 2020 20:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgKBTrB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Nov 2020 14:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgKBTqJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Nov 2020 14:46:09 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E2BC0617A6
        for <linux-acpi@vger.kernel.org>; Mon,  2 Nov 2020 11:46:08 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id cw8so6945259ejb.8
        for <linux-acpi@vger.kernel.org>; Mon, 02 Nov 2020 11:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9S7vWYZqXm3PqYUWfzNRmMs/AaRtdM//LcdO3k++WwE=;
        b=SaEFxDNLdalp+GldG72yakmXkFbPbvhYxzUPN6V+nHaJHQC2qvu41yf5eyB/QcvIXx
         fnyL4DvxD35TO/GGvlfiXuDMtgtT477/tYOW13bVtx/OrLfSQ2t415bP2SHkjLL/O8mJ
         AcwcCG+YwCDYOmn97Av9Te4pGZgyijcm5ClJbwvmjt3zc5RTZiF91Bs2s0gL3oQB2GB+
         ARpsn11XbZVHljA+/UnLfDpb8EBTXxpHgcXRJNr3gf+joX3g5/xDr/C7sjj+V5qYdXj/
         wgzPh+YKW1OvL3e4zUCCLAolj2fD2CNU9Ha6NeCI7xlO0U/CzEs2YoC5HjL0OOqx8G4u
         IByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9S7vWYZqXm3PqYUWfzNRmMs/AaRtdM//LcdO3k++WwE=;
        b=SUznJ2pGvt9vK3NboALeaUEV8EdRO358y6MHlMCYf7snVANKcU5EFswXqiwz65Zsgs
         T7fhRICNIWyH3ENU8Wug/DOD4/5Dd2Ze1rhNXEX5K55ZsYNqx8CHRu7uelKzXhpUHRun
         7r2Pugl6rmDucMD0D/zQ8g6HnkSaZdGF1GAYzHQrbZtvv+8KUABt0lB+3UVD8R5xEcAb
         JOgIRxZ3ct91CFjFTI+oNRPo8T1dorygiLflv0BvBjrO6X62ijTZKjUIPQvb2L8P0ZcP
         Ar4/YuhhtU/uU2OvAabV//7CUpgsqNUAtrzam9E0Jzfl4L31nDxQ1ITBl9yAwfZPkJHs
         xMMw==
X-Gm-Message-State: AOAM533utjYmR5h1PA+ubeGxIkiKIyNqHSeBw26TCyzHThFAR0tdz6WO
        pZij9zlfKUaIZRYQFs1EDOqYjH/btVIRwyyvck9BPg==
X-Google-Smtp-Source: ABdhPJxlB0VuTyd5PdBaybjL8K53mwvkGZB+YeHljHV/lmgT9JUksEsp6iUPlVknSl5PRxkdzwTfMN+/Mocq2Slc5vA=
X-Received: by 2002:a17:906:c20f:: with SMTP id d15mr16418068ejz.341.1604346367393;
 Mon, 02 Nov 2020 11:46:07 -0800 (PST)
MIME-Version: 1.0
References: <BL0PR12MB25321C8689BAFDF8678E5C69BD170@BL0PR12MB2532.namprd12.prod.outlook.com>
 <CAPcyv4jWFf0=VoA2EiXPaQphA-5z9JFO8h0Agy0dO0w6nDyorw@mail.gmail.com>
 <451b2571-c3e8-97d8-bfd0-f8054a1b75c5@redhat.com> <CAPcyv4jX1tedjuU-vCSKgvhQeNFukyq9d0ddmsk7jAjWMX+iBQ@mail.gmail.com>
 <958912b2-1436-378f-43d7-cbc5c8955ffd@redhat.com> <BL0PR12MB2532D78BF9E62E141AED5EADBD100@BL0PR12MB2532.namprd12.prod.outlook.com>
 <2f9fa312-e080-d995-eb82-1ac9e6128a33@redhat.com> <CAPcyv4jvndnm986vjQLHOw=q0+rN8JDuJd4z-Bv3Wz06Wz4gug@mail.gmail.com>
 <BL0PR12MB2532F7D105A1DC2E41B13DF2BD100@BL0PR12MB2532.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB2532F7D105A1DC2E41B13DF2BD100@BL0PR12MB2532.namprd12.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 2 Nov 2020 11:45:55 -0800
Message-ID: <CAPcyv4jkm9MtkG5RPLJDM_PU9nLBXPOGRDZ8tRZX_cgGbf9p9g@mail.gmail.com>
Subject: Re: Onlining CXL Type2 device coherent memory
To:     Vikram Sethi <vsethi@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>,
        Jeff Smith <JSMITH@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 2, 2020 at 11:25 AM Vikram Sethi <vsethi@nvidia.com> wrote:
[..]
> > > At least for passing through memory to VMs (via KVM), you don't actually
> > > need struct pages / memory exposed to the buddy via
> > > add_memory_driver_managed(). Actually, doing that sounds like the wrong
> > > approach.
> > >
> > > E.g., you would "allocate" the memory via devdax/dax_hmat and directly
> > > map the resulting device into guest address space. At least that's what
> > > some people are doing with
>
> How does memory_failure forwarding to guest work in that case?
> IIUC it doesn't without a struct page in the host.
> For normal memory, when VM consumes poison, host kernel signals
> Userspace with SIGBUS and si-code that says Action Required, which
> QEMU injects to the guest.
> IBM had done something like you suggest with coherent GPU memory and IIUC
> memory_failure forwarding to guest VM does not work there.
>
> kernel https://lkml.org/lkml/2018/12/20/103
> QEMU: https://patchwork.kernel.org/patch/10831455/
> I would think we *do want* memory errors to be sent to a VM.
> >
> > ...and Joao is working to see if the host kernel can skip allocating
> > 'struct page' or do it on demand if the guest ever requests host
> > kernel services on its memory. Typically it does not so host 'struct
> > page' space for devdax memory ranges goes wasted.
> Is memory_failure forwarded to and handled by guest?

This dovetails with one of the DAX enabling backlog items to remove
dependencies on page->mapping and page->index for the memory-failure
path because that also gets in the way of reflink. For devdax it's
easy to drop the page->mapping dependency. For fsdax we still need
something to redirect the lookup into the proper filesystem code.

Certainly memory-failure support will not regress, it just means we're
stuck with 'struct page' in this path in the meantime.
