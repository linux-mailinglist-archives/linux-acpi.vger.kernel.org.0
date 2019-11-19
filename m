Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D13B21029B6
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 17:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfKSQsu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 11:48:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52315 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728071AbfKSQst (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Nov 2019 11:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574182128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3bp3KrK4PHmkU4mU+tFATJPu8Jpbe5Nja6U4AQyzxEs=;
        b=UnnOGNtE32nXfZEtSoxjXEg9MuYgysycUXF7Fv/Ar1/br7s0cf7G/SDUI01VHFAB5UBYUA
        uprFPQBzauqtD7+80hEVWRH3lWSoJZEeGDnclc2bUYRJR9fDdVDxlnmHLgotNmnt1wPiUS
        s5Yb4V9qx0Ye6JoU6QgG0MSB47tijOQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-g8DXSnHFND6r24tx1-4rbg-1; Tue, 19 Nov 2019 11:48:45 -0500
Received: by mail-wr1-f69.google.com with SMTP id w9so18813377wrn.9
        for <linux-acpi@vger.kernel.org>; Tue, 19 Nov 2019 08:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bQY9tLNNxnbdPwtEhggYUFtw2jJHqDVh8BuZ6Z2Kho0=;
        b=ZBLSSh6ZyGPgFQeYn7GpibbP97znNNDMTRRP4tDzUjyMu8SHjRGl4tk5snlDLb1d2C
         VNJSIyDRAne7j4PyKWhaMjK2wbLYCJ6mVpkLwjitqflAoxvlzFqMxXjbVB0XxWduiGiX
         84anRFSh2px7mGVSTZ0bP5B+mQSxWpyJZ/eJdbqmx8Mvro0pXqEpYe7EMwgWXbJDiG2i
         mFZt7uI2tGYNboD4Msgg2NS3nLzi/Z3SC0YyLenUQoZTAnO8to2VQzDIptUCJwxwmtch
         Qw1CGTLzkMxOlr6Dq3/J5JtikWaL5vkV2t3lcj1EZ/li2PeZnBXcYhCZgOODthopqcUj
         Hutw==
X-Gm-Message-State: APjAAAXoEn0cVntvZpFZOUxqo71AF6X2krqZzYYg+0WFyXpxB+6Tfweb
        6bOdtoa9cne6FuIv/j2IWY94I1bTaHcuvIJqIta/sTtdzePRH2p804PnGelUpThmQT+2Mk1aAsI
        8SrL9E27SG/E+QmdgNLcFbA==
X-Received: by 2002:adf:b686:: with SMTP id j6mr27356811wre.186.1574182124286;
        Tue, 19 Nov 2019 08:48:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqwApib8Jl+2FG1ncYwG6183TIRBPyyBXi7Zjqx2NP//yeAiiCOVAsxyxV3giwkvkDX1dBtvoA==
X-Received: by 2002:adf:b686:: with SMTP id j6mr27356787wre.186.1574182124020;
        Tue, 19 Nov 2019 08:48:44 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id d11sm27830196wrn.28.2019.11.19.08.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 08:48:43 -0800 (PST)
Subject: Re: [PATCH 3/3] drm/i915: DSI: select correct PWM controller to use
 based on the VBT
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20191119151818.67531-1-hdegoede@redhat.com>
 <20191119151818.67531-4-hdegoede@redhat.com>
 <20191119154717.GA1208@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0b71327b-4afd-1ff2-3e72-7b1b713f12b7@redhat.com>
Date:   Tue, 19 Nov 2019 17:48:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191119154717.GA1208@intel.com>
Content-Language: en-US
X-MC-Unique: g8DXSnHFND6r24tx1-4rbg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 19-11-2019 16:47, Ville Syrj=E4l=E4 wrote:
> On Tue, Nov 19, 2019 at 04:18:18PM +0100, Hans de Goede wrote:
>> At least Bay Trail (BYT) and Cherry Trail (CHT) devices can use 1 of 2
>> different PWM controllers for controlling the LCD's backlight brightness=
.
>> Either the one integrated into the PMIC or the one integrated into the
>> SoC (the 1st LPSS PWM controller).
>>
>> So far in the LPSS code on BYT we have skipped registering the LPSS PWM
>> controller "pwm_backlight" lookup entry when a Crystal Cove PMIC is
>> present, assuming that in this case the PMIC PWM controller will be used=
.
>>
>> On CHT we have been relying on only 1 of the 2 PWM controllers being
>> enabled in the DSDT at the same time; and always registered the lookup.
>>
>> So far this has been working, but the correct way to determine which PWM
>> controller needs to be used is by checking a bit in the VBT table and
>> recently I've learned about 2 different BYT devices:
>> Point of View MOBII TAB-P800W
>> Acer Switch 10 SW5-012
>>
>> Which use a Crystal Cove PMIC, yet the LCD is connected to the SoC/LPSS
>> PWM controller (and the VBT correctly indicates this), so here our old
>> heuristics fail.
>>
>> This commit fixes using the wrong PWM controller on these devices by
>> calling pwm_get() for the right PWM controller based on the
>> VBT dsi.config.pwm_blc bit.
>>
>> Note this is part of a series which contains 2 other patches which renam=
es
>> the PWM lookup for the 1st SoC/LPSS PWM from "pwm_backlight" to
>> "pwm_pmic_backlight" and the PWM lookup for the Crystal Cove PMIC PWM
>> from "pwm_backlight" to "pwm_pmic_backlight".
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/gpu/drm/i915/display/intel_panel.c | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/dr=
m/i915/display/intel_panel.c
>> index bc14e9c0285a..ddcf311d1114 100644
>> --- a/drivers/gpu/drm/i915/display/intel_panel.c
>> +++ b/drivers/gpu/drm/i915/display/intel_panel.c
>> @@ -1840,13 +1840,22 @@ static int pwm_setup_backlight(struct intel_conn=
ector *connector,
>>   =09=09=09       enum pipe pipe)
>>   {
>>   =09struct drm_device *dev =3D connector->base.dev;
>> +=09struct drm_i915_private *dev_priv =3D to_i915(dev);
>>   =09struct intel_panel *panel =3D &connector->panel;
>> +=09const char *desc;
>>   =09int retval;
>>  =20
>> -=09/* Get the PWM chip for backlight control */
>> -=09panel->backlight.pwm =3D pwm_get(dev->dev, "pwm_backlight");
>> +=09/* Get the right PWM chip for DSI backlight according to VBT */
>> +=09if (dev_priv->vbt.dsi.config->pwm_blc =3D=3D PPS_BLC_PMIC) {
>> +=09=09panel->backlight.pwm =3D pwm_get(dev->dev, "pwm_pmic_backlight");
>> +=09=09desc =3D "PMIC";
>> +=09} else {
>> +=09=09panel->backlight.pwm =3D pwm_get(dev->dev, "pwm_soc_backlight");
>> +=09=09desc =3D "SoC";
>> +=09}
>=20
> Might we want the same thing for the panel enable gpio?


TL;DR: yes but that is for a separate series, which currently only exists i=
n my head.

Longer story:

It looks like on BYT we need to control both VLV_GPIO_NC_10_PANEL1_BKLTEN a=
nd
VLV_GPIO_NC_11_PANEL1_BKLTCTL from vlv_dsi.c when the LPSS is used for PWM.
With BKLTCTL working as a panel_enable (needs to be driven high early on
when initializing the panel) and BKLTEN is just a backlight enable/disable
GPIO.

Without this DSI panels will not light-up on BYT when a HDMI monitor is
connected and the GOP chooses to initialize the HDMI rather then the panel,
since then these 2 pins stay low.

On CHT the MIPI power on/off sequences seem to take care of this themselves=
.

I still want to run some more tests. Currently if I export the 2 gpios in
question in sysfs (since their not claimed yet) and read them they always
read 0. I have the feeling this is caused by the input-buffer not being
enabled on these GPIOs, and that they really are high. So I want to do
a little hack to enable the input buffer and then see if indeed they
are high when the GOP has initialized the panel.

Testing has already shown that driving them high manualy before loading
i915 when the GOP did not init the panel fixes the panel not lighting up.
So I'm pretty sure that this is the case, but I want to verify this before
writing a series for that.

Regards,

Hans



>=20
>> +
>>   =09if (IS_ERR(panel->backlight.pwm)) {
>> -=09=09DRM_ERROR("Failed to own the pwm chip\n");
>> +=09=09DRM_ERROR("Failed to get the %s PWM chip\n", desc);
>>   =09=09panel->backlight.pwm =3D NULL;
>>   =09=09return -ENODEV;
>>   =09}
>> @@ -1873,6 +1882,7 @@ static int pwm_setup_backlight(struct intel_connec=
tor *connector,
>>   =09=09=09=09 CRC_PMIC_PWM_PERIOD_NS);
>>   =09panel->backlight.enabled =3D panel->backlight.level !=3D 0;
>>  =20
>> +=09DRM_INFO("Using %s PWM for LCD backlight control\n", desc);
>>   =09return 0;
>>   }
>>  =20
>> --=20
>> 2.23.0
>=20

