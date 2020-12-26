Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B392E2F63
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Dec 2020 00:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgLZXYP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Dec 2020 18:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgLZXYP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Dec 2020 18:24:15 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDF9C061757;
        Sat, 26 Dec 2020 15:23:34 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c133so6095744wme.4;
        Sat, 26 Dec 2020 15:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hEbYb9aZ3x/VuVBuQLFVg0Cu21TzOUqlHQ/5dY4MV0c=;
        b=KeNVRTDUD1QcPSlwKwjysBF/JvAKTGMTjJJ9PZtmjI6Hqlf4jqW1I9NNdh0Y+ZTYUb
         GdIKyopt1Z+HvZ92GxR9i2vslKUADIfBsNgZ4IN68qAnqANvZkMAOKFTcLA5J2i2P+TP
         yH6qpZnr5dS54+909l1S8kwX3cUHFdtd+3pQHVOwOnXih3BCd02MAPUnSngrW1vPaGi5
         mHxJA4dMJrtuvf2TbCXVykzJN1QtfNogaM68ht0mkelV8gpuO4O0DsxSWit9mTwgAr11
         j7DNI4G2FOxYgf/Gxz9gbB+q2Ex/HAPIMneGurgL/409iU01NtOE2/dA0T7yl9K6EleU
         ybCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hEbYb9aZ3x/VuVBuQLFVg0Cu21TzOUqlHQ/5dY4MV0c=;
        b=BQTnDWHdz42M7fg45Dm8vxRujGbnNKAxM/29eoV5hoM4pQ87oSR+sQFCwAbGiing0z
         UhouOvQg/Kyj+QFgb9kbyMqAxk0H6cvQ+9oR8qqyAldDuLMAvrZyY1v0bmrN4FlI5cx3
         Hf72Fx1lhQPRWrOi6CHhpcYRC7gwiIdtpP3YlEat8tzmuutiFJs1qj/faiNLgDrHVwua
         J1Uvt0J9O9tYhNPRi9w3FXyMDwAz/lnW541I6ruvcdoKvyozLTLx4oUvGbr8ejOT5xCx
         UCPlZWTazK9XDhuTx3IPme5cKFiqLgZwGaNUUaE3IJ1ag3fbnyGqVIaNfMJUVv7Q2MGE
         wTLg==
X-Gm-Message-State: AOAM530AO3GVtNMO3ficW/M3a8wAHFTJcTusXkzVuqLbnFvfCkDVD0KI
        hPXr/ZCs2PfZCJTQ/2P8Ugc=
X-Google-Smtp-Source: ABdhPJxTHtqRZfR64FVtTkW4JbCuBPRwpLfFlB0aRJk0TyaA/KQdLvhDHhL3klc3vYN4vVvcPKPnUw==
X-Received: by 2002:a1c:4904:: with SMTP id w4mr13810932wma.140.1609025013169;
        Sat, 26 Dec 2020 15:23:33 -0800 (PST)
Received: from [192.168.1.211] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id n3sm47539441wrw.61.2020.12.26.15.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Dec 2020 15:23:32 -0800 (PST)
Subject: Re: [PATCH v3 14/14] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@acpica.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        kieran.bingham+renesas@ideasonboard.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        niklas.soderlund+renesas@ragnatech.se,
        Steve Longerbeam <slongerbeam@gmail.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-15-djrscally@gmail.com>
 <CAHp75VeXN6PnV7Mzz6UMpD+m-yjPi6XK0kx1=+-M5mci=Vb=YQ@mail.gmail.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <9cf2dfdb-09cf-668b-2e71-a52b177cfd8c@gmail.com>
Date:   Sat, 26 Dec 2020 23:23:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeXN6PnV7Mzz6UMpD+m-yjPi6XK0kx1=+-M5mci=Vb=YQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy

On 24/12/2020 12:54, Andy Shevchenko wrote:
> On Thu, Dec 24, 2020 at 3:12 AM Daniel Scally <djrscally@gmail.com> wrote:
>>
>> Currently on platforms designed for Windows, connections between CIO2 and
>> sensors are not properly defined in DSDT. This patch extends the ipu3-cio2
>> driver to compensate by building software_node connections, parsing the
>> connection properties from the sensor's SSDB buffer.
> 
> Few nitpicks below, after addressing them
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks, and for all the time you've put into this series

>> +/*
>> + * Extend this array with ACPI Hardware ID's of devices known to be working
> 
> ID's -> IDs ?

Yes, turns out I'm pretty bad at apostrophes.

>> +static void cio2_bridge_create_fwnode_properties(struct cio2_sensor *sensor,
>> +                                                const struct cio2_sensor_config *cfg)
>> +{
>> +       unsigned int i;
>> +
>> +       sensor->prop_names = prop_names;
>> +
>> +       for (i = 0; i < 4; i++)
> 
> 4 here and below, can we have a local define for them, like
> 
>   #define CIO2_MAX_LANES  4

Done and for the other place it's mentioned below.

>> +static int cio2_bridge_connect_sensors(struct cio2_bridge *bridge,
>> +                                      struct pci_dev *cio2)
>> +{
>> +       struct fwnode_handle *fwnode;
>> +       struct cio2_sensor *sensor;
>> +       struct acpi_device *adev;
>> +       unsigned int i;
>> +       int ret = 0;
> 
> You may drop this assignment and...
> 
...
> 
>> +       return ret;
> 
> ...use here
> 
>   return 0;
> 
> directly.

Done

>> +enum cio2_sensor_swnodes {
>> +       SWNODE_SENSOR_HID,
>> +       SWNODE_SENSOR_PORT,
>> +       SWNODE_SENSOR_ENDPOINT,
>> +       SWNODE_CIO2_PORT,
>> +       SWNODE_CIO2_ENDPOINT,
> 
>> +       SWNODE_COUNT,
> 
> No comma?

Done

>> @@ -1715,6 +1732,23 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
>>                 return -ENOMEM;
>>         cio2->pci_dev = pci_dev;
>>
>> +       /*
>> +        * On some platforms no connections to sensors are defined in firmware,
>> +        * if the device has no endpoints then we can try to build those as
>> +        * software_nodes parsed from SSDB.
>> +        */
>> +       if (!cio2_check_fwnode_graph(fwnode)) {
>> +               if (fwnode && !IS_ERR_OR_NULL(fwnode->secondary)) {
> 
>> +                       dev_err(&pci_dev->dev,
>> +                               "fwnode graph has no endpoints connected\n");
> 
> One line?

Done
