Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D4E3C9F96
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jul 2021 15:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhGONlU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Jul 2021 09:41:20 -0400
Received: from foss.arm.com ([217.140.110.172]:52736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231327AbhGONlU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Jul 2021 09:41:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC47B31B;
        Thu, 15 Jul 2021 06:38:26 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C4B43F694;
        Thu, 15 Jul 2021 06:38:25 -0700 (PDT)
Date:   Thu, 15 Jul 2021 14:38:23 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 10/13] mailbox: pcc: Avoid accessing PCCT table in
 pcc_send_data and pcc_mbox_irq
Message-ID: <20210715133823.GE6592@e120937-lin>
References: <20210708180851.2311192-1-sudeep.holla@arm.com>
 <20210708180851.2311192-11-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708180851.2311192-11-sudeep.holla@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 08, 2021 at 07:08:48PM +0100, Sudeep Holla wrote:
> Now that the con_priv is availvale solely for PCC mailbox controller
> driver, let us use the same to save the channel specific information
> in it so that we can it whenever required instead of parsing the PCCT
> table entries every time in both pcc_send_data and pcc_mbox_irq.
> 
> We can now use the newly introduces PCC register bundle to simplify both
> saving of channel specific information and accessing them without repeated
> checks for the subspace type.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---o
[snip]
>

Sorry missed this small doxygen break along the way early:

>  /**
> @@ -516,19 +457,20 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
>   * @pcct_entry: Pointer to the ACPI subtable header.
>   *
>   */
> -static void pcc_parse_subspace_db_reg(struct pcc_chan_info *pchan,
> -				      struct acpi_subtable_header *pcct_entry)
> +static int pcc_parse_subspace_db_reg(struct pcc_chan_info *pchan,
> +				     struct acpi_subtable_header *pcct_entry)
>  {
> +	int ret = 0;
> +


drivers/mailbox/pcc.c:485: warning: No description found for return value of 'pcc_parse_subspace_db_reg'

Thanks,
Cristian
