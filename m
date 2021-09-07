Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263AA402C18
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Sep 2021 17:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345389AbhIGPpX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Sep 2021 11:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbhIGPpX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Sep 2021 11:45:23 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AE3C061575;
        Tue,  7 Sep 2021 08:44:17 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so13267043otk.9;
        Tue, 07 Sep 2021 08:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H6L3JGLH5rzWIFpcToqlYPgU1lSCJF6lajc8EiNcH5s=;
        b=XnS4Cm7v8XR+aHGINA1uvkxFSWCkDw+oO+6bpdhlUo3MOWq1Vz59tYc6dWrZhb6QSb
         6hdIfSTPE9yMtXmXX7yjd2QNL+yg3bAn588y9RScXcUJiLY6kmpSSsYRKQOoRyVYSteg
         vwKM28ORF3knKfXn/rIffbOsLlBof8XKcMTmfuoofQK8QzYzzkKCM6d8hYe8FoebUw1Y
         x1E4seNlKq8cOD2l7RMe0ctODfe8D71BJH1Pze8SI2CNZe1DOUR1uTl6p34RAof2X8h2
         jS8qYLcSMm+A3dVd9HbDg8WrelPqhyTzIndgJbPugafc1jcm4hUarTbeW30o2fyh6+Bn
         B24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H6L3JGLH5rzWIFpcToqlYPgU1lSCJF6lajc8EiNcH5s=;
        b=ht+iYSJGfzVhwKMSwp3xhH64UmWRK9dLH2D4sSifBdm25HoMYhaKEF7bDylwKgw3VC
         UupGA4yBpJvxu2GXBZ5b50WH7cqYp9BH0KzVlDEH6fNCdgzUFT46xzj20Y3SJWO3tP/E
         TdqstPHkCuLRae+qcAAH4qylSl9nasCYRlxSBkLgOhhjIT4yZpbwW03CeyNduU3rdW/z
         yN0djBCBZbaZYBaDGBzEpT3sPeSTl00mgYFV2SImFwodYPR8YjzlYihjX5A/OFSPGxKL
         nFoY6GvRs4y/96BIBl3o/65JSb5B8hvYkN74BlH9kRHfj1Qs5RnD850mtv8b8qB3hKso
         FOSw==
X-Gm-Message-State: AOAM5309QdZEsfRrMFviNGwGttHU51fVDYXp1DrvUN6Z7Ct2BTmmL6sE
        Xu4GhcXizuhsBN0sGDAtX4w=
X-Google-Smtp-Source: ABdhPJzQWrtZ5rNjyrci9hxGgUVQp8QtLOQj/fgldG88YmTsraBlmhtlI3LN4jj/zy5kYUqIwOjkOg==
X-Received: by 2002:a05:6830:614:: with SMTP id w20mr16027388oti.145.1631029456288;
        Tue, 07 Sep 2021 08:44:16 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id k24sm2452777otp.31.2021.09.07.08.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 08:44:15 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     abel.vesa@nxp.com, festevam@gmail.com, heiko@sntech.de,
        kernel@pengutronix.de, lee.jones@linaro.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        mturquette@baylibre.com, rafael.j.wysocki@intel.com,
        rjw@rjwysocki.net, s.hauer@pengutronix.de, sboyd@kernel.org,
        shawnguo@kernel.org, zhangqing@rock-chips.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v4 1/4] clk: fractional-divider: Export approximation algorithm to the CCF users
Date:   Tue,  7 Sep 2021 10:44:00 -0500
Message-Id: <20210907154400.26656-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812170025.67074-1-andriy.shevchenko@linux.intel.com>
References: <20210812170025.67074-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Unfortunately, I can confirm this breaks the DSI panel on the Rockchip
PX30 (and possibly other SoCs). Tested on my Odroid Go Advance. When
I revert 4e7cf74fa3b2 "clk: fractional-divider: Export approximation
algorithm to the CCF users" and 928f9e268611 "clk: fractional-divider:
Hide clk_fractional_divider_ops from wide audience" the panel begins
working again as expected on the master branch.

It looks like an assumption is made in the vop_crtc_mode_fixup()
function in the rockchip_drm_vop.c that gets broken with this change.
Specifically, the function says in the comments "When DRM gives us a
mode, we should add 999 Hz to it.". I believe this is no longer true
after this clk change, and when I remove the + 999 from the function
the DSI panel works again. Note that I do not know the implications
of removing this 999 aside from that it fixes the DSI panel on my
PX30 after this change, so I don't know if it's a positive change
or not.

Thank you.
