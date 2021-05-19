Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DC23892A8
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 17:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354876AbhESPbf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 11:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354385AbhESPba (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 May 2021 11:31:30 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF36C061760
        for <linux-acpi@vger.kernel.org>; Wed, 19 May 2021 08:30:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n2so20570015ejy.7
        for <linux-acpi@vger.kernel.org>; Wed, 19 May 2021 08:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0d1XUu2H51X/UWpAoT/6E215/gEAQPiVRFIK9PkOVY0=;
        b=pg2YN9ypboOob/Pa9EQdznyqOWI7Vb4SkTNjXiTAj5NOdll+MmQH9h9N66WLa8fWD1
         WljQyjRO3SZOywENLwSTVsUpH0frps28qIIusXb7QyjRx4IF+iZHU1VcgDExWSs6V8sG
         jwGHGE7/RbgHiA1Jp4/rMQ153nLBstMy+7tKuGiS4qLkJPh6BT3492jNbZF3oZuag5UU
         8wzIDnMu2B3/ZCEauu4Wege6512qpLpLnskVElWUE4mrbizeQRX4bI/V215rY3Hgi+c5
         GWbYPGbgmzykllJFe5vT4+RyKaUMqA8r9RBCreOhkhcPlD6hAqwGS303g8uR/xEuFgC1
         R2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0d1XUu2H51X/UWpAoT/6E215/gEAQPiVRFIK9PkOVY0=;
        b=ZYmUyM0eHjpB+mu9uNNBp2gIxryBQFrf8byh30gKcva7akEo6+TuYD2M4mdgsNgUhI
         ItVuitNaMS041q1eo6T0VsoP3i6ReGsVziva1+2/kq/QIRsjv06iEX1pxQfiq3vRW2N4
         ymbtBCrbnBDKwbopiMP2ou+2Jhx0wI5TBdl55phPWQVbGTK/YMQ+xuzF0Maj19uTnwdv
         x0HS4lMq5O7MqeO4DC/JdHRXdbfPJbTcXdU09mCjW3RnnxMU+rGf0JDMHX4I6Iyi+l3g
         QbmioPumNyvfzDeO5ZbKYgqZzSHGlv1rwi+3m6rKL58PYU6WB24N8SgmeBBtqCBCyjlM
         NvHQ==
X-Gm-Message-State: AOAM533WO1OC6xQkDU9bYcUm1Z003pKUrvIKsM2p1+9B965ccFGsj8bs
        5RGJ9bf3/T5KirHsqgoZ0G1ak75cV/eBnUNH3im1aw==
X-Google-Smtp-Source: ABdhPJwWlgi7eOj8rP/rRDcI6AurWlU6d8gs0XSgkpft5q9uz8j3kgYS7j2VzYHyqsZPMNmYVWqJIqsn2gSrbxos+rY=
X-Received: by 2002:a17:906:e210:: with SMTP id gf16mr13536376ejb.472.1621438209049;
 Wed, 19 May 2021 08:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
 <20210419165451.2176200-3-Jonathan.Cameron@huawei.com> <20210506215934.GJ1904484@iweiny-DESK2.sc.intel.com>
 <20210511175006.00007861@Huawei.com> <CAPcyv4j=uww+85b4AbWmoPNPry_+JLEpEnuywpdC8PonXmRmEg@mail.gmail.com>
 <20210514094755.00002081@Huawei.com> <CAPcyv4h_qSZq+sTAOTKDNsO3xPmq=65j8oO1iw0WdVFj8+XrOA@mail.gmail.com>
 <20210517094045.00004d58@Huawei.com> <CAPcyv4iQcV_U1qmQhXKM0RG9v-sAEPwtTxnv=P86yJrCH25k+w@mail.gmail.com>
 <20210518110403.000013e6@Huawei.com> <CAPcyv4g3JPtAHzemKdQiM44ZkZ_0u+U-UJ5mfeU3fKzRWuaDyQ@mail.gmail.com>
 <20210519161156.00003bf9@Huawei.com>
In-Reply-To: <20210519161156.00003bf9@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 May 2021 08:29:58 -0700
Message-ID: <CAPcyv4j_oEWG1NG1wYryVt3-Gx8q2WwzP7_xhchsDARDR0zBEA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/4] PCI/doe: Add Data Object Exchange support
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 19, 2021 at 8:14 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 19 May 2021 07:18:28 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Tue, May 18, 2021 at 3:06 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Mon, 17 May 2021 10:21:14 -0700
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > > On Mon, May 17, 2021 at 1:42 AM Jonathan Cameron
> > > > <Jonathan.Cameron@huawei.com> wrote:
> > > > >
> > > > > On Fri, 14 May 2021 11:37:12 -0700
> > > > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > > >
> > > > > > On Fri, May 14, 2021 at 1:50 AM Jonathan Cameron
> > > > > > <Jonathan.Cameron@huawei.com> wrote:
> > > > > > [..]
> > > > > > > > If it simplifies the kernel implementation to assume single
> > > > > > > > kernel-initiator then I think that's more than enough reason to block
> > > > > > > > out userspace, and/or provide userspace a method to get into the
> > > > > > > > kernel's queue for service.
> > > > > > >
> > > > > > > This last suggestion makes sense to me. Let's provide a 'right' way
> > > > > > > to access the DOE from user space. I like the idea if it being possible
> > > > > > > to run CXL compliance tests from userspace whilst the driver is loaded.
> > > > > >
> > > > > > Ah, and I like your observation that once the kernel provides a
> > > > > > "right" way to access DOE then userspace direct-access of DOE is
> > > > > > indeed a "you get to keep the pieces" event like any other unwanted
> > > > > > userspace config-write.
> > > > > >
> > > > > > > Bjorn, given this would be a generic PCI thing, any preference for what
> > > > > > > this interface might look like?   /dev/pcidoe[xxxxxx].i with ioctls similar
> > > > > > > to those for the BAR based CXL mailboxes?
> > > > > >
> > > > > > (warning, anti-ioctl bias incoming...)
> > > > >
> > > > > I feel very similar about ioctls - my immediate thought was to shove this in
> > > > > debugfs, but that feels the wrong choice if we are trying to persuade people
> > > > > to use it instead of writing code that directly accesses the config space.
> > > > >
> > > > > >
> > > > > > Hmm, DOE has an enumeration capability, could the DOE driver use a
> > > > > > scheme to have a sysfs bin_attr per discovered object type? This would
> > > > > > make it simliar to the pci-vpd sysfs interface.
> > > > >
> > > > > We can discover the protocols, but anything beyond that is protocol
> > > > > specific.  I don't think there is a enough info available by any standards
> > > > > defined method. Also part of the reason to allow a safe userspace interface
> > > > > would be to provide a generic interface for vendor protocols and things like
> > > > > CXL compliance tests where we will almost certainly never provide a more
> > > > > specific kernel interface.
> > > > >
> > > > > Whilst sysfs would work for CDAT, some protocols are challenge response rather
> > > > > than simple read back and that really doesn't fit well for sysfs model.
> > > > > If we get other protocols that are simple data read back, then I would
> > > > > advocate giving them a simple sysfs interface much like proposed for CDAT
> > > > > as it will always be simpler to use + self describing.
> > > > >
> > > > > On a lesser note it might be helpful to provide sysfs attrs for
> > > > > what protocols are supported.  The alternative is to let userspace run
> > > > > the discovery protocol. Perhaps we can do this as a later phase.
> > > > >
> > > > > >
> > > > > > Then the kernel could cache objects like CDAT that don't change
> > > > > > outside of some invalidation event.
> > > > >
> > > > > It's been a while since I last saw any conversation on sysfs bin_attrs
> > > > > but mostly I thought the feeling was pretty strongly against them for anything
> > > > > but a few niche usecases.
> > > > >
> > > > > Feels to me like it would break most of the usual rules in a way vpd does
> > > > > not (IIRC VPD is supposed to be a simple in the sense that if you write a value
> > > > > to a writable part, you will read back the same value).
> > > > >
> > > > > +CC Greg who is a fount of knowledge in this area (and regularly + correctly
> > > > > screams at the ways I try to abuse sysfs :)  Note I don't think Dan was
> > > > > suggesting implementing response / request directly, but I think that is
> > > > > all we could do given DOE protocols can be vendor specific and the standard
> > > > > discovery protocol doesn't let us know the fine grained support (what commands
> > > > > within a given protocol).
> > > >
> > > > I'm not all that interested in supporting vendor defined DOE
> > > > shenanigans. There's more than enough published DOE protocols that the
> > > > kernel could limit its support to the known set. This is similar to
> > > > how ACPI DSMs are not generically supported, but when they appear in a
> > > > published specification the kernel may then grow the support. The
> > > > supported protocols could be limited to: CDAT, PCIe IDE, CXL
> > > > Compliance, etc...
> > > >
> > > > Vendor specific DOE is in the same class as unfettered /dev/mem
> > > > access, first you need to disable the kernel's integrity and
> > > > confidentiality protections, and then you can do whatever you want. If
> > > > a vendor wants a DOE protocol supported in the "trusted" set they can
> > > > simply publish the specification and send the proper support patches.
> > >
> > > Fair enough, though the interface should be root only, so a vendor shooting
> > > themselves in the foot this way would be no different to using pcitools
> > > to access the device directly (we are just providing safety from concurrency
> > > point of view).
> > >
> > > Anyway, I can see two options for how to do this.
> > >
> > > 1) Per protocol interface. Would not be generic, as these work in entirely
> > >    different ways (some are simple read back of tables, some require complex
> > >    cycles of operations in the right order with data flowing in both directions)
> > > 2) White list those protocols we are going to let through a generic interface
> > >    Not including CXL compliance for instance as that has nasty side effects!
> > >
> > > If we want to enable userspace DOE access, I prefer option 2.
> > >
> > > Note that I wasn't that keen on a userspace interface in the first place as
> > > in my view these should all be handled in kernel.
> > > Ultimately we should have case 1 if userspace access make sense.
> > > However, if we do this we shouldn't pretend we are providing userspace
> > > access to the DOE at all.  We are providing interfaces to things that just
> > > happen to be implemented using DOE under the hood.
> > >
> > > I have a prototype of a trivial ioctl based interface. I'll send it out
> > > as an RFC later this week.  Might add a white list, depending on where
> > > this discussion goes.
> > >
> >
> > I'd say let's do this in typical Linux fashion and not solve future
> > problems before they need to be solved. I.e. start small and build
> > incrementally. To me that looks like a sysfs interface to convey a
> > cached copy of a CDAT with an internal interface for a driver to
> > trigger invalidations and re-reads on the next access. This would
> > assume that userspace may have left the DOE in an indeterminate state
> > and an abort cycle may be needed. A 1 second delay for the rare case
> > where a collision is detected seems reasonable for just CDAT
> > retrieval.
>
> The problem is you can not detect a collision.

This discussion started because Ira questioned the handling of the
busy status. If the DOE is busy and the kernel did not make it busy
then there was a collision, no?

> Hence it's a reset every
> time you use the DOE from in the kernel.

I would expect:

pci_cfg_access_lock()
if (busy)
    reset();
do_doe_operation();
pci_cfg_access_unlock();

> Personally I think that this
> is fixing a problem that doesn't exist.

Again this is all stemming from the driver handling "busy" especially
with the knowledged that it did not busy it itself.

> Userspace should not access
> the DOE when a driver is loaded in exactly the same way it shouldn't
> be writing to anywhere else in config space under normal circumstances.

DOE has data that is similar to what can be retrieved via config read,
it just so happens that reading that data triggers writes. DOE is in a
different class than other configuration writes in terms of the
userspace motivation to access it.

> I really don't see this as special. If we think it is special then
> we should provide a safe interface.


>
> Given it's nearly done, I might send out the ioctl proposal and
> we can can just decide to leave it unmerged for now, pending real
> usecases being established.

Fair enough.
