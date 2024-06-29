Return-Path: <linux-acpi+bounces-6676-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF1391CC08
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Jun 2024 12:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A0F1C214A1
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Jun 2024 10:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983D24084C;
	Sat, 29 Jun 2024 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QY0Kc8P0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0CE3BBCB
	for <linux-acpi@vger.kernel.org>; Sat, 29 Jun 2024 10:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719655582; cv=none; b=jwJ7YLiKva1ucoaqxRHbKDJ03K7ey4aiaQPpsUJpMZetKCDPHyVx5annRttbU4JFuRa1PGy+3nOKQJN7RrVIXJ5P5UPm966IEZG/RgrLAQJ6FOVsJnwZARAbBRyov+PmtO7+E+CdfyfPiKIKT5wTRqsA65RtbpNzNiuZGrKktKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719655582; c=relaxed/simple;
	bh=fP3ZgVcJWnSqmG+QDRXA2UxRMjfdyfjYKpcuz8EafME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yi5OpvprPszmShFm9aKs1TPH9boex7Wj8tLazohlQx0HoS61Mqwn2NTiaqky+UCrpsGWxsSamhghruwmE1Iotrhyf1om/ZSYhm+nCgeU796nB02zE+hQeJx52TtoqWkYt3DSDsA9ub5aRjdQd7W3nRPfZOiNl318dP4pH08BOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QY0Kc8P0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719655579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYqpbKxRqKTXTaQj/B2jrZZGCBFUlpUEsubwrs1Z6Mk=;
	b=QY0Kc8P008ozyIbMevJ1L83lR7ErqELgjkLLtJlF+HxmJSW4ac+PbtlqD6UC/DrNNmte8f
	jVIUEQH8Ds6gTG6s2mQ9GUD6O6qyzDAIdc35Y1OAvK7dNHgh2JLt41G1W6b+jHKaEP/JIe
	GQQNG/DLdd7AxrljGvs4seDAgwtVESs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-rAbrgG0bOPOEu112_gLjUQ-1; Sat, 29 Jun 2024 06:06:15 -0400
X-MC-Unique: rAbrgG0bOPOEu112_gLjUQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a724d8c38d3so79266466b.2
        for <linux-acpi@vger.kernel.org>; Sat, 29 Jun 2024 03:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719655574; x=1720260374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYqpbKxRqKTXTaQj/B2jrZZGCBFUlpUEsubwrs1Z6Mk=;
        b=OiN7DBA9zG5InH4i1S2JbPKM/z+vLFWKjrjDS+5Pt9PlyMY4SHMaevQHd45356g3af
         kdsRK8YeaFOkp8LEr3v9ia1lok1V3qlNxLZQ+/r6JuAahXeWQ9zSXzFTBgmKLJGl45W5
         R7ONpjQggSdXCsqonCOBGc2OHKZtQbv/cm0WDZRePcMPPD5CgNhxPiNpiMLWg/yukd2S
         LnzH2u9JoiHy4AAhgS6rXNIjjqNKV6M/3dFrIeFLI6aFq9yfO3DuGVqvZyqCFxT0U/nc
         g3Of8ywXHjdKLUNdhqGKUGLQtjuirPJ6UgDghOWJlqDFuCF72vrcV1vnBPBlKJRt+NJY
         cyWA==
X-Forwarded-Encrypted: i=1; AJvYcCVd1vM3AvMBxVGWyaqo7MvWBjKFirJhydX7R39NKBqq1xxcVxcqjlAXAWLtThpEhGMkU4GM1wSxYcUp0A0z+kej84XOiL+PtmTQTQ==
X-Gm-Message-State: AOJu0YzxeGGDXvhjO/4W+6SmIRXN29iIfq2wTOv13GXRCEMYfg3+OdqP
	bykDq0jXgCnsLH5o7YnGh5tH8o8mi9B2O9aDMvg7NjLYZK6FZC4n2yJ4gbllNFTurUokO9gt840
	A+wfymEoWmo4zHcYxpl0eZrRAuTMo3VlKYDwWjxLv2wUOYyMco2/O7CcQ+dg=
X-Received: by 2002:a17:906:7c96:b0:a6f:52db:7e5e with SMTP id a640c23a62f3a-a7514428746mr47487566b.19.1719655573829;
        Sat, 29 Jun 2024 03:06:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcgB1sHbm6x7OGM6XRXkq/oMqclcO6vtKJYyVWv4qRyUGTgy4c/TliSIQ5E2RlBoz0K2Vdsw==
X-Received: by 2002:a17:906:7c96:b0:a6f:52db:7e5e with SMTP id a640c23a62f3a-a7514428746mr47485866b.19.1719655573379;
        Sat, 29 Jun 2024 03:06:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab065689sm149922566b.106.2024.06.29.03.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 03:06:13 -0700 (PDT)
Message-ID: <6e881b24-e1fe-40fe-b19e-69ee0091839f@redhat.com>
Date: Sat, 29 Jun 2024 12:06:12 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: PMIC: Constify struct pmic_table
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Andy Shevchenko <andy@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <a6c9b1bcdf259adabbcaf91183d3f5ab87a98600.1719644292.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <a6c9b1bcdf259adabbcaf91183d3f5ab87a98600.1719644292.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/29/24 8:58 AM, Christophe JAILLET wrote:
> 'struct pmic_table' is not modified in these drivers.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    3811	    786	      0	   4597	   11f5	drivers/acpi/pmic/intel_pmic_xpower.o
> 
>    text	   data	    bss	    dec	    hex	filename
>    4147	    450	      0	   4597	   11f5	drivers/acpi/pmic/intel_pmic_xpower.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/acpi/pmic/intel_pmic.c          | 2 +-
>  drivers/acpi/pmic/intel_pmic.h          | 4 ++--
>  drivers/acpi/pmic/intel_pmic_bxtwc.c    | 4 ++--
>  drivers/acpi/pmic/intel_pmic_bytcrc.c   | 4 ++--
>  drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 4 ++--
>  drivers/acpi/pmic/intel_pmic_chtwc.c    | 2 +-
>  drivers/acpi/pmic/intel_pmic_xpower.c   | 4 ++--
>  7 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
> index f20dbda1a831..134e9ca8eaa2 100644
> --- a/drivers/acpi/pmic/intel_pmic.c
> +++ b/drivers/acpi/pmic/intel_pmic.c
> @@ -31,7 +31,7 @@ struct intel_pmic_opregion {
>  
>  static struct intel_pmic_opregion *intel_pmic_opregion;
>  
> -static int pmic_get_reg_bit(int address, struct pmic_table *table,
> +static int pmic_get_reg_bit(int address, const struct pmic_table *table,
>  			    int count, int *reg, int *bit)
>  {
>  	int i;
> diff --git a/drivers/acpi/pmic/intel_pmic.h b/drivers/acpi/pmic/intel_pmic.h
> index d956b03a6ca0..006f0780ffab 100644
> --- a/drivers/acpi/pmic/intel_pmic.h
> +++ b/drivers/acpi/pmic/intel_pmic.h
> @@ -21,9 +21,9 @@ struct intel_pmic_opregion_data {
>  					  u32 reg_address, u32 value, u32 mask);
>  	int (*lpat_raw_to_temp)(struct acpi_lpat_conversion_table *lpat_table,
>  				int raw);
> -	struct pmic_table *power_table;
> +	const struct pmic_table *power_table;
>  	int power_table_count;
> -	struct pmic_table *thermal_table;
> +	const struct pmic_table *thermal_table;
>  	int thermal_table_count;
>  	/* For generic exec_mipi_pmic_seq_element handling */
>  	int pmic_i2c_address;
> diff --git a/drivers/acpi/pmic/intel_pmic_bxtwc.c b/drivers/acpi/pmic/intel_pmic_bxtwc.c
> index e247615189fa..c332afbf82bd 100644
> --- a/drivers/acpi/pmic/intel_pmic_bxtwc.c
> +++ b/drivers/acpi/pmic/intel_pmic_bxtwc.c
> @@ -24,7 +24,7 @@
>  #define VSWITCH1_OUTPUT         BIT(4)
>  #define VUSBPHY_CHARGE          BIT(1)
>  
> -static struct pmic_table power_table[] = {
> +static const struct pmic_table power_table[] = {
>  	{
>  		.address = 0x0,
>  		.reg = 0x63,
> @@ -177,7 +177,7 @@ static struct pmic_table power_table[] = {
>  	} /* MOFF -> MODEMCTRL Bit 0 */
>  };
>  
> -static struct pmic_table thermal_table[] = {
> +static const struct pmic_table thermal_table[] = {
>  	{
>  		.address = 0x00,
>  		.reg = 0x4F39
> diff --git a/drivers/acpi/pmic/intel_pmic_bytcrc.c b/drivers/acpi/pmic/intel_pmic_bytcrc.c
> index 2b09f8da5400..b4c21a75294a 100644
> --- a/drivers/acpi/pmic/intel_pmic_bytcrc.c
> +++ b/drivers/acpi/pmic/intel_pmic_bytcrc.c
> @@ -16,7 +16,7 @@
>  
>  #define PMIC_A0LOCK_REG		0xc5
>  
> -static struct pmic_table power_table[] = {
> +static const struct pmic_table power_table[] = {
>  /*	{
>  		.address = 0x00,
>  		.reg = ??,
> @@ -134,7 +134,7 @@ static struct pmic_table power_table[] = {
>  	}, /* V105 -> V1P05S, L2 SRAM */
>  };
>  
> -static struct pmic_table thermal_table[] = {
> +static const struct pmic_table thermal_table[] = {
>  	{
>  		.address = 0x00,
>  		.reg = 0x75
> diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> index 79f9df552524..ecb36fbc1e7f 100644
> --- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> +++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> @@ -23,7 +23,7 @@
>  #define CHTDC_TI_BPTHERM	0x58
>  #define CHTDC_TI_GPADC		0x5a
>  
> -static struct pmic_table chtdc_ti_power_table[] = {
> +static const struct pmic_table chtdc_ti_power_table[] = {
>  	{ .address = 0x00, .reg = 0x41 }, /* LDO1 */
>  	{ .address = 0x04, .reg = 0x42 }, /* LDO2 */
>  	{ .address = 0x08, .reg = 0x43 }, /* LDO3 */
> @@ -39,7 +39,7 @@ static struct pmic_table chtdc_ti_power_table[] = {
>  	{ .address = 0x30, .reg = 0x4e }, /* LD14 */
>  };
>  
> -static struct pmic_table chtdc_ti_thermal_table[] = {
> +static const struct pmic_table chtdc_ti_thermal_table[] = {
>  	{
>  		.address = 0x00,
>  		.reg = CHTDC_TI_GPADC
> diff --git a/drivers/acpi/pmic/intel_pmic_chtwc.c b/drivers/acpi/pmic/intel_pmic_chtwc.c
> index 25aa3e33b09a..81caede51ca2 100644
> --- a/drivers/acpi/pmic/intel_pmic_chtwc.c
> +++ b/drivers/acpi/pmic/intel_pmic_chtwc.c
> @@ -70,7 +70,7 @@
>   * "regulator: whiskey_cove: implements Whiskey Cove pmic VRF support"
>   * https://github.com/intel-aero/meta-intel-aero/blob/master/recipes-kernel/linux/linux-yocto/0019-regulator-whiskey_cove-implements-WhiskeyCove-pmic-V.patch
>   */
> -static struct pmic_table power_table[] = {
> +static const struct pmic_table power_table[] = {
>  	{
>  		.address = 0x0,
>  		.reg = CHT_WC_V1P8A_CTRL,
> diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
> index 43c5850b4bf3..49bda5e0c8aa 100644
> --- a/drivers/acpi/pmic/intel_pmic_xpower.c
> +++ b/drivers/acpi/pmic/intel_pmic_xpower.c
> @@ -26,7 +26,7 @@
>  #define AXP288_ADC_TS_CURRENT_ON_ONDEMAND		(2 << 0)
>  #define AXP288_ADC_TS_CURRENT_ON			(3 << 0)
>  
> -static struct pmic_table power_table[] = {
> +static const struct pmic_table power_table[] = {
>  	{
>  		.address = 0x00,
>  		.reg = 0x13,
> @@ -129,7 +129,7 @@ static struct pmic_table power_table[] = {
>  };
>  
>  /* TMP0 - TMP5 are the same, all from GPADC */
> -static struct pmic_table thermal_table[] = {
> +static const struct pmic_table thermal_table[] = {
>  	{
>  		.address = 0x00,
>  		.reg = XPOWER_GPADC_LOW


