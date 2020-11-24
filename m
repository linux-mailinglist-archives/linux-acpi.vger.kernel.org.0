Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945942C2883
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Nov 2020 14:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388532AbgKXNnf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Nov 2020 08:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388527AbgKXNnS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Nov 2020 08:43:18 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBD6C0613D6;
        Tue, 24 Nov 2020 05:43:18 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id cq7so20902499edb.4;
        Tue, 24 Nov 2020 05:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ctRbS11BgFmifUEFq2VQXHr3JxOfCOKEQgfEbTr9MN0=;
        b=IbQXIJ5ipOWYlxa4NICpwlQaJnL3WpTzfaLXhKO6rfPPiUTxNDcfHrjpWsihNLoowm
         R7C/RraZRBeQCcUGXKY7IeBEiK4cS9bIJKdXnnVsSdfofoMHxYNIpAY4/IR0RtNPgT9p
         b1/GyYxse9KodHSyQSRQgYJTSYnlHem0HQgN/Do93KSQQo+0aqqlyNCrxW+qoewSQ6Cb
         JVikUX/EFcBAEM8jid33E220rM0GeRbXyUI+Dojb5ZdFLFdIaRpo2kBsXTJleytq7Gr0
         NMNlM1/pHH3iD8TlVljKWYruDhiAQHGzqrzF7j3CK3I2xgVjBe3Fb/4zd+FzL11Js42B
         MA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ctRbS11BgFmifUEFq2VQXHr3JxOfCOKEQgfEbTr9MN0=;
        b=DeVsrHRLuyDE95ObSKvq2Hs/J/Gz3n4RdLf3VVnRc5x2JcczAKtPh801CZTwWsFJcv
         DTkiKtVlDd3KI4sYOHCscPgL+fafwp/klvLk8hk18+idZ4HdtgjCV6EYGp2UHGDcZgDz
         k5HFRxL4H6LEcykIB5IN72BDybxxAjcRFSvxU8R4U6/FcmoCKScfjpv0V647cYV9/PiC
         r94OdSSfk0v05uvT28bXFrsxBaBvtgO9tnTCIg/HZNx9Yu/CPC2dpEPSlq3ALBa/vBfo
         6il1Xv3aCnUnjLNT06/vplf2x/a9Gd6rtb2Oh7vqEYZtJd0ankRrdmiN+0uQvmQSm74D
         SoTQ==
X-Gm-Message-State: AOAM533537ulOkAADXpdNy6nfibNzxsXMlQ15gEjvrulR33jfgVo8uqd
        lKnR7YpvhKbP0vth7wsH4oT2bC315t0=
X-Google-Smtp-Source: ABdhPJxWR9HjOYFpydOK8KY8l6vqAJU6DdBK50fePfrUG+pRzPoEwIaXFKbwO70cbXierpKS775+1Q==
X-Received: by 2002:a50:a40a:: with SMTP id u10mr3896586edb.16.1606225396556;
        Tue, 24 Nov 2020 05:43:16 -0800 (PST)
Received: from [192.168.2.202] (pd9e5aead.dip0.t-ipconnect.de. [217.229.174.173])
        by smtp.gmail.com with ESMTPSA id n14sm6950875edw.38.2020.11.24.05.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 05:43:15 -0800 (PST)
Subject: Re: [PATCH 0/9] Add support for Microsoft Surface System Aggregator
 Module
To:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20201115192143.21571-1-luzmaximilian@gmail.com>
 <059069df-c972-5060-1b26-2ddcc842810d@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <d1a781d9-6433-e1b5-5683-4de15efde686@gmail.com>
Date:   Tue, 24 Nov 2020 14:43:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <059069df-c972-5060-1b26-2ddcc842810d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11/24/20 12:59 PM, Hans de Goede wrote:
> Hi,
> 
> On 11/15/20 8:21 PM, Maximilian Luz wrote:
>> Hello,
>>
>>    N.B.: the following text is mostly a repeat of cover letter from the
>>    previous RFC for the uninitiated, which can be found at
>>
>>    https://lore.kernel.org/linux-serial/20200923151511.3842150-1-luzmaximilian@gmail.com/
>>
>>    See "Changes" below for an overview of differences between the RFC and
>>    this patchset. I hope I have addressed all comments from that in this
>>    version, thank you again for those.
>>
>> The Surface System Aggregator Module (we'll refer to it as Surface
>> Aggregator or SAM below) is an embedded controller (EC) found on various
>> Microsoft Surface devices. Specifically, all 4th and later generation
>> Surface devices, i.e. Surface Pro 4, Surface Book 1 and later, with the
>> exception of the Surface Go series and the Surface Duo. Notably, it
>> seems like this EC can also be found on the ARM-based Surface Pro X [1].
> 
> <snip>
> 
>> This patch-set can also be found at the following repository and
>> reference, if you prefer to look at a kernel tree instead of these
>> emails:
>>
>>    https://github.com/linux-surface/kernel tags/s/surface-aggregator/v1
>>
>> Thanks,
>> Max
> 
> Thank you for your work on this. It would be great if we can get better
> support for the Surface line in the mainline kernel.
> 
> Since a lot of people have already commented on this series I think that
> you have enough feedback to do a v2 addressing that feedback right?

Yes, I'm already working on it.

> For now I'm going to assume that you will do a v2 addressing the
> initial round of comments and not review this myself (IOW I'll review
> this when v2 is posted).

Sure, no need for you to review v1 at this point.
  
> Let me know if you see things differently.

Thanks,
Max
