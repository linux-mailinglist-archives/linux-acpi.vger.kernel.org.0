Return-Path: <linux-acpi+bounces-8580-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02430991DDE
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Oct 2024 12:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F733B20BA0
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Oct 2024 10:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB22158543;
	Sun,  6 Oct 2024 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2BSxm6q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFDB7F6
	for <linux-acpi@vger.kernel.org>; Sun,  6 Oct 2024 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728210702; cv=none; b=p9MWMPqMP5ijn6vz50Axo1G3x/rIhV5wlI8oswupmGqbWvUlzYJinEEfkJCp/A8QA1W2mRYQFzSpOp8KcnwVBMQIcL2TDyBBFCtxuM2UKm6ac2tY34EytwdJzmWl1ZkUvHorAF3NLTq9AngpSAaZzK2iKVxXDeeA629lnk+OUzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728210702; c=relaxed/simple;
	bh=+1hMTw3yjrhtuWg/B41NsVCZVs0eLqPm2W6ekE6WIWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcJ/1cFMzLmWShOoOLDRnkG1ws6dkp/liOYCIPZnkglTxjR7vcp77lscTziNuGtGEnQBbCUZ5uwapFtXMxtwOflM4NKDdJXJsRpd94Rip8WhpzwkN6guyfE7/ZN5Aop5wmLA/jB0130gnnb6u+v8GsQnm/xnBXZV8kZzZeh96BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2BSxm6q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728210700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JCGr2POOT5uxbuD68RQ0lpX6z0IGw4KIWstExrGNdbk=;
	b=c2BSxm6qwBD5GfrTRm6sixBQqHCM1i3e6y5ZkUQrClZQ1VfsKgLzEQaplkOhOlKgZ0jZME
	/aNcJqK8iZngMkD10C2O8zZIrzNuZMjk8TjfRhFiJXrbdCUEzySYrXg8C2Ue+Wyddk5qkA
	Bw85DxSdoKThVZ8EMZF6deFnuzq/YhA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-_1g5hXmZPVG71hl6ODAI_Q-1; Sun, 06 Oct 2024 06:31:38 -0400
X-MC-Unique: _1g5hXmZPVG71hl6ODAI_Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a99527bfb14so17296766b.1
        for <linux-acpi@vger.kernel.org>; Sun, 06 Oct 2024 03:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728210697; x=1728815497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCGr2POOT5uxbuD68RQ0lpX6z0IGw4KIWstExrGNdbk=;
        b=UKfRA0rCg6IrYno0tvpGPOe0v56EnvaXIbzR1RH+jMMORWxd7oygT00qaHqhit0LDK
         kyWk+ijVjSnvEpcEse45IAPf/u7r81J4u006mVne31u6T04GABwhTwYQFoxN/SxerRQt
         KBhPcxUvoQfHOx5/MlUd4+iJx/7jXiPLMEY3QCE1R8C2CtxNIBuoZCIq9KIyrjZwyuEC
         ChzpgM672uU752GLjtSdX7pPskBk9161m+EtiU1DGHO7fYTkh5+kfhgLG+x0pPVgBBWb
         ldI2cknAjxpY7gWNRdZsppdzEkShbut7YaHz40rEXzTx5WEgCchDWiAGLF9t0NjkUKGD
         O2Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVqYWjBNLX0rbds9Xr8OwSXGzey+5kitjY6RSnuFhQS73+rw5DufuBD7BqqFL69nZDOiZwDFeobjkr4@vger.kernel.org
X-Gm-Message-State: AOJu0YwKSto0KwdGk0bqsvKUe24evcrHasgR+HEKyyT/EDsXFBXV6pFO
	CjEPMdKXSwIeymK5YbFUDHhRIuMxeyhuy7bQMW/vdtnf4qP13HnO7ZrpZr2E4QoS1vPt2n/vA/M
	Oy2Wbm5jdobyqM0QiOXkKwp8KKHY2O2PFDmIoUViLJWPwcuXcErADzAw8zNfsveKveLrY0w==
X-Received: by 2002:a17:907:745:b0:a8d:caa:7fee with SMTP id a640c23a62f3a-a991bd04d9fmr915433166b.7.1728210697263;
        Sun, 06 Oct 2024 03:31:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSx1R/LgYBtLI5vnf0Pf3LDe+dvGQmKU2skfmJeTA+eT0pHsSB2e/ggYoF1agP+LPkJ5N0lg==
X-Received: by 2002:a17:907:745:b0:a8d:caa:7fee with SMTP id a640c23a62f3a-a991bd04d9fmr915431166b.7.1728210696829;
        Sun, 06 Oct 2024 03:31:36 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e0598947sm1867769a12.11.2024.10.06.03.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 03:31:35 -0700 (PDT)
Message-ID: <9cfb6e26-e3d1-403a-a894-4a0902905407@redhat.com>
Date: Sun, 6 Oct 2024 12:31:34 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 3/3] platform/x86: dell-laptop: Do not fail when
 encountering unsupported batteries
To: Armin Wolf <W_Armin@gmx.de>, pali@kernel.org, dilinger@queued.net
Cc: rafael@kernel.org, lenb@kernel.org, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241001212835.341788-1-W_Armin@gmx.de>
 <20241001212835.341788-4-W_Armin@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241001212835.341788-4-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 1-Oct-24 11:28 PM, Armin Wolf wrote:
> If the battery hook encounters a unsupported battery, it will
> return an error. This in turn will cause the battery driver to
> automatically unregister the battery hook.
> 
> On machines with multiple batteries however, this will prevent
> the battery hook from handling the primary battery, since it will
> always get unregistered upon encountering one of the unsupported
> batteries.
> 
> Fix this by simply ignoring unsupported batteries.
> 
> Reviewed-by: Pali Rohár <pali@kernel.org>
> Fixes: ab58016c68cc ("platform/x86:dell-laptop: Add knobs to change battery charge settings")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your patch/series, I've applied this patch
(series) to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in the pdx86 review-hans branch once I've
pushed my local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> ---
>  drivers/platform/x86/dell/dell-laptop.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
> index a3cd0505f282..5671bd0deee7 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -2391,12 +2391,18 @@ static struct attribute *dell_battery_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(dell_battery);
> 
> +static bool dell_battery_supported(struct power_supply *battery)
> +{
> +	/* We currently only support the primary battery */
> +	return strcmp(battery->desc->name, "BAT0") == 0;
> +}
> +
>  static int dell_battery_add(struct power_supply *battery,
>  		struct acpi_battery_hook *hook)
>  {
> -	/* this currently only supports the primary battery */
> -	if (strcmp(battery->desc->name, "BAT0") != 0)
> -		return -ENODEV;
> +	/* Return 0 instead of an error to avoid being unloaded */
> +	if (!dell_battery_supported(battery))
> +		return 0;
> 
>  	return device_add_groups(&battery->dev, dell_battery_groups);
>  }
> @@ -2404,6 +2410,9 @@ static int dell_battery_add(struct power_supply *battery,
>  static int dell_battery_remove(struct power_supply *battery,
>  		struct acpi_battery_hook *hook)
>  {
> +	if (!dell_battery_supported(battery))
> +		return 0;
> +
>  	device_remove_groups(&battery->dev, dell_battery_groups);
>  	return 0;
>  }
> --
> 2.39.5
> 
> 


