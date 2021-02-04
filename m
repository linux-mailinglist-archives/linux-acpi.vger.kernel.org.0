Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43C430C871
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 18:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbhBBRuL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 12:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbhBBRrJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 12:47:09 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F466C061788
        for <linux-acpi@vger.kernel.org>; Tue,  2 Feb 2021 09:46:27 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id lg21so3972547ejb.3
        for <linux-acpi@vger.kernel.org>; Tue, 02 Feb 2021 09:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wUurNA9VhndOPP6gfhXBN1JbTKtpFDXXD0/WIc6R26Q=;
        b=Q+gyF53uYybQ7VU8537+gYM+aGyprhjPmxAfLGnXP6OwT0GUtgTrUly1i2fwhFGjtq
         p8whi96zlLUuqYC2XLni6OtAlLqCFkUCNoE29gm7ZNiukEuBRSs16ly47hZcjG6mcf6W
         YYvDPxx/KBKbT4jC9DYrUXZosFGn5i6Xf3mWMFX+1Qr7C65VszwwhvahhMB2NecwsZzI
         e3RqPl7eS6e+HVxxdVcQDLle6L5RSDpa1rJm+u/OFMeLblLfAyT40bK/SRA5AhfI1W1U
         CrxE+ACZJOsvAUYzBKsXKBmEsSRk8P5lses045BxA80LjvV+151v8gAD+DbIAjYVFUu2
         jitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wUurNA9VhndOPP6gfhXBN1JbTKtpFDXXD0/WIc6R26Q=;
        b=KgX3Hc+9IefsCYrHsIBD5rAkbYhSz9vAqfxtPFjubaA6tpahppLOBS1F9zYeA9Y5D4
         8n3pBUJowXLo43IxhjExoXdANELAm6cP4I5olrDBRU8D/2Gni0m+r9DyJRaitW0LCneO
         6cN69I5DhEPqv0cqI69eUEkgSQN9R6FdxS4Iwh5kD1CrD77aZEBZUGqH4mVxd/+h6mAz
         34SS8tOtNx2TLlmXpveexO5lSbDSit81XJ4S2LlET/1GxpivOm0YPo/Bu1icLSzRtVJ9
         kfBBT9bVQClc6Vcsuzdix+HpCTenktkPW+nUKCslDlB4wz1OJBiKmz+yXseW4k4oapaS
         vRiw==
X-Gm-Message-State: AOAM532QbHKHfcRl/iEKWocd7T48CMfqVC/wXhrHdkBFFYC+2iN8uEqM
        k3wlCxM3H/ROTqOZSbR4Dns64gomtj65FTt6zVXWnQ==
X-Google-Smtp-Source: ABdhPJxJMQPeK8rJWCApObIytFXRIQO5rlc1bINukN6cy207HKpFiuo3Yrd9r7/axKlxQdWCDqWdakZUfI9gkorugGA=
X-Received: by 2002:a17:906:8252:: with SMTP id f18mr2377108ejx.418.1612287985906;
 Tue, 02 Feb 2021 09:46:25 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-9-ben.widawsky@intel.com> <20210201181845.GJ197521@fedora>
 <20210201183455.3dndfwyswwvs2dlm@intel.com> <CAPcyv4iBbA+PCnTg-hFALuDJNqcJrwwXN_gMEe6z9LZvSfC5hw@mail.gmail.com>
 <YBi9nkiu3DvMZhrs@Konrads-MacBook-Pro.local>
In-Reply-To: <YBi9nkiu3DvMZhrs@Konrads-MacBook-Pro.local>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 2 Feb 2021 09:46:23 -0800
Message-ID: <CAPcyv4j7xHcz+0+e35k3ed0O3muynMu3HzhXCNFpHreP1jAyHA@mail.gmail.com>
Subject: Re: [PATCH 08/14] taint: add taint for direct hardware access
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 1, 2021 at 6:50 PM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Mon, Feb 01, 2021 at 11:01:11AM -0800, Dan Williams wrote:
> > On Mon, Feb 1, 2021 at 10:35 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 21-02-01 13:18:45, Konrad Rzeszutek Wilk wrote:
> > > > On Fri, Jan 29, 2021 at 04:24:32PM -0800, Ben Widawsky wrote:
> > > > > For drivers that moderate access to the underlying hardware it is
> > > > > sometimes desirable to allow userspace to bypass restrictions. Once
> > > > > userspace has done this, the driver can no longer guarantee the sanctity
> > > > > of either the OS or the hardware. When in this state, it is helpful for
> > > > > kernel developers to be made aware (via this taint flag) of this fact
> > > > > for subsequent bug reports.
> > > > >
> > > > > Example usage:
> > > > > - Hardware xyzzy accepts 2 commands, waldo and fred.
> > > > > - The xyzzy driver provides an interface for using waldo, but not fred.
> > > > > - quux is convinced they really need the fred command.
> > > > > - xyzzy driver allows quux to frob hardware to initiate fred.
> > > >
> > > > Would it not be easier to _not_ frob the hardware for fred-operation?
> > > > Aka not implement it or just disallow in the first place?
> > >
> > > Yeah. So the idea is you either are in a transient phase of the command and some
> > > future kernel will have real support for fred - or a vendor is being short
> > > sighted and not adding support for fred.
> > >
> > > >
> > > >
> > > > >   - kernel gets tainted.
> > > > > - turns out fred command is borked, and scribbles over memory.
> > > > > - developers laugh while closing quux's subsequent bug report.
> > > >
> > > > Yeah good luck with that theory in-the-field. The customer won't
> > > > care about this and will demand a solution for doing fred-operation.
> > > >
> > > > Just easier to not do fred-operation in the first place,no?
> > >
> > > The short answer is, in an ideal world you are correct. See nvdimm as an example
> > > of the real world.
> > >
> > > The longer answer. Unless we want to wait until we have all the hardware we're
> > > ever going to see, it's impossible to have a fully baked, and validated
> > > interface. The RAW interface is my admission that I make no guarantees about
> > > being able to provide the perfect interface and giving the power back to the
> > > hardware vendors and their driver writers.
> > >
> > > As an example, suppose a vendor shipped a device with their special vendor
> > > opcode. They can enable their customers to use that opcode on any driver
> > > version. That seems pretty powerful and worthwhile to me.
> > >
> >
> > Powerful, frightening, and questionably worthwhile when there are
> > already examples of commands that need extra coordination for whatever
> > reason. However, I still think the decision tilts towards allowing
> > this given ongoing spec work.
> >
> > NVDIMM ended up allowing unfettered vendor passthrough given the lack
> > of an organizing body to unify vendors. CXL on the other hand appears
> > to have more gravity to keep vendors honest. A WARN splat with a
> > taint, and a debugfs knob for the truly problematic commands seems
> > sufficient protection of system integrity while still following the
> > Linux ethos of giving system owners enough rope to make their own
> > decisions.
> >
> > > Or a more realistic example, we ship a driver that adds a command which is
> > > totally broken. Customers can utilize the RAW interface until it gets fixed in a
> > > subsequent release which might be quite a ways out.
> > >
> > > I'll say the RAW interface isn't an encouraged usage, but it's one that I expect
> > > to be needed, and if it's not we can always try to kill it later. If nobody is
> > > actually using it, nobody will complain, right :D
> >
> > It might be worthwhile to make RAW support a compile time decision so
> > that Linux distros can only ship support for the commands the CXL
> > driver-dev community has blessed, but I'll leave it to a distro
> > developer to second that approach.
>
> Couple of thoughts here:

I am compelled to challenge these assertions because this set is
*more* conservative than the current libnvdimm situation which is
silent by default about the vendor pasthrough. How can this be worse
when the same scope of possible damage is now loudly reported rather
than silent?

>
>  - As distro developer (well, actually middle manager of distro
>    developers) this approach of raw interface is a headache.

You've convinced me that this needs a compile time disable, is that
not sufficient?

>
>    Customers will pick it

Why will they pick it when the kernel screams bloody murder at them
when it gets used?

> and use it since it is there and the poor
>    support folks will have to go through layers of different devices

What layers willl support folks need to dig through when the WARN
splat is clearly present in the log and the taint flag is visible in
any future crash?

>    say (for example) to finally find out that some OEM firmware opcode
>    X is a debug facility for inserting corrupted data, while for another vendor
>    the same X opcode makes it go super-fast.

None of these commands are in the fast path.

>
>    Not that anybody would do that, right? Ha!

We can look to libnvdimm + ndctl to see the trend. I have not
encountered new competing manageability tool efforts, and the existing
collisions between ndctl and ipmctl are resolving to defeature ipmctl
where ndctl and the standard / native command path can do the job.

>
>  - I will imagine that some of the more vocal folks in the community
>    will make it difficult to integrate these patches with these two
>    (especially this taint one). This will make the acceptance of these
>    patches more difficult than it should be. If you really want them,
>    perhaps make them part of another patchset, or a follow up ones.

The patches are out now and no such pushback from others has arisen. I
believe your proposal for compile-time disable is reasonable and would
satisfy those concerns.

>
>  - I still don't get why as a brand new community hacks are coming up
>    (even when the hardware is not yet there) instead of pushing back at
>    the vendors to have a clean up interface. I get in say two or three
>    years these things .. but from the start? I get your point about
>    flexibility, but it seems to me that the right way is not give open
>    RAW interface (big barndoor) but rather maintain the driver and grow
>    it (properly constructed doors) as more functionality comes about
>    and then adding it in the driver.
>

Again, WARN_TAINT and now the threat of vendor tools not being
generally distributable across distro kernels that turn this off, is a
more strict stance than libnvdimm where the worst fears have yet to
come to fruition. In the meantime this enabling is useful for a
validation test bench kernel for new hardware bringup while the
upstream api formalization work continues.
