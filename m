Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12BD24E2FF
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Aug 2020 00:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHUWHy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Aug 2020 18:07:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21425 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726641AbgHUWHx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Aug 2020 18:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598047668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6/wi0Nw+OScWqjXUa7deT7et3gd07Go77zu0NJl9auw=;
        b=MYsbjoCfKxYBrBIEcPdxD/va7d/RYaj+d8dqRP+nWwLbfibxlme1jFrhSEUy+N78oIvECu
        xoshhUuptQT7npNuMrILO80V2Iao74OQeMYAJZdjZJUCbzjfNZTvwGpcjAlVIYn8gXor3r
        yq0wPEv6VYjcRMMzDLqgfvPUn3aKWe8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-rkM6V3_AMQOPGGb1SSG_bg-1; Fri, 21 Aug 2020 18:07:47 -0400
X-MC-Unique: rkM6V3_AMQOPGGb1SSG_bg-1
Received: by mail-ej1-f72.google.com with SMTP id a19so1271593ejs.12
        for <linux-acpi@vger.kernel.org>; Fri, 21 Aug 2020 15:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=6/wi0Nw+OScWqjXUa7deT7et3gd07Go77zu0NJl9auw=;
        b=cAR+qQmytOnniju0nonP4Z7HmTyr+Bklf46OnYOpeDJ4OsqvdyGlMrF/Oj4HJ64axo
         8bL+LUk5EUuNvWPGWRGlNH9GvrIXixHC+6eGDW7VgPv3HSej0BmTjvuyT6pBcU9a9VQL
         vrQgaWYpUuELk0BwkakkVMJ78TgbzuGhGXpjsRze4yNkaXf0GehF7ZwkBXPs03ZdepIW
         FAODTaQkitxjg8M4WjlDN2mVh8eEr6z49retDMQhJUqE4ilsJk3eFSHga5pXGbTljXDP
         IbA0giDKkb+CaBWrCmabKZYJRMFufTxETjeSA0upEXZxu5WFtES+GrXd22UfazUjh0qh
         iwhQ==
X-Gm-Message-State: AOAM530HdCX+2IP39OKlz+1bEXaDEXKUEC1+2hBRgbipZgXiLq9k6EuX
        CeySuctKtG7ML/Cf9eEjws2lOJAATCSBDCZBPaLZXqoYK/gvxuD381OzsQE6YLoz/tABymLOFsl
        PK2ZZsu4AWu2PAaWqo6eHIA==
X-Received: by 2002:a17:906:6d91:: with SMTP id h17mr4593051ejt.531.1598047665749;
        Fri, 21 Aug 2020 15:07:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2fGCDlUrSC0ozVrUImslz75nvdXz6gshUl15sF6TxX4V9+R9BHsd6i/JypP0Cf8+w6d3+oA==
X-Received: by 2002:a17:906:6d91:: with SMTP id h17mr4593016ejt.531.1598047665540;
        Fri, 21 Aug 2020 15:07:45 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c6231.dip0.t-ipconnect.de. [91.12.98.49])
        by smtp.gmail.com with ESMTPSA id n10sm1810467edo.43.2020.08.21.15.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 15:07:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 00/23] device-dax: Support sub-dividing soft-reserved ranges
Date:   Fri, 21 Aug 2020 23:42:49 +0200
Message-Id: <1FB395E7-633D-4F3E-82F5-12E2FDAF33EC@redhat.com>
References: <646DDE9B-90C2-493A-958C-90EFA1CCA475@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jason Gunthorpe <jgg@mellanox.com>, Jia He <justin.he@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Jeff Moyer <jmoyer@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
In-Reply-To: <646DDE9B-90C2-493A-958C-90EFA1CCA475@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: iPhone Mail (17G68)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> Am 21.08.2020 um 23:34 schrieb David Hildenbrand <david@redhat.com>:
>=20
> =EF=BB=BF
>=20
>>> Am 21.08.2020 um 23:17 schrieb Dan Williams <dan.j.williams@intel.com>:
>>>=20
>>> =EF=BB=BFOn Fri, Aug 21, 2020 at 11:30 AM David Hildenbrand <david@redha=
t.com> wrote:
>>>=20
>>>> On 21.08.20 20:27, Dan Williams wrote:
>>>> On Fri, Aug 21, 2020 at 3:15 AM David Hildenbrand <david@redhat.com> wr=
ote:
>>>>>=20
>>>>>>>=20
>>>>>>> 1. On x86-64, e820 indicates "soft-reserved" memory. This memory is n=
ot
>>>>>>> automatically used in the buddy during boot, but remains untouched
>>>>>>> (similar to pmem). But as it involves ACPI as well, it could also be=

>>>>>>> used on arm64 (-e820), correct?
>>>>>>=20
>>>>>> Correct, arm64 also gets the EFI support for enumerating memory this
>>>>>> way. However, I would clarify that whether soft-reserved is given to
>>>>>> the buddy allocator by default or not is the kernel's policy choice,
>>>>>> "buddy-by-default" is ok and is what will happen anyways with older
>>>>>> kernels on platforms that enumerate a memory range this way.
>>>>>=20
>>>>> Is "soft-reserved" then the right terminology for that? It sounds very=

>>>>> x86-64/e820 specific. Maybe a compressed for of "performance
>>>>> differentiated memory" might be a better fit to expose to user space, n=
o?
>>>>=20
>>>> No. The EFI "Specific Purpose" bit is an attribute independent of
>>>> e820, it's x86-Linux that entangles those together. There is no
>>>> requirement for platform firmware to use that designation even for
>>>> drastic performance differentiation between ranges, and conversely
>>>> there is no requirement that memory *with* that designation has any
>>>> performance difference compared to the default memory pool. So it
>>>> really is a reservation policy about a memory range to keep out of the
>>>> buddy allocator by default.
>>>=20
>>> Okay, still "soft-reserved" is x86-64 specific, no?
>>=20
>> There's nothing preventing other EFI archs, or a similar designation
>> in another firmware spec, picking up this policy.
>>=20
>>> (AFAIK,
>>> "soft-reserved" will be visible in /proc/iomem, or am I confusing
>>> stuff?)
>>=20
>> No, you're correct.
>>=20
>>> IOW, it "performance differentiated" is not universally
>>> applicable, maybe  "specific purpose memory" is ?
>>=20
>> Those bikeshed colors don't seem an improvement to me.
>>=20
>> "Soft-reserved" actually tells you something about the kernel policy
>> for the memory. The criticism of "specific purpose" that led to
>> calling it "soft-reserved" in Linux is the fact that "specific" is
>> undefined as far as the firmware knows, and "specific" may have
>> different applications based on the platform user. "Soft-reserved"
>> like "Reserved" tells you that a driver policy might be in play for
>> that memory.
>>=20
>> Also note that the current color of the bikeshed has already shipped sinc=
e v5.5:
>>=20
>>  262b45ae3ab4 x86/efi: EFI soft reservation to E820 enumeration
>>=20
>=20
> I was asking because I was struggling to even understand what =E2=80=9Esof=
t-reserved=E2=80=9C is and I could bet most people have no clue what that is=
 supposed to be.
>=20
> In contrast =E2=80=9Epersistent memory=E2=80=9C or =E2=80=9Especial purpos=
e memory=E2=80=9C in /proc/iomem is something normal (Linux using) human bei=
ngs can understand.

s/normal/most/ of course :)=

