Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF284C9724
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Mar 2022 21:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiCAUmU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Mar 2022 15:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiCAUmT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2022 15:42:19 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AF550E0C;
        Tue,  1 Mar 2022 12:41:37 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id g1so15399498pfv.1;
        Tue, 01 Mar 2022 12:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TuDxY2Y3DgjEY7geDOUxhhZwwH4120aDoumyCpAjTiY=;
        b=chn1tLNNsUbz59uS4Gbx+F7iSWmr2rTViZtA1d0euu5WjneMT3vYIinNhoIE+exd9E
         b0z8lTmOL8xGQQH78nmzYwdhPntPqL9SwTNyFxBl48DD2WXkPf3GgdvrB43Lcm+ziFn0
         BaWNzVD9j1IUHuNxAHCn5S8anh2udLFc6bq3aXB3Z8Oc2PXfLGhtFbRZuohXnu9ZbiMB
         OUv3TnZq20qrstuVPURmQ8/oiN6USF4KPJXXForCmCq0iCxqm97wrnV3yVBMYaHePvIF
         7n52ngsg4OKN3wSDtdzu3CicjIl1x9N9R17tx62gXYQDXY0ahCS2VqJ1VekHPq/LSJOq
         brDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TuDxY2Y3DgjEY7geDOUxhhZwwH4120aDoumyCpAjTiY=;
        b=I/5VY0VNR1umt+8F8bUv7tkn5UyeqmUXw+kirBWBwGaqrA8CImp1kNPxny3Qp96c4D
         456UeeaP4Ca4OIXlat0YPdcZq8L517etjz/UAwdYTkBMqONCMrhL9dvczfifuFs2YkeA
         jCHAqYonnt2N9of4s7k1xh+CSnGIagrdk9p3YhBEbocjFAsYrE91CxSJza6VqKphUOiT
         RY0EpQnX/P4eiDcYdrybwcBGuLJj39aZzzKx0yGR5pVC0SyKBlx7YxABF7aUGdonvz5H
         HA7RUjKffuw7kULdFh+PxUP2kNoH5SuyoXFAXoSXP5HkXN/wFMQbcHTMvJ9iBjRJtkKI
         LGIw==
X-Gm-Message-State: AOAM533K97FKtbsr3DAofXB1sTs/uxeybig9w6v1Mk1PYkxzdaa0csD3
        uPMSxCz97qY+zynA6HlPiD8=
X-Google-Smtp-Source: ABdhPJwCYn2dhcyQ/3Szh1NMeDK4pMFK/BjkCiJ72jGg1Tw4YwnTnO28ZaiCe9pw4DSe9acLtfIRHg==
X-Received: by 2002:aa7:8d0f:0:b0:4e1:31de:9080 with SMTP id j15-20020aa78d0f000000b004e131de9080mr29471174pfe.1.1646167297110;
        Tue, 01 Mar 2022 12:41:37 -0800 (PST)
Received: from google.com ([2620:15c:202:201:c110:510b:4b7b:d004])
        by smtp.gmail.com with ESMTPSA id 16-20020a056a00073000b004dfe2217090sm17628672pfm.200.2022.03.01.12.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 12:41:36 -0800 (PST)
Date:   Tue, 1 Mar 2022 12:41:33 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: soc_button_array - add support for Microsoft
 Surface 3 (MSHW0028) buttons
Message-ID: <Yh6E/QkwLl47X6IG@google.com>
References: <20220224110241.9613-1-hdegoede@redhat.com>
 <20220224110241.9613-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224110241.9613-2-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 24, 2022 at 12:02:40PM +0100, Hans de Goede wrote:
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
>    to the acpi_device itself, so instantiating a platform_device instead of
>    an i2c_client does not matter.
> 
> 2. The soc_button_array driver will not bind to the MSHW0028 device on
>    the Surface 3 Pro, because it has no GPIO resources.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please feel free to merge through platform tree.

Thanks.

-- 
Dmitry
