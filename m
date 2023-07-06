Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E325749CD9
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 14:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjGFM7l (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 08:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjGFM7k (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 08:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EAF1986
        for <linux-acpi@vger.kernel.org>; Thu,  6 Jul 2023 05:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688648335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yM4N5DFAxPMdGGFLcPi8H5okTfoMwB1Jd++fMp4a7rI=;
        b=Png34Up7SJwM4H1ZMA2wSfqJfOt+CeLW7aSV0llS9adjBGCmP715hlHiDuTPQWThZSB/Xo
        AT1Y/TJN6WNkCfbFsfw7jhclbG2voSKzOPRuYn7NN9SokzHVgSVOk1+ZfzfNJ5EuBoSV4q
        4N405RWGGfvAVkN6OE858FmgAKP/V0c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-yqgQijaTNCq7TrsOeayuLA-1; Thu, 06 Jul 2023 08:58:53 -0400
X-MC-Unique: yqgQijaTNCq7TrsOeayuLA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-518676b6d09so484646a12.1
        for <linux-acpi@vger.kernel.org>; Thu, 06 Jul 2023 05:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688648332; x=1691240332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yM4N5DFAxPMdGGFLcPi8H5okTfoMwB1Jd++fMp4a7rI=;
        b=SdZliljeU2Xbyi0K2HuaBFdl/zl/7OmgJFBLY7gQhvaBWd2NwB8Q4ZFpzomTbm8yR9
         22Pf4GA5qI6Jfof6S9zHxmqc6Yd/m4q9hHDRpUDrynKWcl9YMLH3kl1uVa5QDyZeLWw2
         Lih1xGNniiw1GXaKVaZXo/0UHSIf1kXTJBru/YAKhtmJaHuCO61abnsYfhjwJXbifL0Y
         ZUjWDBeo4ir7+bXsvWyI32EVPDm/RfFJw3dxxXTaTzbZ0C8MK1MJT6BTKuJ1ZTGLf15I
         hw/s+SUl8G9Cn5i+tIbV5nm29WuxA6QuNi0BV4rOLiv9puXZoT46/Y6uo8GGyBbaleao
         0jSQ==
X-Gm-Message-State: ABy/qLZnlxMEzQ5a0SoAHQn5bsTHtFJfIQM5XB3z4vnZm5VDxPQZhDl7
        5MFmt8INK2VLlv1f4xNMfdjP2UwFuNkSkYvuepFmbACbp+dywqknHxpSeKiB8kO2tJe7jcXWgyN
        PRNEa0DMgT4fSlIFEC7tbcA==
X-Received: by 2002:aa7:c75a:0:b0:51d:94d2:ffd2 with SMTP id c26-20020aa7c75a000000b0051d94d2ffd2mr1801137eds.2.1688648332716;
        Thu, 06 Jul 2023 05:58:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE2KGiupXfVuTZpxW0wrRJ/zGbaYn57wxRWnC4NCn4viRGyQrLQsl4osvcy625mvLr8V3kz6A==
X-Received: by 2002:aa7:c75a:0:b0:51d:94d2:ffd2 with SMTP id c26-20020aa7c75a000000b0051d94d2ffd2mr1801127eds.2.1688648332426;
        Thu, 06 Jul 2023 05:58:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id b14-20020aa7c90e000000b0051e1a4454b2sm748143edt.67.2023.07.06.05.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 05:58:51 -0700 (PDT)
Message-ID: <896a1dbc-1445-40d2-1ea0-47ac8b69c9d1@redhat.com>
Date:   Thu, 6 Jul 2023 14:58:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 18/18] media: atomisp: csi2-bridge: Add support for VCM
 I2C-client instantiation
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
 <20230705213010.390849-19-hdegoede@redhat.com>
 <ZKaUWAAf586ZIRMF@smile.fi.intel.com>
 <500c0f9a-7b81-3c13-6da8-39245282fe46@redhat.com>
 <ZKa2qnreaCfb2Lgc@smile.fi.intel.com>
 <b098d5e6-5aeb-a9e1-5f4c-6eed4b78b3fd@redhat.com>
 <ZKa6A1Ex0GRk4aqg@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZKa6A1Ex0GRk4aqg@smile.fi.intel.com>
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

On 7/6/23 14:56, Andy Shevchenko wrote:
> On Thu, Jul 06, 2023 at 02:47:36PM +0200, Hans de Goede wrote:
>> On 7/6/23 14:42, Andy Shevchenko wrote:
>>> On Thu, Jul 06, 2023 at 02:31:14PM +0200, Hans de Goede wrote:
>>>> On 7/6/23 12:15, Andy Shevchenko wrote:
>>>>> On Wed, Jul 05, 2023 at 11:30:10PM +0200, Hans de Goede wrote:
>>>
>>>>>> +	vcm_type = kstrdup(obj->string.pointer, GFP_KERNEL);
>>>>>
>>>>> Where is the counterpart kfree()?
>>>>
>>>> The vcm-type is stored in one of the generated sw-nodes and the ipu-bridge
>>>> code only creates those once and them leaves them in memory, even on
>>>> a rmmod. So this is deliberately leaked just like that the ipu_bridge
>>>> struct which contains all the swnode-s is deliberately leaked by
>>>> ipu-bridge.c
>>>
>>> Should we worry about those leakages?
>>
>> No this is by design because removing the swnodes while e.g. a sensor
>> driver might still be bound to the i2c-client is trouble-some and
>> the callers of ipu_bridge_init check if it has already run and then
>> skip calling it.
>>
>> So after a rmmod + modprobe of the atomisp / ipu3-cio2 driver
>> ipu_bridge_init() will not get called a second time. Instead
>> the old swnodes (1) which are already set as secondary fwnodes for
>> the sensor and bridge devices are re-used.
> 
> But this will be actual leak if we hot unplug/plug back the device, right?
> (I think we can do that in some [debug?] cases).

No, the kstrdup() is called from the parse_sensor_fwnode() callback passed
to ipu_bridge_init(), so it will only happen once even on unbind + re-bind
or rmmod + modprobe.

Regards,

Hans

