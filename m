Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B32F424FF9
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Oct 2021 11:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbhJGJXY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Oct 2021 05:23:24 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:24174 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240562AbhJGJXR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Oct 2021 05:23:17 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HQ5Pf4n9xz1DHR5;
        Thu,  7 Oct 2021 17:19:50 +0800 (CST)
Received: from dggema764-chm.china.huawei.com (10.1.198.206) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 7 Oct 2021 17:21:20 +0800
Received: from [10.174.185.179] (10.174.185.179) by
 dggema764-chm.china.huawei.com (10.1.198.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 7 Oct 2021 17:21:18 +0800
Subject: Re: [PATCH] drm/i915: Free the returned object of acpi_evaluate_dsm()
To:     <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <ville.syrjala@linux.intel.com>, <tiwai@suse.de>,
        <wanghaibin.wang@huawei.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        <linux-acpi@vger.kernel.org>
References: <20210906033541.862-1-yuzenghui@huawei.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <3ae85963-beab-17d2-05f1-5a490cee1296@huawei.com>
Date:   Thu, 7 Oct 2021 17:21:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210906033541.862-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema764-chm.china.huawei.com (10.1.198.206)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[+linux-acpi]

ping

On 2021/9/6 11:35, Zenghui Yu wrote:
> As per the comment on top of acpi_evaluate_dsm():
> 
> | * Evaluate device's _DSM method with specified GUID, revision id and
> | * function number. Caller needs to free the returned object.
> 
> We should free the returned object of acpi_evaluate_dsm() to avoid memory
> leakage. Otherwise the kmemleak splat will be triggered at boot time (if we
> compile kernel with CONFIG_DEBUG_TEST_DRIVER_REMOVE=y).
> 
> Fixes: 8e55f99c510f ("drm/i915: Invoke another _DSM to enable MUX on HP Workstation laptops")
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  drivers/gpu/drm/i915/display/intel_acpi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
> index 7cfe91fc05f2..68abeaf2d7d4 100644
> --- a/drivers/gpu/drm/i915/display/intel_acpi.c
> +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
> @@ -186,13 +186,16 @@ void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915)
>  {
>  	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>  	acpi_handle dhandle;
> +	union acpi_object *obj;
>  
>  	dhandle = ACPI_HANDLE(&pdev->dev);
>  	if (!dhandle)
>  		return;
>  
> -	acpi_evaluate_dsm(dhandle, &intel_dsm_guid2, INTEL_DSM_REVISION_ID,
> -			  INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED, NULL);
> +	obj = acpi_evaluate_dsm(dhandle, &intel_dsm_guid2, INTEL_DSM_REVISION_ID,
> +				INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED, NULL);
> +	if (obj)
> +		ACPI_FREE(obj);
>  }
>  
>  /*
> 
