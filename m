Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07DF340917
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Mar 2021 16:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhCRPnG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Mar 2021 11:43:06 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:34424 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhCRPmd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Mar 2021 11:42:33 -0400
Received: by mail-ot1-f46.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so5613276otn.1;
        Thu, 18 Mar 2021 08:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MSzbL7q7UOHy8XukE1pAVuaN95+QmKI6ybgop91aXbk=;
        b=ANlYDidrioCB7tNaBCxDGmIfMCsD0wenZXnpauJoKeC9QqLP+C7GNMjwfc4Yk/pgjG
         eH1D8f5dlZNdlJOpGkQQrUcPBV2Eidf15Fdy+PFTDyZ+Bzl+ohO3hfNgpciC999dq420
         qhd9ITxX8+vE7cO0irjs6Jg3uNiAs5m45dQiDKTkgxEetekpO8qp1PN6t903AjASggcw
         LG2A3RXLH4QOdNFbdhtkoSeNzMXLq3sFI6hJhbnKyBMg2lX+nMyLoG12BTmVipY2yIUH
         1jy7cS/TzPNhsepEfHf5A2XEBE2TYqIqsEB6BWaX+qpw9MCumF5hVBdv+fdJ0zKDNSAG
         bPrw==
X-Gm-Message-State: AOAM532SxSD3enol9/kMd2aGZgIopvLi36M+m2M9YFfdkIBjyDmjiFXE
        tE8cxCwBMixKvnHq3GZ6Fa0rhwnBkic6ar0QhGM=
X-Google-Smtp-Source: ABdhPJw9CbqKs+8q9CJPeZk/eqMne0374o6AJM6grGChTntRlJqy7ruxZhdfrwTKhrfgAYU8cT2aiydfv+IKHBoN0VQ=
X-Received: by 2002:a05:6830:20d2:: with SMTP id z18mr5393994otq.260.1616082153103;
 Thu, 18 Mar 2021 08:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <YE5dJ6U3nPWsXY4D@linux.ibm.com> <CAJZ5v0g1H6hCVbAAFajhn0AYRMU4GkZOqggOB6LVdgFx_vfwOA@mail.gmail.com>
 <3236337.DtqTXxM43S@kreacher> <bad1ea33-1a6e-bd4d-b795-fbc51ac6ecca@oracle.com>
In-Reply-To: <bad1ea33-1a6e-bd4d-b795-fbc51ac6ecca@oracle.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Mar 2021 16:42:21 +0100
Message-ID: <CAJZ5v0g81pE6S_bYV_ECvvzifEUFznWUOVcC8X5v-MQb4-th_g@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: fix acpi table use after free
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Robert Moore <robert.moore@intel.com>,
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

On Wed, Mar 17, 2021 at 11:28 PM George Kennedy
<george.kennedy@oracle.com> wrote:
>
>
>
> On 3/17/2021 4:14 PM, Rafael J. Wysocki wrote:
> > On Monday, March 15, 2021 5:19:29 PM CET Rafael J. Wysocki wrote:
> >> On Sun, Mar 14, 2021 at 8:00 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >>> On Thu, Mar 11, 2021 at 04:36:31PM +0100, Rafael J. Wysocki wrote:
> >>>> On Wed, Mar 10, 2021 at 8:47 PM David Hildenbrand <david@redhat.com> wrote:
> >>>>>> There is some care that should be taken to make sure we get the order
> >>>>>> right, but I don't see a fundamental issue here.
> >>>> Me neither.
> >>>>
> >>>>>> If I understand correctly, Rafael's concern is about changing the parts of
> >>>>>> ACPICA that should be OS agnostic, so I think we just need another place to
> >>>>>> call memblock_reserve() rather than acpi_tb_install_table_with_override().
> >>>> Something like this.
> >>>>
> >>>> There is also the problem that memblock_reserve() needs to be called
> >>>> for all of the tables early enough, which will require some reordering
> >>>> of the early init code.
> >>>>
> >>>>>> Since the reservation should be done early in x86::setup_arch() (and
> >>>>>> probably in arm64::setup_arch()) we might just have a function that parses
> >>>>>> table headers and reserves them, similarly to how we parse the tables
> >>>>>> during KASLR setup.
> >>>> Right.
> >>> I've looked at it a bit more and we do something like the patch below that
> >>> nearly duplicates acpi_tb_parse_root_table() which is not very nice.
> >> It looks to me that the code need not be duplicated (see below).
> >>
> >>> Besides, reserving ACPI tables early and then calling acpi_table_init()
> >>> (and acpi_tb_parse_root_table() again would mean doing the dance with
> >>> early_memremap() twice for no good reason.
> >> That'd be simply inefficient which is kind of acceptable to me to start with.
> >>
> >> And I changing the ACPICA code can be avoided at least initially, it
> >> by itself would be a good enough reason.
> >>
> >>> I believe the most effective way to deal with this would be to have a
> >>> function that does parsing, reservation and installs the tables supplied by
> >>> the firmware which can be called really early and then another function
> >>> that overrides tables if needed a some later point.
> >> I agree that this should be the direction to go into.
> > So maybe something like the patch below?
>
> Do you want me to try it out in the failing setup?

Yes, please!
