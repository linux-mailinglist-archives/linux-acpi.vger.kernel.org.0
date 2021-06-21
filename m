Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5723AE14B
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jun 2021 03:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhFUBb1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 20 Jun 2021 21:31:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:44228 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229877AbhFUBbZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 20 Jun 2021 21:31:25 -0400
IronPort-SDR: YPHi+TsPHXTOLDarpVfelCBlHBPcVKmqyNyVH+0nawn+wifeXkuDz5pTAhi3kcsY7V0OWNcBRM
 5H8PfFMqGKBg==
X-IronPort-AV: E=McAfee;i="6200,9189,10021"; a="206800620"
X-IronPort-AV: E=Sophos;i="5.83,288,1616482800"; 
   d="scan'208";a="206800620"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2021 18:29:11 -0700
IronPort-SDR: lG3JhbFZtKVv0/tq1ClgxSQQDiYj8MW13qLRXk8ZLzFa5sN9Vl1he4W8PDCfhfb8X9yNi1ds8F
 vep2WymJAeLg==
X-IronPort-AV: E=Sophos;i="5.83,288,1616482800"; 
   d="scan'208";a="486313985"
Received: from jbao6-mobl2.ccr.corp.intel.com ([10.255.29.201])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2021 18:29:10 -0700
Message-ID: <c6483e1f1745c10b3ea0090ad29056911f0a528e.camel@intel.com>
Subject: Re: [PATCH] ACPI: EC: trust DSDT GPE for certain HP laptop
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rjw@rjwysocki.net, leo881003@gmail.com
Date:   Mon, 21 Jun 2021 09:29:08 +0800
In-Reply-To: <20210621012806.30300-1-rui.zhang@intel.com>
References: <20210621012806.30300-1-rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Sorry that this patch is based on top of some local changes and can not
be applied cleanly to latest upstream git.
Patch rebased on top of v5.13-rc7 and resent.

thanks,
rui

On Mon, 2021-06-21 at 09:28 +0800, Zhang Rui wrote:
> On HP Pavilion Gaming Laptop 15-cx0xxx, the ECDT EC and DSDT EC share
> the same port addresses but different GPEs. And the DSDT GPE is the
> right one to use.
> 
> The current code duplicates DSDT EC with ECDT EC if the port
> addresses
> are the same, and uses ECDT GPE as a result, which breaks this
> machine.
> 
> Introduce a new quirk for the HP laptop to trust the DSDT GPE,
> and avoid duplicating even if the port addresses are the same.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=209989
> Reported-and-tested-by: Shao Fu, Chen <leo881003@gmail.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/ec.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 9555c65f2f94..8d8abd0c6cfb 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -183,6 +183,7 @@ static struct workqueue_struct *ec_query_wq;
>  
>  static int EC_FLAGS_CORRECT_ECDT; /* Needs ECDT port address
> correction */
>  static int EC_FLAGS_IGNORE_DSDT_GPE; /* Needs ECDT GPE as correction
> setting */
> +static int EC_FLAGS_TRUST_DSDT_GPE; /* Needs DSDT GPE as correction
> setting */
>  static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi_ec_clear() on
> boot/resume */
>  static int EC_FLAGS_FORCE_EC_REG; /* Needs EC _REG evaluated
> explicitly */
>  
> @@ -1601,7 +1602,8 @@ static int acpi_ec_add(struct acpi_device
> *device)
>  		}
>  
>  		if (boot_ec && ec->command_addr == boot_ec-
> >command_addr &&
> -		    ec->data_addr == boot_ec->data_addr) {
> +		    ec->data_addr == boot_ec->data_addr &&
> +		    !EC_FLAGS_TRUST_DSDT_GPE) {
>  			/*
>  			 * Trust PNP0C09 namespace location rather than
>  			 * ECDT ID. But trust ECDT GPE rather than _GPE
> @@ -1836,6 +1838,18 @@ static int ec_honor_ecdt_gpe(const struct
> dmi_system_id *id)
>  	return 0;
>  }
>  
> +/*
> + * Some ECDTs contain wrong GPE setting, but they share the same
> port addresses
> + * with DSDT EC, don't duplicate the DSDT EC with ECDT EC in this
> case.
> + * https://bugzilla.kernel.org/show_bug.cgi?id=209989
> + */
> +static int ec_honor_dsdt_gpe(const struct dmi_system_id *id)
> +{
> +	pr_debug("Detected system needing DSDT GPE setting.\n");
> +	EC_FLAGS_TRUST_DSDT_GPE = 1;
> +	return 0;
> +}
> +
>  /*
>   * Some buggy BIOS does not have EC OperationRegion, this results in
> the
>   * EC._REG fails to be evaluated when installing the EC address
> space handler.
> @@ -1876,6 +1890,11 @@ static const struct dmi_system_id
> ec_dmi_table[] __initconst = {
>  	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>  	DMI_MATCH(DMI_PRODUCT_NAME, "X580VD"),}, NULL},
>  	{
> +	/* https://bugzilla.kernel.org/show_bug.cgi?id=209989 */
> +	ec_honor_dsdt_gpe, "HP Pavilion Gaming Laptop 15-cx0xxx", {
> +	DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +	DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming Laptop 15-
> cx0xxx"),}, NULL},
> +	{
>  	ec_clear_on_resume, "Samsung hardware", {
>  	DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD.")},
> NULL},
>  	{

