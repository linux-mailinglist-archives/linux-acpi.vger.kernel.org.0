Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612952039D4
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jun 2020 16:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbgFVOpr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jun 2020 10:45:47 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46884 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgFVOpr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2020 10:45:47 -0400
Received: by mail-oi1-f193.google.com with SMTP id 25so15799861oiy.13;
        Mon, 22 Jun 2020 07:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6eMmHPTrb0d3gg0bQJassvP7E5X7KeEpWp5glz92jw=;
        b=P/E4loQdZAgAtU3oSllDp91RdVqRlakUsBEaSmWhvMETX+dnmy/CT5OaGTg0RXvoce
         ObKiDFgqFG5c6L9iCt0eFMAZZFCBZzGPqFadjDILsc8JfsVVzl9xxYPpnnO2a5YY6gyT
         m/yaoznCeD/vrqg5KwFsX1gDHvXqX+w5mGJcDiVc3QDXDCP6dCefbfRmw98W5Y4eP7Y0
         NMSHjBFwQ/KdRtdjGQJI7e32uFeBGxT6Bsxj3CUwT50PcvulgQWTDBd3uJBXWgdTbcdL
         M7pEGzX86jw3rSmcN3xuAcu7IxTqdA/YlCyWTEvb+z90cHnVgcGisosxTXFNVRNSnuf5
         JAkA==
X-Gm-Message-State: AOAM531vYX+EIndKy9ZYNJDWskVRSRKnNqozMs4e0eHJVT4b8gw9ASvh
        xB937uf786ZMgloVleS0sQCjVO9lUSp2VAyjseJYNg==
X-Google-Smtp-Source: ABdhPJz3XIhgbNdrEjLxuwZV8l3ADfdcwxIkEAbudMbN4QUSwurz6C7DjucnqYBFfKoN8iUAdhq9pCK6M2zUIPPYoVY=
X-Received: by 2002:aca:ab92:: with SMTP id u140mr12382604oie.68.1592837145739;
 Mon, 22 Jun 2020 07:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rmAznrAmEQTOaLeMM82iMFTfCNfpxDGXw4CJjuVEF_gQ@mail.gmail.com>
 <20200615104332.901519-1-Jason@zx2c4.com> <CAHmME9oemScgo2mg8fzqtJCbKJfu-op0WvG5RcpBCS1hHNmpZw@mail.gmail.com>
In-Reply-To: <CAHmME9oemScgo2mg8fzqtJCbKJfu-op0WvG5RcpBCS1hHNmpZw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 Jun 2020 16:45:33 +0200
Message-ID: <CAJZ5v0gPQ_5R0AQAN2TMb3m12N9egUst0+MDXTak_u0Tn13+Bw@mail.gmail.com>
Subject: Re: [PATCH] acpi: disallow loading configfs acpi tables when locked down
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On Wed, Jun 17, 2020 at 12:20 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Rafael, Len,
>
> Looks like I should have CC'd you on this patch. This is probably
> something we should get into 5.8-rc2, so that it can then get put into
> stable kernels, as some people think this is security sensitive.
> Bigger picture is this:
>
> https://data.zx2c4.com/american-unsigned-language-2.gif
> https://data.zx2c4.com/american-unsigned-language-2-fedora-5.8.png

I was offline during the last week, sorry.

Applied as 5.8-rc material with some subject/changelog edits, thanks!
