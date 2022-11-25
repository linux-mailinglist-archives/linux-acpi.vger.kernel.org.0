Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94581638D57
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Nov 2022 16:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiKYPOn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Nov 2022 10:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiKYPO2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Nov 2022 10:14:28 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4205311478
        for <linux-acpi@vger.kernel.org>; Fri, 25 Nov 2022 07:14:23 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id i2so4465683vsc.1
        for <linux-acpi@vger.kernel.org>; Fri, 25 Nov 2022 07:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=00R96ylnw99C7hvGye+CZ7+VyWh7xSdStdUJpbF6+K8=;
        b=CAOJB+K0YN2Wg7AwX+1l/acsNdEMRdy3+cGq3RKEYHaIo1y86aqFvm/D2fXwVCa+k8
         vClu34W+czXFHgffQX36IQ8foJv1JYJjkLogn9ttzbeZ9Q9n39VSpoROSHID5z8zCpa5
         RxMH93AekJkUconxiygivxPdBA2xc65u5Xu55ZW3WVYFKrJDFv1mRtaGKXRJ2aEjxgtn
         MZgXcwN1kI+ufffXInD14JO9oy0EwxFL3BHYek5FvQz/NVkS5pHAgy0DkCtwNeY1rNSc
         XhvRcDxBFzmcLB5+L7gr3/nW2BnFMiLYF4jZPThZ+zgLbbFSFtXI4QLnl2cLtwc6xpp9
         Ar+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00R96ylnw99C7hvGye+CZ7+VyWh7xSdStdUJpbF6+K8=;
        b=sDYUuK4de7bNwP04405wlNLCzgOCgkUUtCDasvROGWCVTjYnoubJALBL+A/629JNBR
         lgflFV+HhEWKArm25+3uzoeaMxej/zJLYyMwR/QUKzXE0CH1ixKdw6XT7Yx3Sc30V0dr
         4XNZia8huXmuz3m1nnSJPYIOynuyvtBDFPA/qpIWwSErH53Oed+HW5fGaFLLfP44OUYQ
         5ABJDpAe4ZG3YFM7uKgdFJxMzYl1KjDnaWEOBbRzNuuOsImbm9v0XfUeL2FO8yFigPSe
         5BbqCl5zzTHMpVEUONf1dxsKeKHLI79SHS3ld3xVDtOMaUCjgiz5xItq0RMQ9T2/9wFP
         7T7g==
X-Gm-Message-State: ANoB5plpD7YKFY0wRrh/EbqhzyHJSSBXSbspf60zcon9/GbqT3oA9M8n
        Mqdwd77TEPW0P08ruCqHvCf1hW+HBl7SylOgM+k=
X-Google-Smtp-Source: AA0mqf7qw1Nf/vssU5dF78txmmmFyhTLXPtOTN6OsAmR05oDbBguNhEM8ruspJs4vjV1zKVPN0TozvkUXMmY896kVo0=
X-Received: by 2002:a67:6307:0:b0:3af:b418:df5e with SMTP id
 x7-20020a676307000000b003afb418df5emr12330948vsb.17.1669389261859; Fri, 25
 Nov 2022 07:14:21 -0800 (PST)
MIME-Version: 1.0
Sender: karenleo218@gmail.com
Received: by 2002:a59:c8e8:0:b0:305:138e:2423 with HTTP; Fri, 25 Nov 2022
 07:14:20 -0800 (PST)
From:   Rose Darren <rosedarren0001@gmail.com>
Date:   Fri, 25 Nov 2022 15:14:20 +0000
X-Google-Sender-Auth: LkrjKHg5v_iazxjy4k-fnAv228o
Message-ID: <CAHROqdirKYzL4rG2yFT-UuQPBpuX_2Q2W=zfxjhA_5U=6OjtZg@mail.gmail.com>
Subject: azq
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SPRECHEN SIE ENGLISCH?
Haben Sie gestern Abend meine Nachricht f=C3=BCr weitere Diskussionen erhal=
ten?
