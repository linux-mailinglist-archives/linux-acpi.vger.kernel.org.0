Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1B333ECC6
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Mar 2021 10:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhCQJQj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Mar 2021 05:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229745AbhCQJQV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Mar 2021 05:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615972580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ezgL+/5ajoQ5DL0i1PwRjRopGxlsHomHBU/6UBrTjAg=;
        b=PZedBeeSP/ZSt+iYybg+CgvPVy6GNW5c0tUbF9PfNMYswIgrhXzXU54q3ftadDffpds0ZE
        9I2IcPulH4m8zmIePWYtgc2sd8ZqkZq8NXmdpYKbVXmuQNdRG+rCimxu1WWrH4mIVG+xTm
        UTQLVamZMHuD0Y557J517zGb4x0hWkM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-WRW_qEmSML6lQ_tqVAl4DQ-1; Wed, 17 Mar 2021 05:16:18 -0400
X-MC-Unique: WRW_qEmSML6lQ_tqVAl4DQ-1
Received: by mail-ed1-f71.google.com with SMTP id cq11so18979974edb.14
        for <linux-acpi@vger.kernel.org>; Wed, 17 Mar 2021 02:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ezgL+/5ajoQ5DL0i1PwRjRopGxlsHomHBU/6UBrTjAg=;
        b=CKtEr/55I2ExXyu/taKTpgQhk5AS9HZlBzTZWuF6HhhbyjCel80RcCI1LR8JqUKj1Q
         iuSYEkkN282TnURD4YMzqV6ZSGpfFSDAqeFmnvJTnIR1aJ4G3uKmkaCBWxVEOudpYn7q
         1AiVDKnXmcFFH/fyEm5Gizg3JfPg6AhRVcW83ZrzWDOpTWrn+81+VigcgsRL2rCTY4E4
         XiL/uNrFv8ivezvg+7ty+pGipH/BKZ7jHbAGc59zzFYcVNYU5Oaf3Djep1Oc/TKeioiM
         ebdg3tShQUV6cd6zYVtufzjuBZAOJieqMV1R2R0PhbMgDahOK65ytEJ46ivv6NyIyoIp
         3kpA==
X-Gm-Message-State: AOAM532wN9ir26xiKVBkPkCYdYsXgz1Vgd6naE6RHlr0eS4ASYmAUkwk
        C+79a9S+ysdatbQSj5qtkjJkue//D8Pwhg7zNwnNsDk3j+YBw/kAfjx0U3rGULsNobKriCq1wIu
        4RbMfz1MtiId2rd/H6nIPsw==
X-Received: by 2002:a17:907:a06b:: with SMTP id ia11mr33927478ejc.294.1615972576886;
        Wed, 17 Mar 2021 02:16:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7jjpdDMxbW+XNL49aWfAClHqnec+uYzupjWEAOvDPK/ZPxcHSEt7GO1YyJ3VmFRx/bEKccQ==
X-Received: by 2002:a17:907:a06b:: with SMTP id ia11mr33927469ejc.294.1615972576738;
        Wed, 17 Mar 2021 02:16:16 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id g21sm10944066ejd.6.2021.03.17.02.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 02:16:16 -0700 (PDT)
Subject: Re: [PATCH 1/2] platform/x86: Add missing LPS0 functions for AMD
To:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org
Cc:     Prike.Liang@amd.com, Shyam-sundar.S-k@amd.com,
        Marcin Bachry <hegel666@gmail.com>
References: <20210316194639.287216-1-alexander.deucher@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <904272c4-1f8c-366e-953a-af1d747fed1b@redhat.com>
Date:   Wed, 17 Mar 2021 10:16:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210316194639.287216-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/16/21 8:46 PM, Alex Deucher wrote:
> These are supposedly not required for AMD platforms,
> but at least some HP laptops seem to require it to
> properly turn off the keyboard backlight.
> 
> Based on a patch from Marcin Bachry <hegel666@gmail.com>.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Marcin Bachry <hegel666@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/acpi/x86/s2idle.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 2b69536cdccb..2d7ddb8a8cb6 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -42,6 +42,8 @@ static const struct acpi_device_id lps0_device_ids[] = {
>  
>  /* AMD */
>  #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
> +#define ACPI_LPS0_ENTRY_AMD         2
> +#define ACPI_LPS0_EXIT_AMD          3
>  #define ACPI_LPS0_SCREEN_OFF_AMD    4
>  #define ACPI_LPS0_SCREEN_ON_AMD     5
>  
> @@ -408,6 +410,7 @@ int acpi_s2idle_prepare_late(void)
>  
>  	if (acpi_s2idle_vendor_amd()) {
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD);
>  	} else {
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> @@ -422,6 +425,7 @@ void acpi_s2idle_restore_early(void)
>  		return;
>  
>  	if (acpi_s2idle_vendor_amd()) {
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD);
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
>  	} else {
>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
> 

