Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771C8277B2F
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 23:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgIXVls (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Sep 2020 17:41:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26738 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbgIXVls (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 24 Sep 2020 17:41:48 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600983707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g/Xbd+gOY1D7k7S7s+pOd/hTecpIxif1KV3RUcYn5rQ=;
        b=CORwb8PIeVtKETJHQITWzOlbIFhshZvaUAqTKLBdLXqKgfY0LKONKFbRw8I70agE0Eg7Li
        ZiyAwMaEHal8xJ5GVJod5J2iK4z7l206r/vSlN/JKnFATwuczWZNga6VL5M5LYVQyBwnDI
        3Wqq78QL3D6cQHVdDQKYukquWa3566A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-TBFGaENKNbesjwwTv2IUcQ-1; Thu, 24 Sep 2020 17:41:44 -0400
X-MC-Unique: TBFGaENKNbesjwwTv2IUcQ-1
Received: by mail-wm1-f70.google.com with SMTP id b20so260317wmj.1
        for <linux-acpi@vger.kernel.org>; Thu, 24 Sep 2020 14:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=g/Xbd+gOY1D7k7S7s+pOd/hTecpIxif1KV3RUcYn5rQ=;
        b=Md3ocDKDzCrseYkga5fOh8ceUqaBHTbUmENOLzEppb19Y/wi6ehpj5P9d+4hOdpvDu
         /3qq1CBIoH3f4c63MkAY95Z+hJrmY6sg27Z9MiC1/fBR1cMssBA5cBE0m02n75wH+d3V
         iCm+J0ltjaKE5/SxdOnmQ9Y+uem5uxnyIYMoXKmC2uWwLp3qkAq5Br2bp5G3aT24EScI
         4zeZJSthqI1Dw8UEzY/k7ngtMZFNCS6eDuZLt0avJ7gO8VctpvMucEgTdzSjYJ+MO5EP
         TTWdIL8ddacd3IthwaTF0T8r0+46VQFv0wC1JuM3LzsXhtzSRPDhMpbnhqCq7B3s4lXL
         UoxQ==
X-Gm-Message-State: AOAM532wJE/UZ5iqcXWffFTDXAX0nXnQpnq3l5XzaXtHyU2j/6B/D+KM
        6t10eZ3HGwlwBpWKMNN7IbEs5vkmY7Y4WB3SWU01ErhjZBvnTzKL7ASDieNj9sAkf4taIM1Amqg
        ydcy7JQwaw+rhKxY5/3B3IQ==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr1019732wrr.105.1600983703565;
        Thu, 24 Sep 2020 14:41:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcmOcMLK9ieZTe6UE9SIsXG/tKkkWvHxZX+em+xkUyTPxjCgMj7blLOZyUvF+KwveIZvdq7w==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr1019712wrr.105.1600983703320;
        Thu, 24 Sep 2020 14:41:43 -0700 (PDT)
Received: from localhost.localdomain (p4ff23f51.dip0.t-ipconnect.de. [79.242.63.81])
        by smtp.gmail.com with ESMTPSA id e13sm490886wre.60.2020.09.24.14.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 14:41:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 11/23] device-dax: Kill dax_kmem_res
Date:   Thu, 24 Sep 2020 23:41:41 +0200
Message-Id: <79BEC711-C769-432B-9A50-63C6A3AEB0E3@redhat.com>
References: <CAPcyv4iQ4VnXMU0+_7rfXwPowgcdoABSFUH4WO_3P9vHtWAzPg@mail.gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
In-Reply-To: <CAPcyv4iQ4VnXMU0+_7rfXwPowgcdoABSFUH4WO_3P9vHtWAzPg@mail.gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: iPhone Mail (18A373)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> Am 24.09.2020 um 23:26 schrieb Dan Williams <dan.j.williams@intel.com>:
>=20
> =EF=BB=BF[..]
>>> I'm not suggesting to busy the whole "virtio" range, just the portion
>>> that's about to be passed to add_memory_driver_managed().
>>=20
>> I'm afraid I don't get your point. For virtio-mem:
>>=20
>> Before:
>>=20
>> 1. Create virtio0 container resource
>>=20
>> 2. (somewhen in the future) add_memory_driver_managed()
>> - Create resource (System RAM (virtio_mem)), marking it busy/driver
>>   managed
>>=20
>> After:
>>=20
>> 1. Create virtio0 container resource
>>=20
>> 2. (somewhen in the future) Create resource (System RAM (virtio_mem)),
>>   marking it busy/driver managed
>> 3. add_memory_driver_managed()
>>=20
>> Not helpful or simpler IMHO.
>=20
> The concern I'm trying to address is the theoretical race window and
> layering violation in this sequence in the kmem driver:
>=20
> 1/ res =3D request_mem_region(...);
> 2/ res->flags =3D IORESOURCE_MEM;
> 3/ add_memory_driver_managed();
>=20
> Between 2/ and 3/ something can race and think that it owns the
> region. Do I think it will happen in practice, no, but it's still a
> pattern that deserves come cleanup.

I think in that unlikely event (rather impossible), add_memory_driver_manage=
d() should fail, detecting a conflicting (busy) resource. Not sure what will=
 happen next ( and did not double-check).

But yeah, the way the BUSY bit is cleared here is wrong - simply overwriting=
 other bits. And it would be even better if we could avoid manually messing w=
ith flags here.
>=20

