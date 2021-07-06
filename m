Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3A43BDD2B
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jul 2021 20:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhGFSaj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Jul 2021 14:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46198 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229992AbhGFSaj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jul 2021 14:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625596079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c1hAP22t+F04dtV6l5OX6ERD06Cyqx+4ybbfUmOgayc=;
        b=ZJTxdN2cfxjlGbukOJXTIzemixAWHA0SSyKqpIxJ/kPeG2gKlGdcfME8QGCzirJA50fq/m
        CbzhbSouqhtycrrBDArj65tOfh5JZgBPPWD+fWXsIAeWZp94o6K+YzIRKVFcO4drOLC+KH
        TUgnMMVk7VhxcGbDUTK10dOjmVKhuE8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-ye0vBT_NP4aUnv0h2CfT-g-1; Tue, 06 Jul 2021 14:27:58 -0400
X-MC-Unique: ye0vBT_NP4aUnv0h2CfT-g-1
Received: by mail-ej1-f72.google.com with SMTP id p20-20020a1709064994b02903cd421d7803so6175662eju.22
        for <linux-acpi@vger.kernel.org>; Tue, 06 Jul 2021 11:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c1hAP22t+F04dtV6l5OX6ERD06Cyqx+4ybbfUmOgayc=;
        b=Y1Z8IKeZU8sQqhMFz5HVIFU4tKuccQPzdUysqRvIctlRsdnFJ8IyAZjZEBvyBy3aU5
         tbWYQAWxGQVDR3CobOM+31Mk9UhYP8qvEERYtNTMHfSjGIdrMrHWheQKfPskjMW6kdJa
         cTZvKI9Z1lu+MJwX9H4siy/T9+we9B3B0BteYX7OlBkq1un8Yg26SQ7JRM2JPhHSW3sI
         AcrpDKv62pCme6Ax3/XKRppovqiW1XC5yOl3wsVQ4Bivu7KGdW0M+yhZu3IBbO5wuTM5
         k3lqWOsvckObA1DstnXyw00sj/6Vo9byG3nh3qQFboXinST51zP/W2rrqGZZO9VSfkZR
         NrAA==
X-Gm-Message-State: AOAM531QrV6lFWLjZZMrB8YEeRBR01jyA1xBRqBZNVbei5rgikKDJYAZ
        /uYJ7ub86Wu5txWG2EbaQZurpGvhkQ0pXc1a66t7imKF8KWrLRwcm261EwBksLmplbKhq/yfdj2
        HaKFOwCXDzthMtFgNP/zsoxFrFJhz56Cv3gIejF2Z0oc7Cfc3ILPB2u1/cPajOCtT8JyGTpeZeQ
        ==
X-Received: by 2002:a17:906:8584:: with SMTP id v4mr19905028ejx.301.1625596077394;
        Tue, 06 Jul 2021 11:27:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJv1IgHiEv5mRLRk9yjNsoBI1Tv2eX9gGHUDcvAckvqefV3l+NY46gJ+1HsAP4hut5beUW0Q==
X-Received: by 2002:a17:906:8584:: with SMTP id v4mr19904991ejx.301.1625596077016;
        Tue, 06 Jul 2021 11:27:57 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id i8sm5977705ejo.30.2021.07.06.11.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 11:27:56 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] ACPI / PMIC: XPower: optimize MIPI PMIQ sequence
 I2C-bus accesses
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20210706160923.20273-1-hdegoede@redhat.com>
 <20210706160923.20273-2-hdegoede@redhat.com>
 <YOSGPC5p5guALYUJ@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7f13b049-d2a2-1720-2d82-a10770c49fb0@redhat.com>
Date:   Tue, 6 Jul 2021 20:27:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOSGPC5p5guALYUJ@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/6/21 6:35 PM, Andy Shevchenko wrote:
> On Tue, Jul 06, 2021 at 06:09:23PM +0200, Hans de Goede wrote:
>> The I2C-bus to the XPower AXP288 is shared between the Linux kernel and
>> the SoCs P-Unit. The P-Unit has a semaphore which the kernel must "lock"
>> before it may use the bus and while the kernel holds the semaphore the CPU
>> and GPU power-states must not be changed otherwise the system will freeze.
>>
>> This is a complex process, which is quite expensive. This is all done by
>> iosf_mbi_block_punit_i2c_access(). To ensure that no unguarded I2C-bus
>> accesses happen, iosf_mbi_block_punit_i2c_access() gets called by the
>> I2C-bus-driver for every I2C transfer. Because this is so expensive it
>> is allowed to call iosf_mbi_block_punit_i2c_access() in a nested
>> fashion, so that higher-level code which does multiple I2C-transfers can
>> call it once for a group of transfers, turning the calls done by the
>> I2C-bus-driver into no-ops.
>>
>> The default exec_mipi_pmic_seq_element implementation from
>> drivers/acpi/pmic/intel_pmic.c does a regmap_update_bits() call and
>> the involved registers are typically marked as volatile in the regmap,
>> so this leads to 2 I2C-bus accesses.
>>
>> Add a XPower AXP288 specific implementation of exec_mipi_pmic_seq_element
>> which calls iosf_mbi_block_punit_i2c_access() calls before the
>> regmap_update_bits() call to avoid having to do the whole expensive
>> acquire P-Unit semaphore dance twice.
> 
> ...
> 
> The idea for the further improvement
> 
>> +	if (i2c_address != 0x34) {
>> +		pr_err("%s: Unexpected i2c-addr: 0x%02x (reg-addr 0x%x value 0x%x mask 0x%x)\n",
>> +		       __func__, i2c_address, reg_address, value, mask);
>> +		return -ENXIO;
>> +	}
> 
> We have this in intel_pmic.c. Can we reorganize the code the way we will have
> this check solely in the intel_pmic.c?

No, the drivers/acpi/pmic/intel_pmic_chtwc.c implementation accepts multiple
i2c addresses because the whiskey cove has multiple register banks split
over different i2c-addressses.

Regards,

Hans

