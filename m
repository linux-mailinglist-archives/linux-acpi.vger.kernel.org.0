Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB243C8AA6
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jul 2021 20:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhGNSVi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jul 2021 14:21:38 -0400
Received: from foss.arm.com ([217.140.110.172]:38056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229738AbhGNSVi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Jul 2021 14:21:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 694A6D6E;
        Wed, 14 Jul 2021 11:18:46 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8769E3F774;
        Wed, 14 Jul 2021 11:18:45 -0700 (PDT)
Date:   Wed, 14 Jul 2021 19:18:43 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 06/13] mailbox: pcc: Add pcc_mbox_chan structure to hold
 shared memory region info
Message-ID: <20210714181843.GC49078@e120937-lin>
References: <20210708180851.2311192-1-sudeep.holla@arm.com>
 <20210708180851.2311192-7-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708180851.2311192-7-sudeep.holla@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 08, 2021 at 07:08:44PM +0100, Sudeep Holla wrote:
> Currently PCC mailbox controller sets con_priv in each channel to hold
> the pointer to pcct subspace entry it corresponds to. The mailbox uses

nit: s/uses/users

> will then fetch this pointer from the channel descriptor they get when
> they request for the channel. Using that pointer they then parse the
> pcct entry again to fetch all the information about shared memory region.
> 
> In order to remove individual users of PCC mailbox parsing the PCCT
> subspace entries to fetch same information, let us consolidate the same
> in pcc mailbox controller by parsing all the shared memory region
> information into a structure that can also hold the mbox_chan pointer it
> represent.
> 
> This can then be used as main PCC mailbox channel pointer that we can
> return as part of pcc_mbox_request_channel instead of standard mailbox
> channel pointer.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/mailbox/pcc.c | 27 +++++++++++++++++++++++++++
>  include/acpi/pcc.h    |  9 +++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 5f19bee71c04..affde0995d52 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -67,11 +67,13 @@ static struct mbox_chan *pcc_mbox_channels;
>  /**
>   * struct pcc_chan_info - PCC channel specific information
>   *
> + * @chan: PCC channel information with Shared Memory Region info
>   * @db_vaddr: cached virtual address for doorbell register
>   * @db_ack_vaddr: cached virtual address for doorbell ack register
>   * @db_irq: doorbell interrupt
>   */
>  struct pcc_chan_info {
> +	struct pcc_mbox_chan chan;
>  	void __iomem *db_vaddr;
>  	void __iomem *db_ack_vaddr;
>  	int db_irq;
> @@ -469,6 +471,27 @@ static void pcc_parse_subspace_db_reg(struct pcc_chan_info *pchan,
>  						  db_reg->bit_width / 8);
>  }
>  
> +/**
> + * pcc_parse_subspace_shmem - Parse the PCC Shared Memory Region information
> + *
> + * @pchan: Pointer to the PCC channel info structure.
> + * @pcct_entry: Pointer to the ACPI subtable header.
> + *
> + */
> +static void pcc_parse_subspace_shmem(struct pcc_chan_info *pchan,
> +				     struct acpi_subtable_header *pcct_entry)
> +{
> +	struct acpi_pcct_subspace *pcct_ss;
> +
> +	pcct_ss = (struct acpi_pcct_subspace *)pcct_entry;
> +
> +	pchan->chan.shmem_base_addr = pcct_ss->base_address;
> +	pchan->chan.shmem_size = pcct_ss->length;
> +	pchan->chan.latency = pcct_ss->latency;
> +	pchan->chan.max_access_rate = pcct_ss->max_access_rate;
> +	pchan->chan.min_turnaround_time = pcct_ss->min_turnaround_time;
> +}
> +

Out of curiosity this ACPI provided latency/max_access/turnaround_time
are supposed to be considered and/or enforced where ? by the clients
using this controller ?

>  /**
>   * acpi_pcc_probe - Parse the ACPI tree for the PCCT.
>   *
> @@ -536,6 +559,8 @@ static int __init acpi_pcc_probe(void)
>  		struct pcc_chan_info *pchan = chan_info + i;
>  		pcc_mbox_channels[i].con_priv = pcct_entry;
>  
> +		pchan->chan.mchan = &pcc_mbox_channels[i];
> +
>  		if (pcc_mbox_ctrl.txdone_irq) {
>  			rc = pcc_parse_subspace_irq(pchan, pcct_entry);
>  			if (rc < 0)
> @@ -543,6 +568,8 @@ static int __init acpi_pcc_probe(void)
>  		}
>  		pcc_parse_subspace_db_reg(pchan, pcct_entry);
>  
> +		pcc_parse_subspace_shmem(pchan, pcct_entry);
> +
>  		pcct_entry = (struct acpi_subtable_header *)
>  			((unsigned long) pcct_entry + pcct_entry->length);
>  	}
> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
> index 4dec4ed138cd..5e510a6b8052 100644
> --- a/include/acpi/pcc.h
> +++ b/include/acpi/pcc.h
> @@ -9,6 +9,15 @@
>  #include <linux/mailbox_controller.h>
>  #include <linux/mailbox_client.h>
>  
> +struct pcc_mbox_chan {
> +	struct mbox_chan *mchan;
> +	u64 shmem_base_addr;
> +	u64 shmem_size;
> +	u32 latency;
> +	u32 max_access_rate;
> +	u16 min_turnaround_time;
> +};
> +
>  #define MAX_PCC_SUBSPACES	256
>  #ifdef CONFIG_PCC
>  extern struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
> -- 
> 2.25.1


Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian
