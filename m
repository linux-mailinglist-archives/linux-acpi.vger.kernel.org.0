Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 544AC72113
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jul 2019 22:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbfGWUty convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 23 Jul 2019 16:49:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:40768 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730760AbfGWUty (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Jul 2019 16:49:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 13:49:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,300,1559545200"; 
   d="scan'208";a="174659991"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga006.jf.intel.com with ESMTP; 23 Jul 2019 13:49:53 -0700
Received: from orsmsx126.amr.corp.intel.com (10.22.240.126) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 23 Jul 2019 13:49:53 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.211]) by
 ORSMSX126.amr.corp.intel.com ([169.254.4.77]) with mapi id 14.03.0439.000;
 Tue, 23 Jul 2019 13:49:53 -0700
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Qian Cai <cai@lca.pw>, Nick Desaulniers <ndesaulniers@google.com>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "jkim@freebsd.org" <jkim@freebsd.org>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] acpica: fix -Wnull-pointer-arithmetic warnings
Thread-Topic: [PATCH] acpica: fix -Wnull-pointer-arithmetic warnings
Thread-Index: AQHVPFEYIycQ0k5IUUyXy4NqYzTqpqbP0wgAgAAvDoCACLPGAA==
Date:   Tue, 23 Jul 2019 20:49:52 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B9661869@ORSMSX110.amr.corp.intel.com>
References: <20190717033807.1207-1-cai@lca.pw>
 <CAKwvOdmPX2DsUawcA0SzaFacjz==ACcfD8yDsbaS4eP4Es=Wzw@mail.gmail.com>
 <73A4565B-837B-4E13-8B72-63F69BF408E7@lca.pw>
In-Reply-To: <73A4565B-837B-4E13-8B72-63F69BF408E7@lca.pw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWEwZGI5NTgtYTE0NC00ZWFjLWJjMDYtYjIyYWY5MmFhOTQ1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiY2pvUjE2Mm1qbUl2ejllMmdwQVwvejNWcEJib1RyQ2JUb2Q3R2dnRk14VXo0QVhuUUMrdjJmZUtiSjhJM2dTVTIifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



-----Original Message-----
From: Qian Cai [mailto:cai@lca.pw] 
Sent: Wednesday, July 17, 2019 5:50 PM
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Moore, Robert <robert.moore@intel.com>; Schmauss, Erik <erik.schmauss@intel.com>; jkim@freebsd.org; Len Brown <lenb@kernel.org>; linux-acpi@vger.kernel.org; devel@acpica.org; clang-built-linux <clang-built-linux@googlegroups.com>; LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] acpica: fix -Wnull-pointer-arithmetic warnings



> On Jul 17, 2019, at 6:01 PM, Nick Desaulniers <ndesaulniers@google.com> wrote:
> 
> On Tue, Jul 16, 2019 at 8:38 PM Qian Cai <cai@lca.pw> wrote:
>> 
>> Clang generate quite a few of those warnings.
>> 
>> drivers/acpi/scan.c:759:28: warning: arithmetic on a null pointer 
>> treated as a cast from integer to pointer is a GNU extension 
>> [-Wnull-pointer-arithmetic]
>>                status = acpi_get_handle(ACPI_ROOT_OBJECT,
>> obj->string.pointer,
>>                                         ^~~~~~~~~~~~~~~~
>> ./include/acpi/actypes.h:458:56: note: expanded from macro 
>> 'ACPI_ROOT_OBJECT'
>> #define ACPI_ROOT_OBJECT                ((acpi_handle) ACPI_TO_POINTER
>> (ACPI_MAX_PTR))
>>                                                        
>> ^~~~~~~~~~~~~~~
>> ./include/acpi/actypes.h:509:41: note: expanded from macro 
>> 'ACPI_TO_POINTER'
>> #define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) 0,
>> (acpi_size) (i))
>>                                         
>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./include/acpi/actypes.h:503:84: note: expanded from macro 
>> 'ACPI_ADD_PTR'
>> #define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t,
>> (ACPI_CAST_PTR (u8, (a)) + (acpi_size)(b)))
>>                                         ^~~~~~~~~~~~~~~~~
>> ./include/acpi/actypes.h:501:66: note: expanded from macro 
>> 'ACPI_CAST_PTR'
>> #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
>>                                                                  ^ 
>> This is because pointer arithmetic on a pointer not pointing to an 
>> array is an undefined behavior. Fix it by doing an integer arithmetic 
>> instead.
> 
> Hi Qian, thanks for the patch.  How do I reproduce this issue, 
> precisely?  I just tried:
> $ make CC=clang -j71 drivers/acpi/scan.o on linux-next today and don't 
> observe the warning.  My clang is ToT built sometime this week.  It 
> looks like drivers/acpi/scan.o when CONFIG_ACPI=y, which is set in the 
> defconfig.  Is there another set of configs to enable to observe the 
> warning?

# make W=1 -j 256

With the config,

https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config 

> 
> Also, the fix is curious.  Arithmetic on pointers to different 
> "objects" (with one element passed the end) may lead to provence 
> issues due to undefined behavior, but I would have expected some cases 
> to uintptr_t, then arithmetic on that type, as the solution (which is 
> what I suspect ACPI_CAST_PTR is doing).
> 
> Further, you seem to have modified ACPI_ADD_PTR but not ACPI_SUB_PTR; 
> I would have expected both to be afflicted together or not at all 
> based on their existing implementations.

Yes, I thought about that, but ACPI_SUB_PTR does not seem used anywhere, so I thought maybe just start a new discussion to remove it all together later.

ACPI_SUB_PTR is used in the iasl data table compiler.


> 
>> 
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>> include/acpi/actypes.h | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index 
>> ad6892a24015..25b4a32da177 100644
>> --- a/include/acpi/actypes.h
>> +++ b/include/acpi/actypes.h
>> @@ -500,13 +500,13 @@ typedef u64 acpi_integer;
>> 
>> #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
>> #define ACPI_CAST_INDIRECT_PTR(t, p)    ((t **) (acpi_uintptr_t) (p))
>> -#define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PTR (u8, (a)) + (acpi_size)(b)))
>> +#define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t, (a) + (acpi_size)(b))

We have some questions concerning this change. If (a) is not cast to a u8, the addition will be in whatever units are appropriate for (a) i.e., the type of (a). However, we want ACPI_ADD_PTR (And ACPI_SUB_PTR) to simply perform a byte addition or subtraction - thus the cast to u8. I believe that is the original thinking behind the macros.

>> #define ACPI_SUB_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PTR (u8, (a)) - (acpi_size)(b)))
>> #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8, (a)) - ACPI_CAST_PTR (u8, (b))))
>> 
>> /* Pointer/Integer type conversions */
>> 
>> -#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) 0, (acpi_size) (i))
>> +#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, 0, (acpi_size) (i))
> 
> IIUC, these are adding `i` to NULL (or (void*)0)? X + 0 == X ?
> --
> Thanks,
> ~Nick Desaulniers

