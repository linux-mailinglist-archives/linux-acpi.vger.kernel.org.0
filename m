Return-Path: <linux-acpi+bounces-20795-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI8qO+sffmnKVwIAu9opvQ
	(envelope-from <linux-acpi+bounces-20795-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Jan 2026 16:29:47 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D646C2B0A
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Jan 2026 16:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4ECD43009B38
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Jan 2026 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8642D97B4;
	Sat, 31 Jan 2026 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnJ/cxGN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3E2314A6F
	for <linux-acpi@vger.kernel.org>; Sat, 31 Jan 2026 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769873384; cv=none; b=HG/MSBjyGhoVpdxFBYYud3fHGxQwEph699TFWYntVSt3fcEs0mzpwfy70OV/wxo5GUhsmzAKKDQOiVsvDXcfuJ3nIs4DrY7NdIQ6TZEhK+ZoAAfdzz1uv/SLKVY4a59YqM3x6bnKJY0yMHCM6CluGif1J6o5qwEwMEbZ2vppqFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769873384; c=relaxed/simple;
	bh=OfnW+sgWMsRSJ3W0sFHhMoPc8DQ8fJsLV+nWniMCsQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWMYY2saWzKtQtkE5n8/ip1TKF3kD93UmK5ASwfVAP8a3tZq9MQTbw4TvJqMv4NXlInPGa8JjSGGv2g9ZIFbq5xTNtoMCw0CeUtIoKtGBbI19tDqEN1ndj3+sH2+s7ExvPBOVOu4nE2VNu66+NtdSZLjCk8x63pxG3GVx+ptiq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnJ/cxGN; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-124899ee9d3so2216899c88.0
        for <linux-acpi@vger.kernel.org>; Sat, 31 Jan 2026 07:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769873380; x=1770478180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0HrZr9tYjh8BMSMFkt9+cvbfUu6kErhymPnX7T2QsE=;
        b=cnJ/cxGNA90dPIdrSYrSyuZbdiLeXPIMi8NszHRhGVuoqQ4+djPGxcavWne6Xs8vnF
         1+hyWbPuMQ3+fAo8ulK0TGWHyrts1a//rqqXByWudiYcg8VRbXDH3RUQs2AN9dFrw4A0
         Fx+P27j9lPchty0DRheMQ8yIbQxPhtBD+X/SG+SiS96QQm5Pd6j4ElFvVXNj0oUq1yVt
         ydqIZ1IHX31FtOrY/1ydU/3XbK6YMIr0Cd+wz/jQ63a20CVd2j1dDGtODrwn7xG3Kcpx
         ynzyFOpLvg2eauBsAr4meA2d+mqQ7Us+9UGSRlZ6vVqq+7c51EvF8cPgqWgitThGi8DY
         nC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769873380; x=1770478180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O0HrZr9tYjh8BMSMFkt9+cvbfUu6kErhymPnX7T2QsE=;
        b=UUfdH6ovYU+uFQ1AywIc3ruj++moSjn21RnRpbnUJE6+kdYXm+PSVCj4tg5IUNFHD+
         ScBKGVIS+YGt4jLMW0+BDt4ZDQbeQI/jpZ29sOcDh4icoXzcjIDZPOCOiPjL1+dikWul
         53rB1uLCljHGw0bTci/Wchmc1OJVnjyObJ/vdaIZtd84MCx3K1HX/wJrEiZSoE3Er0Pk
         xE8kuk6IJkuJqNZP21k2OU2F+RS8/Y8Tzod2pbMMkHueuQvEnSVSNnxqu/1I3/7XG45E
         +iwPh8BSjWwvwJYzJyzl4ECgxFW6olb97ohkzpbKYF/Cmv9ZpqCOQvCNUNy3KfTMSpLf
         PKJg==
X-Forwarded-Encrypted: i=1; AJvYcCX+TXt5yuIfFhwglLROxcs7JEkdlaKpGf0VjN9k9+jSBAxWxNeDlCg9DHQZVOmF7YPzDt+b23xed38s@vger.kernel.org
X-Gm-Message-State: AOJu0Yx345LfZLOOTxYbI2Ypy8Qy/Wx2eQa/t73G00FhfaG/odemZCWS
	ktOy1Wid0Non96QyS8PNgSDA98YFLjGA1yp1pFdjlrUl3gUfkUfLvr1z
X-Gm-Gg: AZuq6aKjsXOtR03rNmunjXlpLdyMlwC1DTvGvR83Cz3BfstBkURpSfb5N5jX5pKbaJu
	Zm6ZVp9pDD/NkRXndTsdnN2RN59ig1u0LusjyO9MIILZhnNKAGDHCCeR62FGiQcBDDrwbj3A9aY
	7erhti+WEH5N9msj6c+fTy3eAMNR1s8oB8pyq47jq1AazY1Zc4QhcCnvEGQUDA8wXxRoJ0/9H/7
	D1/SKKsuTLED2wSOV6LryeSbfbFb+lqi1ro6hPxqwHcPkzTqKxYl42yrEetIqm1oJUD9b1k2z84
	riLPPgkCe/cdm1bwqmHjU1y6PXKOUisu+ROUdnyP9pEuhwAZRU1ZgMyNhp/shyC9MzGO/Rnj4oi
	NCNAlg4qwwjxZUuFlfddIZaFvZNtp+pb2EWy0z07i1apmYtLubRNXRlRizloa6hIIHWF7Cj1rBq
	IpwCJCp3rA1E7H1b43DESzYhH48R+lGGVaAF0=
X-Received: by 2002:a05:7022:438e:b0:11b:9386:a38f with SMTP id a92af1059eb24-124b10a4651mr5014930c88.22.1769873380367;
        Sat, 31 Jan 2026 07:29:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9e0304bsm14332370c88.14.2026.01.31.07.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 07:29:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 31 Jan 2026 07:29:38 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Igor Raits <igor@gooddata.com>,
	Daniel Secik <daniel.secik@gooddata.com>,
	Zdenek Pesek <zdenek.pesek@gooddata.com>,
	Jiri Jurica <jiri.jurica@gooddata.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v1] hwmon: (acpi_power_meter) Fix deadlocks related to
 acpi_power_meter_notify()
Message-ID: <30300396-25b0-4d56-b8dd-c65d221c80bb@roeck-us.net>
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <12855313.O9o76ZdvQC@rafael.j.wysocki>
 <d45d7b8a-97dd-4db8-a785-56df128983a4@roeck-us.net>
 <6252535.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6252535.lOV4Wx5bFT@rafael.j.wysocki>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20795-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 5D646C2B0A
X-Rspamd-Action: no action

Hi all,

On Thu, Jan 29, 2026 at 03:18:11PM +0100, Rafael J. Wysocki wrote:

I decided to apply the patch below as-is. While we don't have confirmation
that it fixes the immediate problem, it is a starting point and won't make
the situation worse. A complete fix which does not require re-registering
the hardware monitoring device will require more work and will not be
suitable for LTS backports.

Thanks,
Guenter

> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v1] hwmon: (acpi_power_meter) Fix deadlocks related to acpi_power_meter_notify()
> 
> The acpi_power_meter driver's .notify() callback function,
> acpi_power_meter_notify(), calls hwmon_device_unregister() under a lock
> that is also acquired by callbacks in sysfs attributes of the device
> being unregistered which is prone to deadlocks between sysfs access and
> device removal.
> 
> Address this by moving the hwmon device removal in
> acpi_power_meter_notify() outside the lock in question, but notice
> that doing it alone is not sufficient because two concurrent
> METER_NOTIFY_CONFIG notifications may be attempting to remove the
> same device at the same time.  To prevent that from happening, add a
> new lock serializing the execution of the switch () statement in
> acpi_power_meter_notify().  For simplicity, it is a static mutex
> which should not be a problem from the performance perspective.
> 
> The new lock also allows the hwmon_device_register_with_info()
> in acpi_power_meter_notify() to be called outside the inner lock
> because it prevents the other notifications handled by that function
> from manipulating the "resource" object while the hwmon device based
> on it is being registered.  The sending of ACPI netlink messages from
> acpi_power_meter_notify() is serialized by the new lock too which
> generally helps to ensure that the order of handling firmware
> notifications is the same as the order of sending netlink messages
> related to them.
> 
> In addition, notice that hwmon_device_register_with_info() may fail
> in which case resource->hwmon_dev will become an error pointer,
> so add checks to avoid attempting to unregister the hwmon device
> pointer to by it in that case to acpi_power_meter_notify() and
> acpi_power_meter_remove().
> 
> Fixes: 16746ce8adfe ("hwmon: (acpi_power_meter) Replace the deprecated hwmon_device_register")
> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/hwmon/acpi_power_meter.c |   17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -47,6 +47,8 @@
>  static int cap_in_hardware;
>  static bool force_cap_on;
>  
> +static DEFINE_MUTEX(acpi_notify_lock);
> +
>  static int can_cap_in_hardware(void)
>  {
>  	return force_cap_on || cap_in_hardware;
> @@ -823,18 +825,26 @@ static void acpi_power_meter_notify(stru
>  
>  	resource = acpi_driver_data(device);
>  
> +	guard(mutex)(&acpi_notify_lock);
> +
>  	switch (event) {
>  	case METER_NOTIFY_CONFIG:
> +		if (!IS_ERR(resource->hwmon_dev))
> +			hwmon_device_unregister(resource->hwmon_dev);
> +
>  		mutex_lock(&resource->lock);
> +
>  		free_capabilities(resource);
>  		remove_domain_devices(resource);
> -		hwmon_device_unregister(resource->hwmon_dev);
>  		res = read_capabilities(resource);
>  		if (res)
>  			dev_err_once(&device->dev, "read capabilities failed.\n");
>  		res = read_domain_devices(resource);
>  		if (res && res != -ENODEV)
>  			dev_err_once(&device->dev, "read domain devices failed.\n");
> +
> +		mutex_unlock(&resource->lock);
> +
>  		resource->hwmon_dev =
>  			hwmon_device_register_with_info(&device->dev,
>  							ACPI_POWER_METER_NAME,
> @@ -843,7 +853,7 @@ static void acpi_power_meter_notify(stru
>  							power_extra_groups);
>  		if (IS_ERR(resource->hwmon_dev))
>  			dev_err_once(&device->dev, "register hwmon device failed.\n");
> -		mutex_unlock(&resource->lock);
> +
>  		break;
>  	case METER_NOTIFY_TRIP:
>  		sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
> @@ -953,7 +963,8 @@ static void acpi_power_meter_remove(stru
>  		return;
>  
>  	resource = acpi_driver_data(device);
> -	hwmon_device_unregister(resource->hwmon_dev);
> +	if (!IS_ERR(resource->hwmon_dev))
> +		hwmon_device_unregister(resource->hwmon_dev);
>  
>  	remove_domain_devices(resource);
>  	free_capabilities(resource);

