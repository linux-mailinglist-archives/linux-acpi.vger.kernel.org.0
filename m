Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A8683D39
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Aug 2019 00:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfHFWKW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Aug 2019 18:10:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42027 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfHFWKW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Aug 2019 18:10:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id t28so83556303lje.9
        for <linux-acpi@vger.kernel.org>; Tue, 06 Aug 2019 15:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bgewXXxxhY/dAfBGFMPvrzGizAhrJK4ewhsHFFY/ZXc=;
        b=S7Xmi1DIjpcc1NyZ1euHM9kbzVqM1CVov4LeTusvdshoFAvVWX2NW0xhDTbpTxPMrD
         F7/LCPShWklAmxPw+ZcI2kxGXmv9K9+L08AoQI9dFlQYVFnOYSub7m4UKm1+siM0tYEg
         QVqSH1iJP+cLOAbmK71a2wYQT7CyhUoE2UeVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgewXXxxhY/dAfBGFMPvrzGizAhrJK4ewhsHFFY/ZXc=;
        b=Z/Xi82BCau6e6wC7AS6GyTe22CABL2PWCP9oBF46/iqOtjXJXfFcr3ycIOeI4jH5G5
         19idmlaXoyqizSWAFKEwJE/gKDzyYct68UdYyjY0ZxSJYq/edjsCIUpMPocUbWKWdPNg
         aVX4sg1ilMerW0DuUz55jAKHHUdEzKUp/xWgFaqZIw/Zg4A73iwc1bhAkrxlUX6meqIX
         Ze9R4MOgsj4Tml6dv3kH//tSeKcOX2QOUCQro+VCJJTihPnJoV5eyG+OJx25UZWAWDcd
         L8w0vUKbXdyoSKXAc4CoGw+gJVqDUNaJFyr4iFzrODMJprHXXyj8Wjlfq7AuS5ldMnEc
         DSAg==
X-Gm-Message-State: APjAAAV1gAiFBUfeaL9tkFhszjlpfnUR8Nsig/oUDPOHEaxnX/i73q3r
        h1PsZRxwLwdpRPjb62C9J1dvRm/KvkM=
X-Google-Smtp-Source: APXvYqyoLUQOILKJUHCGbzeZefGr26j11EqeJhFDNpVxA+ntZuLQ9SJgeKhCSPxm7QYnBNcjIapWWg==
X-Received: by 2002:a05:651c:87:: with SMTP id 7mr2859041ljq.184.1565129420159;
        Tue, 06 Aug 2019 15:10:20 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id q17sm2972575lfa.82.2019.08.06.15.10.17
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 15:10:18 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id z28so29338166ljn.4
        for <linux-acpi@vger.kernel.org>; Tue, 06 Aug 2019 15:10:17 -0700 (PDT)
X-Received: by 2002:a2e:3602:: with SMTP id d2mr3006585lja.112.1565129417010;
 Tue, 06 Aug 2019 15:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190729204954.25510-1-briannorris@chromium.org>
In-Reply-To: <20190729204954.25510-1-briannorris@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 6 Aug 2019 15:10:05 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPZxD6D2P_7vucseZS=Fe8KDEyNGvNQySvJYu_-fGxk5A@mail.gmail.com>
Message-ID: <CA+ASDXPZxD6D2P_7vucseZS=Fe8KDEyNGvNQySvJYu_-fGxk5A@mail.gmail.com>
Subject: Re: [PATCH] driver core: platform: return -ENXIO for missing GpioInt
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Salvatore Bellizzi <salvatore.bellizzi@linux.seppia.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enrico Granata <egranata@chromium.org>,
        Enrico Granata <egranata@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 29, 2019 at 1:50 PM Brian Norris <briannorris@chromium.org> wrote:
> Side note: it might have helped alleviate some of this pain if there
> were email notifications to the mailing list when a patch gets applied.
> I didn't realize (and I'm not sure if Enrico did) that v2 was already
> merged by the time I noted its mistakes. If I had known, I would have
> suggested a follow-up patch, not a v3.

I guess I'll be the bot this time: 'twas applied by Greg on Tuesday,
July 30 UTC-07:00.

Thanks,
Brian
