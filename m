Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E787439FC44
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 18:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhFHQWf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 12:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhFHQWf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 12:22:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D31C061574
        for <linux-acpi@vger.kernel.org>; Tue,  8 Jun 2021 09:20:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i94so17190345wri.4
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jun 2021 09:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T00FNpH7loMoqEtu1eWkUwRL9Kx0HIFZ6Q16qohE+J4=;
        b=HRZtPkdQMgKsoj0cPRM68ogG0mMmoH7ag19wxbhzjdW5YKTZEzrIk4akAiv8oS9QDS
         iHwHC9YruyRIKFthp5KNROuavoBGpuhJv7OkiaTg8t5ZcVK4dNC5Os5hgffWYEDId5Hx
         EtUDio58Sr+cKs0CBMf79P0wIvBmREi5fhp6SkaV/zyw/3tAHcQwYCIWW9NRbZdMkO6r
         cy2QNVX6lWOZXd82Zh+xQyfKInh4LQaY2zxWXnhB9jqfmB9v2Hfo7DbgMCqz8ohURgOx
         9oTKXkpOPLnPfp52Vbtl8Vr6Ffgmbm1aR9uO96IoFGzzGa1DKxehsE+75ZnfKCsH/Pp0
         9Ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T00FNpH7loMoqEtu1eWkUwRL9Kx0HIFZ6Q16qohE+J4=;
        b=F4EcnEJIEua01SIe56+7aDwjQEUdqjN0+K64SB3DQ9uGmbhVtbUdZ22++wgbsxhV5w
         Ujf51ZEet5T+Bgp/9It0Ay5+4vjKLTI/jlVyOUpy5FiW3MyGRBCwTIyscsqivY8DfS+/
         oNUio8LDGzDFGPV5KnsiWm1J1rsmq5DQocd02qGLPDrN1320WfSXXTfTzS7dZjE33QcB
         XAK2yFGMvfVR6zEqsYvxQGvHppbbigQg7vNKIE/NKLAzLxB9r5Kq5jRHAuYxCgf6cWaA
         X9mkG6UkgKNUKe0jdRVl/2atf7KWS/UOFHg9LqVT+tl6zSaWR6nWNJhkgHuuXjUxKTIE
         +Shg==
X-Gm-Message-State: AOAM530+AQ3zXVqRuXIEs1GEHC2dIdp8HxVJjhGWwqtzvBoTAcRbJaJH
        6y5zX3eBjLlxuqTs+3CRtFA=
X-Google-Smtp-Source: ABdhPJyIdlws1mfTZDVOyk7oQVbCvi9swbRfOVqsI9H4/EQPATyt1/mTBwmS6f3gPjcBQlUffcOIfw==
X-Received: by 2002:adf:e404:: with SMTP id g4mr23226889wrm.414.1623169225059;
        Tue, 08 Jun 2021 09:20:25 -0700 (PDT)
Received: from ?IPv6:2a02:908:1984:a6c0::f8b0? ([2a02:908:1984:a6c0::f8b0])
        by smtp.gmail.com with ESMTPSA id v7sm23989440wrf.82.2021.06.08.09.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 09:20:24 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] ACPI: Add quirks for AMD Renoir/Lucienne CPUs to
 force the D3 hint
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-acpi@vger.kernel.org, rrangel@chromium.org,
        david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, Alexander.Deucher@amd.com,
        prike.liang@amd.com
References: <20210608154255.8693-1-mario.limonciello@amd.com>
 <20210608154255.8693-2-mario.limonciello@amd.com>
From:   Julian Sikorski <belegdol@gmail.com>
Message-ID: <0825a2d6-be28-3a4d-54b3-c45cc18fbab9@gmail.com>
Date:   Tue, 8 Jun 2021 18:20:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210608154255.8693-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W dniu 08.06.2021 o 17:42, Mario Limonciello pisze:
> AMD systems from Renoir and Lucienne require that the NVME controller
> is put into D3 over a Modern Standby / suspend-to-idle
> cycle.  This is "typically" accomplished using the `StorageD3Enable`
> property in the _DSD, but this property was introduced after many
> of these systems launched and most OEM systems don't have it in
> their BIOS.
> 
> On AMD Renoir without these drives going into D3 over suspend-to-idle
> the resume will fail with the NVME controller being reset and a trace
> like this in the kernel logs:
> ```
> [   83.556118] nvme nvme0: I/O 161 QID 2 timeout, aborting
> [   83.556178] nvme nvme0: I/O 162 QID 2 timeout, aborting
> [   83.556187] nvme nvme0: I/O 163 QID 2 timeout, aborting
> [   83.556196] nvme nvme0: I/O 164 QID 2 timeout, aborting
> [   95.332114] nvme nvme0: I/O 25 QID 0 timeout, reset controller
> [   95.332843] nvme nvme0: Abort status: 0x371
> [   95.332852] nvme nvme0: Abort status: 0x371
> [   95.332856] nvme nvme0: Abort status: 0x371
> [   95.332859] nvme nvme0: Abort status: 0x371
> [   95.332909] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns -16
> [   95.332936] nvme 0000:03:00.0: PM: failed to resume async: error -16
> ```
> 
> The Microsoft documentation for StorageD3Enable mentioned that Windows has
> a hardcoded allowlist for D3 support, which was used for these platforms.
> Introduce quirks to hardcode them for Linux as well.
> 
> As this property is now "standardized", OEM systems using AMD Cezanne and
> newer APU's have adopted this property, and quirks like this should not be
> necessary.
> 
> CC: Julian Sikorski <belegdol@gmail.com>
> CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
> CC: Alexander Deucher <Alexander.Deucher@amd.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Prike Liang <prike.liang@amd.com>
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/device_pm.c |  3 +++
>   drivers/acpi/internal.h  |  9 +++++++++
>   drivers/acpi/x86/utils.c | 25 +++++++++++++++++++++++++
>   3 files changed, 37 insertions(+)
> 
> Changes from v4->v5:
>   * Add this patch back in as it's been made apparent that the
>     system needs to be hardcoded for these.
>     Changes:
>     - Drop Cezanne - it's now covered by StorageD3Enable
>     - Rebase ontop of acpi_storage_d3 outside of NVME
> Changes from v5->v6:
>   * Move the quirk check into drivers/acpi/x86/ as suggested by
>     Rafael.
> Changes from v6->v7:
>   * Move header location
>   * Optimization of force function
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index c45f2d76b67e..31e0025a913e 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1356,6 +1356,9 @@ bool acpi_storage_d3(struct device *dev)
>   	struct acpi_device *adev = ACPI_COMPANION(dev);
>   	u8 val;
>   
> +	if (force_storage_d3())
> +		return true;
> +
>   	if (!adev)
>   		return false;
>   	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index f973bbe90e5e..e29ec463bb07 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -236,6 +236,15 @@ static inline int suspend_nvs_save(void) { return 0; }
>   static inline void suspend_nvs_restore(void) {}
>   #endif
>   
> +#ifdef CONFIG_X86
> +bool force_storage_d3(void);
> +#else
> +static inline bool force_storage_d3(void)
> +{
> +	return false;
> +}
> +#endif
> +
>   /*--------------------------------------------------------------------------
>   				Device properties
>     -------------------------------------------------------------------------- */
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index bdc1ba00aee9..5298bb4d81fe 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -135,3 +135,28 @@ bool acpi_device_always_present(struct acpi_device *adev)
>   
>   	return ret;
>   }
> +
> +/*
> + * AMD systems from Renoir and Lucienne *require* that the NVME controller
> + * is put into D3 over a Modern Standby / suspend-to-idle cycle.
> + *
> + * This is "typically" accomplished using the `StorageD3Enable`
> + * property in the _DSD that is checked via the `acpi_storage_d3` function
> + * but this property was introduced after many of these systems launched
> + * and most OEM systems don't have it in their BIOS.
> + *
> + * The Microsoft documentation for StorageD3Enable mentioned that Windows has
> + * a hardcoded allowlist for D3 support, which was used for these platforms.
> + *
> + * This allows quirking on Linux in a similar fashion.
> + */
> +const struct x86_cpu_id storage_d3_cpu_ids[] = {
> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),	/* Renoir */
> +	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL),	/* Lucienne */
> +	{}
> +};
> +
> +bool force_storage_d3(void)
> +{
> +	return x86_match_cpu(storage_d3_cpu_ids);
> +}
> 

Tested-by: Julian Sikorski <belegdol@gmail.com>
