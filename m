Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D932E2F59
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Dec 2020 00:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgLZXO6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Dec 2020 18:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgLZXO6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Dec 2020 18:14:58 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6743C061757;
        Sat, 26 Dec 2020 15:14:17 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id r4so5988068wmh.5;
        Sat, 26 Dec 2020 15:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eryyFYDf8MMMvLeZ4Dh3QtgjqUjg6SaNopR5osGWllY=;
        b=qZYv6EXQMmNHC9DhRXSMxJOYChP+AeaW9DfFXlByadq/SHGy1MPmSMP7F/LFKBP9cw
         Cwhnir32sL/jjsvJve7BFI7lJNaymtPdnY9etpfsbMC/SuMnTMzcsYRmRsOxyoCJgubz
         4dRpxTFOFRZkLFS/hGUq2UYB7gbkrini56AepUCjg2wkJZJWrf05AL+qr8v4C61M2nYR
         ALdxBW9EauchVPp4X4zXNWN+RwEz9a06th64YDFioktyabgTXZfQTxzl/pJv2hjNjcg/
         OmG3uIky24R336M3zsqD2V6JVUrDZjiIwHn1TY9xz/Ru4d2gsCdnLTch720I+v1N/4Le
         gYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eryyFYDf8MMMvLeZ4Dh3QtgjqUjg6SaNopR5osGWllY=;
        b=tjyaCP1ZSFEgv3VX9pOGoKMkIkFRHYNgfFBj8+UD4qN4xnGwSKNpBIVn+YWwitLxcu
         Rh6v4HeI8w6mhICWny3ZawxP2nWPy2c9rf/SoOQ4guURMEnknDzjbNFoElB97xW2REmA
         kFeS0RqOTaxB/gZQ4guAUjjOHUggOAU3rgnF2O4LdyS8OR+MxU9eTTU45GhJwBXHDwR4
         v3Fn5YatOcdrkyoLEKwo/SpW0ZRzNifv3a0fjLCzup0S5R6KQGtGO6YMZKHaA0bYcUwa
         B6eqBqbP60otRFVIkKG2Zz9Dl4WMj31L1M1aH7RdCpiOwtsOxYJPCJMroP18jBHFVuuW
         tIig==
X-Gm-Message-State: AOAM530IJhlyc3zCwWtfMxAxr9cxF/PRIpiHaGftyFxMIKpoUDE6mngE
        UqR0diDbCeWlw9k4Vw57qp8=
X-Google-Smtp-Source: ABdhPJwuF10rpm3WtaJOMqJO8lZ80gMjL5Ux/o6cTS+GoWMcwYN855GMYqKVCygMQfOxg4xVVWqxPA==
X-Received: by 2002:a1c:3cd5:: with SMTP id j204mr13796911wma.53.1609024456412;
        Sat, 26 Dec 2020 15:14:16 -0800 (PST)
Received: from [192.168.1.211] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id o23sm54117640wro.57.2020.12.26.15.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Dec 2020 15:14:15 -0800 (PST)
Subject: Re: [PATCH v3 13/14] include: media: v4l2-fwnode: Include
 v4l2_fwnode_bus_type
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
        Linus Walleij <linus.walleij@linaro.org>
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-14-djrscally@gmail.com>
 <CAHp75VdSyNv3M9T0_nQKsZfO-nxd5A3Z6o0mrRKrpHm282wsjQ@mail.gmail.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <752601ac-0c9c-bef8-5de0-aa7bf757a8be@gmail.com>
Date:   Sat, 26 Dec 2020 23:14:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdSyNv3M9T0_nQKsZfO-nxd5A3Z6o0mrRKrpHm282wsjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy

On 24/12/2020 12:32, Andy Shevchenko wrote:
> On Thu, Dec 24, 2020 at 3:13 AM Daniel Scally <djrscally@gmail.com> wrote:

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thank you

>> +/**
>> + * enum v4l2_fwnode_bus_type - Video bus types defined by firmware properties
>> + * @V4L2_FWNODE_BUS_TYPE_GUESS: Default value if no bus-type fwnode property
>> + * @V4L2_FWNODE_BUS_TYPE_CSI2_CPHY: MIPI CSI-2 bus, C-PHY physical layer
>> + * @V4L2_FWNODE_BUS_TYPE_CSI1: MIPI CSI-1 bus
>> + * @V4L2_FWNODE_BUS_TYPE_CCP2: SMIA Compact Camera Port 2 bus
>> + * @V4L2_FWNODE_BUS_TYPE_CSI2_DPHY: MIPI CSI-2 bus, D-PHY physical layer
>> + * @V4L2_FWNODE_BUS_TYPE_PARALLEL: Camera Parallel Interface bus
>> + * @V4L2_FWNODE_BUS_TYPE_BT656: BT656 video format bus-type
>> + * @NR_OF_V4L2_FWNODE_BUS_TYPE: Number of bus-types
>> + */
>> +enum v4l2_fwnode_bus_type {
>> +       V4L2_FWNODE_BUS_TYPE_GUESS = 0,
>> +       V4L2_FWNODE_BUS_TYPE_CSI2_CPHY,
>> +       V4L2_FWNODE_BUS_TYPE_CSI1,
>> +       V4L2_FWNODE_BUS_TYPE_CCP2,
>> +       V4L2_FWNODE_BUS_TYPE_CSI2_DPHY,
>> +       V4L2_FWNODE_BUS_TYPE_PARALLEL,
>> +       V4L2_FWNODE_BUS_TYPE_BT656,
> 
>> +       NR_OF_V4L2_FWNODE_BUS_TYPE,
> 
> I see that comma is in the original line, but I think it's a good time
> to remove it from this line. Since it's a terminator line we might
> prevent potential issues during review (by a different diff look) and
> at compile time (if anything comes after it).

Fair enough, I've removed it.

