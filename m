Return-Path: <linux-acpi+bounces-10318-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A78199FDA96
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Dec 2024 13:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219163A085D
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Dec 2024 12:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32837156886;
	Sat, 28 Dec 2024 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=i2labs.ca header.i=nolan@i2labs.ca header.b="aeKqf6PY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0813B1A2
	for <linux-acpi@vger.kernel.org>; Sat, 28 Dec 2024 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735390547; cv=pass; b=VjBgsnizauJBpYvBcgTSkKnDwpuFalqMcRouiNDKYHHAGeW+hh5YkZT9DBzMsE9Sk5DLKoVtmWYjGZjJ8tp0InJ24uu5Z7HH6RZNa2SNS1mnXAWCcW/kMgQtsZ+27yuHWGLFqKadujJTQDAwodPMoWUft9KTSdJYbKR2NYKtX8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735390547; c=relaxed/simple;
	bh=dV5TMzMpkZdM5zUiOGttmCrbEL3paZJpNSRF93v6whM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FqULLIOwNuQXZPMmaYf/vSl0q37+GR4J6jFZo7Sfs/+7PP9zdGmUybs9U20r83KQevod/qJAdVVsGu03gHVK06/lEmwqHqFJ2rbBBbFvSD6QIB+2gWH4J2sO9e2Cpwi7TYja1P69RUX8Lq5P9hDeH/2D1lYpp1uRoTzn1dSx2L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=i2labs.ca; spf=pass smtp.mailfrom=i2labs.ca; dkim=pass (1024-bit key) header.d=i2labs.ca header.i=nolan@i2labs.ca header.b=aeKqf6PY; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=i2labs.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=i2labs.ca
ARC-Seal: i=1; a=rsa-sha256; t=1735390543; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Bvi36ffLbTxZpTde4/P/kdBceUgMJfttK83n7/MQTooyPW3hjom5UKrVWSXEeph8VSgsln5nk5ksZddYrv6pX3Fb9jIPJfI418c0ki56hQsaBP3tKDjK/wlzXx+euXeLNLqxRprYUPIdcKmFE7ptN7oA6Ym4Jb3BW7y2VV9O3N0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1735390543; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=HKxOyj48CE1tZhFub/mTJpA/MraVrdv8U/EIjqGE/nE=; 
	b=FV/sxi7Az1Tx3/JHe6zl04Z1Q+VycgqayVet+5hOSS+IFqhhl9IbiAIdPQpeMka5IvGsyHblQTZOgqb3IVBgDpWRrQq5BDKnVZoxv7xJfk2m46wzphhpqEfBwdYJBl7lR1B2/0XpIO+FneixvX8Fiax/jIMWb1AsfrhjSWPnICQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=i2labs.ca;
	spf=pass  smtp.mailfrom=nolan@i2labs.ca;
	dmarc=pass header.from=<nolan@i2labs.ca>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1735390543;
	s=zoho; d=i2labs.ca; i=nolan@i2labs.ca;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=HKxOyj48CE1tZhFub/mTJpA/MraVrdv8U/EIjqGE/nE=;
	b=aeKqf6PYxmsvZnuQGvy27CNOledpgL3LK1OiRpb2upMVL+cKMTVBdSlNQIUXRVVn
	9AY9rINSC9+0PEsCpONFWvgWl4eD48B9+pGClsdsL6zArsoEz/vbgoP7Idfw5oqjy5r
	Whebdan2ViO8CqgHTW1SrwwQInICAgHMwbV6lNxA=
Received: by mx.zohomail.com with SMTPS id 1735390541107545.2005150358125;
	Sat, 28 Dec 2024 04:55:41 -0800 (PST)
Message-ID: <23b9ca13-9899-4ab4-a0dd-a47da3f34120@i2labs.ca>
Date: Sat, 28 Dec 2024 19:55:37 +0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi: Emit udev 'update' event after battery add hooks
To: linux-acpi@vger.kernel.org
References: <43d1d35b-d875-4e05-b0ff-a9bfde5ef34a@i2labs.ca>
Content-Language: en-US
From: Nolan Woods <nolan@i2labs.ca>
In-Reply-To: <43d1d35b-d875-4e05-b0ff-a9bfde5ef34a@i2labs.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Correction: the event action string is 'change' and not 'update' (not 
sure where
I got that from..).

Also, despite my IDEs repeated insistence the kobj member type is not a
pointer. Here is my updated patch, I would still like some input on the
items in my original message before finalizing the patch.

---
  drivers/acpi/battery.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 3d5342f8d7b3..abe861946eb6 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -899,6 +899,7 @@ static int sysfs_add_battery(struct acpi_battery 
*battery)
          return result;
      }
      battery_hook_add_battery(battery);
+    kobject_uevent(&battery->bat->dev.kobj, KOBJ_CHANGE);
      return 0;
  }
  --

On 12/27/24 8:35 PM, Nolan Woods wrote:
> A 'add' uevent is emitted after adding respective /sys/class/
> power_supply/BAT* devices via battery.c:sysfs_add_battery(...) ->
> power_supply_core.c:power_supply_register(...) ->
> core.c:device_add(...). Additional drivers (asus-wmi for example) can
> register hooks that are called after the sysfs attributes are added by
> power_supply_register. These hooks are normally used to add additional
> attributes to sysfs. These additional attributes are not available at
> the time that the 'add' uevent is emitted. udev rules are not able to
> interact with them as the hooks are called after the 'add' uevent is
> resolved. An additional 'update' uevent is needed to allow udev rules to
> trigger once all hooks have been processed.
>
> Signed-off-by: Nolan Woods <nolan@i2labs.ca>
> ---
>  drivers/acpi/battery.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 3d5342f8d7b3..abe861946eb6 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -899,6 +899,7 @@ static int sysfs_add_battery(struct acpi_battery 
> *battery)
>          return result;
>      }
>      battery_hook_add_battery(battery);
> +    kobject_uevent(battery->bat->dev->kobj, KOBJ_CHANGE);
>      return 0;
>  }
>  --
>
>
> This is my first contribution to this repo. Please let me know if 
> there are any formatting issues of this submission.
>
> I am looking for feedback on if kobject_uevent() should be called as 
> described in this patch or if it should be at the end of the 
> definition of battery_hook_add_battery.
>
> Also, does it make sense that the "update" (KOBJ_CHANGE) event is sent 
> after the battery hooks make arbitrary changes? or is "update" 
> strictly for hardware/device initiated changes and I need to find a 
> different mechanism to trigger user space logic after the battery hooks?
>
> An example udev rule that only works with this patch:
> ACTION=="update", KERNEL=="BAT0", RUN+="/bin/chmod 666 
> /sys/class/power_supply/BAT0/charge_control_end_threshold"
>
> The following does not work as 
> /sys/class/power_supply/BAT0/charge_control_end_threshold does not 
> exist when the event is resolved:
> ACTION=="add", KERNEL=="BAT0", RUN+="/bin/chmod 666 
> /sys/class/power_supply/BAT0/charge_control_end_threshold"
>
> charge_control_end_threshold is created at asus-wmi.c:1446.
>
> Thank you for your time.

