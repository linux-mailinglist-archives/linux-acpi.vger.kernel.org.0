Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D765B74D2
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Sep 2019 10:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfISINz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Sep 2019 04:13:55 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62598 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfISINz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Sep 2019 04:13:55 -0400
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 0ed5324655183c06; Thu, 19 Sep 2019 10:13:52 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        Len Brown <lenb@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, nv@vosn.de
Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table index
Date:   Thu, 19 Sep 2019 10:13:52 +0200
Message-ID: <6851700.HULMXZj6Ep@kreacher>
In-Reply-To: <20190912080742.24642-1-nikolaus.voss@loewensteinmedical.de>
References: <20190906174605.GY2680@smile.fi.intel.com> <20190912080742.24642-1-nikolaus.voss@loewensteinmedical.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, September 12, 2019 10:07:42 AM CEST Nikolaus Voss wrote:
> For unloading an ACPI table, it is necessary to provide the
> index of the table. The method intended for dynamically
> loading or hotplug addition of tables, acpi_load_table(),
> should provide this information via an optional pointer
> to the loaded table index.
> 
> This patch fixes the table unload function of acpi_configfs.
> 
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Fixes: d06c47e3dd07f ("ACPI: configfs: Resolve objects on host-directed table loads")
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>

Overall, I think that something similar to this patch will be needed, but
please don't change the acpi_load_table() signature.  Instead, define it as
a wrapper around a new function called, say, acpi_load_table_with_index()
that will take two arguments, like acpi_load_table() in your patch.

Then, you'd only need to call acpi_load_table_with_index() directly from
acpi_table_aml_write().

In that case, IMO, it will be easier to handle the divergence between the
upstream ACPICA and the kernel in the future in case the upstream doesn't
decide to incorporate your change.

> ---
>  drivers/acpi/acpi_configfs.c   | 2 +-
>  drivers/acpi/acpica/dbfileio.c | 2 +-
>  drivers/acpi/acpica/tbxfload.c | 8 ++++++--
>  drivers/firmware/efi/efi.c     | 2 +-
>  include/acpi/acpixf.h          | 3 ++-
>  5 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
> index 57d9d574d4dde..77f81242a28e6 100644
> --- a/drivers/acpi/acpi_configfs.c
> +++ b/drivers/acpi/acpi_configfs.c
> @@ -53,7 +53,7 @@ static ssize_t acpi_table_aml_write(struct config_item *cfg,
>  	if (!table->header)
>  		return -ENOMEM;
>  
> -	ret = acpi_load_table(table->header);
> +	ret = acpi_load_table(table->header, &table->index);
>  	if (ret) {
>  		kfree(table->header);
>  		table->header = NULL;
> diff --git a/drivers/acpi/acpica/dbfileio.c b/drivers/acpi/acpica/dbfileio.c
> index c6e25734dc5cd..e1b6e54a96ac1 100644
> --- a/drivers/acpi/acpica/dbfileio.c
> +++ b/drivers/acpi/acpica/dbfileio.c
> @@ -93,7 +93,7 @@ acpi_status acpi_db_load_tables(struct acpi_new_table_desc *list_head)
>  	while (table_list_head) {
>  		table = table_list_head->table;
>  
> -		status = acpi_load_table(table);
> +		status = acpi_load_table(table, NULL);
>  		if (ACPI_FAILURE(status)) {
>  			if (status == AE_ALREADY_EXISTS) {
>  				acpi_os_printf
> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
> index 86f1693f6d29a..d08cd8ffcbdb6 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -268,7 +268,8 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_install_table)
>   *
>   * PARAMETERS:  table               - Pointer to a buffer containing the ACPI
>   *                                    table to be loaded.
> - *
> + *              table_idx           - Pointer to a u32 for storing the table
> + *                                    index, might be NULL
>   * RETURN:      Status
>   *
>   * DESCRIPTION: Dynamically load an ACPI table from the caller's buffer. Must
> @@ -278,7 +279,7 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_install_table)
>   *              to ensure that the table is not deleted or unmapped.
>   *
>   ******************************************************************************/
> -acpi_status acpi_load_table(struct acpi_table_header *table)
> +acpi_status acpi_load_table(struct acpi_table_header *table, u32 *table_idx)
>  {
>  	acpi_status status;
>  	u32 table_index;
> @@ -297,6 +298,9 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
>  	status = acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
>  						ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
>  						FALSE, &table_index);
> +	if (table_idx)
> +		*table_idx = table_index;
> +
>  	if (ACPI_SUCCESS(status)) {
>  
>  		/* Complete the initialization/resolution of new objects */
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index ad3b1f4866b35..9773e4212baef 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -308,7 +308,7 @@ static __init int efivar_ssdt_load(void)
>  			goto free_data;
>  		}
>  
> -		ret = acpi_load_table(data);
> +		ret = acpi_load_table(data, NULL);
>  		if (ret) {
>  			pr_err("failed to load table: %d\n", ret);
>  			goto free_data;
> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
> index 3845c8fcc94e5..c90bbdc4146a6 100644
> --- a/include/acpi/acpixf.h
> +++ b/include/acpi/acpixf.h
> @@ -452,7 +452,8 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
>  					       u8 physical))
>  
>  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> -			    acpi_load_table(struct acpi_table_header *table))
> +			    acpi_load_table(struct acpi_table_header *table,
> +					    u32 *table_idx))
>  
>  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>  			    acpi_unload_parent_table(acpi_handle object))
> 




