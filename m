Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF066EB825
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Apr 2023 11:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjDVJGi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 22 Apr 2023 05:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDVJGi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Apr 2023 05:06:38 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E8B1BCB
        for <linux-acpi@vger.kernel.org>; Sat, 22 Apr 2023 02:06:37 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-187b70ab997so15406134fac.0
        for <linux-acpi@vger.kernel.org>; Sat, 22 Apr 2023 02:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682154396; x=1684746396;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rIe29CHlO6glMfRfhMJG3iaAa/iujXdTRrJTiMwIUHI=;
        b=pMKrZEqoWhu7JnE3h3c5AivUZ8ihQwKs3QGwellZ0IsEznvuP6sKl087x6SfWeLZHx
         csOVVnEylHiZAnJ0phBdDz8WPDN0iyn1hOx2etgbrY5DkL9YxRtu96R2Qf7hblyIcMPu
         aydYe9mCyX8TJyEaBZzMTEVwrIXtORLIVthbBN9CN8CbQARbGt2wB3bdMSykP35ZLQla
         Wwqlkv5ll4vpG7WQl9x8z5omELmFHPp85EriFfdCypm0iiDV48U2E+sRT8bplbGvOlYv
         a2pzyRCNYEniSTso2sbDV9NV3WaesJyA4ylpbSssd1PKIZpQqmjmjg5lQtlo9KjH8E5T
         cKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682154396; x=1684746396;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIe29CHlO6glMfRfhMJG3iaAa/iujXdTRrJTiMwIUHI=;
        b=XEHOw0oB63Ris3f4PSF4p6+3xd6f89iAODumcXq42aiyFpMoV0QGjatiHE5dpE0lUz
         iyY1ZCG5m72VhEGSNpMHxbJjdZDCvUaiaarSAHm5Ib2v+JuY2D2LEN9p20C678mTZqGP
         VctbWwcTYSKcUAIomNIas/R7w9U/gECP5MRL1tabL71xHT/7yfULUsWrmIoNOOThES8n
         K+7glsFrCEBRJ5Mm7Ul0MpUwLDxt64mZKc7Dio39Le2SYP62Iu1mFu0nNpjKXlzvSVRh
         tc4JeSjndTqtZ6x4AF22vmGXwFdjv+6jYP1puNO1tMHjBilRAddGEgehOaiX+MMDwYwa
         Q0jA==
X-Gm-Message-State: AAQBX9efJJrXkFKriizwLTp8S6xer5erdGBBsVpeCquKUJ0Khwo3YW9L
        yl7e6OGCmLAGRKsgbZqgeUbv4pjn1MJG2L2r+PI=
X-Google-Smtp-Source: AKy350b1dV5Cd1MBtG9Foi7XjmUNbgk8CLXd2CLADjaRC15rM/I04tuCfH97BzgUi0vEJL+waCYn055RcJELTGLKPVY=
X-Received: by 2002:aca:db56:0:b0:38e:4e96:1292 with SMTP id
 s83-20020acadb56000000b0038e4e961292mr7323078oig.3.1682154396593; Sat, 22 Apr
 2023 02:06:36 -0700 (PDT)
MIME-Version: 1.0
Sender: fricatorabro@gmail.com
Received: by 2002:a05:6358:7581:b0:114:d76a:ce7a with HTTP; Sat, 22 Apr 2023
 02:06:36 -0700 (PDT)
From:   Miss Reacheal <Reacheal4u@gmail.com>
Date:   Sat, 22 Apr 2023 09:06:36 +0000
X-Google-Sender-Auth: HCltU1bT_rnYw2T2KczEKQRomTY
Message-ID: <CAN5s_qJP+L1W9JWDvfbXv5e5kVQZ7NiXOb7Rgx5O+CA57fTSXQ@mail.gmail.com>
Subject: RE: HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hola,

=C2=BFRecibiste mi mensaje anterior? Me comuniqu=C3=A9 contigo antes pero e=
l
mensaje fall=C3=B3, as=C3=AD que decid=C3=AD escribirte de nuevo. Confirme =
si recibe
esto para que pueda continuar,

esperando por tu respuesta.

Saludos,
se=C3=B1orita alcance
