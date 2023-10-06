Return-Path: <linux-acpi+bounces-471-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95427BBA69
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0782F1C202E8
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 14:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616F126E01
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=augustwikerfors.se header.i=@augustwikerfors.se header.b="CUiiRAET";
	dkim=pass (2048-bit key) header.d=arn1.rp.oracleemaildelivery.com header.i=@arn1.rp.oracleemaildelivery.com header.b="Z1Gn40R+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21201F601
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 14:23:21 +0000 (UTC)
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Oct 2023 07:23:18 PDT
Received: from abi149hd125.arn1.oracleemaildelivery.com (abi149hd125.arn1.oracleemaildelivery.com [129.149.84.125])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD835C5
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 07:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=aVEtphrFM7XGVmNaoicY2hacQNy6vbztvG/piAN/eGw=;
 b=CUiiRAETlJPa6eghm+trc2N6kjHcKsYbqFnQ1TMz41tjRWkscPELdRUiAgPOemA78Yo16my0XTVl
   gvaL6mPCBcx8IBg4MGebsyaCE/AQnG7KB9gSdUsNeOeJ+yMX0O4QpYw+a8HcCH35bRWJyDMtStA5
   BgBSA+v2mByCKUREYi6sUJhosKaISb5kivgs7U6perWpRrsUX0drrBLyBlGRT6akb8o+3vmJe5u2
   BK4QOWr21fD/9c3XQopuWICXeJlCJVEH0NwfmBH9PPLTqLFLqrmuDFn2tVEASbdiX4PzsWORG6BW
   r8OxF+fM/ZQhdHT8i4cyYK0aFIQaAfCC5JHIJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=aVEtphrFM7XGVmNaoicY2hacQNy6vbztvG/piAN/eGw=;
 b=Z1Gn40R+rkVvU2K3GiBVBk7kPxEQjtjWN1XPDLZf4jcwIYG5xllutOHs0QnuacIP8shDXXgAaK7B
   KPH4IlnFHITJIx+BTjbOFIAk55mM6i2rERRVsPytH6hZpxnO6+Qs2p0FAEz+R2bBAMZKm/H1AedB
   zxthRtZHiNGYwhsN+3Wzs7dXkNvoInYDpkCeLyUwA9/XmFW7IlqErW+oMzOgPZ6P1ShFYO/RxD6G
   nnac6boB2OcWp9VRcCHDsVTFzjUW0v1m2Iy3+X6rQQF7MRzTx/deSrYTNfS/RDKcTSXIACRkg0UF
   6jrFt/Mwp+AytDl0SvE7aAqvK+q5TrpLbwBZ5w==
Received: by omta-ad1-fd1-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230928 64bit (built Sep 28
 2023))
 with ESMTPS id <0S240022F2ED3320@omta-ad1-fd1-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-acpi@vger.kernel.org; Fri, 06 Oct 2023 14:18:13 +0000 (GMT)
Message-id: <ed4672a7-439c-4240-aadc-7a36858c36b2@augustwikerfors.se>
Date: Fri, 6 Oct 2023 16:18:10 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Subject: Re: [PATCH v2] ACPI: resource: Add TongFang GM6BGEQ,
 GM6BG5Q and GM6BG0Q to irq1_edge_low_force_override[]
Content-language: en-US
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Mario Limonciello <Mario.Limonciello@amd.com>, linux-acpi@vger.kernel.org,
 Francesco <f.littarru@outlook.com>, regressions@lists.linux.dev
References: <20231006123304.32686-1-hdegoede@redhat.com>
From: August Wikerfors <git@augustwikerfors.se>
In-reply-to: <20231006123304.32686-1-hdegoede@redhat.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta:
 AAFxb8QDQo2eFSySz8ItSVTo02kHbz5wF0F7TtCY0dvk7+D7xoQx6o/1MyX7HeB4
 DPJJd2a9Zx4qxX+O+GoXHKLRwEi4r8QlpeZ6DR4Mviu54lslrM/AO8zbeV2Nn1/p
 ZcA4CrpBw1C7+RxuZUIdycDyU6suZZTUR5DsfAuCeW6eXIrCZxfKA4VlzxYg7Wbd
 j+VMuPeFhMV+1yyTdAbvhVnNAlxWXQr4d5T/ozILCUPMoc31qoqNgTuWbliR75yO
 01wxsN8ERfqP/08Amb/QD6g9O23MBuDFGVCvz1zSECw5K5zHiB1uZI9v1318C0C3
 m2PQaTKpmDfv9/eA0Wqe9paoa6C0WafMvEpgLTwj/HSuED/UcwCTVHkjCa+Q2ikY
 Y1kP6m3hTJxXsn0DSW5yzJ32HGhjqAsIUAr/qeX/km5eGYDDwRmc9aDx85WI8TG9 CwxiPSk=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Hans,

On 2023-10-06 14:33, Hans de Goede wrote:
> The TongFang GM6BGEQ, GM6BG5Q and GM6BG0Q are 3 GPU variants of a TongFang
> barebone design which is sold under various brand names.
> 
> The ACPI IRQ override for the keyboard IRQ must be used on these AMD Zen
> laptops in order for the IRQ to work.
> 
> Adjust the irq1_edge_low_force_override[] DMI match table for this:
> 
> 1. Drop the sys-vendor match from the existing PCSpecialist Elimina Pro 16
>     entry for the GM6BGEQ (RTX3050 GPU) model so that it will also match
>     the laptop when sold by other vendors such as hyperbook.pl.
> 
> 2. Add board-name matches for the GM6BG5Q (RTX4050) and GM6B0Q (RTX4060)
>     models.
> 
> Suggested-by: August Wikerfors <git@augustwikerfors.se>
> Reported-by: Francesco <f.littarru@outlook.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217394
> Link: https://laptopparts4less.frl/index.php?route=product/search&filter_name=GM6BG
> Link: https://hyperbook.pl/en/content/14-hyperbook-drivers
> Link: https://linux-hardware.org/?probe=bfa70344e3
> Link: https://bbs.archlinuxcn.org/viewtopic.php?id=13313
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Since this is a regression fix for 453b014e2c29 ("ACPI: resource: Fix 
IRQ override quirk for PCSpecialist Elimina Pro 16 M") (for PCSpecialist 
systems like Francesco's with product name "Elimina Pro 16 M" but not 
board name "GM6BGEQ") and 2d331a6ac481 ("ACPI: resource: revert "Remove 
"Zen" specific match and quirks"") (for other vendors using the same 
TongFang design), it should have a "Fixes:" tag for at least one of those.

Both of those commits are in 6.5 (and 6.6-rc) so this should go into 
6.6-rc and be backported to 6.5, but the patch seems to depend on 
424009ab2030 ("ACPI: resource: Drop .ident values from dmi_system_id 
tables") and maybe also d37273af0e42 ("ACPI: resource: Consolidate IRQ 
trigger-type override DMI tables") to apply cleanly, which seem to only 
be queued for linux-next/6.7? I'm not familiar with what the correct 
process is for such cases.

> ---
> Changes in v2:
> - Add missing reported and suggested by tags
> ---
>   drivers/acpi/resource.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 014a3911381b..18f6353c142e 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -512,17 +512,23 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
>   		},
>   	},
>   	{
> -		/*
> -		 * PCSpecialist Elimina Pro 16 M
> -		 *
> -		 * Some models have product-name "Elimina Pro 16 M",
> -		 * others "GM6BGEQ". Match on board-name to match both.
> -		 */
> +		/* TongFang GM6BGEQ / PCSpecialist Elimina Pro 16 M, RTX 3050 */
>   		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "PCSpecialist"),
>   			DMI_MATCH(DMI_BOARD_NAME, "GM6BGEQ"),
>   		},
>   	},
> +	{
> +		/* TongFang GM6BG5Q, RTX 4050 */
FWIW the PCSpecialist Elimina Pro 16 M is sold with all three GPU 
options: https://www.pcspecialist.ie/notebooks/elimina-pro-16-M/
Presumably the RTX 4050 option has board name "GM6BG5Q" but maybe it's 
better to leave it out if it's not confirmed.

> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GM6BG5Q"),
> +		},
> +	},
> +	{
> +		/* TongFang GM6BG0Q / PCSpecialist Elimina Pro 16 M, RTX 4060 */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GM6BG0Q"),
> +		},
> +	},
>   	{ }
>   };
>   

Regards,
August Wikerfors

