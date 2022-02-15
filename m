Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3306B4B6E47
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Feb 2022 15:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbiBOOFR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Feb 2022 09:05:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiBOOFQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Feb 2022 09:05:16 -0500
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76C43DA6A;
        Tue, 15 Feb 2022 06:05:06 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id bt13so56437169ybb.2;
        Tue, 15 Feb 2022 06:05:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biihkIRRAWUxBq84lbu+MibkbUJ2P2qW/GI/W7wbU00=;
        b=rQ0Eeyb0ZKmV5ROvn1X+wRqZ3UAMiLmzfLzEr9TjEy+lf7GqgWj1kpq2kiC0BViQWl
         G+GIXMjg/neJNHmjD0MhN02J23DTtCz8fsDnrapkOZJ6EujaC0iQBK7wxL6qJN2YG2h5
         lsCATVC4tg+4bPECmqxJfup6J6FBJyJqvqRFJVfun0HVx84Al7eHJDya5meSjnhLUaAa
         GbGgV6zB+7Dwp9e9Pgb4xxVOVk8o8beLKLICqVBdny6NPVacFaERzCLYBzLekm3z1VVv
         pNp5PMsZCBMizaIdVx0YMMf1k1OLJ4uKuGpVk/s2onmcK/kbM2tIZD5YBapHc6sSQR4a
         VS8w==
X-Gm-Message-State: AOAM531ApD4wufzhlMm8pC2thmZFEHWUy/ufXCNXCwfHvdt7HaQlDTE7
        /8AEvLf9UMu2au1y4TxnB5pWQVioPjhs5iatiIw=
X-Google-Smtp-Source: ABdhPJwohV5p5W0xMq6SsY3kDJ4bDpjPyOp8iNfsPm0YBTpI4ktPEEsJgGDjxRd+WdM6XA6RdzVGJAGOJgGbbO2u9dc=
X-Received: by 2002:a25:bd0b:: with SMTP id f11mr2133099ybk.475.1644933905348;
 Tue, 15 Feb 2022 06:05:05 -0800 (PST)
MIME-Version: 1.0
References: <20220211023008.3197397-1-wonchung@google.com> <CAJZ5v0gD4zs3uBAYv6M4_1gNpkZ-g9XKOywJnf5007e6GwoGVA@mail.gmail.com>
 <CAOvb9yjpruiHxkZyZ8BOT0Hi_iV7xMOnBCr59BZX3eah_Zcy_w@mail.gmail.com> <CAOvb9yh7jo27NH32tbAOtkJrnC9LwUFgFbHRbdbArwiU+YSmdw@mail.gmail.com>
In-Reply-To: <CAOvb9yh7jo27NH32tbAOtkJrnC9LwUFgFbHRbdbArwiU+YSmdw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Feb 2022 15:04:54 +0100
Message-ID: <CAJZ5v0gwMSWXMA4XmEioUr2ML3y_NPe9WYUCj2XUj++9ivSLTA@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: device_sysfs: Add sysfs support for _PLD
To:     Won Chung <wonchung@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Adding Greg, who should be involved in this discussion IMO.

On Mon, Feb 14, 2022 at 11:59 PM Won Chung <wonchung@google.com> wrote:
>
> On Mon, Feb 14, 2022 at 12:30 PM Won Chung <wonchung@google.com> wrote:
> >
> > On Mon, Feb 14, 2022 at 11:12 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Fri, Feb 11, 2022 at 3:30 AM Won Chung <wonchung@google.com> wrote:
> > > >
> > > > When ACPI table includes _PLD fields for a device, create a new
> > > > directory (pld) in sysfs to share _PLD fields.
> > >
> > > This version of the patch loos better to me, but I'm not sure if it
> > > goes into the right direction overall.
> > >
> > > > Currently without PLD information, when there are multiple of same
> > > > devices, it is hard to distinguish which device corresponds to which
> > > > physical device in which location. For example, when there are two Type
> > > > C connectors, it is hard to find out which connector corresponds to the
> > > > Type C port on the left panel versus the Type C port on the right panel.
> > >
> > > So I think that this is your primary use case and I'm wondering if
> > > this is the best way to address it.
> > >
> > > Namely, by exposing _PLD information under the ACPI device object,
> > > you'll make user space wanting to use that information depend on this
> > > interface, but the problem is not ACPI-specific (inevitably, it will
> > > appear on systems using DT, sooner or later) and making the user space
> > > interface related to it depend on ACPI doesn't look like a perfect
> > > choice.
> > >
> > > IOW, why don't you create a proper ABI for this in the Type C
> > > subsystem and expose the information needed by user space in a generic
> > > way that can be based on the _PLD information on systems with ACPI?
> >
> > Hi Rafael,
> >
> > Thank you for the review.
> >
> > I was thinking that _PLD info is specific to ACPI since it is part of
> > the ACPI table. Could you explain a little bit more on why you think
> > exposing _PLD fields is not an ACPI-specific problem?

_PLD is an interface defined by ACPI, but its purpose is not ACPI-specific.

> Hi Rafael again,
>
> Sorry for the silly question here. I misunderstood your comment a bit,
> but I talked to Benson and Prashant for clarification. I understand
> now what you mean by it is not an ACPI-specific problem and exposing
> PLD would depend on ACPI.

Right.

> >
> > I gave an example of how _PLD fields can be used for specifying Type C
> > connectors, but it is not Type C specific. For Chrome OS, we plan to
> > initially add PLD to not only Type C connectors but also USB port
> > devices (including Type C and Type A). Also, PLD can be used in the
> > future for describing other types of ports too like HDMI. (Benson and
> > Prashant, please correct or add if I am wrong or missing some
> > information) Maybe my commit message was not detailed enough..
> >
> > I am also curious what Heikki thinks about this. Heikki, can you take
> > a look and share your thoughts?
>
> I am still curious what you and Heikki think about this since it may
> not be a Type C specific issue. We can start from adding generic
> location info to Type C subsystem first, as you suggested, then
> consider how to do the same for USB devices and Type A ports
> afterwards. I would appreciate sharing any thoughts or feedback. Thank
> you very much!

I don't really think that this is a Type C problem either.

It has existed for a long time in the USB world, for example, or
wherever there are user-accessible ports, but it looks like in the
Type C case it has become vitally important.

My point is that writing user space depending on accessing _PLD
information exposed under an ACPI device interface that only
corresponds to the device in question and in the ACPI-specific format
would be a mistake (Greg, please let me know if you disagree).  That's
because (a) it would depend on ACPI tables being present (so it
wouldn't work on systems without them) and (b) it would depend on the
format of data which covers information that isn't likely to be
relevant.

If this information is exposed by the kernel verbatim and user space
depending on this information is created, it will not be possible to
unexpose it even if it turns out that exposing it has been a mistake.

OTOH, if only the relevant pieces of information are exposed in a
generic way, it is always possible to expose more pieces of it in the
future as needed.
