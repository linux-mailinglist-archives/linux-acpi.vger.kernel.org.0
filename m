Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF9E3190A8
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Feb 2021 18:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhBKRJt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Feb 2021 12:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbhBKRHo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Feb 2021 12:07:44 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB28DC061786
        for <linux-acpi@vger.kernel.org>; Thu, 11 Feb 2021 09:07:03 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c6so7744916ede.0
        for <linux-acpi@vger.kernel.org>; Thu, 11 Feb 2021 09:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDAVKBBEPoGx3mqNW0L1W8kc0VtHeqiCwMuQ5W92m8o=;
        b=ifg24T/zyjJNS9lnC2EQ6ttv7KeipFmMRRoHHzemh0OSquUXP+h5b7p45jfDusYp1P
         2Yz/MuQSVeoJEB7eEKh/EnXFL2TAji1xQtYYJ8MlwJx7bVSvy8Ap9do8JSEjbRqp32qY
         HctT9c71U3Q3sJAS7J9kFEjvZRHH0onrw81Vcu23lckUDY/xVUAcUODtHoUhs82+8TOb
         AQ9DbkpWr4BGQJIC1GKsu4XsmKjNjVoin7GJjgUVeUbvUp85TLL3ZZWhLAov9tM6iDlk
         /AijLSZtKgN2+vLkKz+XZs5zHdSv1t+D+4Ua0oDiquGa8Wsi0uNLLED9S4HQhEQ+UTe/
         GHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDAVKBBEPoGx3mqNW0L1W8kc0VtHeqiCwMuQ5W92m8o=;
        b=BxE1hXSKgrV/Ton6B5jrw4hm3Y9Ci7IgF5vo4ZErjDJDeeGzXydHQxKdKEy9jZ/WQ0
         8WhRChqmtRghwXWAHR7sALpKb+i79S2YHRazocEUw3oM8Hb//vD0wTr4B1OQjuVabCkm
         XSF+1NCXikRagRdZnTznt619CAjxcL2zhcHKeTFfwT2vC4UHbr7b99OLkwgVgKEsqfC/
         dFeaBEr45i+2BkzlqxcACT6oIvtzda7SGvHYtpZIPwcbrHuZY4MRA7NotZdVv0tSb2I0
         0b8NybxVJuazKePSUoUKc6Djriu2FO/185Yc6676qjTfDuHvMJBcoK0LznJi4gaO8HGB
         oFCA==
X-Gm-Message-State: AOAM530ZcD/QFYiwUv5s1fkNLxWjXd19kTbu5N8kjH9cOEtEI9WI4cbl
        4Ea2WAS3WKGeQO8yyhJOol8aszDXoS5kkdwkvK5z6g==
X-Google-Smtp-Source: ABdhPJyVMcdNRntyopl3GwkH1PP+iTQdxUbydzSyGMnewIQ1I3ksda9s6GWLweq1+WNIxGb5ts/Jn9i1mOWE03pHooU=
X-Received: by 2002:a05:6402:1152:: with SMTP id g18mr9388920edw.18.1613063222411;
 Thu, 11 Feb 2021 09:07:02 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4gmd_cygXK0PpGkXmJLC3_ctEpRvpi5P-QcuXusFX5oNQ@mail.gmail.com>
 <20210210112330.00003e74@Huawei.com> <CAPcyv4gOyPjVcBa_m6pvpVP+vamJ38G7ePos-2LP273y3ivJqg@mail.gmail.com>
 <20210211094222.000048ae@Huawei.com>
In-Reply-To: <20210211094222.000048ae@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 11 Feb 2021 09:06:51 -0800
Message-ID: <CAPcyv4j0Wce-76OfgqTSkveukgDXB_p2VZZpgM8XjDFd+Q-0Ww@mail.gmail.com>
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

On Thu, Feb 11, 2021 at 1:44 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 10 Feb 2021 08:24:51 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Wed, Feb 10, 2021 at 3:24 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Tue, 9 Feb 2021 19:55:05 -0800
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > > While the platform BIOS is able to describe the performance
> > > > characteristics of CXL memory that is present at boot, it is unable to
> > > > statically enumerate the performance of CXL memory hot inserted
> > > > post-boot. The OS can enumerate most of the characteristics from link
> > > > registers and CDAT, but the performance from the CPU to the host
> > > > bridge, for example, is not enumerated by PCIE or CXL. Introduce an
> > > > ACPI mechanism for this purpose. Critically this is achieved with a
> > > > small tweak to how the existing Generic Initiator proximity domain is
> > > > utilized in the HMAT.
> > >
> > > Hi Dan,
> > >
> > > Agree there is a hole here, but I think the proposed solution has some
> > > issues for backwards compatibility.
> > >
> > > Just to clarify, I believe CDAT from root ports is sufficient for the
> > > other direction (GI on CXL, memory in host).  I wondered initially if
> > > this was a two way issue, but after a reread, I think that is fine
> > > with the root port providing CDAT or potentially treating the root
> > > port as a GI (though that runs into the same naming / representation issue
> > > as below and I think would need some clarifying text in UEFI GI description)
> > >
> > > http://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute%20Table_1.01.pdf
> > >
> > > For the case you are dealing with here potentially we 'could' add something
> > > to CDAT as alternative to changing SRAT, but it would be more complex
> > > so your approach here makes more sense to me.
> >
> > CDAT seems the wrong mechanism because it identifies target
> > performance once you're at the front door of the device, not
> > performance relative to a given initiator.
>
> I'd argue you could make CDAT a more symmetric representation, but it would
> end up replicating a lot of info already in HMAT.  Didn't say it was a good
> idea!

CDAT describes points, HMAT describes edges on the performance graph,
it would be confusing if CDAT tried to supplant HMAT.

>
> That's an odd situation that it sort of 'half' manages it in the BIOS.
> We probably need some supplementary additional docs around this topic
> as the OS would need to be aware of that possibility and explicitly check
> for it before doing its normal build based on CDAT + what you are proposing
> here.  Maybe code is enough but given this is cross OS stuff I'd argue
> it probably isn't.
>
> I guess could revisit this draft Uefi white paper perhaps and add a bunch
> of examples around this usecase https://github.com/hisilicon/acpi-numa-whitepaper

Thanks for the reference, I'll take a look.

>
> >
> > >
> > > >
> > > > # Impact of the Change
> > > > The existing Generic Initiator Affinity Structure (ACPI 6.4 Section
> > > > 5.2.16.6) already contains all the fields necessary to enumerate a
> > > > generic target proximity domain. All that is missing is the
> > > > interpretation of that proximity domain optionally as a target
> > > > identifier in the HMAT.
> > > >
> > > > Given that the OS still needs to dynamically enumerate and instantiate
> > > > the memory ranges behind the host bridge. The assumption is that
> > > > operating systems that do not support native CXL enumeration will ignore
> > > > this data in the HMAT, while CXL native enumeration aware environments
> > > > will use this fragment of the performance path to calculate the
> > > > performance characteristics.
> > >
> > > I don't think it is true that OS not supporting native CXL will ignore the
> > > data.
> >
> > True, I should have chosen more careful words like s/ignore/not
> > regress upon seeing/
>
> It's a sticky corner and I suspect likely to come up at in ACPI WG - what is
> being proposed here isn't backwards compatible

It seems our definitions of backwards compatible are divergent. Please
correct me if I'm wrong, but I understand your position to be "any
perceptible OS behavior change breaks backwards compatibility",
whereas I'm advocating that backwards compatibility is relative
regressing real world use cases. That said, I do need to go mock this
up in QEMU and verify how much disturbance it causes.

> even if the impacts in Linux are small.

I'd note the kernel would grind to a halt if the criteria for
"backwards compatible" was zero perceptible behavior change.

> Mostly it's infrastructure bring up that won't get used
> (fallback lists and similar for a node which will never be specified in
> allocations) and some confusing userspace ABI (which is more than a little
> confusing already).

Fallback lists are established relative to online nodes. These generic
targets are not onlined as memory.

> > > Linux will create a small amount of infrastructure to reflect them (more or
> > > less the same as a memoryless node) and also they will appear in places
> > > like access0 as a possible initiator of transactions.  It's small stuff,
> > > but I'd rather the impact on legacy was zero.
> >
> > I'm failing to see that small collision as fatal to the proposal. The
> > HMAT parsing had a significant bug for multiple kernel releases and no
> > one noticed. This quirk is minor in comparison.
>
> True, there is a lag in HMAT adoption - though for ACPI tables, not that long
> (only a couple of years :)
>
> >
> > >
> > > So my gut feeling here is we shouldn't reuse the generic initiator, but
> > > should invent something new.  Would look similar to GI, but with a different
> > > ID - to ensure legacy OS ignores it.
> >
> > A new id introduces more problems than it solves. Set aside the ACPICA
> > thrash, it does not allow a clean identity mapping of a point in a
> > system topology being both initiator and target. The SRAT does not
> > need more data structures to convey this information. At most I would
> > advocate for an OSC bit for the OS to opt into allowing this new usage
> > in the HMAT, but that still feels like overkill absent a clear
> > regression in legacy environments.
>
> OSC for this case doesn't work. You can't necessarily evaluate it
> early enough in the boot - in Linux the node setup is before AML parsing
> comes up.  HMAT is evaluated a lot later, but SRAT is too early.  + in theory
> another OS is allowed to evaluate HMAT before OSC is available.

The Linux node setup for online memory is before OSC parsing, but
there's nothing to "online" with a GI/GT entry. Also, if this was a
problem, it would already be impacting the OS today because this
proposal only changes HMAT, not SRAT. Lastly there *is* an OSC bit for
GI, so either that's vestigial and needs to be removed, or OSC is
relevant for this case.

>
> > The fact that hardly anyone is
> > using HMAT (as indicated by the bug I mentioned) gives me confidence
> > that perfection is more "enemy of the good" than required here.
>
> How about taking this another way
>
> 1) Assume that the costs of 'false' GI nodes on legacy system as a result
>    of this is minor - so just live with it.  (probably true, but as ever
>    need to confirm with other OS)
>
> 2) Try to remove the cost of pointless infrastructure on 'aware' kernels.
>    Add a flag to the GI entry to say it's a bridge and not expected to,
>    in of itself, represent an initiator or a target.
>    In Linux we then don't create the node intrastructure etc or assign
>    any devices to have the non existent NUMA node.
>
> The information is still there to combine with device info (CDAT) etc
> and build what we eventually want in the way of a representation of
> the topology that Linux can use.
>
> Now we just have the 'small' problem of figuring out how actually implement
> hotplugging of NUMA nodes.

I think it's tiny. Just pad the "possible" nodes past what SRAT enumerates.
