Return-Path: <linux-acpi+bounces-9064-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 068109B4678
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 11:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE48E283C58
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 10:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F100C2040AF;
	Tue, 29 Oct 2024 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLIA1vDv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8C31DE3C5;
	Tue, 29 Oct 2024 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730196755; cv=none; b=fCUFrm2RNSczgSb/IVbp9HiFULhalc/82qMUM2AA2QX9+fYK61MOvOpjg17qyuZF1vags1jDRBPZQtgyeTzqI+OQwr+IWjJYChST+5PKJJ6YcolTQoCEN3HIe8b7x9TJyBiGL2SzLnrrZVXyZdGw65vnUMtwWIbuHLlxOAxpylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730196755; c=relaxed/simple;
	bh=UUL67haHwTZSyVGSKpJ3dDGaIGH82aeC1HUYikM7ht4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aSQxP994iWGqtNfsAunQAqGEdDPRol2wUghvWoxropKS43hJmcN+2ewSV6Br2dw4koJxTUNbGobx37QBA0KNJ/ceOW6FEmq8DAQrJPL9hIsmU4KVcwFaImOmyXiZRUKtHXmfmmZQ2E9veCXYj4R9eHhLp1KTokQsBWyF02l1pew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLIA1vDv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730196755; x=1761732755;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UUL67haHwTZSyVGSKpJ3dDGaIGH82aeC1HUYikM7ht4=;
  b=iLIA1vDvAx0SIHZaNv8xFHKBuQCX7n0IZQChUUviREwlvSj6Gy3wKQtK
   12l0feGsYNI+ArdEfbeLNmnOuneUo2Y8+nB9utfTz6ovYw7keqJv7SdGK
   iSLWQPredEWXBluiRHdiSRs+zQ/7DWKNxz3zSDlzHj/CPYqgj8cPFHlEj
   z3r7S7YdPzLqlBwUvDYfRKz5UXMGJx3papcHzVnDW+2cSZqe/aRDW6gkF
   9HDimuizJzp/OL/tqdybdyB91ldRhVFl7yzj6LZ6OZLWhoOqR7D3qQGwK
   TuFYD0a2FF3ZqIOABCveIT1ykVAWA1UKG/cSM3DkOgrkjJBBRpQ9btIaK
   g==;
X-CSE-ConnectionGUID: C9esSJ37S8yu6sDr7wEWtQ==
X-CSE-MsgGUID: vjzzluheQnKsv3R1av9eQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30016119"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30016119"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:12:34 -0700
X-CSE-ConnectionGUID: w2Dq1ufURcu3Uixl6B014g==
X-CSE-MsgGUID: nqgzNDGLQtOYDmPFkf90yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81546469"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:12:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 29 Oct 2024 12:12:23 +0200 (EET)
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
Subject: Re: [PATCH v2 05/15] ACPI: platform_profile: Move sanity check out
 of the mutex
In-Reply-To: <20241028020131.8031-6-mario.limonciello@amd.com>
Message-ID: <911429e0-3807-255a-4ab5-d89c6d6ce0d7@linux.intel.com>
References: <20241028020131.8031-1-mario.limonciello@amd.com> <20241028020131.8031-6-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 27 Oct 2024, Mario Limonciello wrote:

> The sanity check that the platform handler had choices set doesn't
> need the mutex taken.  Move it to earlier in the registration.
> 
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 0c60fc970b6e8..c20256bb39579 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -180,6 +180,12 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>  {
>  	int err;
>  
> +	/* Sanity check the profile handler field are set */
> +	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> +		!pprof->profile_set || !pprof->profile_get) {

While moving the line, please change the misleading indentation too 
(you'd have probably done it based on my comment on v1 too but since 
this series has changed things a bit, I'm noting it also against this 
patch).

-- 
 i.

> +		return -EINVAL;
> +	}
> +
>  	mutex_lock(&profile_lock);
>  	/* We can only have one active profile */
>  	if (cur_profile) {
> @@ -187,13 +193,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>  		return -EEXIST;
>  	}
>  
> -	/* Sanity check the profile handler field are set */
> -	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> -		!pprof->profile_set || !pprof->profile_get) {
> -		mutex_unlock(&profile_lock);
> -		return -EINVAL;
> -	}
> -
>  	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>  	if (err) {
>  		mutex_unlock(&profile_lock);
> 

