Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E07A62F3EB
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Nov 2022 12:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiKRLmc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Nov 2022 06:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiKRLmb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Nov 2022 06:42:31 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6273922D0
        for <linux-acpi@vger.kernel.org>; Fri, 18 Nov 2022 03:42:30 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id d123so3604325iof.7
        for <linux-acpi@vger.kernel.org>; Fri, 18 Nov 2022 03:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0CQz5nQhHHLvbYQj0zh9N0b40a6wZgwbFL9tmGZqeEg=;
        b=Tex5mwJ7x6BiFUIAp+uRoU6IkbWRJatFtMcZZBVivPg90rrh1dY3FoIv/T+Txm0AO+
         Y/GneqJSDlX0/5a65rAIJWN+IMg+4kvZ5vEva4OT+tNdpBlsXe13DO91n26LRiPmsy0R
         3UMNLatvdzW4bgxq9X+KppIQ21d2HaXuXY84q7JZ8ohKtHts2J3jsY3sgOP+ZWXil0rG
         Hra0UEvZ9hIqvt3GAuxJ0nh0mcr6vn2bURxLNUZx25pUc/+P4bMeqqnHIY4t4qN3/1mP
         TEbrfvh2Mp39F6Pykqj3l0szXondbQa9cuH8IENU61IvoWL9rW7rMjZUY5RDfKhQaI5M
         K/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CQz5nQhHHLvbYQj0zh9N0b40a6wZgwbFL9tmGZqeEg=;
        b=OXNnNDBCiiuMjxoaGtKFqJIh8lif9SkcAjp/Yw9Ycn33MpOgpx9g6ZaZPkWBbt0rgu
         RS9UdDefAt+Xx3YJeXRom3E+C9kn/kHEd+uBzzwWoj7CcitIBPcBpd2SidLsNetDpaVA
         LCt5ZzTwbgm/W1HC2YZLUad6dIqQnhnNCJIT6ZORwR2rG/HZtjOSK1imp45IVZQL7BKE
         cc2OKnScvDAVtAmFLxqQBRCxfyfmBAO82zfJMQp4OtFNvxmxiE6yJdFVKUwKVvf0jl8W
         qDvPzqADugt2nohAjy2Wo0G9meFz0pcKlDBveiNzRmZ15YGF8uhixVOIoqtINOKecirt
         igQA==
X-Gm-Message-State: ANoB5pmoskejlPLBAE3Q6J7fR4z9n6EjL2SXdw47qHDqn6jOZs5IZuP9
        mckWp4C6zuKBLLW0TlBYcwxxfLeecWvUD5zC/xjsr/Fw5elaKA==
X-Google-Smtp-Source: AA0mqf68mKmvSaXJxjVoDoeIYIUQoWgLvxSG204DiSh/FEw/PLNG/DtIhMsmwd9hr2z8gt3U7WSNPTv8aAu0Ik2eJLg=
X-Received: by 2002:a05:620a:990:b0:6fb:c6b6:e7a8 with SMTP id
 x16-20020a05620a099000b006fbc6b6e7a8mr4327414qkx.215.1668770373234; Fri, 18
 Nov 2022 03:19:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:620a:24c1:0:0:0:0 with HTTP; Fri, 18 Nov 2022 03:19:32
 -0800 (PST)
Reply-To: azimpemji251@gmail.com
From:   Azim Pemji <gsmaiturare@gmail.com>
Date:   Fri, 18 Nov 2022 12:19:32 +0100
Message-ID: <CAK8Phj43LZvyuU_zn8TYU8eDdee7hHHU6RQd_msLuyPhqiEcDg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--=20
Die Summe von 1.200.000,00 $ wurde Ihnen von Herrn Azim gespendet. F=C3=BCr
weitere Informationen wenden Sie sich bitte an azimpemji251@gmail.com
