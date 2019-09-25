Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E914BDC15
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2019 12:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfIYKWX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Sep 2019 06:22:23 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:41174 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbfIYKWX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Sep 2019 06:22:23 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 8983C4D436; Wed, 25 Sep 2019 12:22:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 856FE4D253;
        Wed, 25 Sep 2019 12:22:21 +0200 (CEST)
Date:   Wed, 25 Sep 2019 12:22:21 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Moore, Robert" <robert.moore@intel.com>,
        Len Brown <lenb@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPICA: Introduce acpi_load_table_with_index()
In-Reply-To: <20190924151146.GW2680@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.20.1909251221570.582@fox.voss.local>
References: <6851700.HULMXZj6Ep@kreacher> <20190923094701.24950-1-nikolaus.voss@loewensteinmedical.de> <20190924151146.GW2680@smile.fi.intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 24 Sep 2019, Andy Shevchenko wrote:
> On Mon, Sep 23, 2019 at 11:47:01AM +0200, Nikolaus Voss wrote:
>> For unloading an ACPI table, it is necessary to provide the
>> index of the table. The method intended for dynamically
>> loading or hotplug addition of tables, acpi_load_table(),
>> does not provide this information, so a new function
>> acpi_load_table_with_index() with the same functionality,
>> but an optional pointer to the loaded table index is introduced.
>>
>> The new function is used in the acpi_configfs driver to save the
>> index of the newly loaded table in order to unload it later.
>>
>
> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

>
> But consider addressing my comments in one of previous mails.
>
>> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Fixes: d06c47e3dd07f ("ACPI: configfs: Resolve objects on host-directed table loads")
>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>> ---
>>  drivers/acpi/acpi_configfs.c   |  2 +-
>>  drivers/acpi/acpica/tbxfload.c | 43 ++++++++++++++++++++++++++++++++++
>>  include/acpi/acpixf.h          |  6 +++++
>>  3 files changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
>> index 57d9d574d4dd..9e77d5a266c0 100644
>> --- a/drivers/acpi/acpi_configfs.c
>> +++ b/drivers/acpi/acpi_configfs.c
>> @@ -53,7 +53,7 @@ static ssize_t acpi_table_aml_write(struct config_item *cfg,
>>  	if (!table->header)
>>  		return -ENOMEM;
>>
>> -	ret = acpi_load_table(table->header);
>> +	ret = acpi_load_table_with_index(table->header, &table->index);
>>  	if (ret) {
>>  		kfree(table->header);
>>  		table->header = NULL;
>> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
>> index 86f1693f6d29..7ea4fc879cb6 100644
>> --- a/drivers/acpi/acpica/tbxfload.c
>> +++ b/drivers/acpi/acpica/tbxfload.c
>> @@ -309,6 +309,49 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
>>
>>  ACPI_EXPORT_SYMBOL(acpi_load_table)
>>
>> +/*******************************************************************************
>> + *
>> + * FUNCTION:    acpi_load_table_with_index
>> + *
>> + * PARAMETERS:  table               - Pointer to a buffer containing the ACPI
>> + *                                    table to be loaded.
>> + *              table_idx           - Pointer to a u32 for storing the table
>> + *                                    index, might be NULL
>> + * RETURN:      Status
>> + *
>> + * DESCRIPTION: see acpi_load_table() above. Additionally returns the index
>> + *              of the newly created table in table_idx.
>> + *
>> + ******************************************************************************/
>> +acpi_status acpi_load_table_with_index(struct acpi_table_header *table,
>> +				       u32 *table_idx)
>> +{
>> +	acpi_status status;
>> +	u32 table_index;
>> +
>> +	ACPI_FUNCTION_TRACE(acpi_load_table_with_index);
>> +
>> +	/* Parameter validation */
>> +	if (!table)
>> +		return_ACPI_STATUS(AE_BAD_PARAMETER);
>> +
>> +	/* Install the table and load it into the namespace */
>> +	ACPI_INFO(("Host-directed Dynamic ACPI Table Load:"));
>> +	status = acpi_tb_install_and_load_table(
>> +		ACPI_PTR_TO_PHYSADDR(table), ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
>> +		FALSE, &table_index);
>> +	if (table_idx)
>> +		*table_idx = table_index;
>> +
>> +	if (ACPI_SUCCESS(status)) {
>> +		/* Complete the initialization/resolution of new objects */
>> +		acpi_ns_initialize_objects();
>> +	}
>> +
>> +	return_ACPI_STATUS(status);
>> +}
>> +ACPI_EXPORT_SYMBOL(acpi_load_table_with_index)
>> +
>>  /*******************************************************************************
>>   *
>>   * FUNCTION:    acpi_unload_parent_table
>> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
>> index e5e041413581..af375ab318de 100644
>> --- a/include/acpi/acpixf.h
>> +++ b/include/acpi/acpixf.h
>> @@ -460,6 +460,12 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
>>  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>>  			    acpi_load_table(struct acpi_table_header *table))
>>
>> +
>> +ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>> +			    acpi_load_table_with_index(
>> +				    struct acpi_table_header *table,
>> +				    u32 *table_idx))
>> +
>>  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>>  			    acpi_unload_parent_table(acpi_handle object))
>>
>> --
>> 2.17.1
>>
>

