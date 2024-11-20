Return-Path: <linux-acpi+bounces-9699-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEDE9D3E95
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 16:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2133A1F269DE
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 15:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E64B1D8DE1;
	Wed, 20 Nov 2024 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cC0Y/B23"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C34C1C4A3C;
	Wed, 20 Nov 2024 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114623; cv=none; b=MrRt4enQzJ5uSPtB28E3vpUedtOcvenMwsF9jsPp9rRRpWiJfo1sxT28i3+V9TU7hUmuR8wb1l9pmA5Wulx6U7VrG6wZiwiitN+OhNSADF2jOwR74hPZHQjtIwGtyia5KJmP6kGuvW5Ple5PQ5NP4MemhB4cgsNiVBbas8TUrs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114623; c=relaxed/simple;
	bh=wetaeUzQPiT6pjBtLDIE7JUZiPyegKlKOWgtNaRS/7g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HqV3NbsFSANqH76NxGCbJx63Jev0DvK9ISik/mbU4nmyN56XElkldua7nloOQ0LDt386gQxI0c/LOB0bfC8ONHIEZ8N5uPuUeCnNouYg/QM01Ai3E0lOZtWoLeK5BgAjUDmMKyTPZaqx2j7FQput82tyF2YJXwqPYDJc0XrXfNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cC0Y/B23; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732114622; x=1763650622;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wetaeUzQPiT6pjBtLDIE7JUZiPyegKlKOWgtNaRS/7g=;
  b=cC0Y/B23GprC1tIIXLIK/1Z6+9e1LA32eaEyvMt0baPBuH9dfmGp6bjl
   SrLmYXeWIjth+Djij273Xr7SIrZ0xDWeubgDQtEZ8mJerQzwvZCoq2LfA
   l5oCFFtlw8BflEdvR8h1mgiyk0nBm68izm6yzsF1xNwAp92HaIB9mF24j
   PYGClKdm7BM29TY5+Yl9tBXcSs3Ekvwj50TFXQmGf3DeZ6htcvEH58ng2
   AOxRzSMPTfepWCRLrY1xJxn+nqxfj4/WkcftHBc+o+y5rA+lGfMVEVT64
   ATcf97jrGXQEN5G1LNWpPoppSJGa1JK9m8/ETQeEL8sjnQxcXwi8Noc8V
   A==;
X-CSE-ConnectionGUID: CNjZ26S0TfuEw7raVHJnRQ==
X-CSE-MsgGUID: 4AvoKDH0Q+C9bv2BsbhSzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="42689295"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="42689295"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 06:57:00 -0800
X-CSE-ConnectionGUID: 7xbMxUtvQTu1psqEeTwTkg==
X-CSE-MsgGUID: op+9Czp1TfSbzZsNItd5Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="94405691"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.15])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 06:56:52 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 20 Nov 2024 16:56:46 +0200 (EET)
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
    Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: Re: [PATCH v7 13/22] ACPI: platform_profile: Add profile attribute
 for class interface
In-Reply-To: <20241119171739.77028-14-mario.limonciello@amd.com>
Message-ID: <afff4d12-b611-68f0-07a0-2d22bc57fc06@linux.intel.com>
References: <20241119171739.77028-1-mario.limonciello@amd.com> <20241119171739.77028-14-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 19 Nov 2024, Mario Limonciello wrote:

> Reading and writing the `profile` sysfs file will use the callbacks for
> the platform profile handler to read or set the given profile.
> 
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v7:
>  * Remove extra handler set
>  * Remove err variable
> v6:
>  * Fix return
> v5:
>  * Drop recovery flow
>  * Don't get profile before setting (not needed)
>  * Simplify casting for call to _store_class_profile()
>  * Only notify legacy interface of changes
>  * Adjust mutex use
> ---
>  drivers/acpi/platform_profile.c | 100 ++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 9d6ead043994c..1530e6096cd39 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -46,6 +46,52 @@ static ssize_t _commmon_choices_show(unsigned long *choices, char *buf)
>  	return len;
>  }
>  
> +/**
> + * _store_class_profile - Set the profile for a class device
> + * @dev: The class device
> + * @data: The profile to set
> + */
> +static int _store_class_profile(struct device *dev, void *data)
> +{
> +	struct platform_profile_handler *handler;
> +	int *i = (int *)data;

I don't like using "i" as the variable name for this.

> +	lockdep_assert_held(&profile_lock);
> +	handler = dev_get_drvdata(dev);
> +	if (!test_bit(*i, handler->choices))
> +		return -EOPNOTSUPP;
> +
> +	return handler->profile_set(handler, *i);
> +}
> +
> +/**
> + * get_class_profile - Show the current profile for a class device
> + * @dev: The class device
> + * @profile: The profile to return
> + * Return: 0 on success, -errno on failure
> + */
> +static int get_class_profile(struct device *dev,
> +			     enum platform_profile_option *profile)
> +{
> +	struct platform_profile_handler *handler;
> +	enum platform_profile_option val;
> +	int err;
> +
> +	lockdep_assert_held(&profile_lock);
> +	handler = dev_get_drvdata(dev);
> +	err = handler->profile_get(handler, &val);
> +	if (err) {
> +		pr_err("Failed to get profile for handler %s\n", handler->name);
> +		return err;
> +	}
> +
> +	if (WARN_ON(val >= PLATFORM_PROFILE_LAST))
> +		return -EINVAL;
> +	*profile = val;
> +
> +	return 0;
> +}
> +
>  /**
>   * name_show - Show the name of the profile handler
>   * @dev: The device
> @@ -77,12 +123,66 @@ static ssize_t choices_show(struct device *dev,
>  	return _commmon_choices_show(handler->choices, buf);
>  }
>  
> +/**
> + * profile_show - Show the current profile for a class device
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to write to
> + * Return: The number of bytes written
> + */
> +static ssize_t profile_show(struct device *dev,
> +			    struct device_attribute *attr,
> +			    char *buf)
> +{
> +	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
> +	int err;
> +
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		err = get_class_profile(dev, &profile);
> +		if (err)
> +			return err;
> +	}
> +
> +	return sysfs_emit(buf, "%s\n", profile_names[profile]);
> +}
> +
> +/**
> + * profile_store - Set the profile for a class device
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to read from
> + * @count: The number of bytes to read
> + * Return: The number of bytes read
> + */
> +static ssize_t profile_store(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t count)
> +{
> +	int i, ret;
> +
> +	i = sysfs_match_string(profile_names, buf);

Please consider if there's a better name for the variable.

> +	if (i < 0)
> +		return -EINVAL;
> +
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		ret = _store_class_profile(dev, &i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +
> +	return count;
> +}
> +
>  static DEVICE_ATTR_RO(name);
>  static DEVICE_ATTR_RO(choices);
> +static DEVICE_ATTR_RW(profile);
>  
>  static struct attribute *profile_attrs[] = {
>  	&dev_attr_name.attr,
>  	&dev_attr_choices.attr,
> +	&dev_attr_profile.attr,

I started to wonder if "choices" is good name for the other attribute as 
it is the set of values "profile" accepts? Should they be bound by the 
naming too like "profile_choices" or something along those lines so the
connection between the two is very evident?

>  	NULL
>  };
>  ATTRIBUTE_GROUPS(profile);
> 

-- 
 i.


