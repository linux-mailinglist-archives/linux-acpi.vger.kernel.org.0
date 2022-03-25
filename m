Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524014E79B1
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Mar 2022 18:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354431AbiCYRN4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Mar 2022 13:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbiCYRN4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Mar 2022 13:13:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21BFDAFCA
        for <linux-acpi@vger.kernel.org>; Fri, 25 Mar 2022 10:12:21 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id j15so16612519eje.9
        for <linux-acpi@vger.kernel.org>; Fri, 25 Mar 2022 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=KWOnuWt5Ml3KzqpJngcT2NmMAhAasHWzFADJi14RA6Q=;
        b=Re8tzOsp1BmyLZ2bqSDGY7Z+cayC35ykjPIuDl3sZBdmxzIwY1G2Qq9XuSINo+J2Pm
         Q++JVp+J/xmj1BcW86wxfdXyFEYrcXxcnF9jWTMAycgUTitEIcWMgDbAs1uHTxj5oqvz
         z+KX6ySmyKPX1Z+VBz8Bv4z/3xvlkRpedKDG76Z9OwZYSqqebreCJB3yuzkml55G2Eee
         4+//RZ8yPeBLe2edo30rpCKbtvKncSWoVQq3+0rflsX5gp1a9f9xt8R4rbqxooEFaIKk
         kq+GtO3luUWksMck9UYiAqwM2cjndop7qlLLlC0I1CMaQ340eGQwUhWgw8ppEexdbe2z
         ctMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=KWOnuWt5Ml3KzqpJngcT2NmMAhAasHWzFADJi14RA6Q=;
        b=vPHQStKcsfB3XgTb9p8GZI1qXsr5ec03DOxzztr7qz8Bcbpuv23TpDp61d3ArlQ8xA
         GyK+zyzTDC0/hrADc6PMMV+2Fr/NWUS4spjDbwW2j3Y6OTJYFJLPpxX435mtIBat79gD
         NWHaq1Za91zGZfdHjbYks3K6mD2Q6KG7Lcsxs55bnn02rlSf+0V2mEytgVfsfUOjHA1Y
         Jff+1ItVax3QZq75XKmer3Q477/uKMS24CKjK1yAaglQ8D3h+1evgtxmVYfa6tsVBCGc
         26kvLKHbPiYW7aqhvXkaIkjvSLsobl72wV9/k9SOy1GDpXQJXL+ZdX8KGePa9mUbHncs
         bObA==
X-Gm-Message-State: AOAM531cCi8lMtN+UeQInqRog3J7Aadk0yapAIdC4Mf77KFGJb7WtwLZ
        I7+hSshvnLvJrS5bO8nZLzBnfH9QLJu9mHTl954=
X-Google-Smtp-Source: ABdhPJyUbjoP7X+MteF14astCQTJCKiH+Qzg1EHGj4pP84zaB0kQY4aML3Mf2CbwJ83Bgd4UivojXZAwZY/AQ3kZYts=
X-Received: by 2002:a17:907:d23:b0:6db:6c6:8558 with SMTP id
 gn35-20020a1709070d2300b006db06c68558mr12711055ejc.141.1648228340553; Fri, 25
 Mar 2022 10:12:20 -0700 (PDT)
MIME-Version: 1.0
Sender: denizaydinlawfirm@gmail.com
Received: by 2002:a17:906:76d6:0:0:0:0 with HTTP; Fri, 25 Mar 2022 10:12:20
 -0700 (PDT)
From:   Kwami Anthony <kwamianthony.lw@gmail.com>
Date:   Fri, 25 Mar 2022 17:12:20 +0000
X-Google-Sender-Auth: UArjkiCeg4LJKjh8Ekk9M5f55d0
Message-ID: <CABjn5WRhcnd+uv8CAXo9JramtiTkGvnvz9T4sGCFJnc_S5qi=g@mail.gmail.com>
Subject: Attention,
To:     undisclosed-recipients:;
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

Attention,

I am Barrister Kwami Anthony, I wrote to you two days ago without your
response. I have important information for you.
Waiting for your reply for more details.
Best regards,
Barrister Kwami Anthony
