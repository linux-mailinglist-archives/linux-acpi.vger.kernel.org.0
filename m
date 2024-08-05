Return-Path: <linux-acpi+bounces-7287-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26666947BD0
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 15:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7481C21BD8
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 13:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49E415B0F9;
	Mon,  5 Aug 2024 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n7tthhch"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1BC158DCC
	for <linux-acpi@vger.kernel.org>; Mon,  5 Aug 2024 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722864423; cv=none; b=CbqpErsaG4zcdWZI68IBKrbpLu0ruPhx2qw2KTlJ/oRGuEsKJLYRiPC+9dIbBySmmr8dw6sq7RUtAYr79/ofMPvQcH67+h3/Hct3A5k8Eyr1uvDZkZArgx1ZV9CeQDNj5277aN1iWXAycI1Y1h1IvULox5xC1dlbmVN/z3TlRDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722864423; c=relaxed/simple;
	bh=IWUBYZKFodiMcv3oIFUFMpMXdjj6J3Hv+SilGiL2Ygg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFc/FIG/4ruJCTRC6UYlSUYMJzPDjntuc2oYJtwyefJYLXnJiZwS2u9hBDEP1BvN9EXt8o97tKfnuB6/LboOfafSPuteMAp1yJc9Oznc6icF5whrFsAzTKrHbS3oCMMKl+jqWy/qvYoZdx6GVnxk80QyP+7foF2MKobdUQUqEcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n7tthhch; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d1d6369acso3890166b3a.0
        for <linux-acpi@vger.kernel.org>; Mon, 05 Aug 2024 06:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722864420; x=1723469220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=boW2X/O80i4mmc0cFAkLsjKJVoJQSW+QaV7WBtj726I=;
        b=n7tthhchVvUnUfrNlT5MWNvWD9a9Ed0nX5AtRD1c7uJjafJb82rb8I/YKTB4Zff9J5
         O2HrCupK0e+6YKKnFQhING+s6Q6DlE75KfWHlNjfgnGHt5C6GVafLrG8p6N9roaXBDoo
         FjWw6RgiXmrjwvkAQyCgidx+D7GnQzP+MeYCXjm+onTGLlqBf1GjnQmhiFeROWYFjE8W
         vWqviQLlropDgxCw1Kejz/xnJC2DFCn6fNdZ4hLLXSBYxGq//3qtfwH3QYXpeFOuhAdo
         6W/3GWcKqjFdqWlUdk9XE2/pEp9pIU3oUbkkIkac0+PGlBiPawU9RfKUAtmdohWLqOzC
         HY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722864420; x=1723469220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boW2X/O80i4mmc0cFAkLsjKJVoJQSW+QaV7WBtj726I=;
        b=bpSZ+Eu+G3m+FupS2+IXV5eA5d423wEws28p4TQO4bXhcGmoM28zMUvsWibsbkItzW
         /o7o7E++K6L3bkwrsAV7ZJVBPXvV3ITlzQk0Psqy5tyA9I3WoqlmDUm2Y0pq/CKu/jBv
         viNpglBzA80odf3mhGq437G7wXjJ5dOEN5qIm40OONpCSkG72QfXISwWxVM7NW5S5Mt7
         VKsbz7kQGDt5I7Q+gnVsSODqcrHmx7NdmItyTaeJ0iaqd2LdiA/Wrm9VFEfmkL1qo29u
         T2FxdBW/rcVd7zKu5ll19wEk6e0/wTBgaQnGmo44LAfkHnT4vf/SuhjXWk6BihZMAE/m
         4rIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjlotZ6/XONwN57L4yE+P0EkFz4AzTySv6NC7ymgRjwKKNNtfXsgrLmk+qxHHQZF+pc4RD5o4CniRxKLQMav24vLhNFeOgrQmIjQ==
X-Gm-Message-State: AOJu0Yzq0y8U93bonDfR7lvNFOCfFT/U9mZnz1T+q0bjdTd3HQWvVdF/
	LpQ++qaeVotq6K1X64tAki3g/mbZyJO9VvvDtKEMrfRRCdQbaJRBWy48EIWo1Q==
X-Google-Smtp-Source: AGHT+IF+PX69tcKP5upbCedTEm1/JTcYHUpIqoPq+4Lwl4bMcAcMu6iXishN/DPxfJX6IolIzg8qFQ==
X-Received: by 2002:a05:6a20:12d1:b0:1c4:b2d8:43ed with SMTP id adf61e73a8af0-1c69a5f2f94mr17206193637.14.1722864420117;
        Mon, 05 Aug 2024 06:27:00 -0700 (PDT)
Received: from thinkpad ([120.56.197.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed16cb3sm5576274b3a.179.2024.08.05.06.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 06:26:59 -0700 (PDT)
Date: Mon, 5 Aug 2024 18:56:53 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kernel test robot <lkp@intel.com>
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, lukas@wunner.de,
	mika.westerberg@linux.intel.com, Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 2/4] PCI: Rename pci_bridge_d3_possible() to
 pci_bridge_d3_allowed()
Message-ID: <20240805132653.GB7274@thinkpad>
References: <20240802-pci-bridge-d3-v5-2-2426dd9e8e27@linaro.org>
 <202408031855.TEPJlfzl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202408031855.TEPJlfzl-lkp@intel.com>

On Sat, Aug 03, 2024 at 07:03:56PM +0800, kernel test robot wrote:
> Hi Manivannan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 705c1da8fa4816fb0159b5602fef1df5946a3ee2]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam-via-B4-Relay/PCI-portdrv-Make-use-of-pci_dev-bridge_d3-for-checking-the-D3-possibility/20240803-074434
> base:   705c1da8fa4816fb0159b5602fef1df5946a3ee2
> patch link:    https://lore.kernel.org/r/20240802-pci-bridge-d3-v5-2-2426dd9e8e27%40linaro.org
> patch subject: [PATCH v5 2/4] PCI: Rename pci_bridge_d3_possible() to pci_bridge_d3_allowed()
> config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20240803/202408031855.TEPJlfzl-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240803/202408031855.TEPJlfzl-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408031855.TEPJlfzl-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/gpu/drm/radeon/radeon_atpx_handler.c: In function 'radeon_atpx_detect':
> >> drivers/gpu/drm/radeon/radeon_atpx_handler.c:568:59: error: 'struct pci_dev' has no member named 'bridge_d3'
>      568 |                 d3_supported |= parent_pdev && parent_pdev->bridge_d3;
>          |                                                           ^~
>    drivers/gpu/drm/radeon/radeon_atpx_handler.c:578:59: error: 'struct pci_dev' has no member named 'bridge_d3'
>      578 |                 d3_supported |= parent_pdev && parent_pdev->bridge_d3;
>          |                                                           ^~
> --
>    drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c: In function 'amdgpu_atpx_detect':
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c:628:59: error: 'struct pci_dev' has no member named 'bridge_d3'
>      628 |                 d3_supported |= parent_pdev && parent_pdev->bridge_d3;
>          |                                                           ^~
>    drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c:638:59: error: 'struct pci_dev' has no member named 'bridge_d3'
>      638 |                 d3_supported |= parent_pdev && parent_pdev->bridge_d3;
>          |                                                           ^~
> --
>    drivers/gpu/drm/nouveau/nouveau_acpi.c: In function 'nouveau_dsm_pci_probe':
> >> drivers/gpu/drm/nouveau/nouveau_acpi.c:229:32: error: 'struct pci_dev' has no member named 'bridge_d3'
>      229 |                 if (parent_pdev->bridge_d3)
>          |                                ^~

Ok, there seems to be a couple of drivers making use of pci_dev::bridge_d3 to
check if D3Cold is supported or not. And this further strengthens the fact that
PCI core should not rely on pci_bridge_d3_possible() as proposed in patch 1.

- Mani

> 
> 
> vim +568 drivers/gpu/drm/radeon/radeon_atpx_handler.c
> 
> 6a9ee8af344e3b Dave Airlie  2010-02-01  545  
> 82e029357d4726 Alex Deucher 2012-08-16  546  /**
> 82e029357d4726 Alex Deucher 2012-08-16  547   * radeon_atpx_detect - detect whether we have PX
> 82e029357d4726 Alex Deucher 2012-08-16  548   *
> 82e029357d4726 Alex Deucher 2012-08-16  549   * Check if we have a PX system (all asics).
> 82e029357d4726 Alex Deucher 2012-08-16  550   * Returns true if we have a PX system, false if not.
> 82e029357d4726 Alex Deucher 2012-08-16  551   */
> 6a9ee8af344e3b Dave Airlie  2010-02-01  552  static bool radeon_atpx_detect(void)
> 6a9ee8af344e3b Dave Airlie  2010-02-01  553  {
> 6a9ee8af344e3b Dave Airlie  2010-02-01  554  	char acpi_method_name[255] = { 0 };
> 6a9ee8af344e3b Dave Airlie  2010-02-01  555  	struct acpi_buffer buffer = {sizeof(acpi_method_name), acpi_method_name};
> 6a9ee8af344e3b Dave Airlie  2010-02-01  556  	struct pci_dev *pdev = NULL;
> 6a9ee8af344e3b Dave Airlie  2010-02-01  557  	bool has_atpx = false;
> 6a9ee8af344e3b Dave Airlie  2010-02-01  558  	int vga_count = 0;
> bcfdd5d5105087 Alex Deucher 2016-11-28  559  	bool d3_supported = false;
> bcfdd5d5105087 Alex Deucher 2016-11-28  560  	struct pci_dev *parent_pdev;
> 6a9ee8af344e3b Dave Airlie  2010-02-01  561  
> 6a9ee8af344e3b Dave Airlie  2010-02-01  562  	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
> 6a9ee8af344e3b Dave Airlie  2010-02-01  563  		vga_count++;
> 6a9ee8af344e3b Dave Airlie  2010-02-01  564  
> 6a9ee8af344e3b Dave Airlie  2010-02-01  565  		has_atpx |= (radeon_atpx_pci_probe_handle(pdev) == true);
> bcfdd5d5105087 Alex Deucher 2016-11-28  566  
> bcfdd5d5105087 Alex Deucher 2016-11-28  567  		parent_pdev = pci_upstream_bridge(pdev);
> bcfdd5d5105087 Alex Deucher 2016-11-28 @568  		d3_supported |= parent_pdev && parent_pdev->bridge_d3;
> 6a9ee8af344e3b Dave Airlie  2010-02-01  569  	}
> 6a9ee8af344e3b Dave Airlie  2010-02-01  570  
> e9a4099a59cc59 Alex Deucher 2014-04-15  571  	/* some newer PX laptops mark the dGPU as a non-VGA display device */
> e9a4099a59cc59 Alex Deucher 2014-04-15  572  	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
> e9a4099a59cc59 Alex Deucher 2014-04-15  573  		vga_count++;
> e9a4099a59cc59 Alex Deucher 2014-04-15  574  
> e9a4099a59cc59 Alex Deucher 2014-04-15  575  		has_atpx |= (radeon_atpx_pci_probe_handle(pdev) == true);
> bcfdd5d5105087 Alex Deucher 2016-11-28  576  
> bcfdd5d5105087 Alex Deucher 2016-11-28  577  		parent_pdev = pci_upstream_bridge(pdev);
> bcfdd5d5105087 Alex Deucher 2016-11-28  578  		d3_supported |= parent_pdev && parent_pdev->bridge_d3;
> e9a4099a59cc59 Alex Deucher 2014-04-15  579  	}
> e9a4099a59cc59 Alex Deucher 2014-04-15  580  
> 6a9ee8af344e3b Dave Airlie  2010-02-01  581  	if (has_atpx && vga_count == 2) {
> 492b49a2f21a7c Alex Deucher 2012-08-16  582  		acpi_get_name(radeon_atpx_priv.atpx.handle, ACPI_FULL_PATHNAME, &buffer);
> 7ca85295d8cc28 Joe Perches  2017-02-28  583  		pr_info("vga_switcheroo: detected switching method %s handle\n",
> 6a9ee8af344e3b Dave Airlie  2010-02-01  584  			acpi_method_name);
> 6a9ee8af344e3b Dave Airlie  2010-02-01  585  		radeon_atpx_priv.atpx_detected = true;
> bcfdd5d5105087 Alex Deucher 2016-11-28  586  		radeon_atpx_priv.bridge_pm_usable = d3_supported;
> 69ee9742f945cd Alex Deucher 2016-07-27  587  		radeon_atpx_init();
> 6a9ee8af344e3b Dave Airlie  2010-02-01  588  		return true;
> 6a9ee8af344e3b Dave Airlie  2010-02-01  589  	}
> 6a9ee8af344e3b Dave Airlie  2010-02-01  590  	return false;
> 6a9ee8af344e3b Dave Airlie  2010-02-01  591  }
> 6a9ee8af344e3b Dave Airlie  2010-02-01  592  
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

-- 
மணிவண்ணன் சதாசிவம்

