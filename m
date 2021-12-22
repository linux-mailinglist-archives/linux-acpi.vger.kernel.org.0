Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1323A47D7C4
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Dec 2021 20:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345239AbhLVTcR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Dec 2021 14:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345206AbhLVTcQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Dec 2021 14:32:16 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C025C061574
        for <linux-acpi@vger.kernel.org>; Wed, 22 Dec 2021 11:32:16 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id k21so7656773lfu.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 Dec 2021 11:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/qCvdauRyN2z4WAX/IWpSl7E5xdxjoJMymI+F18Bw7Y=;
        b=HkAyIz5in8en3tmDoRGYkJsU6ORNcsMf9e62Ou+GiUDCFyTHoorLLkPfenh3+7FV9A
         LbrqTzXPmocFM/aRAZN9xIkvTbG0cy1mHSl4xW9g+hadG3+JPbnqoPkBH53otMNS5afx
         +FSSfmuD9pA4Hja3po2QjxHqw2WeQbosNIW2gJYFiSQ6yRy1hHxusJT4JUQUSl5XR1oM
         H4jJ8iO0gjKKBgwRg57rzVJcpkJUQ7Bufjula5C/lyEXSw2gi1pgqxoQmogHMHNWRT0v
         N1RMHMszZ+ZU53e+wgHh+9nKz4cQlk0mfq/YEaGnwnBggBoSCczZpsIVObLU7C73kQov
         klXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=/qCvdauRyN2z4WAX/IWpSl7E5xdxjoJMymI+F18Bw7Y=;
        b=jflcxbH7bFR1aazHr3Rk39aEA69w5BWQ9eVL8q+zXq5+cxRsxuTIemiwp2KoRsI9o2
         Ngw12oR3jr/CGBrSTyLV/eMAzBzvmjyEo3DJHG3JZg8ImEefgkZPz0tvaCDwxH6rczQJ
         DLwvx/hGofwX7Hr3UgvK4n0VRo9rytZU6rvyM66plNLBM/PJ1t495686zUtHxEqIYJgN
         Gao+WYamq9Bn70CtumkkC5H1gNEFQ7Y+UQ04pI6u1ztnpALznrmcT49r2Ho0OovgCDWH
         UgkTFRcVCEVOCo2yP6cLyXLVtOGZG/C4zm0ZL7whJY10W6FviXwhixGe2jTY9Pve1svW
         +2xw==
X-Gm-Message-State: AOAM533c0UT3jXW2FnvkmkDS/iTWqQTQr3IwaeegPEq/AUK7pV0nmcVd
        P11wCWD1Uk8pa6CKaC6Nzrazgc5Da+TR9Mxf1ac=
X-Google-Smtp-Source: ABdhPJxJpI28PGLypedqBL9T6QM5dmV2LOrpcj44Fm/aIBkdQ5RzlHu4fA3h5KyXlNhsQOoDghp0XbuNzcDvP8l/uyY=
X-Received: by 2002:ac2:4f86:: with SMTP id z6mr3363659lfs.412.1640201534489;
 Wed, 22 Dec 2021 11:32:14 -0800 (PST)
MIME-Version: 1.0
Reply-To: martinafrancis022@gmail.com
Sender: godfreynwauzor@gmail.com
Received: by 2002:a05:6512:3f01:0:0:0:0 with HTTP; Wed, 22 Dec 2021 11:32:13
 -0800 (PST)
From:   Martina Francis <martinafrancis61@gmail.com>
Date:   Wed, 22 Dec 2021 11:32:13 -0800
X-Google-Sender-Auth: 0KUCpI18Lo5WcHHTF9fXVzV2b2c
Message-ID: <CAFTYJ_pfcnwLVjTb_HbU2bdKHfcVRo0KDcpVA3SO_Mfsm2NKWQ@mail.gmail.com>
Subject: =?UTF-8?Q?Fondo_de_donaci=C3=B3n_de_la_Sra=2E_Martina_Francis?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--=20
Buen dia, querido,
=C2=BFC=C3=B3mo est=C3=A1 usted y su familia?
Mi nombre es Sra. Martina Francis, una viuda enferma que escribe desde
la cama del hospital sin un hijo. =C2=BFPuedo confiar en ti ?, tengo un
fondo de donaci=C3=B3n de ($ 2,700,000.00 MILLONES USD) que quiero donar a
trav=C3=A9s de ti para ayudar a la gente pobre, ni=C3=B1os abusados, menos
privilegiados, iglesias, orfanatos y viudas que sufren en la sociedad.

Comun=C3=ADquese conmigo inmediatamente despu=C3=A9s de leer este mensaje p=
ara
obtener m=C3=A1s detalles sobre esta agenda humanitaria.

Dios los bendiga mientras espero su respuesta.

Tu hermana.
Sra. Martina Francis.
