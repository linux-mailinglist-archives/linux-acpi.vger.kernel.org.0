Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFDD3C8A00
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jul 2021 19:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbhGNRrQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jul 2021 13:47:16 -0400
Received: from foss.arm.com ([217.140.110.172]:37704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239759AbhGNRrP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Jul 2021 13:47:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F35BD6E;
        Wed, 14 Jul 2021 10:44:23 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 473993F774;
        Wed, 14 Jul 2021 10:44:22 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:44:19 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 04/13] mailbox: pcc: Consolidate subspace interrupt
 information parsing
Message-ID: <20210714174419.GA49078@e120937-lin>
References: <20210708180851.2311192-1-sudeep.holla@arm.com>
 <20210708180851.2311192-5-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708180851.2311192-5-sudeep.holla@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 08, 2021 at 07:08:42PM +0100, Sudeep Holla wrote:
> Extended PCC subspaces(Type 3 and 4) differs from generic(Type 0) and

nit: s/differs/differ

> HW-Reduced Communication(Type 1 and 2) subspace structures. However some
> fields share same offsets and same type of structure can be use to extract
> the fields. In order to simplify that, let us move all the IRQ related
> information parsing into pcc_parse_subspace_irq and consolidate there.
> It will be easier to extend it if required within the same.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/mailbox/pcc.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index c5f481a615b0..55866676a508 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -404,18 +404,26 @@ static int parse_pcc_subspace(union acpi_subtable_headers *header,
>  
>  /**
>   * pcc_parse_subspace_irq - Parse the PCC IRQ and PCC ACK register
> - *		There should be one entry per PCC client.
> - * @id: PCC subspace index.
> - * @pcct_ss: Pointer to the ACPI subtable header under the PCCT.
> + *
> + * @pchan: Pointer to the PCC channel info structure.
> + * @pcct_entry: Pointer to the ACPI subtable header.
>   *
>   * Return: 0 for Success, else errno.
>   *
> - * This gets called for each entry in the PCC table.
> + * There should be one entry per PCC channel. This gets called for each
> + * entry in the PCC table. This uses PCCY Type1 structure for all applicable
> + * types(Type 1 -4) to fetch irq
>   */
> -static int pcc_parse_subspace_irq(int id, struct acpi_pcct_hw_reduced *pcct_ss)
> +static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
> +				  struct acpi_subtable_header *pcct_entry)
>  {
> -	struct pcc_chan_info *pchan = chan_info + id;
> +	struct acpi_pcct_hw_reduced *pcct_ss;
>  
> +	if (pcct_entry->type < ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE ||
> +	    pcct_entry->type > ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
> +		return 0;
> +
> +	pcct_ss = (struct acpi_pcct_hw_reduced *)pcct_entry;
>  	pchan->db_irq = pcc_map_interrupt(pcct_ss->platform_interrupt,
>  					  (u32)pcct_ss->flags);
>  	if (pchan->db_irq <= 0) {
> @@ -424,8 +432,7 @@ static int pcc_parse_subspace_irq(int id, struct acpi_pcct_hw_reduced *pcct_ss)
>  		return -EINVAL;
>  	}
>  
> -	if (pcct_ss->header.type
> -		== ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
> +	if (pcct_ss->header.type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
>  		struct acpi_pcct_hw_reduced_type2 *pcct2_ss = (void *)pcct_ss;
>  
>  		pchan->db_ack_vaddr =
> @@ -509,17 +516,10 @@ static int __init acpi_pcc_probe(void)
>  		struct acpi_pcct_subspace *pcct_ss;
>  		pcc_mbox_channels[i].con_priv = pcct_entry;
>  
> -		if (pcct_entry->type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE ||
> -		    pcct_entry->type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
> -			struct acpi_pcct_hw_reduced *pcct_hrss;
> -
> -			pcct_hrss = (struct acpi_pcct_hw_reduced *) pcct_entry;
> -
> -			if (pcc_mbox_ctrl.txdone_irq) {
> -				rc = pcc_parse_subspace_irq(i, pcct_hrss);
> -				if (rc < 0)
> -					goto err;
> -			}
> +		if (pcc_mbox_ctrl.txdone_irq) {
> +			rc = pcc_parse_subspace_irq(pchan, pcct_entry);
> +			if (rc < 0)
> +				goto err;
>  		}
>  		pcct_ss = (struct acpi_pcct_subspace *) pcct_entry;
>  
> -- 
> 2.25.1

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

