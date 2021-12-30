Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94973481F35
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Dec 2021 19:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbhL3Sbm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Dec 2021 13:31:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241705AbhL3Sbk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Dec 2021 13:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640889100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K8Yh71yQj/rlCeet/ch59p/SlKhDeTS1cwWU/SHwgM8=;
        b=SRzfDJ0Ko+9POu8Ktrnz3sp9M2LCNDTXUmTZ1Ea6Zr5m0Au5ZJkS9g5GyX+cHgAUghFXoo
        CD4UkUHjQCR+QwHMBQuxD37koIAQePduKi2KJvgH29AKvZHynzZYaRAOVvBXyNezCwL6Hz
        v00nicC24l26HF7YvlIM8z/O5RrcifE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-Ts5s3MM0Nim_19dsAxEgBg-1; Thu, 30 Dec 2021 13:31:38 -0500
X-MC-Unique: Ts5s3MM0Nim_19dsAxEgBg-1
Received: by mail-ed1-f71.google.com with SMTP id z10-20020a05640235ca00b003f8efab3342so10503715edc.2
        for <linux-acpi@vger.kernel.org>; Thu, 30 Dec 2021 10:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K8Yh71yQj/rlCeet/ch59p/SlKhDeTS1cwWU/SHwgM8=;
        b=7TmuD0WFZLccRLAeBLM8I07wxwgVJYfBpxO4YJDx+C0jskbqgVWMU4qRJJ9X/5LI6w
         YkROOwIet+Tr0+shs5L3h6nh+8o5jL6m8rzvqc7U1msnQiHIPrA+3dXa0fCbDu5FVq3U
         8Zhfvy0lI5ViKYFiNXL2R0h5k85DAERfDWjGtAzQp+r3YQKoxV+bJYp0gF0gQQtli1rD
         juBFrptau1395aUa8TcLaBGEXpqbafrAO4Clta2HviI8xk3glmdNjWadP5LSn4aldUbW
         ZM0Yj4uPQDDZTOA5ve9KjRsDe9z6ovJ623HGW6vQCNdPUqqhbkVgllShezaud51RsfVQ
         S5Og==
X-Gm-Message-State: AOAM531Zr+wRfiep098a0AnTVzDZALeByJ0zZab6kWD0VvOPOQZce0Ez
        3SKDcqxSFxYUut4WOVFh2MX2nAkSHsiocOEnOBu+Xe9u1uaCau/tofcoFAhfSAbS3bQdj2nuYis
        msdcDMWTgPTg5ojuCTENDOw==
X-Received: by 2002:a17:907:728a:: with SMTP id dt10mr25855271ejc.160.1640889097807;
        Thu, 30 Dec 2021 10:31:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFafWulmtFpt6yeA64rh12a20RXIhENEMnG56xff8H78U98MjjCl0EiY6fPKWAOIEpYtx3nQ==
X-Received: by 2002:a17:907:728a:: with SMTP id dt10mr25855261ejc.160.1640889097681;
        Thu, 30 Dec 2021 10:31:37 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id b1sm7460567ejb.51.2021.12.30.10.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 10:31:37 -0800 (PST)
Message-ID: <974029e7-011e-3c49-ee32-d4a9191b0c8d@redhat.com>
Date:   Thu, 30 Dec 2021 19:31:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 1/3] ACPI / x86: Add
 acpi_quirk_skip_[i2c_client|serdev]_enumeration() helpers
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-serial@vger.kernel.org
References: <20211230141722.512395-1-hdegoede@redhat.com>
 <20211230141722.512395-2-hdegoede@redhat.com>
 <CAJZ5v0jw7jNq8FgMFcF9p=YYiuYj=RuV2MTPqGu62QoaG_O1MQ@mail.gmail.com>
 <Yc3ytI/NxnGT0aVf@kunai>
 <CAJZ5v0jyHamePb+J-5JGFPOErzV0Vq1TCD=Yq83hC6eSccCFOg@mail.gmail.com>
 <8043413d-c61a-458b-c81f-dd6e98c05b48@redhat.com>
 <CAJZ5v0ijK17Mff1GLP+QtFN6hJ_E4bFXVr=A2Z0WSHJMvGZnww@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0ijK17Mff1GLP+QtFN6hJ_E4bFXVr=A2Z0WSHJMvGZnww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/30/21 19:19, Rafael J. Wysocki wrote:
> On Thu, Dec 30, 2021 at 7:18 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 12/30/21 19:00, Rafael J. Wysocki wrote:
>>> On Thu, Dec 30, 2021 at 6:56 PM Wolfram Sang <wsa@kernel.org> wrote:
>>>>
>>>> Hi Rafael,
>>>>
>>>>> or please let me know if you want me to take this series.
>>>>
>>>> Yes, see cover-letter :)
>>>
>>> Oh well.
>>>
>>> I'll take it now, thanks!
>>
>> Thank you.
>>
>> I see this in your bleeding-edge branch now. I was wondering what this
>> means wrt this making it into 5.17, or if you consider this 5.18
>> material?
> 
> 5.17

Nice, then it probably is best to also get the matching x86-android-tablets
changes merged for 5.17. I'll give it a couple of days for people to review
those and then merge those into pdx86/for-next.

Regards,

Hans

