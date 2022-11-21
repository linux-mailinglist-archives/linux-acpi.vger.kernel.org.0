Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0AE6326D0
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Nov 2022 15:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiKUOuF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Nov 2022 09:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiKUOsZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Nov 2022 09:48:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D53CD2F7F
        for <linux-acpi@vger.kernel.org>; Mon, 21 Nov 2022 06:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669041655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uvsBImsu/BbpivoFIissXZCk1tsGDBqdresNn8IaQpg=;
        b=PU5IPWtJadthfpqovD2BxLaq2UFfVobXlsCH26QTO3znqUnUJnqfotYpoLUjTSrg4j9Gg4
        AVK2c8Sw+aQ6E7kcY8yykTQx5wa3KPUv2TdnwMyhaJm21H7yrqs6vOPR1HyUZQP071U+xt
        HUdBPUZ6pNqVfM5pkTmQIfTMK78rzns=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-237-nSLi_DO-O_CacyO0MVEdkQ-1; Mon, 21 Nov 2022 09:40:54 -0500
X-MC-Unique: nSLi_DO-O_CacyO0MVEdkQ-1
Received: by mail-ej1-f69.google.com with SMTP id sh31-20020a1709076e9f00b007ae32b7eb51so6651277ejc.9
        for <linux-acpi@vger.kernel.org>; Mon, 21 Nov 2022 06:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uvsBImsu/BbpivoFIissXZCk1tsGDBqdresNn8IaQpg=;
        b=4QmzePR15Btx186kF/CfmMNOGNxFcTyh1dOvg5grxaGaHMplm/noj62hoB8bA5u3hb
         GPrJQnuWW9hsykI/RIduQvq+ImVBab5PevOQd3BHA3qmL5Sc8okVCdXrhj/pzRz9SpPB
         whdVfoLkZ37gPIbKFp1srOh+h5ehdK0ChQew6BKsBupkImZZtJYV22Y9atz3OLyczAtC
         mbh54fs1XFG42QdJzaFW7kh3DdRCj2IRdOW09rjKcvdHwVNToQYInp3DRhQ7IvF8ZaDm
         UftM4cZBRpsVIj/Cptx6ccj8i3PleRvlYIZVd4KLe1StIiK2dG6b9XzXlhSetOqILhz2
         YJRQ==
X-Gm-Message-State: ANoB5plx9SdyKbxkqGkJKOKePPtLB8bPyauRPHZ3U1vft6pLRDmVTdYV
        Es3zw3JAMIdMnS5uvTPpmA6Y0jDAYMW6PNAv5059ONgf7DZGOO11wEBkzmnSQ9XywQuXUXosxok
        Jg43Y/uGr/sNKoBBb7+hm5g==
X-Received: by 2002:aa7:c7d5:0:b0:44e:bee5:4242 with SMTP id o21-20020aa7c7d5000000b0044ebee54242mr3206800eds.128.1669041648605;
        Mon, 21 Nov 2022 06:40:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6doXWveL5eTRZgqwC3+y1yNawxc5ciMGkg1djT6qXLkcVEcPZTjJAgWi/2CTjBojbqOYsqEg==
X-Received: by 2002:aa7:c7d5:0:b0:44e:bee5:4242 with SMTP id o21-20020aa7c7d5000000b0044ebee54242mr3206783eds.128.1669041648454;
        Mon, 21 Nov 2022 06:40:48 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id x20-20020a170906805400b007919ba4295esm5089993ejw.216.2022.11.21.06.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 06:40:47 -0800 (PST)
Message-ID: <1d838451-5bd0-96c2-b341-d991e920ef34@redhat.com>
Date:   Mon, 21 Nov 2022 15:40:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1 2/4] media: ipu3-cio2: Convert to use
 software_node_register_node_group()
Content-Language: en-US
To:     Dan Scally <dan.scally@ideasonboard.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>
References: <20221118185617.33908-1-andriy.shevchenko@linux.intel.com>
 <20221118185617.33908-2-andriy.shevchenko@linux.intel.com>
 <2c69ae41-7920-1438-8bfc-8581aad0ee00@ideasonboard.com>
 <93eb74bf-58c4-1a77-af2f-3a0df4404acf@redhat.com>
 <Y3tSj20qwJZ23VAY@smile.fi.intel.com>
 <f02b5a25-9263-f396-14de-3a7781835222@ideasonboard.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <f02b5a25-9263-f396-14de-3a7781835222@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/21/22 15:32, Dan Scally wrote:
> Hi Andy and Hans
> 
> On 21/11/2022 10:27, Andy Shevchenko wrote:
>> On Mon, Nov 21, 2022 at 11:22:17AM +0100, Hans de Goede wrote:
>>> On 11/21/22 11:19, Dan Scally wrote:
>>>> On 18/11/2022 18:56, Andy Shevchenko wrote:
>>>>> The currently used software_node_register_nodes() is going to
>>>>> be removed. Prepare driver by switchich to new API.
>>>> Also looks good to me:
>>>>
>>>> Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
>> Thank you!
>>
>>> Any chance you can also give this series a test run on an IPU3 device to
>>> ensure that it does not cause regressions ?
>> Yes, it would be really appreciated!
> 
> All seems fine (including the kunit test) - you can add
> 
> 
> Tested-by: Daniel Scally <dan.scally@ideasonboard.com>

Great, thank you!

Regards,

Hans

