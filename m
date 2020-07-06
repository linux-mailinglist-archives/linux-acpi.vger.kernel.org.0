Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D5F2160C0
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jul 2020 23:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgGFVDv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Jul 2020 17:03:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49910 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725860AbgGFVDv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Jul 2020 17:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594069429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTzxL0nmmerH9+ZRGzb1Zo8OQvzYnjQNO+ZtTHpjgQg=;
        b=akudK9zXPo25bDSrsYVYjJdv7PNOxovMg0k3qPnKXK5s0LU1xa1nKSV7yGyGYTmGrlGPuR
        1CC/POU/lcyx2Z9yPmD21zgbqu28NAjQRe4FMzf/MsZj9H4Bf1vrugNQ+gqt86xMVtpCed
        RV/r5i9ziop+02nDICbW/xtwLTcx6Yk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-dUEZSPOSO0i-AgQB3HQvXA-1; Mon, 06 Jul 2020 17:03:47 -0400
X-MC-Unique: dUEZSPOSO0i-AgQB3HQvXA-1
Received: by mail-ed1-f72.google.com with SMTP id y7so6800414edp.8
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2020 14:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BTzxL0nmmerH9+ZRGzb1Zo8OQvzYnjQNO+ZtTHpjgQg=;
        b=UKqc7KlMANFE2Oy2A3xrkAMms8V+3EbtwtpXvPs9pcvjw1u0kvVl2Al0EEoURmlYuv
         vbZGzTHpFeW3L5WPNCi18Take1WPhkzJziHZSA7Ff/Y27pV04JtqnPS7kNZ9+sU9vdP4
         VDz/UqV0EObyvmJw3qHg6OLzPUaoFMRsmasoS+bMdqHg+iT6T//NbksAqPWBoMaRMVAw
         /h/8V1CGcx7kf9qKFPPS5O2EnGelnthK6f/lMQwt8mvG4TwmYBCVDPMJXZE/wtDlYZKN
         Gl2MGPat9H5Wm2WMDg1/5ZrZMCd9jNtNv+MWT6jIrGxjqfYiNUVk/uWqnSoiRNGsFq6u
         +d9g==
X-Gm-Message-State: AOAM532HdY0/A8/kzIO8UgOW1sth7NLup/SP6cc81PPm6I01nX5y7R9W
        BGdIkZdB8wUdGVEUGFLz9AVpO7uhnKlWZzlcNmfNIbTKU3jOvJhQQTHmmME32W3U1LebO/xvymM
        cEQiK/9/wiF7bxdjObb/3uw==
X-Received: by 2002:a17:906:f101:: with SMTP id gv1mr39884587ejb.327.1594069426605;
        Mon, 06 Jul 2020 14:03:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjA0LYkm1LHaUC+ExTwhMlXLbDOBs9EYsgOgpkInQkLnvDLvDn7e4k+oEWoeQSDcDXZetHkQ==
X-Received: by 2002:a17:906:f101:: with SMTP id gv1mr39884570ejb.327.1594069426394;
        Mon, 06 Jul 2020 14:03:46 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id a8sm16961111ejp.51.2020.07.06.14.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 14:03:45 -0700 (PDT)
Subject: Re: [PATCH v3 09/15] pwm: crc: Enable/disable PWM output on
 enable/disable
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, Shobhit Kumar <shobhit.kumar@intel.com>
References: <20200620121758.14836-1-hdegoede@redhat.com>
 <20200620121758.14836-10-hdegoede@redhat.com>
 <20200622075509.v4jlvqeyjip6wr6c@taurus.defre.kleine-koenig.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f1fb632d-3578-7dee-889f-71ee6787c637@redhat.com>
Date:   Mon, 6 Jul 2020 23:03:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622075509.v4jlvqeyjip6wr6c@taurus.defre.kleine-koenig.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/22/20 9:55 AM, Uwe Kleine-König wrote:
> Hello,
> 
> [adding Shobhit Kumar <shobhit.kumar@intel.com> to Cc who is the author
> of this driver according to the comment on the top of the driver]
> 
> On Sat, Jun 20, 2020 at 02:17:52PM +0200, Hans de Goede wrote:
>> The pwm-crc code is using 2 different enable bits:
>> 1. bit 7 of the PWM0_CLK_DIV (PWM_OUTPUT_ENABLE)
>> 2. bit 0 of the BACKLIGHT_EN register
>>
>> So far we've kept the PWM_OUTPUT_ENABLE bit set when disabling the PWM,
>> this commit makes crc_pwm_disable() clear it on disable and makes
>> crc_pwm_enable() set it again on re-enable.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v3:
>> - Remove paragraph about tri-stating the output from the commit message,
>>    we don't have a datasheet so this was just an unfounded guess
> 
> I have the impression you spend quite some time with this driver trying
> to understand it.

Yes, my initial plan for this patch series was to just convert this driver
to atomic PWM, but it turned out to need a bit of TLC first.

> What I still think is a bit unfortunate is that there
> is quite some guesswork involved.

Actually for 99% of the changes I'm pretty sure they are correct.

This patch is the 1% where I'm not sure, and in this case I'm playing
it safe by keeping the code as is.

As the commit message tries to explain I strongly suspect that
bit 0 of the BACKLIGHT_EN register really drives a separate GPIO
pin on the PMIC which is earmarked as backlight-enable pin (many LCD
panels have both a pwm input for brightness-level and a separate
enable/disable pin).

If we can get information that my hunch here is correct then the
right thing to do would be to change things so that the PWM driver
stops poking bit 0 of the BACKLIGHT_EN register and this gets
done by the CRC GPIO driver instead. But the poking of that bit
is already happening now and since I'm not 100% sure that my hunch
is correct, the safe thing to do is to keep this as is.

Note that for the main consumer of the CRC PWM, the i915 driver
it does not matter. If we change that bit into a GPIO then the
i915 drv will need to be modified to drive the GPIO high / low when
enabling / disabling the panel. Just like it already enables/
disables the PWM when enabling / disabling the panel.

So the end result will still be bit 0 of the BACKLIGHT_EN register
going high/low on LCD panel enable/disable. So even if my hunch is
right functionality wise nothing will change. The code doing the
poking will be technically more correct, but that is all that we
would gain.

> I wonder if it would be possible to
> get the manual of that PWM. Do I understand correctly that this is IP
> from Intel? There are quite some Intel people on Cc; maybe someone can
> help/put in a good word/check and ack the changes?

IIRC last time I asked no one from the Intel folks on the Cc has access
to the Crystal Cove PMIC datasheet.

Regards,

Hans

