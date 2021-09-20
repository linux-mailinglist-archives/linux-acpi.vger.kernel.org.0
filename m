Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3183D4112D3
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Sep 2021 12:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhITK1H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Sep 2021 06:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbhITK1H (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Sep 2021 06:27:07 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBF5C061574
        for <linux-acpi@vger.kernel.org>; Mon, 20 Sep 2021 03:25:40 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id g16so10806658uam.7
        for <linux-acpi@vger.kernel.org>; Mon, 20 Sep 2021 03:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=QSp9JWX4XAHKXl7X56VeCQC0onvxbHHBBOV+a/7+PNE=;
        b=kqcVbgOTRikArLdjOfSNYep6sU4/LrmYndQgv1J5WNvTFp2JzIsvIYXfBq/3xdAcQb
         2NEqeUEiWECI2KwYWmbaLjQJDqFWLgi+ieYRvT4RJ5THCiOx4+AhApj14HH6EVCG/W7G
         ObPXbwYU6AvASdg+mWBTsRBhFBN07SWtDf2wamXClrNG62cjciM6PMgW2JWS0Fthqods
         FqZxcEbMyARmc9s5/D3ammsxQeYG17KJfSYcgX9rpDoqIwNtAMJQO0rvjgR28UUZJ19M
         eEqooysfPR8AJjAaOeA+zMOG+hXvK+WA9+rWLUPPvs5c5xRHlwJERq6TitpzIOP4imMR
         DQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=QSp9JWX4XAHKXl7X56VeCQC0onvxbHHBBOV+a/7+PNE=;
        b=Wv/VNN2gScu5qYWx51IYpqBA49QYLZC4rAepx1Jn7pW5MnERDtUa/1gK8GE9k3aqLH
         Qli3JjexKWLjcErS4o4PX7ySP+ysHG45KovlgG5ytoPJc8ezeirMmUL777ip9rbO+t/B
         63FPdcTRj+vHnolrnao2kFos0yYdrDzbHoTyeOUw1r9fTBUCFf0f29FUYt40xpdR4RnF
         cAEtkcoW354TVVBN68c5MBg0A79ml2Uo3TGzp4bRxgqmwan9NH8jJn8aToQJ7ijUR/vk
         Kq0f1wVJj8mSxEOtuUQG66HGKS8d1x35IdBjaqs1zHqIxjeeoYhTG9nkIlrbdlElNxNz
         16qg==
X-Gm-Message-State: AOAM5318BshURM7SF3Ckk3xf/NmFLeVkk1DJGuaPcwQtnSQw365dQmRx
        yunblZ8/OqGrUrthU1SmJesFp9EEIlQZYXUpBZ8=
X-Google-Smtp-Source: ABdhPJwizwl9FI0EwR1MGYrWR+dWYjtL4wWLCONZoBGJj1ZcrQMkPHZvZzIj+ipS5+iK7S9AitEdLZIHZbAmirqjTKo=
X-Received: by 2002:ab0:3b92:: with SMTP id p18mr11339080uaw.134.1632133539668;
 Mon, 20 Sep 2021 03:25:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:c470:0:b0:227:7818:73f8 with HTTP; Mon, 20 Sep 2021
 03:25:38 -0700 (PDT)
Reply-To: headoffcedirectorwu3@gmail.com
In-Reply-To: <CANaBqeBJjO7xN3E6sFuUHaU_ggArHO_CT8Cu1y2zWq14v0CCTg@mail.gmail.com>
References: <CANaBqeBJjO7xN3E6sFuUHaU_ggArHO_CT8Cu1y2zWq14v0CCTg@mail.gmail.com>
From:   BANK Director <officebankdirector0@gmail.com>
Date:   Mon, 20 Sep 2021 10:25:38 +0000
Message-ID: <CANaBqeAgzTfpBc+R+HafJrKSmrQJB-ZYFcFJ=u-PNKNCYN7CFg@mail.gmail.com>
Subject: wu
To:     officebankdirector0@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

  Our office contact , 2554 Road Of Kpalime Face Pharmacy Bet, Gulf  Lome Togo

I m bank director bring notice for you that our IMF compensation you
sum of $850,000.00 because your email address was found in one of scam
victim list. Do you willing to get this fund or not?

Sincerely
Frank Joe
Bank Director
Whatsapp, +22870248258
