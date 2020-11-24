Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953862C2E9B
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Nov 2020 18:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390840AbgKXRcH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 24 Nov 2020 12:32:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33892 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390805AbgKXRcF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Nov 2020 12:32:05 -0500
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1khcAd-00026d-1s
        for linux-acpi@vger.kernel.org; Tue, 24 Nov 2020 17:32:03 +0000
Received: by mail-pl1-f200.google.com with SMTP id x17so14107101pll.8
        for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2020 09:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=c59NXUKfsVeXI+YuJz0D1TteRrVfduhKNfg9Shm/UEo=;
        b=fPpBlbweB8T2q+V64h7sxDTzywI/gzmKHi60zi3BVqJ80UlQ16JIytGJab+A5LHfs2
         yvOlZvxrHPTqhxezB1iVXHRohTaNJbMmgCKAlmYE5TgumWyHM5j2+E3OnGdZoSxKHB8b
         BTvh7bD1iwpAHxFuk41KmXwXYQYAR1zrWwO2jgQvj+b2rbDIaZFHkJtx0IP5dOfPwPFH
         NZPABITCHd/GVCL5us8fKnWVEYR6EZ/19WI+cZLMgIW3WNELqrU55zoDbowWhPDeaNk+
         aXUajkKebPq16aGT4sO2zlbl8fxMcQxESluHYTl0Tl4VD0u3GokG8CcDYJHK672LSgT4
         34vQ==
X-Gm-Message-State: AOAM530XmRARVk82dTb9UDw33Wjnoo6IiAtSRL9OhzcZpX5iPddIMXNl
        W0lyV7jY0fx3hEON9WYtodp3D21XicWnpu23VPO8QFWFLznb/dsXr+5Dj2auxF8j9GKMlkhQXYP
        KV82eDFDPq6Nugi+t0TxltB/I5oDldPXiMwAqNyo=
X-Received: by 2002:a63:381:: with SMTP id 123mr4637086pgd.112.1606239121625;
        Tue, 24 Nov 2020 09:32:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2Ads5zFsLVXiIPD2kWrJR/q50fAinLP4yUQdTy8kjuq6L2IaVbpgGPMCL1AESAO1jbkKzgQ==
X-Received: by 2002:a63:381:: with SMTP id 123mr4637060pgd.112.1606239121217;
        Tue, 24 Nov 2020 09:32:01 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id c22sm15239170pfo.211.2020.11.24.09.31.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 09:32:00 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH] ACPI: PM: Re-enable ACPI GPE if it's already enabled
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAJZ5v0iJ_x5oXL9gG_TvCriNnPwzZYvGkkEK6_HWrH4fmCqBxQ@mail.gmail.com>
Date:   Wed, 25 Nov 2020 01:31:56 +0800
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <90E54BA3-FC3A-4538-ACD0-4C4DDF570C7C@canonical.com>
References: <20201124073619.771940-1-kai.heng.feng@canonical.com>
 <CAJZ5v0iJ_x5oXL9gG_TvCriNnPwzZYvGkkEK6_HWrH4fmCqBxQ@mail.gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> On Nov 24, 2020, at 22:00, Rafael J. Wysocki <rafael@kernel.org> wrote:
> 
> On Tue, Nov 24, 2020 at 8:36 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> 
>> Dell Precision 5550 fails to detect Thunderbolt device hotplug events,
>> once the Thunderbolt device and its root port are runtime-suspended to
>> D3cold.
>> 
>> While putting the entire hierarchy to D3cold, the root port ACPI GPE is
>> enabled via acpi_pci_propagate_wakeup() when suspending Thunderbolt
>> bridges/switches. So when putting the root port to D3cold as last step,
>> ACPI GPE is untouched as it's already enabled.
>> 
>> However, platform may need PCI devices to be in D3hot or PME enabled
>> prior enabling GPE to make it work.
> 
> What platforms and why.

Dell Precision 5550. Its thunderbolt port can't detect newly plugged thunderbolt devices.

> 
>> So re-enable ACPI GPE to address this.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/acpi/device_pm.c | 13 ++++++-------
>> 1 file changed, 6 insertions(+), 7 deletions(-)
>> 
>> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
>> index 94d91c67aeae..dc25d9d204ae 100644
>> --- a/drivers/acpi/device_pm.c
>> +++ b/drivers/acpi/device_pm.c
>> @@ -757,11 +757,10 @@ static int __acpi_device_wakeup_enable(struct acpi_device *adev,
>> 
>>        mutex_lock(&acpi_wakeup_lock);
>> 
>> -       if (wakeup->enable_count >= max_count)
>> -               goto out;
>> -
>> -       if (wakeup->enable_count > 0)
>> -               goto inc;
>> +       if (wakeup->enable_count > 0) {
>> +               acpi_disable_gpe(wakeup->gpe_device, wakeup->gpe_number);
>> +               acpi_disable_wakeup_device_power(adev);
>> +       }
> 
> An event occurring at this point may be lost after this patch.

Yes, so this approach is not optimal.

> 
> It looks like you are trying to work around a hardware issue.  

Windows doesn't have this issue. So I don't think it's hardware issue.

> Can you
> please describe that issue in detail?

The GPE used by Thunderbolt root port, was previously enabled by Thunderbolt switches/bridges.
So when the GPE is already enabled when Thunderbolt root port is suspended.
However, the GPE needs to be enabled after root port is suspended, and that's the approach this patch takes.

Is there any actual hardware benefits from acpi_pci_propagate_wakeup()?
If there's no actual device benefits from it, we can remove it and only enable GPE for the root port.
Otherwise we need to quirk off Thunderbolt bridges/switches, since their native PME just work without the need to enable root port GPE.

Kai-Heng

> 
>> 
>>        error = acpi_enable_wakeup_device_power(adev, target_state);
>>        if (error)
>> @@ -777,8 +776,8 @@ static int __acpi_device_wakeup_enable(struct acpi_device *adev,
>>        acpi_handle_debug(adev->handle, "GPE%2X enabled for wakeup\n",
>>                          (unsigned int)wakeup->gpe_number);
>> 
>> -inc:
>> -       wakeup->enable_count++;
>> +       if (wakeup->enable_count < max_count)
>> +               wakeup->enable_count++;
>> 
>> out:
>>        mutex_unlock(&acpi_wakeup_lock);
>> --
>> 2.29.2

