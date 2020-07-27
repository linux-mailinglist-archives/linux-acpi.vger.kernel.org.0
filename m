Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D1322FC52
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jul 2020 00:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgG0Wkr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jul 2020 18:40:47 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.250]:33745 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727782AbgG0Wkp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Jul 2020 18:40:45 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 484D915738D
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2020 17:17:26 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 0BR0kB4oqBb5d0BR0krKDI; Mon, 27 Jul 2020 17:17:26 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eje+5+4yl5uoO2TllTHrOYESh/jzim1iBsJeaOtDBv8=; b=YWcHLey6OIExHHdL2vELVzvvQT
        eWU73yzEe9J9GFuraOkoX+wyZ3SatQ/vqBcT7F5rYb4euWCm7ZEtuTNbljm2tAZW6vF5UoglvcsQn
        QdnKj6Yhxo4aD+nuVwhQllOsRHFTX2ky9Fl0mN91MEHAvtagScQ4AFgqy7Z53BP5yjtNybu6QzcsD
        PqU9icZBWmDHWmgbrrCAv33e8QXK1NQBLfhXlbBnZLhW05vJUqQ3MTxfSXPJYdy1J23Ogw1Z+7Akg
        BSKLkYXTo9sz3NEZ2C0tkxQUygy35dCSAhf9yJlXyWwm0QUiWpuTtYeY41/btdliuF7hV5wFUvW6H
        FkQOAM3Q==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:44956 helo=[192.168.15.2])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1k0BR0-000mMB-0e; Mon, 27 Jul 2020 17:17:26 -0500
Subject: Re: [PATCH][next] ACPICA: Use fallthrough pseudo-keyword
To:     "Moore, Robert" <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200707200716.GA4920@embeddedor>
 <CAJZ5v0iDz_EsrpdMQQDfaVC2orMQkEcubmR6-J6mvtrXmKXbRg@mail.gmail.com>
 <BYAPR11MB325602EDA2D2ACC2B28EAF4687670@BYAPR11MB3256.namprd11.prod.outlook.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 AP7RWS474w==
Message-ID: <b851b2c8-2d7c-939d-507d-b322dd4a0dbf@embeddedor.com>
Date:   Mon, 27 Jul 2020 17:23:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB325602EDA2D2ACC2B28EAF4687670@BYAPR11MB3256.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1k0BR0-000mMB-0e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.2]) [187.162.31.110]:44956
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,


This is a macro pseudo-keyword, which expands to /* fallthrough */
for compilers that don't support the attribute __fallthrough__. See:

include/linux/compiler_attributes.h:213:
213 #if __has_attribute(__fallthrough__)
214 # define fallthrough                    __attribute__((__fallthrough__))
215 #else
216 # define fallthrough                    do {} while (0)  /* fallthrough */
217 #endif

So, any compiler (older or new) will be fine with it.

Thanks
--
Gustavo

On 7/8/20 09:17, Moore, Robert wrote:
> It looks like this attribute is not supported by msvc 2017 (and perhaps other compilers) -- it is apparently a GCC extension -- meaning that it cannot be used in the ACPICA compiler-independent code.
> 
> Bob
> 
> 
> -----Original Message-----
> From: Rafael J. Wysocki <rafael@kernel.org> 
> Sent: Wednesday, July 08, 2020 3:59 AM
> To: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>; ACPI Devel Maling List <linux-acpi@vger.kernel.org>; open list:ACPI COMPONENT ARCHITECTURE (ACPICA) <devel@acpica.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH][next] ACPICA: Use fallthrough pseudo-keyword
> 
> On Tue, Jul 7, 2020 at 10:01 PM Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
>>
>> Replace the existing /* fall through */ comments and its variants with 
>> the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary 
>> fall-through markings when it is the case.
>>
>> [1] 
>> https://www.kernel.org/doc/html/latest/process/deprecated.html?highlig
>> ht=fallthrough#implicit-switch-case-fall-through
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> I need to talk to Erik and Bob about this one.
> 
>> ---
>>  drivers/acpi/acpica/dscontrol.c |    2 +-
>>  drivers/acpi/acpica/dswexec.c   |    3 +--
>>  drivers/acpi/acpica/dswload.c   |    2 +-
>>  drivers/acpi/acpica/dswload2.c  |    4 +---
>>  drivers/acpi/acpica/exfldio.c   |    2 +-
>>  drivers/acpi/acpica/exresop.c   |    4 ++--
>>  drivers/acpi/acpica/exstore.c   |    4 ++--
>>  drivers/acpi/acpica/hwgpe.c     |    3 +--
>>  drivers/acpi/acpica/utdelete.c  |    3 +--
>>  drivers/acpi/acpica/utprint.c   |    2 +-
>>  10 files changed, 12 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/dscontrol.c 
>> b/drivers/acpi/acpica/dscontrol.c index 4b5b6e859f62..134d53380663 
>> 100644
>> --- a/drivers/acpi/acpica/dscontrol.c
>> +++ b/drivers/acpi/acpica/dscontrol.c
>> @@ -62,7 +62,7 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
>>                         }
>>                 }
>>
>> -               /*lint -fallthrough */
>> +               fallthrough;
>>
>>         case AML_IF_OP:
>>                 /*
>> diff --git a/drivers/acpi/acpica/dswexec.c 
>> b/drivers/acpi/acpica/dswexec.c index 1d4f8c81028c..41f6cb61778a 
>> 100644
>> --- a/drivers/acpi/acpica/dswexec.c
>> +++ b/drivers/acpi/acpica/dswexec.c
>> @@ -598,8 +598,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
>>                                         break;
>>                                 }
>>
>> -                               /* Fall through */
>> -                               /*lint -fallthrough */
>> +                               fallthrough;
>>
>>                         case AML_INT_EVAL_SUBTREE_OP:
>>
>> diff --git a/drivers/acpi/acpica/dswload.c 
>> b/drivers/acpi/acpica/dswload.c index 27069325b6de..1d8789869dda 
>> 100644
>> --- a/drivers/acpi/acpica/dswload.c
>> +++ b/drivers/acpi/acpica/dswload.c
>> @@ -224,7 +224,7 @@ acpi_ds_load1_begin_op(struct acpi_walk_state *walk_state,
>>                                 break;
>>                         }
>>
>> -                       /*lint -fallthrough */
>> +                       fallthrough;
>>
>>                 default:
>>
>> diff --git a/drivers/acpi/acpica/dswload2.c 
>> b/drivers/acpi/acpica/dswload2.c index edadbe146506..de367e8e4cf4 
>> 100644
>> --- a/drivers/acpi/acpica/dswload2.c
>> +++ b/drivers/acpi/acpica/dswload2.c
>> @@ -213,9 +213,7 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
>>                              parse_flags & ACPI_PARSE_MODULE_LEVEL)) {
>>                                 break;
>>                         }
>> -
>> -                       /*lint -fallthrough */
>> -
>> +                       fallthrough;
>>                 default:
>>
>>                         /* All other types are an error */ diff --git 
>> a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c index 
>> ade35ff1c7ba..677ba3ab1482 100644
>> --- a/drivers/acpi/acpica/exfldio.c
>> +++ b/drivers/acpi/acpica/exfldio.c
>> @@ -434,7 +434,7 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
>>                  * region_field case and write the datum to the Operation Region
>>                  */
>>
>> -               /*lint -fallthrough */
>> +               fallthrough;
>>
>>         case ACPI_TYPE_LOCAL_REGION_FIELD:
>>                 /*
>> diff --git a/drivers/acpi/acpica/exresop.c 
>> b/drivers/acpi/acpica/exresop.c index 4d1b22971d58..7c8676adcf43 
>> 100644
>> --- a/drivers/acpi/acpica/exresop.c
>> +++ b/drivers/acpi/acpica/exresop.c
>> @@ -198,7 +198,7 @@ acpi_ex_resolve_operands(u16 opcode,
>>
>>                                         target_op = AML_DEBUG_OP;
>>
>> -                                       /*lint -fallthrough */
>> +                                       fallthrough;
>>
>>                                 case ACPI_REFCLASS_ARG:
>>                                 case ACPI_REFCLASS_LOCAL:
>> @@ -264,7 +264,7 @@ acpi_ex_resolve_operands(u16 opcode,
>>                          * Else not a string - fall through to the normal Reference
>>                          * case below
>>                          */
>> -                       /*lint -fallthrough */
>> +                       fallthrough;
>>
>>                 case ARGI_REFERENCE:    /* References: */
>>                 case ARGI_INTEGER_REF:
>> diff --git a/drivers/acpi/acpica/exstore.c 
>> b/drivers/acpi/acpica/exstore.c index 3adc0a29d890..fcf8dff56c5b 
>> 100644
>> --- a/drivers/acpi/acpica/exstore.c
>> +++ b/drivers/acpi/acpica/exstore.c
>> @@ -96,7 +96,7 @@ acpi_ex_store(union acpi_operand_object *source_desc,
>>                         return_ACPI_STATUS(AE_OK);
>>                 }
>>
>> -               /*lint -fallthrough */
>> +               fallthrough;
>>
>>         default:
>>
>> @@ -422,7 +422,7 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
>>                                 break;
>>                         }
>>
>> -                       /* Fallthrough */
>> +                       fallthrough;
>>
>>                 case ACPI_TYPE_DEVICE:
>>                 case ACPI_TYPE_EVENT:
>> diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c 
>> index 49c46d4dd070..19d574f64c78 100644
>> --- a/drivers/acpi/acpica/hwgpe.c
>> +++ b/drivers/acpi/acpica/hwgpe.c
>> @@ -95,8 +95,7 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action)
>>                 if (!(register_bit & gpe_register_info->enable_mask)) {
>>                         return (AE_BAD_PARAMETER);
>>                 }
>> -
>> -               /*lint -fallthrough */
>> +               fallthrough;
>>
>>         case ACPI_GPE_ENABLE:
>>
>> diff --git a/drivers/acpi/acpica/utdelete.c 
>> b/drivers/acpi/acpica/utdelete.c index c365faf4e6cd..6db09eb9d257 
>> 100644
>> --- a/drivers/acpi/acpica/utdelete.c
>> +++ b/drivers/acpi/acpica/utdelete.c
>> @@ -111,8 +111,7 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
>>                         (void)acpi_ev_delete_gpe_block(object->device.
>>                                                        gpe_block);
>>                 }
>> -
>> -               /*lint -fallthrough */
>> +               fallthrough;
>>
>>         case ACPI_TYPE_PROCESSOR:
>>         case ACPI_TYPE_THERMAL:
>> diff --git a/drivers/acpi/acpica/utprint.c 
>> b/drivers/acpi/acpica/utprint.c index 681c11f4af4e..f7e43baf5ff2 
>> 100644
>> --- a/drivers/acpi/acpica/utprint.c
>> +++ b/drivers/acpi/acpica/utprint.c
>> @@ -475,7 +475,7 @@ int vsnprintf(char *string, acpi_size size, const char *format, va_list args)
>>                 case 'X':
>>
>>                         type |= ACPI_FORMAT_UPPER;
>> -                       /* FALLTHROUGH */
>> +                       fallthrough;
>>
>>                 case 'x':
>>
>>
