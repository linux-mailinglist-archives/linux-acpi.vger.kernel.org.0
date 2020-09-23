Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC432275C3B
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Sep 2020 17:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgIWPnK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Sep 2020 11:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWPnK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Sep 2020 11:43:10 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B43C0613CE;
        Wed, 23 Sep 2020 08:43:09 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id ay8so243298edb.8;
        Wed, 23 Sep 2020 08:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h51vtV3NZEeXo1YiXhByNRW7T2TYwgDS1SZDvdq1otA=;
        b=MDMp6Q4oSdK2i7FvfdR4sMPI5L9H2/tI0U9WMoGwwxPeEREU0wNNBa2Vaq4Zq95yKB
         YpW1BOPT7sS3QTrgkqYln/VKS6uODibJCcP2jCMyB/4pq1oQKY3Oc9L/2QFbsLKzwc9P
         4lZK234a6r5+CNFNLsFe0IAj6P3iKSiBXvJs63IpqemwR5ajoLp3lvZ2T+Vf3Q7LkMBy
         DZQOmIbd+sA/0jNlZWqV5du22KvGLGH5TTOOqyfSPkOjZuRSLc8yJfoG1nEqpWH60dqV
         r0+MrCWP9kBmeiCqIiywNWFuAMVdu6IjQg/pyivtmQpOoiTXaT7O83GVp/We4n5812gu
         Luzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h51vtV3NZEeXo1YiXhByNRW7T2TYwgDS1SZDvdq1otA=;
        b=P20/Naz1E2LS7gnKzVlu9q8tPwbRaP8uU1Udsg4bK19dVUDDfZIYLBx+y43xD5xRm7
         IUR20N+is0WUtDCPJZ9mPQllVZIiC+fzrwyvkjtnHlhu9flAyF1i1sYkYDFqtFz7lYWJ
         76Qo9E4zaY3vUDWxqL/i4TRBoqkpkyKbd8kqulGD9UW3uhiO1G+23SqJ+awK4SDUNFto
         zdKFyvIbKDosVVK9kIxQlOE+bR5+KCf8Sf+S2GQqCnenJRs5rCWiACn+1igWYSe0emTO
         ZBj3lLuetBMAO1jUFqoVg7ELw+XZEox9AFtoJsBXbR1EMk00eMastzPhE+wHU3j1uriT
         QfDg==
X-Gm-Message-State: AOAM530adMV75KTiTjiy1sWdpU6Cu0Y9y6eRRQyCm4O3lSJeQ0wX84gz
        vcZd+j4teaFpJwHUU4pda+A=
X-Google-Smtp-Source: ABdhPJzOrCKFjysaNLgtM/thsyjaPWYAbx9CyDzI5oOvOi8J6cf41WxyMN8duCgVRmZ+epU8RmhZoA==
X-Received: by 2002:aa7:d1ce:: with SMTP id g14mr10374050edp.153.1600875788496;
        Wed, 23 Sep 2020 08:43:08 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9df.dip0.t-ipconnect.de. [217.229.169.223])
        by smtp.gmail.com with ESMTPSA id d25sm243435edq.52.2020.09.23.08.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 08:43:07 -0700 (PDT)
Subject: Re: [RFC PATCH 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <CAK8P3a3Qie_CP1dA-ERqyDv=EnaQQPnNbFYrGr3ySiY4mO0=Uw@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <dad42dce-15d0-245a-4d91-4733e54883a0@gmail.com>
Date:   Wed, 23 Sep 2020 17:43:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3Qie_CP1dA-ERqyDv=EnaQQPnNbFYrGr3ySiY4mO0=Uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 9/23/20 5:30 PM, Arnd Bergmann wrote:
> On Wed, Sep 23, 2020 at 5:15 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>
>> Hello,
>>
>> The Surface System Aggregator Module (we'll refer to it as Surface
>> Aggregator or SAM below) is an embedded controller (EC) found on various
>> Microsoft Surface devices. Specifically, all 4th and later generation
>> Surface devices, i.e. Surface Pro 4, Surface Book 1 and later, with the
>> exception of the Surface Go series and the Surface Duo. Notably, it
>> seems like this EC can also be found on the ARM-based Surface Pro X [1].
> 
> I think this should go to drivers/platform/x86 or drivers/platform/surface/
> along with other laptop vendor specific code rather than drivers/misc/.

I initially had this under drivers/platform/x86. There are two main
reasons I changed that: First, I think it's a bit too big for
platform/x86 given that it basically introduces a new subsystem. At this
point it's really less of "a couple of odd devices here and there" and
more of a bus-type thing. Second, with the possibility of future support
for ARM devices (Pro X, Pro X 2 which is rumored to come out soon), I
thought that platform/x86 would not be a good fit.

I'd be happy to move this to platform/surface though, if that's
considered a better fit and you're okay with me adding that. Would make
sense given that there's already a platform/chrome, which, as far as I
can tell, also seems to be mainly focused on EC support.

> I'll have a look at the code myself, but I'd prefer to have the maintainers
> for the other laptop drivers review this properly.

Thanks! I'll CC them for the next version.

Regards,
Max
