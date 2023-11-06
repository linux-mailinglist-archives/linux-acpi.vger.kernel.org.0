Return-Path: <linux-acpi+bounces-1258-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D9B7E26E3
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 15:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D4D1C20B2F
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAB228DA3
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fl1HAM8R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7FD25100;
	Mon,  6 Nov 2023 12:33:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28DE97;
	Mon,  6 Nov 2023 04:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699274033; x=1730810033;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lly8ppgmxcDDLOmDBL4aU0UCetKvXa6D6CEONx55ShM=;
  b=fl1HAM8RLmfBfFwSXhfJ2lfviepCCwgP/bGCGYfuPGdd4mOtgtsC9BB+
   flZFOuZPzuBxjisjuH9GddRb4DWZz2BGCf2Y7EX31vSLvxoYSbKV9z+mw
   1+aXI8v6inGgtq56I122ebpKVaRgfuIM8rdQpJwiCw0x9EFggcum3DOLo
   14VtFWl8dkrsRNlmUijI0FGn7mllUlv5lectJmS4BcsZ540qKSZtPGeQA
   RjcnjSiYiSPhfEIuLOKm82SIKQMnWceXVhdjJcVk8ynhszfaThMMmhEHO
   pNn1wmSFw31age3VFkeY6mLw1HX7mbhR1lgspmJ0EmJhiHT3pvrBjSXgk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="379657177"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="379657177"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 04:33:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="765938147"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="765938147"
Received: from rmstoi-mobl.ger.corp.intel.com ([10.251.216.76])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 04:33:43 -0800
Date: Mon, 6 Nov 2023 14:33:40 +0200 (EET)
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
Subject: Re: [PATCH v2 3/9] PCI: Drop pci_is_thunderbolt_attached()
In-Reply-To: <20231103190758.82911-4-mario.limonciello@amd.com>
Message-ID: <4747b7b8-ea48-4117-f746-a18dae97bc2@linux.intel.com>
References: <20231103190758.82911-1-mario.limonciello@amd.com> <20231103190758.82911-4-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 3 Nov 2023, Mario Limonciello wrote:

> All callers have switched to dev_is_removable() for detecting
> hotpluggable PCIe devices.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  include/linux/pci.h | 22 ----------------------
>  1 file changed, 22 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b56417276042..530b0a360514 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2616,28 +2616,6 @@ static inline bool pci_ari_enabled(struct pci_bus *bus)
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

I don't think all callers have been removed. Ah, lkp has caught the same 
problem.

-- 
 i.


