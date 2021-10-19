Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D845243395D
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Oct 2021 16:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhJSO7b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Oct 2021 10:59:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232109AbhJSO7a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Oct 2021 10:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634655437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jVtJ+jWtoyifMEkXi2ijdTEVKJmm5rBLCAV/XYMHwdQ=;
        b=IgzpJ/qFRYMN5/XYQudUsAj+wO38P7PsduyVPR64PSSsvhk7iOqXB/l/2774stiJsRtv7h
        +l+u3XTKEZj+ASzWeKR3e68O2UDYL+b94UM2qhlLN3f2cc3B3TZXVu5SbZeEVmvsGijZ+R
        u3OgKj3ftAVFZJrwl9UWL7sD9QHAUNw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-xaAy_-TCNXKCb2ltmeJEtw-1; Tue, 19 Oct 2021 10:57:16 -0400
X-MC-Unique: xaAy_-TCNXKCb2ltmeJEtw-1
Received: by mail-ed1-f70.google.com with SMTP id l22-20020aa7c316000000b003dbbced0731so17868381edq.6
        for <linux-acpi@vger.kernel.org>; Tue, 19 Oct 2021 07:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jVtJ+jWtoyifMEkXi2ijdTEVKJmm5rBLCAV/XYMHwdQ=;
        b=UaAdyB6g+S0wSHJw91DICLIXfZfNWNqad2ZWCq/yIcKCRJ5YHYulfAU+1vq/6XVT/q
         OtTP24NoeDpK1QI9daDSyCXKI5ybZ9b9AQsbz5QsAqX7vIvizq2YWt4Nq1lJMBaBA+yx
         GiIz5yi9CnLGJvJ8TG7moCk5ON/UAnuSrl9Mr9+rmHTOmU+KOU1m0bRhEm5mzrzls3A8
         z0b9L0DzN1bme1dPderVyVHH+4Mptyu5fpdry5WAcbYp1tkyUQnkamCU39fshSgpxYrP
         GPu/ta8GuOl9EE3DL+6kKRKVTbhc0IKpiR6I9PEeic0ZmT0p/SLGk9tImdtDyYz+rHjD
         nF6Q==
X-Gm-Message-State: AOAM531v86ytxJMYxM90s3XBFHd3wCqCi1Xa9aStyeY6F/HBuBHqzJNB
        k2+WX4RZaNcZxnspug1XIzy0705MYFqRJ68jSGjU8F5hP6qXPDcRK2wZ3VQ9pLrt6mgab7jcyyS
        645oKdKnMkpcKUSGp7TA2sg==
X-Received: by 2002:a05:6402:c11:: with SMTP id co17mr12026207edb.36.1634655434885;
        Tue, 19 Oct 2021 07:57:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRGGeys2qHXAWbVnVawsUZF5Og/F7GAcshOuREMS9vGiX8Rvt69GA/Z2U4kPt/F/iRFH87BA==
X-Received: by 2002:a05:6402:c11:: with SMTP id co17mr12026181edb.36.1634655434753;
        Tue, 19 Oct 2021 07:57:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id z4sm10407243ejw.46.2021.10.19.07.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 07:57:14 -0700 (PDT)
Message-ID: <5f767384-a458-3b8f-6111-45e09b77af41@redhat.com>
Date:   Tue, 19 Oct 2021 16:57:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 6/7] platform: x86: ideapad-laptop: Use
 ACPI_COMPANION() directly
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ike Panhc <ike.pan@canonical.com>,
        platform-driver-x86@vger.kernel.org
References: <4369779.LvFx2qVVIh@kreacher> <1727796.VLH7GnMWUR@kreacher>
 <8000884.T7Z3S40VBb@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <8000884.T7Z3S40VBb@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/13/21 18:13, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ACPI_HANDLE() macro is a wrapper arond the ACPI_COMPANION()
> macro and the ACPI handle produced by the former comes from the
> ACPI device object produced by the latter, so it is way more
> straightforward to evaluate the latter directly instead of passing
> the handle produced by the former to acpi_bus_get_device().
> 
> Modify ideapad_acpi_add() accordingly (no intentional functional
> impact).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

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
> 
> v1 -> v2:
>    * Resend with a different From and S-o-b address.  No other changes.
> 
> ---
>  drivers/platform/x86/ideapad-laptop.c |    8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/platform/x86/ideapad-laptop.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/x86/ideapad-laptop.c
> +++ linux-pm/drivers/platform/x86/ideapad-laptop.c
> @@ -1534,17 +1534,13 @@ static void ideapad_check_features(struc
>  
>  static int ideapad_acpi_add(struct platform_device *pdev)
>  {
> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
>  	struct ideapad_private *priv;
> -	struct acpi_device *adev;
>  	acpi_status status;
>  	unsigned long cfg;
>  	int err, i;
>  
> -	err = acpi_bus_get_device(ACPI_HANDLE(&pdev->dev), &adev);
> -	if (err)
> -		return -ENODEV;
> -
> -	if (eval_int(adev->handle, "_CFG", &cfg))
> +	if (!adev || eval_int(adev->handle, "_CFG", &cfg))
>  		return -ENODEV;
>  
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> 
> 
> 

