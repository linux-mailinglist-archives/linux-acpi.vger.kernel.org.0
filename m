Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483F6749BB7
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 14:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjGFMa0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 08:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjGFMa0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 08:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED7EE72
        for <linux-acpi@vger.kernel.org>; Thu,  6 Jul 2023 05:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688646579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iNNsAgLd/8S5YeBehDMR1r5KyYGS/cglxlPiEpZL+5s=;
        b=L7ZUXjViblcAwVT4IoMNfNFscs5wi3vVi3bQY3UL+tI5AFDNooKioUKIbS+4nDRG1ec6bM
        t8VOUFfmZckdlIdq/UYwAWqIf8q2C1VOg4BLy+aVDyPS/nc7zlTxQu1IrU/nmVKlxHN+18
        ShlKppT8Tbg63RL7Xva4IsjUKnRmGNE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-DLLz4RmHNB6XTh6wanYjGw-1; Thu, 06 Jul 2023 08:29:37 -0400
X-MC-Unique: DLLz4RmHNB6XTh6wanYjGw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94f7a2b21fdso54313866b.2
        for <linux-acpi@vger.kernel.org>; Thu, 06 Jul 2023 05:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688646576; x=1691238576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNNsAgLd/8S5YeBehDMR1r5KyYGS/cglxlPiEpZL+5s=;
        b=KTimGjNsnWPDbwEOokLghOZ9sQ8la4OFOsFuUhK6zuoQ+orHp7g8M9AtiznqHn80sC
         mGBFyD4nyTwN5H10Xv/BWaaO3qyPpSY2KzGZS7ESLFcE45b8UDeY+1HcGjv7NwcFP8oH
         jANSOtAaqLZlsfScw3Lo/VDyEpR7swb9+G2nuDwPX6Cmapo1h9gPsNfSmYPKtqofNkY1
         dMLFI7glnR+XX9kx+JiW0at5NGtC4IARHaX1VwZAsUJAb9tR7n3KEGfPN22rIoZp3a/N
         WFSyi8eDb0X6hEwoA5MyHXi2LqBPHZAxN07xTStWEmkY+DDSIGZ+wf4JcI9p2c7WNvhj
         dAGA==
X-Gm-Message-State: ABy/qLanBtc3JfawfuimCkZUvti7TymJbJPuQaWWsHiJRUjsgFHaxCru
        7PzvVCfwJsHrFiWPlf3djO2qde5g0yzBniihRk25/XnzVrrn9Z7rvnoYlWoupqqvOleA8GU2iGr
        GhKlcJzf4zaYdcj22mIwLl8ooE45Dlg==
X-Received: by 2002:a17:906:64d0:b0:98e:43ce:93fa with SMTP id p16-20020a17090664d000b0098e43ce93famr1406706ejn.8.1688646576583;
        Thu, 06 Jul 2023 05:29:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFBA0gDV322GYWvT4dnBfVBLV56ukKBeESbb0KAL9RD8snA12DvEJ3vdSMxPHn9d2RMoSp6Vw==
X-Received: by 2002:a17:906:64d0:b0:98e:43ce:93fa with SMTP id p16-20020a17090664d000b0098e43ce93famr1406683ejn.8.1688646576326;
        Thu, 06 Jul 2023 05:29:36 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gf3-20020a170906e20300b00992665694f7sm752607ejb.107.2023.07.06.05.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 05:29:35 -0700 (PDT)
Message-ID: <08825217-ff29-1f58-220d-617570836542@redhat.com>
Date:   Thu, 6 Jul 2023 14:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 15/18] ACPI: bus: Introduce acpi_match_acpi_device()
 function
Content-Language: en-US, nl
To:     Andy Shevchenko <andy@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Hsuan <hpa@redhat.com>, Hao Yao <hao.yao@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-16-hdegoede@redhat.com>
 <ZKaHErGZOVXXDn9c@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZKaHErGZOVXXDn9c@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/6/23 11:19, Andy Shevchenko wrote:
> On Wed, Jul 05, 2023 at 11:30:07PM +0200, Hans de Goede wrote:
>> Some ACPI glue code (1) may want to do an acpi_device_id match while
>> it only has a struct acpi_device available because the first physical
>> node may not have been instantiated yet.
>>
>> Add a new acpi_match_acpi_device() helper for this, which takes
>> a "struct acpi_device *" as argument rather then the "struct device *"
>> which acpi_match_device() takes.
>>
>> 1) E.g. code which parses ACPI tables to transforms them
>> into more standard kernel data structures like fwnodes
> 
> Looks like it's v1 of my original patch, anyway this is now in Linux Next as
> 2b5ae9604949 ("ACPI: bus: Introduce acpi_match_acpi_device() helper").

Ah interesting, it does indeed look a lot like your version.
but it was developed independently.

Unfortunately it seems that this is headed for 6.6-rc1 and the atomisp
changes in this series which rely on this are intended for 6.6-rc1 too.

So we still need to figure out how to merge this.

Regards,

Hans

