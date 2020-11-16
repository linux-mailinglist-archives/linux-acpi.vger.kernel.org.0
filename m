Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF7E2B45EA
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Nov 2020 15:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgKPOdI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Nov 2020 09:33:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729613AbgKPOdI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Nov 2020 09:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605537187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pVqPTgI76T5GFIq9BCs/H6903+24L9xVPbvpVQ0trVs=;
        b=NI7OsINMaRHgVcdFH+SU+Zte6EK65NRlsYXgXuHHXe3S7A11ywhbwYEbYykVqAlyYaxJZY
        6h1F/6B6otTp2ChflDTaEOZnCvy1zkCxlAupaDvPq/VvbY0Nnj/J0iZ9d1E4CmwOsCAWEV
        TcpWJMGmamlzipM75lH4YFLgOdpcPMo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-eaMNcvrqOUa3tj-IBFLovg-1; Mon, 16 Nov 2020 09:33:04 -0500
X-MC-Unique: eaMNcvrqOUa3tj-IBFLovg-1
Received: by mail-ej1-f69.google.com with SMTP id nt22so7676584ejb.17
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2020 06:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pVqPTgI76T5GFIq9BCs/H6903+24L9xVPbvpVQ0trVs=;
        b=npSc8UyXqU6oNb7oavkBMboXcZ/kRr1NKQfRwJClFpyA5rMlsINK5GIXO5wwcTvhcB
         l2FniZxflxn29sq3WWWdpsWpajRqFjDZe7v7xcS0IoQNW8ZAaiqQYTo0ZJE5d23q67yR
         sZ8PnhYE7VaTxVbHvrmerTN4rNdNIM0iaOokA3/omDBdJ2a/9ZZ94A26e6EUwrA0XOB8
         J80pQ9AYRB7g6aADDfu38DGcjdAHRrWhhi6qMHp/bfCrv8QrE+ra75djC0m5NNR7qnEv
         uw92y+Lfj+qQyLfxBLkXoZQgZMzJ21ycrusE5P6c0N7JuEDXaLvcKAPq6mOoMWet8D5Y
         APFA==
X-Gm-Message-State: AOAM531yDG6USB0w5bRvmB3UVp9/3QBlG0viQNmjYUUBRUjyqC/1t6U5
        ZnWkgbhbXmyMAgHs08E1fJKHyLvDMel+kU6X6MEOdkybq1iATGTopZNQMlrT2MHB9iCnP6G0/Tg
        B4f9yUi08gtMoxrujKoVTzA==
X-Received: by 2002:a05:6402:3105:: with SMTP id dc5mr15298198edb.38.1605537183490;
        Mon, 16 Nov 2020 06:33:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwoL+hiEtIkBgfgse/cu8U7sdEWiH/JNWpKEa8hPzaXcoIWgmEEVyUYdkjjcNHlO31gc33S3A==
X-Received: by 2002:a05:6402:3105:: with SMTP id dc5mr15298187edb.38.1605537183335;
        Mon, 16 Nov 2020 06:33:03 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id w16sm10655384eds.81.2020.11.16.06.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 06:33:02 -0800 (PST)
Subject: Re: [External] Re: [PATCH v3] ACPI: platform-profile: Add platform
 profile support
To:     Mark Pearson <markpearson@lenovo.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
References: <markpearson@lenovo.com>
 <20201115004402.342838-1-markpearson@lenovo.com>
 <qpTm5tmuwsXyXCvmpN4vhQoKis0E5jCcILd49n6_9cqzEuN_Pd9iwMEXAFRQQmGf-rCyHe-LfhjTa15-DTTu9sFQCSQaca1KVfqYggmSGts=@protonmail.com>
 <3bdd8da6-a47a-fbc6-de0e-858f493a226e@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <db12f029-cff8-2c38-7d92-38746bde96a9@redhat.com>
Date:   Mon, 16 Nov 2020 15:33:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <3bdd8da6-a47a-fbc6-de0e-858f493a226e@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/16/20 12:04 AM, Mark Pearson wrote:

<snip>
>> I believe there's no reason to remove the comma from there, and in fact,
>> having a comma after the last entry in an array, enum, etc. seems to be
>> the preferred.
> OK.
> Have to be honest - I struggle to know when comma's are needed on the last entry and when they aren't (I've had similar corrections in other cases both ways :)). I do seem to have a knack of getting it consistently wrong....

Do the rule of thumb here is, if the last element is a terminating element,
e.g. NULL or {} or foo_number_of_foo_types in an enum foo declaration then
there should not be a comma after the last element. The reason for is is
that in case case new entries will be added one line above the last element.

If there is no terminating element (e.g. because ARRAY_SIZE is always used
on the array). Then the last element should end with a comma. The reason for
this is so that the unified diff of a patch adding a new element does not
have -++ lines, as would be necessary when the comma is missing (-+ to add
the comma, plus one more + for the new element).

I hope this helps explain.

I expect you will send out a v4 of the entire set addressing all current
remarks?

Regards,

Hans

