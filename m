Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF1D6D2BF2
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Apr 2023 01:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjCaX5p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Mar 2023 19:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjCaX5a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Mar 2023 19:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD561D2EB
        for <linux-acpi@vger.kernel.org>; Fri, 31 Mar 2023 16:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680306967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NL54WwypdfaSjaxUxBBBx0hRcNBlMPANtnUbzkWfNYM=;
        b=ebwbkimVeQTt3+R8ZMF5psGLcrYlyBFHmNDCxqVy0YxHZQO49u4IM/XL6bYJv0izch6FPx
        auydduCzqaiLmGPa0Wqbs+WRRwet2RmQyleGeaViC7wuSHz0+6OkrbQoiljnw4/BEmzcjB
        /+PX8aES+RM+thJAU53kxX+nth4F7lI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-alwZAtwIP8eZMqJt_Fb0AQ-1; Fri, 31 Mar 2023 19:56:06 -0400
X-MC-Unique: alwZAtwIP8eZMqJt_Fb0AQ-1
Received: by mail-qt1-f200.google.com with SMTP id c14-20020ac87d8e000000b003e38726ec8bso15626083qtd.23
        for <linux-acpi@vger.kernel.org>; Fri, 31 Mar 2023 16:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680306965;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NL54WwypdfaSjaxUxBBBx0hRcNBlMPANtnUbzkWfNYM=;
        b=sx7kzU6utUEXrMDJ5WuOjXV6zmRqUG3nNZ6TrANihFfyby8BJvHfFDlIyZ3jHIr+5N
         7wv9MRcsVnEkAW+pfqBbsTP9CzplXWOecYHb8wM7ftCjfRjyVBEN0M9UIsGViJt+sCmD
         u7z9oMH49BQNk6uaIhyAtK9exFUEpSUah6AKJ2U6L6tjuPn07Fj83mTYgRfl6vLWZNdH
         fgVrmrxOnC9AMnacU61wP1ZHbWLafMPU8FKZItVa2MINw4sKiowJbI978k6rnIZoNW3v
         b2wxuSZYYYEVSbCU2VCJVlOlcHpxm1o6yUZzAbpzERv9QkDHgWNHb5oZCfSAiQRTinG1
         ws5g==
X-Gm-Message-State: AAQBX9fJ5T84arcMggz3iA7EJNyTCT0cT/j5QlKpAxoYMUe3qCOZHosd
        x/fsEXr23Zoa68UwfG3xzBAWj55rUXzqciwpA/tNMaxjyghPLmZNqQFgu7lxrER8NS2GtTwUuZa
        2/qsZLNkUCzI/yfjImdQKt7vUEdfStYTXHH6n2STktZmBsWjbyxdB6E5EVdhjEUzP1NWtMB/yTw
        f0mQ==
X-Received: by 2002:ac8:5a87:0:b0:3e6:454f:9a89 with SMTP id c7-20020ac85a87000000b003e6454f9a89mr4220255qtc.14.1680306965112;
        Fri, 31 Mar 2023 16:56:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZnxJYCYjCfNczshNPHN4pv+/C1fm/oK1ineW0RTnU6Ldeblpw0pQ6aZRBHQoOTm1TNEsQNzw==
X-Received: by 2002:ac8:5a87:0:b0:3e6:454f:9a89 with SMTP id c7-20020ac85a87000000b003e6454f9a89mr4220222qtc.14.1680306964805;
        Fri, 31 Mar 2023 16:56:04 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c57:b700::feb? ([2600:4040:5c57:b700::feb])
        by smtp.gmail.com with ESMTPSA id t18-20020a37ea12000000b0074860fcfbecsm1031786qkj.21.2023.03.31.16.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 16:56:04 -0700 (PDT)
Message-ID: <c5e49ef29c50715f8fa5086fec999c0fa6d84dac.camel@redhat.com>
Subject: Re: [PATCH] Revert "x86/acpi/boot: Do not register processors that
 cannot be onlined for x2APIC"
From:   Lyude Paul <lyude@redhat.com>
To:     linux-acpi@vger.kernel.org
Cc:     Leo Duran <leo.duran@amd.com>,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Date:   Fri, 31 Mar 2023 19:56:03 -0400
In-Reply-To: <20230331235328.4312-1-lyude@redhat.com>
References: <20230331235328.4312-1-lyude@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 2023-03-31 at 19:53 -0400, Lyude Paul wrote:
> This reverts commit e2869bd7af608c343988429ceb1c2fe99644a01f. This commit
> unfortunately seems to have resulted in one of my machines no longer
> booting. Specifically, this machine is a custom build with a MS-7A39/A320=
M
> GAMING PRO motherboard with firmware version v1.10. I'm not entirely sure
> of the cause yet, but starting it up with "earlycon=3Defifb keep_bootcon"=
 has
> informed me that the kernel panics like so:
>=20
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x33/0x46
>   panic+0x105/0x2b1
>   ? timer_irq_works+0x53/0xef
>   panic_if_irq_remap.cold+0x5/0x5
>   setup_IO_APIC+0x3c4/0x831
>   ? __pfx_native_io_apic_read+0x10/0x10
>   ? __ioapic_read_entry+0x34/0x50
>   ? _raw_spin_unlock_irqrestore+0x1b/0x40
>   ? clear_IO_APIC_pin+0x16b/0x240
>   apic_intr_mode_init+0x101/0x106
>   x86_late_time_init+0x20/0x34
>   start_kernel+0x8b4/0x95f
>   secondary_startup_64_no_verify+0x5e/0xeb
>   </TASK>
> ---[ end Kernel panic - not syncing: timer doesn't work through
>  interrupt-mapped IO-APIC ]---

Agh, I totally forgot to actually decode the stacktrace on this before send=
ing
it out. I can do that if anyone would think it would help, but I have a
feeling the stacktrace here isn't particularly useful in the first place
considering the culprit commit here.

As well, hopefully it goes without saying but: I'm happy to try any kind of
fixes or provide any more information from this machine. Just let me know =
=E2=99=A5

>=20
> My assumption is there's probably something funky with the firmware on th=
e
> machine seeing as it's a random gaming motherboard, but that also probabl=
y
> means there are other boards out there like this that are cold, afraid, a=
nd
> unable to boot. We could warm their hearts by reverting this, or maybe by
> figuring out a proper fix.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: e2869bd7af60 ("x86/acpi/boot: Do not register processors that cann=
ot be onlined for x2APIC")
> Cc: Leo Duran <leo.duran@amd.com>
> Cc: Kishon Vijay Abraham I <kvijayab@amd.com>
> Cc: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
>  arch/x86/kernel/acpi/boot.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 1c38174b5f019..4177577c173bf 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -188,17 +188,6 @@ static int acpi_register_lapic(int id, u32 acpiid, u=
8 enabled)
>  	return cpu;
>  }
> =20
> -static bool __init acpi_is_processor_usable(u32 lapic_flags)
> -{
> -	if (lapic_flags & ACPI_MADT_ENABLED)
> -		return true;
> -
> -	if (acpi_support_online_capable && (lapic_flags & ACPI_MADT_ONLINE_CAPA=
BLE))
> -		return true;
> -
> -	return false;
> -}
> -
>  static int __init
>  acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned lo=
ng end)
>  {
> @@ -223,10 +212,6 @@ acpi_parse_x2apic(union acpi_subtable_headers *heade=
r, const unsigned long end)
>  	if (apic_id =3D=3D 0xffffffff)
>  		return 0;
> =20
> -	/* don't register processors that cannot be onlined */
> -	if (!acpi_is_processor_usable(processor->lapic_flags))
> -		return 0;
> -
>  	/*
>  	 * We need to register disabled CPU as well to permit
>  	 * counting disabled CPUs. This allows us to size
> @@ -265,7 +250,9 @@ acpi_parse_lapic(union acpi_subtable_headers * header=
, const unsigned long end)
>  		return 0;
> =20
>  	/* don't register processors that can not be onlined */
> -	if (!acpi_is_processor_usable(processor->lapic_flags))
> +	if (acpi_support_online_capable &&
> +	    !(processor->lapic_flags & ACPI_MADT_ENABLED) &&
> +	    !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
>  		return 0;
> =20
>  	/*

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

