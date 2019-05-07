Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D022615DCC
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2019 09:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfEGHBr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 May 2019 03:01:47 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36504 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfEGHBr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 May 2019 03:01:47 -0400
Received: by mail-ot1-f68.google.com with SMTP id b18so13917053otq.3;
        Tue, 07 May 2019 00:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKMbIttCgzcVVkRNu5fztyhWx+BL/3mOVoqyvi0NAEI=;
        b=INSgcKv8O9yM65+VKqHoMOrNHbmlcEnHOVbaCQOGmt0PIZC9v+jY+T8l/YedGA5NA/
         Tz+qZPZ6yZNqFT/CK02u6QG74NWhUgkOr+nAw/XnxufPoizP/znYNYR6UvgAoH6RSot3
         Qtnkr2Gu+NlLSZkbT1vC0qUNTcyBWXp0alwHZ0xOETpG2m5UoJaUs5b3siE7wEY2C44A
         /VEzhFCZ/DsDN2t1bOfBmP3N1MOOvUF/3QZSD0OfwmuF2Gfz4gE/9nbeMkakfGUF+AVn
         KjV97vEHwb4/wwI88lcpGfze914MRqPgIEf4fZsZGDYq2o3gzCIkEq/Z+usY809PiwxL
         fA/g==
X-Gm-Message-State: APjAAAWjshv6yrOs7FjIStrYJZnaE7Mu+mxWsg5RK/0NvCvpYmGmH3he
        i5ztm6LkBFBO4cALu3OnYbeUbyxpo+gnkRebga8=
X-Google-Smtp-Source: APXvYqx5HZyzDhKKw/pMsuceYuNU8AOS/SQGy+9vmSPw9U4np+bboCTLUqSXmY0Nhp2RD3+3Fq6+UQEkP8tUjoPf56M=
X-Received: by 2002:a05:6830:1251:: with SMTP id s17mr17144503otp.186.1557212506581;
 Tue, 07 May 2019 00:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJqkgh-eh0F0rNBChhurH0LWTLFP0DyfFzKj66p4Z2d1kM2gw@mail.gmail.com>
In-Reply-To: <CAEJqkgh-eh0F0rNBChhurH0LWTLFP0DyfFzKj66p4Z2d1kM2gw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 May 2019 09:01:34 +0200
Message-ID: <CAJZ5v0gRWEL1shQE3im0VxiPRBYat86o=R_NVQbc3JgOX8uT6w@mail.gmail.com>
Subject: Re: [Kernel 5.1] ACPI_DEBUG messages without CONFIG_ACPI_DEBUG being set
To:     Gabriel C <nix.or.die@gmail.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Schmauss, Erik" <erik.schmauss@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+Erik

On Tue, May 7, 2019 at 1:33 AM Gabriel C <nix.or.die@gmail.com> wrote:
>
> Hello,
>
> while testing kernel-5.1 I get on one of my Lenovo Laptops very
> strange 'ACPI Debug:' messages.
>
> After some grepping I realized these are Debug messages from DSDT ,
> however my kernel does
> not have ACPI_DEBUG enabled.
>
> I found out the module triggering this, on this Laptop is
> ideapad_laptop , but looking at the code
> I cannot see what would causes that.
>
> Also on the same Laptop with any 5.0.X kernels I cannot see these.
>
>
> ~$ grep -i ACPI_DEBUG /boot/config-5.1-fw1
> # CONFIG_ACPI_DEBUGGER is not set
> # CONFIG_ACPI_DEBUG is not set
> # CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
> # CONFIG_THINKPAD_ACPI_DEBUG is not set
>
> .. dmesg ..
> ...
> [   68.020812] calling  ideapad_acpi_driver_init+0x0/0x1000
> [ideapad_laptop] @ 1322
> [   68.026708] input: Ideapad extra buttons as
> /devices/pci0000:00/0000:00:1f.0/PNP0C09:00/VPC2004:00/input/input16
> [   68.038236] ACPI Debug:  "=====QUERY_64====="
> [   68.050232] ACPI Debug:  "=====QUERY_65====="
> [   68.060218] ACPI Debug:  "=====QUERY_64====="
> [   68.092216] probe of VPC2004:00 returned 1 after 71386 usecs
> [   68.092245] initcall ideapad_acpi_driver_init+0x0/0x1000
> [ideapad_laptop] returned 0 after 69751 usecssg
>
> ...
>
> These =====QUERY_XX===== messages are from DSDT:
>
> ~/acpi$ grep QUERY dsdt.dsl
>                Debug = "=====QUERY_11====="
>                Debug = "=====QUERY_12====="
>                Debug = "=====QUERY_24====="
>                Debug = "=====QUERY_25====="
>                Debug = "=====QUERY_37====="
>                Debug = "=====QUERY_38====="
>                Debug = "=====QUERY_64====="
>                Debug = "=====QUERY_65====="
>
> Also this is the code from DSDT for QUERY 64 and 65:
>
> ...
>             Method (_Q64, 0, NotSerialized)  // _Qxx: EC Query
>            {
>                Debug = "=====QUERY_64====="
>                If ((OSYS == 0x07D9))
>                {
>                    If (((WLEX == One) & (WLAT == One)))
>                    {
>                        SGOV (0x02040005, One)
>                    }
>                    Else
>                    {
>                        SGOV (0x02040005, Zero)
>                    }
>                }
>            }
>
>            Method (_Q65, 0, NotSerialized)  // _Qxx: EC Query
>            {
>                Debug = "=====QUERY_65====="
>                If ((OSYS == 0x07D9))
>                {
>                    If (((BTEX == One) & (BTAT == One)))
>                    {
>                        SGOV (0x0202000B, One)
>                    }
>                    Else
>                    {
>                        SGOV (0x0202000B, Zero)
>                    }
>                }
>            }
>
> ...
>
>
> Any idea what would cause this ?
>
> BR,
>
> Gabriel C
