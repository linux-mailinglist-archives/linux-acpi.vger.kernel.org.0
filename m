Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3DE76BC6A
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Aug 2023 20:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjHAS1R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Aug 2023 14:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjHAS1Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Aug 2023 14:27:16 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F6F2695
        for <linux-acpi@vger.kernel.org>; Tue,  1 Aug 2023 11:26:42 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso64481675e9.2
        for <linux-acpi@vger.kernel.org>; Tue, 01 Aug 2023 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690914399; x=1691519199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkkS6sKTbNQ3LRfOUF34YGw1W/C6AI1LuWBgt5ptbqM=;
        b=PAUJTPJSwDHYar5prflFDgLr9WYuNLGRiVytqbObYxBz4NiwC765P4ZeWpHq1GaA1B
         UyHP57z67sPDOLogMayFmInhBM3WS8mSR+X8fEaihsNYM3QziuBcbgQneBxaStUePMO9
         PnAZu2SktmCAr27UdcSLjkkqaYuTihJ6t70wYfejY5l+70/48O82rkrR7D2U6vuj+jzH
         N/V72sC/3zCbCGRifTxDdXiNjSTcLFSy/5gDDRsxWWAw8A3c8ZyV4ovb3fu8tp0wPgy/
         5n20lqUuKqBG2Vos1vN9H5YrdSOrdJCMdy9tBr8alTpsHUS55fCitYvReCukNw/BvfhH
         q7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690914399; x=1691519199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkkS6sKTbNQ3LRfOUF34YGw1W/C6AI1LuWBgt5ptbqM=;
        b=biECXK+YyOzpsUFNIn6hDqAkvn7FSAcTK4+StbiJ4ksLctY25mQetVcriVaa2xlfrw
         fYb5WNIjbydb2noJ9dqTI6T/RuK4aDqrhuN7qdrSfa21iEGzWIDPDWSiWW8GtsyMg8I6
         iZJAdwkcXwpWJNKqqN43ACk39eRERQKLp3I5njNIkc9wa594rbBhy/Kn0Jf0AhwSOb1L
         Ft02vhiy78lMRfVsWaRSUeDTuyjb+G1Wve7CJSNwYyeARPOXmhKSi42tbJUN5Yk2QOr8
         r/LJEkyrFIe4bU94SFr0y/NXru4YqMzTnmLXJZq4fPd+r3FdVk4J9+a+9ZN9RPfca7g2
         ek4w==
X-Gm-Message-State: ABy/qLbA/a44NE23Vi42I+yoWUDgmRizKTK1HbqecdIBZ2iHOb53cJbi
        uYaOg0e8i6HPRSHVxNHG4AmhBAezc7NjV+d/RL0=
X-Google-Smtp-Source: APBJJlEvl0U1CkOCk4yo2BP4YgAaX+oApkF7ouGt3yLZCdapsYEkGjbOpcv+6UOfUkCRSIjzL0c9Tw==
X-Received: by 2002:a05:600c:220a:b0:3fe:2b76:3d7 with SMTP id z10-20020a05600c220a00b003fe2b7603d7mr1622998wml.10.1690914398970;
        Tue, 01 Aug 2023 11:26:38 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n19-20020a7bc5d3000000b003fbc30825fbsm14480448wmk.39.2023.08.01.11.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 11:26:38 -0700 (PDT)
Message-ID: <728e22ab-f68c-a891-f4d0-3d66cd03e9ec@linaro.org>
Date:   Tue, 1 Aug 2023 20:26:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/8] ACPI: thermal: Use trip point table to register
 thermal zones
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <12254967.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Hi Rafael,

On 25/07/2023 14:02, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This is the second iteration of the $subject patch series and its original
> description below is still applicable
> 
> On Tuesday, July 18, 2023 8:01:20 PM CEST Rafael J. Wysocki wrote:
>>
>> This patch series makes the ACPI thermal driver register thermal zones
>> with the help of thermal_zone_device_register_with_trips(), so it
>> doesn't need to use the thermal zone callbacks related to trip points
>> any more (and they are dropped in the last patch).
>>
>> The approach presented here is quite radically different from the
>> previous attempts, as it doesn't really rearrange the driver's
>> internal data structures, but adds the trip table support on top of
>> them.  For this purpose, it uses an additional field in struct thermal_trip
>> introduced in the first patch.
> 
> This update is mostly related to the observation that the critical and hot trip
> points never change after initialization, so they don't really need to be
> connected back to the corresponding thermal_trip structures.  It also fixes
> an error code path memory leak in patch [5/8].

I've been through the series. It is really cool that we can get rid of 
the ops usage at the end of the series.

However, the series introduces a wrapper to the thermal zone lock and 
exports that in the public header. That goes in the opposite direction 
of the recent cleanups and obviously will give the opportunity to 
drivers to do silly things [again].

On the other side, the structure thermal_trip introduces a circular 
reference, which is usually something to avoid.

Apart those two points, the ACPI changes look ok.

Comments in the different patches will follow

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

