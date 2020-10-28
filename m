Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC4329DC3C
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 01:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388926AbgJ2AWd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Oct 2020 20:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388923AbgJ1WiD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Oct 2020 18:38:03 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32F3C0613CF;
        Wed, 28 Oct 2020 15:38:01 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w27so1205019ejb.3;
        Wed, 28 Oct 2020 15:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=s/GAYx7ZPx5cYyrJpIiN2TWEaOxiqi1GSB3L4+92Y2c=;
        b=Uv8TJqqZ8sNRjgWSCSuYWFsDZgmVzYOFXrASP3oE9Ka4DpUCAZf26XFlpHKPV4wPzm
         1hTs0h4i2zVlFe7hi1nf4Gc+ilS3NA7c8LS+hOWDQ9KmBdk0zYj4QQPtqlY9GUNAo+al
         Y3alnowM1S+oTkOr7Wvu43bHjPo/7S4eHatuUxNghefi+GNYptku2n4md7lvJHSRwI47
         Bt+5pZXvHu8M95SljAXilBFBlL/AZha7En9I3wvwNam5wAcioDY7YPjxoCkhJqIeQNM9
         nB0cVo7pEvpW3x/RjQprr4tQyyHq9YpF+tTvo5EwUcIq8UAoIHAwm5W324mnm2ilz7qj
         zpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s/GAYx7ZPx5cYyrJpIiN2TWEaOxiqi1GSB3L4+92Y2c=;
        b=Ex4pLo40bDq+1SqsF2LKqm1BNuAUyShcQiJgGPdqIJF4AnjI6/yXduhOB0Ib5S1IOq
         n42s4hUmz8CBdbslzz7f2eE6yc+V6+j6RglHkpDzElXZFXkIBRTRB3qimSE19Bxi1MEn
         OHzJxE4qsHPgL9tE5q1t0ovxuF8UAuqDRX6gfN9mUBHexST4FC3ASaB+rAukEswSy0Zf
         idommq6JbZ4xqbjH/hFRr+yk1TmMlgsxEGaKT+Uc485Te+Z9LhvZQXSc3sFcqdwzYwzy
         EShDfxOtGCniy6nShU/tSFXtLhckzrkF1Gked7nxYPpe0mRQzXvvYVfmEC+ztI9aXYLk
         SC4Q==
X-Gm-Message-State: AOAM5314Fka/fIMbZQIqHxK1O/UidPm0DIgwfttd6H5fi2LgJTKFQmK9
        RTGwu+OhShbeJnuFD62jNBDDs6eoPTA=
X-Google-Smtp-Source: ABdhPJzA1yToYKpCKuK4NAqE6UeeWarnejBXdNhdxv86i3dO+xwNlFDh0dmkO2He/v5J73RT3owQSg==
X-Received: by 2002:a05:6402:141:: with SMTP id s1mr4129789edu.87.1603881678274;
        Wed, 28 Oct 2020 03:41:18 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a52a.dip0.t-ipconnect.de. [217.229.165.42])
        by smtp.gmail.com with ESMTPSA id 64sm561440eda.63.2020.10.28.03.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 03:41:17 -0700 (PDT)
Subject: Re: [PATCH v4] platform/surface: Add Driver to set up lid GPEs on MS
 Surface device
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201023140802.1916057-1-luzmaximilian@gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <44362c2a-14f4-bda0-0539-58543c6329a0@gmail.com>
Date:   Wed, 28 Oct 2020 11:41:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201023140802.1916057-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 10/23/20 4:08 PM, Maximilian Luz wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8ff126ced757..31271180dae3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11532,6 +11532,12 @@ F:	drivers/scsi/smartpqi/smartpqi*.[ch]
>   F:	include/linux/cciss*.h
>   F:	include/uapi/linux/cciss*.h
>   
> +MICROSOFT SURFACE GPE LID SUPPORT DRIVER
> +M:	Maximilian Luz <luzmaximilian@gmail.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/x86/surface_gpe.c

This should of course read

     F: drivers/platform/surface/surface_gpe.c

Sorry for that rookie mistake. Will fix asap.

Regards,
Max
