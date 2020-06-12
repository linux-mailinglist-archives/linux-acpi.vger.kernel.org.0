Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602141F7BE3
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jun 2020 19:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgFLRAQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Jun 2020 13:00:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32282 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLRAQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jun 2020 13:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591981214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YZefpytQS9Nuutazh9XOblfbRG+wXV9orLCiC5J8cHs=;
        b=DO1DLNi7tmeaF1DuK3zoEO5WuN8MXurU9dZyz2q2jOhJeUwSiqzGfmUW8w045XVaxbIJ36
        WBWcvJwnHFOzTKcqlo84Tkzy5yKvhmkJtQ/X206e6RXqEjm43sgiHqx9KSHlqQNyzoY0KJ
        knxgQggFP9AmjQy9UA/t/97uUBxO0RQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-gjckF-jHPXeIBOI3N8ZV9Q-1; Fri, 12 Jun 2020 13:00:02 -0400
X-MC-Unique: gjckF-jHPXeIBOI3N8ZV9Q-1
Received: by mail-ej1-f70.google.com with SMTP id s4so4441903eju.3
        for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2020 10:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YZefpytQS9Nuutazh9XOblfbRG+wXV9orLCiC5J8cHs=;
        b=Pm8dR+1cIX/tE+FQ6Xo1wTO7/1Kcj5stYH39HRYKALI9bsgZvfCp8xLsHHezz1YjQ8
         qOZ0CrF+YkVfDezR8e9KHYR1RZSEusczmFSOz3j6dOE2aLhY0aNBSZdMJtR4Nn8ZWLAd
         fkomL4cnSAjler44QClvg1Z+9jazjcfwCo2QwrZEm+gj9zkBX+JlQHZVXMmZrKoLgF7d
         Rz8s5Bs1im+hX11SE8voDZvApoDeHBnbaXuPGVz6TS0c4ii8oScBkF+goDiwfmMY6KNh
         864wwFp/ETPxK44SbwwSflc06wA9g5UWxKSoj3vg2QCmYT+IfJCcfF9YVL4eO20AELcs
         4Z5g==
X-Gm-Message-State: AOAM5311P1i5g4yeyXU/2gc/mukz528G/vyylzDKb//6mBVx2+tsplgG
        bAoeZ+0zKw/m+eB92THL+SGVR5tPjN2EFXri6QTB/cSS42p8fINe3CwwYV2uDJPlde2QG/FcqkI
        xWFTyBgjPAau5DzSViMFh7w==
X-Received: by 2002:a17:906:a387:: with SMTP id k7mr14926628ejz.408.1591981200773;
        Fri, 12 Jun 2020 10:00:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbjRA0DxcpKz6XFn10/ujz+AwaKQghqUPzhohiLhOX8HiLCbiRGn+Y5AlGw1zWUhaDAf5BGg==
X-Received: by 2002:a17:906:a387:: with SMTP id k7mr14926611ejz.408.1591981200562;
        Fri, 12 Jun 2020 10:00:00 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id h16sm3865328ejq.62.2020.06.12.09.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 09:59:59 -0700 (PDT)
Subject: Re: [PATCH v2 09/15] pwm: crc: Enable/disable PWM output on
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
        linux-acpi@vger.kernel.org
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-10-hdegoede@redhat.com>
 <20200611222029.csyo2wxof7nuhjws@taurus.defre.kleine-koenig.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1af668ef-7b42-340a-8aa2-f66c266ac6ef@redhat.com>
Date:   Fri, 12 Jun 2020 18:59:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611222029.csyo2wxof7nuhjws@taurus.defre.kleine-koenig.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/12/20 12:20 AM, Uwe Kleine-König wrote:
> On Sun, Jun 07, 2020 at 08:18:34PM +0200, Hans de Goede wrote:
>> The pwm-crc code is using 2 different enable bits:
>> 1. bit 7 of the PWM0_CLK_DIV (PWM_OUTPUT_ENABLE)
>> 2. bit 0 of the BACKLIGHT_EN register
>>
>> So far we've kept the PWM_OUTPUT_ENABLE bit set when disabling the PWM,
>> this commit makes crc_pwm_disable() clear it on disable and makes
>> crc_pwm_enable() set it again on re-enable.
>>
>> This should disable the internal (divided) PWM clock and tri-state the
>> PWM output pin when disabled, saving some power.
> 
> It would be great if you could also document that disabling the PWM
> makes the output tri-state. There are a few drivers that have a
> "Limitations" section at their top. Describing that there (in the same
> format) would be the right place.
> 
> Also note that according to Thierry's conception getting a (driven)
> inactive output is the right thing for a disabled PWM.

Hmm, the tri-state thing is an assumption from my side and we
don't have any docs for this PWM controller, so I'm not sure at
all if that is true. So I think it will be better to just drop
the tri-state bit from the commit msg for the next version.

Regards,

Hans


