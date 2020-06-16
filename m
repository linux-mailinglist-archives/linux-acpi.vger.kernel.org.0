Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B751FC17A
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jun 2020 00:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgFPWU4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jun 2020 18:20:56 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:39715 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgFPWU4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 Jun 2020 18:20:56 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id b14129e7;
        Tue, 16 Jun 2020 22:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=RQicizWyLHOE2iCPPK+/7SOXm9U=; b=zwqQ/g
        3Xq/tR7g2fHoBQXiJS3CWnnxoDeJkGT47tGoxmHOECjg2pvQJPYNo/Ejq0CvHM1o
        NCmge4rzYj7J/eHj9zJSeCG2eCkYQL9HaXTBeZrPxQo/3F7GTUifv5/bO4a4v1Ud
        tX/Z6mwcr0ATqWjJ5YOhLIS4J3U4wYUmcvjLJYoTjsmMdQqd2L5YBxtCdTOUFHKq
        mTD5KglvYfKuW154UJWyquve3RxyAMu6/S9EDsGIU4oyJc7XHMpgyuPBZdABo96n
        hzaxhz0tYYJKgIhXTZEKROYDp4gxesLOTbEKAPzbpWOQ+zn5bn7B9Bm251JldpEA
        sspq8gtWfQRzWYpw==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 86c41781 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 16 Jun 2020 22:02:52 +0000 (UTC)
Received: by mail-io1-f41.google.com with SMTP id y5so363070iob.12;
        Tue, 16 Jun 2020 15:20:53 -0700 (PDT)
X-Gm-Message-State: AOAM531ciYCogHcehdyvkF/zUX9H3htBgXM5v4q+IUrAQuVcj3yfD3j8
        iGpaLijqzXNdCQn2yewxtt+WsVcL9wzULYt4FHs=
X-Google-Smtp-Source: ABdhPJzh/Fg/J98wbBnb2dT30/tZcvAhpbVxMckFzIR66mY0R34JuTMP4lkUQFiOJY295tUKmsjnNdvjO8f57XidyrQ=
X-Received: by 2002:a05:6638:216f:: with SMTP id p15mr28530779jak.86.1592346052223;
 Tue, 16 Jun 2020 15:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rmAznrAmEQTOaLeMM82iMFTfCNfpxDGXw4CJjuVEF_gQ@mail.gmail.com>
 <20200615104332.901519-1-Jason@zx2c4.com>
In-Reply-To: <20200615104332.901519-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 16 Jun 2020 16:20:41 -0600
X-Gmail-Original-Message-ID: <CAHmME9oemScgo2mg8fzqtJCbKJfu-op0WvG5RcpBCS1hHNmpZw@mail.gmail.com>
Message-ID: <CAHmME9oemScgo2mg8fzqtJCbKJfu-op0WvG5RcpBCS1hHNmpZw@mail.gmail.com>
Subject: Re: [PATCH] acpi: disallow loading configfs acpi tables when locked down
To:     Len Brown <lenb@kernel.org>, rjw@rjwysocki.net
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael, Len,

Looks like I should have CC'd you on this patch. This is probably
something we should get into 5.8-rc2, so that it can then get put into
stable kernels, as some people think this is security sensitive.
Bigger picture is this:

https://data.zx2c4.com/american-unsigned-language-2.gif
https://data.zx2c4.com/american-unsigned-language-2-fedora-5.8.png

Also, somebody mentioned to me that Microsoft's ACPI implementation
disallows writes to system memory as a security mitigation. I haven't
looked at what that actually entails, but I wonder if entirely
disabling support for ACPI_ADR_SPACE_SYSTEM_MEMORY would be sensible.
I haven't looked at too many DSDTs. Would that break real hardware, or
does nobody do that? Alternatively, the range of acceptable addresses
for SystemMemory could exclude kernel memory. Would that break
anything? Have you heard about Microsoft's mitigation to know more
details on what they figured out they could safely restrict without
breaking hardware? Either way, food for thought I suppose.

Jason
