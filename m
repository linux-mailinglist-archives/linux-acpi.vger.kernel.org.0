Return-Path: <linux-acpi+bounces-20218-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ADBD165BE
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 03:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 225B03021E6B
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 02:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9231E252292;
	Tue, 13 Jan 2026 02:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H81LghPx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1325817B50F;
	Tue, 13 Jan 2026 02:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768272671; cv=none; b=HpLcbNTSEY4S0sU8mxwH3H/HDC+eSgvPDppJFx0kTWzdN0FlUZgEo0B5rhf6XFWo8uyswL1WN0sdXzBigHcpXdPq3RZlLkJQeM4HnCLeYx6ot/iznIfwlLDttiu8xSgigt25tmiOXH4IvtD1lnYKMVDWL44CyT6dZP9dPI0Jt+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768272671; c=relaxed/simple;
	bh=/mJQlAeaTIst1Gk/xi6OOUvkwLzHDp2UUSLNiVabZsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0PSevPY40n21Jn1oN8ejIuc7PDZmxUwjmhAz+XS5LmApVcHKknTGylAYJWwHJVHDTmOSn1XG0hABXFg2NFNLzYYfg6KXdU5CNT9A2oNfDpDXpugl1YGffgRFO2e5mXjk9YIkKo9egxqqjG3xJYqSZ5ouBxAQMcVdqIiJbFWQ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H81LghPx; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768272670; x=1799808670;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/mJQlAeaTIst1Gk/xi6OOUvkwLzHDp2UUSLNiVabZsM=;
  b=H81LghPxWBUHWuNr5fln7NOURHcZWUR8PdkN4ebG4AISBuJqx6uJ1sv1
   kKAesBCevJ6CoKzrzyd9/NF1ygxwpQdVrWOHj31phsw6UeMRTP6iu6HqW
   pTdmAqYqR3NbIJZ1kWxE520wmWZADCX3kfmNF9WqVj1Xlt7AHtj4OnOpv
   YqmpA/vT6Mxp13ERxiMQtFWhlJgY0b3sBGC+Gk8E7NgO/MjDyRDLjjosc
   FeNho/N+zjjTAPpMFHvqqJFjHig2nUMJ0gDkg/qa8HCua4nWSkl8Z8EWG
   aZnrlKUeKhlhHXI9flN+ouRcAcBenFxPBite+2iKlrX6PSLk4J+qLn2ue
   g==;
X-CSE-ConnectionGUID: JkB7TRffRsWah9einsyOIQ==
X-CSE-MsgGUID: 2VdVIziGQv2hp1gaustLjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="69465130"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69465130"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 18:51:10 -0800
X-CSE-ConnectionGUID: jerMGdq1Rh2E+ahNfMtRbg==
X-CSE-MsgGUID: Ng1BtrctTu285bBXajFp2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204163180"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.124.129.8]) ([10.124.129.8])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 18:51:09 -0800
Message-ID: <468babfa-bc4c-4ca9-8649-207576ef7df4@linux.intel.com>
Date: Mon, 12 Jan 2026 18:51:08 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] ACPI: scan: Use acpi_setup_gpe_for_wake() for
 buttons
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Todd Brandt <todd.e.brandt@linux.intel.com>
References: <4715380.LvFx2qVVIh@rafael.j.wysocki>
 <2259694.irdbgypaU6@rafael.j.wysocki>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <2259694.irdbgypaU6@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes the suspend failing regression caused by a recent ACPI 
changes
in intelnext kernel. I tested this patch on Panther Lake platform and it 
can suspend
and resume successfully with this patch.

Tested-by: Xi Pardee <xi.pardee@linux.intel.com>

On 1/10/2026 3:58 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> After starting to use platform devices for representing buttons
> enumerated via ACPI, acpi_mark_gpe_for_wake() is insufficient for
> preparing their GPEs to wake up the system from sleep because it
> does not change the "dispatch type" of the given GPE to
> ACPI_GPE_DISPATCH_NOTIFY.  Subsequently, this causes acpi_enable_gpe()
> in __acpi_device_wakeup_enable() to fail and system suspend transitions
> to be aborted.
>
> Address this by updating acpi_wakeup_gpe_init() to use
> acpi_setup_gpe_for_wake() for buttons like for any other devices.
>
> This allows acpi_setup_gpe_for_wake() to be simplified further because
> buttons are not a special case in it any more, so do that as well.
>
> Fixes: 52d864019636 ("ACPI: button: Convert the driver to a platform one")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/scan.c |   18 ++++--------------
>   1 file changed, 4 insertions(+), 14 deletions(-)
>
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -999,15 +999,11 @@ static int acpi_bus_extract_wakeup_devic
>   	return err;
>   }
>   
> -/* Do not use a button for S5 wakeup */
> -#define ACPI_AVOID_WAKE_FROM_S5		BIT(0)
> -
>   static bool acpi_wakeup_gpe_init(struct acpi_device *device)
>   {
>   	static const struct acpi_device_id button_device_ids[] = {
> -		{"PNP0C0C", 0},				/* Power button */
> -		{"PNP0C0D", ACPI_AVOID_WAKE_FROM_S5},	/* Lid */
> -		{"PNP0C0E", ACPI_AVOID_WAKE_FROM_S5},	/* Sleep button */
> +		{"PNP0C0D", 0},	/* Lid */
> +		{"PNP0C0E", 0},	/* Sleep button */
>   		{"", 0},
>   	};
>   	struct acpi_device_wakeup *wakeup = &device->wakeup;
> @@ -1016,15 +1012,9 @@ static bool acpi_wakeup_gpe_init(struct
>   
>   	wakeup->flags.notifier_present = 0;
>   
> -	/* Power button, Lid switch always enable wakeup */
>   	match = acpi_match_acpi_device(button_device_ids, device);
> -	if (match) {
> -		if ((match->driver_data & ACPI_AVOID_WAKE_FROM_S5) &&
> -		    wakeup->sleep_state == ACPI_STATE_S5)
> -			wakeup->sleep_state = ACPI_STATE_S4;
> -		acpi_mark_gpe_for_wake(wakeup->gpe_device, wakeup->gpe_number);
> -		return true;
> -	}
> +	if (match && wakeup->sleep_state == ACPI_STATE_S5)
> +		wakeup->sleep_state = ACPI_STATE_S4;
>   
>   	status = acpi_setup_gpe_for_wake(device->handle, wakeup->gpe_device,
>   					 wakeup->gpe_number);
>
>
>

