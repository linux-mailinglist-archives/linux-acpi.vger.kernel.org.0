Return-Path: <linux-acpi+bounces-1255-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701497E21A3
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 13:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0717B20B0E
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 12:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41352250F9
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKnP2KpF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831B21EB4E;
	Mon,  6 Nov 2023 12:27:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4910897;
	Mon,  6 Nov 2023 04:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699273670; x=1730809670;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PoyeCM8Yua9sK4/tet7vyzbQ1ABy9+K2hq4FnkLDYA4=;
  b=cKnP2KpFLLMJJKrdz+6QZytwKMn7Zf0kw/UbFcFJDKNfkcJDrCHQUv8Z
   zeZfual7aBC1ow7GaclAfJ4zFlMCwPvKrzCMw4Fpw9UaMhUluvcACziBP
   CQ0qt3tAeKik9dPQ7mch0J4MSdcguQdg/9axARS9vh9tcQCArRpCs5MUm
   dFhso6FLRYc6STibv21SzOmwOhQdTv9Z71iLsm4xg98NlwLZaUigbkvTV
   qmvhEUOk0IZ51y/eEKDD1LOz8x6iGOjmxBaWcJoC1BKff3NK4iEKailO3
   UkceOIdot4kOOSdeszaaX7aVNgm5aOAcz99wa1a2JCT0hxEp9cPqkgLuk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="368600078"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="368600078"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 04:27:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="765937251"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="765937251"
Received: from rmstoi-mobl.ger.corp.intel.com ([10.251.216.76])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 04:27:42 -0800
Date: Mon, 6 Nov 2023 14:27:39 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
    Alex Deucher <alexander.deucher@amd.com>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Hans de Goede <hdegoede@redhat.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Lukas Wunner <lukas@wunner.de>, Danilo Krummrich <dakr@redhat.com>, 
    David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
    Xinhui Pan <Xinhui.Pan@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
    Mark Gross <markgross@kernel.org>, 
    Andreas Noever <andreas.noever@gmail.com>, 
    Michael Jamet <michael.jamet@intel.com>, 
    Yehezkel Bernat <YehezkelShB@gmail.com>, 
    =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>, 
    =?ISO-8859-15?Q?Marek_Beh=FAn?= <kabel@kernel.org>, 
    "Maciej W . Rozycki" <macro@orcam.me.uk>, 
    Manivannan Sadhasivam <mani@kernel.org>, 
    "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" <dri-devel@lists.freedesktop.org>, 
    "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" <nouveau@lists.freedesktop.org>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
    "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
    "open list:ACPI" <linux-acpi@vger.kernel.org>, 
    "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, 
    "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 2/9] drm/radeon: Switch from pci_is_thunderbolt_attached()
 to dev_is_removable()
In-Reply-To: <20231103190758.82911-3-mario.limonciello@amd.com>
Message-ID: <71a39188-2caf-58a-1094-4773e88c111b@linux.intel.com>
References: <20231103190758.82911-1-mario.limonciello@amd.com> <20231103190758.82911-3-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 3 Nov 2023, Mario Limonciello wrote:

> pci_is_thunderbolt_attached() only works for Intel TBT devices. Switch to
> using dev_is_removable() to be able to detect USB4 devices as well.

Same here as with 1/9.

-- 
 i.

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/radeon/radeon_device.c | 4 ++--
>  drivers/gpu/drm/radeon/radeon_kms.c    | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index afbb3a80c0c6..ba0ca0694d18 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -1429,7 +1429,7 @@ int radeon_device_init(struct radeon_device *rdev,
>  
>  	if (rdev->flags & RADEON_IS_PX)
>  		runtime = true;
> -	if (!pci_is_thunderbolt_attached(rdev->pdev))
> +	if (!dev_is_removable(&rdev->pdev->dev))
>  		vga_switcheroo_register_client(rdev->pdev,
>  					       &radeon_switcheroo_ops, runtime);
>  	if (runtime)
> @@ -1519,7 +1519,7 @@ void radeon_device_fini(struct radeon_device *rdev)
>  	radeon_bo_evict_vram(rdev);
>  	radeon_audio_component_fini(rdev);
>  	radeon_fini(rdev);
> -	if (!pci_is_thunderbolt_attached(rdev->pdev))
> +	if (!dev_is_removable(&rdev->pdev->dev))
>  		vga_switcheroo_unregister_client(rdev->pdev);
>  	if (rdev->flags & RADEON_IS_PX)
>  		vga_switcheroo_fini_domain_pm_ops(rdev->dev);
> diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
> index a16590c6247f..ead912a58ab8 100644
> --- a/drivers/gpu/drm/radeon/radeon_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> @@ -138,7 +138,7 @@ int radeon_driver_load_kms(struct drm_device *dev, unsigned long flags)
>  	if ((radeon_runtime_pm != 0) &&
>  	    radeon_has_atpx() &&
>  	    ((flags & RADEON_IS_IGP) == 0) &&
> -	    !pci_is_thunderbolt_attached(pdev))
> +	    !dev_is_removable(&pdev->dev))
>  		flags |= RADEON_IS_PX;
>  
>  	/* radeon_device_init should report only fatal error
> 

