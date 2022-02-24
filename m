Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0B04C2CBF
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Feb 2022 14:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbiBXNJH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Feb 2022 08:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbiBXNJF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Feb 2022 08:09:05 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADED264988;
        Thu, 24 Feb 2022 05:08:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c192so1064444wma.4;
        Thu, 24 Feb 2022 05:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F0Cg1LrG1AC5mF19vpeLhSAzSspyXmQ0+JpwLdBevfg=;
        b=g3rWNQJIZZV2Hd+mvZWHTkv+ieRhhcb6cENj4L3ftnPnl1TuQTSsjEMLmBL+qAqai3
         30J63HRa/kX9vIZBX5xmMW1qsWjhQDuVlHtmsODgNeuJvJ41oJ0r5TytcC4sUtOZJWFq
         8QE6J0GKz68r8pW0YBmYEDoq/WJF2KBoC22LHG4IUleAIy3c2R4X1L/pXbP4xVD8+bPb
         /Tikf1glRdAYpUvHaDAHGPAmU4pvOrA9DyXoL1vnbzUsqO1j2V+narBsG4iK8qxCmngV
         ho5cL+ZJ90TMDPx2uqD5zBFT3iBwVJThqwBrL40CsZXEOiqZCglIsJ+xd8jvpFZa6ijs
         ycmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F0Cg1LrG1AC5mF19vpeLhSAzSspyXmQ0+JpwLdBevfg=;
        b=yN+YZhqWiFTwxIlnD0tTNiGhZTK92G6twv7XivxqGJod6ITHaq4t26FNOpS+LME2rJ
         XcJheT03/1f5MY3HR8ErRoFGIEQKlfQmBiZ4pCXuHHSO22wlm1ghpKWq3g0oi2o7LCTy
         42vwJs3PKCegPlzynjN0gxLKv+kZZlu6fH42Bwet+rkwuPyGrIsle5PDhmxJjDj4g4I7
         17QjUXkK+MoPQDHFjVQs7mcxx4Ukes/q6DW8ouVqY4ibHTks4FJPn6hUcIBOzWWtjENE
         QNPwe4GFMAN/c+Wc8L90UVDj08yCl+i5ab4VJD8M5KDMO7b0Mu9gGvokF97qOAzFGAHp
         2d7A==
X-Gm-Message-State: AOAM532VOmSzJpct7M8Wt7MbaRHOIB3wGEX9EZYXU3/v2rxlpgdB6JBN
        XN3n/RtekRrhX7C9dFC4xdakNnIYtx+CKw==
X-Google-Smtp-Source: ABdhPJz4kTKGuip3L5Hhc+vfH9cplhfFvULnJPy7xqsMRmNu0Hb5ibrSVFsRXMueon1EnBNAytyQLQ==
X-Received: by 2002:a7b:cc8f:0:b0:37b:dcdf:cf40 with SMTP id p15-20020a7bcc8f000000b0037bdcdfcf40mr11632186wma.99.1645708102187;
        Thu, 24 Feb 2022 05:08:22 -0800 (PST)
Received: from [10.16.0.7] ([194.126.177.11])
        by smtp.gmail.com with ESMTPSA id n11sm2548742wms.13.2022.02.24.05.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 05:08:21 -0800 (PST)
Message-ID: <06de12d2-7bf7-01c6-e377-dcbea7c7e90c@gmail.com>
Date:   Thu, 24 Feb 2022 14:08:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] Input: soc_button_array - add support for Microsoft
 Surface 3 (MSHW0028) buttons
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20220224110241.9613-1-hdegoede@redhat.com>
 <20220224110241.9613-2-hdegoede@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20220224110241.9613-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2/24/22 12:02, Hans de Goede wrote:
> The drivers/platform/surface/surface3_button.c code is alsmost a 1:1 copy
> of the soc_button_array code.
> 
> The only big difference is that it binds to an i2c_client rather then to
> a platform_device. The cause of this is the ACPI resources for the MSHW0028
> device containing a bogus I2cSerialBusV2 resource which causes the kernel
> to instantiate an i2c_client for it instead of a platform_device.
> 
> Add "MSHW0028" to the ignore_serial_bus_ids[] list in drivers/apci/scan.c,
> so that a platform_device will be instantiated and add support for
> the MSHW0028 HID to soc_button_array.
> 
> This fully replaces surface3_button, which will be removed in a separate
> commit (since it binds to the now no longer created i2c_client it no
> longer does anyyhing after this commit).
> 
> Note the MSHW0028 id is used by Microsoft to describe the tablet buttons on
> both the Surface 3 and the Surface 3 Pro and the actual API/implementation
> for the Surface 3 Pro is quite different. The changes in this commit should
> not impact the separate surfacepro3_button driver:
> 
> 1. Because of the bogus I2cSerialBusV2 resource problem that driver binds
>     to the acpi_device itself, so instantiating a platform_device instead of
>     an i2c_client does not matter.
> 
> 2. The soc_button_array driver will not bind to the MSHW0028 device on
>     the Surface 3 Pro, because it has no GPIO resources.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Looks good to me.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com
