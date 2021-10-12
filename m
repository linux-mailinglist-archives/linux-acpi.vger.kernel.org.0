Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E53B42ABCD
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 20:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhJLSXo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 14:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhJLSXo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Oct 2021 14:23:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9865EC061570;
        Tue, 12 Oct 2021 11:21:41 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i20so2756824edj.10;
        Tue, 12 Oct 2021 11:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MFVuZrdOHdoGSfOEt0pRo42UMtYCScP5y9KYqR5Gv7I=;
        b=P/SY5Vdz/dKYEPV/1+NARq+1zThf1F+nGG1LM3CNxH6dNNaI/QdcDQm9ih6lAQl7dp
         UuvySsZqacP4RUYxH8BhQQr/0Q+qxiBQxWq+XuMvDjunFApyFUhq6t60Gj2HZ4VYbi8e
         jBHr73J+GSJZqWJjo5W/Ia00rVOiMAWsGyxE4oO1yVTRlPD7OjA9ro5MZYlSyTTL+G3g
         I4DtsQpsnR8ve9htkPWIkuA949qFD3CLW5vNcUeiPYuLA4rAKBQsZGw7X4RghESL9ePK
         7/oZ4iapwo27Nei+F0t8lTEPNSg22NRMxOWEVwPwukDccdl9DYuqrxdYklmscDE8CSWW
         OJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MFVuZrdOHdoGSfOEt0pRo42UMtYCScP5y9KYqR5Gv7I=;
        b=G/0487Uk7Ns4FWR036q2uRYA8eN2G0pbQEn5gBphHZxmHBFkm7QCMFQ6GyWU3keFDm
         rsRB6uBX8pRuXIVA/NYOSVbPUTn7tQkYAQSZ9AqOW7u6Zd+QOVDgshG9DKJ5+wjuz1zf
         3d+DJSj2ezboh/Elz9X1zhrkKIj2y7RFeSXxAW55A9XAfXyV3rEsIkWEkpztExDBCiYv
         IY8RxK44NQqHWTQt6zpRrlJxhVIiVbtNHf4F+abJSfVYWptY++aeHgU2klUIFl56oRXs
         yEIyaexSuqvtodDY4Gj+apx9DoEkE+2sw8L/BZ0X2/DRAZepnnal1bqZJ6ZR0cxyVBje
         YVSw==
X-Gm-Message-State: AOAM533GOhZ1tQl719jtKATEOTWvZbO5W+mAftubP8mrD2gvztLiniIK
        eec+CNhaFY6/Yeu6Q/Bd23QGE/1UTH8=
X-Google-Smtp-Source: ABdhPJyT8BreXzV8eO7gg29MQj0v8lbG5wpNCf9Ns7ixilZABJ3kS7QVqS0HF68c9J4APwoo3gvShg==
X-Received: by 2002:a50:da04:: with SMTP id z4mr1872352edj.52.1634062899284;
        Tue, 12 Oct 2021 11:21:39 -0700 (PDT)
Received: from [10.20.0.4] ([194.126.177.11])
        by smtp.gmail.com with ESMTPSA id fx4sm5309875ejb.113.2021.10.12.11.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 11:21:38 -0700 (PDT)
Message-ID: <e15036b7-b41f-a5cf-b8a6-b1b9023197cd@gmail.com>
Date:   Tue, 12 Oct 2021 20:21:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 5/7] surface: surface3_power: Use ACPI_COMPANION()
 directly
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
References: <4369779.LvFx2qVVIh@kreacher> <3089655.5fSG56mABF@kreacher>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <3089655.5fSG56mABF@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 10/12/21 19:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael@kernel.org>
> 
> The ACPI_HANDLE() macro is a wrapper arond the ACPI_COMPANION()
> macro and the ACPI handle produced by the former comes from the
> ACPI device object produced by the latter, so it is way more
> straightforward to evaluate the latter directly instead of passing
> the handle produced by the former to acpi_bus_get_device().
> 
> Modify mshw0011_notify() accordingly (no intentional functional
> impact).
> 
> Signed-off-by: Rafael J. Wysocki <rafael@kernel.org>

Looks mostly good to me, small comment/question inline.

> ---
>   drivers/platform/surface/surface3_power.c |    9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/platform/surface/surface3_power.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/surface/surface3_power.c
> +++ linux-pm/drivers/platform/surface/surface3_power.c
> @@ -160,15 +160,14 @@ mshw0011_notify(struct mshw0011_data *cd
>   {
>   	union acpi_object *obj;
>   	struct acpi_device *adev;
> -	acpi_handle handle;
>   	unsigned int i;
>   
> -	handle = ACPI_HANDLE(&cdata->adp1->dev);
> -	if (!handle || acpi_bus_get_device(handle, &adev))
> +	adev = ACPI_COMPANION(&cdata->adp1->dev);
> +	if (!adev)
>   		return -ENODEV;

Do we need to get the ACPI device (adev) here? To me it looks like only
its handle is actually used so why not keep ACPI_HANDLE() and remove the
acpi_bus_get_device() call instead?

>   
> -	obj = acpi_evaluate_dsm_typed(handle, &mshw0011_guid, arg1, arg2, NULL,
> -				      ACPI_TYPE_BUFFER);
> +	obj = acpi_evaluate_dsm_typed(adev->handle, &mshw0011_guid, arg1, arg2,
> +				      NULL, ACPI_TYPE_BUFFER);
>   	if (!obj) {
>   		dev_err(&cdata->adp1->dev, "device _DSM execution failed\n");
>   		return -ENODEV;
> 
> 
> 

Regards,
Max
