Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3486C1C8687
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 12:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgEGKWT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 06:22:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29622 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgEGKWT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 May 2020 06:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588846937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=daEPk34nz7/mc4JDF7jTwtjOAhjMSLlPm91sqnZzBuI=;
        b=gu6YFyHY5DHPjMUV1+AtIz/wsLzieRBpR3FC2OUBo0eel0siRgj4g+I/BJlC+5XKFbEh5H
        2sdx48W6sGDv2jbFEC0NbQpogUvZZO1UnWsrMt3nw+XVOLxsTtzZX37UhpWvo68fMDhvl+
        MGzQAm09dwMUHo9SlDAOU0M310bFfzM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-vK7DUj1uPlyfzX3daZ4UZQ-1; Thu, 07 May 2020 06:22:16 -0400
X-MC-Unique: vK7DUj1uPlyfzX3daZ4UZQ-1
Received: by mail-wm1-f69.google.com with SMTP id f17so2280209wmm.5
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2020 03:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=daEPk34nz7/mc4JDF7jTwtjOAhjMSLlPm91sqnZzBuI=;
        b=eP1FIeroJZ6B2x0ZLFc9z3jgbGZMRdbbjTYPk2ece7mIV9kb5quTbJ9+HQoCk1XGR5
         0Ki8O9jL7Y9EvrdnJ7D/hDAX6IinFK0GwHv0Tp/Q/5iMXHGJYdkxMRyErMCgv7mbTbQ/
         Iw2cQ3oN57i9U54gU406IdMWvICv9d3838duzO2xa8PcgLrav7MIUBQVc5Dqgey5eDOy
         6Inpb0JVZXrW+lyBT7eUIlRlUgQHRCZ56pzvlnETHeY4ZJcsTuM46IgkPFzA993EFPOf
         pc1CXJAZD0U10E0HJ8VfK1o7Lh35pjoCHJvFptZhoWRp9T5jEyDaJW48/Cc0+0i1DKAV
         yN2w==
X-Gm-Message-State: AGi0PuYMSxgJ+qHQ/JRyhbB4bUZ+9WnF6eKe14iWn4gtEYDQFfmZctQq
        oOQ40DjGBEQSZL15fJJPtNZhKtRRpPLhhjz0klnZjMt3DS50EvJ8aRxTR/tSBB1dQoSF4jPvhg2
        vTEqL4MUBjbw0eWE4J0XRXw==
X-Received: by 2002:adf:bb4e:: with SMTP id x14mr14365971wrg.63.1588846934931;
        Thu, 07 May 2020 03:22:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypLbQmQ8O7FsZD4F25oysdIJsv00xcVAI1gzNc4qrcfwocuf280YRdmP3LDUgYBImau7I11qbQ==
X-Received: by 2002:adf:bb4e:: with SMTP id x14mr14365949wrg.63.1588846934676;
        Thu, 07 May 2020 03:22:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id u127sm7457177wme.8.2020.05.07.03.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 03:22:14 -0700 (PDT)
Subject: Re: [PATCH 0/3] ACPI / utils: Add acpi_evaluate_reg() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20200505132128.19476-1-hdegoede@redhat.com>
 <20200505154447.GU185537@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3d39d404-98b1-a69e-77dc-779846c77b08@redhat.com>
Date:   Thu, 7 May 2020 12:22:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505154447.GU185537@smile.fi.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 5/5/20 5:44 PM, Andy Shevchenko wrote:
> On Tue, May 05, 2020 at 03:21:25PM +0200, Hans de Goede wrote:
>> Hi All,
>>
>> Here is a small series adding an acpi_evaluate_reg() helper, note
>> the third patch sits on top of a fix for the pinctrl-cherryview
>> driver which I recently submitted and which is still finding its
>> way upstream.
>>
>> Since this is not urgent (just a small code cleanup) I suggest
>> that the ACPI people can pick up patches 1-2 and then the last patch
>> can be merged post 5.8-rc1, at which point all the dependencies for
>> it should have landed already.
> 
> Thank you!
> 
> Some minor comments to be addressed.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you, I will fix the remarks you have and send out a v2
with just patches 1 and 2 for now, then we can move forward
with those.

How to deal with the _REG not being called issue by the ACPICA
core issue on Cherryview devices is still being discussed, so
lets wait for the final fix for that and then I can send out
a new version of the 3th patch on top of that once the other
bits are merged.

Regards,

Hans

