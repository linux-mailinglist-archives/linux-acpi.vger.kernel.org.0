Return-Path: <linux-acpi+bounces-9065-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEF49B4697
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 11:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63941C2277B
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 10:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60B9204940;
	Tue, 29 Oct 2024 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlOIkEkr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9642040AF;
	Tue, 29 Oct 2024 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197165; cv=none; b=ZUxwVvMIthCg1Qlt185yicQzs0js3ntcOEg92oBdXv+B9+hkuVsYGiYi47/Z2c3qM1QQZlzMyjgF2QXfnwricfjKuHg0FYZF/OmltY89/mqyPi807efCKOPfoXRTf0X+T7GxEqJYRfzXi0i7tEst9XIv7EHtceuB8kZ4qagGvD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197165; c=relaxed/simple;
	bh=8V4WvgcLNuSoQRWTHRweFocRSePOA443q+/L1tVEszo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KOmPcLyl+gk7klZzW4xJTQVA4aBe3hF2EuLAjdiBFnGi7Ik7xQNphkBEaPFrr0wA8/bdybaXPyTsQR+1lF5jWma+j+I2e038flei79UadKK74qyw5dubpUXuRqZG+5cbE3YQTIH4aLIioBp6xGnsPx4T8V0ExGDu2kP54iBQz9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlOIkEkr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730197164; x=1761733164;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8V4WvgcLNuSoQRWTHRweFocRSePOA443q+/L1tVEszo=;
  b=nlOIkEkrREooJ4OXG7s5H0tIvtBNNA4H7Y1JJqFMA9wh8BIjumyZMXap
   0aRu6cuT4VIPHgj2CQLAGXVl8DbWG97it4iYPg5hOcKuThBfZrsOzTaEi
   9UJpnfM0k2yQ94ok0j1Q0YRVTWSmJztDXhgvYmKxMmmK/uo5gW4K3G3aC
   SrNaD4pAoqPCAhZDwtjXHVuqMXN/Xwn7lJWVc98x7BDfFEe+KBVZlVrqp
   ZvCGIPEZzPFSrlI/J96QxoK+LkX5eZ6tcV4ubuGLreX7oGA5CkwtKPAZd
   gdoza757fqBMRmfkBn4b1FflmeNmfX1PjjQ3+YS0gooqizo+/PDke4SPW
   Q==;
X-CSE-ConnectionGUID: y2D3qBfkRt6WdNB1mlnh1w==
X-CSE-MsgGUID: uU/9AgGRRtKHDdyFB/iDnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33528075"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33528075"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:19:23 -0700
X-CSE-ConnectionGUID: 7IuxUBGfSCK02rznI4fCyg==
X-CSE-MsgGUID: vFD5fuVPTY63vzcRc4pROA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="87047293"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:19:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 29 Oct 2024 12:19:13 +0200 (EET)
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
Subject: Re: [PATCH v2 10/15] ACPI: platform_profile: Only show profiles
 common for all handlers
In-Reply-To: <20241028020131.8031-11-mario.limonciello@amd.com>
Message-ID: <031cacd1-02a5-b411-7ecf-287d45883192@linux.intel.com>
References: <20241028020131.8031-1-mario.limonciello@amd.com> <20241028020131.8031-11-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 27 Oct 2024, Mario Limonciello wrote:

> If multiple platform profile handlers have been registered, don't allow
> switching to profiles unique to only one handler.
> 
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 35 ++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 5fee467614eac..a83842f05022b 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -33,30 +33,43 @@ static bool platform_profile_is_registered(void)
>  	return count > 0;
>  }
>  
> +/* expected to be called under mutex */
> +static unsigned long platform_profile_get_choices(void)
> +{
> +	struct platform_profile_handler *handler;
> +	unsigned long seen = 0;
> +	int i;
> +
> +	list_for_each_entry(handler, &platform_profile_handler_list, list) {
> +		for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST) {
> +			if (seen & BIT(i))
> +				continue;
> +			seen |= BIT(i);

The condition+continue part seems unnecessary if all this function does is 
accumulate bits into seen.

-- 
 i.

> +		}
> +	}
> +
> +	return seen;
> +}
> +
>  static ssize_t platform_profile_choices_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
>  {
> +	unsigned long choices;
>  	int len = 0;
> -	int err, i;
> -
> -	err = mutex_lock_interruptible(&profile_lock);
> -	if (err)
> -		return err;
> +	int i;
>  
> -	if (!cur_profile) {
> -		mutex_unlock(&profile_lock);
> -		return -ENODEV;
> -	}
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock)
> +		choices = platform_profile_get_choices();
> -	for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
> +	for_each_set_bit(i, &choices, PLATFORM_PROFILE_LAST) {
>  		if (len == 0)
>  			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
>  		else
>  			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
>  	}
> +
>  	len += sysfs_emit_at(buf, len, "\n");
> -	mutex_unlock(&profile_lock);
>  	return len;
>  }
>  
> 

