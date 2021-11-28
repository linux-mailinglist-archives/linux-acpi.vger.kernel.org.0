Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967104606CB
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Nov 2021 15:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357853AbhK1OXA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 28 Nov 2021 09:23:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357802AbhK1OU7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 28 Nov 2021 09:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638109063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7NI4MkDEWM3XqTzozXI1OSNoKuY6xpHZvoJhaI+u0xk=;
        b=XxI/yD8wSl5T6bZ4kJHshLQaSFl8Nv5saeCP9ftMx2j521upPUXht64wDjSRngBhpKbpvm
        q/DgCP8Jh6nf1Ci3Z5jvIrH6k1KEn6QptkAgWX10tSiPDgkSLEbKkxioTcHl3oiOuvaooF
        KjkSZzTa8nJ7ZLxJTDAZ18etJFQqDrg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-pPOf18Q1MwqU5_N2NNT53w-1; Sun, 28 Nov 2021 09:17:42 -0500
X-MC-Unique: pPOf18Q1MwqU5_N2NNT53w-1
Received: by mail-ed1-f70.google.com with SMTP id s12-20020a50ab0c000000b003efdf5a226fso5361889edc.10
        for <linux-acpi@vger.kernel.org>; Sun, 28 Nov 2021 06:17:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7NI4MkDEWM3XqTzozXI1OSNoKuY6xpHZvoJhaI+u0xk=;
        b=Cloanqb00t6buGHy2ETdtajWkcawQs54PXNyRu9HSTvUAYbjg2gqW28MuONNdjxmDj
         91DzT36OOivw3kK/bzjpQArrICALpPedhG2DPsBsQBp2p4Ef2XA6x0IiggsmJf2Jxuqt
         1IyHY+f8QLFayeTt8Ceawq7V647GE8NFxiZ+KxUCRuRAPX9OKxbtP+mNiqchd4auEaOv
         uWycf1nI7be97YkbxhTbEfE8YHkjHFtrA2XDGL+fYX4w8LIp7sZK/aI7jEImKRr3Ja41
         enWhdmnl8QYTBqj0J8hsSWRRbBNmkqMsh5mkavuHhyoBHAjWUvnpmqaKYpEtO64ZGlcE
         0ZgA==
X-Gm-Message-State: AOAM530tbQjJbwppaVhPbm29P2fkEOiEspwiIQ5wxK9pOZYPsHAl3PDn
        eb0IEaTb8PSzT5Kv3WU+p9rMKl/vgn5c/dSq1XBKSZfKIQDqWciAQK4kaLJF04AqYeznjgYmMfM
        GmJN9pRSCrrQCCPHhCxEkVQ==
X-Received: by 2002:a17:906:4703:: with SMTP id y3mr6338988ejq.346.1638109060316;
        Sun, 28 Nov 2021 06:17:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwL7H8xZgeMFEQLMS3aaxDrhrYAGmFJtS/tDttsHLDh8cYMmjMLXiijqcSlwL7R0edEzAz6yA==
X-Received: by 2002:a17:906:4703:: with SMTP id y3mr6338967ejq.346.1638109060109;
        Sun, 28 Nov 2021 06:17:40 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h10sm7453858edj.1.2021.11.28.06.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 06:17:39 -0800 (PST)
Message-ID: <f02aa588-8e6b-64dc-6f98-ef1c6edc7941@redhat.com>
Date:   Sun, 28 Nov 2021 15:17:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 18/20] extcon: intel-cht-wc: Refactor
 cht_wc_extcon_get_charger()
Content-Language: en-US
To:     cwchoi00@gmail.com
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org
References: <20211114170335.66994-1-hdegoede@redhat.com>
 <20211114170335.66994-19-hdegoede@redhat.com>
 <f84e2060-f6b7-64f9-78cd-e8ad8776ab2d@gmail.com>
 <662623cd-c70b-63e6-499e-7c24b5d3e342@redhat.com>
 <CAGTfZH1ndMc902R+wJXM+q+4fSJQD+RZVxaWcMvut4+9oSzqnw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAGTfZH1ndMc902R+wJXM+q+4fSJQD+RZVxaWcMvut4+9oSzqnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/19/21 16:44, Chanwoo Choi wrote:
> Hi,
> 
> On Thu, Nov 18, 2021 at 7:31 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 11/17/21 08:15, Chanwoo Choi wrote:
>>> Hello,
>>>
>>> I think that you need to squash it with patch21
>>> I'm not sure that this patch is either atomic or not because
>>> you remove the 'return EXTCON_CHG_USB_SDP/EXTCON_CHG_USB_SDP'
>>> without explaining why it is no problem. Just mention that
>>> pass the role to next 'switch' cases. But, before this change,
>>> there were any reason to return the type of charger cable
>>> before switch statement.
>>
>> The setting of usbsrc to "CHT_WC_USBSRC_TYPE_SDP << CHT_WC_USBSRC_TYPE_SHIFT"
>> will make the following switch-case return EXTCON_CHG_USB_SDP
>> just as before, so there is no functional change.
>>
>>> According to your patch description, you don't need
>>> to make the separate patch of it. Please squash it with patch21.
>>
>> Having this refactoring in a separate patch makes it easier
>> to see what is going on in patch 21. So I'm going to keep this
>> as a separate patch for v3 of this series.
> 
> If you want to keep this  patch, please remove the following description.
> Instead, just mention to focus on refactor it without behavior changes.
> 
> 'This is a preparation patch for adding support for registering
> a power_supply class device.'

Ok, done for v3 of the patch-series.

Regards,

Hans



>>> On 21. 11. 15. 오전 2:03, Hans de Goede wrote:
>>>> Refactor cht_wc_extcon_get_charger() to have all the returns are in
>>>> the "switch (usbsrc)" cases.
>>>>
>>>> This is a preparation patch for adding support for registering
>>>> a power_supply class device.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>   drivers/extcon/extcon-intel-cht-wc.c | 15 ++++++++-------
>>>>   1 file changed, 8 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
>>>> index 119b83793123..f2b93a99a625 100644
>>>> --- a/drivers/extcon/extcon-intel-cht-wc.c
>>>> +++ b/drivers/extcon/extcon-intel-cht-wc.c
>>>> @@ -153,14 +153,15 @@ static int cht_wc_extcon_get_charger(struct cht_wc_extcon_data *ext,
>>>>       } while (time_before(jiffies, timeout));
>>>>         if (status != CHT_WC_USBSRC_STS_SUCCESS) {
>>>> -        if (ignore_errors)
>>>> -            return EXTCON_CHG_USB_SDP; /* Save fallback */
>>>> +        if (!ignore_errors) {
>>>> +            if (status == CHT_WC_USBSRC_STS_FAIL)
>>>> +                dev_warn(ext->dev, "Could not detect charger type\n");
>>>> +            else
>>>> +                dev_warn(ext->dev, "Timeout detecting charger type\n");
>>>> +        }
>>>>   -        if (status == CHT_WC_USBSRC_STS_FAIL)
>>>> -            dev_warn(ext->dev, "Could not detect charger type\n");
>>>> -        else
>>>> -            dev_warn(ext->dev, "Timeout detecting charger type\n");
>>>> -        return EXTCON_CHG_USB_SDP; /* Save fallback */
>>>> +        /* Save fallback */
>>>> +        usbsrc = CHT_WC_USBSRC_TYPE_SDP << CHT_WC_USBSRC_TYPE_SHIFT;
>>>>       }
>>>>         usbsrc = (usbsrc & CHT_WC_USBSRC_TYPE_MASK) >> CHT_WC_USBSRC_TYPE_SHIFT;
>>>>
>>>
>>>
>>
> 
> 

