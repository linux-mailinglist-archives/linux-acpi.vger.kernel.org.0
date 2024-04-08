Return-Path: <linux-acpi+bounces-4718-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A78989BB86
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 11:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897DDB22070
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 09:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A87C47F7C;
	Mon,  8 Apr 2024 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtvdTwny"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C914594B
	for <linux-acpi@vger.kernel.org>; Mon,  8 Apr 2024 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712568071; cv=none; b=f6N6gko4AZyE3GOdXxO9FtYgoZgqlOC0VvS1AtI8Z2rOY99CDiOFkiI9rS+TK2iKzyB/bPUiAv6FhNRZDJbBty5WzV0urVG7hTC+WJbGUVk3XsJQoYAgFwhVyVbQMDlmTaIGc4adUX1VqNkI2qQ3nDm9052zpYKcN47s0KDcm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712568071; c=relaxed/simple;
	bh=LlWw5D5iq3eRsOKi/6cRekmwRU6E2z6fXUzoAVyRkgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEL/ARLQAurKyox9Nxs5psFwZapRf85CTZA82DIliyjNw8P/o8dgMW9NusAhxcmcbP4EBws5mWMvHmc9Zplk1AoLHvK2BLKVv+iWX6Qwrij2YrLHA+fh7vaEt6zid9TIqksQY1zO5qhrtw2Jp5Bt6lBnO1ScRcTQKtnmRnYAg98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtvdTwny; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712568066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXql7UyGB0xfCaYsiXkmotNqC4Ch89jqlagi6eSTNP4=;
	b=TtvdTwnyeE8jL6BVawSrz3gj74oxe8k3jfOgLkJcgowRAVf7k7RwV00wl0B3Zna+/wxo1Z
	NyzEoaQB1TyRTeiccznsA7su9rJ7YCH1E9xqLklTonVrlyySr2MS2DW7D20214tA5qTWgs
	oH5yq0DcR0MB4c7c6+G6l0agMF6Fmtg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-M3AGzIkYOa21i-ECXOZOOA-1; Mon, 08 Apr 2024 05:21:02 -0400
X-MC-Unique: M3AGzIkYOa21i-ECXOZOOA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a4698fc37dfso272457066b.2
        for <linux-acpi@vger.kernel.org>; Mon, 08 Apr 2024 02:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712568061; x=1713172861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXql7UyGB0xfCaYsiXkmotNqC4Ch89jqlagi6eSTNP4=;
        b=c0nsPQfW/qfZHvlBtAwfjWg8MbvclKzTvAF4ZYwLsFAkexzrxFPqI/TbOAP0p0fO8V
         9mlSc+/AVdsy1j52PNNHxJwfe4qQ4tNOpzg1pxWwfekowGB7a9th0Z8X3nrzlSOpTBYG
         bFcNeTQmmE1URdOxAkAgo8sHhT9bwBn1YTzJBF9SpGk4tdY8r8/ZG27TIS4itLIawOmc
         LalvF1bqaQN/sNogZJU/cu1SCxeic2lnH7+KqZpFgI8UnMY9TiDXcoSdrqtgr0m6fm+e
         Ed/OaF41Na6rcIA7dLF0+gDU8OjEUp8o1JHgeVyJ611Ok0fib8ba6h20l0fUsL9vzgrB
         n9fA==
X-Forwarded-Encrypted: i=1; AJvYcCW7xYMygycTo2RQt+5gGyw8EEnT/8CSdpcAZCztIqu47pwaeCTXR2+blAlCsR5q+F13nL9rk9or/8npnjyKc2kklTqxS0nmcO57HA==
X-Gm-Message-State: AOJu0Yx1uymvffqFDX61oqLsj7heNxMCKGwrFAKS8JNAygiuwYM3KE/M
	jyTvAeQ0OeGrzxkyPpC5SxuW/8uxmemAxEtXTdiCOutc788vOMIAc7aen6UgvBba6krfxPwkDOL
	mxEx4+wGS20NRhIKq1Hei3pIVM8yOJmCJGSOW8d7rxFpobEs1La3G9fA9SeA=
X-Received: by 2002:a17:906:af7b:b0:a46:1d4b:d81 with SMTP id os27-20020a170906af7b00b00a461d4b0d81mr5221300ejb.62.1712568061724;
        Mon, 08 Apr 2024 02:21:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWOk6NEUrk9lnCfVbhMKNrjuoMqwfAbqHURxAw52jR4biGZq5z+GiQk0FKFdfGm0nyfmNnwA==
X-Received: by 2002:a17:906:af7b:b0:a46:1d4b:d81 with SMTP id os27-20020a170906af7b00b00a461d4b0d81mr5221290ejb.62.1712568061420;
        Mon, 08 Apr 2024 02:21:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id o12-20020a170906358c00b00a51d0690052sm1617988ejb.124.2024.04.08.02.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 02:21:01 -0700 (PDT)
Message-ID: <2dd4f820-8b94-4e9b-909c-b43cb40bfc99@redhat.com>
Date: Mon, 8 Apr 2024 11:21:00 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: quickstart: Fix race condition when
 reporting input event
To: Armin Wolf <W_Armin@gmx.de>, ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240327214524.123935-1-W_Armin@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240327214524.123935-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/27/24 10:45 PM, Armin Wolf wrote:
> Since commit e2ffcda16290 ("ACPI: OSL: Allow Notify () handlers to run
> on all CPUs"), the ACPI core allows multiple notify calls to be active
> at the same time. This means that two instances of quickstart_notify()
> running at the same time can mess which each others input sequences.
> 
> Fix this by protecting the input sequence with a mutex.
> 
> Compile-tested only.
> 
> Fixes: afd66f2a739e ("platform/x86: Add ACPI quickstart button (PNP0C32) driver")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
> This applies on the branch "review-hans". Maybe we could somehow
> document the concurrency rules for ACPI notify handlers?
> ---
>  drivers/platform/x86/quickstart.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/platform/x86/quickstart.c b/drivers/platform/x86/quickstart.c
> index ba3a7a25dda7..e40f852d42c1 100644
> --- a/drivers/platform/x86/quickstart.c
> +++ b/drivers/platform/x86/quickstart.c
> @@ -18,6 +18,7 @@
>  #include <linux/input/sparse-keymap.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  #include <linux/sysfs.h>
>  #include <linux/types.h>
> @@ -35,6 +36,7 @@
> 
>  struct quickstart_data {
>  	struct device *dev;
> +	struct mutex input_lock;	/* Protects input sequence during notify */
>  	struct input_dev *input_device;
>  	char input_name[32];
>  	char phys[32];
> @@ -73,7 +75,10 @@ static void quickstart_notify(acpi_handle handle, u32 event, void *context)
> 
>  	switch (event) {
>  	case QUICKSTART_EVENT_RUNTIME:
> +		mutex_lock(&data->input_lock);
>  		sparse_keymap_report_event(data->input_device, 0x1, 1, true);
> +		mutex_unlock(&data->input_lock);
> +
>  		acpi_bus_generate_netlink_event(DRIVER_NAME, dev_name(data->dev), event, 0);
>  		break;
>  	default:
> @@ -147,6 +152,13 @@ static void quickstart_notify_remove(void *context)
>  	acpi_remove_notify_handler(handle, ACPI_DEVICE_NOTIFY, quickstart_notify);
>  }
> 
> +static void quickstart_mutex_destroy(void *data)
> +{
> +	struct mutex *lock = data;
> +
> +	mutex_destroy(lock);
> +}
> +
>  static int quickstart_probe(struct platform_device *pdev)
>  {
>  	struct quickstart_data *data;
> @@ -165,6 +177,11 @@ static int quickstart_probe(struct platform_device *pdev)
>  	data->dev = &pdev->dev;
>  	dev_set_drvdata(&pdev->dev, data);
> 
> +	mutex_init(&data->input_lock);
> +	ret = devm_add_action_or_reset(&pdev->dev, quickstart_mutex_destroy, &data->input_lock);
> +	if (ret < 0)
> +		return ret;
> +
>  	/* We have to initialize the device wakeup before evaluating GHID because
>  	 * doing so will notify the device if the button was used to wake the machine
>  	 * from S5.
> --
> 2.39.2
> 


