Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7396481E54
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Dec 2021 17:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbhL3Qri (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Dec 2021 11:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240031AbhL3Qri (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Dec 2021 11:47:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B23C061574
        for <linux-acpi@vger.kernel.org>; Thu, 30 Dec 2021 08:47:38 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v11so51527366wrw.10
        for <linux-acpi@vger.kernel.org>; Thu, 30 Dec 2021 08:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=bmqMOqVCXRY2ZiAoe8nclv9yeJzG1mj+52WS9uZDouM=;
        b=hpfzoo9MYf5/4mVWVusvXiVXUzuzni5tTTUjSwSkN5bzmtevYQS3OLh3GCxS/SaJD0
         AV6+zMkzi5nSuqnhZ8jJ+5FI6u1ZD/2rHKblOGIsy4MuN7pdbDJdRm36ivjvr5AAvgih
         kOSuzyC/psE6qhXRAO3AwlgZ/9N01PbhubWX/r/DuNHlX5CQTsKnfRlBOOYgGj9i9+bW
         HtA9VDOq7PYqz8oS+AnlMbqhcvgPRvVeOwwg42Y2rrI/CVw6mR62qZMlHcMkS5KZsUH6
         tvQg170qLEmwXz0p2rrDHZI3P6BKL2llkfJNM5+TVWdpYKI0KaxgpS/JHH7uzA8mMQQn
         +u5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=bmqMOqVCXRY2ZiAoe8nclv9yeJzG1mj+52WS9uZDouM=;
        b=EMqMNArJ8vtLL8nJGQh51rIcmB9vzUpeZQ3dse9DpdlLtazyR9KECamolr7bLWdB6P
         wcx7bFF+r8PdK6m/GcqsuuZmslqFeVVEep9tSCAQm/5ZRyHk49Fr5ze4f0kMIl4Q1nyz
         uUej8ZUBm6iNWeZfv968IN+KsoJ/qNaGgbn/sSAKzW3aIyFBPSyFJVRD6RvAjfISkcWx
         r5JwJlJCY0GNszPAEEWPp6jws3xXy7zvlckMqXTaPgn91cxOBDcq7GmVb9RC5eWbw2s9
         RXiSNm78knOAIKHZwEEN/3J1IZxpc25kdVQQ+Uryu5oYYIHLtKrXm3OGFdZv6vI8EhRU
         XiMg==
X-Gm-Message-State: AOAM532RT8B3CIBn/kxhM76YtRE647+1rhFQIBRIoW06zRocCypHplB4
        JE08mD2xXB+tNzUss4Q8inRAZQ==
X-Google-Smtp-Source: ABdhPJy+OkrZ+oAW0pT+OxFrBfg5Ad23s6A3ubTVcWpH+rnx1T/qB/COWoY1W0xmu1EUV+HDhSOQeg==
X-Received: by 2002:adf:f0c8:: with SMTP id x8mr26611959wro.404.1640882856610;
        Thu, 30 Dec 2021 08:47:36 -0800 (PST)
Received: from ?IPV6:2003:d9:9708:7100:bf30:d44a:7c:3046? (p200300d997087100bf30d44a007c3046.dip0.t-ipconnect.de. [2003:d9:9708:7100:bf30:d44a:7c:3046])
        by smtp.googlemail.com with ESMTPSA id q14sm23641248wro.58.2021.12.30.08.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 08:47:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------g0r52Th8qxR28sMoy80DEOXz"
Message-ID: <89ee198e-3c6b-db02-3eec-f2ae0e2b1971@colorfullife.com>
Date:   Thu, 30 Dec 2021 17:47:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: drivers/acpi/processor_thermal.c: avoid cpufreq_get_policy()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        1vier1@web.de
References: <20211222191411.13805-1-manfred@colorfullife.com>
 <CAJZ5v0jJr=-O0UdXKj=nHtDv5oJwKWd_5het80QJZ5PBmzitPw@mail.gmail.com>
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <CAJZ5v0jJr=-O0UdXKj=nHtDv5oJwKWd_5het80QJZ5PBmzitPw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------g0r52Th8qxR28sMoy80DEOXz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 12/30/21 17:23, Rafael J. Wysocki wrote:
> On Wed, Dec 22, 2021 at 8:14 PM Manfred Spraul <manfred@colorfullife.com> wrote:
>> cpu_has_cpufreq() stores a 'struct cpufreq_policy' on the stack.
>> Unfortunately, with debugging options enabled, the structure can be
>> larger than 1024 bytes, which causes a compiler warning/error.
>>
>> (actually observed: 1184 bytes).
>>
>> Therefore: Switch to cpufreq_cpu_get().
>>
>> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
>>
>> ---
>>   drivers/acpi/processor_thermal.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
>> index a3d34e3f9f94..74210d63f62c 100644
>> --- a/drivers/acpi/processor_thermal.c
>> +++ b/drivers/acpi/processor_thermal.c
>> @@ -53,10 +53,19 @@ static int phys_package_first_cpu(int cpu)
>>
>>   static int cpu_has_cpufreq(unsigned int cpu)
>>   {
>> -       struct cpufreq_policy policy;
>> -       if (!acpi_processor_cpufreq_init || cpufreq_get_policy(&policy, cpu))
>> +       struct cpufreq_policy *policy;
>> +       int retval;
> Why is this needed?
You are right, this can be simplified. Updated patch is attached.
>> +
>> +       if (!acpi_processor_cpufreq_init)
>>                  return 0;
>> -       return 1;
>> +
>> +       retval = 0;
>> +       policy = cpufreq_cpu_get(cpu);
>> +       if (policy) {
>> +               cpufreq_cpu_put(policy);
> return 1;
>
>> +               retval = 1;
>> +       }
>> +       return retval;
> return 0;
>
>>   }
>>
>>   static int cpufreq_get_max_state(unsigned int cpu)
>> --
>> 2.33.1
>>

--------------g0r52Th8qxR28sMoy80DEOXz
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drivers-acpi-processor_thermal.c-avoid-cpufreq_get_p.patch"
Content-Disposition: attachment;
 filename*0="0001-drivers-acpi-processor_thermal.c-avoid-cpufreq_get_p.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBiNmE5ODg3NTFkOTM2OTIwMjZiNjI1MzFmMGI1NWE3ZmU2OWIxMDkyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYW5mcmVkIFNwcmF1bCA8bWFuZnJlZEBjb2xvcmZ1
bGxpZmUuY29tPgpEYXRlOiBXZWQsIDIyIERlYyAyMDIxIDE1OjA5OjMxICswMTAwClN1Ympl
Y3Q6IFtQQVRDSF0gZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl90aGVybWFsLmM6IGF2b2lkIGNw
dWZyZXFfZ2V0X3BvbGljeSgpCgpjcHVfaGFzX2NwdWZyZXEoKSBzdG9yZXMgYSAnc3RydWN0
IGNwdWZyZXFfcG9saWN5JyBvbiB0aGUgc3RhY2suClVuZm9ydHVuYXRlbHksIHdpdGggZGVi
dWdnaW5nIG9wdGlvbnMgZW5hYmxlZCwgdGhlIHN0cnVjdHVyZSBjYW4gYmUKbGFyZ2VyIHRo
YW4gMTAyNCBieXRlcywgd2hpY2ggY2F1c2VzIGEgY29tcGlsZXIgd2FybmluZy9lcnJvci4K
CihhY3R1YWxseSBvYnNlcnZlZDogMTE4NCBieXRlcykuCgpUaGVyZWZvcmU6IFN3aXRjaCB0
byBjcHVmcmVxX2NwdV9nZXQoKS4KClNpZ25lZC1vZmYtYnk6IE1hbmZyZWQgU3ByYXVsIDxt
YW5mcmVkQGNvbG9yZnVsbGlmZS5jb20+Ci0tLQogZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl90
aGVybWFsLmMgfCAxMyArKysrKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvcHJv
Y2Vzc29yX3RoZXJtYWwuYyBiL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfdGhlcm1hbC5jCmlu
ZGV4IGEzZDM0ZTNmOWY5NC4uZDhiMmRmY2Q1OWI1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2Fj
cGkvcHJvY2Vzc29yX3RoZXJtYWwuYworKysgYi9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX3Ro
ZXJtYWwuYwpAQCAtNTMsMTAgKzUzLDE3IEBAIHN0YXRpYyBpbnQgcGh5c19wYWNrYWdlX2Zp
cnN0X2NwdShpbnQgY3B1KQogCiBzdGF0aWMgaW50IGNwdV9oYXNfY3B1ZnJlcSh1bnNpZ25l
ZCBpbnQgY3B1KQogewotCXN0cnVjdCBjcHVmcmVxX3BvbGljeSBwb2xpY3k7Ci0JaWYgKCFh
Y3BpX3Byb2Nlc3Nvcl9jcHVmcmVxX2luaXQgfHwgY3B1ZnJlcV9nZXRfcG9saWN5KCZwb2xp
Y3ksIGNwdSkpCisJc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3k7CisKKwlpZiAoIWFj
cGlfcHJvY2Vzc29yX2NwdWZyZXFfaW5pdCkKIAkJcmV0dXJuIDA7Ci0JcmV0dXJuIDE7CisK
Kwlwb2xpY3kgPSBjcHVmcmVxX2NwdV9nZXQoY3B1KTsKKwlpZiAocG9saWN5KSB7CisJCWNw
dWZyZXFfY3B1X3B1dChwb2xpY3kpOworCQlyZXR1cm4gMTsKKwl9CisJcmV0dXJuIDA7CiB9
CiAKIHN0YXRpYyBpbnQgY3B1ZnJlcV9nZXRfbWF4X3N0YXRlKHVuc2lnbmVkIGludCBjcHUp
Ci0tIAoyLjMzLjEKCg==
--------------g0r52Th8qxR28sMoy80DEOXz--

