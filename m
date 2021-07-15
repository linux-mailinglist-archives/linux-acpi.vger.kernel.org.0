Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A9C3C9F6A
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jul 2021 15:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbhGON2G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Jul 2021 09:28:06 -0400
Received: from foss.arm.com ([217.140.110.172]:52634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhGON2G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Jul 2021 09:28:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9188F31B;
        Thu, 15 Jul 2021 06:25:12 -0700 (PDT)
Received: from bogus (unknown [10.57.79.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88D1B3F694;
        Thu, 15 Jul 2021 06:25:11 -0700 (PDT)
Date:   Thu, 15 Jul 2021 14:24:13 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 03/13] mailbox: pcc: Refactor all PCC channel information
 into a structure
Message-ID: <20210715132413.m5dxa33ydsxoya7j@bogus>
References: <20210708180851.2311192-1-sudeep.holla@arm.com>
 <20210708180851.2311192-4-sudeep.holla@arm.com>
 <20210714165434.GC6592@e120937-lin>
 <20210715112710.55ylycforkessxju@bogus>
 <20210715125048.GD6592@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715125048.GD6592@e120937-lin>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 15, 2021 at 01:50:48PM +0100, Cristian Marussi wrote:
> On Thu, Jul 15, 2021 at 12:27:10PM +0100, Sudeep Holla wrote:
> > On Wed, Jul 14, 2021 at 05:54:34PM +0100, Cristian Marussi wrote:
> > > On Thu, Jul 08, 2021 at 07:08:41PM +0100, Sudeep Holla wrote:
> > > > Currently all the PCC channel specific information are stored/maintained
> > > > in global individual arrays for each of those information. It is not
> > > > scalable and not clean if we have to stash more channel specific
> > > > information. Couple of reasons to stash more information are to extend
> > > > the support to Type 3/4 PCCT subspace and also to avoid accessing the
> > > > PCCT table entries themselves each time we need the information.
> > > >
> > > > This patch moves all those PCC channel specific information into a
> > > > separate structure pcc_chan_info.
> > > >
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > ---
> > >
> > > Hi Sudeep,
> > >
> > > >  drivers/mailbox/pcc.c | 106 +++++++++++++++++++++---------------------
> > > >  1 file changed, 53 insertions(+), 53 deletions(-)
> > > >
> > > > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> > > > index 23391e224a68..c5f481a615b0 100644
> > > > --- a/drivers/mailbox/pcc.c
> > > > +++ b/drivers/mailbox/pcc.c
> > > > @@ -64,12 +64,20 @@
> > > >
> > > >  static struct mbox_chan *pcc_mbox_channels;
> > > >
> > > > -/* Array of cached virtual address for doorbell registers */
> > > > -static void __iomem **pcc_doorbell_vaddr;
> > > > -/* Array of cached virtual address for doorbell ack registers */
> > > > -static void __iomem **pcc_doorbell_ack_vaddr;
> > > > -/* Array of doorbell interrupts */
> > > > -static int *pcc_doorbell_irq;
> > > > +/**
> > > > + * struct pcc_chan_info - PCC channel specific information
> > > > + *
> > > > + * @db_vaddr: cached virtual address for doorbell register
> > > > + * @db_ack_vaddr: cached virtual address for doorbell ack register
> > > > + * @db_irq: doorbell interrupt
> > > > + */
> > > > +struct pcc_chan_info {
> > > > +	void __iomem *db_vaddr;
> > > > +	void __iomem *db_ack_vaddr;
> > > > +	int db_irq;
> > > > +};
> > >
> > > Given that this db_irq represents the optional completion interrupt that is
> > > used platform-->OSPM to signal command completions and/or notifications/
> > > delayed_responses and it is mentioned indeed in ACPI 6.4 as "Platform
> > > Interrupt" and also referred in this driver as such somewherelse, is it not
> > > misleading to call it then here "doorbell interrupt" since the "doorbell" in
> > > this context is usually the interrupt that goes the other way around
> > > OSPM-->Platform and is indeed handled by a different set of dedicated Doorbell
> > > registers ? (that are indeed called Doorbell throughout this driver down below
> > > ...but I understand this was the nomenclature used also before in this driver)
> > >
> >
> > Exactly, I share your thoughts and I completely agree. I didn't want to change
> > it in this patch as that would mix 2 different change and makes it hard to
> > review. I assume you might have already seen the 8/13 which renames this
> > before we add more such registers in later patches.
> >
>
> Yes indeed, but db_irq is not renamed even later when db_vaddr/db_ack_addr are
> consolidated and renamed. So that confused me even more :D
>

Yikes! That was not intentional. Since I re-ordered some of the changes
after making them originally, I relied on regex to get it right and ease
the rebasing which I know I failed terribly. I will fix that too.

--
Regards,
Sudeep
