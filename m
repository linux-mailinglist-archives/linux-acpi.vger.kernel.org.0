Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15585ED98F
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Sep 2022 11:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbiI1Jyq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Sep 2022 05:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbiI1JyR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Sep 2022 05:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96791E7C2F
        for <linux-acpi@vger.kernel.org>; Wed, 28 Sep 2022 02:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664358779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2xFUdcVDWsoKQ6dRV/lMVVHVLWuHfpAMF2LfPYKj1M=;
        b=cOMy4kHtYvNAx+HbnUyt68CcgoVBL30vRlf5IBnxhdA0i5Pq/UJr9YFNEoDGzJ5L1Oq7jb
        kjjb9tx9qqJeI9Xm5OdXqfie9glGmVkMuraH9up6aqBTrkm1Mr6nXB1p2gPMhYUCbqwz88
        ahlVmrknT6gfF2shhMTWfn98wmcHB+E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-170-JqzycTweNqio_vuPR69WdA-1; Wed, 28 Sep 2022 05:52:55 -0400
X-MC-Unique: JqzycTweNqio_vuPR69WdA-1
Received: by mail-ed1-f71.google.com with SMTP id m3-20020a056402430300b004512f6268dbso10010936edc.23
        for <linux-acpi@vger.kernel.org>; Wed, 28 Sep 2022 02:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=x2xFUdcVDWsoKQ6dRV/lMVVHVLWuHfpAMF2LfPYKj1M=;
        b=AzOPL/ZyIWsuzwBZILa6cDi1OljYebkEk5HCDWqG/vNgCkjH65Em2NO0Zt/q1ejWRq
         xSQ8+8U29EP//Mp+QPS5IEz2ta2vBjKLQ6K91uPbTbjo7e8IgImWZwWDz1LC0n56RxCK
         hYRrF+4vdKmfbtM5h3ro6nkUw4A90pbgP3EURNvpWYw6PF4xtFx8BoTm8VsDGh8kzgHM
         uHvvDfzOMLakyAZfffWtKhJCg46ZEXefaa9JKatBJJZ0WVLA95v18kKjD8eTD58o61GU
         56qFjv84hGGOUUuxLapjcrIARyYmFJPbT/ZMGOWc7JREL03Zof805JC/5pu9rCEEl/gT
         GHsA==
X-Gm-Message-State: ACrzQf2TinuNN2DfUItmk5p0VeJ68s1OliAJWwfNKjnkjINieHfsKDNN
        EMr99cG2bPG6C+4FJISR2ReENWIEG6HlktRhYVrEvGqDbhbaDvvnQliL/APPxFcKzRite7ns08n
        Q0NH3gC7gwxcEw/CrmcDegg==
X-Received: by 2002:a17:907:6ea4:b0:782:6b82:a2cb with SMTP id sh36-20020a1709076ea400b007826b82a2cbmr25723795ejc.408.1664358774450;
        Wed, 28 Sep 2022 02:52:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4oAVfbH8bkInJRKLy2wfctW0MQ7NUYV8Dm4/aSxllHGsGY1mgLQX++4sFEEm8nKEUEy6HMhA==
X-Received: by 2002:a17:907:6ea4:b0:782:6b82:a2cb with SMTP id sh36-20020a1709076ea400b007826b82a2cbmr25723778ejc.408.1664358774260;
        Wed, 28 Sep 2022 02:52:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id f20-20020a50ee94000000b004482dd03fe8sm2967121edr.91.2022.09.28.02.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 02:52:52 -0700 (PDT)
Message-ID: <8d976e9c-8fea-8a67-1331-7993705c60d9@redhat.com>
Date:   Wed, 28 Sep 2022 11:52:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 0/2] platform/x86: dell: Add new dell-wmi-ddv driver
Content-Language: en-US, nl
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, mario.limonciello@amd.com,
        pobrn@protonmail.com, coproscefalo@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220927204521.601887-1-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220927204521.601887-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/27/22 22:45, Armin Wolf wrote:
> This patch series adds a new driver for a WMI interface found in
> many newer Dell machines. This interface allows to read battery
> properties like temperature and the ePPID (Dell-specific), while
> also providing fan and thermal sensor information.
> 
> The interface does support multiple batteries which are indentified
> by an "index", which appears to be the battery ACPI UID. Since
> the interface also appears to omit any bounts checking of the
> index, the ACPI battery hook mechanism is used to discover batteries.
> 
> Since the information returned when querying fan/thermal sensor
> information is currently unknown, a debugfs entry is created to
> allow for easier reverse engineering. The interface is likely
> to be replaced by a proper hwmon interface in the future.
> 
> Since the driver can potentially be instantiated multiple times,
> the ACPI battery hook mechanism had to be extended.
> 
> The first patch passes a pointer to the battery hook to the
> hook callbacks, so that they can access instance-specific data
> with container_of().
> 
> The second patch finally adds the new driver. It was called
> dell-wmi-ddv since the interface is called "DDV" by Dell software,
> likely meaning "Dell Data Vault".
> 
> The driver was tested, together with the changes made to the
> ACPI battery driver, on a Dell Inspiron 3505. Other drivers
> already using the battery hook mechanism where changed as well,
> but could only be compile-tested due to missing hardware.
> 
> ---
> Changes in v2:
> - Significantly lower the amount of changes being made to the
> acpi battery driver
> - drop unnecessary ABI description of the temp attribute
> - return 0 when a unsupported battery is found to avoid being
> unloaded
> 
> Armin Wolf (2):
>   ACPI: battery: Pass battery hook pointer to hook callbacks
>   platform/x86: dell: Add new dell-wmi-ddv driver

Thanks.

The new version looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Rafael, from my POV this can be merged through either your
tree or mine. Feel free to merge this through your tree,
or please give your Ack for merging through mine
(assuming you are ok with the changes of course).

Regards,

Hans

