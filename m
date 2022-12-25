Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE4A655E5E
	for <lists+linux-acpi@lfdr.de>; Sun, 25 Dec 2022 22:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiLYVbS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 25 Dec 2022 16:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYVbR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Dec 2022 16:31:17 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EFCC3E
        for <linux-acpi@vger.kernel.org>; Sun, 25 Dec 2022 13:31:16 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 186so10291716ybe.8
        for <linux-acpi@vger.kernel.org>; Sun, 25 Dec 2022 13:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1DFvd/qB2iPwiRdxjvsshI/YDS4Nv+p2asGKuDLehw=;
        b=Ahu0M99Vw1klzTk56N2yIZPwVhCrlwj0MboTw9Khz/uDPY2C9LxqXNff1DmZ801gYf
         58IKRb3CguNzEIW30mMh3N45jVDQumJDkJghyXyUxnKTyyeh9OFNH9MAd47A0HNlXi2H
         nZwFpMjx1/VJ0+Kou8IrmJ6vqSBUM07sUh3oHbAZIwWM7hiFgu4SLcCh8w3Mg3Tbo2vE
         CzshM5AdzZlMkpio3zjip/bIB9fQY3Kj1WRX59KSyVC5DJGaz8e9EmbikYQmvXkaYoBs
         NgY0vIAHFL4BardDSiqIwLcb/humOTH3kGQ2DNnpFhi9drqcDLaGNH91ZjMQlALOdrZf
         EUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1DFvd/qB2iPwiRdxjvsshI/YDS4Nv+p2asGKuDLehw=;
        b=JXSSCgq98ZLx2iPBqLDCBasUOxguNsipcdJF6fHwYPisHcnqbbYy2511E7lsSiujEN
         GRvWh02YWyKLvp1l5EohdpirJEOU+WIibUBX42qnOUfl91VpV7jW9lAFngvahJKHPrRe
         M7whuGzsS+RSvL38BjAZXmXiC88KLmIupaiVmaytGnTVHFOLzatT5wsub42ogzaOMBPa
         2QeWTAdOcuHy5i+QoVQS7gvSXqKQ7vAGrMFWYcCyk8aykwmPuOiuoV+X5IyRZtmB50qK
         uiiAAQBerM/toF+ciJZRAppPDvFHFy/TIbfsReqJ1OjKd7GhRym3DNGYuAbMWR6gECdO
         bqOQ==
X-Gm-Message-State: AFqh2krn3WI/0Vfs3bkNHWjpc2NbOegXh1xcwMwFsbr+HFotmSElbywi
        i7zSC4xG4ybRGIBsJoA4VfREmVIaOsTV5tySev4=
X-Google-Smtp-Source: AMrXdXs18lvVwODMY9P2lxYvVCXeVjkHznWHypPJb/UWj02PMmpXu15O2I0LHbqkqXezSyaCh8se8DKDBYS3uMY9P0k=
X-Received: by 2002:a25:23d1:0:b0:6f9:b1b0:67f5 with SMTP id
 j200-20020a2523d1000000b006f9b1b067f5mr1745374ybj.471.1672003867523; Sun, 25
 Dec 2022 13:31:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:5807:b0:2f3:1da0:c726 with HTTP; Sun, 25 Dec 2022
 13:31:07 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <rw372964@gmail.com>
Date:   Sun, 25 Dec 2022 21:31:07 +0000
Message-ID: <CALyrWUHzVCq_GQcOS1PBh9=cF_mUo8+n3niKFFW1j80v=XECCQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

-- 
Good Day Dearest,

 I am Mrs. Thaj Xoa from Vietnam, I Have an important message I want
to tell you please reply back for more details.

Regards
Mrs. Thaj xoa
