Return-Path: <linux-acpi+bounces-1560-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0567EE30E
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Nov 2023 15:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B85ACB20BDC
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Nov 2023 14:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2036031A77
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Nov 2023 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QolO64CJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799C0AD;
	Thu, 16 Nov 2023 05:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700139740; x=1731675740;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qni4q+MCRq+nAUIb30fVBT62T2fPU22iNzyXzheWpdg=;
  b=QolO64CJe2TCEWToxUrLxK29Vbq4OR1al+Dv5dFGWH1zo4lKZMfAcIfV
   FuPwkYNSzt/or0oTtZMqjVYsIvREVP9VQ3gApCCT56in/lyVF4DDpNux7
   l5aNIkJgRyVJb8w+YECRMTQMCa5o8HkyBLqhMhZb0kw1eopgACZWw/44q
   icTe4i7d7AQIVLy4fwhWiGdxPcbg+x/CdJphtBnMnoEW6OqCHd3k7nXVk
   u7gs8T1T1ZIG/GqaIb9UgYSRjQBP9FSzkoogSH/W48bHhrGYR2ljrusqe
   B7TKniPK50hOeOEw5noyIc79JFR9VSgIhZvU7OIaMvlJBiULJFpOKnLjF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="388247928"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="388247928"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 05:02:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="13550045"
Received: from jhsteyn-mobl1.ger.corp.intel.com ([10.252.40.9])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 05:02:14 -0800
Date: Thu, 16 Nov 2023 15:02:11 +0200 (EET)
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
Subject: Re: [PATCH v3 6/7] PCI: Split up some logic in pcie_bandwidth_available()
 to separate function
In-Reply-To: <20231114200755.14911-7-mario.limonciello@amd.com>
Message-ID: <671f5c3b-fd24-7d24-c848-1ae31cea82ff@linux.intel.com>
References: <20231114200755.14911-1-mario.limonciello@amd.com> <20231114200755.14911-7-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-761469376-1700139739=:1886"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-761469376-1700139739=:1886
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 14 Nov 2023, Mario Limonciello wrote:

> The logic to calculate bandwidth limits may be used at multiple call sites
> so split it up into its own static function instead.
> 
> No intended functional changes.
> 
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2->v3:
>  * Split from previous patch version
> ---
>  drivers/pci/pci.c | 60 +++++++++++++++++++++++++++--------------------
>  1 file changed, 34 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 55bc3576a985..0ff7883cc774 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6224,6 +6224,38 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
>  }
>  EXPORT_SYMBOL(pcie_set_mps);
>  
> +static u32 pcie_calc_bw_limits(struct pci_dev *dev, u32 bw,
> +			       struct pci_dev **limiting_dev,
> +			       enum pci_bus_speed *speed,
> +			       enum pcie_link_width *width)
> +{
> +	enum pcie_link_width next_width;
> +	enum pci_bus_speed next_speed;
> +	u32 next_bw;
> +	u16 lnksta;
> +
> +	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> +
> +	next_speed = pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)];
> +	next_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
> +
> +	next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
> +
> +	/* Check if current device limits the total bandwidth */

I'd make this a function comment instead and say:

/* Check if @dev limits the total bandwidth. */

Other than that,

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

> +	if (!bw || next_bw <= bw) {
> +		bw = next_bw;
> +
> +		if (limiting_dev)
> +			*limiting_dev = dev;
> +		if (speed)
> +			*speed = next_speed;
> +		if (width)
> +			*width = next_width;
> +	}
> +
> +	return bw;
> +}
> +
>  /**
>   * pcie_bandwidth_available - determine minimum link settings of a PCIe
>   *			      device and its bandwidth limitation
> @@ -6242,39 +6274,15 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>  			     enum pci_bus_speed *speed,
>  			     enum pcie_link_width *width)
>  {
> -	u16 lnksta;
> -	enum pci_bus_speed next_speed;
> -	enum pcie_link_width next_width;
> -	u32 bw, next_bw;
> +	u32 bw = 0;
>  
>  	if (speed)
>  		*speed = PCI_SPEED_UNKNOWN;
>  	if (width)
>  		*width = PCIE_LNK_WIDTH_UNKNOWN;
>  
> -	bw = 0;
> -
>  	while (dev) {
> -		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> -
> -		next_speed = pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS,
> -						       lnksta)];
> -		next_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
> -
> -		next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
> -
> -		/* Check if current device limits the total bandwidth */
> -		if (!bw || next_bw <= bw) {
> -			bw = next_bw;
> -
> -			if (limiting_dev)
> -				*limiting_dev = dev;
> -			if (speed)
> -				*speed = next_speed;
> -			if (width)
> -				*width = next_width;
> -		}
> -
> +		bw = pcie_calc_bw_limits(dev, bw, limiting_dev, speed, width);
>  		dev = pci_upstream_bridge(dev);
>  	}
>  
> 
--8323329-761469376-1700139739=:1886--

