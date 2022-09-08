Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FA75B1415
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Sep 2022 07:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiIHFfZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Sep 2022 01:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiIHFfY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Sep 2022 01:35:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E764E60C
        for <linux-acpi@vger.kernel.org>; Wed,  7 Sep 2022 22:35:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u9so35505614ejy.5
        for <linux-acpi@vger.kernel.org>; Wed, 07 Sep 2022 22:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=5N+aMihLorZXBHcklDfHgYNT/W4ZQvt0cLc1vwY1KVE=;
        b=FDYuhrjzupqDJY40NDtCR87PKWGjMuEV/iCUW7Vw71hTR5avkj5dgW+vUUZ2+zN00C
         LlMCFbLs+3J8c1CL4nKEY5SPVAMCRxSljqhAi8BIfhxPeaUIA4rcBZYAr154yczwNuI6
         q7+c0cdb79mU6cu41DBFT/enN+0EwDBEjGeAZLkMDNpcnBn16B9P2sDZPqa6FRYzX9gY
         osyHnvDo/d16MGYFAPIQYkRYcXHOsOqf5FET1iBVQun0F8mtkePo+oMRZ+UTnn9vmyYo
         g98rXHfgW52KSb4B3Bye1QzDsCwm53Bmn0c0j8dNjTbQ/azvO1ALlyZjNVU6BIbSWcC3
         ihxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5N+aMihLorZXBHcklDfHgYNT/W4ZQvt0cLc1vwY1KVE=;
        b=XI37hMY2JhERYkoFDMKTRnXUGjj+HXyd1BRS8Lxs8jZ1rvENo8XOLudQ2KOUwDF7GA
         DvB9oEFtHOtEjCisE4MOay7enan6n9FpNk45DjThYmbFgRN2+DA+LiZBRXjnOqWL3z2K
         mlVX54QJFP6qRURr6Du3dMUtTu9PSrQol57HDBT2tNlsHU+PIwISwpc9p961rgqDOXIm
         vPVIUOJstHw19f7BU83UEvQBcj1r1Di+74ts08FA8TWTcIL/ud106nyE9H9taK9tkvvA
         aLeIW/odP2OkOBm+D7aCGIYT9GimDpYNR4tsI0p0cSJekW0NkIrprJNXs+J2GnVibQO0
         7sOA==
X-Gm-Message-State: ACgBeo33Uuwe+RiONdkqZEBUr7J/YMqHGC/COnubf9ypxSi3bt4JvR67
        PS9MZaq5J6/8CPYt4nMl9300yQOThcsOQGZrBzo=
X-Google-Smtp-Source: AA6agR6f9ganJGPnS3fCR9EUD6F+W17XWJLpchvokE0N3GHFTL+yU6BJqShw+38dQHdiM0dz0gaqHuc1cNPMmiIrUWc=
X-Received: by 2002:a17:907:a0c7:b0:76f:35bb:5795 with SMTP id
 hw7-20020a170907a0c700b0076f35bb5795mr4584556ejc.308.1662615320941; Wed, 07
 Sep 2022 22:35:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:c88d:b0:22:d711:dd with HTTP; Wed, 7 Sep 2022
 22:35:20 -0700 (PDT)
Reply-To: jennifermbaya036@gmail.com
From:   "Mrs.Jennifer Mbaya" <taibaondikwa445@gmail.com>
Date:   Thu, 8 Sep 2022 06:35:20 +0100
Message-ID: <CAJvZ1T5nrs0eSC7OwLE2OqR8Aj_ufW0QO__UhXK5qSdDW_JBAg@mail.gmail.com>
Subject: Edunsaaja
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
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
