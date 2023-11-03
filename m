Return-Path: <linux-acpi+bounces-1217-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8284D7E0A63
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 21:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE661C20FED
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 20:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198B423762
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEkItede"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CEA22F0F
	for <linux-acpi@vger.kernel.org>; Fri,  3 Nov 2023 19:38:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7F8D61
	for <linux-acpi@vger.kernel.org>; Fri,  3 Nov 2023 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699040307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18fxGFPyEfYX6zujRVQDCVGp1gVPnAg8xcOJqGUDNpU=;
	b=WEkItedecRds0qOcBxKgV+BlXanqPNvIhVM5BPB+KWD42h5LD+wCXlA7+0afMHD2HRzct6
	aw1oH+KuwFhmX5ToyHwMeCo/q/KLiUER6Ujmq6O+OslgxjzVLMGrjuMrAeY9wibNMVIyYB
	tK+yddk4hNYtAkEd+AB9NeOH7Z9pGw8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-KE5ULWn7NLW7Iy44fDWVUQ-1; Fri, 03 Nov 2023 15:38:26 -0400
X-MC-Unique: KE5ULWn7NLW7Iy44fDWVUQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5411d71889aso2095806a12.2
        for <linux-acpi@vger.kernel.org>; Fri, 03 Nov 2023 12:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699040305; x=1699645105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18fxGFPyEfYX6zujRVQDCVGp1gVPnAg8xcOJqGUDNpU=;
        b=vWDpvn+iNOv3O6ZuIlk8JwCxJZakSFzCyCwWl/M4KZpGGw3MWBgZrww4ehsqQYsAzc
         V9qXyl9uDnNlzpS3ERLByV3UuAsWunBOLKIU3rCa6/VYcqi6tQfTVU+YbZX3T32rXAsi
         wHs+zlawUVR4M5TbOnMMmYjQFCxMygdQ34LdvAsjJLRnHY3+6sOkHzJbfDXLTzySW6NJ
         0JcSnt6O7/fU5/cLzKG6uDIDabYsmVy8D7OpyTQDGKdYv+kpD5MmBbWeCJA0GxI91qPh
         vIIGvD8GjZeXE23UEP53AVom/i6I5ixZn/E/cccLuF6W0bfY8H9WFNfwMiMqPJemJZ+Q
         2sLw==
X-Gm-Message-State: AOJu0YyHNwtHvnJ9OzpN0GG/kPk+o1swSSq+AmrUF2hrQAFwY3+HJfjw
	HvcTRPIeeGnB8Kj+A7RnfnfZENNEEKtXjLB+1/lFNjRy9igF4GDUVtJ0jZV3jKH1LtFhHRLIFFn
	NzfnDv6F9r5IW8IBiL18r/w==
X-Received: by 2002:a17:907:3da1:b0:9b7:37de:6009 with SMTP id he33-20020a1709073da100b009b737de6009mr8119042ejc.3.1699040305116;
        Fri, 03 Nov 2023 12:38:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2EgYFYkxhAFVhtUcYX07z+ZAHa6gRCnHShMvlzepM1PxNvaeqEAxxrCtaSa8ojD2/gCJsUw==
X-Received: by 2002:a17:907:3da1:b0:9b7:37de:6009 with SMTP id he33-20020a1709073da100b009b737de6009mr8119007ejc.3.1699040304766;
        Fri, 03 Nov 2023 12:38:24 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? ([2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id lk22-20020a170906cb1600b0099d804da2e9sm1220533ejb.225.2023.11.03.12.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 12:38:24 -0700 (PDT)
Message-ID: <d6466210-fdb7-e9e2-68bb-551b263f439d@redhat.com>
Date: Fri, 3 Nov 2023 20:38:20 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 6/9] PCI: Rename is_thunderbolt to is_tunneled
Content-Language: en-US, nl
To: Mario Limonciello <mario.limonciello@amd.com>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>
Cc: Danilo Krummrich <dakr@redhat.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Xinhui Pan <Xinhui.Pan@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Mark Gross <markgross@kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?=
 <pali@kernel.org>, =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Manivannan Sadhasivam <mani@kernel.org>,
 "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS"
 <dri-devel@lists.freedesktop.org>,
 "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS"
 <nouveau@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>,
 "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>
References: <20231103190758.82911-1-mario.limonciello@amd.com>
 <20231103190758.82911-7-mario.limonciello@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231103190758.82911-7-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/3/23 20:07, Mario Limonciello wrote:
> The `is_thunderbolt` bit has been used to indicate that a PCIe device
> contained the Intel VSEC which is used by various parts of the kernel
> to change behavior. To later allow usage with USB4 controllers as well,
> rename this to `is_tunneled`.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Here is my ack for the trivial drivers/platform/x86/apple-gmux.c change:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Bjorn, feel free to route this through the PCI tree.

Regards,

Hans




> ---
>  drivers/pci/pci.c                 | 2 +-
>  drivers/pci/probe.c               | 2 +-
>  drivers/platform/x86/apple-gmux.c | 2 +-
>  include/linux/pci.h               | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 59c01d68c6d5..d9aa5a39f585 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3032,7 +3032,7 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  			return true;
>  
>  		/* Even the oldest 2010 Thunderbolt controller supports D3. */
> -		if (bridge->is_thunderbolt)
> +		if (bridge->is_tunneled)
>  			return true;
>  
>  		/* Platform might know better if the bridge supports D3 */
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 795534589b98..518413d15402 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1597,7 +1597,7 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  	/* Is the device part of a Thunderbolt controller? */
>  	vsec = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_TBT);
>  	if (vsec)
> -		dev->is_thunderbolt = 1;
> +		dev->is_tunneled = 1;
>  }
>  
>  static void set_pcie_untrusted(struct pci_dev *dev)
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index 1417e230edbd..20315aa4463a 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -774,7 +774,7 @@ static int gmux_resume(struct device *dev)
>  
>  static int is_thunderbolt(struct device *dev, void *data)
>  {
> -	return to_pci_dev(dev)->is_thunderbolt;
> +	return to_pci_dev(dev)->is_tunneled;
>  }
>  
>  static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 439c2dac8a3e..b1724f25fb02 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -440,7 +440,7 @@ struct pci_dev {
>  	unsigned int	is_virtfn:1;
>  	unsigned int	is_hotplug_bridge:1;
>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
> -	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> +	unsigned int	is_tunneled:1;		/* Tunneled TBT or USB4 link */
>  	unsigned int	no_command_complete:1;	/* No command completion */
>  	/*
>  	 * Devices marked being untrusted are the ones that can potentially


