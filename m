Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3242EABB9
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Jan 2021 14:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbhAENSQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Jan 2021 08:18:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727864AbhAENSP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jan 2021 08:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609852608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LtvpE51PJaJIshJkk/nmlb3ypMZHhp2FfVBDGEueVK0=;
        b=O0/ymIGCLFtmV8BOWfUH6ZI9QCpobDhBxB5C63hjdsD3N6143etsLFHY4mm6rOwtuo4uSS
        a9wW/aSFJeS4Fcx6TvBf4idr5ccexdymIeN6t1ZMsoTGrNkqsA6VMNKLwTVcrOFItYuDOe
        8/icGCgdYl/Yaf9dBKGfCPSYqZbLxDc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-XoLCeOmiNqyRioSPusS38w-1; Tue, 05 Jan 2021 08:16:47 -0500
X-MC-Unique: XoLCeOmiNqyRioSPusS38w-1
Received: by mail-ej1-f69.google.com with SMTP id h17so7900229ejk.21
        for <linux-acpi@vger.kernel.org>; Tue, 05 Jan 2021 05:16:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LtvpE51PJaJIshJkk/nmlb3ypMZHhp2FfVBDGEueVK0=;
        b=qKg/ApnQBJ4+fZ8NePwHlmGiEwwPq522THhvaJZKnzZH9tm2nZvB4xCbP9CDRWPQZ3
         mRLeGGQ9ZgdQwhkh9w5+8hBzzhDvOp4O1SzJDNRAPLvveSn6ZdPxQ2bBRrxg8eeAzp8t
         krFuFyHve4sbbdzvJMdPaa8B4bFJYWSAt2jR1MGYnCsxgUCc2jmh+IkfCgTA40++CRsH
         NDcNMzWaAMkGM93dTahyscwPK8HBkfWWprPrh3XYKBs6thbxc1infsWcVETnPprf9nsk
         TZDSQ1BUJrCZ51FCjdMLO2uZZN+vRJ3PTwQHz9ShcQ/OWsaAktcv+Z/jfQkYRNzqECt4
         kMTA==
X-Gm-Message-State: AOAM530XKLgD+yyPuDlzpGWGQAo1PI/8gxq0tB8vY3dfvZd8bvMx/WxH
        Br3lBnF4fVg99+F5lvuAxlCFqy1U1Kq8/wagPHJpZlw8e3SufV3fPRRFskgnUYHyEA+482eaDhJ
        84vJ+sYk3JZPZe2LIa94gXg==
X-Received: by 2002:a17:906:351a:: with SMTP id r26mr67935436eja.204.1609852605859;
        Tue, 05 Jan 2021 05:16:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzR8665AcodeuSJbYBLUiasXhwrRCFhXP5UBpYr9ukaXtBLdpvwkT7bCIIXAfTHAulHtc13TA==
X-Received: by 2002:a17:906:351a:: with SMTP id r26mr67935430eja.204.1609852605708;
        Tue, 05 Jan 2021 05:16:45 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id e1sm24929834edk.51.2021.01.05.05.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 05:16:45 -0800 (PST)
Subject: Re: [PATCH v2 1/2] ACPI: platform-profile: Introduce object pointers
 to callbacks
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        platform-driver-x86@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Ike Panhc <ike.pan@canonical.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210105131447.38036-1-jiaxun.yang@flygoat.com>
 <20210105131447.38036-2-jiaxun.yang@flygoat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <683c8358-fd71-cd27-8e39-19fdf3e1f71f@redhat.com>
Date:   Tue, 5 Jan 2021 14:16:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210105131447.38036-2-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/5/21 2:14 PM, Jiaxun Yang wrote:
> Add a object pointer to handler callbacks to avoid having
> global variables everywhere.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/acpi/platform_profile.c  | 4 ++--
>  include/linux/platform_profile.h | 6 ++++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 91be50a32cc8..bb4d7b0fe2ac 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -64,7 +64,7 @@ static ssize_t platform_profile_show(struct device *dev,
>  		return -ENODEV;
>  	}
>  
> -	err = cur_profile->profile_get(&profile);
> +	err = cur_profile->profile_get(cur_profile, &profile);
>  	mutex_unlock(&profile_lock);
>  	if (err)
>  		return err;
> @@ -104,7 +104,7 @@ static ssize_t platform_profile_store(struct device *dev,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	err = cur_profile->profile_set(i);
> +	err = cur_profile->profile_set(cur_profile, i);
>  	mutex_unlock(&profile_lock);
>  	if (err)
>  		return err;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 3623d7108421..43f4583b5259 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -28,8 +28,10 @@ enum platform_profile_option {
>  
>  struct platform_profile_handler {
>  	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> -	int (*profile_get)(enum platform_profile_option *profile);
> -	int (*profile_set)(enum platform_profile_option profile);
> +	int (*profile_get)(struct platform_profile_handler *pprof,
> +				enum platform_profile_option *profile);
> +	int (*profile_set)(struct platform_profile_handler *pprof,
> +				enum platform_profile_option profile);
>  };
>  
>  int platform_profile_register(const struct platform_profile_handler *pprof);
> 

