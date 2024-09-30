Return-Path: <linux-acpi+bounces-8488-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F24989F9B
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 12:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EC9280F4B
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 10:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF7F18BB97;
	Mon, 30 Sep 2024 10:43:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E369B152E02;
	Mon, 30 Sep 2024 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692981; cv=none; b=GN9etOEMMClC8Fu0dvft+JektWc/kS/2YAnuxpHDgznQIO9lbihF91f6CWexdsl0vmmIjZG/DYGWI+RJ9R1CgmoMCGEzShPHptCUguClW5DpocuIbpjCefsrPVUGbRV5UzxV+30rzZPuoueZp/amEcNT4CFPoryiOZxtbUzbmh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692981; c=relaxed/simple;
	bh=WLm2oImTyJtVZ0s1Fu+l1CRkqh5H5kOEM1GfEnxzJA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1thHL2Dtt/6PJDKDIXuwuL6Rq+SflCFucFZ3Dy7/2VmIFCLbee755ZLepGawe3kGEc1nstyzao5RQSnZTC8iyeuKXou5fmNyRSVaIlkcNhlXJdpCXvGcHvQSr2Se/Y/XElfobV/Jy6UShPyNTlBAwk//5/uYFPF8ohh21AD9gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.100.97] (unknown [147.123.87.154])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id DEC9161E40639;
	Mon, 30 Sep 2024 12:42:24 +0200 (CEST)
Message-ID: <2f45a6ac-5bb7-4954-adb5-3bf706363062@molgen.mpg.de>
Date: Mon, 30 Sep 2024 12:42:16 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ACPI: resource: Loosen the Asus E1404GAB DMI match to
 also cover the E1404GA
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Ben Mayo <benny1091@gmail.com>,
 Tamim Khan <tamim@fusetak.com>, linux-acpi@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <20240927141606.66826-1-hdegoede@redhat.com>
 <20240927141606.66826-2-hdegoede@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240927141606.66826-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Hans,


Thank you for your patch.

Am 27.09.24 um 16:16 schrieb Hans de Goede:
> Like other Asus Vivobooks, the Asus Vivobook Go E1404GA has a DSDT
> describing IRQ 1 as ActiveLow, while the kernel overrides to Edge_High.
> 
>      $ sudo dmesg | grep DMI:.*BIOS
>      [    0.000000] DMI: ASUSTeK COMPUTER INC. Vivobook Go E1404GA_E1404GA/E1404GA, BIOS E1404GA.302 08/23/2023
>      $ sudo cp /sys/firmware/acpi/tables/DSDT dsdt.dat
>      $ iasl -d dsdt.dat
>      $ grep -A 30 PS2K dsdt.dsl | grep IRQ -A 1
>                  IRQ (Level, ActiveLow, Exclusive, )
>                      {1}
> 
> There already is an entry in the irq1_level_low_skip_override[] DMI match
> table for the "E1404GAB", change this to match on "E1404GA" to cover
> the E1404GA model as well (DMI_MATCH() does a substring match).

Ah, good to know. Thank you for fixing it.

> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219224
> Cc: Tamim Khan <tamim@fusetak.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Note this patch replaces Paul Menzel's patch which added a new entry
> for the "E1404GA", instead of loosening the "E1404GAB" match:
> https://lore.kernel.org/linux-acpi/20240911081612.3931-1-pmenzel@molgen.mpg.de/
> ---
>   drivers/acpi/resource.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 1ff251fd1901..dfe108e2ccde 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -504,10 +504,10 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
>   		},
>   	},
>   	{
> -		/* Asus Vivobook Go E1404GAB */
> +		/* Asus Vivobook Go E1404GA* */

I guess people are going to grep for the model, if something does not 
work, so maybe the known ones should listed. I know it’s not optimal, as 
the comments are very likely be incomplete, but it’s better than than 
not having it listed, in my opinion.

>   		.matches = {
>   			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_BOARD_NAME, "E1404GAB"),
> +			DMI_MATCH(DMI_BOARD_NAME, "E1404GA"),
>   		},
>   	},
>   	{


Kind regards,

Paul

