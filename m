Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A7264FB32
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Dec 2022 18:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLQRTS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 17 Dec 2022 12:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLQRTR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Dec 2022 12:19:17 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895BFD8B
        for <linux-acpi@vger.kernel.org>; Sat, 17 Dec 2022 09:19:16 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3bf4ade3364so75455637b3.3
        for <linux-acpi@vger.kernel.org>; Sat, 17 Dec 2022 09:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJw5sCOmDkIvUOOa9Z9yknbIVX8xyVM0IQzZ2fMQXOs=;
        b=ofRQR2WUj3OMDtvUIGIVDR6MicYDNzmk8K8kSulinqYDJdpSpmpUqgk9U2FJc9PixE
         D4xpQ1QOAGw1yas21vgAeNNYJ6h4Kx7mk4UBcsxCxYWA4MxArFMEIZ4ySCzyFPiLPMJd
         yq9U2uTFEcobQAU9P157uJLCXBrVY5VCVRYfZJasYj5ZwmkMLqQAMTZb0GCV7wrilrx8
         4+yI9z/3G8q4cW1tMjqmRYaAb3ZyZI1Du7XC7F6l7H9VP5lnoHq8XjTfA7zWyJRDOBpM
         omNz9IHCLN+VjShssGhXvtVyUj7+FCemaAQWG+hMme4o+CEHo0vPpSOogFu/tsbJ5B7w
         WtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJw5sCOmDkIvUOOa9Z9yknbIVX8xyVM0IQzZ2fMQXOs=;
        b=MbuXPj7nLBpiHPLEZXoUyMoEGnJ97u02hSuzSfEVgPTZBscYvmGZKIvXauLPn5DTea
         jpfYmomDWWAjaMt/ejH5jXoPzzjWONfiXy2wpJRH5v1Hs0dFoY0lciZarHVgUyrbQ9vc
         lRAOMRLeGOp+cXLSXS64oDEmTDmmh5FlUAiOzoEihFlQqMlbGoMxj6lbSshb5YSiZQys
         kFcp6rhPY/AGfti4P2jAUXwpoWGGGYXmHR9ADDCZA9jVIgA/Ufzdtx9hEyNLbX+rijk9
         PB0GI6DxbwViJZ/6dVY2ib2ssYliWqkCTg1lp0Uyf/xgDRIT+TlEx1DzclnSjvxX24Sg
         JFZg==
X-Gm-Message-State: ANoB5plh26evQxUncfgvBQOpn8SsyzZ2BT35Mu+I9FJYFb7Pe0npcE0X
        3a9b07A/QxuGFqG2uLSMLkY04Ia6gzFZpiMTESRP/U2pMkY=
X-Google-Smtp-Source: AA0mqf4gIvMBgexNjiJVjptMr8Sshwnwm/lS+n45ZNm2jp67LE1uMgtUHbbhUFuLo1iTdn2OS240NCbKjNZbWhFv4t0=
X-Received: by 2002:a0d:e696:0:b0:3e8:da97:53fd with SMTP id
 p144-20020a0de696000000b003e8da9753fdmr23341482ywe.42.1671297555409; Sat, 17
 Dec 2022 09:19:15 -0800 (PST)
MIME-Version: 1.0
References: <CADaG5hMao0nRXP9VrvVy__7H3vKUmQuH_rLVhy1m+GZdBGVJkQ@mail.gmail.com>
 <CADaG5hO1FsZ5JKEq4ZbM2j=xB7E-UheKxLB=k=QpEdDHKKBkuA@mail.gmail.com>
In-Reply-To: <CADaG5hO1FsZ5JKEq4ZbM2j=xB7E-UheKxLB=k=QpEdDHKKBkuA@mail.gmail.com>
From:   Michael Shantzis <shantzis62@gmail.com>
Date:   Sat, 17 Dec 2022 09:19:03 -0800
Message-ID: <CADaG5hOc8f228Bmq7=aeA23SkbSuRdQUNSHLQqAS28iFXm0+FA@mail.gmail.com>
Subject: Re: help with a sleep state bug (216424)
To:     linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[resending w/o HTML]

On Sat, Dec 17, 2022 at 9:16 AM Michael Shantzis <shantzis62@gmail.com> wro=
te:
>
> Hello Rafael,
>
> I mailed you about this a few months ago and then I got caught up with ot=
her things. Adding linux-acpi@ to the email.
>
> I'm still trying to figure out what is going on with my computer's incomp=
lete sleep state. I have the feeling that if someone who understands this l=
ooks at the logs, they may be able to tell me pretty quickly what is going =
on and how to proceed. If any of you can help me out with that, I'd really =
appreciate it.
>
> Thank you in advance for any help you can provide. I greatly appreciate i=
t.
>
> Michael Shantzis
>
> On Sat, Sep 10, 2022 at 11:32 AM Michael Shantzis <shantzis62@gmail.com> =
wrote:
>>
>> Hi Rafael,
>>
>> I'm trying to get some help with this bug:
>> Bug 216424 (see https://bugzilla.kernel.org/show_bug.cgi?id=3D216424)  -=
 HP Spectre x360 incomplete sleep state
>>
>>
>>
>> Someone on the thread encouraged me to email you directly. The summary i=
s that I have an HP Spectre x360 that doesn't entirely go into sleep state =
and its battery dies fairly quickly when the lid is closed (about 2x-3x mor=
e quickly than some of my other laptops/configurations).
>>
>> Any help you can give me in figuring this out would be greatly appreciat=
ed.
>>
>> Thanks so much, both for your contributions to linux (I never get to tha=
nk anyone personally :)) and in advance for any help you can give.
>>
>> Best,
>> Michael Shantzis
