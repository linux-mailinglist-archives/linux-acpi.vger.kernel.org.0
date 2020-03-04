Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D178178F0B
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2020 11:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387751AbgCDK6u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Mar 2020 05:58:50 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56938 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbgCDK6u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2020 05:58:50 -0500
Received: from 79.184.237.41.ipv4.supernova.orange.pl (79.184.237.41) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 99f413d6ffa49f2f; Wed, 4 Mar 2020 11:58:47 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] ACPI / AC: Cleanup DMI quirk table
Date:   Wed, 04 Mar 2020 11:58:47 +0100
Message-ID: <12572528.8LIzrmqC6W@kreacher>
In-Reply-To: <20200223142941.60705-2-hdegoede@redhat.com>
References: <20200223142941.60705-1-hdegoede@redhat.com> <20200223142941.60705-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sunday, February 23, 2020 3:29:40 PM CET Hans de Goede wrote:
> The 3 different entries we have sofar all use different identation and
> 2 of the use DMI_MATCH where as 1 unnecessarily used DMI_EXACT_MATCH
> Fix this to just use full tab idents for each level and DMI_MATCH
> everywhere and sort the entries alphabetically.
> 
> Also add a bit of text to the comments explaining why the quirk is
> necessary.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/ac.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 829f37d36b9f..69d2db13886b 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -293,29 +293,30 @@ static int __init ac_do_not_check_pmic_quirk(const struct dmi_system_id *d)
>  	return 0;
>  }
>  
> +/* Please keep this list alphabetically sorted */
>  static const struct dmi_system_id ac_dmi_table[]  __initconst = {
>  	{
> -	/* Thinkpad e530 */
> -	.callback = thinkpad_e530_quirk,
> -	.matches = {
> -		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -		DMI_MATCH(DMI_PRODUCT_NAME, "32597CG"),
> +		/* ECS EF20EA, AXP288 PMIC but uses separate fuel-gauge */
> +		.callback = ac_do_not_check_pmic_quirk,
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
>  		},
>  	},
>  	{
> -		/* ECS EF20EA */
> +		/* Lenovo Ideapad Miix 320, AXP288 PMIC, separate fuel-gauge */
>  		.callback = ac_do_not_check_pmic_quirk,
>  		.matches = {
> -			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "80XF"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
>  		},
>  	},
>  	{
> -		/* Lenovo Ideapad Miix 320 */
> -		.callback = ac_do_not_check_pmic_quirk,
> +		/* Lenovo Thinkpad e530, see comment in acpi_ac_notify() */
> +		.callback = thinkpad_e530_quirk,
>  		.matches = {
> -		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "80XF"),
> -		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "32597CG"),
>  		},
>  	},
>  	{},
> 

Both patches in the series applied as 5.7 material, thanks!




