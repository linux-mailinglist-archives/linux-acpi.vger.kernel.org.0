Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1C211E64A
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 16:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfLMPP1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 10:15:27 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:41266 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbfLMPP1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Dec 2019 10:15:27 -0500
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Dec 2019 10:15:26 EST
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 9B4458ADA1;
        Fri, 13 Dec 2019 15:05:23 +0000 (UTC)
        (envelope-from jkim@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 47ZDVq2sSMz47Ds;
        Fri, 13 Dec 2019 15:05:23 +0000 (UTC)
        (envelope-from jkim@FreeBSD.org)
Received: from freefall.freebsd.org (static-71-168-218-4.cmdnnj.fios.verizon.net [71.168.218.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: jkim/mail)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 8C0BD2F43C;
        Fri, 13 Dec 2019 15:05:22 +0000 (UTC)
        (envelope-from jkim@FreeBSD.org)
Subject: Re: [Devel] Re: [PATCH] ACPICA: Fix compilation with bare-metal
 toolchian
To:     "Moore, Robert" <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Kaneda, Erik" <erik.kaneda@intel.com>
Cc:     "Laster K." <officiallazerl0rd@gmail.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
References: <CAMhj-NcA8J8rD1PC6mH+HAjBdv2H532UB5aB5-0Y6VWtUh=8-g@mail.gmail.com>
 <2847939.QcJ3fIVZhg@kreacher>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B96BFE2C@ORSMSX110.amr.corp.intel.com>
From:   Jung-uk Kim <jkim@FreeBSD.org>
Autocrypt: addr=jkim@FreeBSD.org; prefer-encrypt=mutual; keydata=
 mQENBFJBztUBCAChqNyGqmFuNo0U7MBzsD+q/G6Cv0l7LGVrOAsgh34M8wIWhD+tztDWMVfn
 AhxNDd0ceCj2bYOe67sTQxAScEcbt2FfvPOLp9MEXb9qohZj172Gwkk7dnhOhZZKhVGVZKM4
 NcsuBDUzgf4f3Vdzj4wg6WlqplnTZo8lPE4hZWvZHoFIyunPTJWenybeV1xnxK7JkUdSvQR0
 fA59RfTTECMwTrSEfYGUnxIDBraxJ7Ecs/0hGQ7sljIj8WBvlRDU5fU1xfF35aw56T8POQRq
 F4E6RVJW3YGuTpSwgtGZOTfygcLRhAiq3dFC3JNLaTVTpM8PjOinJyt9AU6RoITGOKwDABEB
 AAG0Hkp1bmctdWsgS2ltIDxqa2ltQEZyZWVCU0Qub3JnPokBPQQTAQoAJwUCUkHO1QIbAwUJ
 E0/POwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRB8n5Ym/NvxRqyzB/wL7QtsIpeGfGIA
 ZPMtgXMucM3NWzomyQMln2j2efUkDKthzh9jBxgF53TjOr7imwIt0PT2k1bqctPrq5IRqnu9
 mGroqaCLE3LG2/E3jEaao4k9PO6efwlioyivUo5NrqIQOQ4k3EAXw7d2y0Dk1VpTgdMrnUAB
 hj7lGlLqS4ydcrf24DdbCRGdEQwqd9DBeBgbWynxAJMgbZBhYVEyIHuQKkJ8qY0ibIPXXuF0
 KYDeH0qUHtWV2K3srNyPtymUkBQD84Pl1GWRYx05XdUHDmnX0JV3lg0BfYJZgZv0ehPQrMfY
 Fd9abTkf9FHQYz1JtsC8wUuRgqElRd6+YAGf8Tt9uQENBFJBztUBCADLtSrP44El2VoJmH14
 OFrlOgxzZnbn+Y/Gf1k12mJBiR+A+pBeRLD50p7AiTrjHRxO3cHcl9Dh0uf1VSbXgp8Or0ye
 iP/86fZPd4k5HXNmDTLL0HecPE08SCqGZ0W8vllQrokB1QxxRUB+fFMPJyMCjDAZ7P9fFTOS
 dTw1bJSTtOD8Sx8MpZUa9ti06bXFlVYDlaqSdgk181SSx+ZbSKkQR8CIMARlHwiLsa3Z9q9O
 EJr20HPyxe0AlTvwvFndH61hg7ds63eRvglwRnNON28VXO/lvKXq7Br/CiiyhFdKfINIx2Z5
 htYq22tgGTW7mBURbIKoECFBTX9Lv6BXz6w9ABEBAAGJASUEGAEKAA8FAlJBztUCGwwFCRNP
 zzsACgkQfJ+WJvzb8UZcJQf+IsTCxUEqY7W/pT84sMg5/QD3s6ufTRncvq14fEOxCNq1Rf4Q
 9P+tOFa8GZfKDGB2BFGIrW7uT5mlmKdK1vO6ZIA930y5kUsnCmBUEBJkE2ciSQk01aB/1o62
 Q3Gk/F6BwtNY9OXiqF7AcAo+K/BMIaqb26QKeh+IIgK1NN9dQiq3ByTbl4zpGZa6MmsnnRTu
 mzGKt2nkz7vBzH6+hZp1OzGZikgjjhYWVFoJo1dvf/rv4obs0ZJEqFPQs/1Qa1dbkKBv6odB
 XJpPH0ssOluTY24d1XxTiKTwmWvHeQkOKRAIfD7VTtF4TesoZYkf7hsh3e3VwXhptSLFnEOi
 WwYofg==
Message-ID: <8ee4ecbe-f451-112e-677a-87a4d73ccdfc@FreeBSD.org>
Date:   Fri, 13 Dec 2019 10:05:21 -0500
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96BFE2C@ORSMSX110.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 19. 12. 12., Moore, Robert wrote:
>> -----Original Message-----
>> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
>> Sent: Friday, July 5, 2019 2:44 AM
>> To: Moore, Robert <robert.moore@intel.com>; Schmauss, Erik
>> <erik.schmauss@intel.com>
>> Cc: Laster K. <officiallazerl0rd@gmail.com>; Wysocki, Rafael J
>> <rafael.j.wysocki@intel.com>; lenb@kernel.org; linux-
>> acpi@vger.kernel.org; devel@acpica.org
>> Subject: Re: [PATCH] ACPICA: Fix compilation with bare-metal toolchian
>>
>> On Saturday, June 22, 2019 11:03:54 PM CEST Laster K. wrote:
>>> An ifdef expects to be compiled with full-fledged Linux toolchain, but
>>> it's common to compile kernel with just bare-metal toolchain which
>>> doesn't define __linux__. So, also add __KERNEL__ check.
>>>
> [Moore, Robert] 
> This sounds OK, as long as no other supported hosts define __KERNEL__.

FreeBSD defines _KERNEL for kernel source.

JK

>>> Signed-off-by: Laster K. (lazerl0rd) <officiallazerl0rd@gmail.com>
>>> ---
>>> Apologies for the multiple/spammed e-mails, I was having mail client
>> issues.
>>>
>>>  include/acpi/platform/acenv.h   | 2 +-
>>>  include/acpi/platform/acenvex.h | 2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/acpi/platform/acenv.h
>>> b/include/acpi/platform/acenv.h index 35ab3f87cc29..b69319198cb8
>>> 100644
>>> --- a/include/acpi/platform/acenv.h
>>> +++ b/include/acpi/platform/acenv.h
>>> @@ -148,7 +148,7 @@
>>>
>>>  #endif
>>>
>>> -#if defined(_LINUX) || defined(__linux__)
>>> +#if defined(_LINUX) || defined(__KERNEL__) || defined(__linux__)
>>>  #include <acpi/platform/aclinux.h>
>>>
>>>  #elif defined(_APPLE) || defined(__APPLE__) diff --git
>>> a/include/acpi/platform/acenvex.h b/include/acpi/platform/acenvex.h
>>> index 2e36c8344897..c7697a47e33f 100644
>>> --- a/include/acpi/platform/acenvex.h
>>> +++ b/include/acpi/platform/acenvex.h
>>> @@ -19,7 +19,7 @@
>>>   *
>>>
>>> **********************************************************************
>>> *******/
>>>
>>> -#if defined(_LINUX) || defined(__linux__)
>>> +#if defined(_LINUX) || defined(__KERNEL__) || defined(__linux__)
>>>  #include <acpi/platform/aclinuxex.h>
>>>
>>>  #elif defined(__DragonFly__)
>>>
>>
>> Erik, Bob, any input here?
