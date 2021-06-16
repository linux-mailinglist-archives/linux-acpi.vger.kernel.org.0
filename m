Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1403A9F0E
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 17:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhFPPa3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 11:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234077AbhFPPa3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 11:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623857302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BLas3/nFvDzs67dkoqE0uPTj+WWCmULhYvLflkP+fWo=;
        b=GGkC1mWrAWu23uiP2Y0xREcTmmf7C3JuBaGHskSMoxQP4Ar5qrmZ9b6YsTImHrkmlaJbqY
        zBidF4nAqAE1SGhScxDaxwXV4vupAOqlCZ/26lBu6KOF9y0G8e8K5GA+6ckdywo1xncNlI
        ir20uQjLiKw2A/7BP8EBuOl6R/9LWUU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-Oz0X_DBAMAK3eH_SuLNdcw-1; Wed, 16 Jun 2021 11:28:21 -0400
X-MC-Unique: Oz0X_DBAMAK3eH_SuLNdcw-1
Received: by mail-ed1-f70.google.com with SMTP id a16-20020aa7cf100000b0290391819a774aso1265821edy.8
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 08:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BLas3/nFvDzs67dkoqE0uPTj+WWCmULhYvLflkP+fWo=;
        b=Q+DGSsBAbsCUBqqCwUKt3aK/IkGW2jxGFt7MilsEc/yHFwRPcPlbHULvVqXgBRZZ8g
         VUAEs7pmX2MxFftn3/8T7mSYEUb6fTxjvroc4eDBjXkwXjXeYrWUpmsqt2eON9DKjT+7
         nov2bAXEgZhWROPC+z/xBNYMga9eh2XexQv0Te32a+YdRq3OhrTBJUlkc/TEgbBqJc6k
         PX3PhKj8VFQ9R3rYA9R1Nk6jPAKQZ8Saj4do7s43s9RdV7Lbs15b3BMPrvalFtrxG2dX
         u/t68UawHlDEaOfrmQKtZIYvev99By6fn6EIBf9dqFdQWUFARQOm3gj9W9zuiqmJgujo
         XSLw==
X-Gm-Message-State: AOAM531DKfXsCFYd+3hM+F2pmhWDOmZyWAYVSEFkA03DKQGMLPYYWnft
        xG8N33BdJ4anRZeSmSlCBL6B4+5VKm3TJ5nDYX6GorNsqgA7so1oujgSntFNtEXl+wMdwtNxv+E
        yqGfPCk2+D8ncX93hwAVy/Q==
X-Received: by 2002:a17:907:6f2:: with SMTP id yh18mr80060ejb.5.1623857300168;
        Wed, 16 Jun 2021 08:28:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/ww3BJp4hsJ3ry2mzr6M3d8roZGAdHTBAEdOEGDLnh0e3VRj2B6oTQ86XraJunbgXUJNDuQ==
X-Received: by 2002:a17:907:6f2:: with SMTP id yh18mr80047ejb.5.1623857299995;
        Wed, 16 Jun 2021 08:28:19 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id n23sm2136526edr.87.2021.06.16.08.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 08:28:19 -0700 (PDT)
Subject: Re: [PATCH 2/5] ACPI: scan: Make acpi_walk_dep_device_list()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <3140195.44csPzL39Z@kreacher> <1881350.PYKUYFuaPT@kreacher>
 <f46533e2-1ebe-0130-9323-b045da6ea62d@redhat.com>
 <CAJZ5v0gZ2Fbff_g_v8t46-957=U_1nGe22sP9W=Hc-dohG8=Jg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4a08edff-df90-aeee-1d1d-76e6e0b9af4d@redhat.com>
Date:   Wed, 16 Jun 2021 17:28:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gZ2Fbff_g_v8t46-957=U_1nGe22sP9W=Hc-dohG8=Jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/16/21 5:11 PM, Rafael J. Wysocki wrote:
> On Wed, Jun 16, 2021 at 4:41 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 6/16/21 4:22 PM, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Because acpi_walk_dep_device_list() is only called by the code in the
>>> file in which it is defined, make it static, drop the export of it
>>> and drop its header from acpi.h.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Actually, acpi_walk_dep_device_list() was split out as a
>> helper function used to implement acpi_dev_clear_dependencies()
>> because it will be used outside of drivers/acpi.
> 
> Not exactly.
> 
>> Specifically it will be used in the new intel_skl_int3472 driver:
>> https://patchwork.kernel.org/project/platform-driver-x86/patch/20210603224007.120560-6-djrscally@gmail.com/
> 
> That driver will use acpi_dev_get_first_consumer_dev() which is based
> on acpi_walk_dep_device_list(), but still defined in
> drivers/acpi/scan.c.
> 
>> Which I plan to merge into pdx86/for-next today, I've just merged
>> your linux-pm/acpi-scan PULL-req which exports acpi_walk_dep_device_list()
>> as preparation for this.
> 
> No, the acpi_walk_dep_device_list() is a leftover there AFAICS.

You are right, my bad.

So with this resolved, this patch is fine too:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

