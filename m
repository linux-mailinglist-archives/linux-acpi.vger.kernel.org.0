Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5CD31A876
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Feb 2021 00:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhBLXwl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 18:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhBLXwf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Feb 2021 18:52:35 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D546C061756
        for <linux-acpi@vger.kernel.org>; Fri, 12 Feb 2021 15:51:55 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a9so2032195ejr.2
        for <linux-acpi@vger.kernel.org>; Fri, 12 Feb 2021 15:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7K3BZFdb7iE8T1v7NcC1uvFDHsP1mg7JvZIfnpdkCCc=;
        b=pKkeepTNJkXoIRYdoO1nNJJWS2Ygf9ylUb0TVncxwsX8gyAfm0zw2GIc8egaAEa6tY
         TGnFKI5PANlKWpXpFW+ItbNigxHwhl2q+blkXEsUit05ZpW8Fx3JWe4wJ8fNZopp7IwZ
         V8bWLpl2iniZEaRKmGjO9DlkfFM5Vi1SRdLUBj3Tlj1PRMhXJHOB2OBVQu/Rk/lMXGJv
         qi/ZKGRBAN46t4p0273i1/ofe/J9UffHtnDVCdUJKrEjpKlazo+cVl4NQnkxPFrFVbOu
         TdCzySIpua2tapX+OOvw+Ewj8przAfmsIE3ynoxIMsaOmuE95RHBznT3CxbSO4M7lcBT
         cdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7K3BZFdb7iE8T1v7NcC1uvFDHsP1mg7JvZIfnpdkCCc=;
        b=Qur4agZIjeiZwno7m4cgtnWMnihYLjc98KpJkwiKmXJw0OE0ludJZxugQ5PZ1vKa4z
         BsJe/c9BAw4jo3jXvQmnN52HMunx0ritW/ucbjV8nKRujplakJiCi8UZ0ypVk0EJVj5m
         MaFn5VymrIWxhWTHjKPQlRSlB/s1QRJYjwpRZneUAd2ldZEIQweJ7CxeEQoJ9JDwbQ8Z
         5AbK99NpaQ/GhgPTYMGGTg6x08qLhH2fglI/sF//WoM2WfCoa93cO9mMNmpOAyam9Kd8
         ppns3m4FXUiAO9RQwfCgREilT0KStmwFlmi66AWpvjIs0qqkKB0ziSz10j7WXEde27Zs
         zXAQ==
X-Gm-Message-State: AOAM5316nnjavgymPDor60nwU67YMkq4V3yTO7NCJ+LKWKhuH9MtLpGn
        ux0HsYzmy/IzRzuHh337l/cSzFGGC9yBZlhsMnZE8g==
X-Google-Smtp-Source: ABdhPJxLQSGON6NWOqFK+PRDdig0ZUQskNi6wqWwnPDESg6AOe8yfBibbDdMNTqgeX53DriJkN1vCBJscnLlE+HZKHU=
X-Received: by 2002:a17:906:af6b:: with SMTP id os11mr5358519ejb.472.1613173913997;
 Fri, 12 Feb 2021 15:51:53 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4gmd_cygXK0PpGkXmJLC3_ctEpRvpi5P-QcuXusFX5oNQ@mail.gmail.com>
 <20210210112330.00003e74@Huawei.com> <CAPcyv4gOyPjVcBa_m6pvpVP+vamJ38G7ePos-2LP273y3ivJqg@mail.gmail.com>
 <20210211094222.000048ae@Huawei.com> <CAPcyv4j0Wce-76OfgqTSkveukgDXB_p2VZZpgM8XjDFd+Q-0Ww@mail.gmail.com>
 <20210212122438.00003621@Huawei.com>
In-Reply-To: <20210212122438.00003621@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 12 Feb 2021 15:51:42 -0800
Message-ID: <CAPcyv4j1axBsy4GdRxj4JhxRXtrK-U+ikxQ3xYKCa-z-a84XPQ@mail.gmail.com>
Subject: Re: [RFC] ACPI Code First ECR: Generic Target
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        Chet R Douglas <chet.r.douglas@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 12, 2021 at 4:26 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 11 Feb 2021 09:06:51 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Thu, Feb 11, 2021 at 1:44 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Wed, 10 Feb 2021 08:24:51 -0800
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > > On Wed, Feb 10, 2021 at 3:24 AM Jonathan Cameron
> > > > <Jonathan.Cameron@huawei.com> wrote:
> > > > >
> > > > > On Tue, 9 Feb 2021 19:55:05 -0800
> > > > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > > >
> > > > > > While the platform BIOS is able to describe the performance
> > > > > > characteristics of CXL memory that is present at boot, it is unable to
> > > > > > statically enumerate the performance of CXL memory hot inserted
> > > > > > post-boot. The OS can enumerate most of the characteristics from link
> > > > > > registers and CDAT, but the performance from the CPU to the host
> > > > > > bridge, for example, is not enumerated by PCIE or CXL. Introduce an
> > > > > > ACPI mechanism for this purpose. Critically this is achieved with a
> > > > > > small tweak to how the existing Generic Initiator proximity domain is
> > > > > > utilized in the HMAT.
> > > > >
> > > > > Hi Dan,
> > > > >
> > > > > Agree there is a hole here, but I think the proposed solution has some
> > > > > issues for backwards compatibility.
> > > > >
> > > > > Just to clarify, I believe CDAT from root ports is sufficient for the
> > > > > other direction (GI on CXL, memory in host).  I wondered initially if
> > > > > this was a two way issue, but after a reread, I think that is fine
> > > > > with the root port providing CDAT or potentially treating the root
> > > > > port as a GI (though that runs into the same naming / representation issue
> > > > > as below and I think would need some clarifying text in UEFI GI description)
> > > > >
> > > > > http://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute%20Table_1.01.pdf
> > > > >
> > > > > For the case you are dealing with here potentially we 'could' add something
> > > > > to CDAT as alternative to changing SRAT, but it would be more complex
> > > > > so your approach here makes more sense to me.
> > > >
> > > > CDAT seems the wrong mechanism because it identifies target
> > > > performance once you're at the front door of the device, not
> > > > performance relative to a given initiator.
> > >
> > > I'd argue you could make CDAT a more symmetric representation, but it would
> > > end up replicating a lot of info already in HMAT.  Didn't say it was a good
> > > idea!
> >
> > CDAT describes points, HMAT describes edges on the performance graph,
> > it would be confusing if CDAT tried to supplant HMAT.
>
> Entirely agreed.  Note I'm not disagreeing with approach here at all, simply
> trying to point out where I think you'll get questions taking this to ACPI.

Understood.

>
> >
> > >
> > > That's an odd situation that it sort of 'half' manages it in the BIOS.
> > > We probably need some supplementary additional docs around this topic
> > > as the OS would need to be aware of that possibility and explicitly check
> > > for it before doing its normal build based on CDAT + what you are proposing
> > > here.  Maybe code is enough but given this is cross OS stuff I'd argue
> > > it probably isn't.
> > >
> > > I guess could revisit this draft Uefi white paper perhaps and add a bunch
> > > of examples around this usecase https://github.com/hisilicon/acpi-numa-whitepaper
> >
> > Thanks for the reference, I'll take a look.
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > # Impact of the Change
> > > > > > The existing Generic Initiator Affinity Structure (ACPI 6.4 Section
> > > > > > 5.2.16.6) already contains all the fields necessary to enumerate a
> > > > > > generic target proximity domain. All that is missing is the
> > > > > > interpretation of that proximity domain optionally as a target
> > > > > > identifier in the HMAT.
> > > > > >
> > > > > > Given that the OS still needs to dynamically enumerate and instantiate
> > > > > > the memory ranges behind the host bridge. The assumption is that
> > > > > > operating systems that do not support native CXL enumeration will ignore
> > > > > > this data in the HMAT, while CXL native enumeration aware environments
> > > > > > will use this fragment of the performance path to calculate the
> > > > > > performance characteristics.
> > > > >
> > > > > I don't think it is true that OS not supporting native CXL will ignore the
> > > > > data.
> > > >
> > > > True, I should have chosen more careful words like s/ignore/not
> > > > regress upon seeing/
> > >
> > > It's a sticky corner and I suspect likely to come up at in ACPI WG - what is
> > > being proposed here isn't backwards compatible
> >
> > It seems our definitions of backwards compatible are divergent. Please
> > correct me if I'm wrong, but I understand your position to be "any
> > perceptible OS behavior change breaks backwards compatibility",
> > whereas I'm advocating that backwards compatibility is relative
> > regressing real world use cases. That said, I do need to go mock this
> > up in QEMU and verify how much disturbance it causes.
> >
> > > even if the impacts in Linux are small.
> >
> > I'd note the kernel would grind to a halt if the criteria for
> > "backwards compatible" was zero perceptible behavior change.
>
> Key thing here is the difference between Linux backwards compatibility and
> ACPI backwards compatibility.  Linux impacts are easily understood because
> we can go look.  ACPI change impacts in general are rather trickier to
> define.
>
> Note currently I'm fine with this change, though think perhaps it could
> be improved - simply raising that others may not be.

I appreciate that, and as the originator of GI I hold your feedback in
high regard.

Yes, the criteria that it needs to be a functional regression vs a
behavior change may be difficult argument to carry with others.

>
> >
> > > Mostly it's infrastructure bring up that won't get used
> > > (fallback lists and similar for a node which will never be specified in
> > > allocations) and some confusing userspace ABI (which is more than a little
> > > confusing already).
> >
> > Fallback lists are established relative to online nodes. These generic
> > targets are not onlined as memory.
>
> This doesn't really matter beyond the point that there is stuff done for
> a GI only node currently that doesn't make any sense for this new usecase.
>
> Still, you got me digging...
>
> I may have the  wrong term there, but GI nodes have a zone list
> generated that reflects where an allocation will go if an allocation
> happens that is requested on the the GI node.
>
> devm_kzalloc() for example for a device in one of these nodes has to know
> where to allocate memory from.  Similar true for other resources that don't
> exist in the GI node.
>
> Check this worked as expected led me down a rabbit hole.  I knew the end
> to end test did what I expected but wasn't certainly why...
>
> Anyhow, at least for my test case on x86 doing an 8k devm_kzalloc() it works
> as follows.
>
> Some way down the nest of calls we get a call to
> __alloc_pages_nodemask()
> -> prepare_alloc_pages() // this finds the zonelist
>    -> node_listlist(gi_node, ...)
>       -> NODE_DATA(gi_node)->node_zonelists + gfp_zonelist(flags)
>          node_data[gi_node]->node_zonelists + gfp_zonelist(flags)
>
> The node_data entry for the gi_node has it's own zonelist which is used in this
> path.  The first entry of which is an appropriate zone on the nearest node which
> actually has some memory.
>
> The build is referenced by a comment in x86/mm/numa.c under init_memory_less_node()
> "All zonelists will be built later in start_kernel() after per cpu areas are initialized"
>
> build_zonelists() does the expected building based on SLIT distances.

Ugh, I had been holding onto the mental model  that GI support was
limited to the HMAT sysfs representation. What is the use case for
init_gi_nodes()? I would expect GI information is only useful for
performance calculations and that can be done without touching the
node infrastructure.

At first glance that metadata manipulation looks like a mistake to me,
I wish I had paid more attention as that went in... regardless this
does indeed change my thoughts of Generic Target being a minor impact.

Why does GI need anything more than acpi_map_pxm_to_node() to have a
node number assigned?
