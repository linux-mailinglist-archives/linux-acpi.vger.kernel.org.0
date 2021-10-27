Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806BD43CC32
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 16:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbhJ0OaU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 10:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35983 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238198AbhJ0OaT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 Oct 2021 10:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635344873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KHHrb1tiDY2STHq9SuLRvZy3hZaADD9wEfu9gCQmDxI=;
        b=F1yT8CIW2rq/fVl+KFaD/j+sXSSPu0hspZcE6p3ogxwQSStFbbnkI15iIjwUQw0VPDr67C
        6vajQ6Fzs4h8JpCeck2rrbyijUup3JJ2xzZ4BqOq/ZrVtrQFdoAxjJI1DK5ohmR67P821/
        mx88wiHScmwUUyb8LXp9SkwLu/bPO9w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-9dqKB_naOqqSitzR_1xraQ-1; Wed, 27 Oct 2021 10:27:52 -0400
X-MC-Unique: 9dqKB_naOqqSitzR_1xraQ-1
Received: by mail-ed1-f72.google.com with SMTP id f21-20020a0564021e9500b003dd77985601so2483977edf.9
        for <linux-acpi@vger.kernel.org>; Wed, 27 Oct 2021 07:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KHHrb1tiDY2STHq9SuLRvZy3hZaADD9wEfu9gCQmDxI=;
        b=aMlwgkxqXuwmB5f859d8FrjKJiPf50feCmMfDymxwJM909ZHVSKij44X1Jhqp8rk0S
         Buc7MfAJllvZVeuMdH7id6Uo9XtjxNN1FT4piUzAJYX5jOHe+m5jO1mGTlHKQxfYg4kw
         60KqpMLImZH0MozAGynlx2NNl91H+U4cLxFNJWSRYxRG6k5N6Wwj8gWqmO8XAzzmDap2
         d8MTNA4A1CiTDy9QrQkoFYvcIQOsCqGjcPT/Wg0uBc50juVFSqXTynFI1IvQ8VBFNcoO
         zAS/T61dON6yPImK0GaHjRL2Py2qQzFlL+DIPjZ1i/curcQcype7ESlgr/A3Wwi6npHq
         KqWg==
X-Gm-Message-State: AOAM5329JR+jkjEorvVx/Pk90eqM5UmR4kr5E3nEG6aZtAa4iLBF6qU6
        ZWi2DWFZnQcgqc/dVJZXSOpbz8vLi3JtdClvZhcgHwUEasgsHZoM6nJfincHVzZcAE7hmwjTiO6
        IuehfQyHm5X55XkfiamBhBQ==
X-Received: by 2002:a17:907:961a:: with SMTP id gb26mr17802488ejc.527.1635344871503;
        Wed, 27 Oct 2021 07:27:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7TA88/kBuw1NJY7C8S9WnDH4N9C07D2dZ27TMGAfrekL2kIaYn912rjHXCE9gQ/3xdFOx4A==
X-Received: by 2002:a17:907:961a:: with SMTP id gb26mr17802469ejc.527.1635344871372;
        Wed, 27 Oct 2021 07:27:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q23sm47512ejr.0.2021.10.27.07.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 07:27:51 -0700 (PDT)
Message-ID: <3ad75583-b37e-8700-d062-42426966d912@redhat.com>
Date:   Wed, 27 Oct 2021 16:27:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 0/2] ACPI: scan: Honor certain device identification
 rules
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <11860508.O9o76ZdvQC@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <11860508.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/26/21 20:51, Rafael J. Wysocki wrote:
> Hi All,
> 
> There are some rules in the ACPI spec regarding which device identification
> objects can be used together etc., but they are not followed by the kernel
> code.
> 
> This series modifies the code to follow the spec more closely (see patch
> changelogs for details).

Both changes seem sensible to me; and since you make _HID take precedence
over _ADR I don't expect this to cause any regressions on BYT / CHT
hardware (the other way around will likely be an issue).

So for the series:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

