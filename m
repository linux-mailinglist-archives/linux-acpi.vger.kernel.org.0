Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8BA42AD5E
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 21:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhJLTm1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 15:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhJLTm1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Oct 2021 15:42:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E885DC061570;
        Tue, 12 Oct 2021 12:40:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a25so532332edx.8;
        Tue, 12 Oct 2021 12:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9ZlHAKhM6N5LWSJ0H9cpUyXSjibNn8t27gveufH00sQ=;
        b=mazdcSI54JoLZctBQEgPf5MC1Dmb/Ci1bLxBSeNBKImaXm8ShICZKo/NxiSvCC3RpL
         Zs5t46hgoa8jPyk8itvrJRIZTRFR3/kCGwxVE+tmDIzabsOU4KelCgp2hqRW0imhQ2Ny
         0cWrJqHQM+in9eroel9aFVA7CzZ3euUDSd3wai5/dh1jyZw1KqYRleDg2YNl3YjgufuG
         8Om9bHvcPhjXpyo7RtecBKUqTU8+1ShTDa4xENA4+eHITNhPRkQe8/oriGK4i27CV+ik
         XEWSXmLM/V02ycMVOW+KONuUP/Ez9mYgRLWaueexFBDJerkEVQuV+H4c/pDpSyb4cUsQ
         AeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9ZlHAKhM6N5LWSJ0H9cpUyXSjibNn8t27gveufH00sQ=;
        b=BaNGn7nULkGFOiPUGOYe3hxjYJseiw9XX99UF6zMOyrkCZmdPbvHwrtI4j3L6tSBoW
         Ez0vQL5T1JnESDHopw9rdDtp3w7hvh+gjHtOQY4W9bUK2Mj25VRYp2s40gD9Hld0eX9Y
         3nBYdM2e2L0n0TFjlgLLwKkYmrwYygQa55VJvX37r9IBIq0F2NZwy72MRU3k5U4YEAoU
         rYG/3Ph4uTjQEr+ZKEiZdTPl/BLoVFN4s75MTjXVm4HbDdNxJ8eEPh3GtWC4qjZ2VQ7C
         p0+pBbR0FcqMA2U0kS/I/jQ+NS1EJxaFbHTvCgXDAi7vEGJ16e6N6tQKSOhT6QGmHx//
         9rUw==
X-Gm-Message-State: AOAM5330hbAf7zCTbMQ07B/+RB+bnOywPLSjP5fDBxESY5K0LdnbT/gi
        n9le2rZwFyXWepz2ci8UpJHF9D3d/sE=
X-Google-Smtp-Source: ABdhPJw9o+1NbJFUnIHS2jbUWIqY8U4CmeNjyPRAI48xK30yppOWeF3v18X93fh11QLQwmaZCG30PQ==
X-Received: by 2002:a17:906:3c51:: with SMTP id i17mr35892214ejg.86.1634067623475;
        Tue, 12 Oct 2021 12:40:23 -0700 (PDT)
Received: from [10.20.0.4] ([194.126.177.11])
        by smtp.gmail.com with ESMTPSA id r22sm5342214ejd.109.2021.10.12.12.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 12:40:23 -0700 (PDT)
Message-ID: <c83e0e75-0a6a-53b5-5eb0-e0033f844b81@gmail.com>
Date:   Tue, 12 Oct 2021 21:40:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 5/7] surface: surface3_power: Drop redundant
 acpi_bus_get_device() call
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
References: <4369779.LvFx2qVVIh@kreacher> <3089655.5fSG56mABF@kreacher>
 <2503491.Lt9SDvczpP@kreacher>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <2503491.Lt9SDvczpP@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 10/12/21 21:32, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael@kernel.org>
> 
> If the ACPI companion of a given device is not present, the result
> of the ACPI_HANDLE() evaluation for it will be NULL, so calling
> acpi_bus_get_device() on ACPI_HANDLE() result in order to validate
> it is redundant.
> 
> Drop the redundant acpi_bus_get_device() call from mshw0011_notify()
> along with a local variable related to it.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael@kernel.org>
> ---
> 
> v1 -> v2:
>     * Instead of switching over to using ACPI_COMPANION(), just drop the
>       redundant acpi_bus_get_device() call from mshw0011_notify() and
>       update the subject and changelog accordingly.
> 

Thanks, looks good to me!

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/platform/surface/surface3_power.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/platform/surface/surface3_power.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/surface/surface3_power.c
> +++ linux-pm/drivers/platform/surface/surface3_power.c
> @@ -159,12 +159,11 @@ mshw0011_notify(struct mshw0011_data *cd
>   		unsigned int *ret_value)
>   {
>   	union acpi_object *obj;
> -	struct acpi_device *adev;
>   	acpi_handle handle;
>   	unsigned int i;
>   
>   	handle = ACPI_HANDLE(&cdata->adp1->dev);
> -	if (!handle || acpi_bus_get_device(handle, &adev))
> +	if (!handle)
>   		return -ENODEV;
>   
>   	obj = acpi_evaluate_dsm_typed(handle, &mshw0011_guid, arg1, arg2, NULL,
> 
> 
> 
