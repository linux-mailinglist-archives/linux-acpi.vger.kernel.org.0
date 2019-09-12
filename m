Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA54B14F3
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2019 21:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfILTxE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Sep 2019 15:53:04 -0400
Received: from mailfilter03-out40.webhostingserver.nl ([195.211.72.99]:55573
        "EHLO mailfilter03-out40.webhostingserver.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbfILTxD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Sep 2019 15:53:03 -0400
X-Halon-ID: a1826e13-d594-11e9-ba6d-001a4a4cb9a5
Received: from s198.webhostingserver.nl (unknown [195.211.72.171])
        by mailfilter03.webhostingserver.nl (Halon) with ESMTPSA
        id a1826e13-d594-11e9-ba6d-001a4a4cb9a5;
        Thu, 12 Sep 2019 19:36:35 +0000 (UTC)
Received: from cust-178-250-146-69.breedbanddelft.nl ([178.250.146.69] helo=[10.8.0.10])
        by s198.webhostingserver.nl with esmtpa (Exim 4.92.2)
        (envelope-from <ftoth@telfort.nl>)
        id 1i8Utk-00F8TM-4J; Thu, 12 Sep 2019 21:36:56 +0200
Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table index
To:     "Moore, Robert" <robert.moore@intel.com>,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nv@vosn.de" <nv@vosn.de>
Newsgroups: gmane.linux.kernel,gmane.linux.acpi.devel
References: <20190906174605.GY2680@smile.fi.intel.com>
 <20190912080742.24642-1-nikolaus.voss@loewensteinmedical.de>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B9679CE8@ORSMSX110.amr.corp.intel.com>
From:   Ferry Toth <ftoth@telfort.nl>
Message-ID: <4929b1d2-c2a7-4efd-89e4-f02205e79c01@telfort.nl>
Date:   Thu, 12 Sep 2019 21:36:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B9679CE8@ORSMSX110.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SendingUser: hidden
X-SendingServer: hidden
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: hidden
X-SendingUser: hidden
X-SendingServer: hidden
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Op 12-09-19 om 16:19 schreef Moore, Robert:
> Nikolaus,
> The ability to unload an ACPI table (especially AML tables such as SSDTs) is in the process of being deprecated in ACPICA -- since it is also deprecated in the current ACPI specification. This is being done because of the difficulty of deleting the namespace entries for the table.  FYI, Windows does not properly support this function either.

I really hope this is not the case. On x86 loading/unloading SSDTs has 
proven to be a powerful way to handle reconfigurable hardware without 
rebooting and without requiring dedicated platform drivers. Same for 
user plugable hardware on i2c/spi busses.

This has worked before and will violate the "don't break user space" rule.

I don't see why Windows is an example to follow. On Windows platform 
drivers don't get compiled into the kernel and don't need to be upstreamed.

> Bob
> 
> 
> -----Original Message-----
> From: Nikolaus Voss [mailto:nikolaus.voss@loewensteinmedical.de]
> Sent: Thursday, September 12, 2019 1:08 AM
> To: Shevchenko, Andriy <andriy.shevchenko@intel.com>; Schmauss, Erik <erik.schmauss@intel.com>; Rafael J. Wysocki <rjw@rjwysocki.net>; Moore, Robert <robert.moore@intel.com>
> Cc: Len Brown <lenb@kernel.org>; Jacek Anaszewski <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan Murphy <dmurphy@ti.com>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org; nv@vosn.de; Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> Subject: [PATCH] ACPICA: make acpi_load_table() return table index
> 
> For unloading an ACPI table, it is necessary to provide the index of the table. The method intended for dynamically loading or hotplug addition of tables, acpi_load_table(), should provide this information via an optional pointer to the loaded table index.
> 
> This patch fixes the table unload function of acpi_configfs.
> 
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Fixes: d06c47e3dd07f ("ACPI: configfs: Resolve objects on host-directed table loads")
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> ---
>   drivers/acpi/acpi_configfs.c   | 2 +-
>   drivers/acpi/acpica/dbfileio.c | 2 +-
>   drivers/acpi/acpica/tbxfload.c | 8 ++++++--
>   drivers/firmware/efi/efi.c     | 2 +-
>   include/acpi/acpixf.h          | 3 ++-
>   5 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c index 57d9d574d4dde..77f81242a28e6 100644
> --- a/drivers/acpi/acpi_configfs.c
> +++ b/drivers/acpi/acpi_configfs.c
> @@ -53,7 +53,7 @@ static ssize_t acpi_table_aml_write(struct config_item *cfg,
>   	if (!table->header)
>   		return -ENOMEM;
>   
> -	ret = acpi_load_table(table->header);
> +	ret = acpi_load_table(table->header, &table->index);
>   	if (ret) {
>   		kfree(table->header);
>   		table->header = NULL;
> diff --git a/drivers/acpi/acpica/dbfileio.c b/drivers/acpi/acpica/dbfileio.c index c6e25734dc5cd..e1b6e54a96ac1 100644
> --- a/drivers/acpi/acpica/dbfileio.c
> +++ b/drivers/acpi/acpica/dbfileio.c
> @@ -93,7 +93,7 @@ acpi_status acpi_db_load_tables(struct acpi_new_table_desc *list_head)
>   	while (table_list_head) {
>   		table = table_list_head->table;
>   
> -		status = acpi_load_table(table);
> +		status = acpi_load_table(table, NULL);
>   		if (ACPI_FAILURE(status)) {
>   			if (status == AE_ALREADY_EXISTS) {
>   				acpi_os_printf
> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c index 86f1693f6d29a..d08cd8ffcbdb6 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -268,7 +268,8 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_install_table)
>    *
>    * PARAMETERS:  table               - Pointer to a buffer containing the ACPI
>    *                                    table to be loaded.
> - *
> + *              table_idx           - Pointer to a u32 for storing the table
> + *                                    index, might be NULL
>    * RETURN:      Status
>    *
>    * DESCRIPTION: Dynamically load an ACPI table from the caller's buffer. Must @@ -278,7 +279,7 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_install_table)
>    *              to ensure that the table is not deleted or unmapped.
>    *
>    ******************************************************************************/
> -acpi_status acpi_load_table(struct acpi_table_header *table)
> +acpi_status acpi_load_table(struct acpi_table_header *table, u32
> +*table_idx)
>   {
>   	acpi_status status;
>   	u32 table_index;
> @@ -297,6 +298,9 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
>   	status = acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
>   						ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
>   						FALSE, &table_index);
> +	if (table_idx)
> +		*table_idx = table_index;
> +
>   	if (ACPI_SUCCESS(status)) {
>   
>   		/* Complete the initialization/resolution of new objects */ diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c index ad3b1f4866b35..9773e4212baef 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -308,7 +308,7 @@ static __init int efivar_ssdt_load(void)
>   			goto free_data;
>   		}
>   
> -		ret = acpi_load_table(data);
> +		ret = acpi_load_table(data, NULL);
>   		if (ret) {
>   			pr_err("failed to load table: %d\n", ret);
>   			goto free_data;
> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h index 3845c8fcc94e5..c90bbdc4146a6 100644
> --- a/include/acpi/acpixf.h
> +++ b/include/acpi/acpixf.h
> @@ -452,7 +452,8 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
>   					       u8 physical))
>   
>   ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> -			    acpi_load_table(struct acpi_table_header *table))
> +			    acpi_load_table(struct acpi_table_header *table,
> +					    u32 *table_idx))
>   
>   ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>   			    acpi_unload_parent_table(acpi_handle object))
> --
> 2.17.1
> 
> 

