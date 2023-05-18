Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574127087C6
	for <lists+linux-acpi@lfdr.de>; Thu, 18 May 2023 20:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjERS2D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 18 May 2023 14:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERS2C (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 May 2023 14:28:02 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B379E1B5
        for <linux-acpi@vger.kernel.org>; Thu, 18 May 2023 11:28:00 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9659dee48edso53107966b.0
        for <linux-acpi@vger.kernel.org>; Thu, 18 May 2023 11:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684434479; x=1687026479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jjE5UGRXSEQl4iEiVnTPgqw9PE4bzpNmR1Bt2jvPKQ=;
        b=eUmwKR8INP6D9xtkaye6mQSuMpNgZLqbRdI1i+cp5Lm43RBDgfEDdnqjLgGcFO93yy
         i35A5svYQYaiaMlsC+5V27PKUBzr3ulpLcSx4YYBugxoci3xJfksIwaVnBjvvprkdKi9
         KCoKM1ufkIbAtOV8dQJEqOE/Yl+ghHqjq7Sg354xgapHYzUNIC8VAE5EX1G3FKYFDDYQ
         URJ6iz77MIvXiZ2mH7z/ZdHwnc7ojp2cHJnNed/SwTBOahsxHiySjGhHlh5JvqnFUCqR
         smplRDX1kk+mS+i8hdhHMZyJ1+uoVXHOlSd9MQzeAcHFSEd+b2/68c58C6QVnQFrWTG0
         MNGg==
X-Gm-Message-State: AC+VfDwogseQjxnRmLIbQA9EF7n3JXt7IBembsMKLMTrmrbT9SANlAtV
        SymxixYXOWWu+BxKAuucDbGjIH9rWKn4uA6/ZAY=
X-Google-Smtp-Source: ACHHUZ6D9/YXJQbodKbs/CtNUQqO5h21Kv6xCGRq8+MJDyeauWrH0hZBAlbUtdje0ik0dJSryRFcmAAviNFcKs5rGKI=
X-Received: by 2002:a17:906:ce:b0:965:9db5:3821 with SMTP id
 14-20020a17090600ce00b009659db53821mr6743914eji.7.1684434479086; Thu, 18 May
 2023 11:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230517092359.73840-1-hdegoede@redhat.com>
In-Reply-To: <20230517092359.73840-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 May 2023 20:27:48 +0200
Message-ID: <CAJZ5v0jpFdb-_tmCXZ+xU8oqHMeEKxZw4mgMZK3rQ=950CMA8Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI: video: Add 2 new backlight=native DMI quirks
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

On Wed, May 17, 2023 at 11:24 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> Here is a series adding 2 new backlight=native DMI quirks to video_detect.c
> note the first patch is a resend for a patch which seems to have fallen
> through the cracks.

It hasn't, but my queue processing speed is not fantastic ATM.

> I've included that here again since patch 2/2 will
> show a conflict if 1/2 is nor merged first.

Both applied as 6.5 material, thanks!

> p.s.
>
> Talking about unmerged patches, FYI I also have the following series +
> 2 separate patches still pending:
>
> https://lore.kernel.org/linux-acpi/20230429103841.6988-1-hdegoede@redhat.com/
> https://lore.kernel.org/linux-acpi/20230429163458.73479-1-hdegoede@redhat.com/
> https://lore.kernel.org/linux-acpi/20230509124100.288814-1-hdegoede@redhat.com/

I'll get to these.
