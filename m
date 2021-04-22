Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F25368933
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 01:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbhDVXFV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Apr 2021 19:05:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41892 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbhDVXFV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Apr 2021 19:05:21 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619132684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gmWfpHHm6cCJRWuBjc3qinDwjlizXKq6+kayraWbwzk=;
        b=u7DIZvQt3uBYW9xnsSRC5u6ucwyNmzVQVJ7zW+7gh6jQh02qfS6V8cuX1kc377eLvW8S4E
        nXrQTLsJHm6YZFRfJedaf9sfWLRGe5sezvH5OWi/sF5ZiM5HTpaP3U22dxqoxnaR0eqrkV
        Yfk1BQeDrEaiM5BqnE8/6sMARd2xsyNtJC+U7XPgh2/MDfxocAX1n1wpAeVauXkm1SwJ4W
        whDWA+t79DaozNP/cwekYHFmzad79+JHM+PSX3/7XaCJ33IYMcM3JObc+1KidGXMH6pBZf
        nJyLOwbVHBx4D67q8JBIEaMXlEvzqBIhLOFcDbAmnWU6BXvBMFqX7ip9jT8dtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619132684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gmWfpHHm6cCJRWuBjc3qinDwjlizXKq6+kayraWbwzk=;
        b=mWbTZ8BFGmarxsE8A5/Mg5XaXKLWxcKz2JQn4G443yHiqp0HyE6Xr5lUhliJYfHClKBhO1
        SNkU0q080HEYd5AA==
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 3/3] x86/acpi, x86/boot: Add multiprocessor wake-up support
In-Reply-To: <20210422192442.706906-4-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210422192442.706906-1-sathyanarayanan.kuppuswamy@linux.intel.com> <20210422192442.706906-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Fri, 23 Apr 2021 01:04:44 +0200
Message-ID: <87lf99x6nn.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Kuppuswamy!

On Thu, Apr 22 2021 at 12:24, Kuppuswamy Sathyanarayanan wrote:
> +static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
> +{
> +	acpi_mp_wake_mailbox_init();
> +
> +	if (!acpi_mp_wake_mailbox)
> +		return -EINVAL;
> +
> +	WRITE_ONCE(acpi_mp_wake_mailbox->apic_id, apicid);
> +	WRITE_ONCE(acpi_mp_wake_mailbox->wakeup_vector, start_ip);
> +	WRITE_ONCE(acpi_mp_wake_mailbox->command, ACPI_MP_WAKE_COMMAND_WAKEUP);

What's the point of using WRITE_ONCE() here? Where is the required
READ_ONCE() counterpart and the required documentation in form of a
comment?

> +static int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> +				      const unsigned long end)
> +{
...
> +	acpi_wake_cpu_handler_update(acpi_wakeup_cpu);
...

> +++ b/arch/x86/kernel/apic/probe_32.c
> @@ -207,3 +207,11 @@ int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
>  	}
>  	return 0;
>  }
> +
> +void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
> +{
> +	struct apic **drv;
> +
> +	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++)
> +		(*drv)->wakeup_secondary_cpu = handler;
> +}
> diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
> index c46720f185c0..986dbb68d3c4 100644
> --- a/arch/x86/kernel/apic/probe_64.c
> +++ b/arch/x86/kernel/apic/probe_64.c
> @@ -50,3 +50,11 @@ int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
>  	}
>  	return 0;
>  }
> +
> +void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
> +{
> +	struct apic **drv;
> +
> +	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++)
> +		(*drv)->wakeup_secondary_cpu = handler;
> +}

What's the reason for having two verbatim copies of the same function
which has no dependency on CONFIG_*_32/64 at all?

Thanks,

        tglx
