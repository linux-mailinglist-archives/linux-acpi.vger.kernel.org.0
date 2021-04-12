Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A24135D0A1
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Apr 2021 20:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbhDLSx5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Apr 2021 14:53:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48946 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244846AbhDLSxz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Apr 2021 14:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618253616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZaMcPXfDKI4dAGPZ9XHv91m+EkjYZDr8yDUs34Y2fzk=;
        b=ZIYQJaQ801mLvj5OcZ/RLtC8F4o3Lm5iFXlxh3TmNxP8et44xjPvxfpYRaIKt/JOjtFk1t
        2BUR2h57D014/5k4gSq8qImzQanArsObIVzG/jxBkZwzapEtpivujSCePsK9cky6iONIn7
        qcHD+As59wDpZlGrQ8hRP0Dwvft5iZk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-cJurYGkVOqiwDxpcpyegXw-1; Mon, 12 Apr 2021 14:53:34 -0400
X-MC-Unique: cJurYGkVOqiwDxpcpyegXw-1
Received: by mail-ej1-f70.google.com with SMTP id cd13so1428882ejb.9
        for <linux-acpi@vger.kernel.org>; Mon, 12 Apr 2021 11:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZaMcPXfDKI4dAGPZ9XHv91m+EkjYZDr8yDUs34Y2fzk=;
        b=T+qaky3AoXAGzc0BNo/ukPNqeDPzQ5KaNNm63aSvS0Ps/e70lYXgTVvNTvHI0uQFDt
         tdDHfwMrYT6wr+69VNVeTyQur8SeAP+oKfv2ii3uJu4xGzI+/M+EV12dk8Is7A56Fc2R
         0I6w1HAJousd7QWPRs8IRNi3Ixh/oeQ8AnWw32Runx0j3ziUeuBjZHg55nlBwU78MOIc
         Ne/abhLjS0VGMeU9h02IlLf2Ysak4U5Kv3mZDXvNo64QfCp7Lv21B5L+q7fHLO+eJS61
         1kWlXnFTcs4YrBiSgo559+1LqTh6kf37VSJR4W7wnG+mGDvdduYCoHrxo/2t6Rh5ltt2
         zknw==
X-Gm-Message-State: AOAM5312zJ+DXtaW/sv8JPsQkOBbWn82h0e1VrJfCWbQPFBC3nRUyvFA
        Iv/C4pwMw1sDplZziZN8b37bTv2TGjmcO/y6Abzan1c5PPcgZLdhIEoOC/idqo2VI9aEhjh/o7P
        VbdFhl8W9bX6lqlOns+hRELYodPf/YLmFeYybzuukWx9xUdBY/gByDXNJSSw2GhW9RZ+T7/A4nQ
        ==
X-Received: by 2002:a50:fb8c:: with SMTP id e12mr31472729edq.295.1618253612983;
        Mon, 12 Apr 2021 11:53:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+k75kY+DmZ56M/3aDqo4CJgj/w3rLXhG2T4QE6lY7BU/28iCKu57RWQtXdBtliRJkJqprtw==
X-Received: by 2002:a50:fb8c:: with SMTP id e12mr31472713edq.295.1618253612774;
        Mon, 12 Apr 2021 11:53:32 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id mp36sm6270334ejc.48.2021.04.12.11.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 11:53:32 -0700 (PDT)
Subject: Re: [5.12 regression] DSDT overriding from initrd no longer works
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
References: <7d941a3c-bced-09cf-27a1-b61f0d20ef4c@redhat.com>
 <CAJZ5v0iLSbfRH9A3EMUTrY5=vPdp=uVOF2XQnWkAbko9NjPqJg@mail.gmail.com>
 <CAJZ5v0gOMZbyD5r+bCL9vD6_NrFz0nAq+eY2QDtxOY4DfsXG6w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <273d3ea7-aa74-6556-7fef-fb65b620bc95@redhat.com>
Date:   Mon, 12 Apr 2021 20:53:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gOMZbyD5r+bCL9vD6_NrFz0nAq+eY2QDtxOY4DfsXG6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 4/12/21 8:11 PM, Rafael J. Wysocki wrote:
> On Mon, Apr 12, 2021 at 8:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Mon, Apr 12, 2021 at 7:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi Rafael,
>>>
>>> Sorry about the timing of reporting this regression.
>>
>> Oh well.
>>
>>> I just noticed that overriding the DSDT (*) from the initrd will not work in 5.12,
>>> this is caused by:
>>>
>>> commit 1a1c130ab757 ("ACPI: tables: x86: Reserve memory occupied by ACPI tables")
>>>
>>> This makes the initial acpi_locate_initial_tables() call happen earlier
>>> then before, but the acpi_table_upgrade) call in arch/x86/kernel/setup.c is
>>> not moved up, so the tables in the initrd are now only parsed and saved
>>> after the initial ACPI table scanning has already been done.
>>>
>>> I guess fixing this might be as easy as moving the acpi_table_upgrade) call
>>> higher in arch/x86/kernel/setup.c but I'm not sure if that is save to do.
>>
>> Why do you think it may not be safe?
> 
> OK, so it won't work in some cases, because acpi_table_upgrade() needs
> to be called after reserve_initrd(),

Right I notice it was sitting right after reserve_initrd() which made me think
that it probably needed to be after that. Sorry I should have mentioned that
in my original email.

> so I guess the commit above will
> need to be reverted.

One possible solution which I was wondering about is to modify
acpi_table_initrd_scan() to have it call acpi_tb_override_table()
instead of acpi_install_table() for existing tables using the matching
logic from acpi_table_initrd_override(). But I'm not sure when the
parsing of the DSDT is done. If acpi_table_initrd_scan() runs before
the first parsing of the DSDT is done then I think that that should work.

This might be more 5.13 material though and for 5.12 a revert is
probably best.

I also just remembered that at least the Intel audio folks rely on
DSDT overrides to get some (prototype) boards in their CI to work.

Regards,

Hans


