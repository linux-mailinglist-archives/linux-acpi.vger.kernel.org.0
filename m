Return-Path: <linux-acpi+bounces-9067-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F589B4721
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 11:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17256B21F7F
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 10:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80BC204934;
	Tue, 29 Oct 2024 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edmfA/gn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8561DF985;
	Tue, 29 Oct 2024 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198612; cv=none; b=mrSKsv4B6kigbJ7NM7eS7D84CttdZRlavTshJlvMK1FEsWrOcO5eCsyogv1kvsu+8JEUP33VILyHR0aecBxgPZWlAyXlWcIZOUqTuB1RRE2XQBIJzxxAVL6iYgH4lA6zKkbb4qOfh4TnHa+ye+VmwhnMbFK7Xe0fIElXn/OKWxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198612; c=relaxed/simple;
	bh=fCHg+USXVzv55vvKlBlous6qKMSJtzt3sWEWLEln7lo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Gj/ADwxKFRtjYzZA8KbaAjaMMfNx4YE1RFhI5CWFX2SYHZejWE5SG+KuIWxf+vPQ9L16zVsBfuvpHwlPH05yjfKNz+bS4VFHgh+wLH6/FbcMEC6ebf1TKb76uwEfm5VKGF+WYPkFQjFhcoTw9sJY7CvtqJkMx/NVWAwM134FDh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edmfA/gn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730198610; x=1761734610;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fCHg+USXVzv55vvKlBlous6qKMSJtzt3sWEWLEln7lo=;
  b=edmfA/gntf2g6KWQEMVxwrR9rOD2oSwTzHrezLiYHcxGYvgFtcKJPij5
   GohiAS5/0DkIBBzkPt5VVFBfIyO0Pgav8Q3bcXNjFkgIB80QtomMcMSF3
   8jeN4EqSUmy7hvtGw6MjHG68G6SsY6+P3VQ4+l7nxkzT1AYT/R7mp2SeL
   SY9N88nlG21qQSzx2iTqyXBCNMDe7BQ7+/M/zyN0PwBAGeqAx/sM9KnQx
   /MyZ4cKNV+dqIYC7DhnjPUATCOex5BFdtLQy6OPSbrWETTKaDsgw4UUR1
   0WlEAnGdvIujab+bscN3HYiXKoOxk6Blk+P3tYZ0ehiYi2S9THuzl6OFL
   A==;
X-CSE-ConnectionGUID: kQ/OR1LBR3mVwhSErYY0KQ==
X-CSE-MsgGUID: jeFiTvfKSHqvGYgBqH74Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29938249"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29938249"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:43:29 -0700
X-CSE-ConnectionGUID: hwa4kfISQk2Yt3IyfJj9SQ==
X-CSE-MsgGUID: uuHoB4mXT4eVdpxNbr9g8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="105263664"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:43:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 29 Oct 2024 12:43:18 +0200 (EET)
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
Subject: Re: [PATCH v2 12/15] ACPI: platform_profile: Make sure all profile
 handlers agree on profile
In-Reply-To: <20241028020131.8031-13-mario.limonciello@amd.com>
Message-ID: <4eaa085a-3cc8-b359-9f70-c4a6b7742389@linux.intel.com>
References: <20241028020131.8031-1-mario.limonciello@amd.com> <20241028020131.8031-13-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 27 Oct 2024, Mario Limonciello wrote:

> If for any reason multiple profile handlers don't agree on the profile
> set for the system then the value shown in sysfs can be wrong.
> 
> Explicitly check that they match.
> 
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 61 ++++++++++++++++++++++++---------
>  1 file changed, 45 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index db2ebd0393cf7..d22c4eb5f0c36 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -51,6 +51,45 @@ static unsigned long platform_profile_get_choices(void)
>  	return seen;
>  }
>  
> +/* expected to be called under mutex */

Don't add comments like this but enforce it with a lockdep annotation.

"mutex" would have been too vague anyway :-).

> +static int platform_profile_get_active(enum platform_profile_option *profile)
> +{
> +	struct platform_profile_handler *handler;
> +	enum platform_profile_option active = PLATFORM_PROFILE_LAST;
> +	enum platform_profile_option active2 = PLATFORM_PROFILE_LAST;
> +	int err;
> +
> +	list_for_each_entry(handler, &platform_profile_handler_list, list) {
> +		if (active == PLATFORM_PROFILE_LAST)
> +			err = handler->profile_get(handler, &active);
> +		else
> +			err = handler->profile_get(handler, &active2);
> +		if (err) {
> +			pr_err("Failed to get profile for handler %s\n", handler->name);
> +			return err;
> +		}
> +
> +		if (WARN_ON(active == PLATFORM_PROFILE_LAST))
> +			return -EINVAL;
> +		if (active2 == PLATFORM_PROFILE_LAST)
> +			continue;
> +
> +		if (active != active2) {
> +			pr_warn("Profile handlers don't agree on current profile\n");
> +			return -EINVAL;
> +		}
> +		active = active2;

This looked very confusing (IMO). How about this:

	enum platform_profile_option active = PLATFORM_PROFILE_LAST;
	enum platform_profile_option val;
	...

		err = handler->profile_get(handler, &val);
		if (err) {
			pr_err(...);
			return err;
		}

		if (WARN_ON(val == PLATFORM_PROFILE_LAST))
			return -EINVAL;

		if (active != val && active != PLATFORM_PROFILE_LAST) {
			pr_warn("Profile handlers don't agree on current profile\n");
			return -EINVAL;
		}
		active = val;

> +	}
> +
> +	/* Check that profile is valid index */
> +	if (WARN_ON((active < 0) || (active >= ARRAY_SIZE(profile_names))))

What does that < 0 check do? Should it be checked right after reading 
profile_get()? Or perhaps check both of these right there?

> +		return -EIO;
> +
> +	*profile = active;
> +
> +	return 0;
> +}
> +
>  static ssize_t platform_profile_choices_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
> @@ -80,24 +119,14 @@ static ssize_t platform_profile_show(struct device *dev,
>  	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
>  	int err;
>  
> -	err = mutex_lock_interruptible(&profile_lock);
> -	if (err)
> -		return err;
> -
> -	if (!cur_profile) {
> -		mutex_unlock(&profile_lock);
> -		return -ENODEV;
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {

scoped_cond_guard() conversion should be made in the guard patch?

> +		if (!platform_profile_is_registered())
> +			return -ENODEV;
> +		err = platform_profile_get_active(&profile);
> +		if (err)
> +			return err;
>  	}
>  
> -	err = cur_profile->profile_get(cur_profile, &profile);
> -	mutex_unlock(&profile_lock);
> -	if (err)
> -		return err;
> -
> -	/* Check that profile is valid index */
> -	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
> -		return -EIO;
> -
>  	return sysfs_emit(buf, "%s\n", profile_names[profile]);
>  }
>  
> 

-- 
 i.


