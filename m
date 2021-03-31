Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832B3350558
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Mar 2021 19:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbhCaRWQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Mar 2021 13:22:16 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:37845 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhCaRV6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Mar 2021 13:21:58 -0400
Received: by mail-oi1-f182.google.com with SMTP id k25so20729470oic.4;
        Wed, 31 Mar 2021 10:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4iLpiYxr/eGNHMzGTnsmJ+7wRY18tScN0YFt4/BILxo=;
        b=OfJKjl7udMqtO3mH/YeQb6lF3ZGrJV4Dg8g0ydBTuSZl/wnoEfVK9ekkEdUKuwJkI+
         TLPeV2+7iom6BqKqteyYS52w5jbvFtkkjaqVYxqWFPup9WYdt3z21I3JWwMPUenUGyZe
         YPXiQ9VRsZNrPl3yFpj7/tCdKjugE+0v6ynUmO6IhAvmNBRpquflMbsiWTfVHBUrWB1n
         b6kSBZKEI24Greb+sL2nhZ+wh1vwHt4w80Z6hj6uaRyPESzlR9MjA7vqrXc3l9kuGNvD
         kqju+H+EeFfafzi606TC1v2CG3jiy0WZ38Vk8nayFM0GCK5mNH4+k2M0obX4QqzJ00D/
         XW2g==
X-Gm-Message-State: AOAM532oR4GBfCVUquZcibuxLW1U8b4y4pykp3Bpc5MQd2wpZ84Yi4ah
        C8i4Cwk2s3mUryqi6g9w9yq+TYlC5MySnhy8tr+v6gpY
X-Google-Smtp-Source: ABdhPJwt9qyQJu4QdBjwCQqx4qAcdWkNIsIYrTsjfe1KXXw0T7nYITVfNRryF92t6jQ0UGGD2EvLJvDbUXOZb6CbXBo=
X-Received: by 2002:aca:c4c5:: with SMTP id u188mr2990883oif.71.1617211318226;
 Wed, 31 Mar 2021 10:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210331204357.4e439016@canb.auug.org.au> <ae86c684-5d63-aea5-6bff-774f1512da82@infradead.org>
In-Reply-To: <ae86c684-5d63-aea5-6bff-774f1512da82@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 31 Mar 2021 19:21:47 +0200
Message-ID: <CAJZ5v0jP50iCaz2+venkT45p+PUbpZz0duL5xeXEBQXERZjiRg@mail.gmail.com>
Subject: Re: linux-next: Tree for Mar 31 (acpi build warning)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 31, 2021 at 5:32 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 3/31/21 2:43 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > News: there will be no linux-next release on Friday or the following
> > Monday.
> >
> > Changes since 20210330:
> >
>
> ../drivers/acpi/processor_idle.c:542:15: warning: extra tokens at end of #ifdef directive
>
> #ifdef defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)
>
> s/ifdef/if/

Yup, my mistake, sorry about that.  Will fix shortly.
