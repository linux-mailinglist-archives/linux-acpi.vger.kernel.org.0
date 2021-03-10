Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C2D3338D6
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Mar 2021 10:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhCJJdy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Mar 2021 04:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbhCJJdi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Mar 2021 04:33:38 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EC2C06174A
        for <linux-acpi@vger.kernel.org>; Wed, 10 Mar 2021 01:33:38 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo10245349wmq.4
        for <linux-acpi@vger.kernel.org>; Wed, 10 Mar 2021 01:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DBkpl+xD4oZAcvKTWFgn5ufHlMadxME7etzpIVJ7NDI=;
        b=LWkPVnm4FOGXuMt/XlLDHOzZrLxjPKHbpg4ynOEaxl1Sa/LkJsFdkBBRlN6OPTyR+x
         J575prTN3E68aCQmuOI3lpQsXqs96UytsfuiesvZNC7ImZvfACP6Ws0hBnEclNPJ/myx
         Ws6LPzcIi5hknGde/f75MPvjs20KpBtdquwDhl4pN6PvvsYWOOoo+ZAT28z74gxhjGZz
         O+/Na0jU1niNXa5pRMwzrZHvGPCegEbBipGuOArYjWr47yYj/+kkJLanerfDrPOjufpj
         T0rCCtKApnDJyZweJYmfkFwLscOjQ5fYGD4mHSgHFhZue1oRC+77fKMbULmA2VYnLsTu
         de/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DBkpl+xD4oZAcvKTWFgn5ufHlMadxME7etzpIVJ7NDI=;
        b=eKfMK8WGz0hvcDlqwi8y5BBMHYzgp0OUH0BbAaQ6fgM9RcZBYOuxOykF4V1cyOG0mD
         lh2bgFCh7pKnUHRxj1pH+eh3FFcY4mfk2nYW9xKdSntB2yDsVUvinEhTJWJcAfz7F+Op
         b4fCJsY9yOgPFv/D+KTOPCov5OAKNDCmDKyn1zlz5g2HJNUYGJ6g/0ND/bZKGKOjhq4b
         rQ8XXoNDQgpYKi4VK1E+QGg62VYHVBMAnwhfAasSGT4hBZ5kfAFmoCDfNFKvBRNeXcfg
         k/Mu84JPvpjvMSX54FWc+m4r7bRhOKCAKPKpLTxov2kbcr7ZyCG2Kv4qqLPI9q65Tir2
         fJWA==
X-Gm-Message-State: AOAM533xGttHQJCDAz5soAOxbomd90K39m8rz/uw4ivofByKgvqm1F2/
        TmZBZLjihYBGg1f9QSeLptDn6g==
X-Google-Smtp-Source: ABdhPJxxc/itI5SsHSC//A+r/pQaChX9aXm0PYl5GF2BpZsZeu/Clm1aKBtk60CyvvU4AgP+zcMIDQ==
X-Received: by 2002:a05:600c:2945:: with SMTP id n5mr2433718wmd.78.1615368816817;
        Wed, 10 Mar 2021 01:33:36 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id m14sm9164174wmi.27.2021.03.10.01.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 01:33:36 -0800 (PST)
Date:   Wed, 10 Mar 2021 09:33:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     tfiga@chromium.org, sakari.ailus@linux.intel.com,
        rajmohan.mani@intel.com, rjw@rjwysocki.net, lenb@kernel.org,
        mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, wsa@kernel.org,
        andy.shevchenko@linux.intel.com,
        kieran.bingham+renesas@ideasonboard.com,
        laurent.pinchart@ideasonboard.com, hdegoede@redhat.com,
        mgross@linux.intel.com, luzmaximilian@gmail.com,
        robert.moore@intel.com, erik.kaneda@intel.com, me@fabwu.ch,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, devel@acpica.org
Subject: Re: [PATCH v3 6/6] mfd: tps68470: Remove tps68470 MFD driver
Message-ID: <20210310093334.GP4931@dell>
References: <20210222130735.1313443-1-djrscally@gmail.com>
 <20210222130735.1313443-7-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210222130735.1313443-7-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 22 Feb 2021, Daniel Scally wrote:

> This driver only covered one scenario in which ACPI devices with _HID
> INT3472 are found, and its functionality has been taken over by the
> intel-skl-int3472 module, so remove it.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
> Changes in v3:
> 	- Replaced Kconfig dependencies with INTEL_SKL_INT3472 for the tps68470
> 	  OpRegion and GPIO drivers.
> 
>  drivers/acpi/pmic/Kconfig |  2 +-
>  drivers/gpio/Kconfig      |  2 +-
>  drivers/mfd/Kconfig       | 18 --------
>  drivers/mfd/Makefile      |  1 -
>  drivers/mfd/tps68470.c    | 97 ---------------------------------------
>  5 files changed, 2 insertions(+), 118 deletions(-)
>  delete mode 100644 drivers/mfd/tps68470.c

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
