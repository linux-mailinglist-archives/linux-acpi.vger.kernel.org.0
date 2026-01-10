Return-Path: <linux-acpi+bounces-20147-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAA1D0D66F
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Jan 2026 14:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF78630060EA
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Jan 2026 13:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B7A33E34C;
	Sat, 10 Jan 2026 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifVluebY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C2D205E26;
	Sat, 10 Jan 2026 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768051556; cv=none; b=DvoHS9rErXlM+LwdHKFk+zOJA1ruumeMXXbqdSnyraQhJBxg2mgaEzjG4ELB+Q0htK6wbC018qauHVZ9uAbLN4LDVy7h4vObMLBaIPAJiVCjO1ZjmZtp6DB2Lz6a9wM35mlzuBFhpQZtNR0/mrVrk/yko/IcAMAcJegim18n5xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768051556; c=relaxed/simple;
	bh=JNYkBdK1i7Nkf6ZCZmZ0xBSVN53rPojmSksPG4wHzYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BG4NIPzO1Frpcm984RuLvUmIobPDfSw5exIicuJoLAFOJrZGMncqxBIavXpIKdtzJkGEZd51EtcTb/KD+YoJeq10vvJKZO2mg6MDzIfkDXnl8+cOEImy85u/1hyGjwuHTDuABKsFjG7LY6GD7zSU+k9Q/HcYuFEoNh/ZKjFIBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifVluebY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4FDC4CEF1;
	Sat, 10 Jan 2026 13:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768051556;
	bh=JNYkBdK1i7Nkf6ZCZmZ0xBSVN53rPojmSksPG4wHzYw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ifVluebYgjDvO04rt8luqDg+2jv4Uj246tkuMFtZf98bj7Karb+1/YytX3i+U66Ca
	 9pi3YPaIEWBuq3wbQ+VamS9QdSLPKIzVyKS5P78y4RvIdBDG++Y7/4Go2J+eMnyTYi
	 EieMtXfQmuEQi/lCu98LT3UYb6YePzPsHHSZk03XmuZ/3KNj4KULx4HQFFUOualIwJ
	 xJ8NChV9VaMZZLATyugh/e1drsbt22rXrAdcYwhrFgOGrddkUt9+Xb06AMZmXGb08M
	 JmI6Qi8Ae0ln7QC6aYCHBqR9gm65SHnkKnOhlyWVV62IlBmeD/7NFxlx1pM8CgyGrq
	 Kw5E+dfjo8V9w==
Message-ID: <1aadd874-6400-4652-9a42-d1113db19184@kernel.org>
Date: Sat, 10 Jan 2026 07:25:55 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: scan: Clean up after recent changes
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <12825056.O9o76ZdvQC@rafael.j.wysocki>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <12825056.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/10/2026 5:50 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use LIST_HEAD() for initializing an on-stack list head in two places and
> remove an empty code line added by mistake.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> 
> This is based on ACPI changes in linux-next.
> 
> ---
>   drivers/acpi/acpi_platform.c |    2 +-
>   drivers/acpi/scan.c          |    3 +--
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -136,7 +136,7 @@ struct platform_device *acpi_create_plat
>   	}
>   
>   	if (adev->device_type == ACPI_BUS_TYPE_DEVICE && !adev->pnp.type.backlight) {
> -		struct list_head resource_list = LIST_HEAD_INIT(resource_list);
> +		LIST_HEAD(resource_list);
>   
>   		count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
>   		if (count < 0)
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2602,8 +2602,8 @@ static void acpi_scan_postponed(void)
>   
>   static void acpi_scan_claim_resources(struct acpi_device *adev)
>   {
> -	struct list_head resource_list = LIST_HEAD_INIT(resource_list);
>   	struct resource_entry *rentry;
> +	LIST_HEAD(resource_list);
>   	unsigned int count = 0;
>   	const char *regionid;
>   
> @@ -2660,7 +2660,6 @@ exit:
>   	acpi_dev_free_resource_list(&resource_list);
>   }
>   
> -
>   static int __init acpi_reserve_motherboard_resources(void)
>   {
>   	struct acpi_scan_system_dev *sd, *tmp;
> 
> 
> 


