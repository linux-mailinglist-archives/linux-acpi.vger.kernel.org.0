Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B417A454916
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Nov 2021 15:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbhKQOsp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Nov 2021 09:48:45 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:37887 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238702AbhKQOso (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Nov 2021 09:48:44 -0500
Received: by mail-oi1-f169.google.com with SMTP id bj13so6916474oib.4;
        Wed, 17 Nov 2021 06:45:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjhQCnGFiZRZn4HhOXATPtXP/D2AreYkoIRitZsh/OY=;
        b=5UwZzz+wKcHRTaqv2g6iYMkRylYEWe27Ex//6WTM9wf1Nmuq4H6kwho3UvIbNdZUzW
         7Y6BgMikHRNk4N/Iy2HXhEVJa2i9vhRUXZ3UuOHbQOeqSCb/XRgk1/9Y6kKotjlwIpAn
         fXCOpCRdBckK6uyAxRnU4JJ9KkG6Tbi7dBx16ueMEb3gnVKYj2/InCK0UEZTcEy0pwg+
         U4PWl3Jl17wy7jxkfD0AD/tlPmrmN/9pzK5iOGzibME1xRhA/hsckblQpvsDQCRxXkon
         OBbXjQWkIgAn0NP3HiqxcqDK6EJSxJU6CZ8brMDROP66uqZytP73w4+UPVzRWK1g5JZ1
         WMoQ==
X-Gm-Message-State: AOAM533ZymBkaTvn9mbNdmI0ML+mJdbpKxuZQL5MWGnNskUvHsy1hQ7/
        DQMP8g0ZWA8dEBCAOqJj4WQckkNSQRUIPPfEFoi1Urg1
X-Google-Smtp-Source: ABdhPJynHC7yzCykHs/e+D7qfi18Hi/cBuLly/hnyICjVDno7CAzKBnoSWcMNSODhGvkH2KI4hYOsM7/lbJQ3Tjzw3Y=
X-Received: by 2002:a05:6808:14c3:: with SMTP id f3mr129507oiw.51.1637160345289;
 Wed, 17 Nov 2021 06:45:45 -0800 (PST)
MIME-Version: 1.0
References: <20211101200346.16466-1-quic_qiancai@quicinc.com>
 <CAHp75VcrWPdR8EVGpcsniQedT0J4X700N7thFs6+srTP1MTgwQ@mail.gmail.com>
 <52df4a97-1132-d594-0180-132d0ca714d5@quicinc.com> <CAHp75VebOnrce-XZjOnZiivQPz-Cdgq6mor5oiLxK8Y49GiNNg@mail.gmail.com>
 <YZMrjqhYYNGMP84x@qian-HP-Z2-SFF-G5-Workstation> <CAJZ5v0hjq+X=Gej072jwY2Uf4BgvqPHvHTON2p0Mszd5ntjjJA@mail.gmail.com>
 <YZUT5EPqPiPy2iiy@fixkernel.fios-router.home>
In-Reply-To: <YZUT5EPqPiPy2iiy@fixkernel.fios-router.home>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 Nov 2021 15:45:34 +0100
Message-ID: <CAJZ5v0if7__bYSnNWYNd7c9MfG32Sm2_cRcw6Qr+C2t2ywE-tg@mail.gmail.com>
Subject: Re: [RFC PATCH] software node: Skip duplicated software_node sysfs
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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

On Wed, Nov 17, 2021 at 3:38 PM Qian Cai <quic_qiancai@quicinc.com> wrote:
>
> On Tue, Nov 16, 2021 at 05:29:56PM +0100, Rafael J. Wysocki wrote:
> > > Frist, fixes all dev->fwnode / dev.fwnode to use dev_fwnode(). This
> > > could be a standalone tree-wide patchset going out to avoid
> > > heavy-lifting later.
> > >
> > > Then, we can create another patchset on top. I have audited
> > > "irq_domain" but not seen any "secondary" leakage. Struct
> > > "cht_int33fe_data" does have some need to fix.
> > >
> > > Rename set_secondary_fwnode() to insert_secondary_fwnode(). Fix things
> > > in drivers/base/core.c, swnode.c etc to use the new fwnode_head and
> > > anything I can't think of right now.
> > >
> > > Since we will have multiple "software_node" (secondary fwnode:s) for a
> > > single "device". What would be the usual way to deal with a
> > > linked-list in the sysfs? I can think of just let "software_node"
> > > become a directory to host a list of symlinks named from
> > > swnode->id. Thoughts?
> >
> > Note that one pointer dereference in ACPI_COMPANION() is enough.
>
> Rafael, we suppose to convert ACPI_COMPANION() to:
>
> to_acpi_device_node(dev_fwnode())
>
> since we will no longer has a dev->fwnode pointer anymore. Do you
> suggest to keep that pointer but convert the "secondary" to a linked
> list instead?

Yes, please.
