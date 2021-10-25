Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB933438F2B
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Oct 2021 08:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhJYGO0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Oct 2021 02:14:26 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:57142
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229841AbhJYGOZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Oct 2021 02:14:25 -0400
Received: from [10.1.1.116] (unknown [103.229.218.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3CC983FFE2;
        Mon, 25 Oct 2021 06:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635142323;
        bh=yMuzWDx3A+Pg8g7yJv+W2F7wN09aQHmIzneRtqCdIbk=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=bQV75QmR/9+1QgawKSo+M+gFDfdVQr6AKZ2cBoFe4pKALYdIWePEtCuRQBg/LFtnV
         vc2hyGtpDF3mFOeMX+LAnBbLMhR92xJTx1yhWL2j7T9Va73ey1FqDhORw0V+FTgZk9
         5nu+QTZlNtTD7XWBo5D/7wQeCSisthZgCEgtGlLEHCpqfPdLQCT+IxNeMQKgOBOqk7
         29Oe3P3P48bzx2d3Xl8x+yHEMvGIg40amAHnBFpjXRwvv06DKI9B0Igkn2Ulh/d9ey
         bSdIFPKwVO/I4ecRuTfxyojswijZ7h4Xdv0RnToehJx9p9+XAFNfyvQNQ4Jk5olpvO
         GK0y+0db+F0AA==
Subject: Re: [For 5.16][PATCH] ACPI: resources: Add one more Medion model in
 IRQ override quirk
To:     linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com
Cc:     dirksche@posteo.de
References: <20211025060628.7580-1-hui.wang@canonical.com>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <5ee06cff-9b71-25b3-de9c-4732861f63b5@canonical.com>
Date:   Mon, 25 Oct 2021 14:11:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211025060628.7580-1-hui.wang@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Please ignore this patch, forgot to add BugLink prefix.

On 10/25/21 2:06 PM, Hui Wang wrote:
> The Medion s17 series laptops have the same issue on the keyboard
> as the s15 series, if skipping to call acpi_get_override_irq(), the
> keyboard could work well. So put the DMI info of s17 series in the
> IRQ override quirk table as well.
>
> https://bugzilla.kernel.org/show_bug.cgi?id=213031
> Tested-by: dirksche <dirksche@posteo.de>
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>   drivers/acpi/resource.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 7bf38652e6ac..3c25ce8c95ba 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -389,6 +389,13 @@ static const struct dmi_system_id medion_laptop[] = {
>   			DMI_MATCH(DMI_BOARD_NAME, "M15T"),
>   		},
>   	},
> +	{
> +		.ident = "MEDION S17405",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
> +			DMI_MATCH(DMI_BOARD_NAME, "M17T"),
> +		},
> +	},
>   	{ }
>   };
>   
