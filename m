Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C4512EB5A
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Jan 2020 22:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgABV1L (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Jan 2020 16:27:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23371 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726103AbgABV1L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jan 2020 16:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578000430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PpYbVzWZkkwXmuxKU68lA7mgW4bz/XGYjmci9VZh6ZU=;
        b=O5bWnXaI3rvbpMXDq7orZBjFCTNaRzBbqhqFwXwQba2M166wz8gZ1+zVYqjbbyrhEVAg5+
        NPjB14mKznioFV1+BMRUJ2USCXKEEjIFsX4TXwKa28LeC2rzAjk1sRGhsGq+5jNMouC0dP
        Xqwj93f0Qd9nw+OsaXqymePKum1we0I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-iLxMMDxIPWS9KFLqQ_a_Xw-1; Thu, 02 Jan 2020 16:27:09 -0500
X-MC-Unique: iLxMMDxIPWS9KFLqQ_a_Xw-1
Received: by mail-wr1-f70.google.com with SMTP id c17so15976893wrp.10
        for <linux-acpi@vger.kernel.org>; Thu, 02 Jan 2020 13:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PpYbVzWZkkwXmuxKU68lA7mgW4bz/XGYjmci9VZh6ZU=;
        b=bqR5cM8nfWW75Rf7BemEWohlBRyHDopjsObS+etXfx/9BwDYFLpqVmD+KANcg3RA1F
         8HZfNRzN26rf6B4PYiPr1iVdg3oNcgReWXtFzjra+e2NxnpkLSiuxxXJBEQfG9j2IeuJ
         1BDnsrDhLCZT5jtEi+6S/5fsltCzIKYETaJtjIr2dD7XkyW+HhxrAujBVcw9xyIKpjTd
         SPCs7m3FpMKe77yR5B4hQjbvKvJbRkgzdnDdstndN/pAyYfSwIN4xyDBavJ1ViPDUCgv
         zEIYpN9XlHPyyEV6skneEHlHoXPvIjy+zfE1O9fTkp96j3sFBWrOf/Pc4Fq7FNhUOmPx
         6Vtg==
X-Gm-Message-State: APjAAAWQZRvzfEu0z3fC4F6Aa4dCfRhQdK9t1I8TpngpnYhxy9lozuSj
        1KtDRJDfS62va5Vk8x18UZKqkP3+1nSH+jhzwl2NaAzML2Y37LNOqi1ISmib35sppH+HS0fdktT
        sRQ7fL6YgMU1Gu3LAslwjpA==
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr29395662wrx.109.1578000428333;
        Thu, 02 Jan 2020 13:27:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqxzTcuAi7Pt7nocywZojYU3QnxHnmj9Zekuq4+JDJeNLdhsFfNQ//LfZ2fZaVTc9W4d6sCEYQ==
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr29395655wrx.109.1578000428180;
        Thu, 02 Jan 2020 13:27:08 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id q11sm56704622wrp.24.2020.01.02.13.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 13:27:07 -0800 (PST)
Subject: Re: [PATCH] ACPI: button: Add a DMI quirk for Razer Blade Stealth 13
 late 2019 lid-switch
To:     Jason Ekstrand <jason@jlekstrand.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191206175409.335568-1-jason@jlekstrand.net>
 <20200102202754.24028-1-jason@jlekstrand.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7eba4578-42e2-69da-99a3-2fc316a588b8@redhat.com>
Date:   Thu, 2 Jan 2020 22:27:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200102202754.24028-1-jason@jlekstrand.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 02-01-2020 21:27, Jason Ekstrand wrote:
> Running evemu-record on the lid switch event shows that the lid reports
> the first close but then never reports an open.  This causes systemd to
> continuously re-suspend the laptop every 30s.  Resetting the _LID to
> open fixes the issue.
> 
> v2: Updated the comment to better describe the behavior of ACPI
> 
> Signed-off-by: Jason Ekstrand <jason@jlekstrand.net>

Thanks, looks good to me now:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/acpi/button.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 662e07afe9a1..ef5d473e7992 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -122,6 +122,17 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
>   		},
>   		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
>   	},
> +	{
> +		/*
> +		 * Razer Blade Stealth 13 late 2019, notification of the LID device
> +		 * only happens on close, not on open and _LID always returns closed.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Razer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Razer Blade Stealth 13 Late 2019"),
> +		},
> +		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
> +	},
>   	{}
>   };
>   
> 

