Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8C640A57C
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Sep 2021 06:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhINEke (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Sep 2021 00:40:34 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:53918
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230415AbhINEkd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Sep 2021 00:40:33 -0400
Received: from [192.168.1.5] (unknown [124.160.154.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3B9283F045;
        Tue, 14 Sep 2021 04:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631594349;
        bh=uuBU+h/IuQdUNYiepyHPinjsbxSTa1hGW+k7DP/hvXA=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=WEPj88bKWxWsZURTRfDjuCB+8K6p2Y+c+choKn8n8/pFlozFcBDIhm6XTAoOfLDm9
         816l9cUxQrGmrXOr26H4IIwYT7HqCEz4+LD7Q2qKdcERTSuXu01ZhQAzp/TZudE1cn
         Q4oamOub4ae9kuraqoTYWDxncesoTWzoXAnHkcY2nybkaD5BqF0p6dye1JEDAOB/6r
         Ap+cae4s5y4XqpGsQA1znzkUqwjqCaEBvpK4NnHaE7vuL8pNIIfw6jjr4Emu0dHDBr
         5Iv0JfQaBHoXIjybEZ1cQX+zvHBK3VGMZz2Qsjn38xturPOpVaK30q+uLvvMLDH2ZJ
         WJEcJLRReEjxQ==
Subject: Re: [PATCH] ACPI: resources: add legacy irq override exception by DMI
 info
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        manuelkrause@netscape.net
References: <20210904014340.17536-1-hui.wang@canonical.com>
 <CAJZ5v0gocDX_XFDkUQuYkEEjkxFjPW_u0mf1ZzaHd6FWwAn+bQ@mail.gmail.com>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <583e76f8-a30b-eb52-18a8-c83ffe48886d@canonical.com>
Date:   Tue, 14 Sep 2021 12:39:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gocDX_XFDkUQuYkEEjkxFjPW_u0mf1ZzaHd6FWwAn+bQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 9/14/21 1:10 AM, Rafael J. Wysocki wrote:
> On Sat, Sep 4, 2021 at 3:44 AM Hui Wang <hui.wang@canonical.com> wrote:
>> After the commit 0ec4e55e9f57 ("ACPI: resources: Add checks for ACPI
>> IRQ override") is reverted, the keyboard of those Medion laptops can't
>> work again.
>>
>> To fix the keyboard issue, here adding an override check by DMI info,
>> this will not affect other machines and this design refers to
>> the prt_quirks[] in the drivers/acpi/pci_irq.c.
>>
>> If we meet similar issues on other platforms, we could expand the
>> table of skip_override_table[] or medion_laptop[].
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
>> BugLink: http://bugs.launchpad.net/bugs/1909814
>> Reported-by: Manuel Krause <manuelkrause@netscape.net>
>> Tested-by: Manuel Krause <manuelkrause@netscape.net>
[...]
>> +                                        u8 shareable)
>> +{
>> +       int i;
>> +       const struct irq_override_cmp *en;
> This can be declared inside the for () loop.  Also, if "en" means
> "entry", please call the variable "entry".
OK, got it.
>
>> +
>> +       for (i = 0; i < ARRAY_SIZE(skip_override_table); i++) {
>> +               en = &skip_override_table[i];
>> +
>> +               if (dmi_check_system(en->system) &&
>> +                   en->irq == gsi &&
>> +                   en->triggering == triggering &&
>> +                   en->polarity == polarity &&
>> +                   en->shareable == shareable)
>> +                       return false;
>> +       }
>> +
>> +       return true;
>> +}
>> +
>>   /**
>>    * acpi_dev_resource_interrupt - Extract ACPI interrupt resource information.
>>    * @ares: Input ACPI resource object.
>> @@ -447,6 +491,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>>   {
>>          struct acpi_resource_irq *irq;
>>          struct acpi_resource_extended_irq *ext_irq;
>> +       bool is_legacy;
>>
>>          switch (ares->type) {
>>          case ACPI_RESOURCE_TYPE_IRQ:
>> @@ -459,9 +504,14 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>>                          irqresource_disabled(res, 0);
>>                          return false;
>>                  }
>> +
>> +               is_legacy = acpi_dev_legacy_irq_override(irq->interrupts[index],
>> +                                                        irq->triggering, irq->polarity,
>> +                                                        irq->shareable);
>> +
>>                  acpi_dev_get_irqresource(res, irq->interrupts[index],
>>                                           irq->triggering, irq->polarity,
>> -                                        irq->shareable, true);
>> +                                        irq->shareable, is_legacy);
> Maybe we can rename the last argument of acpi_dev_get_irqresource() to
> check_override (or similar) and do the check in there when that is
> set?

OK will change it as the suggestion.

Thanks.

>>                  break;
>>          case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
>>                  ext_irq = &ares->data.extended_irq;
>> --
