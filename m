Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72648332E4D
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Mar 2021 19:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhCISa2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Mar 2021 13:30:28 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:39296 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhCISaD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Mar 2021 13:30:03 -0500
Received: by mail-ot1-f50.google.com with SMTP id h22so13772650otr.6;
        Tue, 09 Mar 2021 10:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cc44XgMrXYcGJmv2uY6Gj2YJymaXa/QmpTtTLJqdQFI=;
        b=USW/msloywO14osyG+ECNiIuO9ZgSvBLcJtajMmhV7DtjHVb+zzr83DAxllQfSEjic
         CjvQkrXnTjukrS6tdqJb6RNOcPpGEC4MrITTPnKWVD9P9MHm5Gx36xDQ6dOqwbVibmfW
         JdJ86L4VKlfedA6AvT7Iq5K227JgPGw04lb8pYx/szg4V382Kt04vcfTMiML3JSK9dsY
         38SUO++Bt/7Pz/PNx6IbiLCkN/jJk5edRSxWPp6Kg2SIzHs7DVQWARgvrUvZguEq32Fj
         ab8S26E8njSWGNCMOzIGjxHd14JLfZjhO/XeMz1AxHDSRbLrRBtQU+RJ5eAknmdSvj+i
         NmXw==
X-Gm-Message-State: AOAM5307IPWlzi1lSJ85LDEN4tBL7wFwyYeOkaaFye/jax5ncwkSxO6E
        EEmYTBMtRROIGTwNvUp5QNBP2SrxHo3rmgKXF5E=
X-Google-Smtp-Source: ABdhPJzQ3YoLZ+PxyTqe/NlRBk7RWCsHb3LYmwtIWjMGSid8IPbg/yX8pHvnTStEAX1FNVz3aRxckdVSCkOn+4duQM4=
X-Received: by 2002:a9d:3422:: with SMTP id v31mr20594235otb.260.1615314602894;
 Tue, 09 Mar 2021 10:30:02 -0800 (PST)
MIME-Version: 1.0
References: <1614802160-29362-1-git-send-email-george.kennedy@oracle.com>
 <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <9c3bc1b2-bb8d-194d-6faf-e4d7d346dc9b@oracle.com> <CAJZ5v0j8udd0R6A1wwpNvZL5Dr1pRcdiZr2if5y50o7OkHOMqg@mail.gmail.com>
 <YESEymRQ2/F7xJGt@linux.ibm.com> <YEe2SAESEaEak+HB@linux.ibm.com>
In-Reply-To: <YEe2SAESEaEak+HB@linux.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Mar 2021 19:29:51 +0100
Message-ID: <CAJZ5v0hAQo7+3bthoC8K7n7qyhQFMuOd8U3BhZWSREjPmq0-7w@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: fix acpi table use after free
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 9, 2021 at 6:54 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Sun, Mar 07, 2021 at 09:46:22AM +0200, Mike Rapoport wrote:
> > Hello Rafael,
> >
> > On Fri, Mar 05, 2021 at 02:30:07PM +0100, Rafael J. Wysocki wrote:
> > > On Fri, Mar 5, 2021 at 12:14 AM George Kennedy <george.kennedy@oracle.com> wrote:
> > >
> > > > The ibft table, for example, is mapped in via acpi_map() and kmap(). The
> > > > page for the ibft table is not reserved, so it can end up on the freelist.
> > >
> > > You appear to be saying that it is not sufficient to kmap() a page in
> > > order to use it safely.  It is also necessary to reserve it upfront,
> > > for example with the help of memblock_reserve().  Is that correct?  If
> > > so, is there an alternative way to reserve a page frame?
> >
> > Like David said in the other reply, if a BIOS does not mark the memory that
> > contains an ACPI table as used (e.g. reserved or ACPI data), we need to
> > make sure the kernel knows that such memory is in use and an early call to
> > memblock_reserve() is exactly what we need here.
> > George had this issue with iBFT, but in general this could be any table
> > that a buggy BIOS forgot to mark as ACPI data.
>
> BTW, I wonder is there a fundamental reason to use ioremap() to access ACPI
> tables at all?
> In the end, they reside in RAM and, apparently, they live at the same DIMM
> as neighboring "normal memory" so why cannot we just map them normally as
> read-only not executable?

This may be NVS memory (depending on the configuration of the system)
which isn't "normal" RAM AFAICS.
