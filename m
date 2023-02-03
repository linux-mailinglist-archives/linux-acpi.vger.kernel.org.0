Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540E868A074
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Feb 2023 18:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjBCRgv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Feb 2023 12:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjBCRgs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2023 12:36:48 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97725AC205
        for <linux-acpi@vger.kernel.org>; Fri,  3 Feb 2023 09:36:25 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so1916380wms.0
        for <linux-acpi@vger.kernel.org>; Fri, 03 Feb 2023 09:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCgGTTd6deMS9Ox4WowaJYL28gWYX/hwA4H5b8yv1Fg=;
        b=hWnORNdu1mRlfIOJE9WLnRwGdTjWqHG9L8t6s6kQ6Sb/7QpkFCMHJm46Br0iJ+6iai
         FzHLwN7P/mNCxcuHnaZDqGQjFsJEJ67hVeJ6XlZtzuclVLN+qhkwv1T1ry+LXWb57ZqF
         JvN9Hqa12BSIGdPh6cbL4Gt0JgD5k2cddjS5sFMsujNNYfMFXN8m0yERSqqRGjyKJ9s0
         f9dZxitn4WRXnWQuXNqnZGyEwSvEw9bwP5B3hvip8IttKnF4TxlClD8EO9vcePjquiaV
         huziFIFZBYs/nxh+usuGmor4kR7+15vuQoSV3zz3XFHS1WbNNNHIEX5FRtB7ygGHRuu7
         R13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCgGTTd6deMS9Ox4WowaJYL28gWYX/hwA4H5b8yv1Fg=;
        b=VRWsm9AvOwboEVfQtog6hBjPv1y7HT+xsMbTuNzP8nFWUCAA09swaY1XiPSi/++9YX
         w1ajvl1dk3+YIxWw5tIzePjhO6TsOrX25T0cl6wvL9sSpS4Vwlm7OMyhtsrQG6USQhJV
         iQ6HRbSPV8HW9Rdd5JlnKQRzbH9sXOChRX+rOdd/aV9BpqnnBclflpnW3UaDgDlgyN8w
         F2P0NGVMOspxNP6tGADUptZFmuBHueGLLr3ou2H7slbF80v8Wlksm5i+UKLLYddYU/XP
         mDxqJQe0dE85BD9cGRaieMIgRvoY8pyTfzHNyui5hyphr+TAinaHLT37DYXiQEEIi0o+
         3ftA==
X-Gm-Message-State: AO0yUKUQqTEyyJbWY+PWhspO/RqAd5PXBOJP0feoGvAo0vjf9I/o9Qyj
        Sdw1wJkdN+1v0736cBWtv6r7DA==
X-Google-Smtp-Source: AK7set8RToqo78OctPw1TvhPdxJFjkhUZ09BtTKHGuVEguJXd+Bs+rzcR0BfZk08ffK6SPj3ZWaHLA==
X-Received: by 2002:a05:600c:1c12:b0:3dc:5a9f:1c7a with SMTP id j18-20020a05600c1c1200b003dc5a9f1c7amr10560483wms.30.1675445782093;
        Fri, 03 Feb 2023 09:36:22 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n29-20020a05600c181d00b003db06224953sm3073464wmp.41.2023.02.03.09.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 09:36:21 -0800 (PST)
Message-ID: <7b73c77e-6f70-9bc3-5c34-b71e0dd6158b@linaro.org>
Date:   Fri, 3 Feb 2023 18:36:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 00/11] Generic trip points for ACPI
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230203173331.3322089-1-daniel.lezcano@linaro.org>
In-Reply-To: <20230203173331.3322089-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Please discard this version, I missed to git add my latest changes

On 03/02/2023 18:33, Daniel Lezcano wrote:
> This series introduces the generic trip points usage in the thermal ACPI
> driver. It provides a step by step changes to move the current code the
> generic trip points.
> 
> I don't have an ACPI platform, the code is not tested.
> 
> The changes are based on top of linux-pm/linux-next
> 
> 
> Daniel Lezcano (11):
>    thermal/acpi: Remove the intermediate acpi_thermal_trip structure
>    thermal/acpi: Change to a common acpi_thermal_trip structure
>    thermal/acpi: Convert the acpi thermal trips to an array
>    thermal/acpi: Move the active trip points to the same array
>    thermal/acpi: Optimize get_trip_points()
>    thermal/acpi: Encapsulate in functions the trip initialization
>    thermal/acpi: Simplifify the condition check
>    thermal/acpi: Remove active and enabled flags
>    thermal/acpi: Convert the units to milli Celsuis
>    thermal/acpi: Rewrite the trip point intialization to use the generic
>      thermal trip
>    thermal/acpi: Use the thermal framework ACPI API
> 
>   drivers/acpi/thermal.c | 683 ++++++++++++++++++++++++++---------------
>   1 file changed, 439 insertions(+), 244 deletions(-)
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

