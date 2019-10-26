Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0601E5DBC
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Oct 2019 16:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfJZOor (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Oct 2019 10:44:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:31719 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfJZOor (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 26 Oct 2019 10:44:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2019 07:44:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,232,1569308400"; 
   d="scan'208";a="197693167"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 26 Oct 2019 07:44:44 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iONJ6-00077e-1d; Sat, 26 Oct 2019 17:44:44 +0300
Date:   Sat, 26 Oct 2019 17:44:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Erik Schmauss <erik.schmauss@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        Bob Moore <robert.moore@intel.com>
Subject: Re: [PATCH v2 05/12] ACPICA: make acpi_load_table() return table
 index
Message-ID: <20191026144444.GJ32742@smile.fi.intel.com>
References: <20191025213700.14685-1-erik.schmauss@intel.com>
 <20191025213700.14685-6-erik.schmauss@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025213700.14685-6-erik.schmauss@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 25, 2019 at 02:36:53PM -0700, Erik Schmauss wrote:
> From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> 
> ACPICA commit d1716a829d19be23277d9157c575a03b9abb7457
> 
> For unloading an ACPI table, it is necessary to provide the index of
> the table. The method intended for dynamically loading or hotplug
> addition of tables, acpi_load_table(), should provide this information
> via an optional pointer to the loaded table index.
> 
> This patch fixes the table unload function of acpi_configfs.
> 
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Fixes: d06c47e3dd07f ("ACPI: configfs: Resolve objects on host-directed table loads")

So, as far as I understand and Rafael mentioned ACPICA includes only changes
related to itself. It means that for configfs.c we may need a modified patch.
Anyway, I will test this to be sure we have a working base for further
improvements.

> 
> Link: https://github.com/acpica/acpica/commit/d1716a82
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> ---
>  drivers/acpi/acpi_configfs.c   | 2 +-
>  drivers/acpi/acpica/dbfileio.c | 2 +-
>  drivers/acpi/acpica/tbxfload.c | 8 +++++++-
>  drivers/firmware/efi/efi.c     | 2 +-
>  include/acpi/acpixf.h          | 3 ++-
>  5 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
> index 57d9d574d4dd..77f81242a28e 100644
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
> index c6e25734dc5c..e1b6e54a96ac 100644
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
> index ce86e7945e90..0782acf85722 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -268,6 +268,8 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_install_table)
>   *
>   * PARAMETERS:  table               - Pointer to a buffer containing the ACPI
>   *                                    table to be loaded.
> + *              table_idx           - Pointer to a u32 for storing the table
> + *                                    index, might be NULL
>   *
>   * RETURN:      Status
>   *
> @@ -278,7 +280,7 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_install_table)
>   *              to ensure that the table is not deleted or unmapped.
>   *
>   ******************************************************************************/
> -acpi_status acpi_load_table(struct acpi_table_header *table)
> +acpi_status acpi_load_table(struct acpi_table_header *table, u32 *table_idx)
>  {
>  	acpi_status status;
>  	u32 table_index;
> @@ -297,6 +299,10 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
>  	status = acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
>  						ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
>  						FALSE, &table_index);
> +	if (table_idx) {
> +		*table_idx = table_index;
> +	}
> +
>  	if (ACPI_SUCCESS(status)) {
>  
>  		/* Complete the initialization/resolution of new objects */
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 69f00f7453a3..0d65cb21519d 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -296,7 +296,7 @@ static __init int efivar_ssdt_load(void)
>  			goto free_data;
>  		}
>  
> -		ret = acpi_load_table(data);
> +		ret = acpi_load_table(data, NULL);
>  		if (ret) {
>  			pr_err("failed to load table: %d\n", ret);
>  			goto free_data;
> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
> index 109b2f14b6c6..867170049b07 100644
> --- a/include/acpi/acpixf.h
> +++ b/include/acpi/acpixf.h
> @@ -458,7 +458,8 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
>  					       u8 physical))
>  
>  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> -			    acpi_load_table(struct acpi_table_header *table))
> +			    acpi_load_table(struct acpi_table_header *table,
> +					    u32 *table_idx))
>  
>  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>  			    acpi_unload_table(u32 table_index))
> -- 
> 2.21.0
> 

-- 
With Best Regards,
Andy Shevchenko


