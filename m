Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4D03C9DAF
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jul 2021 13:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbhGOL0I (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Jul 2021 07:26:08 -0400
Received: from foss.arm.com ([217.140.110.172]:51362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240366AbhGOL0I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Jul 2021 07:26:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2975B31B;
        Thu, 15 Jul 2021 04:23:15 -0700 (PDT)
Received: from bogus (unknown [10.57.79.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADB673F694;
        Thu, 15 Jul 2021 04:23:13 -0700 (PDT)
Date:   Thu, 15 Jul 2021 12:22:14 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 06/13] mailbox: pcc: Add pcc_mbox_chan structure to hold
 shared memory region info
Message-ID: <20210715112214.iqpasedboy7hb5cb@bogus>
References: <20210708180851.2311192-1-sudeep.holla@arm.com>
 <20210708180851.2311192-7-sudeep.holla@arm.com>
 <20210714181843.GC49078@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210714181843.GC49078@e120937-lin>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 14, 2021 at 07:18:43PM +0100, Cristian Marussi wrote:
> On Thu, Jul 08, 2021 at 07:08:44PM +0100, Sudeep Holla wrote:
> > Currently PCC mailbox controller sets con_priv in each channel to hold
> > the pointer to pcct subspace entry it corresponds to. The mailbox uses
> 
> nit: s/uses/users
> 
> > will then fetch this pointer from the channel descriptor they get when
> > they request for the channel. Using that pointer they then parse the
> > pcct entry again to fetch all the information about shared memory region.
> > 
> > In order to remove individual users of PCC mailbox parsing the PCCT
> > subspace entries to fetch same information, let us consolidate the same
> > in pcc mailbox controller by parsing all the shared memory region
> > information into a structure that can also hold the mbox_chan pointer it
> > represent.
> > 
> > This can then be used as main PCC mailbox channel pointer that we can
> > return as part of pcc_mbox_request_channel instead of standard mailbox
> > channel pointer.
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/mailbox/pcc.c | 27 +++++++++++++++++++++++++++
> >  include/acpi/pcc.h    |  9 +++++++++
> >  2 files changed, 36 insertions(+)
> > 
> > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> > index 5f19bee71c04..affde0995d52 100644
> > --- a/drivers/mailbox/pcc.c
> > +++ b/drivers/mailbox/pcc.c
> > @@ -67,11 +67,13 @@ static struct mbox_chan *pcc_mbox_channels;
> >  /**
> >   * struct pcc_chan_info - PCC channel specific information
> >   *
> > + * @chan: PCC channel information with Shared Memory Region info
> >   * @db_vaddr: cached virtual address for doorbell register
> >   * @db_ack_vaddr: cached virtual address for doorbell ack register
> >   * @db_irq: doorbell interrupt
> >   */
> >  struct pcc_chan_info {
> > +	struct pcc_mbox_chan chan;
> >  	void __iomem *db_vaddr;
> >  	void __iomem *db_ack_vaddr;
> >  	int db_irq;
> > @@ -469,6 +471,27 @@ static void pcc_parse_subspace_db_reg(struct pcc_chan_info *pchan,
> >  						  db_reg->bit_width / 8);
> >  }
> >  
> > +/**
> > + * pcc_parse_subspace_shmem - Parse the PCC Shared Memory Region information
> > + *
> > + * @pchan: Pointer to the PCC channel info structure.
> > + * @pcct_entry: Pointer to the ACPI subtable header.
> > + *
> > + */
> > +static void pcc_parse_subspace_shmem(struct pcc_chan_info *pchan,
> > +				     struct acpi_subtable_header *pcct_entry)
> > +{
> > +	struct acpi_pcct_subspace *pcct_ss;
> > +
> > +	pcct_ss = (struct acpi_pcct_subspace *)pcct_entry;
> > +
> > +	pchan->chan.shmem_base_addr = pcct_ss->base_address;
> > +	pchan->chan.shmem_size = pcct_ss->length;
> > +	pchan->chan.latency = pcct_ss->latency;
> > +	pchan->chan.max_access_rate = pcct_ss->max_access_rate;
> > +	pchan->chan.min_turnaround_time = pcct_ss->min_turnaround_time;
> > +}
> > +
>
> Out of curiosity this ACPI provided latency/max_access/turnaround_time
> are supposed to be considered and/or enforced where ? by the clients
> using this controller ?
>

Ideally enforced, if not at-least considered by the clients using this
PCC channel. I do agree it results in duplication and at the discretion
of the clients. I am thinking if we can provide some kind of helpers/
accessors to achieve that. Very rough idea still as mentioned in the
cover letter, not looked at all users in details. Some drivers map the
shared memory as normal/cached while majority expects it to be device/IO.
That is one difference to consider while we try to consolidate shmem
accesses. Happy to hear opinions here 😄.

--
Regards,
Sudeep
