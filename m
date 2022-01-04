Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0D848443A
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jan 2022 16:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiADPID (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Jan 2022 10:08:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232106AbiADPID (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Jan 2022 10:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641308882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m5qvi6VI75K4m5Xy/Lf2jDQtWXVEbFIApX4IB7rpEeI=;
        b=QIYJOEXXSCKfaQRdQA0P/trVmS4VmhY81XAhuDXKXBXWpKPo6Lhzs56vml1YYGl8qcDpwC
        G/O4yeO0qIauGUdEX90vMxRmcKSom9+mqD23XEbEIpV0mVx5XSUp84WOdooF4/UlnK7kaY
        yEcPclMcbCoqhf6c1Pp25P8XzULjJRQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-O_j0vaHSPQOcSLulm9YYbQ-1; Tue, 04 Jan 2022 10:08:01 -0500
X-MC-Unique: O_j0vaHSPQOcSLulm9YYbQ-1
Received: by mail-ed1-f69.google.com with SMTP id b8-20020a056402350800b003f8f42a883dso18288813edd.16
        for <linux-acpi@vger.kernel.org>; Tue, 04 Jan 2022 07:08:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m5qvi6VI75K4m5Xy/Lf2jDQtWXVEbFIApX4IB7rpEeI=;
        b=taWTogPc7/6IyduXbitjB3vvBHJ2qg9qS/oQVZ+vm2sCbBHIYhsBkm5P3ZU+WUqKjF
         jlZoqST6hK7DXgjsRrSm+pvPKAPkiXpeiQUhemkXchcjr8A0LGeNS3R38LESqqTZl8/w
         OlYNRvueTP0GKO3rpucw8VXq1R3E6LaBzrRK9z/FUMRs8giXcsY3Ya01x/2Olzq/bM8y
         aCU4OcyHB+Qpnku9hZMySdSfKQvG9Tdsd6BbNHV2LCahoBZ+75xwzpSQ0Vf6xx6YWQnk
         Lv8fG1G3e9ZoM+4ZGZ2E8gJ5FqY3F+EE5s8Onpa/1yoR0BzFeeC0anHN0W3dw237TtBS
         lKpg==
X-Gm-Message-State: AOAM533xuECUaDpV+yd+PmomGAL4nfR74aiRV8byFgxulgAEtULU/hLZ
        HSbB+LYQ/SpbBh+srWbNMFUI+VAfXWL3TMKqZ5jXwgluUTHK55Mbc2AZgWW+p+t50BSw0b31GXg
        2WRV7UrGFTeu3Xd1vnWmJyQ==
X-Received: by 2002:a05:6402:297:: with SMTP id l23mr47909529edv.400.1641308880310;
        Tue, 04 Jan 2022 07:08:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwigj6KtpYNQa6M50vzY3o8axn1bPlUk77k5KJSVSvkFdagfZypSmDygaCHmZhwm5zT+nVwFQ==
X-Received: by 2002:a05:6402:297:: with SMTP id l23mr47909519edv.400.1641308880132;
        Tue, 04 Jan 2022 07:08:00 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id nb27sm11556905ejc.136.2022.01.04.07.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 07:07:59 -0800 (PST)
Message-ID: <df517ead-3535-c191-32e4-abbca0358ec0@redhat.com>
Date:   Tue, 4 Jan 2022 16:07:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 0/2] ACPI / x86: ac and battery device quirk work
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20211230193120.589337-1-hdegoede@redhat.com>
 <CAJZ5v0ihpNHZxJBRDGDFGME+Z+PZ8p5qzZ+ck3DAL=UsfT_p2g@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0ihpNHZxJBRDGDFGME+Z+PZ8p5qzZ+ck3DAL=UsfT_p2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 1/4/22 15:52, Rafael J. Wysocki wrote:
> On Thu, Dec 30, 2021 at 8:31 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Rafael,
>>
>> Here are 2 patches for ACPI ac and battery device quirk handling on x86,
>> the first one refactors the almost identical quirk handling in ac.c and
>> battery.c out into a shared helper.
>>
>> And the 2nd patch then uses the now shared code to also skip / ignore
>> ac and battery devices on x86 Android tablets with known broken DSDTs.
>>
>> Note this applies on top of my:
>> "[PATCH v2 0/3] ACPI / pdx86: Add support for x86 Android tablets with broken DSDTs"
>> series which you've just merged into your bleeding edge branch.
>>
>> Regards,
>>
>> Hans
>>
>>
>> Hans de Goede (2):
>>   ACPI / x86: Introduce an acpi_quirk_skip_acpi_ac_and_battery() helper
>>   ACPI / x86: Skip ac and battery devices on x86 Android tablets with
>>     broken DSDTs
>>
>>  drivers/acpi/ac.c        | 43 ++------------------
>>  drivers/acpi/battery.c   | 42 ++------------------
>>  drivers/acpi/x86/utils.c | 86 ++++++++++++++++++++++++++++++++++++----
>>  include/acpi/acpi_bus.h  |  5 +++
>>  4 files changed, 90 insertions(+), 86 deletions(-)
> 
> Applied as 5.17 material.
> 
> Note that the changes here clashed with some recent battery driver
> changes, so I needed to resolve the merge conflict.  Please double
> check the result.

Sorry about the conflict.

I just checked and something indeed went wrong with the merge.

Checking drivers/acpi/battery.c from your bleeding-edge
branch there a bunch of now dead code still present there
related to setting the now never checked battery_check_pmic
global quirk flag:

Line 55: "static int battery_check_pmic = 1;"

Line 1105-1111:

"""
static int __init
battery_do_not_check_pmic_quirk(const struct dmi_system_id *d)
{
	battery_check_pmic = 0;
	return 0;
}

"""

Line 1146-1161:

"""
	{
		/* ECS EF20EA, AXP288 PMIC but uses separate fuel-gauge */
		.callback = battery_do_not_check_pmic_quirk,
		.matches = {
			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
		},
	},
	{
		/* Lenovo Ideapad Miix 320, AXP288 PMIC, separate fuel-gauge */
		.callback = battery_do_not_check_pmic_quirk,
		.matches = {
			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
			DMI_MATCH(DMI_PRODUCT_NAME, "80XF"),
			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
		},
	},
"""

Since this all just sets the now no longer checked battery_check_pmic flag, it
is harmless, but all of this can be removed.

Regards,

Hans



