Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B436F1965
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Apr 2023 15:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346256AbjD1N06 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Apr 2023 09:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjD1N05 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Apr 2023 09:26:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0E11FF5
        for <linux-acpi@vger.kernel.org>; Fri, 28 Apr 2023 06:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682688372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=STu7YaLdDG8nPsEVlYhXNUOcMxwx5g0OadIoYgDkbrY=;
        b=UpZDGNtumRHfTq9vnpXTpqTXApcdPKjAi+jIVw2nTGLsh/uziyQKfsKktgyZdl1J809Lys
        F7S7nXM2TUexzNdmn8+J5Qd6SRxn4Oj96SeKbEveEnv+32c6+m8IBug4fiirjvglUVIP1p
        RYGv95O/GuViJab6x+VhSURV7iKDV1c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-2jcF3eJGMzOOd9mXf90cTw-1; Fri, 28 Apr 2023 09:26:10 -0400
X-MC-Unique: 2jcF3eJGMzOOd9mXf90cTw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-50a094d5876so4161563a12.3
        for <linux-acpi@vger.kernel.org>; Fri, 28 Apr 2023 06:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682688370; x=1685280370;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=STu7YaLdDG8nPsEVlYhXNUOcMxwx5g0OadIoYgDkbrY=;
        b=gAyBZFoplk/6qHA8o7a9KU5yyUntDI456f1468Q3oJIzLU+Kpng3AIS7B7jMA9Ky24
         DXU28Wu24v6uvJkNT8e3KaKwzEJJZLwf3MsVRsEe/Xplg0gbNvKeDEMD81rAu/ODnfHn
         QgAgrUS/Abe4oujEUEqeGkgVjvhCNiusfmIs4rBc5IaFfxlGYKJfIa+j+ChWnhwqGttS
         V6G1zo6j0T+gDdHz68xIrejn/toW536BB/FhMK5WNpstXeNgKqlIHGVJbzwOdBUiZkm1
         N/Fm+EhU9N/sTpPFS54TguoT+xCreY0FtTpMl/F6sQ2vI0SpeGEh5mapzyopi9W/OG6G
         GIpg==
X-Gm-Message-State: AC+VfDzivQB012Mu1IpKLRTl91sabKMbdRZo3u5CgwUUg/KLct31Z2zA
        /I8IewLhMyOJj/5PjV+W3EQcuKHqz/tPU+rQKVWxnjb/IiK0Ij1LZNZf5EC2WUTZl4JF8NCP+Y2
        Y5K14NZKWhZJxIJsgAd9WuQ==
X-Received: by 2002:aa7:d982:0:b0:506:82b7:10c3 with SMTP id u2-20020aa7d982000000b0050682b710c3mr4550900eds.41.1682688369877;
        Fri, 28 Apr 2023 06:26:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5CCW/Jyr+5Y3KHgbmqEA0xNQh0H0ptqZWxalQP4WOGaxem7p5E+wEtbCODK8WGm6FC4W/b4Q==
X-Received: by 2002:aa7:d982:0:b0:506:82b7:10c3 with SMTP id u2-20020aa7d982000000b0050682b710c3mr4550878eds.41.1682688369568;
        Fri, 28 Apr 2023 06:26:09 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id k26-20020aa7c39a000000b005068053b53dsm9215433edq.73.2023.04.28.06.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 06:26:09 -0700 (PDT)
Message-ID: <c228e469-9d17-faa8-d218-dfb2b7b63b22@redhat.com>
Date:   Fri, 28 Apr 2023 15:26:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: REGRESSION: ThinkPad W530 dim backlight with recent changes
 introduced in Linux 6.1.24
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?B?0KDRg9GB0LXQsiDQn9GD0YLQuNC9?= 
        <rockeraliexpress@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, stable@vger.kernel.org,
        Daniel Dadap <ddadap@nvidia.com>
References: <CAK4BXn0ngZRmzx1bodAF8nmYj0PWdUXzPGHofRrsyZj8MBpcVA@mail.gmail.com>
 <2023041711-overcoat-fantastic-c817@gregkh>
 <CAK4BXn30dd3oCwcF2yVb5nNnjR21=8J2_po-gSUuArd5y=f9Ww@mail.gmail.com>
 <CAJZ5v0g+PAOZs47LCrxRswZoCmHbGfBg3_cr13Y8zWPXDjgm3A@mail.gmail.com>
 <a3b89478-2d37-1b25-94e0-0e12396f6fd4@redhat.com>
 <CAK4BXn37Ns8Z8g4ysKoOZJaVa8K+mFQm5PupAanQwmz07ygW9A@mail.gmail.com>
 <689fdd60-66e4-d423-3ae5-f9fc4513a9b7@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <689fdd60-66e4-d423-3ae5-f9fc4513a9b7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Русев,

On 4/28/23 15:22, Hans de Goede wrote:
> Hi Русев,
> 
> On 4/27/23 17:35, Русев Путин wrote:
>>> This patch should not change the maximum brightness. But you may need
>> to adjust the brightness once after changing to a new kernel with
>> the patch because the range / brightness-curve may be different.
>>
>> This patch does change the display brightness curve but it is very
>> buggy and does not change the brightness as soon as set. There is a
>> very significant delay in brightness transition on the laptop due to
>> this patch. Also it is worth mentioning that this patch also messes up
>> color contrast of the display causing significantly deeper blacks on
>> the display.
> 
> Ok, lets remove the acpi_backlight=video quirk for Lenovo ThinkPad W530
> then. This was intended to make life easier for Nvidia binary driver
> users, but since it is causing issues elsewhere  Nvidia binary driver
> users will just have to manually pass acpi_backlight=video on
> the kernel commandline until Nvidia fixes the driver.
> 
> I'll submit a patch to remove the quirk right away.

p.s.

In the mean time you can work around the regression by passing:
"acpi_backlight=native" on the kernel commandline.

Regards,

Hans


