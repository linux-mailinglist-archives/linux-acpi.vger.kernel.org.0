Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BB46DB5F7
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 23:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjDGVyX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 17:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjDGVyV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 17:54:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7DFC66C
        for <linux-acpi@vger.kernel.org>; Fri,  7 Apr 2023 14:54:20 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id o20so41717848ljp.3
        for <linux-acpi@vger.kernel.org>; Fri, 07 Apr 2023 14:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680904458;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUf+hItRUlAyl8Odc+K+o9OQqV17J58V+aP3v0kFHhk=;
        b=HDRfRiwyLM/lRXtziEze5NRPh6rgRw/JeQ+qfRM5Cqn7guhS0gRrdgIW9xOpT8Raw8
         N+2IxIYkZudLJOb6CMyliOjZ092IoXrAieqLEVohPUzsgrFKfLb9g6iAhCLHgoq4qgY4
         QkgDhMcrq2aCU/C+7DEu248Jfb3qILitbqCwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680904458;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUf+hItRUlAyl8Odc+K+o9OQqV17J58V+aP3v0kFHhk=;
        b=cfgJlG7FOFfwEKGF5vedTydR3C4+kIGE1DfTBPajnL5jsaZ/OmQXukiR9NLLGh16fF
         iUD3M6L3Kq/Hu9jrZfmqkGOX5ElaGqe8nms6BdixZsyHQI8URTs2hG5FDAGOlUlce6re
         hB0GPCGB7Yd7IEH/19pVvP/K8MRbmr8kmyqbsUUEpKUzPu1w+863wzIFkZuzLrm+LbaT
         2OzsNOj/hBYLJialsQhxhglkLyrlna4Qofjh+EX6pMq340DiNFtSJBYliyPvIP094sbq
         VFpO0l2z/ud2eHqovR4h2tFDyXQ73/QIj3vhjYpKX86RkxfjJnqKGm8rMoUxklXMps9w
         2onA==
X-Gm-Message-State: AAQBX9e16rv6p7+2t4NBg73HrKqvq8HqPDvtDR6Oq2cD5OBef9+mhWN1
        WWZIt7wq5DDWSXPqqtwiyD4mKcIDBkGyyCoNs6YULw==
X-Google-Smtp-Source: AKy350bK2tfa/ifMpJd99S5lA9yyNvRN8J9D6TZLrauRv7sSWhzgZZFM6h20BylS5hhLgn59vMCdcBgqoUJ4xAgeXvY=
X-Received: by 2002:a05:651c:1035:b0:2a5:f6f2:1ff4 with SMTP id
 w21-20020a05651c103500b002a5f6f21ff4mr917513ljm.10.1680904458705; Fri, 07 Apr
 2023 14:54:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Apr 2023 14:54:18 -0700
MIME-Version: 1.0
In-Reply-To: <20230331091145.737305-2-treapking@chromium.org>
References: <20230331091145.737305-1-treapking@chromium.org> <20230331091145.737305-2-treapking@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 7 Apr 2023 14:54:18 -0700
Message-ID: <CAE-0n53Dw1tk0vVuToTwGYrKD76O_F97QgSGricBuvuPJnG60g@mail.gmail.com>
Subject: Re: [PATCH v15 01/10] device property: Add remote endpoint to devcon matcher
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Daniel Scally <djrscally@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Pin-yen Lin <treapking@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Xin Ji <xji@analogixsemi.com>, Marek Vasut <marex@denx.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Lyude Paul <lyude@redhat.com>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Quoting Pin-yen Lin (2023-03-31 02:11:36)
> From: Prashant Malani <pmalani@chromium.org>
>
> When searching the device graph for device matches, check the
> remote-endpoint itself for a match.
>
> Some drivers register devices for individual endpoints. This allows
> the matcher code to evaluate those for a match too, instead
> of only looking at the remote parent devices. This is required when a
> device supports two mode switches in its endpoints, so we can't simply
> register the mode switch with the parent node.

Looking at this in isolation I have no idea what a mode switch is and
how it is related to drivers/base/property.c. Can you expand on this
commit text? Maybe say two "usb typec mode switches"? And maybe include
an example graph node snippet?
