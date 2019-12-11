Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C69D511BA5B
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2019 18:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfLKRcl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Dec 2019 12:32:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33028 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730010AbfLKRcl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 11 Dec 2019 12:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576085560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y12wlbSvkuEx6hrDq4ife4K7ITZLnh8SGNBP1jLgnxg=;
        b=imPvHEEkbA9jPkPnT/Hk3dDk494brYNKFWr+REXeuEA/bkJDobyKPrajgXLTDbtG6FUV6b
        0YBo/SCWH+Ldb2UDHFjUXNHnM+kcavgcrQ/ZQFpSKwIEA9199itAbbir3miOuu8DiJMs8v
        6VlBdrvgC2t0j4Eiuy5Z63jj9syEk0U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-Qznd049APiKk15oUswiRBw-1; Wed, 11 Dec 2019 12:32:39 -0500
X-MC-Unique: Qznd049APiKk15oUswiRBw-1
Received: by mail-wr1-f70.google.com with SMTP id c17so10623057wrp.10
        for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2019 09:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y12wlbSvkuEx6hrDq4ife4K7ITZLnh8SGNBP1jLgnxg=;
        b=mHJ8Yv8HgC3X72dg4F1q0VY4OLUfwK3rmLQuIgGigTEgqKLfjYXbmYBoDwkNtEEG3H
         R/DGHTt5utJM/9dBhESd1ryUZ71jNykgD4F5wBDELx8cAYBzfryM64XI18QDzyQzngBD
         wk3i//uZdn8dhzlqvdb4WBouOu3i9Vl2a2/NLVj+181bFPM+74Lqt/1OxyWOD6u1ukDU
         7esOKB9fUxHyjLRruL5MOU86BRvs0arFvPMYlp/wC5yfvBAyGgkAhiptXrr2ILt5Gk3j
         p/0I25xwY1X1nN2l3vxKKzBowVoU718sKZv/1XuaFpUiceohMo6JOHHHjOUruDFNxYt1
         uNng==
X-Gm-Message-State: APjAAAWT1fpnW/ajBZRu9ZGpUfOTrbhOeYit2eU25mZyk5njn7NtRmXL
        AGW3vSq2uXbwFr+oGhfc7afOnBE+GVdFDRc9+h3ircqTRV1y0/cVxjsARox7i0aow+FFIsCmpRh
        oYNzCUjX9MtIYbhPbB0TJDA==
X-Received: by 2002:adf:df90:: with SMTP id z16mr1036614wrl.273.1576085558007;
        Wed, 11 Dec 2019 09:32:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqyJNDISSzLaekbps4PPe/Y5SFMhSF7OjIT8TamyAaUOOzgveUOLSuGFFwaNrhfYHhJrY6DB/A==
X-Received: by 2002:adf:df90:: with SMTP id z16mr1036575wrl.273.1576085557720;
        Wed, 11 Dec 2019 09:32:37 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id o185sm2736280wmb.40.2019.12.11.09.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 09:32:37 -0800 (PST)
Subject: Re: [PATCH 2/2] drm/i915/vlv_dsi: Control panel and backlight enable
 GPIOs on BYT
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20191129185836.2789-1-hdegoede@redhat.com>
 <20191129185836.2789-3-hdegoede@redhat.com>
 <CACRpkdbRb-LF2tNN-ueo=tKuJc+u4B7Y20+BCyqnN7wYbm8y7Q@mail.gmail.com>
 <87wobfj65b.fsf@intel.com> <47c36b75-bc30-502b-7f8d-035cf2348fc4@redhat.com>
 <CACRpkdaJGZsJpYu3cgQCeWuJD1y9CQyzuk_VYfGfAT8WC=_1VA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4bc1d1ac-b3c7-4ea5-9150-bc1b9cffb963@redhat.com>
Date:   Wed, 11 Dec 2019 18:32:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CACRpkdaJGZsJpYu3cgQCeWuJD1y9CQyzuk_VYfGfAT8WC=_1VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11-12-2019 01:24, Linus Walleij wrote:
> On Mon, Dec 2, 2019 at 4:49 PM Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> There is only one problem, currently is is not possible to
>> unregister a mapping added with pinctrl_register_mappings
>> and the i915 driver is typically a module which can be unloaded
>> and I believe actually is unloaded as part of the i915 CI.
>>
>> pinctrl_register_mappings copies the passed in mapping, but
>> it is a shallow copy, so it contains pointers to the modules
>> const segment and we do not want to re-add another copy of
>> the mapping when the module loads a second time.
>>
>> Fixing this is easy though, there already is a pinctrl_unregister_map()
>> function, we just need to export it so that the i915 driver can
>> remove the mapping when it is unbound.
>>
>> Linus would exporting this function be ok with you?
> 
> Yep!
> 
>> Linus, question what is the purpose of the "dupping" / shallow
>> copying of the argument passed to pinctrl_register_map ?
> 
> The initial commit contained this comment later removed:
> 
> +       /*
> +        * Make a copy of the map array - string pointers will end up in the
> +        * kernel const section anyway so these do not need to be deep copied.
> +        */
> 
> The use was to free up memory for platforms using boardfiles
> with a gazillion variants and huge pin control tables, so these
> could be marked  __initdata and discarded after boot.
> As the strings would anyway stay around we didn't need to
> deep copy.
> 
> See for example in arch/arm/mach-u300/core.c
> static struct pinctrl_map __initdata u300_pinmux_map[]
> 
>> Since
>> it is shallow the mem for any pointers contained within there need
>> to be kept around by the caller, so why not let the caller keep
>> the pinctrl_map struct itself around too?
> 
> So the strings will be kept around because the kernel can't get
> rid of strings. (Yeah it is silly, should haven been fixed ages
> ago, but not by me, haha :)
> 
>> If we are going to export pinctrl_unregister_map() we need to make it
>> do the right thing for dupped maps too, we can just store the dup flag
>> in struct pinctrl_maps. So this is easy, but I wonder if we cannot
>> get rid of the dupping all together ?
> 
> Maybe ... I don't know. What do you think? I suppose you could
> make u300 crash if you do that.

I've prepared a patch which makes pinctrl_register_mappings remember
if the mapping is dupped or not (store the dup value in struct pinctrl_maps);
and which modifies pinctrl_unregister_map() to do the right thing
depending on the stored dup value.

I still need to test the new series and then I will post it.

Regards,

Hans

