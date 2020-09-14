Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDC3268495
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Sep 2020 08:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgINGMx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Sep 2020 02:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgINGMu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2020 02:12:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C047C06174A;
        Sun, 13 Sep 2020 23:12:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n14so11709851pff.6;
        Sun, 13 Sep 2020 23:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qMA4+bCENmKIAaTqxulZuH+89CCPDE5hYbEDjMHkXKs=;
        b=ImN7bFA4m+p5DOY/7dzMqVt4AhCSlCS8AvdGccNUVwUTamyKxLSHWkY458gsmDtech
         7SCCHR3iK1Gcoq1G51VrQTUu4O2gNh5+urgYaF8kNC/0KWZqBxDGMh0SsdbfN8B5HxfH
         O1nPdzOFabzFv5bxIZN+NEmR32fCvHZqHqLcwofGfFnqRMhNfMyuERItnTLDx/2qfgdN
         DzGtnoLZtIxQGe0LVfCayOipd1G+ODZAYxZtRUSdEp4nkBbA7XNQfJSce2Vlj3oTHq/d
         403h8mPgDPixm7QRfru2Qw01dVTk5nyeyDGh96hyYJztcqueKLitHTUGiqRZjFTGe1QU
         PMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qMA4+bCENmKIAaTqxulZuH+89CCPDE5hYbEDjMHkXKs=;
        b=kap24xN/23i/B4LdGdgloRx8YRj6cE8R7O8X9AVwJeUU0MuREbwyLMjgYZRrk/tUwC
         nr0rzeZ2q2ugg37IglcU6/qnbd9hZN6LkREBcf0Vbj/EHzhh+/BCZnVm2T/aA7hY6slv
         i+Wl4JwaAPOcBnVcsWx/YsffNSZw7ua14oKRODI4sKl1+SjEEgX0vNwRnpOfAoy8lKX8
         1haQBC+nfaSbp43Fnjm9K5p9slswPgaf1P5Br/+m9G8D4WMMkzXf27/rz/mymC+6THpo
         /M736vqlSPZE3fcDy7tNrXba9IH39hRLbRRFtobepmnlJYHoskkGjrmmDLIX3ExTQmvx
         RhwA==
X-Gm-Message-State: AOAM531EIT9//TS363X2LsseNo18mBN8OzdlK82GTdwJ+JFfWAf/Uked
        gCSb8axey0JtqvG56kqNYFU=
X-Google-Smtp-Source: ABdhPJxs9cVIGboCh7RXMAQIEb2NwGImTJlraPod7XpYSttMor38d9NhB8UZsugu9/+aPeKJFjX0Og==
X-Received: by 2002:a17:902:8ecc:b029:d1:7cd1:8d5b with SMTP id x12-20020a1709028eccb02900d17cd18d5bmr13148934plo.42.1600063969764;
        Sun, 13 Sep 2020 23:12:49 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id d128sm2817677pfc.8.2020.09.13.23.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 23:12:48 -0700 (PDT)
Date:   Sun, 13 Sep 2020 23:12:46 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 0/1] Input: soc_button_array - Work around DSDTs which
 modify the irqflags
Message-ID: <20200914061246.GO1665100@dtor-ws>
References: <20200906122016.4628-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906122016.4628-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

On Sun, Sep 06, 2020 at 02:20:15PM +0200, Hans de Goede wrote:
> Hi Dmitry,
> 
> This patch is a bit of a kludge, but the problem it fixes has been
> encountered on 2 different models now, so it seems that we really
> need a workaround for this.
> 
> This patch applies on top of these 2 patches:
> 
> "Input: soc_button_array - Add active_low setting to soc_button_info"
> "Input: soc_button_array - Add support for INT33D3 tablet-mode switch devices"
> 
> Which I have posted multiple times upstream already (they are from May!),
> but these have not been getting any attention.

Sorry about that, I merged them just now.
> 
> The soc_button_array code really is x86 specific glue code to translate
> various incarnations of gpio-keys in ACPI tables to gpio_keys_platform_data.
> As such I wonder if it would not be better to move this driver to
> drivers/platform/x86?
> 
> I seem to be doing most if not all of the recent work on soc_button_array,
> and soon I will be a co-maintainer of drivers/platform/x86. So having it
> there and adding me in MAINTAINERS as maintaining it seems to be best?
> 
> If you want I can do a patch moving soc_button_array to drivers/platform/x86
> and then add the other 3 patches on top and then we can merge all of this
> through drivers/platform/x86?

Sorry, misread this first time through, so already merged the 3 patches,
but I to not mind at all moving the driver to platform tree. If you send
me such a patch I will apply it.

Thanks.

-- 
Dmitry
