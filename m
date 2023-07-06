Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BCD749BE2
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 14:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjGFMfR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jul 2023 08:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjGFMfQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jul 2023 08:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FBB1BF4
        for <linux-acpi@vger.kernel.org>; Thu,  6 Jul 2023 05:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688646864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pHG+s984VgbLe4X3onhJFh+2Xs4irl46yzWa4lBXQlk=;
        b=Ya+bfTByfho/PMOp2PrMNyyvDWwj8SlqdAgOMSWhALWmoL6B6epPkWr9SG+fvTbMt2hwWR
        hlmbfc1rQh1gdEh+NXSLSs+453mMo/pQOHAQCxZIvRQAIRV29sqgqAca6CW/MXHbK74xAq
        l+NmgNzhrjUMkp9Vt1LxsMpgr9F3NME=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-tXO6XjXtNTiLznbpzqO4yg-1; Thu, 06 Jul 2023 08:34:23 -0400
X-MC-Unique: tXO6XjXtNTiLznbpzqO4yg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-987a0365f77so46630266b.1
        for <linux-acpi@vger.kernel.org>; Thu, 06 Jul 2023 05:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688646862; x=1691238862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHG+s984VgbLe4X3onhJFh+2Xs4irl46yzWa4lBXQlk=;
        b=NFvbt5PQrl/N/NSgxTiCQ/ZTuY75kAXw00xDYBZ+zcygIA1E1tum4Y3iD0qVS7J/wM
         GkT1rJSiQOsT12bi2GhdQHmB4DxoHRbanxDeq5bh2nHfdsmlYVskoQOHTz+idKDGleqN
         KQgi0Wqitn+yJ4rsWEBNAmx35Wlj9515Pkz4Tl/m5UgA1Zio6o9AzYYCWuyhn3YdUIaO
         IkIKppGpE3jIODJRZ2v/RiDMNOnk/yNYykTV1QmJtsE+EnYwl9cm5ZyoVZratrt0E6QE
         dHCOaFimB3GEz9f9KPux4VFf9KSrsHHpObQMDNEmJcLoR9uT2GzSaHDpbPA59VnnpUwT
         HeBw==
X-Gm-Message-State: ABy/qLZFRmymCJIAppVSB2iAfwRTeKt0Wa6jdDAkpr19Jur4oJkj3s5d
        ng16Svjqilz0OFtkExA5wSoDcuzMW/DEcpAsqJ0gPHklL6dse0gOOfR1M4T+PDMMPOkvbe49PF1
        GNsOKqWzx+j4lu49hYcCcqg==
X-Received: by 2002:a17:906:ad91:b0:992:7197:e4d5 with SMTP id la17-20020a170906ad9100b009927197e4d5mr1591823ejb.70.1688646862708;
        Thu, 06 Jul 2023 05:34:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG55R1bBe9g4GFmg/UIczBx0K5fBkSyyHFhPezjRHgXDe9iFbXvcHKZw11jbjtlExNBq9TO9g==
X-Received: by 2002:a17:906:ad91:b0:992:7197:e4d5 with SMTP id la17-20020a170906ad9100b009927197e4d5mr1591808ejb.70.1688646862418;
        Thu, 06 Jul 2023 05:34:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ju14-20020a17090798ae00b00992b3ea1ee4sm774771ejc.149.2023.07.06.05.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 05:34:21 -0700 (PDT)
Message-ID: <e0aae289-44ef-354b-64d8-86a8546ab776@redhat.com>
Date:   Thu, 6 Jul 2023 14:34:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 14/18] media: i2c: Add driver for DW9719 VCM
Content-Language: en-US, nl
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Kate Hsuan <hpa@redhat.com>,
        Hao Yao <hao.yao@intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
        linux-media@vger.kernel.org, Daniel Scally <djrscally@gmail.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
 <20230705213010.390849-15-hdegoede@redhat.com>
 <CAPY8ntBsWqibbnxPszHE74wVo7dtwG2wk-JtR3258WArJ+U8PQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAPY8ntBsWqibbnxPszHE74wVo7dtwG2wk-JtR3258WArJ+U8PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Dave,

On 7/6/23 13:18, Dave Stevenson wrote:
> Hi Hans
> 
> On Wed, 5 Jul 2023 at 22:33, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> From: Daniel Scally <djrscally@gmail.com>
>>
>> Add a driver for the DW9719 VCM. The driver creates a v4l2 subdevice
>> and registers a control to set the desired focus.
>>
>> Signed-off-by: Daniel Scally <djrscally@gmail.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v3 (Hans de Goede)
>> - New patch in v3 of this series based on Dan Scally's initial
>>   DW9719 upstream submission:
>>   https://lore.kernel.org/all/20211128232115.38833-1-djrscally@gmail.com/
>> - Drop hack to enable "vsio" regulator, this is no longer necessary
>>   now that there is a device-link making the VCM a runtime-pm consumer
>>   of the sensor
>> - Add checking of device-properties for sac-mode and vcm-freq,
>>   as requested by Sakari, this is done similar to the dw9768:
>>   Documentation/devicetree/bindings/media/i2c/dongwoon,dw9768.yaml
>>   Note no devicetree binding doc is added since currently only
>>   i2c_device_id enumeration (instantiated by IPU bridge) is
>>   supported
>> ---
>>  MAINTAINERS                |   7 +
>>  drivers/media/i2c/Kconfig  |  11 +
>>  drivers/media/i2c/Makefile |   1 +
>>  drivers/media/i2c/dw9719.c | 427 +++++++++++++++++++++++++++++++++++++
>>  4 files changed, 446 insertions(+)
>>  create mode 100644 drivers/media/i2c/dw9719.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 494682dd437f..cf8e799f6ea2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6266,6 +6266,13 @@ T:       git git://linuxtv.org/media_tree.git
>>  F:     Documentation/devicetree/bindings/media/i2c/dongwoon,dw9714.yaml
>>  F:     drivers/media/i2c/dw9714.c
>>
>> +DONGWOON DW9719 LENS VOICE COIL DRIVER
>> +M:     Daniel Scally <djrscally@gmail.com>
>> +L:     linux-media@vger.kernel.org
>> +S:     Maintained
>> +T:     git git://linuxtv.org/media_tree.git
>> +F:     drivers/media/i2c/dw9719.c
>> +
>>  DONGWOON DW9768 LENS VOICE COIL DRIVER
>>  L:     linux-media@vger.kernel.org
>>  S:     Orphan
>> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
>> index 26dc365365d8..4864f1df3c7a 100644
>> --- a/drivers/media/i2c/Kconfig
>> +++ b/drivers/media/i2c/Kconfig
>> @@ -875,6 +875,17 @@ config VIDEO_DW9714
>>           capability. This is designed for linear control of
>>           voice coil motors, controlled via I2C serial interface.
>>
>> +config VIDEO_DW9719
>> +       tristate "DW9719 lens voice coil support"
>> +       depends on I2C && VIDEO_DEV
>> +       select MEDIA_CONTROLLER
>> +       select VIDEO_V4L2_SUBDEV_API
>> +       select V4L2_ASYNC
>> +       help
>> +         This is a driver for the DW9719 camera lens voice coil.
>> +         This is designed for linear control of voice coil motors,
>> +         controlled via I2C serial interface.
>> +
>>  config VIDEO_DW9768
>>         tristate "DW9768 lens voice coil support"
>>         depends on I2C && VIDEO_DEV
>> diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
>> index d175a2e2fb19..745f8d07e649 100644
>> --- a/drivers/media/i2c/Makefile
>> +++ b/drivers/media/i2c/Makefile
>> @@ -32,6 +32,7 @@ obj-$(CONFIG_VIDEO_DS90UB913) += ds90ub913.o
>>  obj-$(CONFIG_VIDEO_DS90UB953) += ds90ub953.o
>>  obj-$(CONFIG_VIDEO_DS90UB960) += ds90ub960.o
>>  obj-$(CONFIG_VIDEO_DW9714) += dw9714.o
>> +obj-$(CONFIG_VIDEO_DW9719) += dw9719.o
>>  obj-$(CONFIG_VIDEO_DW9768) += dw9768.o
>>  obj-$(CONFIG_VIDEO_DW9807_VCM) += dw9807-vcm.o
>>  obj-$(CONFIG_VIDEO_ET8EK8) += et8ek8/
>> diff --git a/drivers/media/i2c/dw9719.c b/drivers/media/i2c/dw9719.c
>> new file mode 100644
>> index 000000000000..7b83ae102131
>> --- /dev/null
>> +++ b/drivers/media/i2c/dw9719.c
>> @@ -0,0 +1,427 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2012 Intel Corporation
>> +
>> +/*
>> + * Based on linux/modules/camera/drivers/media/i2c/imx/dw9719.c in this repo:
>> + * https://github.com/ZenfoneArea/android_kernel_asus_zenfone5
>> + */
>> +
>> +#include <asm/unaligned.h>
>> +
>> +#include <linux/delay.h>
>> +#include <linux/i2c.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/types.h>
>> +
>> +#include <media/v4l2-common.h>
>> +#include <media/v4l2-ctrls.h>
>> +#include <media/v4l2-subdev.h>
>> +
>> +#define DW9719_MAX_FOCUS_POS   1023
>> +#define DW9719_CTRL_STEPS      16
>> +#define DW9719_CTRL_DELAY_US   1000
>> +#define DELAY_MAX_PER_STEP_NS  (1000000 * 1023)
>> +
>> +#define DW9719_INFO                    0
>> +#define DW9719_ID                      0xF1
>> +#define DW9719_CONTROL                 2
>> +#define DW9719_VCM_CURRENT             3
>> +
>> +#define DW9719_MODE                    6
>> +#define DW9719_VCM_FREQ                        7
>> +
>> +#define DW9719_MODE_SAC_SHIFT          4
>> +#define DW9719_MODE_SAC3               4
>> +
>> +#define DW9719_DEFAULT_VCM_FREQ                0x60
>> +
>> +#define DW9719_ENABLE_RINGING          0x02
> 
> This register setup and the ramping up/down code is nearly identical
> to the existing dw9807-vcm driver[1]. Admittedly that doesn't expose
> SAC (Smart Actuator Control) for damping the movement, but dw9807 does
> support it.
> 
> The only really quirky bit here is the "Jiggle SCL pin to wake up
> device", but I can't find a datasheet to know anything more about
> that. The other apparent distinction would be whether DW9719 has the
> VBUSY bit in the status register that dw9807 is abiding by, whilst
> this driver doesn't.
> 
> Should this be a new driver, or a variant of dw9807-vcm?

That is a good question and there also have been lots of other
remarks on this driver / patch.

So lets continue with this series without this patch (it is
not necessary for the rest of the series) and then I'll submit
a new version of the patch as a new standalone series/patch
when I have some time to work on this more.

I'll then also check to see if instead of this driver a patch
to modify dw9807-vcm makes more sense.

Regards,

Hans


