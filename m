Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6FD11A316
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2019 04:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfLKDhg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Dec 2019 22:37:36 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34536 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfLKDhf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Dec 2019 22:37:35 -0500
Received: by mail-oi1-f195.google.com with SMTP id l136so12019424oig.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2019 19:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hKg6CtmhRxPWbTqHVDFqtJdh68B7oJMOxK58C2vi9N8=;
        b=iNUzbB/5ZyunOXZp5DcomNLJDeahuk6g7IY6VuRLyRHeh2QM6XEki1XWdTp+Cd3PMQ
         fRyrjIC7JrtZILRdswUDUinWmMEioVaGqU7bSAM2iWRp86GaNLu+lKPoBLVKkksTqgeW
         QqkyH6RhgyP2qq8JMFcWcgSy8WiN213s+MBH0AYXl8xvOA6j4aMw9fsPXWNjRskd9PSd
         f5/nBfuyA6z5Jnk02HLUjQDGKMz2HyantBRL8GF1HanGTsU4NP/0P03j68TpMLKo2F41
         DtafWdcAg4t4Bnrzat9zJ0zmg/k+wNam/fzjp8fFOfjvWt7iJ3QHdL3+KX/zm7F9EFg9
         3MKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hKg6CtmhRxPWbTqHVDFqtJdh68B7oJMOxK58C2vi9N8=;
        b=ldsfc+yvjyQdDyuNqlCB97yYlfaQoB95LXxGWhv4Y2IlvIL09NiOg6OrMU70ovbKRG
         fIiNj0dgK3QnX6khxsiKGcGJIaroSZSSLR+Gusjd6gnEpbbUhkHQxAKv86h6zHjYZDc6
         ol9dqkNvkoNN5EoOdlVW38eJc8uJ9Q49Ev9zBLH7sMTB+m0jYIPO1dFea4xRaXES/Gmk
         /Ivg446pq6IuVt4zIJWbaeSFrepsxMI7AsyWYxyzb63smjvC3408XUuX+0SeuV5BBVSN
         9isSVIkrHjXn3UDIZ2nfZ62QYOVBsQvhhOcPtBYfHTne/m80RXzR2S3nvFk5d1EhmIuQ
         j/vg==
X-Gm-Message-State: APjAAAVuuynuScp5fbrCBKKQn3dCa0A33PQLbdwgAs3sPQAQjTi12dGO
        EdCauxFTgvmLwcX26kEJwAbr0kmk2Chi1H050UM7FA==
X-Google-Smtp-Source: APXvYqyuye/rOVhTdrOk0mj5xLYR20XK/mN+wO9DEAnn/wew7e1KaSZQdtqZT8bdwpFXWrz5zbo34m58+Ut2ulUFCVo=
X-Received: by 2002:aca:4850:: with SMTP id v77mr1121953oia.70.1576035454356;
 Tue, 10 Dec 2019 19:37:34 -0800 (PST)
MIME-Version: 1.0
References: <20191202070348.32148-1-tao3.xu@intel.com> <CAJZ5v0hqjR5EdrxcdkLUpxseFiizqNjtA3nYdDtZiSt85JiywQ@mail.gmail.com>
 <6dbcdaff-feae-68b9-006d-dd8aec032553@intel.com> <CAJZ5v0jYb7XQC7u0rmxF-XVMAsEoOfmD11-FYDvMrZuOuzgyiA@mail.gmail.com>
 <0e4219c3-943a-e416-e5eb-723bed8c9383@intel.com> <CAJZ5v0h6_7AoYW5Syk=BUR656eW11A3GjA7uvmTA6ayByOaqBg@mail.gmail.com>
 <82e7361e-256e-002c-6b30-601cec1fad07@intel.com> <0f8084fd-86a9-081c-e32a-20c756c9daf6@intel.com>
In-Reply-To: <0f8084fd-86a9-081c-e32a-20c756c9daf6@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 10 Dec 2019 19:37:23 -0800
Message-ID: <CAPcyv4gq690oQgjD53qF_v7YPT2shR0pw5ubtXbOcYMQfH1wxg@mail.gmail.com>
Subject: Re: [PATCH] ACPI/HMAT: Fix the parsing of Cache Associativity and
 Write Policy
To:     Tao Xu <tao3.xu@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 10, 2019 at 7:05 PM Tao Xu <tao3.xu@intel.com> wrote:
>
>
> On 12/10/19 9:18 PM, Tao Xu wrote:
> > On 12/10/2019 4:27 PM, Rafael J. Wysocki wrote:
> >> On Tue, Dec 10, 2019 at 9:19 AM Tao Xu <tao3.xu@intel.com> wrote:
> >>>
> >>> On 12/10/2019 4:06 PM, Rafael J. Wysocki wrote:
> >>>> On Tue, Dec 10, 2019 at 2:04 AM Tao Xu <tao3.xu@intel.com> wrote:
> >>>>>
> >>>>> On 12/9/2019 6:01 PM, Rafael J. Wysocki wrote:
> >>>>>> On Mon, Dec 2, 2019 at 8:03 AM Tao Xu <tao3.xu@intel.com> wrote:
> >>>>>>>
> >>>>>>> In chapter 5.2.27.5, Table 5-147: Field "Cache Attributes" of
> >>>>>>> ACPI 6.3 spec: 0 is "None", 1 is "Direct Mapped", 2 is "Complex
> >>>>>>> Cache
> >>>>>>> Indexing" for Cache Associativity; 0 is "None", 1 is "Write Back",
> >>>>>>> 2 is "Write Through" for Write Policy.
> >>>>>>
> >>>>>> Well, I'm not sure what the connection between the above statement,
> >>>>>> which is correct AFAICS, and the changes made by the patch is.
> >>>>>>
> >>>>>> Is that the *_OTHER symbol names are confusing or something deeper?
> >>>>>>
> >>>>>
> >>>>> Because in include/acpi/actbl1.h:
> >>>>>
> >>>>> #define ACPI_HMAT_CA_NONE                     (0)
> >>>>>
> >>>>> ACPI_HMAT_CA_NONE is 0, but in include/linux/node.h:
> >>>>>
> >>>>>       enum cache_indexing {
> >>>>>              NODE_CACHE_DIRECT_MAP,
> >>>>>              NODE_CACHE_INDEXED,
> >>>>>              NODE_CACHE_OTHER,
> >>>>>       };
> >>>>> NODE_CACHE_OTHER is 2, and for otner enum:
> >>>>>
> >>>>>             case ACPI_HMAT_CA_DIRECT_MAPPED:
> >>>>>                     tcache->cache_attrs.indexing =
> >>>>> NODE_CACHE_DIRECT_MAP;
> >>>>>                     break;
> >>>>>             case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
> >>>>>                     tcache->cache_attrs.indexing = NODE_CACHE_INDEXED;
> >>>>>                     break;
> >>>>> in include/acpi/actbl1.h:
> >>>>>
> >>>>>     #define ACPI_HMAT_CA_DIRECT_MAPPED            (1)
> >>>>>     #define ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING   (2)
> >>>>>
> >>>>> but in include/linux/node.h:
> >>>>>
> >>>>> NODE_CACHE_DIRECT_MAP is 0, NODE_CACHE_INDEXED is 1. This is
> >>>>> incorrect.
> >>>>
> >>>> Why is it incorrect?
> >>>
> >>> Sorry I paste the wrong pre-define.
> >>>
> >>> This is the incorrect line:
> >>>
> >>> case ACPI_HMAT_CA_DIRECT_MAPPED:
> >>> tcache->cache_attrs.indexing = NODE_CACHE_DIRECT_MAP;
> >>>
> >>> ACPI_HMAT_CA_DIRECT_MAPPED is 1, NODE_CACHE_DIRECT_MAP is 0. That means
> >>> if HMAT table input 1 for cache_attrs.indexing, kernel store 0 in
> >>> cache_attrs.indexing. But in ACPI 6.3, 0 means "None". So for the whole
> >>> switch codes:
> >>
> >> This is a mapping between the ACPI-defined values and the generic ones
> >> defined in the kernel.  There is not rule I know of by which they must
> >> be the same numbers.  Or is there such a rule which I'm missing?
> >>
> >> As long as cache_attrs.indexing is used consistently going forward,
> >> the difference between the ACPI-defined numbers and its values
> >> shouldn't matter, should it?
> >>
> > Yes, it will not influence the ACPI HMAT tables. Only influence is the
> > sysfs, as in
> > https://www.kernel.org/doc/html/latest/admin-guide/mm/numaperf.html:
> >
> > # tree sys/devices/system/node/node0/memory_side_cache/
> > /sys/devices/system/node/node0/memory_side_cache/
> > |-- index1
> > |   |-- indexing
> > |   |-- line_size
> > |   |-- size
> > |   `-- write_policy
> >
> > indexing is parsed in this file, so it can be read by user-space.
> > Although now there is no user-space tool use this information to do some
> > thing. But I am wondering if it is used in the future, someone use it to
> > show the memory side cache information to user or use it to do
> > performance turning.
>
> I finish a test using emulated ACPI HMAT from QEMU
> (branch:hmat https://github.com/taoxu916/qemu.git)
>
> And I get the kernel log and sysfs output:
> [    0.954288] HMAT: Cache: Domain:0 Size:20480 Attrs:00081111 SMBIOS
> Handles:0
> [    0.954835] HMAT: Cache: Domain:1 Size:15360 Attrs:00081111 SMBIOS
> Handles:0
>
> /sys/devices/system/node/node0/memory_side_cache/index1 # cat indexing
> 0
> /sys/devices/system/node/node0/memory_side_cache/index1 # cat write_policy
> 0
>
> Note that 'Attrs' is printed using %x, so we can get:
> (attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8 = 1,
> (attrs & ACPI_HMAT_WRITE_POLICY) >> 12       = 1
>
> but we get 0 in sysfs, so if user or software read this information and
> read the ACPI 6.3 spec, will think there is 'none' for Cache
> Associativity or Write Policy.

The sysfs interface is not meant to reflect the ACPI values. This
sysfs information may be populated by another platform firmware
(non-ACPI). I would have preferred that these files use text values
rather than numbers. However, at least the ABI documentation gives the
expected translation:

What:           /sys/devices/system/node/nodeX/memory_side_cache/indexY/indexing
Date:           December 2018
Contact:        Keith Busch <keith.busch@intel.com>
Description:
                The caches associativity indexing: 0 for direct mapped,
                non-zero if indexed.

What:
/sys/devices/system/node/nodeX/memory_side_cache/indexY/write_policy
Date:           December 2018
Contact:        Keith Busch <keith.busch@intel.com>
Description:
                The cache write policy: 0 for write-back, 1 for write-through,
                other or unknown.
