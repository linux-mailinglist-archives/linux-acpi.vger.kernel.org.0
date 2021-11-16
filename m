Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2AD45378F
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Nov 2021 17:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhKPQfP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Nov 2021 11:35:15 -0500
Received: from mail-oo1-f48.google.com ([209.85.161.48]:39676 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbhKPQdE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Nov 2021 11:33:04 -0500
Received: by mail-oo1-f48.google.com with SMTP id d1-20020a4a3c01000000b002c2612c8e1eso7412561ooa.6;
        Tue, 16 Nov 2021 08:30:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDrq+QOnZFTPGeBGIaTOzJl6i+SxZ4J4MSSRm1zXWEo=;
        b=pzUVTBKPpMUzSEyuoo8RXlXB1b3e7ZX3yxDmfEnHb32yxU9qnpKCiry+85Cn1Iva7k
         EpgMbQiEClb1ntD9HKU41R+/4BnScyFJVTDN40juj2Tf7LBYCJTjMfX1+fXMMDDhO9De
         iDkvmXZPsJW4mBPBbNbBoZjthTkoxUBs744guoo1OPngy8OQs35sBghviwvQutQUrP27
         VuNwDSuys3b8Yh1V88YuvzTlzdvAjvoq+l0SfhF3LCzCDKu0/oSURdI6pR7ERZH9NJ9g
         eqZd4ZYZsEgm4faNwbl1ibEl7CjNeHPw32m/hzqWcthCd2qr2tglwApdIqMho5Iz9Uxr
         gwSA==
X-Gm-Message-State: AOAM532nHESU9wmnBLEPHOpmJef6ChJJMUb+3nUaSQP9B9T+83MQmmni
        5TIQ7d+CtNcUzj/8vDwNkaBumtri+bcWU02V3E8=
X-Google-Smtp-Source: ABdhPJxK/62djEfWaXqQrqza5crsAmOwUIaEHqlghK4v2HJzDZB/TIcs7/cdigkhRN0w2Xl4J44nQng2/aBhY8d7cE0=
X-Received: by 2002:a4a:ead8:: with SMTP id s24mr4437160ooh.89.1637080207075;
 Tue, 16 Nov 2021 08:30:07 -0800 (PST)
MIME-Version: 1.0
References: <20211101200346.16466-1-quic_qiancai@quicinc.com>
 <CAHp75VcrWPdR8EVGpcsniQedT0J4X700N7thFs6+srTP1MTgwQ@mail.gmail.com>
 <52df4a97-1132-d594-0180-132d0ca714d5@quicinc.com> <CAHp75VebOnrce-XZjOnZiivQPz-Cdgq6mor5oiLxK8Y49GiNNg@mail.gmail.com>
 <YZMrjqhYYNGMP84x@qian-HP-Z2-SFF-G5-Workstation>
In-Reply-To: <YZMrjqhYYNGMP84x@qian-HP-Z2-SFF-G5-Workstation>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Nov 2021 17:29:56 +0100
Message-ID: <CAJZ5v0hjq+X=Gej072jwY2Uf4BgvqPHvHTON2p0Mszd5ntjjJA@mail.gmail.com>
Subject: Re: [RFC PATCH] software node: Skip duplicated software_node sysfs
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 16, 2021 at 4:54 AM Qian Cai <quic_qiancai@quicinc.com> wrote:
>
> On Fri, Nov 05, 2021 at 09:39:42PM +0200, Andy Shevchenko wrote:
> > > Anyway, what's the "upper layer"? Is that "struct device" or "struct
> > > swnode"? I suppose you meant:
> >
> > struct device here.
> >
> > > - Remove "secondary" field from "struct fwnode_handle".
> > > - Replace "fwnode" from "upper layer" with
> > >   "struct list_head fwnode_head;".
> > > - Modify all functions in "software_node_ops" to use "fwnode_head".
> > >
> > > Is that correct?
> >
> > Yes.
> >
> > It might be a bit complicated taking into account how much fwnode is
> > spreaded in the kernel... Basically, you need to fix all direct
> > accesses to the dev->fwnode first.
> > Besides that you need to check that fwnode, which is used out of the
> > device scope, like in IRQ domains, doesn't use secondary pointer(s).
> >
> > This nevertheless adds a lot of flexibility and we may add whatever
> > type of fwnodes and mix them together.
>
> Okay, here is my plan until someone still has an idea to avoid a
> redesign.
>
> Frist, fixes all dev->fwnode / dev.fwnode to use dev_fwnode(). This
> could be a standalone tree-wide patchset going out to avoid
> heavy-lifting later.
>
> Then, we can create another patchset on top. I have audited
> "irq_domain" but not seen any "secondary" leakage. Struct
> "cht_int33fe_data" does have some need to fix.
>
> Rename set_secondary_fwnode() to insert_secondary_fwnode(). Fix things
> in drivers/base/core.c, swnode.c etc to use the new fwnode_head and
> anything I can't think of right now.
>
> Since we will have multiple "software_node" (secondary fwnode:s) for a
> single "device". What would be the usual way to deal with a
> linked-list in the sysfs? I can think of just let "software_node"
> become a directory to host a list of symlinks named from
> swnode->id. Thoughts?

Note that one pointer dereference in ACPI_COMPANION() is enough.
