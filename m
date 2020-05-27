Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DE71E48EF
	for <lists+linux-acpi@lfdr.de>; Wed, 27 May 2020 17:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390057AbgE0PtX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 May 2020 11:49:23 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:36344 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390052AbgE0PtV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 May 2020 11:49:21 -0400
Received: by mail-ot1-f52.google.com with SMTP id h7so19532548otr.3
        for <linux-acpi@vger.kernel.org>; Wed, 27 May 2020 08:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/YEWRFK7nPzrFIIV4a6R+JM7u5FV9oYg4C3SmV7yGU=;
        b=bHkCZXrDlRiLSltB7E2GDdCdYLAyOHAvgQqd9IHaOdkYjPybIq1McKt6s0+cSThiqQ
         eQXRum54+QUoTzZdLiyD20fxF842LWdrfk5I4trXx+G71sMSLDNfzNuHn1tZPs9LduZi
         DN7sQgyxTwCd3t5+fO7JgrOIxsveqyJ0k/CBlAuAgVwHs2Vm4hjqehNF3LNDTuz6AvUi
         Jq5cX48jEy52jSKxrJKC28MjKPYZ9m2NnC7Cnypl4yVp2n2OqYZSdIUAF8ceWmgVqA6k
         wNnG6C8dOw4wOYuIrzPFoN5WRyFKz4kT5H/4FsVAeR4J3iwV5SbyzPfrFfIYNJ6vQHov
         Ey2Q==
X-Gm-Message-State: AOAM530pqUw9933SfTDVDKGqL6H/iEJsKh7tglBJBZnI0q1Jr3rXRXFy
        fCH5W+z97OtgqSqaOs9th3hCoCCxhl0MX/kuBqXslw==
X-Google-Smtp-Source: ABdhPJxos+gSPKwPjo9E/8hd7WyXGqnee0InAjdGiXRKF5Hw1a+bKE+qwLduw1zckwsETZbQUq83FTdZw0gsqjD5shs=
X-Received: by 2002:a9d:6c0f:: with SMTP id f15mr4903860otq.118.1590594560589;
 Wed, 27 May 2020 08:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <1696561.dScFM4BVNv@c100>
In-Reply-To: <1696561.dScFM4BVNv@c100>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 May 2020 17:49:09 +0200
Message-ID: <CAJZ5v0hAYRb9gZ8s=bZQ1NQrm5uUk5eLhLMwj2+pR2Apmd+WfA@mail.gmail.com>
Subject: Re: Remove last acpi procfs dirs after being marked deprecated for a decade
To:     Thomas Renninger <trenn@suse.de>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 27, 2020 at 5:33 PM Thomas Renninger <trenn@suse.de> wrote:
>
> Kernel development should not be hindered anymore by this absolutely
> outdated stuff.

Well, this is a bit vague.

I'm not against making this change, but why do it now?  Is there
anything in particular that cannot be done without it?

Thanks!
