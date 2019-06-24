Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A876B50937
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2019 12:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbfFXKvi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Jun 2019 06:51:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43339 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfFXKvh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jun 2019 06:51:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id e3so21084405edr.10
        for <linux-acpi@vger.kernel.org>; Mon, 24 Jun 2019 03:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t2vNhPqnjovK4zG9TO7OvRbTUDaxPdCfrbFcCQ4/rec=;
        b=tyDcQWe1BRh2vaSK8CR2WAbQIqfMNNfTQHKtGfhM7i39sVWST+gDh7LH8nowccmfaa
         YutJvVjNPG0LnvwBh2kl2PrY2t4DTL+x5NbFXAmmh7c86q54rORPnaWr60Ulr7am0+wJ
         mNO0c6gP/2t/GwAEKmYMM/U2772jvltFXehColed3vBeHEMfsvM9SdP6toHddMtFrj5y
         6S1nJ0L52UEP7aCr+Job4RFJMNXgdbbCizx9sqB4mjBv4SZ2yZdc9OzvnJNjhAWqNbAS
         27FoFG8RVETtlYSiCAPF/jCBwHxKboFqK2sEIFPENG5QUNgwVTQ0w6d5Z323svTSwb1r
         7LrA==
X-Gm-Message-State: APjAAAU1NDNRvsl4/KBUwgCu9gqq4fGIs23U7SW81U0SOVeWTGtFJ58l
        DDijN8N2OX7uF+IN596jhLIeeQ==
X-Google-Smtp-Source: APXvYqy6CGkPLlV7tl6IxVnLDwe2iA+Fh94YFcTZLM1DjVz/O99S/BAFt5gA6FwddRHJzo8hvC3aBg==
X-Received: by 2002:a50:8b9c:: with SMTP id m28mr121540476edm.53.1561373494788;
        Mon, 24 Jun 2019 03:51:34 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id w17sm3539385edi.15.2019.06.24.03.51.33
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 03:51:34 -0700 (PDT)
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Robert R. Howell" <RHowell@uwyo.edu>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
 <1588383.bXYZMuyLB9@kreacher> <e650be02-ec9b-742e-b34f-7944631107b5@uwyo.edu>
 <2830645.pXxymQ5XCC@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b02ef915-faf5-635d-bf2f-92dd10d274b1@redhat.com>
Date:   Mon, 24 Jun 2019 12:51:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2830645.pXxymQ5XCC@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

<snip>

> Sorry for the long delay.
> 
> I haven't dropped this issue on the floor, I hope that you are still able to follow up here.
> 
> Can you please test the appended patch instead of the previous one?
> 
> I have found some inconsistencies in the handling of hibernation in the ACPI PM domain
> and the LPSS driver that should be covered by this patch.

I know this is just a testing patch for now, but still I've given it
a quick look, some comments inline.

> ---
>   drivers/acpi/acpi_lpss.c |   63 +++++++++++++++++++++++++++++++++++------------
>   drivers/acpi/device_pm.c |   30 ++++++++++++++++++++--
>   include/linux/acpi.h     |    4 ++
>   3 files changed, 79 insertions(+), 18 deletions(-)
> 
> Index: linux-pm/drivers/acpi/device_pm.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/device_pm.c
> +++ linux-pm/drivers/acpi/device_pm.c
> @@ -1171,6 +1171,32 @@ int acpi_subsys_thaw_noirq(struct device
>   	return pm_generic_thaw_noirq(dev);
>   }
>   EXPORT_SYMBOL_GPL(acpi_subsys_thaw_noirq);
> +
> +/**
> + * acpi_subsys_restore_noirq - Run the device driver's "noirq" restore callback.
> + * @dev: Device to handle.
> + */
> +int acpi_subsys_restore_noirq(struct device *dev)
> +{
> +	/* This is analogous to what acpi_subsys_resune_noirq() does. */
> +	if (dev_pm_smart_suspend_and_suspended(dev))
> +		pm_runtime_set_active(dev);
> +
> +	return pm_generic_restore_noirq(dev);
> +}
> +EXPORT_SYMBOL_GPL(acpi_subsys_restore_noirq);
> +
> +/**
> + * acpi_subsys_restore_early - Restore device using ACPI.
> + * @dev: Device to restore.
> + */
> +int acpi_subsys_restore_early(struct device *dev)
> +{
> +	int ret = acpi_dev_resume(dev);
> +	return ret ? ret : pm_generic_restore_early(dev);
> +}
> +EXPORT_SYMBOL_GPL(acpi_subsys_restore_early);
> +
>   #endif /* CONFIG_PM_SLEEP */
>   
>   static struct dev_pm_domain acpi_general_pm_domain = {
> @@ -1192,8 +1218,8 @@ static struct dev_pm_domain acpi_general
>   		.poweroff = acpi_subsys_suspend,
>   		.poweroff_late = acpi_subsys_suspend_late,
>   		.poweroff_noirq = acpi_subsys_suspend_noirq,
> -		.restore_noirq = acpi_subsys_resume_noirq,
> -		.restore_early = acpi_subsys_resume_early,
> +		.restore_noirq = acpi_subsys_restore_noirq,
> +		.restore_early = acpi_subsys_restore_early,
>   #endif
>   	},
>   };
> Index: linux-pm/drivers/acpi/acpi_lpss.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpi_lpss.c
> +++ linux-pm/drivers/acpi/acpi_lpss.c
> @@ -1069,36 +1069,67 @@ static int acpi_lpss_suspend_noirq(struc
>   	return acpi_subsys_suspend_noirq(dev);
>   }
>   
> -static int acpi_lpss_do_resume_early(struct device *dev)
> +static int acpi_lpss_resume_noirq(struct device *dev)
>   {
> -	int ret = acpi_lpss_resume(dev);
> +	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
> +
> +	/* Follow acpi_subsys_resune_noirq(). */
> +	if (dev_pm_may_skip_resume(dev))
> +		return 0;
> +
> +	if (dev_pm_smart_suspend_and_suspended(dev))
> +		pm_runtime_set_active(dev);
>   
> -	return ret ? ret : pm_generic_resume_early(dev);
> +	if (pdata->dev_desc->resume_from_noirq) {
> +		int ret = acpi_lpss_resume(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return pm_generic_resume_noirq(dev);
>   }

Hmm, normally acpi_lpss_resume runs at resume_early time, AFAIK
the order of resume callbacks calling is: resume_noirq, resume_early, resume

So normally our call order is:

---noirq-phase---
pm_generic_resume_noirq()
---early-phase---
acpi_lpss_resume()
pm_generic_resume_early()

My patch adding the resume_from_noirq flag, move the calling of
acpi_lpss_resume() to the resume_noirq phase (if the flag is
set) but kept the generic order, so the call order with the
flag set currently is:

---noirq-phase---
pm_generic_resume_noirq()
acpi_lpss_resume()
---early-phase---
pm_generic_resume_early()

So the order of the 3 calls relative to each other did not change.

You are changing this to:

---noirq-phase---
acpi_lpss_resume()
pm_generic_resume_noirq()
---early-phase---
pm_generic_resume_early()

So now when the flag is set acpi_lpss_resume() runs before
pm_generic_resume_noirq(). Is this intentional ?

Regards,

Hans




>   
>   static int acpi_lpss_resume_early(struct device *dev)
>   {
>   	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
>   
> -	if (pdata->dev_desc->resume_from_noirq)
> -		return 0;
> +	if (!pdata->dev_desc->resume_from_noirq) {
> +		int ret = acpi_lpss_resume(dev);
> +		if (ret)
> +			return ret;
> +	}
>   
> -	return acpi_lpss_do_resume_early(dev);
> +	return pm_generic_resume_early(dev);
>   }
>   
> -static int acpi_lpss_resume_noirq(struct device *dev)
> +static int acpi_lpss_restore_noirq(struct device *dev)
>   {
>   	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
> -	int ret;
>   
> -	ret = acpi_subsys_resume_noirq(dev);
> -	if (ret)
> -		return ret;
> +	/* Follow acpi_subsys_restore_noirq(). */
> +	if (dev_pm_smart_suspend_and_suspended(dev))
> +		pm_runtime_set_active(dev);
> +
> +	if (pdata->dev_desc->resume_from_noirq) {
> +		int ret = acpi_lpss_resume(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return pm_generic_restore_noirq(dev);
> +}
> +
> +static int acpi_lpss_restore_early(struct device *dev)
> +{
> +	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
>   
> -	if (!dev_pm_may_skip_resume(dev) && pdata->dev_desc->resume_from_noirq)
> -		ret = acpi_lpss_do_resume_early(dev);
> +	if (!pdata->dev_desc->resume_from_noirq) {
> +		int ret = acpi_lpss_resume(dev);
> +		if (ret)
> +			return ret;
> +	}
>   
> -	return ret;
> +	return pm_generic_restore_early(dev);
>   }
>   
>   #endif /* CONFIG_PM_SLEEP */
> @@ -1140,8 +1171,8 @@ static struct dev_pm_domain acpi_lpss_pm
>   		.poweroff = acpi_subsys_suspend,
>   		.poweroff_late = acpi_lpss_suspend_late,
>   		.poweroff_noirq = acpi_lpss_suspend_noirq,
> -		.restore_noirq = acpi_lpss_resume_noirq,
> -		.restore_early = acpi_lpss_resume_early,
> +		.restore_noirq = acpi_lpss_restore_noirq,
> +		.restore_early = acpi_lpss_restore_early,
>   #endif
>   		.runtime_suspend = acpi_lpss_runtime_suspend,
>   		.runtime_resume = acpi_lpss_runtime_resume,
> Index: linux-pm/include/linux/acpi.h
> ===================================================================
> --- linux-pm.orig/include/linux/acpi.h
> +++ linux-pm/include/linux/acpi.h
> @@ -925,6 +925,8 @@ int acpi_subsys_freeze(struct device *de
>   int acpi_subsys_freeze_late(struct device *dev);
>   int acpi_subsys_freeze_noirq(struct device *dev);
>   int acpi_subsys_thaw_noirq(struct device *dev);
> +int acpi_subsys_restore_noirq(struct device *dev);
> +int acpi_subsys_restore_early(struct device *dev);
>   #else
>   static inline int acpi_dev_resume_early(struct device *dev) { return 0; }
>   static inline int acpi_subsys_prepare(struct device *dev) { return 0; }
> @@ -938,6 +940,8 @@ static inline int acpi_subsys_freeze(str
>   static inline int acpi_subsys_freeze_late(struct device *dev) { return 0; }
>   static inline int acpi_subsys_freeze_noirq(struct device *dev) { return 0; }
>   static inline int acpi_subsys_thaw_noirq(struct device *dev) { return 0; }
> +static inline int acpi_subsys_restore_noirq(struct device *dev) { return 0; }
> +static inline int acpi_subsys_restore_early(struct device *dev) { return 0; }
>   #endif
>   
>   #ifdef CONFIG_ACPI
> 
> 
> 
