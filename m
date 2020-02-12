Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 966C215AC79
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 16:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgBLPzm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 10:55:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:58208 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbgBLPzm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 10:55:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 49C57AC9D;
        Wed, 12 Feb 2020 15:55:40 +0000 (UTC)
Date:   Wed, 12 Feb 2020 16:55:37 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Tom Abraham <tabraham@suse.com>
Subject: Re: [PATCH v2 2/3] ACPI / watchdog: Fix gas->access_width usage
Message-ID: <20200212165537.46f251cf@endymion>
In-Reply-To: <20200212145941.32914-3-mika.westerberg@linux.intel.com>
References: <20200212145941.32914-1-mika.westerberg@linux.intel.com>
        <20200212145941.32914-3-mika.westerberg@linux.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 12 Feb 2020 17:59:40 +0300, Mika Westerberg wrote:
> ACPI Generic Address Structure (GAS) access_width field is not in bytes
> as the driver seems to expect in few places so fix this by using the
> newly introduced macro ACPI_ACCESS_BYTE_WIDTH().
> 
> Fixes: b1abf6fc4982 ("ACPI / watchdog: Fix off-by-one error at resource assignment")

It does not actually fix that commit, as the bug already existed prior
to it. It has to be applied on top of that commit though because they
touch the same lines, granted.

> Fixes: 058dfc767008 ("ACPI / watchdog: Add support for WDAT hardware watchdog")
> Reported-by: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/acpi/acpi_watchdog.c | 3 +--
>  drivers/watchdog/wdat_wdt.c  | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
> index b5516b04ffc0..d827a4a3e946 100644
> --- a/drivers/acpi/acpi_watchdog.c
> +++ b/drivers/acpi/acpi_watchdog.c
> @@ -126,12 +126,11 @@ void __init acpi_watchdog_init(void)
>  		gas = &entries[i].register_region;
>  
>  		res.start = gas->address;
> +		res.end = res.start + ACPI_ACCESS_BYTE_WIDTH(gas->access_width) - 1;
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
> index b069349b52f5..e1b1fcfc02af 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c
> @@ -389,7 +389,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>  
>  		memset(&r, 0, sizeof(r));
>  		r.start = gas->address;
> -		r.end = r.start + gas->access_width - 1;
> +		r.end = r.start + ACPI_ACCESS_BYTE_WIDTH(gas->access_width) - 1;
>  		if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>  			r.flags = IORESOURCE_MEM;
>  		} else if (gas->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
