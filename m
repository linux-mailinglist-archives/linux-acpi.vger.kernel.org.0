Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC807355554
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Apr 2021 15:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhDFNhe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 09:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53619 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238367AbhDFNhe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2021 09:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617716246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dMiNBtEMrQvnxIoUeX1bu77l5Tzq/22mbIKvwOxGjy8=;
        b=S2Ck+GB4FlHcl6LCvKZ76X15GJg7YQXN1caSU5YmqCV36zALqraBUT3MvmGFO4FxMyJznt
        fTJL8vAzAXqkfLSiNwOe3J96njqceBm65FGbPk69ykOY06pN6EdX9j00UTJM3Yf2urhzKq
        JJ3gVBH/EvcYOrl+xiRN+WX4qOGjFxo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-dvnZ5DxxNPiFvbwK_96IHA-1; Tue, 06 Apr 2021 09:37:24 -0400
X-MC-Unique: dvnZ5DxxNPiFvbwK_96IHA-1
Received: by mail-ej1-f72.google.com with SMTP id de56so1783838ejc.16
        for <linux-acpi@vger.kernel.org>; Tue, 06 Apr 2021 06:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dMiNBtEMrQvnxIoUeX1bu77l5Tzq/22mbIKvwOxGjy8=;
        b=EplPg6iNeVgdYsO4IkbB4fzJtmYIyWgIyG8IN4aQ5e/kJhCzlwHKnUmO/MjK6bDe96
         3tDpJRQsPJFOOEUPu2HoLq5xGGFtoJ6i3fPUFkxcvVFdlxXgFHFJbhyxpwvTZtgrJlte
         DCcoif/bFan/3jjiyampuVePfykYmGV1PGo0oguoGsLgjgqOlibm7G1e+QBubt1n5PXJ
         WU/EUPETrVQq5QnS8pbbYLrAKhtQrBPY9nKdJK26OKBiD+fN5RKOC9W3rdYcVq2ffLkH
         CekPPVwnGfmQxy6Zd5E7mYYU0u5WukkaTDRKoWB24H5ZtJB4F+msncDi8AfjZbTVPx2Z
         x1XQ==
X-Gm-Message-State: AOAM531KHx6PAnWrthNLqHyHCPDDgr4xgKGEqEAG38I+NyCvXZtnaj/1
        kYH6X3Gsdqm161hiEsEAn1uitEA4bns5rpbqWNVCsntDTxvT8JrojNins1A6LvmRyObN8+KsEtl
        Iml/Qo3b9RR+UmCnrEKUg0A==
X-Received: by 2002:a17:907:629c:: with SMTP id nd28mr34632035ejc.267.1617716243117;
        Tue, 06 Apr 2021 06:37:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPlX5I+as++Bo8KruxUM9wb9AZX5YYNyyxHZGmZWQjUSiI0DOUwwJMY80ynUyPN+ZY2HHTFg==
X-Received: by 2002:a17:907:629c:: with SMTP id nd28mr34632009ejc.267.1617716242875;
        Tue, 06 Apr 2021 06:37:22 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t14sm11010189ejc.121.2021.04.06.06.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 06:37:22 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Stable <stable@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: processor: Fix build when CONFIG_ACPI_PROCESSOR=m
In-Reply-To: <CAJZ5v0hpkF-acQAomZZKN=r00gNy831R7J-ZWZgWnoCJe5xSkg@mail.gmail.com>
References: <20210406125047.547501-1-vkuznets@redhat.com>
 <CAJZ5v0hpkF-acQAomZZKN=r00gNy831R7J-ZWZgWnoCJe5xSkg@mail.gmail.com>
Date:   Tue, 06 Apr 2021 15:37:21 +0200
Message-ID: <87mtubcz5a.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Tue, Apr 6, 2021 at 2:50 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Commit 8cdddd182bd7 ("ACPI: processor: Fix CPU0 wakeup in
>> acpi_idle_play_dead()") tried to fix CPU0 hotplug breakage by copying
>> wakeup_cpu0() + start_cpu0() logic from hlt_play_dead()//mwait_play_dead()
>> into acpi_idle_play_dead(). The problem is that these functions are not
>> exported to modules so when CONFIG_ACPI_PROCESSOR=m build fails.
>>
>> The issue could've been fixed by exporting both wakeup_cpu0()/start_cpu0()
>> (the later from assembly) but it seems putting the whole pattern into a
>> new function and exporting it instead is better.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Fixes: 8cdddd182bd7 ("CPI: processor: Fix CPU0 wakeup in acpi_idle_play_dead()")
>> Cc: <stable@vger.kernel.org> # 5.10+
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/include/asm/smp.h    |  2 +-
>>  arch/x86/kernel/smpboot.c     | 15 ++++++++++-----
>>  drivers/acpi/processor_idle.c |  3 +--
>>  3 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
>> index 57ef2094af93..6f79deb1f970 100644
>> --- a/arch/x86/include/asm/smp.h
>> +++ b/arch/x86/include/asm/smp.h
>> @@ -132,7 +132,7 @@ void native_play_dead(void);
>>  void play_dead_common(void);
>>  void wbinvd_on_cpu(int cpu);
>>  int wbinvd_on_all_cpus(void);
>> -bool wakeup_cpu0(void);
>> +void wakeup_cpu0_if_needed(void);
>>
>>  void native_smp_send_reschedule(int cpu);
>>  void native_send_call_func_ipi(const struct cpumask *mask);
>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>> index f877150a91da..9547d870ee27 100644
>> --- a/arch/x86/kernel/smpboot.c
>> +++ b/arch/x86/kernel/smpboot.c
>> @@ -1659,7 +1659,7 @@ void play_dead_common(void)
>>         local_irq_disable();
>>  }
>>
>> -bool wakeup_cpu0(void)
>> +static bool wakeup_cpu0(void)
>>  {
>>         if (smp_processor_id() == 0 && enable_start_cpu0)
>>                 return true;
>> @@ -1667,6 +1667,13 @@ bool wakeup_cpu0(void)
>>         return false;
>>  }
>>
>> +void wakeup_cpu0_if_needed(void)
>> +{
>> +       if (wakeup_cpu0())
>> +               start_cpu0();
>
> Note that all of the callers of wakeup_cpu0 do the above, so maybe
> make them all use the new function?
>
> In which case it can be rewritten in the following way
>
> void cond_wakeup_cpu0(void)
> {
>         if (smp_processor_id() == 0 && enable_start_cpu0)
>                 start_cpu0();
> }
> EXPORT_SYMBOL_GPL(cond_wakeup_cpu0);
>

Sure, separate wakeup_cpu0() is no longer needed.

> Also please add a proper kerneldoc comment to it and maybe drop the
> comments at the call sites?

Also a good idea. v2 is coming, thanks!

>
>
>> +}
>> +EXPORT_SYMBOL_GPL(wakeup_cpu0_if_needed);
>> +
>>  /*
>>   * We need to flush the caches before going to sleep, lest we have
>>   * dirty data in our caches when we come back up.
>> @@ -1737,8 +1744,7 @@ static inline void mwait_play_dead(void)
>>                 /*
>>                  * If NMI wants to wake up CPU0, start CPU0.
>>                  */
>> -               if (wakeup_cpu0())
>> -                       start_cpu0();
>> +               wakeup_cpu0_if_needed();
>>         }
>>  }
>>
>> @@ -1752,8 +1758,7 @@ void hlt_play_dead(void)
>>                 /*
>>                  * If NMI wants to wake up CPU0, start CPU0.
>>                  */
>> -               if (wakeup_cpu0())
>> -                       start_cpu0();
>> +               wakeup_cpu0_if_needed();
>>         }
>>  }
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 768a6b4d2368..de15116b754a 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -545,8 +545,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
>>
>>  #if defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)
>>                 /* If NMI wants to wake up CPU0, start CPU0. */
>> -               if (wakeup_cpu0())
>> -                       start_cpu0();
>> +               wakeup_cpu0_if_needed();
>>  #endif
>>         }
>>
>> --
>> 2.30.2
>>
>

-- 
Vitaly

