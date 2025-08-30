Return-Path: <linux-acpi+bounces-16216-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9630AB3CBBD
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 17:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE8587A3DAB
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 15:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37A2256C9E;
	Sat, 30 Aug 2025 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ox4seuAJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5C621C9ED;
	Sat, 30 Aug 2025 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756566836; cv=none; b=D7ksFy3UfBsm4WZF9MQ/geFJjayraj2jGczLkl4J1Osc9vUDNwSUUQNo2l11fv6uk/iFVphjUGn/Pu0mL5abSTYdEAL+Y3Scj9KIYstLm0szEmpxXpYI9sQoQI3W1DeWnnDO66D+pHtVxmrNKWm5EJIwkpBnHnabvbwsVYmNslw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756566836; c=relaxed/simple;
	bh=GeVA+T7o7ntpTg+xDppGN4AZE4VBs4ETAWnGCIdbQ8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPJ8j417CoPk70OVSlzrkV4xuipR4d8xiJk6yF9AEhFwLYb8NQt6kLiBeTdyxPNmH3szw+ISnSRvyhr9HnEt/kCv++mM2yW7wxJNxtW16Nubuq89ItxYIeAIX7Foy6qVZocgyeGfIUhCsYDU/Hf4BYoImzlfh+NfUlwjYb5loz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ox4seuAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2B4C4CEEB;
	Sat, 30 Aug 2025 15:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756566836;
	bh=GeVA+T7o7ntpTg+xDppGN4AZE4VBs4ETAWnGCIdbQ8Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ox4seuAJ4kJOea08PjWUf2rQDKdDH6Y6LSCx026o7RHkuepgKM12vZxYgapVNr172
	 HzXtoIE2YhIl83+6AdAqviwgPxuI+sHg1h5L9ttGwdHcQnBbd9QPOdobVoRo7stSGd
	 JrYxLORc5aI7feU745QB4RYzxl0NGYLwEqFgRIfnsRmqJPQ0RvtIbRbb9M0HMvMvn/
	 xcrlHk4FbAQ4v7Uw0ir8EJpiwOYO4oWrx7F/7pNe94iewApCLdSJlYgtxBpxJ9m8Kt
	 S6cJkpp8byAk3mls4OMtKSVrBtYZnFdl8N+yUppAyWpO7FWBmpWCeo2WgZq/LDSOv1
	 kXi9XHajbSFTQ==
Message-ID: <c6f2b153-b783-4087-b7e4-30ca207b7572@kernel.org>
Date: Sat, 30 Aug 2025 17:13:51 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/12] ACPI: platform: Add macro for acpi platform
 driver
To: Slawomir Rosek <srosek@google.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 AceLan Kao <acelan.kao@canonical.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Tomasz Nowicki <tnowicki@google.com>, Stanislaw Kardach
 <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250830053404.763995-1-srosek@google.com>
 <20250830053404.763995-12-srosek@google.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20250830053404.763995-12-srosek@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Slawomir,

On 30-Aug-25 7:34 AM, Slawomir Rosek wrote:
> Introduce module_acpi_platform_driver() macro to simplify dynamic
> enumeration of ACPI device objects on the platform bus by loadable
> modules. Move common code from the intel-hid and intel-vbtn drivers
> to the ACPI platform core.
> 
> Signed-off-by: Slawomir Rosek <srosek@google.com>

Thank you for your interesting patch.

> ---
>  drivers/acpi/acpi_platform.c      | 27 ++++++++++++++++++++
>  drivers/platform/x86/intel/hid.c  | 41 +------------------------------
>  drivers/platform/x86/intel/vbtn.c | 30 +---------------------
>  include/linux/platform_device.h   | 17 +++++++++++++
>  4 files changed, 46 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index 48d15dd785f6..adf32ffa6be6 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -190,6 +190,33 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
>  }
>  EXPORT_SYMBOL_GPL(acpi_create_platform_device);
>  
> +static acpi_status
> +__acpi_platform_driver_register_cb(acpi_handle handle, u32 lvl,
> +				void *context, void **rv)
> +{
> +	const struct acpi_device_id *ids = context;
> +	struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
> +
> +	if (dev && acpi_match_device_ids(dev, ids) == 0)
> +		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL))) {
> +			dev_info(&dev->dev,
> +				 "created platform device\n");
> +		}
> +
> +	return AE_OK;
> +}
> +
> +int __acpi_platform_driver_register(struct platform_driver *drv,
> +				struct module *owner)
> +{
> +	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, ACPI_UINT32_MAX,
> +			    __acpi_platform_driver_register_cb, NULL,
> +			    (void *)drv->driver.acpi_match_table, NULL);
> +
> +	return __platform_driver_register(drv, owner);
> +}
> +EXPORT_SYMBOL_GPL(__acpi_platform_driver_register);
> +
>  void __init acpi_platform_init(void)
>  {
>  	acpi_reconfig_notifier_register(&acpi_platform_notifier);
> diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
> index f25a427cccda..e2e0fc95e177 100644
> --- a/drivers/platform/x86/intel/hid.c
> +++ b/drivers/platform/x86/intel/hid.c
> @@ -766,43 +766,4 @@ static struct platform_driver intel_hid_pl_driver = {
>  	.remove = intel_hid_remove,
>  };
>  
> -/*
> - * Unfortunately, some laptops provide a _HID="INT33D5" device with
> - * _CID="PNP0C02".  This causes the pnpacpi scan driver to claim the
> - * ACPI node, so no platform device will be created.  The pnpacpi
> - * driver rejects this device in subsequent processing, so no physical
> - * node is created at all.
> - *
> - * As a workaround until the ACPI core figures out how to handle
> - * this corner case, manually ask the ACPI platform device code to
> - * claim the ACPI node.
> - */

This comment contains useful info, please preserve the comment changing
the last paragraph to:

 * As a workaround until the ACPI core figures out how to handle
 * this corner case, manually ask the ACPI platform device code to
 * claim the ACPI node by using module_acpi_platform_driver()
 * instead of the regular module_platform_driver().

> -static acpi_status __init
> -check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
> -{
> -	const struct acpi_device_id *ids = context;
> -	struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
> -
> -	if (dev && acpi_match_device_ids(dev, ids) == 0)
> -		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL)))
> -			dev_info(&dev->dev,
> -				 "intel-hid: created platform device\n");
> -
> -	return AE_OK;
> -}
> -
> -static int __init intel_hid_init(void)
> -{
> -	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> -			    ACPI_UINT32_MAX, check_acpi_dev, NULL,
> -			    (void *)intel_hid_ids, NULL);
> -
> -	return platform_driver_register(&intel_hid_pl_driver);
> -}
> -module_init(intel_hid_init);
> -
> -static void __exit intel_hid_exit(void)
> -{
> -	platform_driver_unregister(&intel_hid_pl_driver);
> -}
> -module_exit(intel_hid_exit);
> +module_acpi_platform_driver(intel_hid_pl_driver);
> diff --git a/drivers/platform/x86/intel/vbtn.c b/drivers/platform/x86/intel/vbtn.c
> index 232cd12e3c9f..42932479de35 100644
> --- a/drivers/platform/x86/intel/vbtn.c
> +++ b/drivers/platform/x86/intel/vbtn.c

...

> -static int __init intel_vbtn_init(void)
> -{
> -	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> -			    ACPI_UINT32_MAX, check_acpi_dev, NULL,
> -			    (void *)intel_vbtn_ids, NULL);

Too bad there is no comment here. I wonder if this is necessary
at all, or if this was just copy & pasted from the intel/hid.c
driver.

git blame is not really helpful here, the acpi_walk_namespace()
was added in 332e081225fc2 ("intel-vbtn: new driver for Intel Virtual
Button").

So it looks like this is just copy paste and maybe a regular
module_platform_driver() will be sufficient here. But changing
behavior like that is out of scope for this patch-set, so please
keep using module_acpi_platform_driver()

Otherwise this looks good to me.

Regards,

Hans



