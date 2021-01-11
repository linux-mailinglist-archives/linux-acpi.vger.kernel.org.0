Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8DE2F1E34
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Jan 2021 19:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbhAKSpH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jan 2021 13:45:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21773 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726063AbhAKSpH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Jan 2021 13:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610390621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LmhyGcm/gx5kQBUSkkI38f/0C4ZXazDKDqXscbSb8Is=;
        b=H3jhoS2DjXqG/Ha9tjlPENUd2zwdWvYytKBavANXgneiJqVYU8mssZsc/5uuGIB/uZ9k/W
        ifeNrUcaUFZGvXzNKdMBn/CE7glZKHPR7gAsmRuz1bvqdwGp87iODubjTAWc4sf5k4qhDF
        xLZM1s6gxQi/6qPdYU0yvULHN5nLvSE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-H1x6V4vQNW6hAOt0E-Qgdg-1; Mon, 11 Jan 2021 13:43:39 -0500
X-MC-Unique: H1x6V4vQNW6hAOt0E-Qgdg-1
Received: by mail-ej1-f70.google.com with SMTP id g24so242493ejh.22
        for <linux-acpi@vger.kernel.org>; Mon, 11 Jan 2021 10:43:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LmhyGcm/gx5kQBUSkkI38f/0C4ZXazDKDqXscbSb8Is=;
        b=aSf4O46iSzvSa2t4V6kptMHTj7cexcM596eG6Yf7gqhUWRv5D9sEp+O+olHLtbMO7c
         hIGjkmiW6WOYBQkEf+dTipGE9RmgR0RuJ9mCLc7hNVz6IPyERDV/o9x2eBhyOCxdc9Uo
         Ngh8YAYLGO3twkH+ERudvkOykC5E28V0cf6EgImDsM2sgbBjoKxXELffnCdJspqCLZuX
         T42erV4OAfJzT6FuP5gs5wGVRMrAMw2GnWZKPrUx8H28ayfChWk0QIT5osxgbDX6A89z
         QOlyEIXL0lH5ltlhU8VpsPOfTDX8oeA4EVlS3ju7PZGB7AfrdoSy+RFMP7ypdGJ0F/zG
         OnZw==
X-Gm-Message-State: AOAM531COx9eeCL7XfBc12wxKToKKGUz7s0kcw+234KHLziAwfCPqeK+
        fegCtHzAF2BlRhJmDdvHwflc36eQ7elsNyLjlvnwUf/78Z0r3DoUl0p0VJGG8iuOa4eU6a66u5a
        jXDu/AOFeWDAKF1vcqcQ7Jw==
X-Received: by 2002:a50:e78b:: with SMTP id b11mr524676edn.165.1610390617825;
        Mon, 11 Jan 2021 10:43:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvuRCDS34ctNm4MvvviTLoyj/Hm2fnaGydoWwblLHYWqNNNmzo4MbNRHi+bLrFBV0kTWWDdQ==
X-Received: by 2002:a50:e78b:: with SMTP id b11mr524657edn.165.1610390617639;
        Mon, 11 Jan 2021 10:43:37 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id i18sm299758edq.79.2021.01.11.10.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 10:43:36 -0800 (PST)
Subject: Re: [PATCH 0/2] ACPICA: Fix a race in GenericSerialBus (I2C) and GPIO
 handling
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
References: <20201226142830.48818-1-hdegoede@redhat.com>
 <MWHPR11MB159999DD0D8F383288CF8CDEF0AB0@MWHPR11MB1599.namprd11.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a0e625b8-3ddc-148c-8626-650f965dad04@redhat.com>
Date:   Mon, 11 Jan 2021 19:43:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB159999DD0D8F383288CF8CDEF0AB0@MWHPR11MB1599.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/11/21 7:39 PM, Kaneda, Erik wrote:
> 
> 
>> -----Original Message-----
>> From: Hans de Goede <hdegoede@redhat.com>
>> Sent: Saturday, December 26, 2020 6:28 AM
>> To: Rafael J . Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>;
>> Moore, Robert <robert.moore@intel.com>; Kaneda, Erik
>> <erik.kaneda@intel.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>; linux-acpi@vger.kernel.org;
>> devel@acpica.org
>> Subject: [PATCH 0/2] ACPICA: Fix a race in GenericSerialBus (I2C) and GPIO
>> handling
>>
>> Hi All,
>>
>> On one of my machines I noticed the following errors being logged:
>>
>> [   52.892807] i2c i2c-0: adapter quirk: no zero length (addr 0x0078, size 0,
>> read)
>> [   52.893037] i2c i2c-0: i2c read 0 bytes from client@0x78 starting at reg 0x0
>> failed, error: -95
>>
>> The second line is coming from the Linux I2C ACPI OpRegion handling and
>> after a bunch of debugging I've found out that there is a rather obvious
>> (once you see it) and nasty race condition in the handling of I2C and GPIO
>> opregions in acpi_ev_address_space_dispatch(). See the first patch in this
>> series (the second patch is a follow-up cleanup patch removing some code
>> duplication).
>>
>> TBH I'm surprised that this issue has gone unnoticed as long as it has,
>> but I guess that it mostly leads to unreproducable sporadic problems
>> making it hard to debug and I got lucky that I had a machine where the
>> race seems to trigger about once every 20 seconds.
>>
>> I know that ACPICA patches are normally merged through the ACPICA
>> upstream
>> but given that this is a serious bug, I believe that in this case it might
>> be best to add the fix directly to Linux and then port it to ACPICA from
>> there.
> 
> Thanks for this changeset! I'm taking a look right now

Ok, note I already ported it to ACPICA git and submitted a pull-req
(on Bob's request): https://github.com/acpica/acpica/pull/658

Regards,

Hans

