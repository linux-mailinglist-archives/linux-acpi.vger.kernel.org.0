Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CC4485250
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jan 2022 13:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbiAEMSB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jan 2022 07:18:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235171AbiAEMSB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jan 2022 07:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641385080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tG8ao8ZwwPZIHs1awBWwZWcFcF8+em9e/44mwLxFi9Q=;
        b=FI3r+IPFVUomtPrDqyxMD5AI4MZOEu4mQ2wxiz7X7hKB/ARp7ROK8JJ4XOlLK2J+9TGLx0
        iBr/5V6nhNe2GqF7ktqQe4XrFuP9x28TDgxBFEqnX+GnVzTZwpab7pyCxCmH8MKerOlUgJ
        oD6NTuPtaYV/kRC6Q1Z//B01ZsjnPiE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-4fJfXE7mM-G1SVL9VQiS8A-1; Wed, 05 Jan 2022 07:17:59 -0500
X-MC-Unique: 4fJfXE7mM-G1SVL9VQiS8A-1
Received: by mail-ed1-f71.google.com with SMTP id b8-20020a056402350800b003f8f42a883dso20601621edd.16
        for <linux-acpi@vger.kernel.org>; Wed, 05 Jan 2022 04:17:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tG8ao8ZwwPZIHs1awBWwZWcFcF8+em9e/44mwLxFi9Q=;
        b=tp5fcMcvtTJ4oLzOf1K1sbM+qPcX55JXIB+DwsTB63GYieAmTFHDKLP8C0lGdwFQJX
         U6Z/VOrHHHP4slFi4W2HNkd68A2OZsBxVrNzui1SVsPRNsl5CmljLdnFrBTH+MckIKBJ
         PbwtWMXBSrysSnFkzImMtP4ZYFMljBnN59R68VXEXwcXzEALXHyajq1y0ixO4newiRPl
         p8wAqWjE7qvFBXbTwd7K6y0RCvs8hMHEJ58S05aOXdfo9tIiaQ3VNZ8mWwf/DBToEKgQ
         O7FtVx0AKbIqPUCFjkpvY034d0OWSU4f1hnx1mWwNLidqdl0ekw7k/h5Qk4j8JJPpN/A
         Wohg==
X-Gm-Message-State: AOAM5325m5/Zj1MVO6aWIDkXNLCJsEKWrdoUMsO3BVpj6K8mqx96/+Fh
        sjrX1kwccH11Yo+VH7GcPP4E2/u00NqxrS7vRQD7AOdkr+wc/YNGiTxNf/delTrlEmw/6qxWocg
        Wg+QhScuWMPUmUFQvq74IEQ==
X-Received: by 2002:a17:907:760b:: with SMTP id jx11mr36387271ejc.99.1641385077946;
        Wed, 05 Jan 2022 04:17:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJ14EYavVQDpmcTFtCmhEDZ3ieLkwkvvVcQKr/nkn7iIwx/X5eWUgobSVDnMArMKUDfsTaYg==
X-Received: by 2002:a17:907:760b:: with SMTP id jx11mr36387258ejc.99.1641385077787;
        Wed, 05 Jan 2022 04:17:57 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id jg34sm12228942ejc.74.2022.01.05.04.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 04:17:57 -0800 (PST)
Message-ID: <fe4ec79a-fea0-2957-5052-7700d890be3b@redhat.com>
Date:   Wed, 5 Jan 2022 13:17:56 +0100
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
 <df517ead-3535-c191-32e4-abbca0358ec0@redhat.com>
 <CAJZ5v0g545AoFd1Z==gzJe4cR_n-7PTCUn8QBiLcV1GtUxvW2Q@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0g545AoFd1Z==gzJe4cR_n-7PTCUn8QBiLcV1GtUxvW2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/4/22 21:03, Rafael J. Wysocki wrote:
> On Tue, Jan 4, 2022 at 4:08 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Rafael,
>>
>> On 1/4/22 15:52, Rafael J. Wysocki wrote:
>>> On Thu, Dec 30, 2021 at 8:31 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi Rafael,
>>>>
>>>> Here are 2 patches for ACPI ac and battery device quirk handling on x86,
>>>> the first one refactors the almost identical quirk handling in ac.c and
>>>> battery.c out into a shared helper.
>>>>
>>>> And the 2nd patch then uses the now shared code to also skip / ignore
>>>> ac and battery devices on x86 Android tablets with known broken DSDTs.
>>>>
>>>> Note this applies on top of my:
>>>> "[PATCH v2 0/3] ACPI / pdx86: Add support for x86 Android tablets with broken DSDTs"
>>>> series which you've just merged into your bleeding edge branch.
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>>>
>>>>
>>>> Hans de Goede (2):
>>>>   ACPI / x86: Introduce an acpi_quirk_skip_acpi_ac_and_battery() helper
>>>>   ACPI / x86: Skip ac and battery devices on x86 Android tablets with
>>>>     broken DSDTs
>>>>
>>>>  drivers/acpi/ac.c        | 43 ++------------------
>>>>  drivers/acpi/battery.c   | 42 ++------------------
>>>>  drivers/acpi/x86/utils.c | 86 ++++++++++++++++++++++++++++++++++++----
>>>>  include/acpi/acpi_bus.h  |  5 +++
>>>>  4 files changed, 90 insertions(+), 86 deletions(-)
>>>
>>> Applied as 5.17 material.
>>>
>>> Note that the changes here clashed with some recent battery driver
>>> changes, so I needed to resolve the merge conflict.  Please double
>>> check the result.
>>
>> Sorry about the conflict.
>>
>> I just checked and something indeed went wrong with the merge.
>>
>> Checking drivers/acpi/battery.c from your bleeding-edge
>> branch there a bunch of now dead code still present there
>> related to setting the now never checked battery_check_pmic
>> global quirk flag:
>>
>> Line 55: "static int battery_check_pmic = 1;"
>>
>> Line 1105-1111:
>>
>> """
>> static int __init
>> battery_do_not_check_pmic_quirk(const struct dmi_system_id *d)
>> {
>>         battery_check_pmic = 0;
>>         return 0;
>> }
>>
>> """
>>
>> Line 1146-1161:
>>
>> """
>>         {
>>                 /* ECS EF20EA, AXP288 PMIC but uses separate fuel-gauge */
>>                 .callback = battery_do_not_check_pmic_quirk,
>>                 .matches = {
>>                         DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
>>                 },
>>         },
>>         {
>>                 /* Lenovo Ideapad Miix 320, AXP288 PMIC, separate fuel-gauge */
>>                 .callback = battery_do_not_check_pmic_quirk,
>>                 .matches = {
>>                         DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>                         DMI_MATCH(DMI_PRODUCT_NAME, "80XF"),
>>                         DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
>>                 },
>>         },
>> """
>>
>> Since this all just sets the now no longer checked battery_check_pmic flag, it
>> is harmless, but all of this can be removed.
> 
> OK, I redid the merge, please check again.

This looks good now, thanks.

Regards,

Hans

