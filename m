Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F1C2E975C
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 15:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbhADOfr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 09:35:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28962 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbhADOfr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2021 09:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609770860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PTEfEjtKePQ0/JuJ57gSim73GubJunX7YVIOZ0Wadjk=;
        b=XgkBdGGXgLzOFxq3GgtW5/naqY8iCVZoUoKBMf/uiAUaHFzxZ112kjxgX7I03Xpz4X4jrx
        JopTplP8yowASpMrVwHG9xCzLlt5wGU5ARX2xVNXXtZEglkTKKaPVq6vsQkIq/A7ke/ymm
        yMu5XntlWMhnEhoFUwSipLYCkE6hh1w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-4GZa4yW8PiijaE6fr4_G1g-1; Mon, 04 Jan 2021 09:34:19 -0500
X-MC-Unique: 4GZa4yW8PiijaE6fr4_G1g-1
Received: by mail-ed1-f70.google.com with SMTP id cq17so12308874edb.17
        for <linux-acpi@vger.kernel.org>; Mon, 04 Jan 2021 06:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PTEfEjtKePQ0/JuJ57gSim73GubJunX7YVIOZ0Wadjk=;
        b=ATYPRuHDmNy/6glRAKywbkJ/g2HBxbmEaOjUzZo2NLB4WVchRt9FY3JPbBtMIKjM5E
         6voGubcl8dRASCTM53el+g2FZWdJBpAycDXEmrEQRFY58fTGQebGgWCLJ3ie21C49mhR
         AvnbZhTztTAW+gxu+sE0/Kuae1SeG+8ZGSHeiNbAIsEaKqcEJWqNilDmTkhYO7IWbtzY
         /GbKTagtxq5S43cB2zS/viWxSrah+6xTc7lf66yg8smJQmXmAl+93o705cbcGrtVfvoS
         0wPZfTZLytJ/VuxgBNbFwPEriNET3ztx/8ggJiYyiIklZwp9gn6y+LItEygJjiP9VBCD
         8j4g==
X-Gm-Message-State: AOAM531yyBELfqakXcPfmxcSwMfHS6Z2EZTQkhoGxYksoiUr9x/qQFpP
        gRGfsTuU723YSs351nk+ASI/ebqvV0dsPGe9kz33hD2xrjoCRBvkDkpgZbZrUNXla44QAzLSsVm
        QP7Qjy3d2HpEc4Ds+X2x4gQ==
X-Received: by 2002:a17:906:4809:: with SMTP id w9mr66494829ejq.139.1609770858001;
        Mon, 04 Jan 2021 06:34:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6O37oPsVISpiRv4vXsFdt1QCkP08fqKLicEBFWvl0wC0+ErN5ZrtJrx0V/Uvq60GofTzJqA==
X-Received: by 2002:a17:906:4809:: with SMTP id w9mr66494821ejq.139.1609770857873;
        Mon, 04 Jan 2021 06:34:17 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id d3sm40336685edt.32.2021.01.04.06.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 06:34:17 -0800 (PST)
Subject: Re: [PATCH 1/2] ACPI: platform-profile: Introduce data parameter to
 handler
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        platform-driver-x86@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Ike Panhc <ike.pan@canonical.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210101125629.20974-1-jiaxun.yang@flygoat.com>
 <20210101125629.20974-2-jiaxun.yang@flygoat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c58562aa-b3c5-f35f-0328-06bed81db559@redhat.com>
Date:   Mon, 4 Jan 2021 15:34:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210101125629.20974-2-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/1/21 1:56 PM, Jiaxun Yang wrote:
> Add a data parameter to handler callbacks to avoid having
> global variables everywhere.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/acpi/platform_profile.c  | 4 ++--
>  include/linux/platform_profile.h | 5 +++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 91be50a32cc8..60072f6e032d 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -64,7 +64,7 @@ static ssize_t platform_profile_show(struct device *dev,
>  		return -ENODEV;
>  	}
>  
> -	err = cur_profile->profile_get(&profile);
> +	err = cur_profile->profile_get(cur_profile->data, &profile);
>  	mutex_unlock(&profile_lock);
>  	if (err)
>  		return err;
> @@ -104,7 +104,7 @@ static ssize_t platform_profile_store(struct device *dev,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	err = cur_profile->profile_set(i);
> +	err = cur_profile->profile_set(cur_profile->data, i);
>  	mutex_unlock(&profile_lock);
>  	if (err)
>  		return err;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 3623d7108421..272faf55875d 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -27,9 +27,10 @@ enum platform_profile_option {
>  };
>  
>  struct platform_profile_handler {
> +	void *data;
>  	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> -	int (*profile_get)(enum platform_profile_option *profile);
> -	int (*profile_set)(enum platform_profile_option profile);
> +	int (*profile_get)(void *data, enum platform_profile_option *profile);
> +	int (*profile_set)(void *data, enum platform_profile_option profile);
>  };
>  
>  int platform_profile_register(const struct platform_profile_handler *pprof);
> 

