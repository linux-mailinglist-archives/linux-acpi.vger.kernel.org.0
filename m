Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC902D3725
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Dec 2020 00:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgLHXth (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Dec 2020 18:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729961AbgLHXtg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2020 18:49:36 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEB4C0617A7
        for <linux-acpi@vger.kernel.org>; Tue,  8 Dec 2020 15:48:55 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id 91so51950wrj.7
        for <linux-acpi@vger.kernel.org>; Tue, 08 Dec 2020 15:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/YmS3hOWCE4k0hphrxM0zugM8Gyy2ukY1jHYkXDZO18=;
        b=D8tyTURvjYboRt+y3QWaXUMHHn+QkpdU8U+5jD1CYwAWx3+ItPvDxxtpWcmLkvKSqQ
         MXVrzoAdrnivlLZuUO764fkXqfyt7laDrAwB079ibUu1DPc7aliPsRRA6/Rhbmji9CUk
         eM8htCVu+PnLLNX5oOr7eRCCC3HIL1dgQ423XvRQhJQSDwiNEzTvf0m3EsrGbb9v/QdU
         lEZ+ydoYRgiT3ec/2lpH5B1oPC6PQxAeRtuhCNvinyJSc+788jWVwqFpBapJ+EstAqT6
         VgwvJA7JZMFISFi2pksSokpHFIzCD635KCBSkmDsGCJkzqsFLycexwVbF9iFN6DEy8pg
         JXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/YmS3hOWCE4k0hphrxM0zugM8Gyy2ukY1jHYkXDZO18=;
        b=AsW0TDqJiXqL2dkwzq/X5jGGvvUlKov9djQXKFIyOYv6fH9kmq1ZTbRULdBIgX8WCG
         Mx3kkdpPNZPEtsvY4ByAKzi5Sbds4vkBAB9F3nXFzONs0nItrQmqgpk7Zva2984gKBGQ
         ypQPQC7Gu/BLDZ6kr44DumdQpmwQXx7dwutk0z1jpaCCIfoSvqmNbGyh5H1p5rCIuLMJ
         wlAP6SC9Z2YJZggCz6kR7+HsTFBMrmiRu1GYwHZVNrHU0e2dNVA2v8BhbF27jTMwizlZ
         3qNfRMAlrem2h++a9KflemITsqZghCktb0H3tZr3D4bE7Nm0GQjgQbfid8MpZAtdIbEA
         TRcA==
X-Gm-Message-State: AOAM5325sNeJajg1/Yexd4SSWz7wAAO5v5s6chMx9KESU4OZNHZZF9n4
        k8vyR1AgW2Fgly4q5k7hNkXZSB8rmq04CQ==
X-Google-Smtp-Source: ABdhPJzSQqZpCYjTF9SHkM04wIq6HJhRqNauXSXZHA9Gi7aMcUhjirPZYSGwvwa/ystpyMZ14nwlQw==
X-Received: by 2002:adf:e48d:: with SMTP id i13mr550120wrm.48.1607471333815;
        Tue, 08 Dec 2020 15:48:53 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.56])
        by smtp.gmail.com with ESMTPSA id u66sm546580wmg.30.2020.12.08.15.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 15:48:53 -0800 (PST)
Subject: Re: acpi_device_notify() binding devices that don't seem like they
 should be bound
From:   Daniel Scally <djrscally@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
References: <1409ba0c-1580-dc09-e6fe-a0c9bcda6462@gmail.com>
Message-ID: <858bb2b0-e2b4-f0d4-0088-7106fec3cb8f@gmail.com>
Date:   Tue, 8 Dec 2020 23:48:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1409ba0c-1580-dc09-e6fe-a0c9bcda6462@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello again

On 06/12/2020 00:00, Daniel Scally wrote:
> INT3472:08 is not an acpi device that seems to be a good candidate for
> binding to 0000:00:00.0; it just happens to be the first child of
> PNP0A08:08 that shares _ADR 0 and has _STA not set to 0.
> 
> The comment within acpi_find_child_device() does imply that there should
> only ever be a single child device with the same _ADR as the parent, so
> I suppose this is possibly a case of poor ACPI tables confusing the code
> a bit; given both PNP0A08:00 and _all_ of the INT3472 devices have _ADR
> set to zero (as indeed do the machine's cameras), but I'm not
> knowledgeable enough on ACPI to know whether that's to spec (or at least
> accounted for). The INT3472 devices themselves do not actually seem to
> represent a physical device (atleast, not in this case...sometimes they
> do...), rather they're a dummy being used to simply group some GPIO
> lines under a common _CRS. The sensors are called out as dependent on
> these "devices" in their _DEP method, which is already a horrible way of
> doing things so more broken ACPI being to blame wouldn't surprise me.
> 
> The other problem that that raises is that there seems to be _no_ good
> candidate for binding to 0000:00:00.0 that's a child of PNP0A08:00 - the
> only devices sharing _ADR 0 and having _STA != 0 are those two INT3472
> entries and the machine's cameras.

After some more reading, I'm pretty confident that this is the problem
now - I.E. that those devices having _ADR of 0 is what's causing this
issue to materialise, and that those values should be set to something
more appropriate. Still unsure about the best approach to fix it though
from a kernel point of view; there doesn't seem to be anything out of
whack in the logic, and I believe (correct me if I'm wrong) there can be
legitimate instances of child devices sharing _ADR=0 with the parent, so
the problem becomes how to identify the illegitimate instances so that
they can be discarded. My experience in this is really limited, so I
lean towards the conclusion that hard-coding exceptions somewhere might
be necessary to handle this without resorting to patched ACPI tables.
Whether that's within acpi_find_child_device() to prevent matching
occurring there, or else setting the adev->pnp.bus_address to some
alternate value after creation to compensate.

I recognise that that's a horrible answer though, so I'm really hoping
that someone has an idea for how to handle this in a better way.
