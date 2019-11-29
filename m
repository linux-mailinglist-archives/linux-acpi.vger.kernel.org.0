Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D6510D4C0
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Nov 2019 12:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfK2LZV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Nov 2019 06:25:21 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54861 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2LZV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Nov 2019 06:25:21 -0500
Received: from 79.184.255.242.ipv4.supernova.orange.pl (79.184.255.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 8704bd7f7b9eea39; Fri, 29 Nov 2019 12:25:18 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] acpi: fix for memory leak in i2c_acpi_install_space_handler
Date:   Fri, 29 Nov 2019 12:25:18 +0100
Message-ID: <1919238.VxGNAZmCyg@kreacher>
In-Reply-To: <20191128102825.GA1774@cosmos>
References: <20191128102825.GA1774@cosmos>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, November 28, 2019 11:28:29 AM CET Vamshi K Sthambamkadi wrote:
> kmemleak reported backtrace:
>     [<bbee0454>] kmem_cache_alloc_trace+0x128/0x260
>     [<6677f215>] i2c_acpi_install_space_handler+0x4b/0xe0
>     [<1180f4fc>] i2c_register_adapter+0x186/0x400
>     [<6083baf7>] i2c_add_adapter+0x4e/0x70
>     [<a3ddf966>] intel_gmbus_setup+0x1a2/0x2c0 [i915]
>     [<84cb69ae>] i915_driver_probe+0x8d8/0x13a0 [i915]
>     [<81911d4b>] i915_pci_probe+0x48/0x160 [i915]
>     [<4b159af1>] pci_device_probe+0xdc/0x160
>     [<b3c64704>] really_probe+0x1ee/0x450
>     [<bc029f5a>] driver_probe_device+0x142/0x1b0
>     [<d8829d20>] device_driver_attach+0x49/0x50
>     [<de71f045>] __driver_attach+0xc9/0x150
>     [<df33ac83>] bus_for_each_dev+0x56/0xa0
>     [<80089bba>] driver_attach+0x19/0x20
>     [<cc73f583>] bus_add_driver+0x177/0x220
>     [<7b29d8c7>] driver_register+0x56/0xf0
> In i2c_acpi_remove_space_handler function, leak occurs whenever "data"
> parameter is initialized to 0 in call to acpi_bus_get_private_data().
> This is because the parameter validity check in acpi_bus_get_private_data
> (condition->if(!*data)) returns EINVAL and as a consequence, memory is
> never freed in i2c_acpi_remove_space_handler function. Fix/Correct the
> parameter validity check in acpi_bus_get_private_data() as that of
> similarly done in acpi_get_data_full().
> 
> Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
> ---
>  drivers/acpi/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 48bc96d..5400267 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -153,7 +153,7 @@ int acpi_bus_get_private_data(acpi_handle handle, void **data)
>  {
>  	acpi_status status;
>  
> -	if (!*data)
> +	if (!data)
>  		return -EINVAL;
>  
>  	status = acpi_get_data(handle, acpi_bus_private_data_handler, data);
> 

Applying as a stable-candidate fix for 5.5 with rewritten subject and changelog.

Thanks!




