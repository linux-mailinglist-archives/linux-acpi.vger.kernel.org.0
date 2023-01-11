Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0979B665B3F
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jan 2023 13:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjAKMWf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Jan 2023 07:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjAKL6M (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jan 2023 06:58:12 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FDBD132
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2023 03:52:39 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ay40so10920935wmb.2
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2023 03:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dXEkUlcaRJU+IZrJi8CuXIJgOt2qGuXk03UCGnHzGW8=;
        b=yN6iKXVK/HZx6HeigqN595bqeJFf4kNM93BVsX1Ko1VOfFPizK5vyIFhlEGjTgRKpn
         EhERQVYtQkj3hw/WU1TK0papqOuxEDWyVlojbyQmOPDeWv80BWWZwklWliAPKBP3CLuU
         7kMl7muYT4BjlyvbQECmrif9aT9/6PezYGYUSuX0LGsjrOjCM3JCaUsozXxajlFoNdhf
         +2ZsLId48z8Q4iHOin+PSLNGgIPYHX1ZA3UsWrIYUtdCmUEAm9Ej7AFy9O1K3B+0iaFQ
         inrbW2z6x/BnVkUhgm+pB7F1uAqoSHYgW8b91SnzxsuNEIF+dLTHCTMiSVIs8z+EdOh7
         8RAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXEkUlcaRJU+IZrJi8CuXIJgOt2qGuXk03UCGnHzGW8=;
        b=MnRP+LrVU/XEg+wx6ZoJetOdrwKxggYK+eW7QWIyvyml/jkVKpJLHdjFbAcjSMMhUg
         rC4sGu0GYHt+CAQRTjmvAQKVqdAsuuvTQz/m0DUTxt/53IpC17NcyIfMuTbWlMygn976
         GNKCyy3X+fYRsS+OvtmMrGeyXFRSkUE5V6afIUgg7XNRPYd9lHedL0nWXfhP7GSacSR2
         CObX8Xg85tlYBBJl5xecguP0OJRtqbcDZPXoc2buVlmZsv3j8jZ1/ivz0aRP6Q9UZnJD
         oXLLeUcu0bTHJr5oN+3bDpBImVpM/Bd3i1WF2ouTXKt6ljJZmG0dfcBPWwq0X5ohhr3T
         LU/A==
X-Gm-Message-State: AFqh2kqEXNM7Ib8r+FcbHG7EZjEJmQjGW1ZMqaCddBHAhzbq8RjT33S/
        /2RYbVE/2LUAXRjbPtxYmX3ATQ==
X-Google-Smtp-Source: AMrXdXve3QwByNvRZEzXPEK1JHi8+pn3KPBas+JUTDrPGtpWx1zwbCNIAZjYptXKp2WXk+cHtfn4VA==
X-Received: by 2002:a05:600c:b90:b0:3d9:76fd:ee06 with SMTP id fl16-20020a05600c0b9000b003d976fdee06mr43025072wmb.32.1673437957647;
        Wed, 11 Jan 2023 03:52:37 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g14-20020a05600c4ece00b003d9ea176d54sm17933292wmq.27.2023.01.11.03.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 03:52:37 -0800 (PST)
Message-ID: <b070cfab-b8ab-f795-0c98-fc874f05f16b@linaro.org>
Date:   Wed, 11 Jan 2023 12:52:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 0/3] Thermal ACPI APIs for generic trip points
Content-Language: en-US
To:     rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rui.zhang@intel.com, christophe.jaillet@wanadoo.fr
References: <20230110151745.2546131-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230110151745.2546131-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Can I consider these changes ok for thermal/bleeding-edge ?


On 10/01/2023 16:17, Daniel Lezcano wrote:
> Recently sent as a RFC, the thermal ACPI for generic trip points is a set of
> functions to fill the generic trip points structure which will become the
> standard structure for the thermal framework and its users.
> 
> Different Intel drivers and the ACPI thermal driver are using the ACPI tables to
> get the thermal zone information. As those are getting the same information,
> providing this set of ACPI function with the generic trip points will
> consolidate the code.
> 
> Also, the Intel PCH and the Intel 34xx drivers are converted to use the generic
> trip points relying on the ACPI generic trip point parsing functions.
> 
> These changes have been tested on a Thinkpad Lenovo x280 with the PCH and
> INT34xx drivers. No regression have been observed, the trip points remain the
> same for what is described on this system.
> 
> Changelog:
>   - V4:
>     - Fixed Kconfig option dependency, select THERMAL_ACPI if ACPI is set
>       only for the PCH driver
> 
>   - V3:
>     - Took into account Rafael's comments
>     - Used a silence option THERMAL_ACPI in order to stay consistent
>       with THERMAL_OF. It is up to the API user to select the option.
> 
>   - V2:
>     - Fix the thermal ACPI patch where the thermal_acpi.c was not included in
>       the series
>     - Provide a couple of users of this API which could have been tested on a
>       real system
> 
> Daniel Lezcano (3):
>    thermal/acpi: Add ACPI trip point routines
>    thermal/drivers/intel: Use generic trip points for intel_pch
>    thermal/drivers/intel: Use generic trip points int340x
> 
>   drivers/thermal/Kconfig                       |   4 +
>   drivers/thermal/Makefile                      |   1 +
>   drivers/thermal/intel/Kconfig                 |   1 +
>   drivers/thermal/intel/int340x_thermal/Kconfig |   1 +
>   .../int340x_thermal/int340x_thermal_zone.c    | 177 ++++-----------
>   .../int340x_thermal/int340x_thermal_zone.h    |  10 +-
>   drivers/thermal/intel/intel_pch_thermal.c     |  88 ++------
>   drivers/thermal/thermal_acpi.c                | 211 ++++++++++++++++++
>   include/linux/thermal.h                       |   8 +
>   9 files changed, 287 insertions(+), 214 deletions(-)
>   create mode 100644 drivers/thermal/thermal_acpi.c
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

