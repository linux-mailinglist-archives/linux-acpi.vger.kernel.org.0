Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9994341C43D
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Sep 2021 14:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343677AbhI2MDu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 29 Sep 2021 08:03:50 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:45788 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343879AbhI2MDe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Sep 2021 08:03:34 -0400
Received: by mail-oi1-f182.google.com with SMTP id v10so2528900oic.12;
        Wed, 29 Sep 2021 05:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DPTFjBNMYZsH/LoF0h0iC/ghN40ymuV4zkUVlZxxnn4=;
        b=nFsj8U7fsXNHpID73JvNvKeoev19i8s8Qc6aNmtgTy4h1ZJ12fo5OJUqFMeydby5q0
         r3XQ7gk6BdmgTayJGmj3OyjutX1cSdGR/9YXDA5f17ybkj5kFXCPQPkLWTw3rYB6rv3Y
         iNFiyBdnY3VeTOtAgRQ7En8pQ9R7A2VaJgosggcZ6kwzxei42AbsyRBPJNyRx9EBLpV6
         YMmTzSIANmULQNsnM/KuSRWkBxSyF2qaoWJkbXbvJ1YYHqBsPwA38xxUGPCy/yinc9dX
         0pzHmsuW3qvFMDCjRoUazXbzN70F9YgiBNkZUJtlQCrG4yUG3a+uT8RfHJTNi9GdXIoy
         h+0Q==
X-Gm-Message-State: AOAM53072xOp1CuP/KX0hGBdNG+WNiiKjgOCXHTI4QRyyIjuOYC8iu8h
        tPxUw9OvakhznHTsJjBA5Db86C9UKnZNLZfnqHMy1GKc
X-Google-Smtp-Source: ABdhPJxoNw5TPiy7tXyGhRFCBqyoslPg2WsTrtX+8FsVJTpHKJufbkxvO43p83wgr2KyAiyOScD/EBdm7rFq04tgduc=
X-Received: by 2002:a05:6808:178c:: with SMTP id bg12mr8017044oib.157.1632916913639;
 Wed, 29 Sep 2021 05:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210927121338.938994-1-arnd@kernel.org> <92b02547-3aa5-537f-a782-7a25854d88fe@intel.com>
 <BYAPR11MB32560CEAC6CC3C2E93FBBF9387A89@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB32560CEAC6CC3C2E93FBBF9387A89@BYAPR11MB3256.namprd11.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Sep 2021 14:01:41 +0200
Message-ID: <CAJZ5v0gHgMVjKzKUnJ0HkE+Bz7-1Rav3FnLA+ycF94JTw5V=ww@mail.gmail.com>
Subject: Re: [PATCH] ACPI: avoid NULL pointer arithmetic
To:     "Moore, Robert" <robert.moore@intel.com>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 28, 2021 at 10:39 PM Moore, Robert <robert.moore@intel.com> wrote:
>
> I can take this patch as-is, I think. I'll try for the next acpica release later this week.

Thanks!


> -----Original Message-----
> From: Wysocki, Rafael J <rafael.j.wysocki@intel.com>
> Sent: Tuesday, September 28, 2021 10:44 AM
> To: Arnd Bergmann <arnd@kernel.org>; Moore, Robert <robert.moore@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; Nathan Chancellor <nathan@kernel.org>; Nick Desaulniers <ndesaulniers@google.com>; Erik Kaneda <erik.kaneda@intel.com>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org; llvm@lists.linux.dev; Len Brown <lenb@kernel.org>; Rafael J. Wysocki <rafael@kernel.org>
> Subject: Re: [PATCH] ACPI: avoid NULL pointer arithmetic
>
> Bob, this is ACPICA material.
>
> Would it be possible to apply this to the upstream from the patch or do you need  a PR for this?
>
> On 9/27/2021 2:13 PM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > There are some very old macros for doing an open-coded offsetof() and
> > cast between pointer and integer in ACPI headers. clang-14 now
> > complains about these:
> >
> > drivers/acpi/acpica/tbfadt.c:86:3: error: performing pointer subtraction with a null pointer has undefined behavior [-Werror,-Wnull-pointer-subtraction]
> >           ACPI_FADT_OFFSET(pm_timer_block),
> >           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/acpi/actbl.h:376:47: note: expanded from macro 'ACPI_FADT_OFFSET'
> >   #define ACPI_FADT_OFFSET(f)             (u16) ACPI_OFFSET (struct acpi_table_fadt, f)
> >
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/acpi/actypes.h:511:41: note: expanded from macro 'ACPI_OFFSET'
> >   #define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
> >
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/acpi/actypes.h:505:79: note: expanded from macro 'ACPI_PTR_DIFF'
> >   #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8, (a)) - ACPI_CAST_PTR (u8, (b))))
> >
> > ^ ~~~~~~~~~~~~~~~~~~~~~~~ Convert them to the modern equivalents.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >   include/acpi/actypes.h | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index
> > 92c71dfce0d5..285bc7b73de3 100644
> > --- a/include/acpi/actypes.h
> > +++ b/include/acpi/actypes.h
> > @@ -507,8 +507,8 @@ typedef u64 acpi_integer;
> >   /* Pointer/Integer type conversions */
> >
> >   #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size) (i))
> > -#define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
> > -#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
> > +#define ACPI_TO_INTEGER(p)              ((uintptr_t)(p))
> > +#define ACPI_OFFSET(d, f)               offsetof(d, f)
> >   #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
> >   #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
> >
>
>
