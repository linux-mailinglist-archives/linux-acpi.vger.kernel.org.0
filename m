Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A350415A868
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 12:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgBLL4I (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 06:56:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:58000 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgBLL4I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 06:56:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6BED4AC5C;
        Wed, 12 Feb 2020 11:56:06 +0000 (UTC)
Date:   Wed, 12 Feb 2020 12:56:05 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Subject: Re: [PATCH 2/3] ACPI / watchdog: Fix gas->access_width usage
Message-ID: <20200212125605.4b2013b4@endymion>
In-Reply-To: <20200212110540.83559-2-mika.westerberg@linux.intel.com>
References: <20200211180331.11dbe525@endymion>
        <20200212110540.83559-1-mika.westerberg@linux.intel.com>
        <20200212110540.83559-2-mika.westerberg@linux.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 12 Feb 2020 14:05:39 +0300, Mika Westerberg wrote:
> ACPI Generic Address Structure (GAS) access_width field is not in bytes
> as the driver seems to expect in few places so fix this by using the
> newly introduced macro ACPI_ACCESS_BIT_WIDTH().
> 
> Reported-by: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> Not sure if this is stable material since there is no user visible issues
> without the fix. If this needs to go stable then the ACPICA change need to
> be taken there as well (or we make separate fix for stable without the
> macro).

I thought about it too and I don't think it qualifies for stable
because we have no proof it affects any user in pratcice. You may want
to add a "Fixes:" tag though to track where the bug was introduced and
let distributions backport the fix if they want to.

> 
>  drivers/acpi/acpi_watchdog.c | 3 +--
>  drivers/watchdog/wdat_wdt.c  | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
> index b5516b04ffc0..ef0832999892 100644
> --- a/drivers/acpi/acpi_watchdog.c
> +++ b/drivers/acpi/acpi_watchdog.c
> @@ -126,12 +126,11 @@ void __init acpi_watchdog_init(void)
>  		gas = &entries[i].register_region;
>  
>  		res.start = gas->address;
> +		res.end = res.start + ACPI_ACCESS_BIT_WIDTH(gas->access_width) - 1;
>  		if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>  			res.flags = IORESOURCE_MEM;
> -			res.end = res.start + ALIGN(gas->access_width, 4) - 1;
>  		} else if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
>  			res.flags = IORESOURCE_IO;
> -			res.end = res.start + gas->access_width - 1;
>  		} else {
>  			pr_warn("Unsupported address space: %u\n",
>  				gas->space_id);
> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index b069349b52f5..2132018f031d 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c
> @@ -389,7 +389,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>  
>  		memset(&r, 0, sizeof(r));
>  		r.start = gas->address;
> -		r.end = r.start + gas->access_width - 1;
> +		r.end = r.start + ACPI_ACCESS_BIT_WIDTH(gas->access_width) - 1;
>  		if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>  			r.flags = IORESOURCE_MEM;
>  		} else if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {

You are using ACPI_ACCESS_BIT_WIDTH() where you clearly meant to use
ACPI_ACCESS_BYTE_WIDTH().

-- 
Jean Delvare
SUSE L3 Support
