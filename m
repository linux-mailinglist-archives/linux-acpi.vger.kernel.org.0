Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711C63FFD5F
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Sep 2021 11:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348919AbhICJm3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Sep 2021 05:42:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54286 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348898AbhICJm2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Sep 2021 05:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630662088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7hLvnClLlStMjpZTeAIE1ZO2uEqHpHnrGDZJuuDhu0o=;
        b=FbLPTaFyOMbjWxRnmhSITbG/p/NYlY0RcKky2q7BGN9mJDhwEISy9P1hBIjNppR77JAPHb
        Xf5QraX1gh0f4GLXw2sFrvn6ZD1dPkFs4zllOkPnKZzMIVwsUjOn6nI++l+2yg+r+zZQfD
        D4KpEPPsbUCfui06PLzx1J5T1GWanbc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-Y4KXfwVlMweVr3pxSOthsw-1; Fri, 03 Sep 2021 05:41:27 -0400
X-MC-Unique: Y4KXfwVlMweVr3pxSOthsw-1
Received: by mail-ed1-f72.google.com with SMTP id y21-20020a056402359500b003cd0257fc7fso2471444edc.10
        for <linux-acpi@vger.kernel.org>; Fri, 03 Sep 2021 02:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7hLvnClLlStMjpZTeAIE1ZO2uEqHpHnrGDZJuuDhu0o=;
        b=SA0/0Dr2m4Wh5HtcoeDP3OFMlsEzc7uUDiOJdvS818p2bFVFj/kiUBE7pim5h6jQ1f
         3hdZTzWuDSBhDfMGR10ioGxnq2KY85IljUiYyPXcPtDNM4WJyAXWqXXvlBAoGTjkN7nz
         52QllZIUheCWMO8typB5CbRZpMHnuIPHnRSP7k1VQGpLRmiG7hCfR0UYqkBv4ajX2BIw
         92EGIAm6vZVCgcuERndqv2I/jMzLiu7KmRiP6vOk5gJo9PL8NISu29XIjXhThwx6Duv7
         FE0pfmQvEr0UN7O292Vu/brzUvcoy6KQoyIl3Ub4a0/NAjLG60jlrIQGh+JrQLWyXgU/
         b6mg==
X-Gm-Message-State: AOAM532BTHNOruE1Pf6R2CHzUCFyIF/ojJaTU8o7G2ytoHGje+8yACiz
        PwuOuBP4sNhl/MZ4PqtVpX08klyvjTEStYn2utFjHduUIHMRANjWi0hPrmfXdrOpfJdzs9TtIZx
        KYP+wpQDBcGqkglSlzO+TBA==
X-Received: by 2002:a05:6402:40cf:: with SMTP id z15mr3046717edb.70.1630662086336;
        Fri, 03 Sep 2021 02:41:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVvlOVa5vCaE3fjEj7lwXGvcGylc0wmdHCUhNkWuvv0hbdypQkOAqNQUnJ86GotOebRMkSzg==
X-Received: by 2002:a05:6402:40cf:: with SMTP id z15mr3046707edb.70.1630662086155;
        Fri, 03 Sep 2021 02:41:26 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id qt23sm2371698ejb.26.2021.09.03.02.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 02:41:25 -0700 (PDT)
Subject: Re: TPS68470 PMIC config option
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <20210901160234.0e3e24b2@endymion>
 <YS+6xzk9yc8uPetU@smile.fi.intel.com>
 <20210901193251.GZ3@paasikivi.fi.intel.com>
 <20210902115731.2fd22c80@endymion>
 <20210902121529.GC3@paasikivi.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b1fb59bb-aec4-660d-4291-f74f26f5b67b@redhat.com>
Date:   Fri, 3 Sep 2021 11:41:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210902121529.GC3@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/2/21 2:15 PM, Sakari Ailus wrote:
> Hi Jean,
> 
> On Thu, Sep 02, 2021 at 11:57:31AM +0200, Jean Delvare wrote:
>> Hi Sakari,
>>
>> On Wed, 1 Sep 2021 22:32:51 +0300, Sakari Ailus wrote:
>>> On Wed, Sep 01, 2021 at 08:39:19PM +0300, Andy Shevchenko wrote:
>>>> On Wed, Sep 01, 2021 at 04:02:34PM +0200, Jean Delvare wrote:  
>>>>> Is there a reason why config TPS68470_PMIC_OPREGION is not under "if
>>>>> PMIC_OPREGION" where all other *_PMIC_OPREGION driver options are?  
>>>>
>>>> It was originally like that.
>>>>
>>>> Sakari, do you know?  
>>>
>>> The answer can be found in Makefile:
>>>
>>> obj-$(CONFIG_PMIC_OPREGION)             += intel_pmic.o
>>>
>>> intel_pmic.c seems to contain common functionality for PMICs in Intel SoCs

That is not correct, it implements an ACPI opregion handler where the
"API" is defined by Intel, but these are external PMICs which are made
by Intel, TI and X-Powers.

Note these are only used on hardware with Intel Bay Trail and Cherry Trail
SoCs (which are more or less Atom series SoCs).

>>> whereas the TPS68470 is an external chip. The two codebases are distinct.

The others are external chips too, where the TPS68470 is different is
that the ACPI OpRegion interface "API" is a different one (defined by Google
AFAIK) and is only used on ChromeBook devices, in combination with
various *other* Intel SoCs, mostly standard (Y-series) Core models,
but possibly also Apollo Lake / Gemini Lake (Atom like) SoCs.

>>>
>>> Perhaps it could make sense to either rename this as
>>> CONFIG_PMIC_INTEL_OPREGION, or move the TPS68470 driver in and change the
>>> Kconfig+Makefile to have the common code compiled if at least one of the
>>> drivers is enabled.
>>
>> OK, thanks for the explanation I get it now. Yes, the fact that the
>> menu looks vendor-neutral while it is about Intel drivers only is
>> confusing. Renaming it would help. I'm not sure about your alternative
>> proposal as I can't actually see any common code or dependency between
>> intel_pmic and tps68470_pmic.
> 
> There isn't. I was thinking whether all PMIC opregion drivers would be
> behind a menu entry. If you have any sort of a generic kernel then you'd
> probably want all of these in anyway. I don't really have an opinion
> at this point though.

See above, note with the caveats from above noted I'm fine with the
rename. OTOH I'm fine with keeping things as is too.

A better name might by PMIC_BYT_CHT_OPREGION or PMIC_INTEL_BYT_CHT_OPREGION
though, since the TPS68470 OpRegion is also found only on devices where
the main SoC is from Intel.

>> What about the following?
>>
>> From: Jean Delvare <jdelvare@suse.de>
>> Subject: ACPI / PMIC: Rename CONFIG_PMIC_OPREGION
>>
>> Rename the intel_pmic driver's Kconfig option to make it clear it's
>> about the Intel chipset family.
>>
>> Signed-off-by: Jean Delvare <jdelvare@suse.de>
>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: Andy Shevchenko <andy@kernel.org>
>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>> ---
>>  drivers/acpi/pmic/Kconfig                    |   10 +++++-----
>>  drivers/acpi/pmic/Makefile                   |    2 +-
>>  drivers/gpu/drm/i915/display/intel_dsi_vbt.c |    4 ++--
>>  drivers/staging/media/atomisp/Kconfig        |    2 +-
>>  4 files changed, 9 insertions(+), 9 deletions(-)
>>
>> --- linux-5.14.orig/drivers/acpi/pmic/Kconfig	2021-08-30 00:04:50.000000000 +0200
>> +++ linux-5.14/drivers/acpi/pmic/Kconfig	2021-09-02 11:51:14.146662112 +0200
>> @@ -1,14 +1,14 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>> -menuconfig PMIC_OPREGION
>> -	bool "PMIC (Power Management Integrated Circuit) operation region support"
>> +menuconfig INTEL_PMIC_OPREGION
>> +	bool "Intel PMIC (Power Management Integrated Circuit) operation region support"
>>  	help
>>  	  Select this option to enable support for ACPI operation
>> -	  region of the PMIC chip. The operation region can be used
>> +	  region of the Intel PMIC chip. The operation region can be used
>>  	  to control power rails and sensor reading/writing on the
>>  	  PMIC chip.
>>  
>> -if PMIC_OPREGION
>> +if INTEL_PMIC_OPREGION
>>  
>>  config BYTCRC_PMIC_OPREGION
>>  	bool "ACPI operation region support for Bay Trail Crystal Cove PMIC"
>> @@ -48,7 +48,7 @@ config CHT_DC_TI_PMIC_OPREGION
>>  	help
>>  	  This config adds ACPI operation region support for Dollar Cove TI PMIC.
>>  
>> -endif	# PMIC_OPREGION
>> +endif	# INTEL_PMIC_OPREGION
>>  
>>  config TPS68470_PMIC_OPREGION
>>  	bool "ACPI operation region support for TPS68470 PMIC"
>> --- linux-5.14.orig/drivers/acpi/pmic/Makefile	2021-08-30 00:04:50.000000000 +0200
>> +++ linux-5.14/drivers/acpi/pmic/Makefile	2021-09-02 11:21:34.527694178 +0200
>> @@ -1,6 +1,6 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>> -obj-$(CONFIG_PMIC_OPREGION)		+= intel_pmic.o
>> +obj-$(CONFIG_INTEL_PMIC_OPREGION)	+= intel_pmic.o
>>  obj-$(CONFIG_BYTCRC_PMIC_OPREGION)	+= intel_pmic_bytcrc.o
>>  obj-$(CONFIG_CHTCRC_PMIC_OPREGION)	+= intel_pmic_chtcrc.o
>>  obj-$(CONFIG_XPOWER_PMIC_OPREGION)	+= intel_pmic_xpower.o
>> --- linux-5.14.orig/drivers/staging/media/atomisp/Kconfig	2021-08-30 00:04:50.000000000 +0200
>> +++ linux-5.14/drivers/staging/media/atomisp/Kconfig	2021-09-02 11:51:39.792007892 +0200
>> @@ -12,7 +12,7 @@ menuconfig INTEL_ATOMISP
>>  config VIDEO_ATOMISP
>>  	tristate "Intel Atom Image Signal Processor Driver"
>>  	depends on VIDEO_V4L2 && INTEL_ATOMISP
>> -	depends on PMIC_OPREGION
>> +	depends on INTEL_PMIC_OPREGION
>>  	select IOSF_MBI
>>  	select VIDEOBUF_VMALLOC
>>  	select VIDEO_V4L2_SUBDEV_API
>> --- linux-5.14.orig/drivers/gpu/drm/i915/display/intel_dsi_vbt.c	2021-08-30 00:04:50.000000000 +0200
>> +++ linux-5.14/drivers/gpu/drm/i915/display/intel_dsi_vbt.c	2021-09-02 11:52:38.230795493 +0200
>> @@ -511,7 +511,7 @@ static const u8 *mipi_exec_spi(struct in
>>  static const u8 *mipi_exec_pmic(struct intel_dsi *intel_dsi, const u8 *data)
>>  {
>>  	struct drm_i915_private *i915 = to_i915(intel_dsi->base.base.dev);
>> -#ifdef CONFIG_PMIC_OPREGION
>> +#ifdef CONFIG_INTEL_PMIC_OPREGION
>>  	u32 value, mask, reg_address;
>>  	u16 i2c_address;
>>  	int ret;
>> @@ -529,7 +529,7 @@ static const u8 *mipi_exec_pmic(struct i
>>  		drm_err(&i915->drm, "%s failed, error: %d\n", __func__, ret);
>>  #else
>>  	drm_err(&i915->drm,
>> -		"Your hardware requires CONFIG_PMIC_OPREGION and it is not set\n");
>> +		"Your hardware requires CONFIG_INTEL_PMIC_OPREGION and it is not set\n");
> 
> I wonder if this is just an Intel PMIC or whether it could be any PMIC.

This is used on devices which use the PMICs which use the ACPI OpRegion
handler defined in the shared intel_pmic.c code, so changing the check
as part of renaming the Kconfig option is fine.

I hope this helps clarify things a bit, if not feel free to ask questions.

Regards,

Hans

