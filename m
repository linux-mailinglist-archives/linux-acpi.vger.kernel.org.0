Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160A33C8A7E
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jul 2021 20:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239974AbhGNSMf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jul 2021 14:12:35 -0400
Received: from foss.arm.com ([217.140.110.172]:37972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229651AbhGNSMe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Jul 2021 14:12:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0A58D6E;
        Wed, 14 Jul 2021 11:09:42 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABD033F774;
        Wed, 14 Jul 2021 11:09:41 -0700 (PDT)
Date:   Wed, 14 Jul 2021 19:09:39 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 05/13] mailbox: pcc: Consolidate subspace doorbell
 register parsing
Message-ID: <20210714180939.GB49078@e120937-lin>
References: <20210708180851.2311192-1-sudeep.holla@arm.com>
 <20210708180851.2311192-6-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708180851.2311192-6-sudeep.holla@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 08, 2021 at 07:08:43PM +0100, Sudeep Holla wrote:
> Extended PCC subspaces(Type 3 and 4) differs from generic(Type 0) and
nit: s/differs/differ

> HW-Reduced Communication(Type 1 and 2) subspace structures. However some
> fields share same offsets and same type of structure can be use to
> extract the fields. In order to simplify that, let us move all the doorbell
> register parsing into pcc_parse_subspace_db_reg and consolidate there.
> It will be easier to extend it if required within the same.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/mailbox/pcc.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 55866676a508..5f19bee71c04 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -447,6 +447,28 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
>  	return 0;
>  }
>  
> +/**
> + * pcc_parse_subspace_db_reg - Parse the PCC doorbell register
> + *
> + * @pchan: Pointer to the PCC channel info structure.
> + * @pcct_entry: Pointer to the ACPI subtable header.
> + *
> + */
> +static void pcc_parse_subspace_db_reg(struct pcc_chan_info *pchan,
> +				      struct acpi_subtable_header *pcct_entry)
> +{
> +	struct acpi_pcct_subspace *pcct_ss;
> +	struct acpi_generic_address *db_reg;
> +
> +	pcct_ss = (struct acpi_pcct_subspace *)pcct_entry;
> +
> +	/* If doorbell is in system memory cache the virt address */
> +	db_reg = &pcct_ss->doorbell_register;
> +	if (db_reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
> +		pchan->db_vaddr = acpi_os_ioremap(db_reg->address,
> +						  db_reg->bit_width / 8);
> +}
> +
>  /**
>   * acpi_pcc_probe - Parse the ACPI tree for the PCCT.
>   *
> @@ -512,8 +534,6 @@ static int __init acpi_pcc_probe(void)
>  
>  	for (i = 0; i < count; i++) {
>  		struct pcc_chan_info *pchan = chan_info + i;
> -		struct acpi_generic_address *db_reg;
> -		struct acpi_pcct_subspace *pcct_ss;
>  		pcc_mbox_channels[i].con_priv = pcct_entry;
>  
>  		if (pcc_mbox_ctrl.txdone_irq) {
> @@ -521,13 +541,8 @@ static int __init acpi_pcc_probe(void)
>  			if (rc < 0)
>  				goto err;
>  		}
> -		pcct_ss = (struct acpi_pcct_subspace *) pcct_entry;
> +		pcc_parse_subspace_db_reg(pchan, pcct_entry);
>  
> -		/* If doorbell is in system memory cache the virt address */
> -		db_reg = &pcct_ss->doorbell_register;
> -		if (db_reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
> -			pchan->db_vaddr = acpi_os_ioremap(db_reg->address,
> -							  db_reg->bit_width / 8);
>  		pcct_entry = (struct acpi_subtable_header *)
>  			((unsigned long) pcct_entry + pcct_entry->length);
>  	}
> -- 
> 2.25.1
> 

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

