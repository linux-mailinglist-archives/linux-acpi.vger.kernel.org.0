Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF3C4B5074
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Feb 2022 13:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiBNMmt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Feb 2022 07:42:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353323AbiBNMmo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Feb 2022 07:42:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FF9D49279
        for <linux-acpi@vger.kernel.org>; Mon, 14 Feb 2022 04:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644842555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X1Jpjwwox5k5370KtI4j1QtTVVVbkixYWe+bK2EarXk=;
        b=Rctb5thP9SIv54PqEJ/gAmyQ9++kaI/rfWjmXxb48HoSvJWrhW1TYu8Cuuys11J2wpbIIp
        BVnsynnqMYsfOr6c5mqTzBWPsa5ogjOZG4Nqd68AbikFl85GsVjKE7QloKkXJKx3w9iiIN
        uqqW7hYe5WkTEuv+r4VOdZMOdt7U5yE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-WiNgG4BnPOONLpZZcDtY8w-1; Mon, 14 Feb 2022 07:42:32 -0500
X-MC-Unique: WiNgG4BnPOONLpZZcDtY8w-1
Received: by mail-ed1-f70.google.com with SMTP id w18-20020a056402269200b00410b0a48d56so2375038edd.17
        for <linux-acpi@vger.kernel.org>; Mon, 14 Feb 2022 04:42:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X1Jpjwwox5k5370KtI4j1QtTVVVbkixYWe+bK2EarXk=;
        b=a8do7t3O4NiekUsYxikhgny9g3KTC7hf6b4ZtFgGC9pSdPmNya9e90pxOUYaSwDr6Y
         VEcUJYSOpKTd4oGUgOMCu8D2KXbGWZa0WkQ1twx5Ur8KB+78HfWS+bts3x+qNlfgIHeS
         mLXwWUUlCHwIvUzRFBPStSulrGEjB80qj52sEaSxMrEXeAoZChBKptvTfN0IYqrWKFrB
         Uq6bt2LGo9OjXpXpM3wWS4UIpDhvk62IJeAEOg3JTVf5bAPMw51h2cZXCqFCh64cK+PN
         UaSyfPu8re6X/SPZNlS/IFNw2BWtSx4pcOqcNM3L/MrOeXqGkN9JW2KGbo7qBjGAJ9Ee
         v9MQ==
X-Gm-Message-State: AOAM5330kVe+rtpfrHFoQBUvC7Lhihvq7XA8nCYsX4h+T542C5/FR8xd
        qhwkT9V41nlZC60D1PzBK2B+Rp9aQnNAL3CZMzNDggJZMnVN1qVQZI1yZVzCJhXiBAuSnw1vwNx
        5Q5V+DmBLucfkYqj8ZPjj1g==
X-Received: by 2002:aa7:c50c:: with SMTP id o12mr724067edq.371.1644842551360;
        Mon, 14 Feb 2022 04:42:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyj/l4tfOptcU/CYAsP61RQdEKzffgL3aoTinb5HoXeMc77SQL0GNkvMZVC2W7G+of0QpBr4A==
X-Received: by 2002:aa7:c50c:: with SMTP id o12mr724052edq.371.1644842551154;
        Mon, 14 Feb 2022 04:42:31 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 29sm6336686ejk.147.2022.02.14.04.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 04:42:30 -0800 (PST)
Message-ID: <039f9e8d-6e29-0288-606a-1d298e026c97@redhat.com>
Date:   Mon, 14 Feb 2022 13:42:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [5.17 regression] "x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems" breaks suspend/resume
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>
References: <a7ad05fe-c2ab-a6d9-b66e-68e8c5688420@redhat.com>
 <697aaf96-ec60-4e11-b011-0e4151e714d7@redhat.com> <YgKcl9YX4HfjqZxS@lahna>
 <02994528-aaad-5259-1774-19aeacdd18fc@redhat.com> <YgPlQ6UK3+4/yzLk@lahna>
 <2f01e99d-e830-d03c-3a9d-30b95726cc2c@redhat.com> <YgSzNAlfgcrm8ykH@lahna>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YgSzNAlfgcrm8ykH@lahna>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/10/22 07:39, Mika Westerberg wrote:
> Hi Hans,
> 
> On Wed, Feb 09, 2022 at 05:08:13PM +0100, Hans de Goede wrote:
>> As mentioned in my email from 10 seconds ago I think a better simpler
>> fix would be to just do:
>>
>> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
>> index 9b9fb7882c20..18656f823764 100644
>> --- a/arch/x86/kernel/resource.c
>> +++ b/arch/x86/kernel/resource.c
>> @@ -28,6 +28,10 @@ static void remove_e820_regions(struct resource *avail)
>>  	int i;
>>  	struct e820_entry *entry;
>>  
>> +	/* Only remove E820 reservations on classic BIOS boot */
>> +	if (efi_enabled(EFI_MEMMAP))
>> +		return;
>> +
>>  	for (i = 0; i < e820_table->nr_entries; i++) {
>>  		entry = &e820_table->entries[i];
>>  
>>
>> I'm curious what you think of that?
> 
> I'm not an expert in this e820 stuff but this one looks really simple
> and makes sense to me. So definitely should go with it assuming there
> are no objections from the x86 maintainers.

Unfortunately with this suspend/resume is still broken on the ThinkPad X1 carbon gen 2 of the reporter reporting the regression. The reporter has been kind enough to also test in EFI mode (at my request) and then the problem is back again with this patch. So just differentiating between EFI / non EFI mode is not an option.

FYI, here is what I believe is the root-cause of the issue on the ThinkPad X1 carbon gen 2:

The E820 reservations table has the following in both BIOS and EFI boot modes:

[    0.000000] BIOS-e820: [mem 0x00000000dceff000-0x00000000dfa0ffff] reserved

Which has a small overlap with:

[    0.884684] pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]

This leads to the following difference in assignments of PCI resources when honoring E820 reservations

[    0.966573] pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfb00000-0xdfcfffff]
[    0.966698] pci_bus 0000:02: resource 1 [mem 0xdfb00000-0xdfcfffff]

vs the following when ignoring E820 reservations:

[    0.966850] pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfa00000-0xdfbfffff]
[    0.966973] pci_bus 0000:02: resource 1 [mem 0xdfa00000-0xdfbfffff]

And the overlap of 0xdfa00000-0xdfa0ffff from the e820 reservations seems to be what is causing the suspend/resume issue.

###

As already somewhat discussed, I'll go and prepare this solution instead:

1. Add E820_TYPE_MMIO to enum e820_type and modify the 2 places which check for
   type == reserved to treat this as reserved too, so as to not have any
   functional changes there

2. Modify the code building e820 tables from the EFI memmap to use
   E820_TYPE_MMIO for MMIO EFI memmap entries.

3. Modify arch/x86/kernel/resource.c: remove_e820_regions() to skip
   e820 table entries with a type of E820_TYPE_MMIO,
   this would actually be a functional change and should fix the
   issues we are trying to fix.

Regards,

Hans

