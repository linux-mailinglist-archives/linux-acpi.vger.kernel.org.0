Return-Path: <linux-acpi+bounces-9700-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5323A9D3EC3
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 16:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E26F1F253E5
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 15:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5121CB526;
	Wed, 20 Nov 2024 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBiwH0sN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825FE1AA1DC;
	Wed, 20 Nov 2024 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732115393; cv=none; b=YwrjAy+/v9C8LMYdp5uthrQjw1alsnohGRXSuC6/Pik0U819X8xN3MyRZ8X8545HPje5lxPz+rTke5E5W/is490VA1p8xkJRll69Or8GZKMo13WNQuO0lzg9PXdIwiNisUiPbYGCYgdfhCQTO9vTklfPcT1zh81OYf9GzubjeDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732115393; c=relaxed/simple;
	bh=ZAldjlSxwzzvH0PYhiji31OD13HJA6bDZY9dPRf3qSU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=D0UBiu5Bx2x3JptJYpguUaZVQUctl1SqxsShEYO9BDchCpOaw90e6tH5KgBsqPqkaMH6z+F2/xhnXy+4eYy6X6DbGqFH9i48Mbxbwq3Vgog87Ae7g4xt0Ha6shdtbxxN4J6atlRERQoCWMZjeQy2sAHPgBqmFOVXjlTzU6iJZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VBiwH0sN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732115392; x=1763651392;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZAldjlSxwzzvH0PYhiji31OD13HJA6bDZY9dPRf3qSU=;
  b=VBiwH0sNdbPMA/+hV9xitMJ49c5uBOJuh9aP0RXiKgP9am80dm8hWcof
   5mhZ/5R4iDw5RGhMAnZZaKB6yuMZfmALEYMs2nI2BlFsHKkwXlSxTD8E+
   msjPsz2J7V1rrjxxjPnQEP+E/mjX5yQLLvXcHOX334OeM4v3dDNCwUmwh
   GiMTCqD0DXKc25r6Igg9T3ojqqb2hishg3fpGRWyUhlt8cBsvByGfgUgI
   pr4qy3kV4jZodtYGZWyoQn99HCloIVaH+uwncCrsPf8c0zIBJkFpOoP2M
   l9+88aaw53QksqDwNk8JfKxuB2LdLWu22OLk6tgK2uCMUViNYFVgaFX+G
   g==;
X-CSE-ConnectionGUID: f+AhHM6QTb2aoy1f4ohwpA==
X-CSE-MsgGUID: pCwoLP7BSDeEYlDf5uYqLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="32429772"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="32429772"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 07:09:46 -0800
X-CSE-ConnectionGUID: 8dbZfYckSkKBBQ5sRHkv+Q==
X-CSE-MsgGUID: qZMsLm4qR3WdVIWSEKEQgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="90107921"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.15])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 07:09:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 20 Nov 2024 17:09:36 +0200 (EET)
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
Subject: Re: [PATCH v7 14/22] ACPI: platform_profile: Notify change events
 on register and unregister
In-Reply-To: <20241119171739.77028-15-mario.limonciello@amd.com>
Message-ID: <31d48b10-87e1-1064-b25a-71f55736e504@linux.intel.com>
References: <20241119171739.77028-1-mario.limonciello@amd.com> <20241119171739.77028-15-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 19 Nov 2024, Mario Limonciello wrote:

> As multiple platform profile handlers may come and go, send a notification
> to userspace each time that a platform profile handler is registered or
> unregistered.
> 
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v7:
>  * Add Armin's tag
> ---
>  drivers/acpi/platform_profile.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 1530e6096cd39..de0804305b02c 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -363,6 +363,8 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>  		goto cleanup_ida;
>  	}
>  
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +
>  	cur_profile = pprof;
>  
>  	err = sysfs_update_group(acpi_kobj, &platform_profile_group);

Is the ordering problematic here, how long userspace has to wait for the 
update to become visible?

> @@ -393,6 +395,8 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
>  	device_unregister(pprof->class_dev);
>  	ida_free(&platform_profile_ida, id);
>  
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +
>  	sysfs_update_group(acpi_kobj, &platform_profile_group);


-- 
 i.


