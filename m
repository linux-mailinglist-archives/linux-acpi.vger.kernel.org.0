Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F167E7772
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2019 18:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbfJ1RPi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 28 Oct 2019 13:15:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:55572 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730665AbfJ1RPi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Oct 2019 13:15:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 10:15:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,240,1569308400"; 
   d="scan'208";a="211492759"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga002.jf.intel.com with ESMTP; 28 Oct 2019 10:15:37 -0700
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.32]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.200]) with mapi id 14.03.0439.000;
 Mon, 28 Oct 2019 10:15:36 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH v2 05/12] ACPICA: make acpi_load_table() return table
 index
Thread-Topic: [PATCH v2 05/12] ACPICA: make acpi_load_table() return table
 index
Thread-Index: AQHVi37Xu/znG/VfU0m5sGp1b4yodKdtdioAgALYhCA=
Date:   Mon, 28 Oct 2019 17:15:36 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C6648B7@ORSMSX122.amr.corp.intel.com>
References: <20191025213700.14685-1-erik.schmauss@intel.com>
 <20191025213700.14685-6-erik.schmauss@intel.com>
 <20191026144444.GJ32742@smile.fi.intel.com>
In-Reply-To: <20191026144444.GJ32742@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDk5MDJmNzUtOGVjNS00NDAyLWExZTQtODJlMGYwMTkxNDQ4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoickp0blhPalZZZ2Q1ZTRrczY0aGd3TVoydURmTytWUEhGdjhXVE1RZU40NXR3cnVacllKamhmZ241Zlc3OGF3aSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Saturday, October 26, 2019 7:45 AM
> To: Schmauss, Erik <erik.schmauss@intel.com>
> Cc: Rafael J . Wysocki <rafael@kernel.org>; linux-acpi@vger.kernel.org;
> Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>; Moore, Robert
> <robert.moore@intel.com>
> Subject: Re: [PATCH v2 05/12] ACPICA: make acpi_load_table() return table
> index
> 
> On Fri, Oct 25, 2019 at 02:36:53PM -0700, Erik Schmauss wrote:
> > From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> >
> > ACPICA commit d1716a829d19be23277d9157c575a03b9abb7457
> >
> > For unloading an ACPI table, it is necessary to provide the index of
> > the table. The method intended for dynamically loading or hotplug
> > addition of tables, acpi_load_table(), should provide this information
> > via an optional pointer to the loaded table index.
> >
> > This patch fixes the table unload function of acpi_configfs.
> >
> > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Fixes: d06c47e3dd07f ("ACPI: configfs: Resolve objects on
> > host-directed table loads")
> 
> So, as far as I understand and Rafael mentioned ACPICA includes only changes
> related to itself. It means that for configfs.c we may need a modified patch.
> Anyway, I will test this to be sure we have a working base for further
> improvements.

These contain changes from his original patch in configfs.
For simplicity, we just held on to his patch until the ACPICA release.

Let me know if there is anything else that needs to be added to this patch.

Thanks,
Erik
> 
> >
> > Link: https://github.com/acpica/acpica/commit/d1716a82
> > Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> > Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> > Signed-off-by: Bob Moore <robert.moore@intel.com>
> > ---
> >  drivers/acpi/acpi_configfs.c   | 2 +-
> >  drivers/acpi/acpica/dbfileio.c | 2 +-  drivers/acpi/acpica/tbxfload.c
> > | 8 +++++++-
> >  drivers/firmware/efi/efi.c     | 2 +-
> >  include/acpi/acpixf.h          | 3 ++-
> >  5 files changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_configfs.c
> > b/drivers/acpi/acpi_configfs.c index 57d9d574d4dd..77f81242a28e 100644
> > --- a/drivers/acpi/acpi_configfs.c
> > +++ b/drivers/acpi/acpi_configfs.c
> > @@ -53,7 +53,7 @@ static ssize_t acpi_table_aml_write(struct config_item
> *cfg,
> >  	if (!table->header)
> >  		return -ENOMEM;
> >
> > -	ret = acpi_load_table(table->header);
> > +	ret = acpi_load_table(table->header, &table->index);
> >  	if (ret) {
> >  		kfree(table->header);
> >  		table->header = NULL;
> > diff --git a/drivers/acpi/acpica/dbfileio.c
> > b/drivers/acpi/acpica/dbfileio.c index c6e25734dc5c..e1b6e54a96ac
> > 100644
> > --- a/drivers/acpi/acpica/dbfileio.c
> > +++ b/drivers/acpi/acpica/dbfileio.c
> > @@ -93,7 +93,7 @@ acpi_status acpi_db_load_tables(struct
> acpi_new_table_desc *list_head)
> >  	while (table_list_head) {
> >  		table = table_list_head->table;
> >
> > -		status = acpi_load_table(table);
> > +		status = acpi_load_table(table, NULL);
> >  		if (ACPI_FAILURE(status)) {
> >  			if (status == AE_ALREADY_EXISTS) {
> >  				acpi_os_printf
> > diff --git a/drivers/acpi/acpica/tbxfload.c
> > b/drivers/acpi/acpica/tbxfload.c index ce86e7945e90..0782acf85722
> > 100644
> > --- a/drivers/acpi/acpica/tbxfload.c
> > +++ b/drivers/acpi/acpica/tbxfload.c
> > @@ -268,6 +268,8 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_install_table)
> >   *
> >   * PARAMETERS:  table               - Pointer to a buffer containing the ACPI
> >   *                                    table to be loaded.
> > + *              table_idx           - Pointer to a u32 for storing the table
> > + *                                    index, might be NULL
> >   *
> >   * RETURN:      Status
> >   *
> > @@ -278,7 +280,7 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_install_table)
> >   *              to ensure that the table is not deleted or unmapped.
> >   *
> >
> >
> *******************************************************************
> ***
> > ********/ -acpi_status acpi_load_table(struct acpi_table_header
> > *table)
> > +acpi_status acpi_load_table(struct acpi_table_header *table, u32
> > +*table_idx)
> >  {
> >  	acpi_status status;
> >  	u32 table_index;
> > @@ -297,6 +299,10 @@ acpi_status acpi_load_table(struct
> acpi_table_header *table)
> >  	status =
> acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
> >
> 	ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
> >  						FALSE, &table_index);
> > +	if (table_idx) {
> > +		*table_idx = table_index;
> > +	}
> > +
> >  	if (ACPI_SUCCESS(status)) {
> >
> >  		/* Complete the initialization/resolution of new objects */ diff
> > --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c index
> > 69f00f7453a3..0d65cb21519d 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -296,7 +296,7 @@ static __init int efivar_ssdt_load(void)
> >  			goto free_data;
> >  		}
> >
> > -		ret = acpi_load_table(data);
> > +		ret = acpi_load_table(data, NULL);
> >  		if (ret) {
> >  			pr_err("failed to load table: %d\n", ret);
> >  			goto free_data;
> > diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h index
> > 109b2f14b6c6..867170049b07 100644
> > --- a/include/acpi/acpixf.h
> > +++ b/include/acpi/acpixf.h
> > @@ -458,7 +458,8 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> ACPI_INIT_FUNCTION
> >  					       u8 physical))
> >
> >  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> > -			    acpi_load_table(struct acpi_table_header *table))
> > +			    acpi_load_table(struct acpi_table_header *table,
> > +					    u32 *table_idx))
> >
> >  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> >  			    acpi_unload_table(u32 table_index))
> > --
> > 2.21.0
> >
> 
> --
> With Best Regards,
> Andy Shevchenko
> 

