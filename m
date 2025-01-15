Return-Path: <linux-acpi+bounces-10686-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EC8A1259C
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 15:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2BF3A56BD
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 14:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D36624A7E4;
	Wed, 15 Jan 2025 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LuoP0cRg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5342143ACB;
	Wed, 15 Jan 2025 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736950182; cv=none; b=NHolMLyMRRZRStGxzHm1+vvU6CJ+0EQi6zpqWhn3U9A4E2R+JUkNT7oC3tUVl8kj4htDW+EIYF7WO+AIYRqev9/XshF7akUPUqN3pkygTd/xoD+oJpdpxFmSiUGS7fPglPMOhkm0UPdHANZAxUpedXSKw/i4HlXm/bOdG5JTf3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736950182; c=relaxed/simple;
	bh=1kVg3kAMp3gOm/sjlivJT3RcbpuT/0yvUqoPb68XgEo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LVYd8Ku3sICAP6r7Q4r52Hj/lv7JVw/3FubTp4eBY3/b8whu7yYvyY00AxPfsVEXajBCOnmVHmPtduUI+YvN0QEc74apsIzUyDxr/a2juRV7Py/l7D7xeRJv6LnNwvD0KOU98ngUK6lOGrD+8ptA076sit+Gb8G0JKrMx4yBPr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LuoP0cRg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736950180; x=1768486180;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1kVg3kAMp3gOm/sjlivJT3RcbpuT/0yvUqoPb68XgEo=;
  b=LuoP0cRgzx3uSwsViT1KYZ32OXhb/EDNjdGu1YDtTIJ7xXDgNcRu3rTs
   a5FSZLo78UBPZ6TWLqyCRCgokDqJGGQpI56Sek/pN/1IlJ3MaE1t/wuxR
   fTd0fQGe2euCpOv6dHwxJ+v1I3ah81BauZKuwpsbRvC2B2IsPFrf1dA+y
   RtV6assG+zs27nTJJ+k0opKTtsfe5Ks1C13B9ArXdp3K//tB4ipm74cAg
   KUcuWL63Jy4TPifZueulANecHlN75rGQHHQMEuDt9koO/evm3BWBsIAz4
   vPa3qRD/duM4bEPGWn7b7+dHyhLbsW8o/Q0y6yed7tS8XvQ8VavWjfUbp
   A==;
X-CSE-ConnectionGUID: XT/y0UhMREWBfZRbZvikOg==
X-CSE-MsgGUID: 2mD1KjofQfCWT6XxCGdg7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="40097077"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="40097077"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 06:08:47 -0800
X-CSE-ConnectionGUID: KgwrCvFySLC2xuCBGMPiFA==
X-CSE-MsgGUID: 5qI55X07Qhu3ZETM0UZjKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105626698"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 06:08:38 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 15 Jan 2025 16:08:35 +0200 (EET)
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
Subject: Re: [PATCH v3 09/19] platform/x86: asus-wmi: Use
 devm_platform_profile_register()
In-Reply-To: <20250115071022.4815-10-kuurtb@gmail.com>
Message-ID: <9a00d65e-01a8-007f-9918-44b21b194803@linux.intel.com>
References: <20250115071022.4815-1-kuurtb@gmail.com> <20250115071022.4815-10-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 Jan 2025, Kurt Borja wrote:

> Replace platform_profile_register() with it's device managed version.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/platform/x86/asus-wmi.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 3d77f7454953..f8437cff66df 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3895,12 +3895,12 @@ static int platform_profile_setup(struct asus_wmi *asus)
>  	asus->platform_profile_handler.dev = dev;
>  	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
>  
> -	err = platform_profile_register(&asus->platform_profile_handler, asus);
> +	err = devm_platform_profile_register(&asus->platform_profile_handler, asus);
>  	if (err == -EEXIST) {
>  		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
>  		return 0;
>  	} else if (err) {
> -		pr_err("%s, failed at platform_profile_register: %d\n", __func__, err);
> +		pr_err("%s, failed at devm_platform_profile_register: %d\n", __func__, err);

Hi,

I'm sorry I didn't notice this while passing through the patches 
yesterday.

Could you please make this error message plain english instead of piling 
even more kernel C specifics to it? Preferrably, an user seeing a kernel 
error message should not be required to know/understand any C, so don't 
print __func__ nor write function names into any error/warning/info level 
messages.

Also, it should use dev_err() I think (platform_profile_setup() seems to
mix pr_*() & dev_*() prints with no good reason).

-- 
 i.

>  		return err;
>  	}
>  
> @@ -4859,8 +4859,6 @@ static int asus_wmi_add(struct platform_device *pdev)
>  fail_sysfs:
>  fail_custom_fan_curve:
>  fail_platform_profile_setup:
> -	if (asus->platform_profile_support)
> -		platform_profile_remove(&asus->platform_profile_handler);
>  fail_fan_boost_mode:
>  fail_platform:
>  	kfree(asus);
> @@ -4886,9 +4884,6 @@ static void asus_wmi_remove(struct platform_device *device)
>  	throttle_thermal_policy_set_default(asus);
>  	asus_wmi_battery_exit(asus);
>  
> -	if (asus->platform_profile_support)
> -		platform_profile_remove(&asus->platform_profile_handler);
> -
>  	kfree(asus);
>  }
>  
> 

