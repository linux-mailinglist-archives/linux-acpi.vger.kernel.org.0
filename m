Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB435BCE41
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Sep 2022 16:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiISONs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Sep 2022 10:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiISONr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Sep 2022 10:13:47 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8E03207A
        for <linux-acpi@vger.kernel.org>; Mon, 19 Sep 2022 07:13:46 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-3321c2a8d4cso341261937b3.5
        for <linux-acpi@vger.kernel.org>; Mon, 19 Sep 2022 07:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=5N+aMihLorZXBHcklDfHgYNT/W4ZQvt0cLc1vwY1KVE=;
        b=mUWl7S2Y4/CWgqFso+XmN6Xqp8+CFE05l7JuQpZyPgBkK+hCv4nAf5riUlWYlCEvT4
         5Qky6Sqf87ecwSE6ZgnN/M4JNgb90eWdXgvublcOBvJ4fmSXto+LIN17Nd+Zo7LkKAXH
         JiFkCIcsM4TzAFdhHNb4/dvx19hVFUsWVLCQeexD0+XseruCvKpUl3dGh0D334YkmTHI
         VmtrQ3fTwTXkV5l50FR04UN5RMTqmDkNSISD/PkMGvv0O95GNPhQ0hzc9I6ayYV1BhHx
         MEoi6AxmJxiODxUnIj2Hd0gj/rRMdCp1bmwPwXIY3ff8pNSca2pGQXJpLDpwHL7VxXVq
         tLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5N+aMihLorZXBHcklDfHgYNT/W4ZQvt0cLc1vwY1KVE=;
        b=8PIWihg0O50LA5ywV3gkCx/2UTagwJdR2iw5ZkA3uzfdxX6TBl8b5iB4pk1zGDsfKr
         q1I7c4/F7urk72ubFcYxKZ8KIhqDlOwY76MFoKMZpb1FEno09LQXqr0aMP97ipgUxfZy
         gyMIL2j0zW8vZoMwgszfgG62eaA7EHhA7F27U8UZYpeTe7iwL12W33ndZPgWnG/OXtN7
         sgI2mZDXS2rUCfoqWR904PjKHRpgZ49OCeoaV8Kq0J3kS+I+xN++uOfLtaFwMn4N7E5D
         Gkuv0eSuMut8g6wa98vUNc3/A66pblwZtj2TBBIwaYbgos4NI6GMi2vuk+jcogl+3d1t
         USrA==
X-Gm-Message-State: ACrzQf21ztLchQnNcgTLK38/Nj/sFcl/Ma4hyyemE6dS0s5NjXgdWYlP
        VUWfF08PzRNg6JR1f0MU6aswnnYA7HBMxbBJmcs=
X-Google-Smtp-Source: AMsMyM7Ef0u62N/5DUXX0q86EAugLF0XHftnjQsZCYkMa85rQjam7b1SYONFq2Dyyl8oo9VHyrqGiu8Le9FphSdDf7o=
X-Received: by 2002:a81:1dd6:0:b0:349:c9c9:eb61 with SMTP id
 d205-20020a811dd6000000b00349c9c9eb61mr14822070ywd.7.1663596825274; Mon, 19
 Sep 2022 07:13:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:8e28:b0:305:bafb:f9c2 with HTTP; Mon, 19 Sep 2022
 07:13:44 -0700 (PDT)
Reply-To: jennifermbaya036@gmail.com
From:   "Mrs.Jennifer Mbaya" <tantisayo@gmail.com>
Date:   Mon, 19 Sep 2022 15:13:44 +0100
Message-ID: <CAOOke06_EYisqAAMuj_qqrsu7FL6WSsJKocc3LQa_4H1emUOPA@mail.gmail.com>
Subject: Edunsaaja
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Edunsaaja

Nimess=C3=A4si on palkinto Yhdistyneilt=C3=A4 Kansakunnilta ja Maailman
terveysj=C3=A4rjest=C3=B6lt=C3=A4, joka on osa kansainv=C3=A4list=C3=A4 val=
uuttarahastoa, johon
s=C3=A4hk=C3=B6postisi, osoite ja raha on luovutettu meille siirtoa varten,
vahvista yst=C3=A4v=C3=A4llisesti tietosi siirtoa varten.
Meit=C3=A4 kehotettiin siirt=C3=A4m=C3=A4=C3=A4n kaikki vireill=C3=A4 oleva=
t tapahtumat
seuraavien kahden aikana, mutta jos olet vastaanottanut rahasi, j=C3=A4t=C3=
=A4
t=C3=A4m=C3=A4 viesti huomioimatta, jos et toimi heti.
Tarvitsemme kiireellist=C3=A4 vastausta t=C3=A4h=C3=A4n viestiin, t=C3=A4m=
=C3=A4 ei ole yksi
niist=C3=A4 Internet-huijareista, se on pandemiaapu.
Jennifer
