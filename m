Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87469105CE7
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2019 23:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfKUW5c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Nov 2019 17:57:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46310 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKUW5c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2019 17:57:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id r18so2364447pgu.13;
        Thu, 21 Nov 2019 14:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vqy0Ktfx+e1VHKIzbLW7lEwWr2BHqTiwe+oCnkuSYZA=;
        b=JcEQ1i2352AaD6f01ASy44G06Y2RW0EDhvQMO4UMcpwVlnRog2R1SLmwm7U5ft+e/u
         d9pufedYWHLk7P1BIbIbjGA4XA4HU/AYoAf9PfrSjDprwvkMTz5Gwy6ICPbrs/8kcOxy
         6t1A6uLuQuCNoJoQjtMtrLR8WifzvNXSn4OBMPK1B0o9S2+714zJwW7vMrbEHlHn1BIR
         zWjwAlOhTCVzvLarL1GJSeIeQXcKEXRRDC1f9TcB76s8TeYZuMlqVotTlVmHg35YZamN
         IkeEVDX74PGXvvKHFeA7Utp0jE+B4UGBWSWZ2PBVbf3tIzmU4wOiWTY8/QWGy4Xhkq7M
         XPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vqy0Ktfx+e1VHKIzbLW7lEwWr2BHqTiwe+oCnkuSYZA=;
        b=FJmeQZUe2zZ52Xb582SDUqh96+kun7lQjpP6xKStnHRP3t6g/Zg7QudPfJ9YfzoCFa
         mvg6Rlhtxfrq0zyrws45MstVkvETtXSbx5BvIZItYXe/jN3GyvPB5460GyHlkLlSbNPB
         NdAMWsUmd9JTx9+61Ltxsw+0D7P942/bkakHFdoPNBMmG7brfx/ZQQhw23v0KuVVaoqK
         9gwVaJF9/e3PbIay2qj0A6y+vn4jn4J2iC8FVIWz8rK1yE/C4t+8Toe4ZPBEI9ztEUSA
         MJzjfnHSpoDsd31VcJFFlTZsB5vxhAllAg4T2aw5B2q80smTtByp/+6Gz/8kzUPwIOG8
         PMyg==
X-Gm-Message-State: APjAAAU1XoszPJ1th2eF/L3Hcn9NzajMluN5OpYlBbj4l42nwOSWt7q/
        1GT/UiMS4t8C1PlhdUcbcWj2ehrVSnc=
X-Google-Smtp-Source: APXvYqzXCoAOVZjVBqkK4XttGVG0TfnLBIPYbN6VlOIB+NbeaH+S0Ej7DsDQ1hHQxQZP8frLpROxQA==
X-Received: by 2002:a63:d901:: with SMTP id r1mr12330337pgg.328.1574377050294;
        Thu, 21 Nov 2019 14:57:30 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id a23sm535836pjv.26.2019.11.21.14.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:57:29 -0800 (PST)
Subject: Re: [PATCH] ACPI: only free map once in osl.c
To:     Francesco Ruggeri <fruggeri@arista.com>
Cc:     lenb@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org
References: <20191120054728.0979695C0FE4@us180.sjc.aristanetworks.com>
 <CAJwJo6ZTSw93zKdN3i-YqVtEEwh4qWc22Hk-emHvJth+HsaQbQ@mail.gmail.com>
 <CA+HUmGh+tEnP7n+_FcJuwZOF4HBgfatLwUa8a=K_BdqnKETNCw@mail.gmail.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <1bb01499-34f7-c4a5-a910-bb6419e9e476@gmail.com>
Date:   Thu, 21 Nov 2019 22:57:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CA+HUmGh+tEnP7n+_FcJuwZOF4HBgfatLwUa8a=K_BdqnKETNCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11/21/19 10:49 PM, Francesco Ruggeri wrote:
> On Thu, Nov 21, 2019 at 1:19 PM Dmitry Safonov <0x7f454c46@gmail.com> wrote:
>>
>> Hi Francesco,
>>
>> I believe, there's still an issue with your patch.
>>
>> On Wed, 20 Nov 2019 at 05:50, Francesco Ruggeri <fruggeri@arista.com> wrote:
>>> @@ -472,10 +477,11 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
>>>                 mutex_unlock(&acpi_ioremap_lock);
>>>                 return;
>>>         }
>>> -       acpi_os_drop_map_ref(map);
>>> +       refcount = acpi_os_drop_map_ref(map);
>>>         mutex_unlock(&acpi_ioremap_lock);
>>
>> Here comes acpi_os_get_iomem() increasing the refcount again.
> 
> Thanks Dmitry.
> I think that any code that increments the refcount does so after
> looking for map in acpi_ioremap under acpi_ioremap_lock,
> and the process that drops the last reference removes map
> from the list, also under acpi_ioremap_lock, so I am not sure
> this could happen.
> The synchronize_rcu_expedited in acpi_os_map_cleanup should
> then take care of any other references to map (which it is my
> understanding require acpi_ioremap_lock or rcu read lock).

Ah, right you are!
Sorry for a false alarm.

Thanks,
          Dmitry
