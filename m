Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA31445233
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Nov 2021 12:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhKDLb5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 4 Nov 2021 07:31:57 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:36589 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKDLb5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Nov 2021 07:31:57 -0400
Received: by mail-ot1-f41.google.com with SMTP id r10-20020a056830448a00b0055ac7767f5eso7770333otv.3;
        Thu, 04 Nov 2021 04:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eEExj6i05wPUp1wi7tN5SgnGp5/UYcEmTl+YJODnmn4=;
        b=TqbBZNHKT0A7m9W9ZvtflrXWy/ThBEnbpYdyPJmG79f8/5HtSHdy6L2TyonsIbv3QT
         efvNUI6Y9e2HE6WPM7ASDn5wJsdwZy1ox2GLxehgU8ljwcGGYWSxcierNb0uFm2Zlaty
         OmukX6TKBqBoXC0NgqAqGpIiyfWpXJ7Rvr5oi+YOahQ8TyLuPRE3puFBkozo2qi3j0Rs
         W+o/JqbXhjdXpnXpvb2q1cgTAGpssZo5bdRpDyUfaJbuPvT24V3oW0SYHXEwD2Mf6mZf
         3bn7+HqykOt2rs+IB0UKz6RVPD3SkIYQsBJhFy9T6SQqx6e6iPZzBIbDVc1FA2jP8NXk
         SMaw==
X-Gm-Message-State: AOAM5324LZQs0lpHzyEGSZVY6w+n5nAEtxaHMVdu4vpVC6cXNKe9kDWB
        sUX8m305ra2MCoxRhgQek1IPBinpPe+iXN5CXXc=
X-Google-Smtp-Source: ABdhPJw/YUxlhi6f3PLQdlPXIr1aQW1J1lgPjhbsPOISxNWuHm7MHufuAdZ4KOx+o8YvCtPxW1JV6UVVe6e/p2+uLLw=
X-Received: by 2002:a05:6830:1af0:: with SMTP id c16mr36162646otd.16.1636025359375;
 Thu, 04 Nov 2021 04:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211103055119.19312-1-wangzhitong@uniontech.com>
 <CAJZ5v0gS5Mo3REP-Y14gxUWge3avdiANHXi51R+mwz+EOBi_1w@mail.gmail.com> <tencent_5EE3079906D3D5211516C198@qq.com>
In-Reply-To: <tencent_5EE3079906D3D5211516C198@qq.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Nov 2021 12:29:07 +0100
Message-ID: <CAJZ5v0h03-SpqTmX5gFvocdKTTcsjcn5oTmPmcG5FySu=Lh3jg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: fix error "do not initialise statics to false"
To:     =?UTF-8?B?546L5b+X5qGQ?= <wangzhitong@uniontech.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 4, 2021 at 3:33 AM 王志桐 <wangzhitong@uniontech.com> wrote:
>
> hi  Rafael J
>
>   Thank you for your reply， Forgive me for my limited level 。
>   I do't understand your means:
> "Applied as 5.16-rc material with rewritten changelog and subject, thanks!"
> Please help me ， Please help guide ， How do I need to modify my patch.

You don't need to change it, I've changed it myself.

Basically, I've retained the code changes, but I've modified the patch
subject and description.
