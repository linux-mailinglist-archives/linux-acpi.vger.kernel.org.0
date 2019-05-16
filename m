Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C62920D7D
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2019 18:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfEPQzh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 May 2019 12:55:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34997 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfEPQzh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 May 2019 12:55:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id t87so2164322pfa.2;
        Thu, 16 May 2019 09:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EAZuaSOFLPgJxOfkuE/RETBPBEFS9w8pXwe5DKxj3jc=;
        b=Mde2YlhG7yTq8WVVRYWPZKNPot9dDb1OTgQhm/zFDYDcGEXigQoKN8OkBi46VzNrKy
         gT8PkyM45K9GvYcErJxIbJkUQsREpqAEMDj41efjuvc61FT9Wrjsd/H4MK92+pP6BMh9
         B0tUFeM9aobU6BIvdQ7aHU1X7fWv0IAqZ49YslhHpHWtaJ+FTEaf4oZIiWRi72CZsoVT
         cwh5V3MK1XSDSxl5WkV2VLLWAxKJgGux2ejDUj9pqErha4IcqJvlYEEYZK5BpKnAgKKR
         1bBPXp3j6A9xe2efxc6Pk/wQJayXvE2cTBHRycki3fUIWSXrN0+Xv0c8rJpuiX8xcSPL
         qKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EAZuaSOFLPgJxOfkuE/RETBPBEFS9w8pXwe5DKxj3jc=;
        b=ay38/lMsIKoRs6LQ4o60o2G1Z2f7MjY8RQMrkb66e/GvR16EiaaWz0zcN0LtFQKcKd
         VJTATk9K5a0spwjLben19PMiHQ0YZUhdicDMzOSI7iylQ7Zk90SZ44NlUZSYRWtFoLg0
         zYwqAEJiZpfeyry0x3ylw+s9VZy9ySGkgRPzhJL8lKhnC33n5HPBntDoiwhXoF++cs2Y
         DBaLP98ObfCb99Wxc1EcThIJy9nhIlUzz6VJ4tLXrwOPTcQKXh8Hb3UdmPZSdDWGLYui
         RjVGHXCaMu0ouifwTdQmauFmdNqC4apKqibnyfF/cSfnNQch7veK+ERTykYd5l5bYaD2
         F2yw==
X-Gm-Message-State: APjAAAXm5oMji4yZcjZguEGyfXMv3NdhUNCFQBF36VUztVljF+QhHEXG
        CdDp1fHy04d0pWGTJokaJ0Tr9cTl
X-Google-Smtp-Source: APXvYqx7/fR+YFTBealEB1eVL6PMrU8y84ftgQoiHQ9J3my7pDkqFDmJGluga/cEErBpiNrRP8iZSA==
X-Received: by 2002:a62:164f:: with SMTP id 76mr56070014pfw.172.1558025736036;
        Thu, 16 May 2019 09:55:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q142sm2615058pfc.27.2019.05.16.09.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 09:55:34 -0700 (PDT)
Subject: Re: [GIT PULL] Thermal-SoC management changes for v5.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190516044313.GA17751@localhost.localdomain>
 <CAHk-=wiaO_8SiEB9QM3vOTniiT67K6CBH0uHJ82-Dp_+6kxH3g@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <cd06dc28-1076-259a-ba94-bad116771da8@roeck-us.net>
Date:   Thu, 16 May 2019 09:55:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiaO_8SiEB9QM3vOTniiT67K6CBH0uHJ82-Dp_+6kxH3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 5/16/19 8:07 AM, Linus Torvalds wrote:
> On Wed, May 15, 2019 at 9:43 PM Eduardo Valentin <edubezval@gmail.com> wrote:
>>
>> - thermal core has a new devm_* API for registering cooling devices, thanks to Guenter R.
>>    I took the entire series, that is why you see changes on drivers/hwmon in this pull.
> 
> This clashed badly with commit 6b1ec4789fb1 ("hwmon: (pwm-fan) Add RPM
> support via external interrupt"), which added a timer to the pwm-fan
> handling.
> 
> In particular, that timer now needed the same kind of cleanup changes,
> and I'd like you guys (particularly Guenther, who was involved on both
> sides) to double-check my merge.
> 
> The way I solved it was to just make the pwm_fan_pwm_disable()
> callback do both the pwm_diable() _and_ the del_timer_sync() on the
> new timer. That seemed to be the simplest solution that meshed with
> the new devm cleanup model, but while I build-tested the result, I
> obviously did no actual use testing. And maybe there's some reason why
> that approach is flawed.
> 
> Guenther?

Sorry for the trouble. Looks like I did too much cleanup this time around.

Looks ok. I'll have to send a follow-up patch - we should check the
return value of devm_add_action_or_reset(). No idea why I didn't do that
in this series. I'll do that after the commit window closes (and after
I am back from vacation).

Thanks a lot for sorting this out.

Guenter
