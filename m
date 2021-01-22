Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD59300E91
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 22:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbhAVVKB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 16:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbhAVVIr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2021 16:08:47 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23900C061786
        for <linux-acpi@vger.kernel.org>; Fri, 22 Jan 2021 13:08:06 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id y4so6803719ybn.3
        for <linux-acpi@vger.kernel.org>; Fri, 22 Jan 2021 13:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVc/JMkhbZ642gWanQRDHxa/CH0+8991b/z+xpWJCVE=;
        b=sv6yjs1f0h/jilFnfWEYscV2TwPHz046JX1vja4M1fRL7/hPcAimzjsx09ndnGML1+
         R1dYHaoAPYi/shuH4sdW1QblpzxI+u7SkGi3MNPi+El6gPb+WhnRHFnDiaz77PyejxFE
         bnlC79MJ79AWbokEVsWQaIgH4NFvplailCmo3cPt7yPvl3blKaOiFXfBUpasnfE4IK9r
         7wvBHXRMAI9Qdf83Jkdbgx9puJ8gL8d0sUEX1S8mMSLen7WXn9rifkY8zRhBpmsCmZJt
         nzUKXEqWgZeUtPVfru5jeTmT17iJVykkgsqIfG57gyHnRFVvjTp2xRRjltHv51NQUBgf
         HgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVc/JMkhbZ642gWanQRDHxa/CH0+8991b/z+xpWJCVE=;
        b=KVUrfcpPZJZ058JBpH0PVMw2DGyqNmgU8GMubQ/2qzifBTpg7aYTX0fJwWD//2GLDF
         4RdIL/ktzUoya4Tr82J9kryDZrRHoWuImiykLYDLwa4wrP77ClcRXnnXdZPlcxPiWODT
         wbFEQS5jCkQMpOn3V2dy35vq5DGVcnglcCZnExSLT83RcQL4Zr/of0OnCAJJRJCNh7rF
         sXcMqRCL+lo+KHg576d7PXRsHzbWglGqpDy1BLYUW1L8xKdTyqkgA3mN6c1yhyZ/Hhpm
         6VmFqa7vKV3PtYlXc7Qp2sJEvQ4JxfTlX40UscIhAojs+v3eJfAxjUeJlyl/XVNQdlDc
         2DFQ==
X-Gm-Message-State: AOAM5333abQVUsbTpTYCWWWBpIbDRu+rSmSGRnKsKi8ZU4mtumTtd/MQ
        2XgliipTh4MTHubvfKVawa/t3svGjAltHiOMJvo2Gw==
X-Google-Smtp-Source: ABdhPJzl3B4tmnY6/Kaav43wpplRGKE3E6UPYGKpTFTuTVbPUkkV4q2p8tfyfjSW1l1la2fC7GPmuC9hUaiU1fTvO1w=
X-Received: by 2002:a25:3345:: with SMTP id z66mr9256594ybz.466.1611349685124;
 Fri, 22 Jan 2021 13:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20210112134054.342-1-calvin.johnson@oss.nxp.com>
 <20210112134054.342-10-calvin.johnson@oss.nxp.com> <CAGETcx-7JVz=QLCMWicHqoagWYjeBXdFJmSv1v6MQhtPt2RS=Q@mail.gmail.com>
 <20210112180343.GI4077@smile.fi.intel.com> <CAJZ5v0iW0jJUcXtiQtLOakkSejZCJD=hTFLL4mvoAN3ZTB+1Tw@mail.gmail.com>
 <CAHp75VcJS10KMA5amUc36PFgj0FLddj1fXD4dUtuAchrVhhzPg@mail.gmail.com>
 <CAJZ5v0ga5RqwFzbBqSChJ7=gBBM-7dWNQPz6bqvqsNAkWZJ=vQ@mail.gmail.com>
 <CAGETcx8DP8J53ntxX2VCSnbMfq1qki7gD-md+NC_jVfOkTam3g@mail.gmail.com>
 <CAJZ5v0gUCUxJX9sGJiZ+zTVYrc3rjuUO2B2fx+O6PewbG7F8aw@mail.gmail.com>
 <CAGETcx-904Cr11nVW6PC=OqWnwM-ZC-DdEUa8+7JmhsH3UOqHw@mail.gmail.com> <CAHp75VcVNj0+KZiLEsPgfz=fZoLr9g1=6ikeUo7FZ1rd4FKpWQ@mail.gmail.com>
In-Reply-To: <CAHp75VcVNj0+KZiLEsPgfz=fZoLr9g1=6ikeUo7FZ1rd4FKpWQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 22 Jan 2021 13:07:29 -0800
Message-ID: <CAGETcx-CFPa6hckV6RjWfOcYnrfoU1_vYYpLZtV_LgxNSDzthQ@mail.gmail.com>
Subject: Re: [net-next PATCH v3 09/15] device property: Introduce fwnode_get_id()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Calvin Johnson <calvin.johnson@oss.nxp.com>,
        Grant Likely <grant.likely@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Cristi Sovaiala <cristian.sovaiala@nxp.com>,
        Florin Laurentiu Chiculita <florinlaurentiu.chiculita@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Madalin Bucur <madalin.bucur@oss.nxp.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Pieter Jansen Van Vuuren <pieter.jansenvv@bamboosystems.io>,
        Jon <jon@solid-run.com>,
        Diana Madalina Craciun <diana.craciun@nxp.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux.cj" <linux.cj@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 22, 2021 at 1:05 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Jan 22, 2021 at 10:59 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Fri, Jan 22, 2021 at 8:34 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Wed, Jan 20, 2021 at 9:01 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > On Wed, Jan 20, 2021 at 11:15 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>
> > > > I'd rather this new function be an ops instead of a bunch of #ifdef or
> > > > if (acpi) checks. Thoughts?
> > >
> > > Well, it looks more like a helper function than like an op and I'm not
> > > even sure how many potential users of it will expect that _ADR should
> > > be evaluated in the absence of the "reg" property.
> > >
> > > It's just that the "reg" property happens to be kind of an _ADR
> > > equivalent in this particular binding AFAICS.
> >
> > I agree it is not clear how useful this helper function is going to be.
> >
> > But in general, to me, any time the wrapper/helper functions in
> > drivers/base/property.c need to do something like this:
> >
> > if (ACPI)
> >    ACPI specific code
> > if (OF)
> >    OF specific code
> >
> > I think the code should be pushed to the fwnode ops. That's one of the
> > main point of fwnode. So that firmware specific stuff is done by
> > firmware specific code. Also, when adding support for new firmware,
> > it's pretty clear what support the firmware needs to implement.
> > Instead of having to go fix up a bunch of code all over the place.
>
> Wishful thinking.
> In the very case of GPIO it's related to framework using headers local
> to framework. Are you suggesting to open its guts to the entire wild
> world?

What are you even talking about? How is whatever you are saying
remotely related to getting an "id" for a fwnode?

> I don't think it's a good idea. You see, here we have different
> layering POD types,

POD?

> which are natural and quite low level that ops
> suits best for them and quite different resource types like GPIO. And
> the latter is closer to certain framework rather than to POD handling
> cases.
>

-Saravana
