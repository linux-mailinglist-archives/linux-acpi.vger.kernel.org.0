Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056BD59AA6D
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Aug 2022 03:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241975AbiHTBPP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Aug 2022 21:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240928AbiHTBPO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Aug 2022 21:15:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D354D176
        for <linux-acpi@vger.kernel.org>; Fri, 19 Aug 2022 18:15:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e19so4867335pju.1
        for <linux-acpi@vger.kernel.org>; Fri, 19 Aug 2022 18:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=GyIdygXpERIYq0zhovmgdDSjsG4Trhk4Rphv5GwxReI=;
        b=h/CAcJeeszRSUpsHRrWjNL8ehsLBFUel5BIrCu13Hr3XLNeFnDXWiRLI+HZXbBHkf/
         MCu/HP/5KOKDzmk7zBgLD6PyndhQCFa+D7EGkjsm8/G2vlq4Xiv7sTlNDNbxOkILuSFr
         VICrSwy44DZZ/zr5FT2SDtRgbGT5C6eRoXN3I+G3ngO38XrtUJUpbenxHKbjn8muKEAP
         DBTCPtyP5HzmsZsXoX5ejMFZegUoiFZeWx9oYs5Aqww7pXSJt2mRVDpozhWAm1G+dO5A
         dhhLEPyA9NdDz3urCzZiWZW2iBQIx3hP+0knkunFXxOaFjHM9cl3ze8ZEOZ4Y1quqFgt
         kpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GyIdygXpERIYq0zhovmgdDSjsG4Trhk4Rphv5GwxReI=;
        b=OT5tGfTIDvMrdpINlCIzDuVlCZPGxzKca12qUdxLrlz4V+F9HhCMfAzPi4oQXH4h26
         Ric/umm2xN8NiMWtsMJ8azLoajtIY7LZBBVP+aIiRVI1ZrY/Inoh/p3x/AS3pkl0ZgFC
         UWpAEt+301sMeeFOpDaAZRf8vUxv/LDQz8tFt6twzVSJjKXpoSyIa/q5yu2keYuwgLJX
         9Q5m9WVnnolnIeKL93395PHhGC/J5P7KpLUmF6XDopqq5248ds/IoWKjhKuuGq5CNV1u
         1l57nyzVYfFT8TJG37U8BMGeYMlC44SOVWf1Y91R0VDc2F9AVF01Ezb7a5y+jVigYAYR
         +fFA==
X-Gm-Message-State: ACgBeo2FZw4Rt2N+TrRunG6zS2vg9bFxgGabjvXZAVtuS3nrQDP38f/I
        GwC+Qk63+/0Ibf2vJ3aKsKXMBx/sP0m2s/oBVGE=
X-Google-Smtp-Source: AA6agR5CF+zwedWTQwMvyc2fr0r7Pa6iCsCeofF3rvOFFM3c26m5Am9XejyMXw/VysVlih/IaNNqhF6KDmBrp+lOKM8=
X-Received: by 2002:a17:902:bd08:b0:16e:e00c:dd48 with SMTP id
 p8-20020a170902bd0800b0016ee00cdd48mr9884483pls.93.1660958112962; Fri, 19 Aug
 2022 18:15:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:d4d2:b0:16e:fde3:172d with HTTP; Fri, 19 Aug 2022
 18:15:12 -0700 (PDT)
Reply-To: aseanvietnam55@gmail.com
From:   ASEAN VIETNAM <yawoarouna@gmail.com>
Date:   Sat, 20 Aug 2022 01:15:12 +0000
Message-ID: <CABoxYe0pCOJFX=V3PiuPwXpDjC+EyAWHjNh7ZrirhDHjafRnMg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--=20
Hello,

You have an important message get back to me for more information.

Mr. Le Luong Minh
(Ph=C3=B3 C=E1=BB=A5c Ng=C3=A2n kh=E1=BB=91) Deputy Department of the Treas=
ury
Vietnam.
