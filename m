Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F104818DF74
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Mar 2020 11:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgCUKgB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 21 Mar 2020 06:36:01 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54068 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgCUKgB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Mar 2020 06:36:01 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id e7c2313a2645bf6d; Sat, 21 Mar 2020 11:35:59 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        erik.schmauss@intel.com, lenb@kernel.org, rafael@kernel.org,
        Erik Kaneda <erik.kaneda@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RESEND PATCH] acpi: Add NHLT table signature
Date:   Sat, 21 Mar 2020 11:35:59 +0100
Message-ID: <1841329.abDEU0iM3b@kreacher>
In-Reply-To: <20200320192727.20560-1-cezary.rojewski@intel.com>
References: <20200320192727.20560-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, March 20, 2020 8:27:27 PM CET Cezary Rojewski wrote:
> NHLT (Non-HDAudio Link Table) provides configuration of audio
> endpoints for Intel SST (Smart Sound Technology) DSP products. Similarly
> to other ACPI tables, data provided by BIOS may not describe it
> correctly, thus overriding is required.
> 
> ACPI override mechanism checks for unknown signature before proceeding.
> Update known signatures array to support NHLT.
> 
> Cc: Erik Kaneda <erik.kaneda@intel.com>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>  drivers/acpi/tables.c | 2 +-
>  include/acpi/actbl2.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 180ac4329763..0e905c3d1645 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -501,7 +501,7 @@ static const char * const table_sigs[] = {
>  	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
>  	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>  	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> -	NULL };
> +	ACPI_SIG_NHLT, NULL };
>  
>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>  
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index e45ced27f4c3..876ccf50ec36 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -43,6 +43,7 @@
>  #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
>  #define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception Interface Table */
>  #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
> +#define ACPI_SIG_NHLT           "NHLT"	/* Non-HDAudio Link Table */
>  
>  /*
>   * All tables must be byte-packed to match the ACPI specification, since
> 

This should go in through the ACPICA upstream IMO.




