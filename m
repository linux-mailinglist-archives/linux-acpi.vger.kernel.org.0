Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF4E66CB19
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jul 2019 10:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfGRInK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Jul 2019 04:43:10 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58640 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfGRInJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jul 2019 04:43:09 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 9a5cff5b74e7777b; Thu, 18 Jul 2019 10:43:07 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Erik Schmauss <erik.schmauss@intel.com>
Cc:     linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
Subject: Re: [PATCH v2 1/2] ACPICA: Update table load object initialization
Date:   Thu, 18 Jul 2019 10:43:07 +0200
Message-ID: <2383721.89ovj2a0fz@kreacher>
In-Reply-To: <20190711165821.16372-1-erik.schmauss@intel.com>
References: <20190711165821.16372-1-erik.schmauss@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, July 11, 2019 6:58:21 PM CEST Erik Schmauss wrote:
> ACPICA commit c7ef9f3526765bed8930825dda1eed1a274b9668
> 
> Use the common internal "initialize objects" interface
> Affects:
> Load()
> load_table()
> acpi_load_table
> 
> Link: https://github.com/acpica/acpica/commit/c7ef9f35
> 
> Tested-by: Rong Chen <rong.a.chen@intel.com>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> ---
>  drivers/acpi/acpica/exconfig.c | 18 ++++++++----------
>  drivers/acpi/acpica/tbxfload.c | 10 +++-------
>  2 files changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
> index 587aeeeb5070..46a8baf28bd0 100644
> --- a/drivers/acpi/acpica/exconfig.c
> +++ b/drivers/acpi/acpica/exconfig.c
> @@ -174,12 +174,11 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
>  		return_ACPI_STATUS(status);
>  	}
>  
> -	/* Complete the initialization/resolution of package objects */
> +	/* Complete the initialization/resolution of new objects */
>  
> -	status = acpi_ns_walk_namespace(ACPI_TYPE_PACKAGE, ACPI_ROOT_OBJECT,
> -					ACPI_UINT32_MAX, 0,
> -					acpi_ns_init_one_package, NULL, NULL,
> -					NULL);
> +	acpi_ex_exit_interpreter();
> +	acpi_ns_initialize_objects();
> +	acpi_ex_enter_interpreter();
>  
>  	/* Parameter Data (optional) */
>  
> @@ -437,12 +436,11 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
>  		return_ACPI_STATUS(status);
>  	}
>  
> -	/* Complete the initialization/resolution of package objects */
> +	/* Complete the initialization/resolution of new objects */
>  
> -	status = acpi_ns_walk_namespace(ACPI_TYPE_PACKAGE, ACPI_ROOT_OBJECT,
> -					ACPI_UINT32_MAX, 0,
> -					acpi_ns_init_one_package, NULL, NULL,
> -					NULL);
> +	acpi_ex_exit_interpreter();
> +	acpi_ns_initialize_objects();
> +	acpi_ex_enter_interpreter();
>  
>  	/* Store the ddb_handle into the Target operand */
>  
> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
> index ef8f8a9f3c9c..86f1693f6d29 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -297,15 +297,11 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
>  	status = acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
>  						ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
>  						FALSE, &table_index);
> -
>  	if (ACPI_SUCCESS(status)) {
> -		/* Complete the initialization/resolution of package objects */
>  
> -		status = acpi_ns_walk_namespace(ACPI_TYPE_PACKAGE,
> -						ACPI_ROOT_OBJECT,
> -						ACPI_UINT32_MAX, 0,
> -						acpi_ns_init_one_package,
> -						NULL, NULL, NULL);
> +		/* Complete the initialization/resolution of new objects */
> +
> +		acpi_ns_initialize_objects();
>  	}
>  
>  	return_ACPI_STATUS(status);
> 

Applied, thanks!




