Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0578A33F734
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Mar 2021 18:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhCQRhU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Mar 2021 13:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231398AbhCQRgu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Mar 2021 13:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616002609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JOdr3pyod5+SolyquXi4mCwLkYoXjfdw7Xom99NirA=;
        b=TqVGVI3SFfS+eQuw+x30F4wlgG3hH1c6LjOhoAyD+XBG/uaMBur0SQrE0/wBT542t+wpf2
        NIxV0tanlRsWwjNF0LP1wB+87DlTYly4eoXJB2xubxsimak0G1jdqR/LAct+re3ecJxjO9
        wSsvSBSWnjVb4Tf5OE4p2MsWCBx3XBQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-YEnZhzqYMaC7yatOIsm9wA-1; Wed, 17 Mar 2021 13:36:46 -0400
X-MC-Unique: YEnZhzqYMaC7yatOIsm9wA-1
Received: by mail-ed1-f69.google.com with SMTP id bi17so19705379edb.6
        for <linux-acpi@vger.kernel.org>; Wed, 17 Mar 2021 10:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5JOdr3pyod5+SolyquXi4mCwLkYoXjfdw7Xom99NirA=;
        b=YroTp/LgDQRyMGj8PYHuiIcGMC8gcPdzItK8cCGgX+TLgTPYjx9xVa8uQNG1d7vYfP
         ErTFD5RLO0GQ+KNkRDHY1wGTY1O5hOldgCdpUNAABIWMEAHq20R/ifTLS8IorJNWDHDH
         d4uNf4GOBFSx13ZmqNl44V28v/YKVYGB/FPE74btUE/PWblMkz49LhuTCi8MwkV41x8E
         uFC5hoes52pGwO31v5fOArd/9gkWFuIQ4uyjYpeUQO7mj49shIG+dxLDSlIaqrdDkQGj
         PjIBoDZKkvTZ28qcUZMTMkxONOTuhc5ZlszazIpzjlqCAgGKgJTj2KzjQ80xi48XpWRL
         KKuQ==
X-Gm-Message-State: AOAM531Qr5FYgmt0tYCA5uR9ZqtKWoruyxG7nApvjsRiBNswyb4O4KDY
        k+4tLLotp8LyJkEjvxJHTKJXxtftcumFvADqJ9jBY5xN8WBP4cJEf0uCB0cT2lED3n65GGlKRyA
        dfHel/Q1njsDd3yNS90DfBg==
X-Received: by 2002:a17:906:5949:: with SMTP id g9mr4867075ejr.518.1616002605631;
        Wed, 17 Mar 2021 10:36:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqinHOoTwYUtX6nZhOFnJb6qXcHsgbaTlxUMnWG+ZMrSyNasCQ3Hhph7Glnso55BkCS1u4BA==
X-Received: by 2002:a17:906:5949:: with SMTP id g9mr4867059ejr.518.1616002605496;
        Wed, 17 Mar 2021 10:36:45 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id c15sm6266853ejm.52.2021.03.17.10.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 10:36:44 -0700 (PDT)
Subject: Re: [PATCH 2/2 V2] platform/x86: force LPS0 functions for AMD
To:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org
Cc:     Prike.Liang@amd.com, Shyam-sundar.S-k@amd.com,
        Marcin Bachry <hegel666@gmail.com>
References: <20210317143842.786380-1-alexander.deucher@amd.com>
 <20210317143842.786380-2-alexander.deucher@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <070ee308-aed5-b2bf-5177-76ee2d9f404a@redhat.com>
Date:   Wed, 17 Mar 2021 18:36:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210317143842.786380-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/17/21 3:38 PM, Alex Deucher wrote:
> ACPI_LPS0_ENTRY_AMD/ACPI_LPS0_EXIT_AMD are supposedly not
> required for AMD platforms, and on some platforms they are
> not even listed in the function mask but at least some HP
> laptops seem to require it to properly support s0ix.
> 
> Based on a patch from Marcin Bachry <hegel666@gmail.com>.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Marcin Bachry <hegel666@gmail.com>
> ---
> 
> V2: rework the patch to just fix up the specific problematic
>     case by setting the function flags that are missing.

Thanks, the new version looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> 
>  drivers/acpi/x86/s2idle.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 2d7ddb8a8cb6..482e6b23b21a 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -368,6 +368,13 @@ static int lps0_device_attach(struct acpi_device *adev,
>  
>  	ACPI_FREE(out_obj);
>  
> +	/*
> +	 * Some HP laptops require ACPI_LPS0_ENTRY_AMD/ACPI_LPS0_EXIT_AMD for proper
> +	 * S0ix, but don't set the function mask correctly.  Fix that up here.
> +	 */
> +	if (acpi_s2idle_vendor_amd())
> +		lps0_dsm_func_mask |= (1 << ACPI_LPS0_ENTRY_AMD) | (1 << ACPI_LPS0_EXIT_AMD);
> +
>  	acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
>  			  lps0_dsm_func_mask);
>  
> 

