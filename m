Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7196F194C
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Apr 2023 15:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346222AbjD1NXs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Apr 2023 09:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346197AbjD1NXr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Apr 2023 09:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5D41BE7
        for <linux-acpi@vger.kernel.org>; Fri, 28 Apr 2023 06:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682688178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xw5k5HB/XqttO2GdPnL9DIAwbzyOdlnfvD271qf0MJc=;
        b=VMgifYoYnbTHAdwzp/iGdkXA19mvy7lkuatUHVj5T3vo5IVSUcmj0nFQu8wX7cMA0Q2Xw/
        AJAnRxn0Fpa80UvByNDEQGMPbxK9RM2b6SJCDEXE1C368m5nD5sDnobOV8N7lCzG6h/iKg
        k94o3CAl73hvYabkuBmR0IIOAG3n3Es=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-NENHPkL7Nxm3g85vwSajpw-1; Fri, 28 Apr 2023 09:22:57 -0400
X-MC-Unique: NENHPkL7Nxm3g85vwSajpw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-506e62603f6so9889576a12.2
        for <linux-acpi@vger.kernel.org>; Fri, 28 Apr 2023 06:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682688175; x=1685280175;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xw5k5HB/XqttO2GdPnL9DIAwbzyOdlnfvD271qf0MJc=;
        b=Glg4YtWFHJAMTf5mU8IRhJb5qKz9VqabXnEA7llNQJtEuHaLx/t3SfIzMUQHAe1b1k
         lyi4acJ7UsJeSr1aUoWRnhyx7bfhpgjq/Ar292EgcBWbuUaGo0u2iDiKmNra1LNm/zvO
         Rd6jP82ZWy6aNyXXnkk7/vAUHURKbE4IvV4/ysFtUWldF0nnmiKduN/eibSp9YDGdX7t
         qh3iz5O4EDCOi/5keOgO2TU7rayttxlc5xA95sGOCQm5nGD1xgOiGnVViKI7Zr2WW3Jb
         +AMpMN735T/8LBnirUmxeEFA+RWY7GytjeSv/3KnbSjmGb5DuBjcy8vTZaH/O3MFRzJ/
         h5Wg==
X-Gm-Message-State: AC+VfDzFnnHPesVeHX0mm+u+R5JKrr8k5s665UbjCApT3W2ZziK4DrBL
        2ru1IDye5BGFrmeStfSIraIP92/xv5cAyk/ETKCSW3h5FxdeJWOi29MRWfuXw9R5oRZtsNMTpnJ
        uh6hByNp8nBFkk/HKMvvdU6YGng48DA==
X-Received: by 2002:a05:6402:50f:b0:506:8da7:fab7 with SMTP id m15-20020a056402050f00b005068da7fab7mr4553818edv.10.1682688175502;
        Fri, 28 Apr 2023 06:22:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6pwLHm2AzLmfLaqdpck/itqpURgmaLHJ46TeWsFBZ5DNBmq1cy3BPVHn2Xy/9FdNsLEekd/w==
X-Received: by 2002:a05:6402:50f:b0:506:8da7:fab7 with SMTP id m15-20020a056402050f00b005068da7fab7mr4553801edv.10.1682688175279;
        Fri, 28 Apr 2023 06:22:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id q3-20020a056402032300b004af6c5f1805sm9100221edw.52.2023.04.28.06.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 06:22:54 -0700 (PDT)
Message-ID: <689fdd60-66e4-d423-3ae5-f9fc4513a9b7@redhat.com>
Date:   Fri, 28 Apr 2023 15:22:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: REGRESSION: ThinkPad W530 dim backlight with recent changes
 introduced in Linux 6.1.24
Content-Language: en-US, nl
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
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAK4BXn37Ns8Z8g4ysKoOZJaVa8K+mFQm5PupAanQwmz07ygW9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Русев,

On 4/27/23 17:35, Русев Путин wrote:
>> This patch should not change the maximum brightness. But you may need
> to adjust the brightness once after changing to a new kernel with
> the patch because the range / brightness-curve may be different.
> 
> This patch does change the display brightness curve but it is very
> buggy and does not change the brightness as soon as set. There is a
> very significant delay in brightness transition on the laptop due to
> this patch. Also it is worth mentioning that this patch also messes up
> color contrast of the display causing significantly deeper blacks on
> the display.

Ok, lets remove the acpi_backlight=video quirk for Lenovo ThinkPad W530
then. This was intended to make life easier for Nvidia binary driver
users, but since it is causing issues elsewhere  Nvidia binary driver
users will just have to manually pass acpi_backlight=video on
the kernel commandline until Nvidia fixes the driver.

I'll submit a patch to remove the quirk right away.

Regards,

Hans



