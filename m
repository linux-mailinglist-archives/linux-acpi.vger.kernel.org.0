Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F4B45A5BB
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 15:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhKWOgo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 09:36:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237991AbhKWOgl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 09:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637678012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GlQ7neAf3vKotnvHgathjuTef4jE0oGqHMBfZ9Tq9gs=;
        b=M7vd6TdgNLE6feVKjrcuq6rGMx3s8FeofrgjAE7Sv39tADQJRJ9gqVcTLBQZXAydnPmZEQ
        1FbVAkjBM3CFFgx9Gj57RIDMWhUs6HareVchoFM1JeEGTnj7ZW0vbikC1NB2T4nb9hNtVu
        Lg0RD/aTteBZkETkuwk2cU2gXR5pjnQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-5wvkpUrSOz-C6tZqMrTuoA-1; Tue, 23 Nov 2021 09:33:31 -0500
X-MC-Unique: 5wvkpUrSOz-C6tZqMrTuoA-1
Received: by mail-ed1-f72.google.com with SMTP id c1-20020aa7c741000000b003e7bf1da4bcso17934754eds.21
        for <linux-acpi@vger.kernel.org>; Tue, 23 Nov 2021 06:33:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GlQ7neAf3vKotnvHgathjuTef4jE0oGqHMBfZ9Tq9gs=;
        b=fC07wCJwtoyVsmKuZ1r25lxxRompHRkRhJywlHUBne4ucKu1YHdCJxcI19d3MahlAN
         H2PwF5+ZaS51f7fOub1kP4+Cns4Hayau/1AQ+qM2TfW51sL4qhX+/2mN1mC2ImXVQQzV
         aTY9niAqGoQY015BY3bSb4prVq6NlR6hWkKzbeOBREirjTjHoag8x2ngIE16N5lAlHdl
         hqdFruOuZqoyKrKc7bYo+6lcyD9PyS/4l+e4ofPzkzCWJOCKS+ljQW9KLP7vRQRtplKO
         mDbXAu8Q3+ES4Hkwzqq+LxpQ5zqoFWm/E1GAYsZwQNEWhuFituhqgEUuy1vl5PF43ukC
         bZWw==
X-Gm-Message-State: AOAM5319pi9CWwGEt8xCqoRJ+QdyLU63ToZzOx9jboPPRU0Cg5M8WQwr
        FmRLIXPo05zbG0num/TVZSgE3I176MsfdlethPvP7znfFGnVQSqNMQzKIok0TAynL5xiW2mbTtk
        ormhEdjdEHvzZjmvfbRuAkg==
X-Received: by 2002:aa7:dbca:: with SMTP id v10mr10033200edt.280.1637678009881;
        Tue, 23 Nov 2021 06:33:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwM6sZDBXNvZq21GD8hv0D76i/zF6xqLU6SZULsUuPnIhoUpAz2DY/y8mTaNSapofDR9nNcwg==
X-Received: by 2002:aa7:dbca:: with SMTP id v10mr10033173edt.280.1637678009731;
        Tue, 23 Nov 2021 06:33:29 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id eg8sm5836080edb.75.2021.11.23.06.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 06:33:29 -0800 (PST)
Message-ID: <471c7587-4b45-8540-45ec-9a1fcd03caab@redhat.com>
Date:   Tue, 23 Nov 2021 15:33:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 0/7] ACPI: acpi_device_override_status() changes
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20211122170536.7725-1-hdegoede@redhat.com>
 <CAPDyKFqtYJ2aT+brhAG9r-VTuK=-25nEAXhw_M7yWhUSJN=BXg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAPDyKFqtYJ2aT+brhAG9r-VTuK=-25nEAXhw_M7yWhUSJN=BXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/23/21 12:13, Ulf Hansson wrote:
> On Mon, 22 Nov 2021 at 18:05, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Rafael,
>>
>> As requested here is a v2 of my series previously titled:
>> "ACPI: scan: Skip turning off some unused objects during scan"
>>
>> Which was a regression fix series for the commit c10383e8ddf4
>> ("ACPI: scan: Release PM resources blocked by unused objects")
>> change, but that has been reverted now. So as requested here is
>> a v2 changing the wording of various commit messages since these
>> changes are still useful to have regardless.
>>
>> Patch 1/7 is a v2/resend of the "ACPI / x86: Drop PWM2 device on
>> Lenovo Yoga Book from always present table" patch. You requested
>> changing the commit message of this one a bit to make it sound
>> less like a regression fix (which it is not). But you already
>> have the previous version of this patch in your bleeding-edge
>> branch, with a "Cc: 5.1+ <stable@vger.kernel.org> # 5.1+"
>> added ?  So depending on which version you want you can either
>> skip this patch when applying this series, or replace it with
>> the version from this series.
>>
>> Patches 2-4 are the main changes to make the always_present
>> quirk handling more flexible, changing it into a status_override
>> mechanism + adding a quirk for the GPD win and pocket to fix
>> an issue with those in a more elegant matter then the current
>> kludge in the sdhci-acpi code.
>>
>> Patch 5 is an unrelated patch which touches the override-status
>> quirk table, so it needed to be rebased and I decided to add it
>> to this series to make it clear that its v2 needs to be applied
>> on top of the other ACPI changes from this series.
>>
>> Patches 6+7 cleanup the sdhci-acpi code, removing the now no
>> longer needed ugly kludge for the GPD win/pocket. These can
>> be merged independently from patches 1-5, through the mmc
>> tree, as long as they get send to Linus during the same
>> kernel cycle as the ACPI bits.
> 
> This sounds like the mmc changes are really not that independent after
> all. What about bisectability?

Merging the ACPI and mmc bits separately does indeed have a 50% chance
of causing an issue where during a bisect the wifi might stop working
on the GPD win / pocket. But only on those 2 models, so it won't be
a general bisect break; and it will only break wifi, without causing
other side-effects.

So I believe this really is mostly a theoretical issue. With that
said merging the entire set to one tree of course is fine too,
maybe even better because it keeps the related ACPI and sdhci
commit close together in the history.

> An option is to funnel the sdhci patches together with the ACPI
> patches through Rafael's tree. You have my ack for this, but let's
> wait for Adrian's ack too.

Thanks.

Regards,

Hans

