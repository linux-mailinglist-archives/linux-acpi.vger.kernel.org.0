Return-Path: <linux-acpi+bounces-19374-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A535FC9A06E
	for <lists+linux-acpi@lfdr.de>; Tue, 02 Dec 2025 05:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DF0F4E229D
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Dec 2025 04:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DAE2DEA83;
	Tue,  2 Dec 2025 04:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Myba3YY6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EEC272813;
	Tue,  2 Dec 2025 04:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764650614; cv=none; b=CYvhSw5XbH3Rdz5RdT64N7wZ1EidcCrUOVDj+7zfN3o5swkM/KZsnnFAZIQQx0wxmQIjFGNigIm1WddnoVHWvcw03XPUte9uyf/WUbtFBP8+oGmQcBBLP+920Cr77oup4Ce0+V5rBJQLKMYpEueLpZq4ZTFlDMbR2BTHBAGsGh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764650614; c=relaxed/simple;
	bh=Wfm4K/CtvvCS85v3k7UzwpOnrUwGFPhaWyCiMNWdn+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+zPgpESltNT4LyvK6o/Z7aJDWnhHlfjCix8DsWu0NGDQLf6O8Hv5l1fNceRE4fs40oJ7MA35rnfUn65TyoHhM0KXWw1a2vnCi7R/fNJt+xl2a90LmGlrz3CoTiXdJbFOV2x4We836oObKfaqderPQqXbRTpACQkd8zerlb++a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Myba3YY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C6DC4CEF1;
	Tue,  2 Dec 2025 04:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764650614;
	bh=Wfm4K/CtvvCS85v3k7UzwpOnrUwGFPhaWyCiMNWdn+E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Myba3YY6+o692HLYNTvc84JNrskKCBzD97I/ol0JBfvxhCeVCIw5bdN3LOfjG4HtF
	 Z7oIMrUF4XAoXCm7C2ljRvFGcXFhLjl/a2hs2gefRuoUd7o/PsO5Szrf79uDe63cXW
	 TLzYBx/fsUOVairFlRJ5fCmpcWXHwDL5GrkOXYmPymR8KB858/Qpo+Pm0NueWRELUN
	 YbZK6MXHHKg0Hj6d/ux/OFsb7tM6v24KQVQCEGs3QpqH/0RoO8ZnohSFVCZ/78zdeF
	 gWECf5734/oF2B5tavu6+mYuuOpFBhnh6Ny49ZQa4ka4QZc59LEyb0Cd9N77hD+fam
	 QxpH5A9KyPRdw==
Message-ID: <1654cfc3-ff8a-4f7f-9929-0442f2b3bb2b@kernel.org>
Date: Mon, 1 Dec 2025 22:43:31 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Beckett <bob.beckett@collabora.com>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Cc: linux-acpi@vger.kernel.org, kernel@collabora.com,
 linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, Richard Hughes <richard@hughsie.com>,
 William Jon McCann <mccann@jhu.edu>, "Jaap A . Haitsma" <jaap@haitsma.org>,
 Benjamin Canou <bookeldor@gmail.com>, Bastien Nocera <hadess@hadess.net>,
 systemd-devel@lists.freedesktop.org,
 Lennart Poettering <lennart@poettering.net>,
 Antheas Kapenekakis <lkml@antheas.dev>
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

++ dri-devel

On 12/1/2025 10:34 PM, Dmitry Osipenko wrote:
> Add `/sys/power/lps0_screen_off` interface to allow userspace to control
> Display OFF/ON DSM notifications at runtime. Writing "1" to this file
> triggers the OFF notification, and "0" triggers the ON notification.
> 
> Userspace should write "1" after turning off all physical and remote
> displays. It should write "0" before turning on any of displays.

As this has to do with actions when displays are off I think you should 
also CC dri-devel on the next submission.

> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   Documentation/ABI/testing/sysfs-power |  13 +++
>   drivers/acpi/x86/s2idle.c             | 149 +++++++++++++++++++++++---
>   2 files changed, 145 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> index d38da077905a..af7c81ae517c 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -470,3 +470,16 @@ Description:
>   
>                   Minimum value: 1
>                   Default value: 3
> +
> +What:		/sys/power/lps0_screen_off
> +Date:		November 2025

This should be matching the kernel you're targeting this to land, which 
is definitely not in the past.

> +Contact:	Dmitrii Osipenko <dmitry.osipenko@collabora.com>
> +Description:
> +		This file is available if the ACPI/OSPM system supports
> +		Display Off/On DSM notifications. It controls state of the
> +		notification.
> +
> +		Writing a "1" to this file invokes Display Off Notification.
> +		Writing a "0" to this file invokes Display On Notification.
> +
> +		Notifications are only triggered on state transitions.
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 6d4d06236f61..d5cb5e22431d 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -18,7 +18,10 @@
>   #include <linux/acpi.h>
>   #include <linux/device.h>
>   #include <linux/dmi.h>
> +#include <linux/kobject.h>
> +#include <linux/mutex.h>
>   #include <linux/suspend.h>
> +#include <linux/sysfs.h>
>   
>   #include "../sleep.h"
>   
> @@ -61,6 +64,11 @@ static guid_t lps0_dsm_guid_microsoft;
>   static int lps0_dsm_func_mask_microsoft;
>   static int lps0_dsm_state;
>   
> +static DEFINE_MUTEX(lps0_dsm_screen_off_lock);
> +static bool lps0_dsm_screen_state_off;
> +static bool lps0_screen_off_suspended;
> +static bool lps0_screen_off_sysfs_inhibit;
> +
>   /* Device constraint entry structure */
>   struct lpi_device_info {
>   	char *name;
> @@ -513,6 +521,76 @@ static struct acpi_scan_handler lps0_handler = {
>   	.attach = lps0_device_attach,
>   };
>   
> +static bool lps0_has_screen_off_dsm(void)
> +{
> +	int id = acpi_s2idle_vendor_amd() ?
> +		 ACPI_LPS0_SCREEN_ON_AMD : ACPI_LPS0_SCREEN_OFF;
> +
> +	if (lps0_dsm_func_mask_microsoft > 0 &&
> +	    (lps0_dsm_func_mask & BIT(ACPI_LPS0_SCREEN_OFF)))
> +		return true;
> +
> +	if (lps0_dsm_func_mask > 0 && (lps0_dsm_func_mask & BIT(id)))
> +		return true;
> +
> +	return false;
> +}
> +
> +static void lps0_dsm_screen_off(void)
> +{
> +	if (lps0_dsm_screen_state_off)
> +		return;
> +
> +	if (lps0_dsm_func_mask > 0)
> +		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> +					ACPI_LPS0_SCREEN_OFF_AMD :
> +					ACPI_LPS0_SCREEN_OFF,
> +					lps0_dsm_func_mask, lps0_dsm_guid);
> +
> +	if (lps0_dsm_func_mask_microsoft > 0)
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
> +					lps0_dsm_func_mask_microsoft,
> +					lps0_dsm_guid_microsoft);
> +
> +	lps0_dsm_screen_state_off = true;
> +}
> +
> +static void lps0_dsm_screen_on(void)
> +{
> +	if (!lps0_dsm_screen_state_off)
> +		return;
> +
> +	if (lps0_dsm_func_mask_microsoft > 0)
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
> +					lps0_dsm_func_mask_microsoft,
> +					lps0_dsm_guid_microsoft);
> +
> +	if (lps0_dsm_func_mask > 0)
> +		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> +					ACPI_LPS0_SCREEN_ON_AMD :
> +					ACPI_LPS0_SCREEN_ON,
> +					lps0_dsm_func_mask, lps0_dsm_guid);
> +
> +	lps0_dsm_screen_state_off = false;
> +}
> +
> +static void lps0_dsm_screen_off_set(int sysfs_off, int suspended)

I don't really like passing in arbitrary integers, it makes this code 
hard to follow.

Could you perhaps use an enum instead?

> +{
> +	mutex_lock(&lps0_dsm_screen_off_lock);
> +

I'd use a guard(mutex) here instead.

> +	if (sysfs_off > -1)
> +		lps0_screen_off_sysfs_inhibit = sysfs_off;
> +	if (suspended > -1)
> +		lps0_screen_off_suspended = suspended;
> +
> +	if (lps0_screen_off_suspended || lps0_screen_off_sysfs_inhibit)
> +		lps0_dsm_screen_off();
> +	else
> +		lps0_dsm_screen_on();
> +
> +	mutex_unlock(&lps0_dsm_screen_off_lock);
> +}
> +
>   static int acpi_s2idle_begin_lps0(void)
>   {
>   	if (pm_debug_messages_on && !lpi_constraints_table) {
> @@ -543,15 +621,7 @@ static int acpi_s2idle_prepare_late_lps0(void)
>   		lpi_check_constraints();
>   
>   	/* Screen off */
> -	if (lps0_dsm_func_mask > 0)
> -		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> -					ACPI_LPS0_SCREEN_OFF_AMD :
> -					ACPI_LPS0_SCREEN_OFF,
> -					lps0_dsm_func_mask, lps0_dsm_guid);
> -
> -	if (lps0_dsm_func_mask_microsoft > 0)
> -		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
> -				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> +	lps0_dsm_screen_off_set(-1, true);
>   
>   	/* LPS0 entry */
>   	if (lps0_dsm_func_mask > 0 && acpi_s2idle_vendor_amd())
> @@ -618,14 +688,7 @@ static void acpi_s2idle_restore_early_lps0(void)
>   	}
>   
>   	/* Screen on */
> -	if (lps0_dsm_func_mask_microsoft > 0)
> -		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
> -				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> -	if (lps0_dsm_func_mask > 0)
> -		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> -					ACPI_LPS0_SCREEN_ON_AMD :
> -					ACPI_LPS0_SCREEN_ON,
> -					lps0_dsm_func_mask, lps0_dsm_guid);
> +	lps0_dsm_screen_off_set(-1, false);
>   }
>   
>   static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
> @@ -673,4 +736,56 @@ void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg)
>   }
>   EXPORT_SYMBOL_GPL(acpi_unregister_lps0_dev);
>   
> +static ssize_t lps0_screen_off_store(struct kobject *kobj,
> +				     struct kobj_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 10, &val))
> +		return -EINVAL;
> +
> +	if (val > 1)
> +		return -EINVAL;

Based upon how you are using this maybe just use kstrtobool() instead.

> +
> +	lps0_dsm_screen_off_set(val, -1);
> +
> +	return count;
> +}
> +
> +static ssize_t lps0_screen_off_show(struct kobject *kobj,
> +				    struct kobj_attribute *attr,
> +				    char *buf)
> +{
> +	return sprintf(buf, "%d\n", lps0_screen_off_sysfs_inhibit);

You should use sysfs_emit().

> +}
> +
> +static struct kobj_attribute lps0_screen_off_attr =
> +	__ATTR(lps0_screen_off, 0644,
> +	       lps0_screen_off_show, lps0_screen_off_store);
> +
> +static struct attribute *lps0_screen_off_attrs[] = {
> +	&lps0_screen_off_attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group lps0_screen_off_attr_group = {
> +	.attrs = lps0_screen_off_attrs,
> +};
> +
> +static int lps0_dsm_screen_off_init(void)
> +{
> +	int ret;
> +
> +	if (!lps0_has_screen_off_dsm())
> +		return 0;
> +
> +	ret = sysfs_create_group(power_kobj, &lps0_screen_off_attr_group);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +late_initcall(lps0_dsm_screen_off_init);
> +
>   #endif /* CONFIG_SUSPEND */


