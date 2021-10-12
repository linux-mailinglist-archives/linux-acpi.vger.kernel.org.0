Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B379042ABAD
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 20:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhJLSPM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 14:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbhJLSPL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Oct 2021 14:15:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C78C061570;
        Tue, 12 Oct 2021 11:13:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a25so2772772edx.8;
        Tue, 12 Oct 2021 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Gbt771FcUpKhRbY7l1qKOaogjRjP2WQTDl1Nm1Sbb5s=;
        b=nR9m8poegxkbYqSEvu0sGbUleY5y9j4ueU4x0z4zFGBeys0kxAWQ0tARkgRqTqu58Q
         zfZ9wYkH2kqgTE+0+q6LurNMt2LcMdgnTtt1xDdn9xrPz3s/LY7bz2oD+jWv0XByqj3w
         jkeyX34/ZnkEtgdP0lvrulDXik6yBqQvRGnfestR3ZuFGUfIuMcMF5qHAjKSTddVcuuO
         E+C+wmcO3Bd6uqHKYG6MlV21XkeHJmEKiQpJWlg1AdwuLlWxVDboZeXHaxGqoc2dVLIQ
         SBt06KJjQQG0fEOztcMnlu0HESWOwZsnmPf45daNJV9su55j0pRqyEHuxZp/UowstN+Q
         SoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Gbt771FcUpKhRbY7l1qKOaogjRjP2WQTDl1Nm1Sbb5s=;
        b=RKcw2DsJOTOyUVYjw9osUhC4K9pLzlb6ftXZ0brVTYqrnDI/wnr80Qs/MVZ3zljtPD
         H+Fl47wwK7lxenIpPB5z29ttAGohxUotZ59O6VyE1Hfuiw+UTy0brWgsIQkS2GC2eUCE
         UMuA/+B0OwZIBoeHODvSWy6eYJHyvWBQD9qDi5tMYuSsFaZFNxRzD59OUxlq5CPOjyTM
         iHzh3OMNuP8lIJv1+H4zm8/F52QtayhrQEGz2GQfnBnUBhqkkw+h2SaXbTMonDR1G0qR
         J6U4Te6KqoZsWnM7+tXAM+cr/3krnTEbSrx2Is5gacT0qPcpRN4lBGHuzhZaiKAIPczy
         5UbQ==
X-Gm-Message-State: AOAM5302E/4ltMXDs5TS+/t7EBZy7mKm/wsmGHJo2ZuV9Tzqpwo6WtZq
        dbR1E/PbAIlLzQUQDQfdxMw=
X-Google-Smtp-Source: ABdhPJwbZy3JHKQpZ5UY5oPwLwwgrSNtl5KLlgVD6eaf1lk6xQeON7r1+S/KRDcGC/hdkS8l1to66g==
X-Received: by 2002:a50:da48:: with SMTP id a8mr1752981edk.146.1634062384153;
        Tue, 12 Oct 2021 11:13:04 -0700 (PDT)
Received: from [10.20.0.4] ([194.126.177.11])
        by smtp.gmail.com with ESMTPSA id nd36sm5422846ejc.17.2021.10.12.11.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 11:13:03 -0700 (PDT)
Message-ID: <f8ab041f-fe54-baf3-a378-f6807a7d3e01@gmail.com>
Date:   Tue, 12 Oct 2021 20:13:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 4/7] surface: surface3-wmi: Use ACPI_COMPANION()
 directly
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
References: <4369779.LvFx2qVVIh@kreacher> <3414042.iIbC2pHGDl@kreacher>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <3414042.iIbC2pHGDl@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 10/12/21 19:44, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael@kernel.org>
> 
> The ACPI_HANDLE() macro is a wrapper arond the ACPI_COMPANION()
> macro and the ACPI handle produced by the former comes from the
> ACPI device object produced by the latter, so it is way more
> straightforward to evaluate the latter directly instead of passing
> the handle produced by the former to acpi_bus_get_device().
> 
> Modify s3_wmi_check_platform_device() accordingly (no intentional
> functional impact).
> 
> Signed-off-by: Rafael J. Wysocki <rafael@kernel.org>

Looks good to me.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/platform/surface/surface3-wmi.c |    9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/platform/surface/surface3-wmi.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/surface/surface3-wmi.c
> +++ linux-pm/drivers/platform/surface/surface3-wmi.c
> @@ -139,13 +139,12 @@ static acpi_status s3_wmi_attach_spi_dev
>   
>   static int s3_wmi_check_platform_device(struct device *dev, void *data)
>   {
> -	struct acpi_device *adev, *ts_adev = NULL;
> -	acpi_handle handle;
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	struct acpi_device *ts_adev = NULL;
>   	acpi_status status;
>   
>   	/* ignore non ACPI devices */
> -	handle = ACPI_HANDLE(dev);
> -	if (!handle || acpi_bus_get_device(handle, &adev))
> +	if (!adev)
>   		return 0;
>   
>   	/* check for LID ACPI switch */
> @@ -159,7 +158,7 @@ static int s3_wmi_check_platform_device(
>   	    strlen(SPI_CTL_OBJ_NAME)))
>   		return 0;
>   
> -	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, adev->handle, 1,
>   				     s3_wmi_attach_spi_device, NULL,
>   				     &ts_adev, NULL);
>   	if (ACPI_FAILURE(status))
> 
> 
> 
