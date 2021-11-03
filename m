Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE6744425A
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 14:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhKCN1g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 09:27:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58285 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231961AbhKCN13 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Nov 2021 09:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635945893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1UEjne3KTsM7G0LAMn2SKIuBZS6NQXeQ5ig+HYQFpI4=;
        b=ZnUxJCDcX7GmrK0zYc1GoKpTKTuBM7zxka+SFA0+2RQo+rNk+7EEqN+ISID0LD9/yT2WfG
        gcYdjKPMKtK3N7gfMcCA/9R5pXyIYMsK6/gKs+27euwYgCgzUxxk7qcGnwYa37BzzejW5Y
        6xLeYFRcWskD6uCpR5NrwOb5y5zdU5s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-JT80eE-9PgyY14U2s667Bg-1; Wed, 03 Nov 2021 09:24:52 -0400
X-MC-Unique: JT80eE-9PgyY14U2s667Bg-1
Received: by mail-ed1-f69.google.com with SMTP id y20-20020a056402359400b003e28c9bc02cso2481614edc.9
        for <linux-acpi@vger.kernel.org>; Wed, 03 Nov 2021 06:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1UEjne3KTsM7G0LAMn2SKIuBZS6NQXeQ5ig+HYQFpI4=;
        b=zyHquYtAmwNOaCtTJBUWZHGPnAaAEL8BO4tbAJqwXRZgjBTjKOWZUvqQ0Ej0Jfdbg+
         kFlnJQ+8+A61gN5okykYpr2wIcg1kUBrw4KXI0CHAaXI7NNxePlCqMjPUoIMHneXBFnE
         TKWKz6XADOlyrnWnYS2n3bBDm94+BGL8gZIF+F0Sh0UbPKjMtAb9x9B73kztqrttq3oi
         r3Bl6PkdEitzkGQXam8GC6hU/QehiuiPwc1Kduz3UaD6UBAR/V0KPw4Lg/6m5Kk3g+BX
         98wA/izcQLGvMM5V7x2NDwmy2hpFSkGx7VoVmzJ1tlwV6fgxBLHKS1k/A0S5LgOV2IV5
         XFaQ==
X-Gm-Message-State: AOAM5315DfopX0kFZfSNEmVKt9lyPFb331h2ZCGmOAJLde4dUo2GNm1E
        BjEscScud9XrgdcKnxfxdSOH8W6ltXO1ArZYZ1xWXkquMbl2T6UpkYPMcaVKLIK40Hss+BldaE1
        iqTCDZIW4C8cDUkwosy+utA==
X-Received: by 2002:a17:906:c156:: with SMTP id dp22mr16108429ejc.168.1635945890808;
        Wed, 03 Nov 2021 06:24:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCqyHl8agNlXtb5HAok/T9a3IaOhS26SNarB/DH1d5lwiDutq5HNGG50nvkNjDJuoExRsndA==
X-Received: by 2002:a17:906:c156:: with SMTP id dp22mr16108401ejc.168.1635945890567;
        Wed, 03 Nov 2021 06:24:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m3sm1304890eds.71.2021.11.03.06.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 06:24:50 -0700 (PDT)
Message-ID: <1f5708b8-c190-f732-bc91-64c8657fea73@redhat.com>
Date:   Wed, 3 Nov 2021 14:24:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 0/2] ACPI/power-suppy add fuel-gauge support on cht-wc
 PMIC without USB-PD support devs
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20211102223959.3873-1-hdegoede@redhat.com>
 <CAHp75VdoYO7DCWGHadgto3Aay836z1A7g4LHT7RNLF4kgAa_Pg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VdoYO7DCWGHadgto3Aay836z1A7g4LHT7RNLF4kgAa_Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/3/21 10:18, Andy Shevchenko wrote:
> On Wed, Nov 3, 2021 at 12:40 AM Hans de Goede <hdegoede@redhat.com> wrote:
> 
> ...
> 
>> While working on this I realized that there also is a 4th option,
>> which is basically option 1 from the v1 RFC minus the 2 gpiolib-acpi
>> patches.
>>
>> With the 2nd option (as implemented by this RFC) we leave the
>> _AEI handler in place and run the fuel-gauge without interrupt,
>> we can do the same when marking the fuel-gauge as always present
>> by treating IRQs on ACPI devices the same way as in the
>> max17042_battery code, which has already solved the IRQ problem
>> without disabling the _AEI handler:
>>
>>                 /*
>>                  * On ACPI systems the IRQ may be handled by ACPI-event code,
>>                  * so we need to share (if the ACPI code is willing to share).
>>                  */
> 
>>                 if (acpi_id)
>>                         flags |= IRQF_SHARED | IRQF_PROBE_SHARED;
>>
>> This is a pretty decent option too, it requires:
>>
>> 1. 2 more always_present quirks in the ACPI scan code which is part of
>> the main kernel image.
>>
>> 2. Patches to the bq27xxx_battery code to support ACPI enumeration.
> 
> If it works, why not try it?

I'm 99.9% sure it will work, so I see no reason to actually try it unless
we decide that this is a better option.

This option would basically be patches 1 + 4-5 from option 1 / the v1 RFC:
https://lore.kernel.org/platform-driver-x86/20211031162428.22368-1-hdegoede@redhat.com/

plus extra changes to the bq27xxx_battery code IRQ handling like above.

So this would mean 2 extra quirks in drivers/apci/x86/utils.c vs this
RFC v2 patches + various changes to the bq27xxx_battery code, where as
this (option 2/RFC v2) approach requires no changes to the bq27xxx_battery
code at all (1).

So at the cost of a board_file (patch 2/2 of this RFC v2 series) we save 2 quirks
which would be in the main vmlinuz image for everyone, as well as not having
to add any special code to the bq27xxx_battery code just for this one board;
and as mentioned the board-file .ko will only ever auto-load on the actual
board, so it just costs diskspace when enabled in generic distro kernels,
where as e.g. the 2 quirks take op memory for everyone.

So all in all I still believe that the approach in this v2 RFC is the best.

Also note that we already have an i2c-client being instantiated for a
bq27xxx_battery fuel-gauge (rather then forcing an ACPI-device as always-
present) here:

drivers/platform/x86/intel/int33fe/intel_cht_int33fe_microb.c

and for the max17042 fg here:

drivers/platform/x86/intel/int33fe/intel_cht_int33fe_typec.c

So doing the manual instantiation already is somewhat of a pattern
and IMHO is the best (least bad) option to deal with this.

> I like the common base for the FG drivers that can be used as a pattern then.

I don't believe this is a pattern which we want to introduce, with the
exception of one buggy BIOS version (2) fuel-gauges on ACPI devices
are never directly instantiated through an ACPI-device / fwnode.

The whole business of using native fuel-gauge drivers on X86/ACPI is
a special case just for BYT/CHT devices to begin with (because of
broken or outright missing ACPI battery class support) and on all but
the broken BIOS version the platform_dev or i2c-client for the
fuel-gauge is instantiated by specific kernel-code, rather then
directly from ACPI tables. So having ACPI enumeration support
in fuel-gauge drivers is something which we do not need and
should not want.

(Arguably we also need an always_hidden option for the ACPI quirks
and then use that to hide the anomaly of the MAX17042 ACPI device
not being hidden on the one troublesome BIOS version, this would
allow removing a nice amount of code in a bunch of places.)

Regards,

Hans



1) Well I notices some issues there which need fixes but those issues impact
all users of the bq27xxx_battery code and are not related to the discussed
enumeration issues

2) BIOS version, not board, other BIOS versions for the same board are fine

