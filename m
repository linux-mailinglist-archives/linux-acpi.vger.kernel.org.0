Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C74F7728F4
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Aug 2023 17:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjHGPU5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Aug 2023 11:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjHGPUx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Aug 2023 11:20:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B18410FD
        for <linux-acpi@vger.kernel.org>; Mon,  7 Aug 2023 08:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691421605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFqv/cLru+C9EdiPmmulE3UaUKd0oAuNQ0J088mMQ+8=;
        b=MyTHRzZo5YPaSzGDv7eRZEIiaDJxNl2X059M+8dbD4tqsbPxhGS+f4AcZwfB072m/iUQI6
        n38fkceysZoJ9c0F3xzbhvKrFJjrocoW+EXTNzTwgr5FnH2tARe0ch2c88QYppjN0eLOaE
        bXWlU4Sx8oGF2si5obwDdMcOmXASvac=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-5si0hJArOves9hLJnkApfw-1; Mon, 07 Aug 2023 11:20:02 -0400
X-MC-Unique: 5si0hJArOves9hLJnkApfw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99cc32f2ec5so130952766b.1
        for <linux-acpi@vger.kernel.org>; Mon, 07 Aug 2023 08:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691421601; x=1692026401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFqv/cLru+C9EdiPmmulE3UaUKd0oAuNQ0J088mMQ+8=;
        b=C1i3+CFG172kJs36LFnkNcIXDliM8L1Iku1hlLBgt9D8z3kX78Lc6wkBdKFPVKkqHX
         4YpGsinyRtq/sMYNlTldpvpBJpHfYA6Zko4gRefYzflRMDJvBGcBBjvDqoo+PgJq1B7D
         OAj6F0Fq6JYbnow2AYEzSza/Dj3cPihnMVnxOCj+KhNvERL/RPPL3u4Wgev/O59bJbhj
         yZ+VvQvL/zJzlr6K12nTcLCvySq0V1KW77v4+1371tfgoLS2WI4gytBwZn+pXJcZrZvU
         pLOsw2MpDnZZ1tqh0datXsPO40lgUDEVyi+4cjz5CvKoLsMfKweFxPyDH6ZPb3un3yr7
         Gilg==
X-Gm-Message-State: AOJu0Yy7vqCipabwZC7FbOWmIvoeooqADwQsNUoIl26lpU58tnLsnGML
        2c3QCHIXU4Is10Nf+D6BIRcTSSActBdw/Z3Iy3zworUpHonPo34x11h6A0qd1J2cmJrQ6fsI4e+
        dyj3Jg9N+Tv3KzZR8mWxbYQ==
X-Received: by 2002:a17:906:ef90:b0:99c:4c94:1a9a with SMTP id ze16-20020a170906ef9000b0099c4c941a9amr6771620ejb.42.1691421601502;
        Mon, 07 Aug 2023 08:20:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj2BYdB5sgBFDcOsXFzpQIRJr3pnZIUQAYATthoLkJCHhAJUC+aVdZHM4mDbl/rkxKP6+Zig==
X-Received: by 2002:a17:906:ef90:b0:99c:4c94:1a9a with SMTP id ze16-20020a170906ef9000b0099c4c941a9amr6771610ejb.42.1691421601194;
        Mon, 07 Aug 2023 08:20:01 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id y8-20020a1709063a8800b0099316c56db9sm5241702ejd.127.2023.08.07.08.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 08:20:00 -0700 (PDT)
Message-ID: <3cdde518-1c0c-24dc-1ffb-90ae34c23296@redhat.com>
Date:   Mon, 7 Aug 2023 17:19:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ACPI: resource: revert "Remove "Zen" specific match and
 quirks"
Content-Language: en-US
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org
References: <20230806151453.10690-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230806151453.10690-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

On 8/6/23 17:14, Hans de Goede wrote:
> Commit a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and
> quirks") is causing keyboard problems for quite a log of AMD based
> laptop users, leading to many bug reports.
> 
> Revert this change for now, until we can come up with
> a better fix for the PS/2 IRQ trigger-type/polarity problems
> on some x86 laptops.
> 
> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229165
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229317
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217726
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I've spend most of today analysing the situation / this problem :

213031 - MEDION notebook internal keyboard not recognized / not working correctly
https://bugzilla.kernel.org/show_bug.cgi?id=213031

This is the bug that started it all, the issue here was overriding
a level low DSDT entry:

                IRQ (Level, ActiveLow, Exclusive, )
                    {1}

With an edge high entry from the MADT, note that edge high is the default
mp_irqs[idx].irqflags value for legacy/ISA IRQs. The dmesg for the Ice Lake
Medion M15T this bug is about shows no INT_SRC_OVR entry for IRQ 1
in the MADT, it does show INT_SRC_OVR entries for IRQ 0 and 9.

At first a fix was attempted to not use the MADT override unless
the DSDT entry was edge high. But that caused regressions, so a switch
to a DMI based approach was used instead. Noteworthy is that some of
the regressions benefitted from a MADT override to high edge for
IRQ 3 and 4 (UART IRQs) even though there are no INT_SRC_OVR messages
in the dmesg of the machine with the regression.

*** fast forward to today ***

The DMI quirk based approach seems to have worked well for the Ice Lake
era problems from approx. 3 years ago. But on AMD Zen based systems
the situation seems to be more complex. Not using the MADT override
is a problem for quite a few models. But using the MADT override
is a problem on quite a few other models ...

Looking at the status quo for v6.4 where MADT overriding by default
is not used, 3 bugs have been filed where the override is actually
necessary (note dmesg snippets with patched kernel to enable
MADT override):

217394 - IRQ override skipping breaks the Aya Neo Air Plus 6800U keyboard buttons 
https://bugzilla.kernel.org/show_bug.cgi?id=217394

Aya Neo Air Plus - AMD Ryzen 7 6800U

[    0.003333] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.003333] ACPI: INT_SRC_OVR (bus 0 bus_irq 1 global_irq 1 low edge)
[    0.003333] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.410670] ACPI: IRQ 1 override to edge, low(!)

217406 - very slow keyboard typing without IRQ override with new AMD Ryzen CPUs
https://bugzilla.kernel.org/show_bug.cgi?id=217406

HP Pavilion Aero 13 - AMD Ryzen 7735U 

[    0.026135] ACPI: INT_SRC_OVR (bus 0 bus_irq 1 global_irq 1 low edge)
[    0.026136] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.026137] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)

[    0.361640] ACPI: IRQ 1 override to edge, low(!)

217336 - keyboard not working Asus TUF FA617NS 
https://bugzilla.kernel.org/show_bug.cgi?id=217336

Asus TUF FA617NS - AMD Ryzen 7 7735HS

Noteworthy DSTD keyboard resource:

                IRQNoFlags ()
                    {1}

ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 1 global_irq 1 low edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ 1 override to edge, low(!)

So for all 3 do use MADT override on Zen bugs we have an INT_SRC_OVR dmesg entry
for IRQ 1.

Unfortunately the "MAINGEAR Vector Pro 2 17" / "MG-VCP2-17A3070T" for
which a quirk was added in commit 9946e39fe8d0 to force the override
even though it it Zen based breaks this pattern:

[    0.073733] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.073734] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.341347] ACPI: IRQ 1 override to edge, high(!)

Still the presence of an INT_SRC_OVR for a specific legacy IRQ seems
to be a strong indicator that MADT overriding should be used in that
case and can be used to at least reduce the amount of DMI quirks.

Another interesting data point is that all the devices for which
DMI quirks are present for which MADT overriding should not be used
for IRQ 1 all have a DSDT entry with the IRQ configured as level low
and exclusive.

I think that the best thing to do might be to go back to
the original approach from:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=0ec4e55e9f571f08970ed115ec0addc691eda613

and then limit this to IRQ1. Also maybe inverting the check to:

static bool irq_is_legacy(struct acpi_resource_irq *irq)
{
	return !(irq->triggering == ACPI_LEVEL_SENSITIVE &&
		 irq->polarity == ACPI_ACTIVE_LOW &&
		 irq->shareable == ACPI_EXCLUSIVE);
}

But I need to check if this will work for all the new Zen models
for which we got bug reports after the recent dropping of
9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platforms")

Regards,

Hans





> ---
>  drivers/acpi/resource.c | 60 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 1dd8d5aebf67..0800a9d77558 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -470,6 +470,52 @@ static const struct dmi_system_id asus_laptop[] = {
>  	{ }
>  };
>  
> +static const struct dmi_system_id lenovo_laptop[] = {
> +	{
> +		.ident = "LENOVO IdeaPad Flex 5 14ALC7",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82R9"),
> +		},
> +	},
> +	{
> +		.ident = "LENOVO IdeaPad Flex 5 16ALC7",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82RA"),
> +		},
> +	},
> +	{ }
> +};
> +
> +static const struct dmi_system_id tongfang_gm_rg[] = {
> +	{
> +		.ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
> +		},
> +	},
> +	{ }
> +};
> +
> +static const struct dmi_system_id maingear_laptop[] = {
> +	{
> +		.ident = "MAINGEAR Vector Pro 2 15",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-15A3070T"),
> +		}
> +	},
> +	{
> +		.ident = "MAINGEAR Vector Pro 2 17",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-17A3070T"),
> +		},
> +	},
> +	{ }
> +};
> +
>  static const struct dmi_system_id lg_laptop[] = {
>  	{
>  		.ident = "LG Electronics 17U70P",
> @@ -493,6 +539,10 @@ struct irq_override_cmp {
>  static const struct irq_override_cmp override_table[] = {
>  	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>  	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
> +	{ lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
> +	{ lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
> +	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
> +	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>  	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>  };
>  
> @@ -512,6 +562,16 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
>  			return entry->override;
>  	}
>  
> +#ifdef CONFIG_X86
> +	/*
> +	 * IRQ override isn't needed on modern AMD Zen systems and
> +	 * this override breaks active low IRQs on AMD Ryzen 6000 and
> +	 * newer systems. Skip it.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_ZEN))
> +		return false;
> +#endif
> +
>  	return true;
>  }
>  

