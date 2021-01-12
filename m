Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84732F2C02
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 10:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389251AbhALJ4W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jan 2021 04:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbhALJ4W (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2021 04:56:22 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F93C061786;
        Tue, 12 Jan 2021 01:55:41 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m12so2419664lfo.7;
        Tue, 12 Jan 2021 01:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=loyloL2refMy8dA3c2ycvOjXL4TrjdX3EelbwyY2h84=;
        b=GunDz4PR+b+bFv9NeTCDZHJYK6qvwSLm5LZx2uW4iuV9vpoE0pK6a2M5Ssu3o36rY0
         ThK1WfJdiIMITwuFQWNdgpXGhdeFAqnjbspd03oT9Ok3SDBY9Gc+Wz65yiAVXrxLbAZt
         090wxPpnj6YJgY54xvMhb1xZfNtjDvAYX65yksZ/ZFfbD8Gvo0bfx4SFW/5YaB18bajY
         u/F2W5AKuUphih87Ab3TF7Et6vjP6z8K15Hde2jKRmaVa2mo7TlH3Dx/7ISQ4FupHsjo
         PcIVycol0xP7+psEaIhpX8DVq+24pDzU1AZdaD7HPRSuLUh4Qj6VmQn0Ml3hV8EYL7dX
         BKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=loyloL2refMy8dA3c2ycvOjXL4TrjdX3EelbwyY2h84=;
        b=oU3BZ2CnZo8pTi+rDFpRP8IEZeedUnt99i0gewQcfQN6FxrBpqImubZWnJG42omGxJ
         MGtY0kw2omUiii5uCzHu/TxfVcPKnBPS9/wr5HxKCNFq1H4+F7ZkYPtcbQZBI4N7/7wV
         dZajfcYl3+QMgK7Q/BveoRLJC6nzBXmnn7G5dJqBc/pQ+t7Vy7csD2AtR265EFW+NHwR
         FeCBeYkgJvK2JDd8q8+fTyona6eEPi/ZFsS1lv0YWEHMP1Med69wkhcqeDt9nIDJIfVR
         5rjQ25gc7A6l6WhMgE487Vq1zDvocXhxZZIw4x9YYRygMSvpop9IBIHJHm7ns0foyflQ
         ww1w==
X-Gm-Message-State: AOAM531itxGPhh9UU2DNj4EjuN1Mz6FzDV8xIZz6oB8bCXLR3f8q356P
        458ORAj0y1dVk+yYSdSouF4WiYoPGLg=
X-Google-Smtp-Source: ABdhPJzIaHvUf+SYQhEw7QIoUCU9D4xA0fR6coljdgV4PURFp5PXxuI9FwBmybEj+kXGkSwkKM/L7g==
X-Received: by 2002:a19:904:: with SMTP id 4mr1859774lfj.64.1610445339691;
        Tue, 12 Jan 2021 01:55:39 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id f3sm286381ljn.129.2021.01.12.01.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 01:55:39 -0800 (PST)
Subject: Re: [PATCH] drivers: core: Detach device from power domain on
 shutdown
To:     Furquan Shaikh <furquan@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20201201213019.1558738-1-furquan@google.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e77e0569-568a-f7fb-9f0d-e64943b467f0@gmail.com>
Date:   Tue, 12 Jan 2021 12:55:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201201213019.1558738-1-furquan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

02.12.2020 00:30, Furquan Shaikh пишет:
> When the system is powered off or rebooted, devices are not detached
> from their PM domain. This results in ACPI PM not being invoked and
> hence PowerResouce _OFF method not being invoked for any of the
> devices. Because the ACPI power resources are not turned off in case
> of poweroff and reboot, it violates the power sequencing requirements
> which impacts the reliability of the devices over the lifetime of the
> platform. This is currently observed on all Chromebooks using ACPI.
> 
> In order to solve the above problem, this change detaches a device
> from its PM domain whenever it is shutdown. This action is basically
> analogous to ->remove() from driver model perspective. Detaching the
> device from its PM domain ensures that the ACPI PM gets a chance to
> turn off the power resources for the device thus complying with its
> power sequencing requirements.
> 
> Signed-off-by: Furquan Shaikh <furquan@google.com>
> ---
>  drivers/base/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d661ada1518f..5823f1d719e1 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -23,6 +23,7 @@
>  #include <linux/of_device.h>
>  #include <linux/genhd.h>
>  #include <linux/mutex.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/netdevice.h>
>  #include <linux/sched/signal.h>
> @@ -4057,6 +4058,8 @@ void device_shutdown(void)
>  			dev->driver->shutdown(dev);
>  		}
>  
> +		dev_pm_domain_detach(dev, true);
> +
>  		device_unlock(dev);
>  		if (parent)
>  			device_unlock(parent);
> 

This patch broke system shutdown on NVIDIA Tegra using today's
linux-next because power domain can't be turned off until device drivers
handed control over device resets to the power domain of Power
Management controller on Tegra. This patch introduced the wrong
behaviour, apparently it should be made specific to ACPI only.

Please fix, thanks in advance.
