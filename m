Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84282A0F9C
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 21:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgJ3Uhh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 16:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgJ3Uhh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Oct 2020 16:37:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175B0C0613CF
        for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2020 13:37:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id t25so10281662ejd.13
        for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2020 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0yxY74xWsPt5sZN5p++K4jkGrPBDD8koRyi9GnKBFk=;
        b=S22MpHoqEXvqyUrQAPw674b1W1Vz7Q4PyyQbYdBWx046WIj3kdsyiHvQFKF9Jt+G93
         plND+AW82uz1ZPkiwR7VsnfABV7yDDYCzcRSepOPJRIRTnQl4AaXrnzSLj0jIp1rtQOj
         ElLFbcdMFQSZYHQ4mTyZalg8AoMNcMJViaIj5w7Sdk0so11pNODUmGa2IEKwtlxIoTBu
         yoziX6CQQZyL/o84slpcE+qc43TIIOe/U0oOQQ1OhV08K7jsnrnh2LCHpgpvTCUjiz2+
         SLLwsiHr3zK3YQCagmRiotwx7A6+rA9ui/q0a7YpPNXRYO8Rfpz4rgI2kdVA8fL6Iqp3
         RkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0yxY74xWsPt5sZN5p++K4jkGrPBDD8koRyi9GnKBFk=;
        b=BukIahOQ9ZBfPaakqY9PLvjxpt4QtetIhuhiPbzFTc2GPA4RM9eOhsk1ePcH3psJDt
         +V+U0qH3L5/WNWF6Dxy9fNg8jiaKoU/bTg6YpenBuCl03GOGNZWu7HEi3rmuCk9LxrBO
         NEn8G2gVcNt8tnsjpGXYR66C69fEENq2aFIriUZxv+eZQ9H/mKhUFaHJ2BR2590lW1MK
         6FtupBi4uDcELXgjDNkDUUGzv/p4oyMLWWIChbnVoIKk24cKNbwQR0cwz4eS5P0YVmRM
         ZTRRi1vOsZSEDU4/Q3m6QfUk52/XUZorWgpYGXP050ibWhD0iXIRuc0WeIWYhkYHukKH
         X5Rw==
X-Gm-Message-State: AOAM533+kq7grRnKO8WXNFI068voY9we7lGeHUIpqhU8mkBnH1DqAkVq
        BYxfYU0fMYfuagBZbdK5WRiOtu9EsqA906Ac9w601w==
X-Google-Smtp-Source: ABdhPJz2V/T5RbaTHtnCsE/t6M9HLRLRF46JjqGVltyFoc8XhA78ITBcqtYoWwv/7YiEowU+E1BhiyDGT6zDrxxVgOE=
X-Received: by 2002:a17:906:d92c:: with SMTP id rn12mr1935796ejb.472.1604090253894;
 Fri, 30 Oct 2020 13:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <BL0PR12MB25321C8689BAFDF8678E5C69BD170@BL0PR12MB2532.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB25321C8689BAFDF8678E5C69BD170@BL0PR12MB2532.namprd12.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 30 Oct 2020 13:37:18 -0700
Message-ID: <CAPcyv4jWFf0=VoA2EiXPaQphA-5z9JFO8h0Agy0dO0w6nDyorw@mail.gmail.com>
Subject: Re: Onlining CXL Type2 device coherent memory
To:     Vikram Sethi <vsethi@nvidia.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>,
        Jeff Smith <JSMITH@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 28, 2020 at 4:06 PM Vikram Sethi <vsethi@nvidia.com> wrote:
>
> Hello,
>
> I wanted to kick off a discussion on how Linux onlining of CXL [1] type 2 device
> Coherent memory aka Host managed device memory (HDM) will work for type 2 CXL
> devices which are available/plugged in at boot. A type 2 CXL device can be simply
> thought of as an accelerator with coherent device memory, that also has a
> CXL.cache to cache system memory.
>
> One could envision that BIOS/UEFI could expose the HDM in EFI memory map
> as conventional memory as well as in ACPI SRAT/SLIT/HMAT. However, at least
> on some architectures (arm64) EFI conventional memory available at kernel boot
> memory cannot be offlined, so this may not be suitable on all architectures.

That seems an odd restriction. Add David, linux-mm, and linux-acpi as
they might be interested / have comments on this restriction as well.

> Further, the device driver associated with the type 2 device/accelerator may
> want to save off a chunk of HDM for driver private use.
> So it seems the more appropriate model may be something like dev dax model
> where the device driver probe/open calls add_memory_driver_managed, and
> the driver could choose how much of the HDM it wants to reserve and how
> much to make generally available for application mmap/malloc.

Sure, it can always be driver managed. The trick will be getting the
platform firmware to agree to not map it by default, but I suspect
you'll have a hard time convincing platform-firmware to take that
stance. The BIOS does not know, and should not care what OS is booting
when it produces the memory map. So I think CXL memory unplug after
the fact is more realistic than trying to get the BIOS not to map it.
So, to me it looks like arm64 needs to reconsider its unplug stance.

> Another thing to think about is whether the kernel relies on UEFI having fully
> described NUMA proximity domains and end-end NUMA distances for HDM,
> or whether the kernel will provide some infrastructure to make use of the
> device-local affinity information provided by the device in the Coherent Device
> Attribute Table (CDAT) via a mailbox, and use that to add a new NUMA node ID
> for the HDM, and with the NUMA distances calculated by adding to the NUMA
> distance of the host bridge/Root port with the device local distance. At least
> that's how I think CDAT is supposed to work when kernel doesn't want to rely
> on BIOS tables.

The kernel can supplement the NUMA configuration from CDAT, but not if
the memory is already enumerated in the EFI Memory Map and ACPI
SRAT/HMAT. At that point CDAT is a nop because the BIOS has precluded
the OS from consuming it.

> A similar question on NUMA node ID and distances for HDM arises for CXL hotplug.
> Will the kernel rely on CDAT, and create its own NUMA node ID and patch up
> distances, or will it rely on BIOS providing PXM domain reserved at boot in
> SRAT to be used later on hotplug?

I don't expect the kernel to merge any CDAT data into the ACPI tables.
Instead the kernel will optionally use CDAT as an alternative method
to generate Linux NUMA topology independent of ACPI SRAT. Think of it
like Linux supporting both ACPI and Open Firmware NUMA descriptions at
the same time. CDAT is its own NUMA description domain unless BIOS has
blurred the lines and pre-incorporated it into SRAT/HMAT. That said I
think the CXL attached memory not described by EFI / ACPI is currently
the NULL set.
