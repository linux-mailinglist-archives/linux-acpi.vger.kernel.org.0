Return-Path: <linux-acpi+bounces-9063-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9619B4667
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 11:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFABC1F218E7
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 10:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B690204091;
	Tue, 29 Oct 2024 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D/mt/1ty"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115D8187FE0;
	Tue, 29 Oct 2024 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730196404; cv=none; b=d0ozz1oiImF57m5NEciGsBjvdIOPgirWw1hBqOxku4MsNAjhLA9tzHkmRy4JblWYdaXNoegw8197WwjZfbxwpsu8eZgsSFC1T8atlpInBztSE/NfPyUKzzxATovJXM/MCXaXh/hm2UaiVulsZPaozxF3QJf2hRbRxsz/YtMTqco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730196404; c=relaxed/simple;
	bh=ALT9A3sQ5Y4md6I1DY1tRYdezpyKZu0ORjTnspRxHZI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Iw2U8ukc7qjGnpqcUgM/L4LNSAnLcmlZDfPjsBZK4kQT462Pcj13nQVuRmA1SV149PzBi+Ssy2xUK7/j78WuPEJUplsddDej+xCCD+R67O++2E1uGjdFZCRNGY0uPEArqI8tzza9UJhniO7JxBcYmYZfZDEZ4RSBZGLg0hxIo1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D/mt/1ty; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730196404; x=1761732404;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ALT9A3sQ5Y4md6I1DY1tRYdezpyKZu0ORjTnspRxHZI=;
  b=D/mt/1tyJbYsc8Fvp/cJfbOD4pB9n52/GUkor6VTDIAtJarOfeVxn2MS
   QegFrTPw7RoGXgVjWmkyfq6N2qXMMTMPu7OrZAq1wkK43O6QsAYvHY7ak
   AtLMW3GFZlLyo2s6TT6oEQ9MdikxtA82+gCa1wMAvWtSXgzKycIhQ6uYc
   Axt3vY6TmxxwYaKIWOQCUEDPya+fpJMqFN7eDd/m6f5FfHhftWIVZNZ3C
   jfJzpmoE+NaBnm0NSYjz+lp0P7w1ZqPf+IzWoQq+AtNtipRHQChAVfvCO
   Q3kVlu9anWEpCM6YvbIXvTmijuRVADtWWnYTQUe618+4bvWb41TKlyKF/
   g==;
X-CSE-ConnectionGUID: ZbihmPPsQGWdWxO8jXCwww==
X-CSE-MsgGUID: GubRRJv6RvOK6FvTBagjAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29966971"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29966971"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:06:43 -0700
X-CSE-ConnectionGUID: /ByS0/uCSJyNAfrJ3/2dmg==
X-CSE-MsgGUID: fIHuh1rVR6O5/pjdIVrJRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82237442"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:06:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 29 Oct 2024 12:06:33 +0200 (EET)
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
Subject: Re: [PATCH 6/8] ACPI: platform_profile: Only remove group when no
 more handler registered
In-Reply-To: <20241025193055.2235-7-mario.limonciello@amd.com>
Message-ID: <2816f1b2-b6ea-05eb-f2ce-a0c07093f146@linux.intel.com>
References: <20241025193055.2235-1-mario.limonciello@amd.com> <20241025193055.2235-7-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 25 Oct 2024, Mario Limonciello wrote:

> As multiple handlers may register for ACPI platform profile handler,
> only remove the sysfs group when the last one unregisters.
> 
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 81928adccfade..091ca6941a925 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -23,6 +23,15 @@ static const char * const profile_names[] = {
>  };
>  static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
>  
> +static bool platform_profile_is_registered(void)
> +{
> +	struct list_head *pos;
> +	int count = 0;
> +	list_for_each(pos, &platform_profile_handler_list)
> +		count++;
> +	return count > 0;

return !list_empty(&platform_profile_handler_list) ?

> +}
> +
>  static ssize_t platform_profile_choices_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
> @@ -206,8 +215,10 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
>  
>  	list_del(&pprof->list);
>  
> -	sysfs_remove_group(acpi_kobj, &platform_profile_group);
>  	cur_profile = NULL;
> +	if (!platform_profile_is_registered())
> +		sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_remove);
> 

-- 
 i.


