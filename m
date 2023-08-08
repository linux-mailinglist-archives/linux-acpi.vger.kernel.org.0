Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799B1774B92
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Aug 2023 22:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbjHHUuO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Aug 2023 16:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbjHHUuA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Aug 2023 16:50:00 -0400
Received: from abi149hd127.arn1.oracleemaildelivery.com (abi149hd127.arn1.oracleemaildelivery.com [129.149.84.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCE219BF3
        for <linux-acpi@vger.kernel.org>; Tue,  8 Aug 2023 13:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=00B+bvS7xxbE3P6eaqYNfcMl67cqchVUieBrLpYsDxc=;
 b=Lcug5vRz4iHrMWQFbkRRRJ1QogKubjFMqdPfIFsVGUmZl/2P9aw+rmoeswZRV3Uw4ISfqoyQJR6T
   O0OZiS/n3mmdO9oEUkbOhnpZ6jXSRc0huKOTxl6+a3XC9Lpc98C1C7R9rgCrvhjVPU5x5yH/dqRV
   WFq0dUOlaR7lTb7OFyp0xQs0cBElerp+YTaJtF4KX1YjXtfi18upscJCL+RLPmWxAgMP4g+9aDJP
   zMnEJ5rtBxqwpG/mHekgGQFks6sFS5D5sdPWF3UyEEFlQZWRhmYD1AUk04f+u3bJHnOYvHi0aEMR
   hoZQ2BMBvG6y1ApQzbxlK4JV7/GcvZ8v0dZp6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=00B+bvS7xxbE3P6eaqYNfcMl67cqchVUieBrLpYsDxc=;
 b=izLkc7PhLbHGtYjTXc/0sBGSLEqmkyIgouwwv40Bsd96Cn2U8WBW6v9XBAlzz+mKPb0gzomox063
   f/v0vPXi1e9s/A7BFHaMSa29lVz2LpwKYFlmqp8TF22XNaKU2tkPXLIbikpN2BycK1BqAVka+mct
   fW7P5EXOUxMH7QByEUYNOoJV8rdQszjOWpFV3I6zUFR0XPoGkEgz3FyyylFgVODzR1JAr7B84Gdt
   eEZ2PWcYl0EmY7UTcZ6Bgd0vDrW7a0vqeQdNvpdK7dBs+bwdx5oMHj2FOSrEpY7GlaYonqshD+lr
   p/ynKq8YraLynVid5xQnPHmHjQv+nnm6kBX1Vw==
Received: by omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230707 64bit (built Jul  7
 2023))
 with ESMTPS id <0RZ300CTYADDSL30@omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-acpi@vger.kernel.org; Tue, 08 Aug 2023 20:32:01 +0000 (GMT)
Message-id: <abaad492-6aea-4edf-891f-f57bc2b86781@augustwikerfors.se>
Date:   Tue, 8 Aug 2023 22:31:57 +0200
MIME-version: 1.0
Subject: Re: [PATCH v2 2/3] ACPI: resource: Always use MADT override IRQ
 settings for GSI != 1
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
References: <20230808103335.95339-1-hdegoede@redhat.com>
 <20230808103335.95339-3-hdegoede@redhat.com>
Content-language: en-US
From:   August Wikerfors <git@augustwikerfors.se>
In-reply-to: <20230808103335.95339-3-hdegoede@redhat.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAELwczx0/PLPh99wS5vR5JfKPvEuMYNwWpXbIZ357NfxSo4P0nGN+uZ47Gqli9C
 1Ie7q4CpfU++soFG2psvdAraYd+Sx3xJHcDoyvjsBbky2eq42oNZdrsqXW6oS3ny
 kUryd9/fVYgnsLj+W093lScbvqjr0vy4/qWZqkaf6c6qxqlprPI5nmybluOg9hYP
 kqZV1IcUhPsFIshVlNkXDPdf0TP1WNOHsqvaNGI5CktCwxP51PtNNY15Gwqbx2bT
 9i54nzULF2OsJ6b5Zx+RvcAi8m76Rq24b5zrqReW1v8IH4QsGV03bUxvlwHhDiAw
 im25C4oc/z5S5AOFTjojSc5hh/vquwY2PPDAiELBgzc0EnX16mEdrpLZwE3vauPc
 qDQnMnNKp6Q3MiMksr0+Gt4EDa+zS9cBMyGhvDOK9JTd/nAoNMfBMWURIKL+cfZM yEXXHaY=
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-08-08 12:33, Hans de Goede wrote:
> All the cases, were the DSDT IRQ settings should be used instead of
> the MADT override, are for IRQ 1 (the PS/2 kbd IRQ).
> 
> Simplify things by always honering the override for GSI != 1
> (for non DMI quirked cases).
> 
> This allows removing the DMI quirks to honor the override for
> some non IRQ 1 IRQs on some AMD ZEN based Lenovo models.
> 
> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/acpi/resource.c | 28 ++++++++--------------------
>   1 file changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 0800a9d77558..840b938a5fb0 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -470,24 +470,6 @@ static const struct dmi_system_id asus_laptop[] = {
>   	{ }
>   };
>   
> -static const struct dmi_system_id lenovo_laptop[] = {
> -	{
> -		.ident = "LENOVO IdeaPad Flex 5 14ALC7",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "82R9"),
> -		},
> -	},
> -	{
> -		.ident = "LENOVO IdeaPad Flex 5 16ALC7",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "82RA"),
> -		},
> -	},
> -	{ }
> -};
> -
>   static const struct dmi_system_id tongfang_gm_rg[] = {
>   	{
>   		.ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
> @@ -539,8 +521,6 @@ struct irq_override_cmp {
>   static const struct irq_override_cmp override_table[] = {
>   	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>   	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
> -	{ lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
> -	{ lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
>   	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>   	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>   	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
> @@ -562,6 +542,14 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
>   			return entry->override;
>   	}
>   
> +	/*
> +	 * Always use the MADT override info, except for IRQ 1 for IRQ1
> +	 * the DSDT IRQ settings should sometimes be used otherwise
> +	 * PS/2 keyboards will not work.
> +	 */
> +	if (gsi != 1)
> +		return true;
> +
>   #ifdef CONFIG_X86
>   	/*
>   	 * IRQ override isn't needed on modern AMD Zen systems and

I don't think this will work for the Lenovo ThinkPad neo 14 because 
according to https://bugzilla.kernel.org/show_bug.cgi?id=217731 it needs 
the override to also be skipped for IRQ 12.

Regards,
August Wikerfors
