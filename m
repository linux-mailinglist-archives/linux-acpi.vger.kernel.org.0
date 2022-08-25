Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8A75A173A
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Aug 2022 18:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242469AbiHYQvd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Aug 2022 12:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243780AbiHYQu7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Aug 2022 12:50:59 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB95BB936
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 09:48:45 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id f4so15625317qkl.7
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zr01gl/HvI5A4zIYlSujQ2dhfFkxyVl5qw9Y7WGa/tw=;
        b=E8Tb2gMDt5Y4sthZLcRUJDciRRrgCmH1PMDfqCuTfnRZirjIZ/AEmstPHFj/WisyUd
         JHK2XjtKKIVuzV4n/KqrhNcCgZvlCh7WVA/bb8Dw1d8dsefd247tXrJjrVxPatjUV6qB
         u7Og5S8BSXewsTUrYb/N0h96PiMVS5H0Auqr7sXb5h8i2FoB5n/2UPiz1y5uSCHkSqKR
         YY20aJCyu1sPtC+uIgX+rZZefMVpimimoCTLhcRZo3tsW0vuYeY0FrIqEi1t8ssPNuqn
         wXLbYLnDERrk+erACwU/tv4IwX/JcjoVUESADH7PpXT3NyzS46RMZwe6iHbAtNo1EE8I
         punA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zr01gl/HvI5A4zIYlSujQ2dhfFkxyVl5qw9Y7WGa/tw=;
        b=Wi52xeRx8kd1vhz4OwnIDOzlF3GYoFHAeW4+y7mLxGj3zmLDQfEtejyYC+5AefmcoR
         u2U+vhYGomlcrSox8QTMDV1733jJKQY2XCawnWUR0hqfwm5f1hpzx2dxEQO6KIgyrsvH
         QWFhi6exUMIzkDvOZE/St+X1ZAvca75TrbgpGMGt9umRzrx+yE9X+9jsweZy5lEgW222
         zOY6HAwYxSx0jAImQ5ogxO/l82elkmjTYXweoidEw45N9GzoZawdNIAGGvhNSrGqNCGo
         6VwWE0jbvnb9iFYEN4rJ9zFuurGrO8dJ5AERV3UtQunMvZv9E8d7YBJLR3bvk53ozfJR
         H9zQ==
X-Gm-Message-State: ACgBeo1GsFFqSbyp2HlaAG9ZCfh1MYtdexgH1L86WQUWK3vR9/mehOJe
        dnLuQmKf3d6HrrsjvVwuFgJ18/q9UGANlbR5Tfk=
X-Google-Smtp-Source: AA6agR5/Vzcpnmf+iAhH/1FwKWHNLZDMSW3SrveehRU9Lvc8xoIbQOOvpZDB2KjHqOO2P2Jj1isVMMH2l1rWQVnFblk=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr3868686qkp.504.1661446124148; Thu, 25
 Aug 2022 09:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VczhmTTdMbj7z2DOPm+k4SWGzuLF8NyJ2FWHwhfg9HJ1Q@mail.gmail.com>
 <CAJZ5v0j=90uhWRcVWKVyDhEuVNWw-W28RoKkCwxpzNd3NLC9mg@mail.gmail.com>
In-Reply-To: <CAJZ5v0j=90uhWRcVWKVyDhEuVNWw-W28RoKkCwxpzNd3NLC9mg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Aug 2022 19:48:08 +0300
Message-ID: <CAHp75VdfMF_AyONneSMHzmX_cU_tEa97EhL43iu07+9BvFO_ZA@mail.gmail.com>
Subject: Re: ACPI ID list termination
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 25, 2022 at 3:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Aug 25, 2022 at 2:38 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > I have stumbled over __acpi_match_device() implementation and noticed
> > different types of termination of the struct acpi_device_id (ACPI ID
> > list), i.e. '{ }' vs. '{"", 0}'.
> >
> > As I read the code of the above mentioned function, I see that it
> > dereferences the id field without NULL check. This means we are quite
> > lucky (somebody before guarantees the match) we have no crash here.
>
> I'm not sure what you mean.
>
> In __acpi_match_device() id is a pointer used for walking the acpi_ids
> table (if not NULL).  Its initial value is the acpi_ids value and it's
> incremented in every step, so it cannot be NULL.
>
> The loop is terminated if both the first byte of the device ID field

^^^ (1)

> and the cls field in the current row are both zeros, so both
> termination markers in use should work.
>
> Or am I missing anything?

Yes. The ID field itself is _dereferenced_ w/o NULL check. So, compare
two ID lists:

FIRST:
  { "A", 1 },
  { "B", 2 },
  { "", 0}

SECOND:
  { "A", 1 },
  { "B", 2 },
  { }

They are different in the terminator and the above mentioned function
simply will crash the kernel if no match is found. Of course I might
miss something, but as I said it seems we are simply lucky that
somebody else (platform / device core code?) does our job.

-- 
With Best Regards,
Andy Shevchenko
