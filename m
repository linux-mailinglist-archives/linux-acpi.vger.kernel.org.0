Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96800403782
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Sep 2021 12:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhIHKIH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Sep 2021 06:08:07 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:56679 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232273AbhIHKIF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 Sep 2021 06:08:05 -0400
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id B231161E5FE33;
        Wed,  8 Sep 2021 12:06:54 +0200 (CEST)
Subject: Re: [PATCH] ACPI/PRM: Find PRMT table before parse it
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <1631066984-63501-1-git-send-email-aubrey.li@intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <79d42839-729e-559b-beda-8f1cdbc1e113@molgen.mpg.de>
Date:   Wed, 8 Sep 2021 12:06:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1631066984-63501-1-git-send-email-aubrey.li@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dear Aubrey,


Am 08.09.21 um 04:09 schrieb Aubrey Li:
> Find and verify PRMT table before parse it, this eliminates a
> warning on machines without PRMT table.
> 
> 	[    7.197173] ACPI: PRMT not present

Please also add:

Fixes: cefc7ca462 ("ACPI: PRM: implement OperationRegion handler for the 
PlatformRtMechanism subtype")

> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>   drivers/acpi/prmt.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index 1f6007a..89c22bc 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -288,10 +288,18 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
>   
>   void __init init_prmt(void)
>   {
> +	struct acpi_table_header *tbl;
>   	acpi_status status;
> -	int mc = acpi_table_parse_entries(ACPI_SIG_PRMT, sizeof(struct acpi_table_prmt) +
> +	int mc;
> +
> +	status = acpi_get_table(ACPI_SIG_PRMT, 0, &tbl);
> +	if (ACPI_FAILURE(status))
> +		return;
> +
> +	mc = acpi_table_parse_entries(ACPI_SIG_PRMT, sizeof(struct acpi_table_prmt) +
>   					  sizeof (struct acpi_table_prmt_header),
>   					  0, acpi_parse_prmt, 0);
> +	acpi_put_table(tbl);
>   	/*
>   	 * Return immediately if PRMT table is not present or no PRM module found.
>   	 */

Thank you very much for preparing the patch.


Kind regards,

Paul
