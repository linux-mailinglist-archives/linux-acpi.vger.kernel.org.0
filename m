Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC3831C107
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Feb 2021 18:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhBORvx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Feb 2021 12:51:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231551AbhBORvn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 Feb 2021 12:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613411415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+IX9Y+g0AiC0vHhEOs3UjpOm/krxaJYnx6TKqaAu6g=;
        b=R+R3vv2l60LHSIbMECVe2T0PqaCJvrB3bPXoNdTl8bb0dlAjfCmyvFQ/qfduYLmtu0/S29
        ybWnqP/oy4NeRVOUPIJCO/quK4X64gjZ/BlKAsrkHUH7gf740TdAImrzHOHxCj+ZSQg/1y
        Y1GcLLMZ2EBYL2JDGlB7fDwH/JKxRRA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-9pRyfl6_MX6Qb7bubUgW0Q-1; Mon, 15 Feb 2021 12:50:12 -0500
X-MC-Unique: 9pRyfl6_MX6Qb7bubUgW0Q-1
Received: by mail-ed1-f70.google.com with SMTP id j10so5706765edv.5
        for <linux-acpi@vger.kernel.org>; Mon, 15 Feb 2021 09:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T+IX9Y+g0AiC0vHhEOs3UjpOm/krxaJYnx6TKqaAu6g=;
        b=THx1Fo6VaB3Mw4VeQRAFGjGHi4klmzj26iMxQM46IYmqH9xn4izmQ3oZ8HblUxb5Fh
         Djmd7ykZBshTuAMQOVL98ohr9uxan0FCCm6oVIQ+053cnHj5WCo1/3PEiNGSVWrOoFRG
         GlJHpimdd22K/mHMetkZOB0Z8fzf/XHMAkjuBaTOIIaQ/F3ECYZxC+Kw0LwimUwdWBX6
         ge0sTHhrs6iN04rq2SBcWD98HC6yMk5a8BgHH82M7L8iQu1TcRrYc428tepDoEWXX9pt
         IHQpaM1k6+brBaiPWt434lTHoK3n03EcLzGTIk02OeisI8R8xFnxI7aQnBFBuIbYDJ/v
         Obsg==
X-Gm-Message-State: AOAM533+fw4iZ8gAGNpRS+UydkQq7Xi/ml8Zv2SNCfz4lv/STDItSEhb
        yoPWKRpircXPWlyHwa0yW7BGI0CiGwnqgAZ60+EG/eA+5ApL0uiVmpnIb4REk31DbHoxjRtun/s
        bFAxcVvYpLSbaIwvnlRAp9g==
X-Received: by 2002:a17:907:210d:: with SMTP id qn13mr16394832ejb.377.1613411411642;
        Mon, 15 Feb 2021 09:50:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIlYmN8Khr9fY+uQZ2l4k0vXzWl0rrgka6XKDuklL2UniN41CQQGXIxNz2p9VZiehgdpcoYQ==
X-Received: by 2002:a17:907:210d:: with SMTP id qn13mr16394819ejb.377.1613411411452;
        Mon, 15 Feb 2021 09:50:11 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id x17sm10738490edd.76.2021.02.15.09.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 09:50:11 -0800 (PST)
Subject: Re: [PATCH 0/2] ACPICA: Fix a race in GenericSerialBus (I2C) and GPIO
 handling
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org
References: <20201226142830.48818-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ced43570-1e76-6f96-f9ab-83473b4adfb7@redhat.com>
Date:   Mon, 15 Feb 2021 18:50:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20201226142830.48818-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/26/20 3:28 PM, Hans de Goede wrote:
> Hi All,
> 
> On one of my machines I noticed the following errors being logged:
> 
> [   52.892807] i2c i2c-0: adapter quirk: no zero length (addr 0x0078, size 0, read)
> [   52.893037] i2c i2c-0: i2c read 0 bytes from client@0x78 starting at reg 0x0 failed, error: -95
> 
> The second line is coming from the Linux I2C ACPI OpRegion handling and
> after a bunch of debugging I've found out that there is a rather obvious
> (once you see it) and nasty race condition in the handling of I2C and GPIO
> opregions in acpi_ev_address_space_dispatch(). See the first patch in this
> series (the second patch is a follow-up cleanup patch removing some code
> duplication).
> 
> TBH I'm surprised that this issue has gone unnoticed as long as it has,
> but I guess that it mostly leads to unreproducable sporadic problems
> making it hard to debug and I got lucky that I had a machine where the
> race seems to trigger about once every 20 seconds.
> 
> I know that ACPICA patches are normally merged through the ACPICA upstream
> but given that this is a serious bug, I believe that in this case it might
> be best to add the fix directly to Linux and then port it to ACPICA from
> there.

ping ?

This was submitted 2 full months ago; and despite this:

1. Fixing a serious bug in ACPICA
2. The fix being pretty simple (and AFAICT obviously correct)

This is still awaiting review upstream:
https://github.com/acpica/acpica/pull/658

I must say that it feels to me that the upstream ACPICA process is broken here.

I submitted a pull-req for this, as requested and after that there has
been zero progress.

The pull-req even has a 26 day old "this looks good to me" comment from Erik,
followed by silence... ?

Rafael, can you please consider just directly picking these 2 fixes into
your acpi branch, so that we can get this nasty race condition fixed ?

Regards,

Hans

