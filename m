Return-Path: <linux-acpi+bounces-1559-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E507EE30A
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Nov 2023 15:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 049C7B20A18
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Nov 2023 14:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64594328BF
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Nov 2023 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XkRRthZ3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5875131;
	Thu, 16 Nov 2023 04:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700139124; x=1731675124;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=f4QDrezvvE23+gVuxjkoKDCNJ2E6SLKLC02A5VExyX4=;
  b=XkRRthZ3BQP6Hbdmjs6+JAsbO30f64mdr+nef0yGaKdHXOkBOUJ9VzhX
   tE7mw5g6P5GOxSt6BDM7ftd5kIvZdrafS8wMnadFr7q3NjARs044dm2t8
   jgQNBbEMuywcNFYwiFUHxrq/rjxxQGdwjLAZ2feidDU/EZuOMdOxMonrn
   2KZ1PfR0YV1ro+VoyJodcKh2bMOXnrm3MwfpTNEGRNxC8z8K4rgGvylj8
   4Xl4rCiLDuiV0qAPvW6UX9ttL1xQd9/28HRK+U3DJcukUmfmr0X+KyeiV
   wX4ov4oOXqScpc4SVVcoN4NvuLLTQaz1g9KKIbuhKnH6aojwMh4fzFWgJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="376126896"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="376126896"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 04:52:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="768899030"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="768899030"
Received: from jhsteyn-mobl1.ger.corp.intel.com ([10.252.40.9])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 04:51:57 -0800
Date: Thu, 16 Nov 2023 14:51:55 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
    Alex Deucher <alexander.deucher@amd.com>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Lukas Wunner <lukas@wunner.de>, Danilo Krummrich <dakr@redhat.com>, 
    David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
    Xinhui Pan <Xinhui.Pan@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
    =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>, 
    =?ISO-8859-15?Q?Marek_Beh=FAn?= <kabel@kernel.org>, 
    "Maciej W . Rozycki" <macro@orcam.me.uk>, 
    Manivannan Sadhasivam <mani@kernel.org>, 
    "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" <dri-devel@lists.freedesktop.org>, 
    "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" <nouveau@lists.freedesktop.org>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
    "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
    "open list:ACPI" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] PCI: Drop pci_is_thunderbolt_attached()
In-Reply-To: <20231114200755.14911-4-mario.limonciello@amd.com>
Message-ID: <74dcfcaf-e6d4-dec8-4227-a4caf51bd4d0@linux.intel.com>
References: <20231114200755.14911-1-mario.limonciello@amd.com> <20231114200755.14911-4-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1230501375-1700139122=:1886"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1230501375-1700139122=:1886
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 14 Nov 2023, Mario Limonciello wrote:

> All callers have switched to dev_is_removable() for detecting
> hotpluggable PCIe devices.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2->v3:
>  * No changes
> ---
>  include/linux/pci.h | 22 ----------------------
>  1 file changed, 22 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 60ca768bc867..1fbca2bd92e8 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2645,28 +2645,6 @@ static inline bool pci_ari_enabled(struct pci_bus *bus)
>  	return bus->self && bus->self->ari_enabled;
>  }
>  
> -/**
> - * pci_is_thunderbolt_attached - whether device is on a Thunderbolt daisy chain
> - * @pdev: PCI device to check
> - *
> - * Walk upwards from @pdev and check for each encountered bridge if it's part
> - * of a Thunderbolt controller.  Reaching the host bridge means @pdev is not
> - * Thunderbolt-attached.  (But rather soldered to the mainboard usually.)
> - */
> -static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
> -{
> -	struct pci_dev *parent = pdev;
> -
> -	if (pdev->is_thunderbolt)
> -		return true;
> -
> -	while ((parent = pci_upstream_bridge(parent)))
> -		if (parent->is_thunderbolt)
> -			return true;
> -
> -	return false;
> -}
> -
>  #if defined(CONFIG_PCIEPORTBUS) || defined(CONFIG_EEH)
>  void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
>  #endif
> 

Reviewed-by: Ilpo J�rvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1230501375-1700139122=:1886--

