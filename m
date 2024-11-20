Return-Path: <linux-acpi+bounces-9696-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D29F9D3DE4
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 15:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E509B24BD4
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3B11AB53F;
	Wed, 20 Nov 2024 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i27XemEK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8C1AA7A6;
	Wed, 20 Nov 2024 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732113476; cv=none; b=H7qh5/owCE4c/o2zC+bQdoO7pKVJ3oaav+8QSTt0VgoD0aSFYoLD26u6a2kK6Tg5C8AaC11YL5RxszLxpWuheDZzwqO/ANCv6F6RHuA3omoPFCGuys4LvPvTrcPur4XDPyrC7xIDoPMDXpm8OpR4zD69PUrtWNLPLQjHgPyxgcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732113476; c=relaxed/simple;
	bh=huhfnspYmyT9A0LEG6xXsTFa1U1/BfpTovXGM0t2Kak=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Lynqjan6jN0AIAtONTPf6M0sWQLI6x3ghgMSLDrBHbcXAHMCXIFNc+TrOc/xKesfFK1X5xfURobbDsy/V5Fp5n/DQqJydMyf/s7v9d7YGmH4i9Qb13z1GPe8/0uYvABUg6EmLgtbE1Y+1v7Y9yrLwnyjnesfXarGW+EfTMOp41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i27XemEK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732113476; x=1763649476;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=huhfnspYmyT9A0LEG6xXsTFa1U1/BfpTovXGM0t2Kak=;
  b=i27XemEKy9sVx7wwF3ay4Yi4rlxRddCG/KbaR9dXgHU3MIYRDAFtH2Uu
   xbsQARyfhCTtilEM0hsoilDv8SL58ehvNJtdlWQ14tov3LPzOJ6E2LEM2
   YpvT26nJGOM5vpUN9cXe8cQYX0YoRxP0m7bePhuSDjoelasSLY0tTmEyO
   XlbnX3Fr5+j8CcqziP/lcwKGg9HkYfZo7M3WMFhVrTLFFeFoInv+0z8Wl
   DzSUXZEk0NAGIRgh6P6j6V7ts9gGtS5/Sm7dtKWMFosw5TotRNOvB3tRI
   7IbtK3dRnelCA7jZFHI6fKLI1UwAJKwhggW8ZlwjGa/N7Slbb9GzLvdLz
   w==;
X-CSE-ConnectionGUID: 2cbr75vBTZiq1yq0TDLzLw==
X-CSE-MsgGUID: zZM2//sfSBKy+KEKCXjvOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="42684964"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="42684964"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 06:37:38 -0800
X-CSE-ConnectionGUID: 8isG7xbCRWe1GHP/k4ss8A==
X-CSE-MsgGUID: yQI1+t9GT7+pt8Exz7P1Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="90100512"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.15])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 06:37:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 20 Nov 2024 16:37:28 +0200 (EET)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Hans de Goede <hdegoede@redhat.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>, 
    Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
    Alexis Belmonte <alexbelm48@gmail.com>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
    Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list:ACPI" <linux-acpi@vger.kernel.org>, 
    "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER" <platform-driver-x86@vger.kernel.org>, 
    "open list:THINKPAD ACPI EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Matthew Schwartz <matthew.schwartz@linux.dev>, Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v7 10/22] ACPI: platform_profile: Create class for ACPI
 platform profile
In-Reply-To: <20241119171739.77028-11-mario.limonciello@amd.com>
Message-ID: <6aa9ba66-485f-6de9-1769-a544e8313d22@linux.intel.com>
References: <20241119171739.77028-1-mario.limonciello@amd.com> <20241119171739.77028-11-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 19 Nov 2024, Mario Limonciello wrote:

> When registering a platform profile handler create a class device
> that will allow changing a single platform profile handler.
> 
> The class and sysfs group are no longer needed when the platform profile
> core is a module and unloaded, so remove them at that time as well.
> 
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v7:
>  * Whitespace
>  * Add tag
>  * Drop class_is_registered() check
>  * Remove legacy sysfs before class
> v6:
>  * Catch failures in ida_alloc
>  * Use 4th argument of device_create instead of dev_set_drvdata()
>  * Squash unregister patch
>  * Add module init callback
>  * Move class creation to module init
>  * Update visibility based on group presence
>  * Add back parent device
> v5:
>  * Use ida instead of idr
>  * Use device_unregister instead of device_destroy()
>  * MKDEV (0, 0)
> ---
>  drivers/acpi/platform_profile.c  | 86 ++++++++++++++++++++++++++++++--
>  include/linux/platform_profile.h |  2 +
>  2 files changed, 83 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 32affb75e782d..3524a2b4618ed 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -5,6 +5,7 @@
>  #include <linux/acpi.h>
>  #include <linux/bits.h>
>  #include <linux/init.h>
> +#include <linux/kdev_t.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_profile.h>
>  #include <linux/sysfs.h>
> @@ -22,6 +23,12 @@ static const char * const profile_names[] = {
>  };
>  static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
>  
> +static DEFINE_IDA(platform_profile_ida);
> +
> +static const struct class platform_profile_class = {
> +	.name = "platform-profile",
> +};
> +
>  static ssize_t platform_profile_choices_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
> @@ -105,8 +112,25 @@ static struct attribute *platform_profile_attrs[] = {
>  	NULL
>  };
>  
> +static int profile_class_registered(struct device *dev, const void *data)
> +{
> +	return 1;
> +}
> +
> +static umode_t profile_class_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
> +{
> +	if (!class_find_device(&platform_profile_class, NULL, NULL, profile_class_registered))
> +		return 0;
> +	if (attr == &dev_attr_platform_profile_choices.attr)
> +		return 0444;
> +	if (attr == &dev_attr_platform_profile.attr)
> +		return 0644;

These two should just return attr->mode I think.

> +	return 0;

Is this even necessary for something?

-- 
 i.

> +}
> +
>  static const struct attribute_group platform_profile_group = {
> -	.attrs = platform_profile_attrs
> +	.attrs = platform_profile_attrs,
> +	.is_visible = profile_class_is_visible,
>  };
>  
>  void platform_profile_notify(struct platform_profile_handler *pprof)
> @@ -164,25 +188,77 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>  	if (cur_profile)
>  		return -EEXIST;
>  
> -	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
> -	if (err)
> -		return err;
> +	/* create class interface for individual handler */
> +	pprof->minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
> +	if (pprof->minor < 0)
> +		return pprof->minor;
> +	pprof->class_dev = device_create(&platform_profile_class, pprof->dev,
> +					 MKDEV(0, 0), pprof, "platform-profile-%d",
> +					 pprof->minor);
> +	if (IS_ERR(pprof->class_dev)) {
> +		err = PTR_ERR(pprof->class_dev);
> +		goto cleanup_ida;
> +	}
>  
>  	cur_profile = pprof;
> +
> +	err = sysfs_update_group(acpi_kobj, &platform_profile_group);
> +	if (err)
> +		goto cleanup_cur;
> +
>  	return 0;
> +
> +cleanup_cur:
> +	cur_profile = NULL;
> +	device_unregister(pprof->class_dev);
> +
> +cleanup_ida:
> +	ida_free(&platform_profile_ida, pprof->minor);
> +
> +	return err;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_register);
>  
>  int platform_profile_remove(struct platform_profile_handler *pprof)
>  {
> +	int id;
>  	guard(mutex)(&profile_lock);
>  
> -	sysfs_remove_group(acpi_kobj, &platform_profile_group);
>  	cur_profile = NULL;
> +
> +	id = pprof->minor;
> +	device_unregister(pprof->class_dev);
> +	ida_free(&platform_profile_ida, id);
> +
> +	sysfs_update_group(acpi_kobj, &platform_profile_group);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_remove);
>  
> +static int __init platform_profile_init(void)
> +{
> +	int err;
> +
> +	err = class_register(&platform_profile_class);
> +	if (err)
> +		return err;
> +
> +	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
> +	if (err)
> +		class_unregister(&platform_profile_class);
> +
> +	return err;
> +}
> +
> +static void __exit platform_profile_exit(void)
> +{
> +	sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +	class_unregister(&platform_profile_class);
> +}
> +module_init(platform_profile_init);
> +module_exit(platform_profile_exit);
> +
>  MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
>  MODULE_DESCRIPTION("ACPI platform profile sysfs interface");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 8ec0b8da56db5..a888fd085c513 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -29,6 +29,8 @@ enum platform_profile_option {
>  struct platform_profile_handler {
>  	const char *name;
>  	struct device *dev;
> +	struct device *class_dev;
> +	int minor;
>  	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>  	int (*profile_get)(struct platform_profile_handler *pprof,
>  				enum platform_profile_option *profile);
> 

