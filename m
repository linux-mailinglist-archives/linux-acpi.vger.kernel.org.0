Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C488410701
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Sep 2021 16:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbhIROTk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 18 Sep 2021 10:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhIROTk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Sep 2021 10:19:40 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5EFC061574
        for <linux-acpi@vger.kernel.org>; Sat, 18 Sep 2021 07:18:16 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id 13so4851914vkl.1
        for <linux-acpi@vger.kernel.org>; Sat, 18 Sep 2021 07:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=QSp9JWX4XAHKXl7X56VeCQC0onvxbHHBBOV+a/7+PNE=;
        b=YDyuLyPtan3sCI2xds/RVeENXO77tx7W/YzWsAn4k9INZhsjwdyjbKuMDxSboP50Ps
         8bH8fgppQ1ScttdnPHyORJRA0ZyA3pqwBeZk0Szwb5C9FGvU6q/llkDwzoztg4QfJgU/
         nrVdlSb3aZwFJ0PGifGb/ZFHSlO8DRhtO/RLmSdxA9M1C7hhDxk2hRW7T/QT8nCGrrGA
         Xnm1YUQ4WO1Tq5sgT8my3lB7gQ47SCBBrPfB7NerwownuDD4GtSlgg8E8LGY6wcNri1p
         GIBS8WtFefQVLaqmdek56VDAI+ah8W1Q4ussF/BN0ya8KEkP2eiF1Nq/96oCX1E9+Wqd
         HBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=QSp9JWX4XAHKXl7X56VeCQC0onvxbHHBBOV+a/7+PNE=;
        b=JskgqHnIR/diikfQuf4QBY/8LtARSKz23pBjGbmyD1cbMv/FoytJsGjlbbaAzTmiE7
         h72oE8xgzOdbfANkmN3H1dkB92uvrnUOMJygsfY/4E/qNJbqUGMowTZQFCk/l7jPkCXY
         RTEAzTFt9e6wCb6pNRJtzXSUi8tTZJnjvddmBMS1Ip87s0PFuScteaEAruwkSWheuc6U
         8f+EYAxv11ZlYKSvdbcaxxZ/bmUIRM4GdG/f37fo8lf6Kj/JEs4FVx1bGqtLbanyxB61
         4lF8p//Hqq4CQ5S6dEXTqKq6auNDIArMFgBO+AS+l0wNkNBTomAohms04HLH3iMTQcxC
         nYTg==
X-Gm-Message-State: AOAM533DZx/Q1pSLFyxpIxp/aZEv366PQYrnEwaMjT+2zc+7SioddZrq
        GK5/ZVfl7JP0RW6BPSaoN3CaZEgJrvdg0TvWC2o=
X-Google-Smtp-Source: ABdhPJwajyo2qMjDEf+/S4o3SDU2T77gaVtzY79DiGgAUU9r172O8DzcVtyMXRW8OnTjk4CRKqhwP5XyX06PVYwaetc=
X-Received: by 2002:a1f:a68c:: with SMTP id p134mr10934742vke.8.1631974695277;
 Sat, 18 Sep 2021 07:18:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:c470:0:b0:227:7818:73f8 with HTTP; Sat, 18 Sep 2021
 07:18:14 -0700 (PDT)
Reply-To: headoffcedirectorwu3@gmail.com
In-Reply-To: <CANaBqeDXi9pQ=vqah_8K2a0PAyep20nC7cTgb5qa5HuMDejfdg@mail.gmail.com>
References: <CANaBqeDXi9pQ=vqah_8K2a0PAyep20nC7cTgb5qa5HuMDejfdg@mail.gmail.com>
From:   BANK Director <officebankdirector0@gmail.com>
Date:   Sat, 18 Sep 2021 14:18:14 +0000
Message-ID: <CANaBqeC1kC+=m9UKZTH2f8t0Z-2k+TJ+1v86GmFT918-NLMc-g@mail.gmail.com>
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
