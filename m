Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF563A9E09
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 16:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhFPOuT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 10:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233914AbhFPOuS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 10:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623854892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IvtAfkdui48DNcpbQR2o5Pss84Ycf8cKv7uo587U+1U=;
        b=Dsv5D/41lNWm5G2miVC5+4KJXSVizqg/zo2jjiBTY033Iz8sBwjIHpVvK4J5A5ccOZdQHQ
        1Un87t5kGShyutDqc24FPM11lp6VVQIzqYvU9XtZ0N2d+OaRuqDCKiklNIK2iHzJtCabkY
        jyLnOQrPSKVpDq3b4bZmQrgcUxNG0Kc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-j86JFSp4N92pWW_P3h1Ijg-1; Wed, 16 Jun 2021 10:48:10 -0400
X-MC-Unique: j86JFSp4N92pWW_P3h1Ijg-1
Received: by mail-ej1-f71.google.com with SMTP id hz18-20020a1709072cf2b02903fbaae9f4faso1069038ejc.4
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 07:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IvtAfkdui48DNcpbQR2o5Pss84Ycf8cKv7uo587U+1U=;
        b=Tu1671TQ2qXNHsDUhpFI3IK+D+Iks3NU+7hP9Hst1bVXkiexAkWOXlrRFa4P+EWFBF
         zLHg4gnVdZANs8ArOuYGy4G6U9ukMs6ix8rwMf4Jcx4OhK6Cb1e+uQzItsx/Gc0KA2S8
         zAGGg358XvsLshmPLbxQn+qRltcEmGSO9GL24eoSq++p8uuM2fRdjxY1gy4zx/1ats1Y
         PE+lWpUry742IpV+2ETinc5tWmgS/+plt/9lnAObO304S3MQq6G7vSLO++uHkM+Zssq5
         Y5L4Ty1eUDJt+veg6z257X1ajmkqsw8mIKI8FjpaBQ9+QvwD/CXQ6DG9CBNYoIsB/Iar
         Tp/Q==
X-Gm-Message-State: AOAM532/Fn48wUidMDSI0iUhn0rLJ7TNVXERTh57TdumpQyZlmBYG4vn
        gOpbR+GImiw2UUD05/HjQBLDjxvrORCniM44fIdpDaAd61z8ojhx3MSsrgbWuKkAs+bmD1bKpGu
        Rx7ULNtHqZ1s82lgxG6yVww==
X-Received: by 2002:a05:6402:31a8:: with SMTP id dj8mr4735666edb.296.1623854889413;
        Wed, 16 Jun 2021 07:48:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNlVZnPN4c2QDPjEhBJpunBgYCKdSnZYkQWQtFv6b4qQ4mchIgWG4G2np0uMtWo3iB6a75bQ==
X-Received: by 2002:a05:6402:31a8:: with SMTP id dj8mr4735650edb.296.1623854889281;
        Wed, 16 Jun 2021 07:48:09 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id n11sm1793001ejg.43.2021.06.16.07.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 07:48:08 -0700 (PDT)
Subject: Re: [PATCH 3/5] ACPI: scan: Fix device object rescan in
 acpi_scan_clear_dep()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <3140195.44csPzL39Z@kreacher> <7272740.EvYhyI6sBW@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0cd3a0b5-f656-2b4f-b5bc-67680bc80603@redhat.com>
Date:   Wed, 16 Jun 2021 16:48:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7272740.EvYhyI6sBW@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/16/21 4:23 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In general, acpi_bus_attach() can only be run safely under
> acpi_scan_lock, but that lock cannot be acquired under
> acpi_dep_list_lock, so make acpi_scan_clear_dep() schedule deferred
> execution of acpi_bus_attach() under acpi_scan_lock instead of
> calling it directly.
> 
> This also fixes a possible race between acpi_scan_clear_dep() and
> device removal that might cause a device object that went away to
> be accessed, because acpi_scan_clear_dep() is changed to acquire
> a reference on the consumer device object.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/scan.c |   50 +++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -2115,16 +2115,56 @@ static int acpi_dev_get_first_consumer_d
>  	return 0;
>  }
>  
> -static int acpi_scan_clear_dep(struct acpi_dep_data *dep, void *data)
> -{
> +struct acpi_scan_clear_dep_work {
> +	struct work_struct work;
>  	struct acpi_device *adev;
> +};
> +
> +static void acpi_scan_clear_dep_fn(struct work_struct *work)
> +{
> +	struct acpi_scan_clear_dep_work *cdw;
> +
> +	cdw = container_of(work, struct acpi_scan_clear_dep_work, work);
>  
> -	acpi_bus_get_device(dep->consumer, &adev);
> +	acpi_scan_lock_acquire();
> +	acpi_bus_attach(cdw->adev, true);
> +	acpi_scan_lock_release();
> +
> +	acpi_dev_put(cdw->adev);
> +	kfree(cdw);
> +}
> +
> +static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
> +{
> +	struct acpi_scan_clear_dep_work *cdw;
> +
> +	if (adev->dep_unmet)
> +		return false;
> +
> +	cdw = kmalloc(sizeof(*cdw), GFP_KERNEL);
> +	if (!cdw)
> +		return false;
> +
> +	cdw->adev = adev;
> +	INIT_WORK(&cdw->work, acpi_scan_clear_dep_fn);
> +	/*
> +	 * Since the work function may block on the lock until the entire
> +	 * initial enumeration of devices is complete, put it into the unbound
> +	 * workqueue.
> +	 */
> +	queue_work(system_unbound_wq, &cdw->work);

Hmm, I'm a bit worried about this. Even with the system_unbound_wq
some code may expect at least some progress being made with processing
works during the initial enumeration. OTOH this does run pretty early on.

Still I wonder if it would not be better to create + use our own workqueue
for this ?

I guess we can always do this if we run into issues later...

With that said / otherwise the patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> +
> +	return true;
> +}
> +
> +static int acpi_scan_clear_dep(struct acpi_dep_data *dep, void *data)
> +{
> +	struct acpi_device *adev = acpi_bus_get_acpi_device(dep->consumer);
>  
>  	if (adev) {
>  		adev->dep_unmet--;
> -		if (!adev->dep_unmet)
> -			acpi_bus_attach(adev, true);
> +		if (!acpi_scan_clear_dep_queue(adev))
> +			acpi_dev_put(adev);
>  	}
>  
>  	list_del(&dep->node);
> 
> 
> 

