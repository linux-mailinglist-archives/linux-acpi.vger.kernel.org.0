Return-Path: <linux-acpi+bounces-10629-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7C6A10CD6
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 17:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECD01612F5
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9731CAA7C;
	Tue, 14 Jan 2025 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khAUWzwR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E51C4617;
	Tue, 14 Jan 2025 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873844; cv=none; b=uR4WK9hxIRdIYcqfon+8misedEVrD3HnP9Fky2LC6UQgxiw66vwtI8gRe5o1ub+ihwv4eVyg+K+pDNUiJvIl7fRxKalm7bBZ+n5nJNDxb2zSCK7c2pJQpKNfmz4jhXH5oKGLpn/cdch2BnIMdSbjuSEci8t9dF9qo6ZyGgrGiEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873844; c=relaxed/simple;
	bh=BGR7gp3P1T6LTIpZ0AhjdKM+0EyL1mGRxJjubaWlvVE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tio6xDayoianKwlpSfeX6JcR7z9YJWry4C2azAUWs3e1EOm6Q6OstyAKMbqaPTH1Atuj/vAwq1zezN8jGDKzCEV8r5iJWPT+2vinvIuSFwr9K8zcBovameTZOp2fgo6OOlHDLO+CFeyUuAARLCrtGphl6PqftQrNptrsIfNqrsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khAUWzwR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736873843; x=1768409843;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BGR7gp3P1T6LTIpZ0AhjdKM+0EyL1mGRxJjubaWlvVE=;
  b=khAUWzwR5/rc/NeiGDkh7zLTtqb4Qu/1H+VePUzzDKmDPJ0Hdd9SOXXy
   XSfSjo0Fb7oXVXOpdAm/du0hEvUNAXxUwPnrm5GeFtNfRWeYT2hgFw5En
   YbJ2WypTXw1Ydfx39lY5iHJJrTNX2wLf/Gxu6wPsEL3fdrB/7f7fYazrm
   oeAJcjwjw7B6RipYlkhcr25XYeB6qNsCFZvRO2mHX6RPFYRboB7LCfZK/
   wX++cfY484msgURCzw50nL0ij4xkGCgKE6US2CoabdKoEPWq19GE/+rWm
   7V8HSEl31Rq968697dy728t/MapfmbetQWzCoPpQ3fQ+oClmK5TZ4QhoI
   A==;
X-CSE-ConnectionGUID: 3wtvQJjxS9O/LkF23fHFWQ==
X-CSE-MsgGUID: /YkKIwBuSIS51+/f1sID5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37095406"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="37095406"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:57:22 -0800
X-CSE-ConnectionGUID: +oiblfeeS9O5N8NAdpNipw==
X-CSE-MsgGUID: C2HJmBnaQUOp7g/pmJtkkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="104613573"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:57:14 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 14 Jan 2025 18:57:11 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: platform-driver-x86@vger.kernel.org, 
    "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>, 
    Joshua Grisham <josh@joshuagrisham.com>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Maximilian Luz <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D. Jones" <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>, 
    Ike Panhc <ike.pan@canonical.com>, 
    Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Alexis Belmonte <alexbelm48@gmail.com>, Ai Chao <aichao@kylinos.cn>, 
    Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com, 
    ibm-acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 18/18] ACPI: platform_profile: Add documentation
In-Reply-To: <20250114153726.11802-19-kuurtb@gmail.com>
Message-ID: <0e10985e-2400-daee-00a9-3a6156214b3e@linux.intel.com>
References: <20250114153726.11802-1-kuurtb@gmail.com> <20250114153726.11802-19-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 14 Jan 2025, Kurt Borja wrote:

> Add kerneldoc and sysfs class documentation.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  .../ABI/testing/sysfs-class-platform-profile  | 44 +++++++++++++++++++
>  drivers/acpi/platform_profile.c               | 33 ++++++++++++++
>  include/linux/platform_profile.h              | 24 ++++++++++
>  3 files changed, 101 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-platform-profile
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/Documentation/ABI/testing/sysfs-class-platform-profile
> new file mode 100644
> index 000000000000..b5a3600080bc
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-platform-profile
> @@ -0,0 +1,44 @@
> +What:		/sys/class/platform-profile/platform-profile-X/name
> +Date:		January 2025
> +Description:	Name of the class device given by the driver.
> +
> +		RO
> +
> +What:		/sys/class/platform-profile/platform-profile-X/choices
> +Date:		January 2025
> +Description:	This file contains a space-separated list of profiles supported for this device.
> +
> +		Drivers must use the following standard profile-names:
> +
> +		====================	========================================
> +		low-power		Low power consumption
> +		cool			Cooler operation
> +		quiet			Quieter operation
> +		balanced		Balance between low power consumption
> +					and performance
> +		balanced-performance	Balance between performance and low
> +					power consumption with a slight bias
> +					towards performance
> +		performance		High performance operation
> +		custom			Driver defined custom profile
> +		====================	========================================
> +
> +		RO
> +
> +What:		/sys/class/platform-profile/platform-profile-X/profile
> +Date:		January 2025
> +Description:	Reading this file gives the current selected profile for this
> +		device. Writing this file with one of the strings from
> +		platform_profile_choices changes the profile to the new value.
> +
> +		This file can be monitored for changes by polling for POLLPRI,
> +		POLLPRI will be signaled on any changes, independent of those
> +		changes coming from a userspace write; or coming from another
> +		source such as e.g. a hotkey triggered profile change handled
> +		either directly by the embedded-controller or fully handled
> +		inside the kernel.
> +
> +		This file may also emit the string 'custom' to indicate
> +		that the driver is using a driver defined custom profile.
> +
> +		RW
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index c44989801f8e..9caddac695b8 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -426,6 +426,10 @@ static const struct attribute_group platform_profile_group = {
>  	.is_visible = profile_class_is_visible,
>  };
>  
> +/**
> + * platform_profile_notify - Notify class device and legacy sysfs interface
> + * @dev: The class device
> + */
>  void platform_profile_notify(struct device *dev)
>  {
>  	scoped_cond_guard(mutex_intr, return, &profile_lock) {
> @@ -435,6 +439,11 @@ void platform_profile_notify(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_notify);
>  
> +/**
> + * platform_profile_cycle - Cycles profiles available on all registered class devices
> + *
> + * Return: 0 on success, -errno on failure
> + */
>  int platform_profile_cycle(void)
>  {
>  	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
> @@ -478,6 +487,15 @@ int platform_profile_cycle(void)
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_cycle);
>  
> +/**
> + * platform_profile_register - Creates and registers a platform profile class device
> + * @dev: Parent device
> + * @name: Name of the class device
> + * @drvdata: Driver data that will be attached to the class device
> + * @ops: Platform profile's mandatory operations
> + *
> + * Return: pointer to the new class device on success, ERR_PTR on failure
> + */
>  struct device *platform_profile_register(struct device *dev, const char *name,
>  					 void *drvdata,
>  					 const struct platform_profile_ops *ops)
> @@ -544,6 +562,12 @@ struct device *platform_profile_register(struct device *dev, const char *name,
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_register);
>  
> +/**
> + * platform_profile_remove - Unregisters a platform profile class device
> + * @dev: Class device
> + *
> + * Return: 0
> + */
>  int platform_profile_remove(struct device *dev)
>  {
>  	struct platform_profile_handler *pprof = to_pprof_handler(dev);
> @@ -569,6 +593,15 @@ static void devm_platform_profile_release(struct device *dev, void *res)
>  	platform_profile_remove(*ppdev);
>  }
>  
> +/**
> + * devm_platform_profile_register - Device managed version of platform_profile_register
> + * @dev: Parent device
> + * @name: Name of the class device
> + * @drvdata: Driver data that will be attached to the class device
> + * @ops: Platform profile's mandatory operations
> + *
> + * Return: pointer to the new class device on success, ERR_PTR on failure
> + */
>  struct device *devm_platform_profile_register(struct device *dev, const char *name,
>  					      void *drvdata,
>  					      const struct platform_profile_ops *ops)
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index eea1daf85616..eb4dc85dc18c 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -28,6 +28,30 @@ enum platform_profile_option {
>  	PLATFORM_PROFILE_LAST, /*must always be last */
>  };
>  
> +/**
> + * struct platform_profile_ops - platform profile operations
> + * @probe:	Callback to setup choices available to the new class device.
> + *		Parameters are:
> + *		@drvdata: drvdata pointer passed to platform_profile_register.
> + *		@choices: Empty choices bitmap which the driver has to manually
> + *			  setup, by using set_bit() in bits corresponding to
> + *			  platform_profile_option values. These values will only
> + *			  be enforced when a new profile is selected from
> + *			  user-space.
> + * @profile_get: Callback that will be called when showing the current platform
> + *		 profile.
> + *		 Parameters are:
> + *		 @dev: Class device.
> + *		 @profile: Pointer to the profile which will be read from
> + *			   user-space. Selected choices are not enforced when
> + *			   modifying this value.
> + * @profile_set: Callback that will be called when storing the new platform
> + *		 profile.
> + *		 Parameters are:
> + *		 @dev: Class device.
> + *		 @profile: New platform profile to be set. Guaranteed to be a
> + *			   value selected in the @probe callback.

Does kerneldoc render this sensibly?

> + */
>  struct platform_profile_ops {
>  	int (*probe)(void *drvdata, unsigned long *choices);
>  	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
> 

-- 
 i.


