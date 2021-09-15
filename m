Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B86840C5AE
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Sep 2021 14:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbhIOMxL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Sep 2021 08:53:11 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:51078
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233574AbhIOMxJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Sep 2021 08:53:09 -0400
Received: from [192.168.1.5] (unknown [124.160.154.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CB5ED3F22D;
        Wed, 15 Sep 2021 12:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631710309;
        bh=rq9X1sYGHHPKLbmisEQnv3ABzhIUivDcYwmuwDygWSk=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=vuWuiSDQnqNl/fhuyK1oLYohKFpUffm5fAU+xtLFGvEucsiZZyvPMVEol5QMJhjFu
         lRlj6MqinfHeKMkAd5lp1HzcrnGUhKSJoFcrPSM3Hpc4yafc48OQJxl1IgmnQDYorw
         F/K+cuQ4/DREEe1/eNfY/obpcAaQSqatupCz9ZP4I56MxPYwnTcahHlRVBOBhgMZGN
         l3DJ6hdhcRuciqC7a7kD5PvyrChtgq50Q72o8e/OlZYYlYKbWHRE/1Oo9/aY2smZni
         VjqmlmO3zLR4J7OeGDLtcqhunVNtGMFBOujHPKMUKz2oVO8Kpz99qVlQYlqGQimIqj
         VnUnBpUSHvgqg==
Subject: Re: [PATCH v2] ACPI: resources: add legacy irq override exception by
 DMI info
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        manuelkrause@netscape.net
References: <20210914133410.88366-1-hui.wang@canonical.com>
 <CAJZ5v0jvSEdcgu+gRa2s25wW3L+RQHoyPJiorid7wZdKM23CQw@mail.gmail.com>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <338de10e-f93d-4633-b55f-81386ffb4295@canonical.com>
Date:   Wed, 15 Sep 2021 20:51:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jvSEdcgu+gRa2s25wW3L+RQHoyPJiorid7wZdKM23CQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 9/15/21 7:53 PM, Rafael J. Wysocki wrote:
> On Tue, Sep 14, 2021 at 3:34 PM Hui Wang <hui.wang@canonical.com> wrote:
[...]
>>
>> +       override = check_override && acpi_dev_irq_override(gsi, triggering,
>> +                                                          polarity, shareable);
>> +
> This can be still made more straightforward.
>
> The local bool variable is not necessary and check below can be
> rearranged as follows below.
>
>>          /*
>>           * In IO-APIC mode, use overridden attribute. Two reasons:
>>           * 1. BIOS bug in DSDT
>> @@ -401,7 +448,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>>           * using extended IRQ descriptors we take the IRQ configuration
>>           * from _CRS directly.
>>           */
>> -       if (legacy && !acpi_get_override_irq(gsi, &t, &p)) {
>> +       if (override && !acpi_get_override_irq(gsi, &t, &p)) {
> if (check_override &&
>      acpi_dev_irq_override(gsi, triggering, polarity, shareable) &&
>      !acpi_get_override_irq(gsi, &t, &p)) {

OK, got it. will change to it in the v3.

Thanks.


>>                  u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
>>                  u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>>
>> --
>> 2.25.1
>>
