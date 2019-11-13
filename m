Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17C0AFBC6E
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 00:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKMXVg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Nov 2019 18:21:36 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55249 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfKMXVg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Nov 2019 18:21:36 -0500
Received: from 79.184.253.153.ipv4.supernova.orange.pl (79.184.253.153) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 55c8f715c53ddc9c; Thu, 14 Nov 2019 00:21:34 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Subject: Re: [PATCH] ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100
Date:   Thu, 14 Nov 2019 00:21:33 +0100
Message-ID: <2931286.GRae9fBGx2@kreacher>
In-Reply-To: <8bdc7a86-e464-9c46-3d40-4f3c75111ce6@huawei.com>
References: <8bdc7a86-e464-9c46-3d40-4f3c75111ce6@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, November 5, 2019 3:35:25 PM CET Yunfeng Ye wrote:
> There are two problems after commit 0f27cff8597d ("ACPI: sysfs: Make
> ACPI GPE mask kernel parameter cover all GPEs"):
> 
> 1. ACPI_MASKABLE_GPE_MAX is changed from 0x80 to 0xff, so the check
> condition "gpe > ACPI_MASKABLE_GPE_MAX" is not valid because the type of
> gpe is u8.
> 
> 2. The size of bitmap is ACPI_MASKABLE_GPE_MAX, so it is not support the
> num 255 for gpe.
> 
> Update the macro ACPI_MASKABLE_GPE_MAX to 0x100, and change the type of
> gpe to u32, also modify the checking condition for gpe.
> 
> Bye the way, update the docs for kernel parameter acpi_mask_gpe.
> 
> Fixes: 0f27cff8597d ("ACPI: sysfs: Make ACPI GPE mask kernel parameter cover all GPEs")
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

AFAICS this really is about supporting the masking of GPE 0xFF.

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 1 +
>  drivers/acpi/sysfs.c                            | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a84a83f8881e..dd878e2491e1 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -114,6 +114,7 @@
>  			This facility can be used to prevent such uncontrolled
>  			GPE floodings.
>  			Format: <int>
> +			Support masking of GPEs numbered from 0x00 to 0xff

Why not just say "Format: <byte>" ?

> 
>  	acpi_no_auto_serialize	[HW,ACPI]
>  			Disable auto-serialization of AML methods
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 75948a3f1a20..3c3302583d78 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -819,14 +819,14 @@ static ssize_t counter_set(struct kobject *kobj,
>   * interface:
>   *   echo unmask > /sys/firmware/acpi/interrupts/gpe00
>   */
> -#define ACPI_MASKABLE_GPE_MAX	0xFF
> +#define ACPI_MASKABLE_GPE_MAX	0x100

So this is the only change that's necessary AFAICS.

>  static DECLARE_BITMAP(acpi_masked_gpes_map, ACPI_MASKABLE_GPE_MAX) __initdata;
> 
>  static int __init acpi_gpe_set_masked_gpes(char *val)
>  {
> -	u8 gpe;
> +	u32 gpe;
> 
> -	if (kstrtou8(val, 0, &gpe) || gpe > ACPI_MASKABLE_GPE_MAX)

And here you can drop the ACPI_MASKABLE_GPE_MAX check and the rest can remain
as is.

> +	if (kstrtouint(val, 0, &gpe) || gpe >= ACPI_MASKABLE_GPE_MAX)
>  		return -EINVAL;
>  	set_bit(gpe, acpi_masked_gpes_map);
> 
> @@ -838,7 +838,7 @@ void __init acpi_gpe_apply_masked_gpes(void)
>  {
>  	acpi_handle handle;
>  	acpi_status status;
> -	u8 gpe;
> +	u32 gpe;
> 
>  	for_each_set_bit(gpe, acpi_masked_gpes_map, ACPI_MASKABLE_GPE_MAX) {
>  		status = acpi_get_gpe_device(gpe, &handle);
> 




