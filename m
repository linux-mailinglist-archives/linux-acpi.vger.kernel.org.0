Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3EE676884
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Jan 2023 20:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjAUTcn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 21 Jan 2023 14:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjAUTcn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Jan 2023 14:32:43 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00507180
        for <linux-acpi@vger.kernel.org>; Sat, 21 Jan 2023 11:32:40 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t5so7551399wrq.1
        for <linux-acpi@vger.kernel.org>; Sat, 21 Jan 2023 11:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vuOj7Pmh+wtlsvEuWLR7B+JQ5ULsnR92v6e8rmeN4V4=;
        b=vxNV/79KVG5SXbw645DYl7ZmnzkZ2bNAl8nbl8rg4aAHlUjiekTObitSq7TqJdDhik
         xqQTQLdRL1mzqQJJGzISuY7pC3pyBMRmUXzqS1gaW9gyqK/It3JomhJlsbhSPaYZglBH
         krI9ydHERNj96zSL7OXi41OhznkUbfpjCd0trfcQAwtMgIh7wuVZhL9byrN8/6r0BpXj
         tbQpM69gMG1DefDFn2UeI/a1pqD2lJJd+ur5o4/B0sFlYwlqHOAh01l2GXnA+IwXVhXZ
         jA/FXcKoEQPDuxKko7egVshqz4TNsaYHLd+WZnxnlGbSVcF+AmbKQ1a4wfuFdurvVkeS
         TXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vuOj7Pmh+wtlsvEuWLR7B+JQ5ULsnR92v6e8rmeN4V4=;
        b=7Y5pL33jGind80WWK+eqq9w61bTxtn1Ginw8AFzU6E0RFnKgZdTbs030ZIknb+W45n
         1Mu+vxa+0gGk6oXL5+Pi8gWwJQMZk21z/lh7RE+PSASY6MC+XxbA4/bNBlGxS3KZ20hs
         yy4N4EXWVdWwY473ru+j7IU4xO3qFKA/DTPv+QRqqPBdOVNvyTiqb+mOZpxroqmhfb5k
         mY6ESVAWiXi4sU8CPgpdMVl8JyrJQy0TuiizzWxmxWeC85CgBW7nhiXIlsIdDavqY26b
         SpuVhmPvmnDRTs6ZgMOSnQvy4X0CMjfyAh+fwdDQ+UitK8npz7lbBtXyT+tjAQZDz2O9
         yQdw==
X-Gm-Message-State: AFqh2krv4TUDf0MbIF2AnQElEODRmSc0NL7Awf0Z0vnCBz9GhIH+SfHw
        0RX0xg2ZIdqrD/IIpRd36hLpQg==
X-Google-Smtp-Source: AMrXdXv0RMpmvgbs3y6gSjUbn8LMwF2nbeDJboui4DRln8AARK5jQv7yAUOUpbKN0iD5BMkvmMX5pg==
X-Received: by 2002:a05:6000:1c04:b0:232:be5d:5ee9 with SMTP id ba4-20020a0560001c0400b00232be5d5ee9mr17823457wrb.64.1674329559335;
        Sat, 21 Jan 2023 11:32:39 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id d3-20020adfe843000000b00241bd7a7165sm901114wrn.82.2023.01.21.11.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 11:32:38 -0800 (PST)
Message-ID: <e309fda8-85c1-0129-af90-6aa2cb3e36f2@linaro.org>
Date:   Sat, 21 Jan 2023 20:32:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 0/3] Thermal ACPI APIs for generic trip points
Content-Language: en-US
To:     rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rui.zhang@intel.com, christophe.jaillet@wanadoo.fr
References: <20230120231530.2368330-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230120231530.2368330-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 21/01/2023 00:15, Daniel Lezcano wrote:
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

I forgot to mention this series apply on

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git 
linux-pm/thermal

Thanks

> Changelog:
>   - V6:
>     - Changed thermal ACPI function names according the changes done in the first patch
>     - Put back the GTSH function here as it is specific to int340x
>     - Propagate the function name change from thermal ACPI
>     - Changed the functions name and prototype to return the temperature
>       instead of passing a pointer
>     - Removed the GTSH function as it does not belong to the ACPI standard
>     - Changed hysteresis -> hyst, temperature -> temp
>     - Changed message level info -> debug
>     - Changed error messages
>     - Return -ENODATA error only
>     - Fixed description functions
>   
>   - V5:
>     - Fixed GTSH unit conversion, deciK -> milli C
> 
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
>   .../int340x_thermal/int340x_thermal_zone.c    | 168 ++++------------
>   .../int340x_thermal/int340x_thermal_zone.h    |  10 +-
>   drivers/thermal/intel/intel_pch_thermal.c     |  88 ++-------
>   drivers/thermal/thermal_acpi.c                | 185 ++++++++++++++++++
>   include/linux/thermal.h                       |   7 +
>   9 files changed, 263 insertions(+), 202 deletions(-)
>   create mode 100644 drivers/thermal/thermal_acpi.c
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

