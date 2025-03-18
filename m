Return-Path: <linux-acpi+bounces-12325-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7FAA6791A
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 17:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A4B424AD0
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Mar 2025 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41F517A2E0;
	Tue, 18 Mar 2025 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDy6GmMB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2EC20E033
	for <linux-acpi@vger.kernel.org>; Tue, 18 Mar 2025 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314750; cv=none; b=nb/l9m7/deGBBkOfveAP+S4qi4eYlP2E+rOy5cUh+N+Sd3Etr2QVWhs+mfr0xeleJF9QJauwxJPKOBfPFl2CwdkeiwTTkXG/Zqxwcwo3uSBKrMXp79x/DuS3tdcr3W5KQ3vfT2TbC1nQpzqEAjKDTBu5z8Rhicux/Dc/yq/Ric8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314750; c=relaxed/simple;
	bh=VuQm2jFESaPBbuqwjoKGcVK+DXK4tuxwWAqwbEc2gtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LILCQ0dS2liWK2bZSwEab0lVMYPA9kSpMzhoE3lGx+WYFgUIS6cX/NhmVh73DsH6nPDje4wlOc6WalMk3L1I0GAmlmtwRu3EUc8LP1ePVyAWhKlXZy8qkCJWneC4PSM1A4Jw5SEAMwp8TQP82OQSQAd236bNdrjwheMVrAeM37M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDy6GmMB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742314744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EU2Ic7I1sUvSKCy08C9Tv8GAj2wePPRjqEZAXSqjPhY=;
	b=HDy6GmMB2jyKIksSmRDk9ilxcUNjqrESRtg5kHAvONHYaw/ammSUvgHoSj1n/Ij1kF8xHO
	BHbLHRyIF/kyE1c5ImRxpBAcinS0N2W8eNnQ7f11iWuSx91TuGLVP0Ilneb47arWfbGmwb
	QKUE+Fctm/cbeQRXkf0EicQQktt+oa8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-VNdhc90pPpmTEfrcFoOULw-1; Tue, 18 Mar 2025 12:19:02 -0400
X-MC-Unique: VNdhc90pPpmTEfrcFoOULw-1
X-Mimecast-MFC-AGG-ID: VNdhc90pPpmTEfrcFoOULw_1742314740
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abec83a498cso444955366b.1
        for <linux-acpi@vger.kernel.org>; Tue, 18 Mar 2025 09:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742314740; x=1742919540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EU2Ic7I1sUvSKCy08C9Tv8GAj2wePPRjqEZAXSqjPhY=;
        b=QrhE9UPxlH0rGFauTeQK/Fo2El58ACM0+KrtMpcebdyyY7O8Si8ftp8TZEhAuRBRmm
         Ow/Mqta0AcC1rqQjUV9p4fuoOkCTgM1W5Sv0JHgBHxHdDdObVt5dZecOd8CuyGO2gogV
         7l+LtMqBQZbdK+hH0LygGhlduj4sgqYxowgKfFUV4AG+lbdPwL3gGJiMPEOZuK5nRHeY
         v7oM4zJsUxvuRXdWEbV9Huofey86QlHHZJ7vaVBWYCIUmrE//GA0TGu47sGMeOPDZaxZ
         RtageWrMGueEx6XPoYzEImK7cMqgmHYPsgrqbA8YC7yTVeMVk0IEbpTmwtRL9yQ9pXBV
         OjKw==
X-Forwarded-Encrypted: i=1; AJvYcCW5eD9mGTlwrigAeFXNmQN65nQwV8DhL+RWOkc+L78I2FUt8425s3JH6vOkkCmg41veQRKIKamWv/LQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8P8Ipm2/yMW7WnhhMiQEk/OXkhSCqu56cYoRp7ZO8ZT538FHU
	ovpcLld6mPvUfOcl9HGL+gWiI6fW5toc+aw/Kr71XLrMqND8ClqZYMLiY4uF9FGnINmEOtpJpqM
	CvYP3xINRYCHjdOdvT0+NqRL/Zq/QVmT7FUbHxKOt8PAyrhyclqEkBkCpNRs=
X-Gm-Gg: ASbGnctMhExQ1Ap8WUS6J7yMIAh5UTvUP6/OVPPm4f0WlVqwQoBZeDdodFRN7AQ6NTv
	QXTz+3S1olNHD7yWU9rHk6Nu2HkCXSXsO8Noo/VpcBZWefgiY0kugCdXVIW1fPRwK8BT6S8zTLY
	BEofDCgLEy7o3FukYEOhQaaZKaFOHTGmGoI3KQmbiYytMHJpKHReGvVtovX+cRcH1hpoxGFeULk
	N9ZOqJ+h4cyEXkF5psjXXUmaLSNajgQrptQCtYvYaMpgmDWzq93YvLWMif1conbqPp0a2qWDTsk
	toFTVVQ6+vVp49EcSdFyv4bT1uFuJB8GjA0AMlV5XxcwPcF452uhUA0Lk+ll9S0/tT0Xs2ayjXO
	uvoWDacAevLU+zKV0icE/r3i6CcOaydRPqI62ibfz5V4bmPW7acb4lp8AyoSEiEg23zjo
X-Received: by 2002:a17:907:2cc5:b0:ac2:fd70:dda3 with SMTP id a640c23a62f3a-ac330445086mr1687697766b.35.1742314740306;
        Tue, 18 Mar 2025 09:19:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBzjMM3CLmirwe4h/1Hf9RQ0UnvPgbhViJ1GHQlrn3tDmefjP8E2y4LgrMP7j+PJOy9U53DA==
X-Received: by 2002:a17:907:2cc5:b0:ac2:fd70:dda3 with SMTP id a640c23a62f3a-ac330445086mr1687694366b.35.1742314739884;
        Tue, 18 Mar 2025 09:18:59 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:f271:322f:26b0:6eb5? (2001-1c00-2a07-3a01-f271-322f-26b0-6eb5.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:f271:322f:26b0:6eb5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aefdbsm864270366b.3.2025.03.18.09.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 09:18:59 -0700 (PDT)
Message-ID: <cf45e4a4-b1dd-4485-81bd-e65ab729f073@redhat.com>
Date: Tue, 18 Mar 2025 17:18:56 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on ASUS Vivobook 14
 X1404VAP
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Anton Shyndin <mrcold.il@gmail.com>,
 All applicable <stable@vger.kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250318160903.77107-1-pmenzel@molgen.mpg.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250318160903.77107-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 18-Mar-25 17:09, Paul Menzel wrote:
> Like the ASUS Vivobook X1504VAP and Vivobook X1704VAP, the ASUS Vivobook 14
> X1404VAP has its keyboard IRQ (1) described as ActiveLow in the DSDT, which
> the kernel overrides to EdgeHigh breaking the keyboard.
> 
>     $ sudo dmidecode
>     […]
>     System Information
>             Manufacturer: ASUSTeK COMPUTER INC.
>             Product Name: ASUS Vivobook 14 X1404VAP_X1404VA
>     […]
>     $ grep -A 30 PS2K dsdt.dsl | grep IRQ -A 1
>                  IRQ (Level, ActiveLow, Exclusive, )
>                      {1}
> 
> Add the X1404VAP to the irq1_level_low_skip_override[] quirk table to fix
> this.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219224
> Cc: Anton Shyndin <mrcold.il@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index b4cd14e7fa76..14c7bac4100b 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -440,6 +440,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
>  			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
>  		},
>  	},
> +	{
> +		/* Asus Vivobook X1404VAP */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_BOARD_NAME, "X1404VAP"),
> +		},
> +	},
>  	{
>  		/* Asus Vivobook X1504VAP */
>  		.matches = {


