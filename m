Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9ABB11625B
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Dec 2019 15:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfLHOFW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 8 Dec 2019 09:05:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31604 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726406AbfLHOFW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Dec 2019 09:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575813920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=30ipBLDOpILVGltlX+yMvZubDIZXAvCZnhKBpoYTnd0=;
        b=SkKosVp5YTE7Hi+oVvSCkJn+2c6pDWpLMZ8JKKGRa6FCydEcMO1GZ+j2iWajZOm/dz4vML
        e0d2wF6PjmSKKP3juJ8JlvHVl9h3l+QOUmKiJirjh725ShF7xWDWFm0pRxeCVZMrW3rnKH
        76F6xBL4tdnPr80KSJA40GtnqIlG3mU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-BA45oVaSN82a4fwlim6N7A-1; Sun, 08 Dec 2019 09:05:19 -0500
Received: by mail-wr1-f71.google.com with SMTP id c6so5969332wrm.18
        for <linux-acpi@vger.kernel.org>; Sun, 08 Dec 2019 06:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=30ipBLDOpILVGltlX+yMvZubDIZXAvCZnhKBpoYTnd0=;
        b=d0keIVrxHTdHJgWACfy2IUmvWlFL4imvGvRJPACdmKgI+oGpu7uI0KUJcSPRmbsfYT
         lorFr8aFOQEe4VEEHmyj+jhcpw9QFQBTKgeujiU9UHzMSTtbyqlZb7yd7ldVuY2UhNKb
         Rox7VSvn8FoMha/+EyrtnvIJuubDXu3kMmnOA+FF4z9L1Jb/LBfIGiIjKp+zklZ3lnCq
         gzzhlWIq7ydMXuKOoniBM3RTkYF+EKvwNyhRayfwLi9n8UtWXLHxasA3MlXY5dL1Dq7I
         5kcOppM1Gei4c3Q+GW36n/+S74p+1Y9z32HqryI7z7SlAUC65GupLktx4ZuvOMGpoS+c
         03VQ==
X-Gm-Message-State: APjAAAVqkUru+z962Nv/vF8bD/uZPho2H7N/jj1A33N71PuOMnSHtGsJ
        6lDCgzsdxFenq8yNvRD+xa+L0r2i3K4jXk5tIG6/BlF+/oOSRoE2mdVU9g+iDSAC5nDYrKvkio2
        qQ9zyZyGT5uKQE8gw4FmXZA==
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr3828227wrn.280.1575813918075;
        Sun, 08 Dec 2019 06:05:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqwClxrwfKXccjCy3DgP3KyYWvRyxieD/Vi/Ud1fqKAxEpVX6n6WXJ4jmC4eyZLJ/l742BKMfA==
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr3828207wrn.280.1575813917877;
        Sun, 08 Dec 2019 06:05:17 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id q6sm24703020wrx.72.2019.12.08.06.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2019 06:05:17 -0800 (PST)
Subject: Re: [PATCH] ACPI: button: Add a DMI quirk for Razer Blade Stealth 13
 late 2019 lid-switch
To:     Jason Ekstrand <jason@jlekstrand.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191206175409.335568-1-jason@jlekstrand.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3565c99f-3cc4-32cb-1cac-98c7b0392e5c@redhat.com>
Date:   Sun, 8 Dec 2019 15:05:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191206175409.335568-1-jason@jlekstrand.net>
Content-Language: en-US
X-MC-Unique: BA45oVaSN82a4fwlim6N7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 06-12-2019 18:54, Jason Ekstrand wrote:
> Running evemu-record on the lid switch event shows that the lid reports
> the first close but then never reports an open.  This causes systemd to
> continuously re-suspend the laptop every 30s.  Resetting the _LID to
> open fixes the issue.

Sorry to be a bit nitpicky here, but the LID does work normally right,
so it does signal an event when it gets closed a second time right?

Your current commit message and comment suggest closing the LID only
works once. So perhaps something like this for the comment:

/*
  * Razer Blade Stealth 13 late 2019, _LID always reports closed,
  * even when opened.
  */

And adjust the comment accordingly.

Regards,

Hans



> Signed-off-by: Jason Ekstrand <jason@jlekstrand.net>
> ---
> 
> Re-sending due to a typo in my own e-mail address. :(
> 
>   drivers/acpi/button.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 662e07afe9a1..f7ca94e41c48 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -122,6 +122,17 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
>   		},
>   		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
>   	},
> +	{
> +		/*
> +		 * Razer Blade Stealth 13 late 2019, _LID reports the first
> +		 * close but never resets to open.
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

